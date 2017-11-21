#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw"
CLIENT="mc"

while read COMMAND
do
    echo "Action: $CLIENT $COMMAND"
    time $IMAGE $CLIENT $COMMAND
    if [ "$?" == 0 ];
    then
        echo "Success"
    else
        echo "Error: $?"
        exit 1
    fi
done <<EOM
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET
cp data/big/5MB.1 $TACC_S3_ALIAS/$TACC_S3_BUCKET
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET/5MB.1
cp --recursive data/many $TACC_S3_ALIAS/$TACC_S3_BUCKET/
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET/many
rm --force $TACC_S3_ALIAS/$TACC_S3_BUCKET/5MB.1
rm -r --force $TACC_S3_ALIAS/$TACC_S3_BUCKET/many
ls $TACC_S3_ALIAS/$TACC_S3_BUCKET
EOM
