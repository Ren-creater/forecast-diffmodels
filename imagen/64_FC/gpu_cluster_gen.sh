#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --partition=gpgpuB
#SBATCH --mail-type=ALL
#SBATCH --mail-user=pritthijit.nath.ml@gmail.com

/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "West Indian Ocean" -name "Emnati" -horizon 100 -start 24
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "North Pacific Ocean" -name "Orlene" -horizon 100 -start 12

/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "North Indian Ocean" -name "Mocha" -horizon 100 -start 00
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "North Indian Ocean" -name "Maha" -horizon 100 -start 24
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "Australia" -name "Veronica" -horizon 100 -start 00
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "West Indian Ocean" -name "Gombe" -horizon 100 -start 24
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "North Atlantic Ocean" -name "Ida" -horizon 100 -start 12
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "North Pacific Ocean" -name "Rosyln" -horizon 100 -start 0
/vol/bitbucket/zr523/venv/bin/python /vol/bitbucket/zr523/researchProject/forecast-diffmodelsimagen/64_FC/t05-forecasting-pipeline.py -region "West Pacific Ocean" -name "Molave" -horizon 100 -start 30