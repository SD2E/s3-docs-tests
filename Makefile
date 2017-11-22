include config.rc
export

.SILENT: docker
.PHONY: docker
docker: 
	echo "Building container images"
	scripts/docker.sh

.SILENT: data
data: 
	echo "Generating test data"
	scripts/getdata.sh

.PHONY: tests
tests: data test-mc test-aws test-s3cmd test-boto
	true

.SILENT: test-mc
.PHONY: test-mc
test-mc: data
	echo "Testing minio-client"
	tests/01_mc.sh

.SILENT: test-aws
.PHONY: test-aws
test-aws: data
	echo "Testing aws-cli"
	tests/02_awscli.sh

.SILENT: test-s3cmd
.PHONY: test-s3cmd
test-s3cmd: data
	echo "Testing s3cmd"
	tests/03_s3cmd.sh

.SILENT: test-minfs
.PHONY: test-minfs
test-minfs: data
	echo "Testing minfs docker volume driver"
	tests/04_minfs.sh

.SILENT: test-boto
.PHONY: test-boto
test-boto: data
	echo "Testing boto Python library"
	tests/05_boto3.sh

.SILENT: data/huge
data/huge: data
	echo "Generating air-quotes Big Data"
	scripts/bigdata.sh

.SILENT: tests/huge
.PHONY: tests/huge
tests/huge: data/huge
	echo "Running Big Data tests"
	tests/06_bigdata.sh

.SILENT: clean
.PHONY: clean
clean:
	echo "Cleaning up"
	rm -rf downloads
	rm -rf data
	rm -rf tests/*.log
	scripts/docker.sh clean

.SILENT: all
.PHONY: all
all: docker data tests 
	true
