#!/bin/bash
#PBS -l select=1:ncpus=4:mem=48gb:ngpus=1:gpu_type=L40S
#PBS -l walltime=72:00:00


eval "$(~/anaconda3/bin/conda shell.bash hook)"

source activate research_env

cd /rds/general/user/zr523/home/researchProject/

cd imagen-pytorch
python setup.py develop
cd ..

cd forecast-diffmodels/imagen/64_FC

python v_t05-forecasting-pipeline.py -region "West Indian Ocean" -name "Emnati" -horizon 100 -start 24
python v_t05-forecasting-pipeline.py -region "North Pacific Ocean" -name "Orlene" -horizon 100 -start 12

python v_t05-forecasting-pipeline.py -region "North Indian Ocean" -name "Mocha" -horizon 100 -start 00
python v_t05-forecasting-pipeline.py -region "North Indian Ocean" -name "Maha" -horizon 100 -start 24
python v_t05-forecasting-pipeline.py -region "Australia" -name "Veronica" -horizon 100 -start 00
python v_t05-forecasting-pipeline.py -region "West Indian Ocean" -name "Gombe" -horizon 100 -start 24
python v_t05-forecasting-pipeline.py -region "North Atlantic Ocean" -name "Ida" -horizon 100 -start 12
python v_t05-forecasting-pipeline.py -region "North Pacific Ocean" -name "Rosyln" -horizon 100 -start 0
python v_t05-forecasting-pipeline.py -region "West Pacific Ocean" -name "Molave" -horizon 100 -start 30