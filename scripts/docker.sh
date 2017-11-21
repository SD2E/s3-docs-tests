#!/usr/bin/env bash

cd docker

COMMAND=$1

echo "docker.sh $COMMAND"

if [ -z "$COMMAND" ]
then
    COMMAND="build"
fi

for I in awscli mc s3cmd boto
do
    if [ "$COMMAND" == "build" ]
    then
    echo "Building $I..."
    docker build -q -t $I -f Dockerfile.${I} \
                 --build-arg S3_ALIAS=$TACC_S3_ALIAS \
                 --build-arg S3_URI=$TACC_S3_URI \
                 --build-arg S3_REGION=$TACC_S3_REGION \
                 --build-arg S3_KEY=$TACC_S3_KEY \
                 --build-arg S3_SECRET=$TACC_S3_SECRET \
                 --build-arg S3_SIG=$TACC_S3_SIG \
                 --build-arg S3_PROTO=$TACC_S3_PROTO \
                 --build-arg S3_USE_HTTPS=$TACC_S3_USE_HTTPS \
                 --build-arg S3_BUCKET=$TACC_S3_BUCKET .
    elif [ "$COMMAND" == "clean" ]
    then
        echo "Deleting Docker image '${I}'"
        docker rmi -f $I &> /dev/null
    else
        echo "Unknown command $COMMAND"
        exit 1
    fi
done

