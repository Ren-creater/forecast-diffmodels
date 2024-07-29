#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodels/imagen/64_PRP/m01w_woERA5_64_PRP.py -mode execute -epochs 261
