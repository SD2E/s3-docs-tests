#!/usr/bin/env bash

cat << EOF > docker-compose.yml
---
version: '2'

volumes:
  minfs-store:
    driver: tacc/minfs
    driver_opts:
      endpoint: ${TACC_S3_PROTO}://${TACC_S3_URI}
      access-key: ${TACC_S3_KEY}
      secret-key: ${TACC_S3_SECRET}
      bucket: ${TACC_S3_BUCKET}
      opts: cache=/tmp/minfs-store
EOF

# services:
#   interactive:
#     image: sd2e/base:ubuntu16
#     volumes:
#       - minfs-store:/root
