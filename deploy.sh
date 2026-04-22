#!/bin/bash

# generate name
TS=$(date +%s)
BUCKET=nano-test-$TS

# create file
echo "<h1>Hello AWS</h1>" > index.html

# create bucket
aws s3 mb s3://$BUCKET --region ap-southeast-1

# upload
aws s3 cp index.html s3://$BUCKET/

# enable website
aws s3 website s3://$BUCKET/ --index-document index.html

# disable block public
aws s3api put-public-access-block \
--bucket $BUCKET \
--public-access-block-configuration '{
  "BlockPublicAcls": false,
  "IgnorePublicAcls": false,
  "BlockPublicPolicy": false,
  "RestrictPublicBuckets": false
}'

# apply policy
aws s3api put-bucket-policy --bucket $BUCKET --policy '{
  "Version":"2012-10-17",
  "Statement":[{
    "Effect":"Allow",
    "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::'"$BUCKET"'/*"]
  }]
}'

# test
URL="http://$BUCKET.s3-website-ap-southeast-1.amazonaws.com"
echo "URL: $URL"
curl $URL

# cleanup (optional - comment kalau nak test lama)
# aws s3 rm s3://$BUCKET --recursive
# aws s3 rb s3://$BUCKET
