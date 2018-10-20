#! /bin/sh

print_media_size () {
    echo "Size of *.$1:"
    echo "-------------"
    nb_med=`find . -name "*.$1" | wc -l`
    echo -e "$nb_med\tfiles"
    find . -name "*.$1" | xargs du -ch | grep total$
    echo ""
}

print_media_size MOV
print_media_size avi
print_media_size MP4
print_media_size mp4
print_media_size JPG
