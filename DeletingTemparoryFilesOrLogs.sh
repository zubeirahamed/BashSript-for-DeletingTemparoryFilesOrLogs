#!/bin/bash

# Directory to search for files
SEARCH_DIR="/home/ec2-user/raj"

# Date in YYYY-MM-DD format to define the threshold
THRESHOLD_DATE="2023-08-17"

# File extension or pattern (e.g., "*.log", "temp_*")
FILE_PATTERN="*.log"

# Dry-run mode (set to "true" for testing; set to "false" to actually delete files)
DRY_RUN="false"

# Find and delete files
find "$SEARCH_DIR" -type f -name "$FILE_PATTERN" -mtime +$(( ($(date +%s) - $(date -d "$THRESHOLD_DATE" +%s)) / 86400 )) -print0 | while IFS= read -r -d $'\0' file; do
    echo "Deleting: $file"
    if [ "$DRY_RUN" = "false" ]; then
        rm "$file"
    fi
done

echo "Cleanup completed."
