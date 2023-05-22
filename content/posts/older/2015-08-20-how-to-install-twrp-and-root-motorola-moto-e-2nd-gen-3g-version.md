---
author: Mansoor A
date: "2015-08-20T18:28:20Z"
description: ""
draft: false
title: How To Install TWRP and Root Motorola Moto E 2nd Gen 3G version
url: blog/how-to-install-twrp-and-root-motorola-moto-e-2nd-gen-3g-version
---


If you wanted to root your Motorola Moto E 2nd Generation ( 3G version / Moto E 2015 / XT1506), you came to the right place. Let's get started

**Things You need:**

  1. Motorola Moto E Second Gen ( Codename: Otus ) with unlocked bootloader. If you don't have an unlocked bootloader, go <a href="http://digitz.org/blog/unlock-bootloader-moto-ubuntu-mint/" target="_blank">HERE</a>
  2. If you're using Linux, skip this step.  Windows users download mfastboot, and extract the contents:=> <a href="/blog/downloads/android/mfastboot-v2.zip" target="_blank">HERE: mfastboot-v2.zip</a>
  3. Download the TWRP recovery for MOTO E2nd Gen from : <a href="http://forum.xda-developers.com/devdb/project/?id=9288#downloads" target="_blank">HERE</a>
  4. Download the drivers for your phone from: <a href="https://androidmtk.com/download-motorola-usb-drivers" target="_blank">HERE</a> and install them properly.

 

**Installing Recovery: Linux Users ( Linux Mint / Ubuntu or anything for that matter )**

  1. Copy the TWRP recovery to your home folder.
  2. Boot into fastboot mode. ( Turn off your phone, now press and hold power button and volume down buttons simultaneously).  
While in fastboot mode, enter the following command to flash the recovery:  
The following command will display if your device is recognized properly by the system
```
fastboot devices
```
If you see a device list with a string, you're good to go
Issue the below command to flash the recovery
Make sure you replace `twrp-otus.img` with the correct name of the file you downloaded
```
fastboot flash recovery twrp-otus.img
fastboot reboot
```
  3. That's it. Now TWRP recovery is flashed onto your phone.

**Installing Recovery: Windows Users**

  1. Extract the `mfastboot_v2.zip` you have previously downloaded.
  2. Download TWRP recovery for your phone from <a href="http://forum.xda-developers.com/devdb/project/?id=9288#downloads" target="_blank">HERE</a>
  3. Download the drivers for your phone from: <a href="https://androidmtk.com/download-motorola-usb-drivers" target="_blank">HERE</a> and install them properly.
  4. Go to the folder where you extracted mfastboot, Press and hold shift key and right click inside the folder, choose open command window here. This should open up a command line.  

The following command will display if your device is recognized properly by the system
```
adb devices
```
If you see a device list with a string, you're good to go  
Before we flash the recovery, let's make sure that mfastboot is working.  
Issue the following command to see if mfastboot is working
```
mfastboot -h
```
This should list all the available options in mfastboot

Issue the below command to flash the recovery

Make sure you replace `twrp-otus.img` with the correct name of the file you downloaded
```
mfastboot flash recovery twrp-otus.img
```
The recovery should be flashed by now.
Issue the following command to reboot your device.

```
fastboot reboot
```
    
Now your phone should have TWRP recovery installed. Let's root the device
    
* Go <a href="http://download.chainfire.eu/supersu" target="_blank">HERE</a> and download the latest version of SuperSu.
* Transfer the above downloaded zip file to the root of your SD card
* Reboot into TWRP recovery, choose install zip, select the SuperSu zip and flash it. That's itIf you've come this far and did not mess up anything, you must be having a rooted device.

