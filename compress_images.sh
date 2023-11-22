#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

find "$directory_path" -type f -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.webp" | while read -r image; do
    size=$(stat -c%s "$image")
    
    if [ "$size" -lt 1048576 ]; then
        echo "Compressing $image..."
        mogrify -quality 80 "$image"
    else
        echo "Skipping $image as it is already larger than 1 MB."
    fi
done

echo "Compression completed."
