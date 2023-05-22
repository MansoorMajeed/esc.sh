---
author: Mansoor A
categories:
- Google Cloud
- HomePage
date: "2017-08-05T00:07:00Z"
description: ""
draft: false
summary: Easily mount a Google Cloud Storage bucket in a Linux file system using gcsfuse
  and use it as if a local disk attached
tags:
- Google Cloud
- HomePage
title: How to mount a Google Cloud Bucket in Linux
url: blog/mount-gcs-bucket-linux
---


Google Cloud Storage is Google's equivalent of Amazon's S3. And it's cheaper than S3 and works pretty great.

Today, I'll be explaining how to mount a Google Cloud Storage bucket to your Linux Machine (Running Debian/Ubuntu)
using `gcsfuse`

> A word of advice: gcsfuse mounted bucket is painfully slow for operations involving many files.If you are going to have too many file reading/writing to the Bucket through this mount, this is not adviced. On the other hand, if you are storing big files in small quantities, this is a great way to have cheaper storage

Note: This can be used for any major Debian derivative

#### Install gcsfuse
Enter the following commands one by one

```bash
sudo apt-get update
sudo apt-get install curl -y

export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install gcsfuse
```

As of now, you should have `gcsfuse` installed and ready for action. But we will need `google-cloud-sdk` for authenticating to the Google Storage

#### Install Google Cloud SDK

```bash
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

#### Authenticate with Google Cloud Storage
Switch to the user you will be mounting your bucket with. And issue the following command

```bash
gcloud auth application-default login
```

This will present you with a URL. Copy that URL and paste it in your browser, login with your Google account.
You should see a token on your browser window. Copy it and paste it in the Terminal prompt asking for the verification code.

Once you give the token, you should be authenticated and you can now mount your Bucket.

#### Mount the bucket
Again, switch to the user you want to mount the bucket as. This is important because you cannot change the ownership of the mount.
If you mount it with `root` user, then the mount can only be used by the `root` user.

```bash
mkdir /mnt/google-cloud-bucket
gcsfuse your_bucket_name /mnt/google-cloud-bucket
```

That's it, you should have your bucket mounted on your system. You can verify the mount using the `df -h` command

