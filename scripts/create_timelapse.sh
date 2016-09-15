#!/bin/sh

fps=${1:-25}
# Prepare source files
if [ ! -d "source" ]; then
    mkdir source
    mv *.JPG source
fi
# Resize images to 1920x1080 to get Full HD
if [ ! -d "resized" ]; then
    cd source
    mkdir ../resized
    parallel --progress gm mogrify -quality 100 -output-directory ../resized -resize 1920x1080! ::: *.JPG # using "parallel" to utilize all CPU cores and perform the resize much faster
    cd ..
fi
# Create timelaps video
cd resized
output=../timelapse_${fps}fps
if [ ! -f $output.avi ]; then
    ffmpeg -r ${fps} -pattern_type glob -i '*.JPG' -c:v copy $output.avi
fi
if [ ! -f $output.mkv ]; then
    ffmpeg -i $output.avi -c:v libx264 -preset slow -crf 18 $output.mkv
    rm -f $output.avi
fi
