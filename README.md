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

Folder structure:
HPC-OCR-Pipeline/```
│```
├── README.md```
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


