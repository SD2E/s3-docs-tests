FROM minio/mc:RELEASE.2018-10-06T00-15-16Z

ARG S3_ALIAS
ARG S3_URI
ARG S3_REGION
ARG S3_KEY
ARG S3_SECRET
ARG S3_SIG
ARG S3_BUCKET
ARG S3_PROTO
ARG S3_USE_HTTPS

WORKDIR /home

RUN mc config host add $S3_ALIAS "$S3_PROTO://$S3_URI" $S3_KEY $S3_SECRET $S4_SIG
