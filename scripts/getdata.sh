#!/usr/bin/env bash

command date --version >/dev/null 2>&1 && is_gnu=1 || true

function randstring() {
    if ((is_gnu)); then
        echo $RANDOM | md5sum | head -c 8
    else
        echo $RANDOM | md5 | head -c 8
    fi
}

# Multi-GB random files
echo "Generating bigness series"
for LAB in biofab emerald ginkgo transcriptic
do

DESTROOT="data/${LAB}/201808/$(randstring)"
mkdir -p ${DESTROOT}

filesize=268435456 # 256 MB
humanized=$((filesize / 1024 / 1024))
for X in {1..1}
do
FNAME="${DESTROOT}/big_${humanized}MB.txt"
if [ ! -f $FNAME ]
then
    echo "File $X: ${humanized}MB"
    head -c $filesize </dev/urandom >${FNAME}
    filesize=$((filesize * 2))
    humanized=$((filesize / 1024 / 1024))
fi
done
echo "Done"

DESTROOT="data/${LAB}/201808/$(randstring)"
mkdir -p ${DESTROOT}

# 10000 1kb random files
echo "Generating 1000 1kb files"
for X in {1..100}
do
FNAME="${DESTROOT}/many_${X}.txt"
head -c 1024 </dev/urandom >${FNAME}
done
echo "Done"

done
