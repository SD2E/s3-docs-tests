#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw"
OPTS=
if [ -n "${TACC_S3_IGNORE_CERT}" ]; then OPTS="--insecure"; fi
CLIENT="mc $OPTS"
HNAME=$(hostname)

rm -rf "$0.log"

while read COMMAND
do
    echo "Action: $CLIENT $COMMAND"

    T1=$(date "+%s")
    $IMAGE $CLIENT $COMMAND
    T2=$(date "+%s")
    ELAPSED=$((T2 - T1))
    echo -e "Test: $CLIENT $COMMAND\nElapsed: $ELAPSED seconds" >> "$0.log"
    
    if [ "$?" == 0 ];
    then
        echo "Success"
    else
        echo "Error: $?"
        exit 1
    fi
done <<EOM
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET
cp data/big/5MB.1 $TACC_S3_ALIAS/$TACC_S3_BUCKET/$HNAME/
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET/$HNAME/5MB.1
cp --recursive data/many $TACC_S3_ALIAS/$TACC_S3_BUCKET/$HNAME/
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET/$HNAME/many
rm -r --force $TACC_S3_ALIAS/$TACC_S3_BUCKET/$HNAME
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET
EOM
