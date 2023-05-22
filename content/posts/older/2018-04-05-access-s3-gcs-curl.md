---
author: Mansoor A
categories:
- Ops
- SRE
date: "2018-04-05T00:07:00Z"
description: ""
draft: false
summary: Quick script to access private objects from Google Cloud Storage or Amazon
  S3 using the secret and key
tags:
- Ops
- SRE
title: Accessing private objects from S3 or GCS using curl
url: blog/access-s3-gcs-curl
---


There will be scenarios where you might want to make a request directly to Google Cloud Storage Bucket or your Amazon
S3 bucket using curl.  This can be especially helpful if you want to host your static site or some other stuff in S3/GCS 
and you want to serve it via a proxy like Nginx or even using a CDN like Fastly.

This is quite simple (once you figure out all the proper headers ;) )

```shell
#!/bin/bash

# Path to your test file
req_path="/index.html"

# We need the current date to calculate the signature and also to pass to S3/GCS
curr_date=`date +'%a, %d %b %Y %H:%M:%S %z'`

# This is the name of your S3/GCS bucket
bucket_name="yourbucket"
string_to_sign="GET\n\n\n${curr_date}\n/${bucket_name}${req_path}"

# Your secret
secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Your S3 key
s3_key="XXXXXXXXXXXXXXXXXXXXXXX"

# We will now calculate the signature to be sent as a header.
signature=$(echo -en "${string_to_sign}" | openssl sha1 -hmac "${secret}" -binary | base64)

# That's all we need. Now we can make the request as follows.

# GCS
curl -v -H "Host: ${bucket_name}.storage.googleapis.com" \
        -H "Date: $curr_date" \
        -H "Authorization: AWS ${s3_key}:${signature}" \
         "https://${bucket_name}.storage.googleapis.com${req_path}" --compress

# S3
curl -v -H "Host: ${bucket_name}.s3.amazonaws.com" \
        -H "Date: $curr_date" \
        -H "Authorization: AWS ${s3_key}:${signature}" \
         "https://${bucket_name}.s3.amazonaws.com${req_path}" --compress
```

