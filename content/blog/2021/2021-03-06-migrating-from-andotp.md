---
author: Mansoor A
categories:
- HowTo
date: "2021-03-06T04:32:34Z"
description: ""
draft: false
summary: Migrating from andOTP to other applications including to other platforms.
  We simply generate the QR codes from the backup file
tags:
- HowTo
title: Migrating From andOTP to Other Apps
url: blog/migrating-from-andotp
---


## My use case

As a long time Android user, I have been using andOTP (which you should be using if you are an Android user) and it worked amazingly for me. Especially the encrypted backup and the peace of knowing your OTPs are truly local, on your phone.

But, recently I got an iPhone and sadly andOTP does not have an iOS version, so I had to figure out a way to migrate all the accounts from andOTP to the new app. On iOS, I settled on `OTP Auth` which is kinda similar to andOTP in that it offers an encrypted backup option

## Requirements

A computer with Python 3, pip and git installed

## How to make the switch

1. Make an encrypted backup of your andOTP accounts and transfer the file to your computer
2. Clone the repository: `git clone https://github.com/asmw/andOTP-decrypt.git`
3. `cd andOTP-decrypt`
4. `pip3 install -r requirements.txt`
5. `./generate_qr_codes.py <location to the andOTP backup file>` This will ask you to enter the password for the encrypted file
6. Done! This will generate an image with QR code for all the accounts in the backup file. You can use any OTP app to scan them. Make sure you delete these images as anyone who have access to these can generate your TOTP codes

