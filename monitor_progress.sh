#!/bin/bash

# Define paths
PIPELINE_DIR=""
INPUT_DIR=""
OUTPUT_DIR=""
FILE_LIST="${PIPELINE_DIR}/pending_files.txt"

# Count pending files (if file list exists)
if [ -f "${FILE_LIST}" ]; then
    PENDING=$(wc -l < "${FILE_LIST}")
else
    PENDING="unknown (file list not found)"
fi

# Count how many have been processed
PROCESSED=$(find "${OUTPUT_DIR}" -type f -iname "*.pdf" | wc -l)

# Count how many array jobs are currently running
RUNNING_JOBS=$(squeue -u $USER | grep ' R ' | wc -l)

echo "🕓 Pending files: ${PENDING}"
echo "✅ Processed files: ${PROCESSED}"
echo "🚀 Running jobs: ${RUNNING_JOBS}"
