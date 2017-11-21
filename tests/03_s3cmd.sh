#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw s3cmd"
CLIENT="s3cmd"

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
ls s3://$TACC_S3_BUCKET
put data/big/5MB.1 s3://$TACC_S3_BUCKET
sync data/many s3://$TACC_S3_BUCKET/s3cmd/
del --recursive s3://$TACC_S3_BUCKET/s3cmd
del s3://$TACC_S3_BUCKET/5MB.1
ls s3://$TACC_S3_BUCKET
EOM

