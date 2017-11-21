#!/usr/bin/env bash

# Multi-GB random files
echo "Generating bigness series"
mkdir -p data/huge
filesize=268435456 # 256 MB
humanized=$((filesize / 1024 / 1024))
for X in {1..8}
do
if [ ! -f data/huge/file_${humanized}MB ]
then
    echo "File $X: ${humanized}MB"
    head -c $filesize </dev/urandom >data/huge/file_${humanized}MB
    filesize=$((filesize * 2))
    humanized=$((filesize / 1024 / 1024))
fi
done
echo "Done"

# 10000 1kb random files
echo "Generating 10000 1kb files"
filecount=10000
mkdir -p data/toomany
for X in {1..10000}
do
head -c 1024 </dev/urandom >data/toomany/1kB.${X}
done
echo "Done"
