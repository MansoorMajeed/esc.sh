---
author: Mansoor A
categories:
- HowTo
- HomePage
date: "2018-02-16T00:07:00Z"
description: ""
draft: false
summary: Moving all your 2FA codes from an authenticator app to another (only for
  rooted android devices)
tags:
- HowTo
- HomePage
title: Migrating the Authenticator app to a new device
url: blog/migrating-authenticator
---


> Note: For this to work, your source phone has to be a rooted Android device

> TL;DR : [Github Repository](https://github.com/MansoorMajeed/extract-authenticator-credentials)

Till last week, I was using the Lastpass Authenticator app as my main multifactor OTP generator. The main reason why I went with it was that it allows backing up of your OTP codes ( I know I know, it's a bad idea to put all your eggs in one basket and put your OTP in the cloud - That's what I'm getting into)

But, I had to switch phone and for some reason, LastPass Authenticator's backup functionality was not working. It simply refused to backup my accounts. I turned on my optimist mode and thought that it's a good thing.
Because, since forever, I wanted to move from Lastpass authenticator to an offline app, preferrably open source. 


### The search for a FOSS OTP app begins
So I started searching for a decent Open source TOTP app. I turned to the reddit gods and I wasn't disappointed. Someone at /r/fossdroid mentioned about `FreeOTP` and it looked promising. But, I wasn't extremely impressed with the UI. 

Search continued and I found the winner: [andOTP](https://github.com/andOTP/andOTP). It had better UI and an option to have encrypted local backups.

### Now comes the hard part
I have to switch ~15 accounts from old phone's app(Lastpass authenticator) to the new one. I actually thought of logging into each account and switching the authenticator app one by one. That would work, but would be extremely painful. So, as always, I decided to look for easier ways. 

### The Solution!!
Internet never disappoints and I found a Github repository with information on how to do it for Google Authenticator. I forked the repo, made some changes and voila! It worked. All my accounts from the Lastpass authenticator has been now copied to the new phone with `andOTP`. 

The beauty of it? You can use it on **any authenticator app**.

### How to do it?
It's quite simple. The only requirement that's a bit hard is that your old phone has to be a **rooted Android device**. iOS users, I'm sorry, you're on your own. 

If you're still interested, head over to my [Github Repository](https://github.com/MansoorMajeed/extract-authenticator-credentials)

