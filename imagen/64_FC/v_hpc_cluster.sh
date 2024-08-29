#!/bin/bash
#PBS -l select=1:ncpus=4:mem=24gb:ngpus=1:gpu_type=RTX6000
#PBS -l walltime=72:00:00

module load anaconda3/personal

source activate research_env

#conda install python=3.10.12

#python3 -m pip install -r /rds/general/user/zr523/home/researchProject/forecast-diffmodels/imagen/requirements.txt

cd /rds/general/user/zr523/home/researchProject/

cd imagen-pytorch
python setup.py develop
pip install kornia_rs
pip install einops_exts
pip install multiprocess
pip install pyarrow
pip install aiohttp
pip install xxhash
pip install pydantic_core
pip install annotated_types
cd ..

cd forecast-diffmodels/imagen/64_FC

python v_64_FC.py -mode execute -epochs 261
