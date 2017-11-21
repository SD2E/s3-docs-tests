#!/usr/bin/env bash

echo "Testing boto3"

docker run boto

if [ "$?" == 0 ];
then
    echo "Success"
else
    echo "Error: $?"
    exit 1
fi
