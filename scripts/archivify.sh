#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <dirname>"
    exit
fi

tar --exclude-vcs --exclude="*~" -czf ${1%/}.tgz $1
