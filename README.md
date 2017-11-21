# Overview

TACC provides S3 compatible data management via Minio, a performant open-source implementation of the S3 server protocol. Minio is almost perfectly compatible with Amazon's S3 managed service, which means that existing S3 tooling with work out of the box. This README illustrates configuration and usage options for common S3 client packages in use today, tailored to TACC's specific Minio implementation. We also provide a prototype event-based triggering system that can take action based on file events in a specific S3 bucket. 

Documentation
* [Configuring S3 clients](docs/01-s3-clients.md)
* [Notifications and events](docs/03-events-reactors.md)

## About this repository

In addition to holding documentation, which will eventually be turned into tutorials and guides, this repo can be used to validate correctness and measure performance of any TACC (or other) S3 endpoint. Tests are driven by the Makefile.

**Requirements**

1. Mac OS X 10.11+ / Linux (Ubuntu 14+ or Centos 7+)
2. Docker CE 17.09.0-ce-*
3. GNU Make 3.81+
4. GNU Bash 3.2.57+
5. Valid S3 endpoint, API key, and API secret
6. 100MB free disk to run basic tests
7. [Optional] 100GB free disk and 10Gb/sec network to run big data tests

## Running Tests

```
git clone https://github.com/SD2E/s3-docs-tests
cd s3-docs-tests
cp config.rc.sample config.rc
# (edit config.rc with appropriate values before proceeding)
make docker
make data
make tests
# optional - these will take a while and require a lot of disk space
make data/huge
make tests/huge
# now clean up
make clean
```
