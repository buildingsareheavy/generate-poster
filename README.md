# Video Poster Generator

Extract a single frame from a video file or URL and save it as an image using `ffmpeg`.

## Setup

Make the script executable:

```bash
chmod +x generate_poster.sh
```

## Usage

```bash
./generate_poster.sh
```

## Parameters

The script will prompt you for:

1. **Video path** - Local file path or URL
2. **Time method** - `[S/f]` Extract by seconds or frame number
3. **Time/Frame** - Timestamp (e.g., `5.5`) or frame number (e.g., `150`)
4. **Format** - `[Jpg/png/webp]` Output image format
5. **Output directory** - Where to save (supports tab completion)
6. **Filename** - Name without extension (auto-appended based on format)
7. **Max width** - Maximum width in pixels (height scales proportionally)

Press Enter at any prompt to use the default value shown in brackets.

## Requirements

- `ffmpeg`
