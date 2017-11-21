#!/usr/bin/env bash

# 1 GB random files
echo "Generating 5 MB files"
mkdir -p data/big/
for X in {1..3}
do
echo "File $X"
if [ ! -f data/big/5MB.${X} ]
then
    head -c 5242880 </dev/urandom >data/big/5MB.${X}
fi
done
echo "Done"

# 400 1kb random files
echo "Generating 100 1kb files"
mkdir -p data/many/
for X in {1..10}
do
echo "File $X"
head -c 1024 </dev/urandom >data/many/1kB.${X}
done
echo "Done"
