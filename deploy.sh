#!/bin/bash

TS=$(date +%s)
BUCKET=nano-test-$TS

echo "<h1>Hello AWS</h1>" > index.html

aws s3 mb s3://$BUCKET --region ap-southeast-1
aws s3 cp index.html s3://$BUCKET/
aws s3 website s3://$BUCKET/ --index-document index.html

echo "URL: http://$BUCKET.s3-website-ap-southeast-1.amazonaws.com"
