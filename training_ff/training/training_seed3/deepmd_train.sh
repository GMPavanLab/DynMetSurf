#!/bin/bash -l
#
# CP2K on Piz Daint: 2 nodes, 1 MPI task per node, 12 OpenMP threads per task
#
#SBATCH --job-name=dp_1
#SBATCH --time=05:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --constraint=gpu
#SBATCH --account=s1125
#SBATCH --ntasks-per-core=1
#SBATCH --mem=60GB
#SBATCH --partition=normal
#========================================
# load modules and run simulation

module load daint-gpu
module use /store/usi/u1/polinod/easybuild/modules/all/
module use /users/polinod/easybuild/daint/haswell/modules/all
module load deepmd-kit/2.0.1-CrayGNU-20.11

export CRAY_CUDA_MPS=1
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
#ulimit -s unlimited
#srun -n $SLURM_NTASKS --ntasks-per-node=$SLURM_NTASKS_PER_NODE -c $SLURM_CPUS_PER_TASK --hint=nomultithread dp_train -t 36 urea_in_water.json > log.train
#srun -n $SLURM_NTASKS --ntasks-per-node=$SLURM_NTASKS_PER_NODE -c $SLURM_CPUS_PER_TASK --hint=nomultithread dp_train --restart model.ckpt Fe_O_smooth.json > log.train
#srun --hint=nomultithread dp_train Fe_smooth.json > log.train


srun dp train input_Cu.json --init-frz-model Cu-model.pb > log.train
#dp freeze -o Cu-model_final_2.pb
#dp test -m Cu-model.pb -s  /scratch/snx3000/mcioni/surface/METAL_SURFACES/data/100/data_0  -n 100
#dp test -m Cu-model.pb -s  .../data/100/data_0  -n 100
