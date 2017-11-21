#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw awscli"
CLIENT="aws --endpoint-url ${TACC_S3_PROTO}://$TACC_S3_URI s3"
OPTS="--no-guess-mime-type "
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
cp $OPTS --recursive data/huge s3://$TACC_S3_BUCKET/awscli/cp/huge/
sync $OPTS data/huge s3://$TACC_S3_BUCKET/awscli/sync/huge/
cp $OPTS--recursive data/toomany s3://$TACC_S3_BUCKET/awscli/cp/toomany/
sync $OPTS data/toomany s3://$TACC_S3_BUCKET/awscli/sync/toomany/
rm --recursive s3://$TACC_S3_BUCKET/awscli/cp
rm --recursive s3://$TACC_S3_BUCKET/awscli/sync
ls s3://$TACC_S3_BUCKET
EOM
