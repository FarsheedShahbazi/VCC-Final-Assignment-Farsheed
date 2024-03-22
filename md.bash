#!/bin/bash
#SBATCH --gres=gpu:v100:1
#SBATCH --cpus-per-task=3
#SBATCH --mem=32G
#SBATCH --time=3-00:00
#SBATCH --account=rrg-jtrant
#SBATCH --output=PROD.log 
module purge
module load StdEnv/2020 gcc/9.3.0 cuda/11.4 openmpi/4.0.3 amber/20.12-20.15



srun pmemd.cuda -O -i min.in -o min.out -p com_solvated.prmtop -c com_solvated.inpcrd -r min.rst -ref com_solvated.inpcrd
srun pmemd.cuda -O -i min2.in -o min2.out -p com_solvated.prmtop -c min.rst -r min2.rst -ref min.rst
srun pmemd.cuda -O -i min3.in -o min3.out -p com_solvated.prmtop -c min2.rst -r min3.rst -ref min2.rst
srun pmemd.cuda -O -i min4.in -o min4.out -p com_solvated.prmtop -c min3.rst -r min4.rst -ref min3.rst
srun pmemd.cuda -O -i min5.in -o min5.out -p com_solvated.prmtop -c min4.rst -r min5.rst -ref min4.rst
srun pmemd.cuda -O -i heat.in -o heat.out -p com_solvated.prmtop -c min5.rst -r heat.rst -x heat.nc -ref min5.rst
srun pmemd.cuda -O -i heat2.in -o heat2.out -p com_solvated.prmtop -c heat.rst -r heat2.rst -x heat2.nc -ref heat.rst
srun pmemd.cuda -O -i hold.in -o hold_1.out -p com_solvated.prmtop -c heat2.rst -r hold_1.rst -x hold_1.nc
srun pmemd.cuda -O -i hold.in -o hold_2.out -p com_solvated.prmtop -c hold_1.rst -r hold_2.rst -x hold_2.nc
srun pmemd.cuda -O -i hold.in -o hold_3.out -p com_solvated.prmtop -c hold_2.rst -r hold_3.rst -x hold_3.nc
srun pmemd.cuda -O -i hold.in -o hold_4.out -p com_solvated.prmtop -c hold_3.rst -r hold_4.rst -x hold_4.nc
srun pmemd.cuda -O -i hold.in -o hold_5.out -p com_solvated.prmtop -c hold_4.rst -r hold_5.rst -x hold_5.nc
srun pmemd.cuda -O -i hold.in -o hold_6.out -p com_solvated.prmtop -c hold_5.rst -r hold_6.rst -x hold_6.nc
srun pmemd.cuda -O -i hold.in -o hold_7.out -p com_solvated.prmtop -c hold_6.rst -r hold_7.rst -x hold_7.nc
srun pmemd.cuda -O -i hold.in -o hold_8.out -p com_solvated.prmtop -c hold_7.rst -r hold_8.rst -x hold_8.nc
srun pmemd.cuda -O -i hold.in -o hold_9.out -p com_solvated.prmtop -c hold_8.rst -r hold_9.rst -x hold_9.nc
srun pmemd.cuda -O -i hold.in -o hold_10.out -p com_solvated.prmtop -c hold_9.rst -r hold_10.rst -x hold_10.nc
srun pmemd.cuda -O -i equil.in -o equil.out -p com_solvated.prmtop -c hold_10.rst -r equil.rst -x equil.nc
srun pmemd.cuda -O -i prod.in -o prod.out -p com_solvated.prmtop -c equil.rst -r prod.rst -x prod.nc

