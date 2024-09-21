#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zr523
export PATH=/vol/bitbucket/zr523/myvenv/bin/:$PATH
# the above path could also point to a miniconda install
# if using miniconda, uncomment the below line
# source ~/.bashrc
source activate
#source /vol/cuda/11.3.1-cudnn8.2.1/setup.sh
. /vol/cuda/11.3.1-cudnn8.2.1/setup.sh
nvcc --version
TERM=vt100
/usr/bin/nvidia-smi
uptime

cd /vol/bitbucket/zr523/researchProject/

cd imagen-pytorch
python setup.py develop
cd ..

cd forecast-diffmodels/imagen/64_FC

python v_64_FC_dim64.py -mode execute -epochs 400

python v_test_v_FC_dim64.py -run_name v_64_FC_3e-4_dim64

# python v_t02-sampling-and-evaluation.py -run_name v_64_FC_3e-4_dim64

# jupyter nbconvert --execute --to notebook 'v_T03 - Visualizing Metrics.ipynb'