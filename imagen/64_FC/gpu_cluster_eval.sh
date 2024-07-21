#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com
/vol/bitbucket/zr523/venv/bin/python /homes/zr523/Work/MSc_Project_zr523/imagen/64_FC/tw2-sampling-and-evaluation.py -run_name 64_FC_woERA5_rot904_3e-4
