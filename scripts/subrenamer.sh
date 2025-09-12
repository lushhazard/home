#!/bin/bash

# Usage: rename-subs [optional-path]

# Set working directory to argument or current directory
DIR="${1:-.}"

# Validate the path
if [[ ! -d "$DIR" ]]; then
  echo "Error: '$DIR' is not a valid directory."
  exit 1
fi

# Extensions for video files
video_exts=("mkv" "mp4" "avi" "mov")

# Collect video files in the directory
video_files=()
for ext in "${video_exts[@]}"; do
  while IFS= read -r -d '' file; do
    video_files+=("$file")
  done < <(find "$DIR" -maxdepth 1 -type f -iname "*.${ext}" -print0)
done

# Process subtitle files in the directory
find "$DIR" -maxdepth 1 -type f -iname "*.srt" | while IFS= read -r sub; do
  # Extract episode number from subtitle (supports S01E01, s01e01, etc.)
  if [[ "$sub" =~ [Ss]([0-9]{1,2})[Ee]([0-9]{2}) ]]; then
    season="${BASH_REMATCH[1]}"
    episode="${BASH_REMATCH[2]}"

    # Try to find the matching video file
    match=""
    for vid in "${video_files[@]}"; do
      if [[ "$vid" =~ [Ss]0*${season}[Ee]${episode} ]]; then
        match="$vid"
        break
      elif [[ "$vid" =~ ([^0-9])${episode}([^0-9]) ]]; then
        # fallback if video file uses just episode number
        match="$vid"
      fi
    done

    if [[ -n "$match" ]]; then
      base="${match%.*}"
      new_sub="${base}.srt"
      echo "Renaming: '$sub' → '$new_sub'"
      mv -- "$sub" "$new_sub"
    else
      echo "❌ No video found for '$sub'"
    fi
  else
    echo "⚠️  Could not extract episode number from '$sub'"
  fi
done
