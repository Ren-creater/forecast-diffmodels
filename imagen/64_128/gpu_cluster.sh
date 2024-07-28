#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_128/m01_64x64_128x128.py -mode execute -epochs 261
