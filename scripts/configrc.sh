#!/usr/bin/env bash

FUSER=$1

if [ -z "$FUSER" ];
then
    echo "Usage: $0 <username>"
fi

if [ -f "config.rc" ]
then
    . config.rc
else
    echo "No config.rc found"
    exit 1
fi

cat << EOF > ${FUSER}-tacc-s3.rc
export S3_ALIAS=s3-data-upload
export S3_KEY=DUKHBJTT0KREC5A9FI4U
export S3_SECRET=tC1zzJH91hNiGG8QGUh/r5X8EmOFushbcDMD1Yx1
export S3_REGION=us-east-1
export S3_SIG=s3v4
export S3_BUCKET=sd2e-community/ingest/${FUSER}
export S3_URI=s3-data-upload.sd2e.org:9001
export S3_PROTO=https
export S3_USE_HTTPS=True
export S3_IGNORE_CERT=
EOF
