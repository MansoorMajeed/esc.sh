---
author: Mansoor A
date: "2013-08-02T11:23:37Z"
description: ""
draft: false
title: How to unlock bootloader of Motorola Devices Using Ubuntu/Linux Mint
url: blog/unlock-bootloader-moto-ubuntu-mint
---


Bootloader is the code that boots up your phone's operating system. In order for you to use custom operating systems ( or as said in case of Android devices - custom ROMs ) you need to have an unlocked bootloader. Why? Well, because your phone's manufacture has locked down your phone so that no operating system other than that are signed by the manufacture can be loaded.

Today, I will show you how to unlock your bootloader in your Motorola device using a Linux desktop (preferably Ubuntu or Linux Mint). If you're here, so you probably know why you are doing this and the consequences of doing this.

Disclaimer:

>   * You  will lose your warranty by unlocking the bootloader
>   * You will lose all your contents in your device - including the installed apps (You should backup all important files)
>   * If you cause any damage to your device by following the instructions in this page, it's your sole responsibility ( Don't worry, if you do it right, nothing wrong will happen )
>   * And some other stuff you probably already know

Anyway, let's get started

  * Install the required tools: 
```
sudo apt-get update
sudo apt-get install android-tools
```

  * Now, put your phone in fastboot mode. For that, turn off your device, and then press the power button and volume down button simultaneously. You can remove your finger from the power button after a few seconds and you will be in fastboot mode
  * Now, connect your device to your Linux machine using a USB cable
  * Open a terminal and type: 
```
fastboot devices
# The above command will list your device. If it does then enter the following command
fastboot oem get_unlock_data
```

  * The above command will return a few lines of strings. It would look something like this:
```
    _(bootloader) 0A40040192024205#4C4D3556313230_
  
    _(bootloader) 30373731363031303332323239#BD00_
  
    _(bootloader) 8A672BA4746C2CE02328A2AC0C39F95_
  
    _(bootloader) 1A3E5#1F53280002000000000000000_
  
    _(bootloader) 0000000_
```
Now, copy those continuous strings into a one string. Do not include the text "bootloader" or any white space. At the end, your string should look like:
  ```
    _0A40040192024205#4C4D355631323030373731363031303332323239#BD008A672BA4746C2CE02328A2AC0C39F951A3E5#1F532800020000000000000000000000
  ```

  * Head to <a href="https://motorola-global-portal.custhelp.com/app/standalone/bootloader/unlock-your-device-b" target="_blank">HERE</a>. You will be prompted to login using your Motorola ID. Login and follow the onscreen instructions.

