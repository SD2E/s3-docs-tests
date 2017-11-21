include config.rc
export

.SILENT: docker
.PHONY: docker
docker: 
	echo "Building container images"
	scripts/docker.sh

.SILENT: test-mc
.PHONY: test-mc
test-mc: 
	echo "Testing minio-client"
	tests/01_mc.sh

.SILENT: test-aws
.PHONY: test-aws
test-aws: 
	echo "Testing aws-cli"
	tests/02_awscli.sh

.SILENT: test-s3cmd
.PHONY: test-s3cmd
test-s3cmd: 
	echo "Testing s3cmd"
	tests/03_s3cmd.sh

.SILENT: test-minfs
.PHONY: test-minfs
test-minfs: 
	echo "Testing minfs docker volume driver"
	tests/04_minfs.sh

.SILENT: test-boto
.PHONY: test-boto
test-boto: 
	echo "Testing boto Python library"
	tests/05_boto.sh
