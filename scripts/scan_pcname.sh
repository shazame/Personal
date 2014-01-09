#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 x.y.z"
    echo ""
    echo "Example: $0 192.168.1"
    exit 1
fi

for i in `seq 1 254`; do
    dig -x $1.$i | head -n12 | tail -n1 | grep "PTR" | sed 's/^\([0-9]\+\)\.\([0-9]\+\)\.\([0-9]\+\)\.\([0-9]\+\).*\t\([^ ]\+\)\.home\./\4.\3.\2.\1\t\5/'
done
