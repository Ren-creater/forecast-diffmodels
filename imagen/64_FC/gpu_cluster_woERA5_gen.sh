#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com

/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodels/imagen/64_FC/tw5-forecasting-pipeline.py -region "North Indian Ocean" -name "Amphan" -horizon 100 -start 0
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodels/imagen/64_FC/tw5-forecasting-pipeline.py -region "North Indian Ocean" -name "Mocha" -horizon 100 -start 0
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodels/imagen/64_FC/tw5-forecasting-pipeline.py -region "North Indian Ocean" -name "Tauktae" -horizon 100 -start 0
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodels/imagen/64_FC/tw5-forecasting-pipeline.py -region "North Indian Ocean" -name "Maha" -horizon 100 -start 24