aws cli can't upload to https
-----------------------------

Performing an upload 'cp' command using awscli fails with https://s3-data-upload.sd2e.org:9001 but works with http://129.114.52.101:9001 . The debug log for awscli shows the following. I think the 100 response is the issue at play here.

```
PUT
/test/5MB.1

content-md5:OFR7redcRDF8578w8rjztg==
host:s3-data-upload.sd2e.org:9001
x-amz-content-sha256:UNSIGNED-PAYLOAD
x-amz-date:20171119T194129Z

content-md5;host;x-amz-content-sha256;x-amz-date
UNSIGNED-PAYLOAD
2017-11-19 19:41:29,034 - Thread-3 - botocore.auth - DEBUG - StringToSign:
AWS4-HMAC-SHA256
20171119T194129Z
20171119/us-east-1/s3/aws4_request
81ca52cc36eb5ec188b47f19e1403d70308fb16517484cad1843744d151549b4
2017-11-19 19:41:29,035 - Thread-3 - botocore.auth - DEBUG - Signature:
daea39c7e9116338d4f563e0aed70bdb261fc4018a4d55f16ff02552723c0c75
2017-11-19 19:41:29,035 - Thread-3 - botocore.hooks - DEBUG - Event request-created.s3.PutObject: calling handler <function enable_upload_callbacks at 0x7f13f3657cf8>
2017-11-19 19:41:29,038 - Thread-3 - botocore.endpoint - DEBUG - Sending http request: <PreparedRequest [PUT]>
2017-11-19 19:41:29,039 - Thread-3 - botocore.vendored.requests.packages.urllib3.connectionpool - INFO - Starting new HTTPS connection (1): s3-data-upload.sd2e.org
2017-11-19 19:41:29,440 - Thread-3 - botocore.awsrequest - DEBUG - Waiting for 100 Continue response.
2017-11-19 19:41:29,474 - Thread-3 - botocore.awsrequest - DEBUG - Received a non 100 Continue response from the server, NOT sending request body.
2017-11-19 19:41:29,475 - Thread-3 - botocore.vendored.requests.packages.urllib3.connectionpool - DEBUG - "PUT /test/5MB.1 HTTP/1.1" 417 363
2017-11-19 19:41:29,481 - Thread-3 - botocore.parsers - DEBUG - Response headers: {'date': 'Sun, 19 Nov 2017 19:41:29 GMT', 'content-length': '363', 'content-type': 'text/html', 'connection': 'close', 'server': 'lighttpd/1.4.32'}
```


