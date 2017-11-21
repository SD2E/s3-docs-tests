#!/usr/bin/env bash

docker volume create -d tacc/minfs \
  --name "minfs-volume" \
  -o endpoint=${TACC_S3_PROTO}://${TACC_S3_URI} \
  -o access-key=${TACC_S3_KEY} \
  -o secret-key=${TACC_S3_SECRET} \
  -o bucket=${TACC_S3_BUCKET} \
  -o opts=cache=/tmp/minfs-volume

if [ "$?" != 0 ]
then
    echo "Error: Couldn't create a minfs-based Docker volume"
    exit 1
fi

docker run --rm --name "minfs-test" -v minfs-volume:/root -w /root ubuntu:xenial sleep 60 &

if [ "$?" != 0 ]
then
    echo "Error: Couldn't create a container mounting the minfs Docker volume"
    exit 1
fi

sleep 1

IMAGE="docker exec minfs-test"
CLIENT=""
TS="$( date "+%s" ).txt"

while read COMMAND
do
    echo "Action: $IMAGE $CLIENT $COMMAND"
    $IMAGE $COMMAND
    
    if [ "$?" == 0 ];
    then
        echo "Success"
    else
        echo "Error: $?"
        exit 1
    fi
    echo "======"

done <<EOM
pwd
ls
touch $TS
ls
rm $TS
EOM

docker kill minfs-test
docker volume rm -f minfs-volume
