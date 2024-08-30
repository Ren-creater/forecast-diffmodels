#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zr523@ic.ac.uk
/rds/general/user/zr523/home/myvenv/bin/python /rds/general/user/zr523/home/researchProject/forecast-diffmodels/imagen/64_FC/v_64_FC.py -mode execute -epochs 261
