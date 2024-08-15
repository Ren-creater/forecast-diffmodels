#!/bin/bash
#PBS -l walltime=96:00:00
#PBS -l select=1:ncpus=4:mem=24gb:ngpus=1:gpu_type=RTX6000

module load anaconda3/personal

source activate research_env

python3 -m pip install $HOME/researchProject/forecast-diffmodels/imagen/requirements.txt

python $HOME/researchProject/forecast-diffmodels/imagen/64_FC/v_64_FC.py -mode execute -epochs 261