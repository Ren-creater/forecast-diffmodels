#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com
/vol/bitbucket/zr523/venv/bin/python /homes/zr523/Work/MSc_Project_zr523/imagen/64_PRP/m01_64_PRP.py -mode execute -epochs 261
