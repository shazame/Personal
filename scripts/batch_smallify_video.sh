#! /bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file_extension>"
    exit
fi

file_list=`find . -name "*.$1"`

for infile in $file_list; do
    output=`echo $infile | sed "s/$1/mp4/"`
    echo "**********************************************************************************************************************************"
    echo "************** ./smallify_video.sh $infile $output"
    echo "**********************************************************************************************************************************"
    ./smallify_video.sh $infile $output
done
