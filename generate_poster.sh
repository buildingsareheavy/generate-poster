#!/bin/bash

# =========================
# Video Poster Generator
# =========================

# Ask for video URL or local path
read -p "Enter video URL or local path: " video

# Ask whether to use seconds or frame number
read -p "Use seconds or frame number? [S/f]: " choice
choice=${choice:-s}

# Ask for time/frame depending on choice
if [[ "$choice" == "f" ]]; then
    read -p "Enter frame number [default: 0]: " frame
    frame=${frame:-0}
    time_option="frame"
else
    read -p "Enter time in seconds (can be fractional) [default: 0.00]: " seconds
    seconds=${seconds:-0.00}
    time_option="seconds"
fi

# Extract filename without extension
filename=$(basename "$video")
name="${filename%.*}"

# Ask for output format
read -p "Enter output format [Jpg/png/webp]: " format
format=${format:-jpg}

# Ask for output directory
default_dir="$HOME/Downloads"
read -e -p "Enter output directory [default: $default_dir]: " output_dir
output_dir=${output_dir:-$default_dir}

# Expand tilde to full path
output_dir="${output_dir/#\~/$HOME}"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Ask for output filename (without extension)
default_filename="${name}_poster"
read -p "Enter output filename without extension [default: $default_filename]: " output_filename
output_filename=${output_filename:-$default_filename}

# Construct full output path with format
output="$output_dir/$output_filename.$format"

# Ask for max width
read -p "Enter max width in pixels [default: 1440]: " MAX_WIDTH
MAX_WIDTH=${MAX_WIDTH:-1440}

# Generate poster
if [[ "$time_option" == "frame" ]]; then
    ffmpeg -i "$video" -vf "select=eq(n\\,$frame),scale=${MAX_WIDTH}:-1" -frames:v 1 -q:v 2 "$output"
else
    ffmpeg -ss $seconds -i "$video" -frames:v 1 -q:v 2 -vf "scale=${MAX_WIDTH}:-1" "$output"
fi

echo "Poster saved to $output"