---
author: Mansoor A
categories:
- HomePage
date: "2017-08-01T00:07:00Z"
description: ""
draft: false
tags:
- HomePage
title: Enable SSH in Raspberry Pi without a monitor
url: blog/raspberry-pi-ssh
---


If you are trying to setup your Raspberry Pi ( Running Raspbian ) without a monitor, you might be in for a surprise.
Well, the new Raspbian versions do not have SSH enabled by default, and for good reason. 
Most people who setup a RaspberryPi do not even change the default password and they connect it to the internet. 
And these RaspberryPis become part of a botnet in no time. 

Anyways, let's see how to enable SSH.

### Enable SSH in Raspbian
1. Prepare the SD card with Raspbian
2. Connect the SD card to your Linux/Mac/Windows laptop
3. Open the `/boot` partition of the SD card. This is a `FAT` filesystem, so all major operating systems should be able to open it.
4. `cd` to the `/boot` partition of the SD card (not the `/boot` of your system, obviously)  and create an empty file named `ssh`

   #### On a Mac/Linux machine
   ```
   touch ssh
   ```


   #### On a Windows Laptop
   Use notepad to create the empty file. Make sure it doesn't have the `.txt` extension

And that's it. Boot the Pi and you should be able to ssh to the Pi with the default username and password

