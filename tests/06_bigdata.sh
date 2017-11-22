#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw awscli"
CLIENT="aws --endpoint-url ${TACC_S3_PROTO}://$TACC_S3_URI --cli-read-timeout 0 s3"
OPTS="--no-guess-mime-type"
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
ls s3://$TACC_S3_BUCKET
cp $OPTS --recursive data/huge s3://$TACC_S3_BUCKET/awscli/cp/huge/
sync $OPTS data/huge s3://$TACC_S3_BUCKET/awscli/sync/huge/
cp $OPTS --recursive data/toomany s3://$TACC_S3_BUCKET/awscli/cp/toomany/
sync $OPTS data/toomany s3://$TACC_S3_BUCKET/awscli/sync/toomany/
cp $OPTS --recursive s3://$TACC_S3_BUCKET/awscli/sync/huge downloads/huge/
cp $OPTS --recursive s3://$TACC_S3_BUCKET/awscli/sync/toomany downloads/toomany/
rm --recursive s3://$TACC_S3_BUCKET/awscli/cp
rm --recursive s3://$TACC_S3_BUCKET/awscli/sync
ls s3://$TACC_S3_BUCKET
EOM

rm -rf downloads/*
