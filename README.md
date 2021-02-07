# ffmpeg commands

These are just some of my common commands I use to cut, compress, and merge videos with ffmpeg.

## Installation

Install ffmpeg and exiftools for your OS. If you're using windows I recommend using the Git Bash (MinGW)

## Usage

Right now it's just hvenc. It compresses all .mp4 videos in the current directory using the nvidia accelerated encoder, so on my GTX 1070 I can get 4x encoding for a 1080p video. 

To Run just enter a folder full of files you want to compress and run `hvenc`. Once you're happy that all .mp4s have been copied successfully to `.h265.mp4` files, and all the date/time information has also been copied, you can run `hvenc_delete_originals` to clear up the space on your hard drive. If `hvenc` on a file fails you'll likely need to delete the `.h265.mp4` file created to start over.
