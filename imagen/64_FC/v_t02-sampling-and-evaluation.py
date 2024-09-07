import glob
import copy
import argparse
from functools import partial, partialmethod

from einops import rearrange

import sys
sys.path.append("../")
sys.path.append("../imagen/")
sys.path.append("../../dataproc/")

from helpers import *
from imagen_pytorch import Unet3D, Imagen, ImagenTrainer, NullUnet
from send_emails import *

seed_value = 42
torch.manual_seed(seed_value)
if torch.cuda.is_available(): torch.cuda.manual_seed_all(seed_value)

parser = argparse.ArgumentParser()
parser.add_argument('-run_name', help='Specify the run name (for eg. 64_FC_3e-4)')
args = parser.parse_args()

sys.stdout = open(f'METRICS_LOG_{datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")}.log','wt')
print = partial(print, flush=True)
tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

RUN_NAME = args.run_name
BASE_DIR = f"/rds/general/user/zr523/home/researchProject/models/{RUN_NAME}/models/{RUN_NAME}/"

print(f"Run name: {RUN_NAME}")

ckpt_files = sorted(glob.glob(BASE_DIR + "ckpt_1_*"))
ckpt_trainer_files = sorted(glob.glob(BASE_DIR + "ckpt_trainer_1_*"))


unet1 = Unet3D(
    dim = 32,
    cond_dim = 1024,
    dim_mults = (1, 2, 4, 8),
    num_resnet_blocks = 3,
    layer_attns = (False, True, True, True),
)  

unets = [unet1]

class DDPMArgs:
    def __init__(self):
        pass
    
args = DDPMArgs()
args.batch_size = 1
args.image_size = 64 ; args.o_size = 64 ; args.n_size = 128 ;
args.continuous_embed_dim = 64*64*3*8
args.dataset_path = f"/rds/general/ephemeral/user/zr523/ephemeral/satellite/dataloader/{args.o_size}_FC"
args.datalimit = False
args.mode = "fc"
args.lr = float(RUN_NAME.split('_')[-1])

train_dataloader, test_dataloader = get_satellite_data(args, "vid")
train_dataloader.switch_to_vid()
test_dataloader.switch_to_vid()
_ = len(train_dataloader) ; _ = len(test_dataloader)

if '1k' in RUN_NAME:
    timesteps = 1000
else:
    timesteps = 250

imagen = Imagen(
    unets = unets,
    image_sizes = (64),
    timesteps = 250,
    cond_drop_prob = 0.1,
    condition_on_continuous = True,
    continuous_embed_dim = args.continuous_embed_dim,
)

random_idx = [5]

metric_dict = {
    "kl_div": [],
    "rmse": [],
    "mae":  [],
    "psnr": [],
    "ssim": [],
    "fid": []
}

train_test_metric_dict = {
    "train": copy.deepcopy(metric_dict), 
    "test": copy.deepcopy(metric_dict)
}

for idx in range(len(ckpt_trainer_files)):
    ckpt_trainer_path = ckpt_trainer_files[idx]
    print(f'Evaluating {ckpt_trainer_path.split("/")[-1]} ...')

    for mode in ["train", "test"]:
        if mode == "train" : dataloader = train_dataloader
        elif mode == "test": dataloader = test_dataloader
    
        trainer = ImagenTrainer(imagen, lr=args.lr, verbose=False).cuda()
        trainer.load(ckpt_trainer_path)  
        
        batch_idx = dataloader.random_idx[random_idx[0]]
        
        vid_cond, vid, era5 = dataloader.get_batch(batch_idx)
        cond_embeds = era5.reshape(1, -1).float().cuda()
        ema_sampled_vid = imagen.sample(
                    batch_size = vid.shape[0],#img_64.shape[0],          
                    cond_scale = 3.,
                    continuous_embeds=cond_embeds,
                    use_tqdm = False,
                    video_frames = vid.shape[2],
                    cond_video_frames=vid_cond
            )
        #ema_sampled_vid = ema_sampled_vid.squeeze(0)
        ema_sampled_images = rearrange(ema_sampled_vid, 'b c t h w -> (b t) c h w')
        img_64 = rearrange(vid, 'b c t h w -> (b t) c h w')

        y_true = img_64.cpu()
        y_pred = ema_sampled_images.cpu()
        metric_dict = calculate_metrics(y_pred, y_true)
        for key in metric_dict.keys():
            train_test_metric_dict[mode][key].append(metric_dict[key])

with open(f"/rds/general/user/zr523/home/researchProject/models/{RUN_NAME}/metrics.pkl", "wb") as file:
    pickle.dump(train_test_metric_dict, file)

print(f'Evaluation completed.')

subject = f"[COMPLETED] Evaluation Metrics"
message_txt = f"""Metrics Evaluation Completed for {RUN_NAME}"""
send_txt_email(message_txt, subject)