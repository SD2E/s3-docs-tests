#!/usr/bin/env bash

# 1 GB random files
echo "Generating bigness series"
mkdir -p data/huge
filesize=268435456 # 256 MB
for X in {1..8}
do
if [ ! -f data/huge/file_256e${X} ]
then
    echo "File $X: ${humanized}MB"
    humanized=$((filesize / 1024 / 1024))
    head -c $filesize </dev/urandom >data/huge/file_${humanized}MB
    filesize=$((filesize * 2))
fi
done
echo "Done"

# 10000 1kb random files
echo "Generating 10000 1kb files"
filecount=10000
mkdir -p data/toomany
for X in {1..$filecount}
do
head -c 1024 </dev/urandom >data/toomany/1kB.${X}
done
echo "Done"
