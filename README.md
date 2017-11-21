# Overview

TACC provides S3 compatible data management via Minio, a performant open-source implementation of the S3 server protocol. Minio is almost perfectly compatible with Amazon's S3 managed service, which means that existing S3 tooling with work out of the box. This README illustrates configuration and usage options for common S3 client packages in use today, tailored to TACC's specific Minio implementation. We also provide a prototype event-based triggering system that can take action based on file events in a specific S3 bucket. 

Documentation
* [Configuring S3 clients](docs/01-s3-clients.md)
* [Notifications and events](docs/03-events-reactors.md)

