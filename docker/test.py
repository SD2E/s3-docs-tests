#!/usr/bin/env python

import boto3
import os
import sys
from botocore.client import Config

CONFIG = {'protocol': 'https',
          'server': 'localhost:9001',
          'aws_key': None,
          'aws_secret': None,
          'signature': 's3v4',
          'region': 'us-east-1',
          'bucket': None}

if os.environ.get('AWS_S3_PROTO'):
    CONFIG['protocol'] = os.environ.get('AWS_S3_PROTO')
if os.environ.get('AWS_S3_URI'):
    CONFIG['server'] = os.environ.get('AWS_S3_URI')
if os.environ.get('AWS_S3_KEY'):
    CONFIG['aws_key'] = os.environ.get('AWS_S3_KEY')
if os.environ.get('AWS_S3_SECRET'):
    CONFIG['aws_secret'] = os.environ.get('AWS_S3_SECRET')
if os.environ.get('AWS_S3_REGION'):
    CONFIG['region'] = os.environ.get('AWS_S3_REGION')
if os.environ.get('AWS_S3_SIG'):
    CONFIG['signature'] = os.environ.get('AWS_S3_SIG')
if os.environ.get('AWS_S3_BUCKET'):
    CONFIG['bucket'] = os.environ.get('AWS_S3_BUCKET')

print("Creating boto3 client")
s3 = boto3.client('s3',
                  endpoint_url=CONFIG['protocol'] + '://' + CONFIG['server'],
                  aws_access_key_id=CONFIG['aws_key'],
                  aws_secret_access_key=CONFIG['aws_secret'],
                  config=Config(signature_version=CONFIG['signature']),
                  region_name=CONFIG['region'])

print("Listing all buckets")
response = s3.list_buckets()
for bucket in response['Buckets']:
    print(bucket['Name'])

print("Listing a specific bucket")
for key in s3.list_objects(Bucket=CONFIG['bucket'])['Contents']:
    print(key['Key'])

print("Upload a test file to the bucket")
s3.upload_file('ipsum.txt', CONFIG['bucket'], 'pirate.txt')

print("Verifying the upload")
filenames = []
for key in s3.list_objects(Bucket=CONFIG['bucket'])['Contents']:
    filenames.append(key['Key'])
if 'pirate.txt' in filenames:
    print("Success")
else:
    print("Failure")
    sys.exit(1)

print("Deleting the uploaded file")
s3.upload_file('ipsum.txt', CONFIG['bucket'], 'pirate.txt')
