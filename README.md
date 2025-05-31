# HPC-OCR-Pipeline

✅ Project Overview:
Distributed OCR Pipeline using OCRmyPDF + SLURM job arrays for scalable PDF OCR processing on HPC clusters.

✅ Features:
- SLURM job array support
- QOS-limited job chunking (coming: v3.4.1)
- Automatic pending files detection
- Fault-tolerant processing
- Supports very large file sets (10k+ PDFs)

✅ System Requirements:
- Conda
- Python 3.10+
- OCRmyPDF
- Tesseract

✅ Cluster Dependencies:
- SLURM job scheduler

✅ Basic Usage:
- conda env create -f environment.yml
- conda activate ocr_env
- bash master_controller.sh
- Check completed PDF files
  - find /scratch/*/ -iname '*.pdf' | wc -l
- Monitor progress
  - shmonitor.sh
  - squeue -u $USER

  
## Folder Structure:
```bash
HPC-OCR-Pipeline/
│
├── README.md
├── LICENSE
├── environment.yml        # Conda environment definition
├── master_controller.sh   # The main orchestration script
├── slurm_array_job.sh     # SLURM job submission script
├── ocr_array_worker.py    # The worker that processes each file batch
├── monitor_progress.sh    # (Optional) Script to monitor live progress
│
├── utils/
│   └── (any helper scripts you may add later)
│
├── logs/                  # Logs folder (ignored in git)
│
└── .gitignore

```

# Activate conda env first:
conda env create -f environment.yml
conda activate ocr_env

# Run controller
bash master_controller.sh

# Then submit smaller batch manually (example: batches 1 to 25)
sbatch --array=1-25 slurm_array_job.sh

# If QOS limits allow, you can submit additional chunks as needed:
sbatch --array=26-50 slurm_array_job.sh
sbatch --array=51-75 slurm_array_job.sh
