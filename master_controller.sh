#!/bin/bash

# Set directories
PIPELINE_DIR=""
INPUT_DIR=""
OUTPUT_DIR=""
FILE_LIST="${PIPELINE_DIR}/pending_files.txt"
LOG_DIR="${PIPELINE_DIR}/logs"
BATCH_SIZE=50
MAX_ARRAY_SIZE=25  # QOS-safe submission limit

# Create logs directory if it doesn't exist
mkdir -p "${LOG_DIR}"

echo "🔎 Scanning for unprocessed files..."

# Generate list of PDFs excluding already processed files
find "${INPUT_DIR}" -path "${OUTPUT_DIR}" -prune -o -type f -iname "*.pdf" -print | while read FILE; do
    REL_PATH="${FILE#$INPUT_DIR/}"
    INPUT_FILE="${INPUT_DIR}/${REL_PATH}"
    OUTPUT_FILE="${OUTPUT_DIR}/${REL_PATH}"
    if [ ! -f "${OUTPUT_FILE}" ]; then
        echo "${REL_PATH}"
    fi
done > "${FILE_LIST}"

PENDING=$(wc -l < "${FILE_LIST}")

echo "✅ Found ${PENDING} files to process."

# If nothing to process, exit
if [ "${PENDING}" -eq 0 ]; then
    echo "🎉 Nothing to do. All files are already processed."
    exit 0
fi

# Compute total number of batches
TOTAL_BATCHES=$(( (PENDING + BATCH_SIZE - 1) / BATCH_SIZE ))

echo "🧮 Total batches: ${TOTAL_BATCHES}"

# Submit array jobs in chunks that stay inside QOS limits
START=1
while [ $START -le $TOTAL_BATCHES ]; do
    END=$(( START + MAX_ARRAY_SIZE - 1 ))
    if [ $END -gt $TOTAL_BATCHES ]; then
        END=$TOTAL_BATCHES
    fi
    echo "🚀 Submitting array chunk: $START-$END"
    sbatch --array=${START}-${END} ${PIPELINE_DIR}/slurm_array_job.sh
    START=$(( END + 1 ))
done
