#!/bin/bash
#SBATCH --job-name=ocr_array
#SBATCH --output=/scratch/b.rcv24pry/OCRPipeline/logs/array_%A_%a.out
#SBATCH --error=/scratch/b.rcv24pry/OCRPipeline/logs/array_%A_%a.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=4:00:00
#SBATCH --mem=8G

# Load conda environment
source /home/*/conda.sh
conda activate /home/*/ocr_env

# Ensure Tesseract knows where the language data is
export TESSDATA_PREFIX=$CONDA_PREFIX/share/tessdata

# Run the batch worker
PIPELINE_DIR=""
python ${PIPELINE_DIR}/ocr_array_worker.py $SLURM_ARRAY_TASK_ID
