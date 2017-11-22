#!/usr/bin/env bash

rm -rf "$0.log"

echo "Testing boto3"

T1=$(date "+%s")
docker run boto
T2=$(date "+%s")
ELAPSED=$((T2 - T1))
echo -e "Test: boto3: $ELAPSED seconds" >> "$0.log"

if [ "$?" == 0 ];
then
    echo "Success"
else
    echo "Error: $?"
    exit 1
fi
