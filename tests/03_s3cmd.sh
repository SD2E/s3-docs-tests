#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw s3cmd"
OPTS=
if [ -n "${TACC_S3_IGNORE_CERT}" ]; then OPTS="--no-check-certificate"; fi
CLIENT="s3cmd $OPTS"
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
ls s3://$TACC_S3_BUCKET
put data/big/5MB.1 s3://$TACC_S3_BUCKET/$HNAME/
sync data/many s3://$TACC_S3_BUCKET/$HNAME/s3cmd/
del --recursive s3://$TACC_S3_BUCKET/$HNAME
ls s3://$TACC_S3_BUCKET
EOM
