#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw s3cmd"
CLIENT="s3cmd --no-check-md5 --progress --stats"

mkdir -p downloads/huge && mkdir -p downloads/toomany

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
sync data/huge s3://$TACC_S3_BUCKET/s3cmd/sync/huge/
sync data/toomany s3://$TACC_S3_BUCKET/s3cmd/sync/toomany/
put --recursive data/huge s3://$TACC_S3_BUCKET/s3cmd/put/huge/
put --recursive data/toomany s3://$TACC_S3_BUCKET/s3cmd/put/toomany/
get --recursive s3://$TACC_S3_BUCKET/s3cmd/sync/huge downloads/huge/
get --recursive s3://$TACC_S3_BUCKET/s3cmd/sync/toomany downloads/toomany/
del --recursive s3://$TACC_S3_BUCKET/s3cmd/sync
del --recursive s3://$TACC_S3_BUCKET/s3cmd/put
ls s3://$TACC_S3_BUCKET
EOM
