#!/usr/bin/env bash

IMAGE="docker run -v $PWD:/home:rw awscli"
OPTS=
if [ -n "${TACC_S3_IGNORE_CERT}" ]; then OPTS="--no-verify-ssl"; fi
CLIENT="aws --endpoint-url ${TACC_S3_PROTO}://$TACC_S3_URI $OPTS s3"
HNAME=$(hostname)
rm -rf "$0.log"

DS="201808"
for LAB in biofab emerald ginkgo transcriptic
do
    for DIR in $(ls data/${LAB}/${DS})
    do
        $IMAGE $CLIENT cp --recursive data/${LAB}/${DS}/${DIR} s3://$TACC_S3_BUCKET/${LAB}/${DS}/${DIR}
    done
done
