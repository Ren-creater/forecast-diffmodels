#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com

/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t07-test-set-evaluation.py -run_name 64_FC_rot904_sep_3e-4
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t07-test-set-evaluation.py -run_name 64_FC_rot904_3e-4
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t07-test-set-evaluation.py -run_name 64_FC_3e-4
