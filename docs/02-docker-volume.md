# minfs Docker Volume Driver

There's an intriguing [Docker volume driver][8] for Minio S3 that allows one to create a Docker volume that uses an S3 bucket as its backing store. Caching is taken care of automatically, within the limits of the eventual consistency provided by the S3 protocol. TACC provides a [pre-built version of this plugin at Docker Hub][9] which you are free to use. There are extensive instructions on how to use Docker Compose to build and link to volumes at the [MinFS source repository][10]. 

## Usage

Here's how to manually create a volume and link a container to it: 

```
docker volume create -d tacc/minfs \
  --name "example-minfs-volume" \
  -o endpoint=http://s3-demo.sd2e.org:9001 \
  -o access-key=DBJKH5A9FITT0KRECU4U \
  -o secret-key=hNGUhiGG8QC1zzJH91mOFushbcDMD1Yx1 \
  -o bucket=example-bucket \
  -o opts=cache=/tmp/example-minfs-volume
```

You will be able to confirm it with `docker volume ls`. Here's an example:

```
DRIVER              VOLUME NAME
local               e245b1388ef40e2585585b370d963c385126009e46fa4839e7503f82cf6ebb88
tacc/minfs:latest   example-minfs-volume
local               synbiohub
```

Now, create and mount a consumer container:

```
docker run -it -v example-minfs-volume:/home ubuntu:xenial bash
```

File system actions you take inside `/home` in the container will be reflected directly in `example-bucket`. 

:warning: **S3 is an eventually-consistent protocol and FUSE, upon which the minfs plugin is based, caches extensively. Do not use the minfs Docker volume plugin for use cases that require a high degree of filesystem integrity or correctness**. 
