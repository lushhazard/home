#!/bin/bash
# ai generated script modified to suit my needs
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
  match=""
  episode=""
  season=""

  # Try matching S01E01 format
  if [[ "$sub" =~ [Ss]([0-9]{1,2})[Ee第]([0-9]{1,3}) ]]; then
    season="${BASH_REMATCH[1]}"
    episode="${BASH_REMATCH[2]}"

    for vid in "${video_files[@]}"; do
      if [[ "$vid" =~ [Ss]0*${season}[Ee]${episode} ]]; then
        match="$vid"
        break
      elif [[ "$vid" =~ ([^0-9])${episode}([^0-9]) ]]; then
        match="$vid"
      fi
    done

  # seasonless
  elif [[ "$sub" =~ [Ee第]([0-9]{1,3})? ]]; then
    episode="${BASH_REMATCH[1]}"

    for vid in "${video_files[@]}"; do
      if [[ "$vid" =~ ([^0-9])0*${episode}([^0-9]) ]]; then
        match="$vid"
        break
      elif [[ "$vid" =~ [^0-9]${episode}\. ]]; then
        match="$vid"
        break
      fi
    done
  fi

  # Rename if match found
  if [[ -n "$match" ]]; then
    base="${match%.*}"
    new_sub="${base}.srt"
    echo "✅ Renaming: '$sub' → '$new_sub'"
    mv -- "$sub" "$new_sub"
  else
    echo "❌ No video found for '$sub'"
  fi
done
