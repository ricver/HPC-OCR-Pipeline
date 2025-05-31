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
HPC-OCR-Pipeline/
│
├── README.md
├── LICENSE
├── environment.yml  # For conda environment setup
├── master_controller.sh
├── slurm_array_job.sh
├── ocr_array_worker.py
├── monitor_progress.sh
├── utils/
│   └── (any helper scripts)
├── logs/ (ignored in git)
│
└── .gitignore
