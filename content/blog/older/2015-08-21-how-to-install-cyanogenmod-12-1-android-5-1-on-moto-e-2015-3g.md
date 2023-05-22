---
author: Mansoor A
date: "2015-08-21T17:52:51Z"
description: ""
draft: false
title: How to install Cyanogenmod 12.1 (Android 5.1) on Moto E 2015 3G
url: blog/how-to-install-cyanogenmod-12-1-android-5-1-on-moto-e-2015-3g
---


If you're reading this, that probably means you know what Cyanogenmod is and you want to install it in your Moto E. There is no point in writing something up about CM and how great it is, which you're not gonna read anyway. So, let's get started.

### Which Device?

Motorola Moto E Second Generation, 3G variant, Code name: Otus. XT1506. This post is about the 3G variant, and not the 4G one.

### Disclaimer

I'm not responsible for whatever happens to your device by you following the instructions mentioned in this page. No, seriously. 😀

If you brick your device, it's your own responsibility and you should blame yourself only 😛 But, if you have little bit of common sense and the ability to understand English, I promise you that nothing will go wrong. On the other hand, Oh well..!!

And one other thing to note here is that, IT WILL WIPE YOUR DEVICE AND ALL THE DATA WILL BE LOST. DO A BACKUP BEFORE FLASHING ANYTHING.

> Update: Cyangoenmod is now officially supported for Moto E 2015, Yay!! 😀

### Cyanogenmod 12.1 Review? Anything like that?

Actually, yeah!. Well, I've been using CM 12.1 for past couple of weeks and I'm impressed. It's pretty fast and got tons of options.

One thing I noticed is that the battery is draining a bit more fast, comparing to the stock ROM. Maybe it's just me. But, if you have an unlocked bootloader, I would strongly recommend you to try this one. And that's that. Phew!

### Prerequisites

  1. You need an unlocked bootloader for this to work. If you don't have an unlocked bootloader, read <a href="http://esc.sh/blog/unlock-bootloader-moto-ubuntu-mint/" target="_blank">THIS</a>
  2. You need a rooted device with TWRP installed. If you don't have it, go <a href="http://esc.sh/blog/how-to-install-twrp-and-root-motorola-moto-e-2nd-gen-3g-version/" target="_blank">HERE</a>
  3. You need an internet connection to download two zip files

### Here's how to install Cyanogenmod 12.1 in your Moto E 2nd Gen

  1. First things first. <del>Download the Cyanogenmod rom from <a href="http://www.mediafire.com/download/1s63e6q6gz3pda9/cm-12.1-20150821-UNOFFICIAL-otus.ziphttp://www.mediafire.com/download/1s63e6q6gz3pda9/cm-12.1-20150821-UNOFFICIAL-otus.zip" target="_blank">HERE</a> This is the latest build at the time of writing this post.</del>
  
 You could go to the original thread <a href="http://forum.xda-developers.com/moto-e-2015/orig-development/rom-cyanogenmod-moto-e-3g-t3098526" target="_blank">HERE</a> to get the link to the latest build. Download the zip and transfer it to the root of your SD card
    
    
Actually, Cyanogenmod has official builds for Moto E 2015 ( 2nd Generation ). Download the latest version of the ROM file from <a href="https://download.cyanogenmod.org/?device=otus" target="_blank">HERE</a>

Download google apps (gapps) for CM from <a href="http://wiki.cyanogenmod.org/w/Google_Apps" target="_blank">HERE</a>. Make sure you download the one corresponding to CM version 12.1. Transfer it to the root of your SD card

Turn off your phone, now press and hold power button and volume down buttons simultaneously. Release the power button after a few seconds and you should see the recovery menu. Use volume down to move the selection to the "Recovery" and press the volume up to make a selection. TWRP should load now


In TWRP, you can use the touch screen. Go ahead and wipe your device now. Tap on advanced wipe and select "data, cache, dalvick cache and system" and swipe to wipe. WARNING!! THIS WILL ERASE ALL THE APPS/CONTACTS AND WHATNOT FROM YOUR PHONE. But, I know you have a backup, 😉


Once everything is wiped, tap on install zip, and add the two zip files you have downloaded previously. Now swipe right to flash those zip files, once the flashing is completed, reboot your device, sit back and relax. Your phone will boot into Cyanogenmod.

