#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw awscli"
CLIENT="aws --endpoint-url ${TACC_S3_PROTO}://$TACC_S3_URI s3"

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
cp data/big/5MB.1 s3://$TACC_S3_BUCKET
cp --recursive data/many s3://$TACC_S3_BUCKET/awscli/
sync data/many s3://$TACC_S3_BUCKET/awscli/
cp s3://$TACC_S3_BUCKET/5MB.1 downloads
rm --recursive s3://$TACC_S3_BUCKET/awscli
rm s3://$TACC_S3_BUCKET/5MB.1
ls s3://$TACC_S3_BUCKET
EOM
