import os
import sys
import shutil
import traceback
import ocrmypdf

# Pipeline configuration
BATCH_SIZE = 50
PIPELINE_DIR = "*/OCRPipeline"
INPUT_DIR = "/scratch/user/*"
OUTPUT_DIR = "/scratch/use/*/*"
FILE_LIST = os.path.join(PIPELINE_DIR, "pending_files.txt")
FAILED_LIST = os.path.join(PIPELINE_DIR, "failed_files.txt")

def read_pending_files():
    """Reads the list of pending files"""
    with open(FILE_LIST, 'r') as f:
        files = [line.strip() for line in f.readlines()]
    return files

def process_pdf(rel_path):
    """Process a single PDF file"""
    input_path = os.path.join(INPUT_DIR, rel_path)
    output_path = os.path.join(OUTPUT_DIR, rel_path)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    try:
        ocrmypdf.ocr(
            input_path, 
            output_path, 
            language='eng',
            skip_text=True,
            output_type='pdf',
            pdf_renderer='hocr',
            clean=False,
            clean_final=False,
            optimize=0,
            image_dpi=200,
            jobs=2
        )
        print(f"OCR complete: {rel_path}")
    
    except Exception as e:
        print(f"OCR failed for {rel_path}: {e}")
        with open(FAILED_LIST, 'a') as f:
            f.write(rel_path + '\n')
        # Optional: fallback copy (if you prefer to save the file even if OCR fails)
        # shutil.copy2(input_path, output_path)

if __name__ == '__main__':
    task_id = int(sys.argv[1])  # Get SLURM array task ID
    all_files = read_pending_files()
    
    batch_start = (task_id - 1) * BATCH_SIZE
    batch_end = min(batch_start + BATCH_SIZE, len(all_files))
    batch_files = all_files[batch_start:batch_end]

    print(f"Processing batch {batch_start+1}-{batch_end}...")

    for rel_path in batch_files:
        process_pdf(rel_path)
