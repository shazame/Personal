#! /bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_filename> <output_filename>"
    exit
fi

if [ ! -f $1 ]; then
    echo "File '$1' does not exist"
    exit
fi

ffmpeg -i $1 -vf scale=-2:720 $2

# Same as following default
#ffmpeg -i input.MOV -c:v libx264 -crf 23 -vf scale=-2:720 output.mp4
