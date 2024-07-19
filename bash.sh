#!/bin/bash

APPDATA_PATH="$APPDATA"
SIX_MONTHS_AGO=$(date -d '6 months ago' +%s)

if [ -d "$APPDATA_PATH" ]; then
    find "$APPDATA_PATH" -type f -name '*.tmp' -printf '%T@ %p\n' | while read -r timestamp file; do
        if (( $(echo "$timestamp < $SIX_MONTHS_AGO" | bc -l) )); then
            rm "$file"
            echo "Deleted: $file"
        fi
    done
else
    echo "AppData directory not found."
fi
