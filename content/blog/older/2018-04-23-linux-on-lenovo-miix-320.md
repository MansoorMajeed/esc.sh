---
author: Mansoor A
categories:
- Linux
date: "2018-04-23T00:07:00Z"
description: ""
draft: false
summary: Installing Linux on the tiny convertible budget laptop from Lenovo - The
  Miix 320
tags:
- Linux
title: Installing Ubuntu Linux on Lenovo Miix 320 Hybrid Laptop
url: blog/linux-on-lenovo-miix-320
---


Lenovo Miix 320 is a tiny convertible laptop that doesn't put a hole in your wallet. It's an amazing piece of hardware with one major flaw - It comes with Windows 10. But, worry not, I was able to successfully install and use Ubuntu 18.04 on this tiny laptop, and it is pretty neat.

### UPDATE!! Please read

The original blog post was about installing Ubuntu 18.04 on your Miix 320. It took lot of effort to get the system to a usable state. But, I came across Pop OS by System76 (Someone mentioned it in the comments) and I gave it a shot. Surprisingly, everything works out of the box

Go [HERE](https://system76.com/pop) and download the Intel version. 

> You can use the instructions below to make the bootable disk etc. But, you don't need to edit any configuration files. It should work out of the box

### Choosing a Linux Distro

> Update: I highly recommend Pop OS! Read the above part if you haven't already.

I chose Ubuntu 18.04 (~~as of now, it is still in beta - not a public stable release~~) because it will have the latest possible Kernel, which means better hardware support. Lenovo Miix 320 was released very recently and because of that, old Kernels doesn't play nice with the hardware. Even with the latest available hardware, we need to do quite some work to get some stuff (like, boot!) working properly.

Let's get started

### Preparing a Bootable USB drive
Go ahead and download the Ubuntu iso from [HERE](http://releases.ubuntu.com/18.04/). Make sure you download the 64bit version. If you are too lazy to do that, [HERE](http://releases.ubuntu.com/18.04/ubuntu-18.04-desktop-amd64.iso) is the direct link to the ISO

Now that we have the ISO, we need to write it to a flash drive. I use [Etcher](https://etcher.io/) which is an amazing open source tool to flash OS images. 

Go ahead and download Etcher and prepare the bootable flash drive

### Making room for our installation
It is not a good idea to wipe the disk and install just Linux as things are not pretty yet. If you rely on this laptop to get things done, I recommend you keep Windows10 until you are sure that the Ubuntu installation works great for you.

If you plan to keep Windows 10, boot into it, launch the `disk management` tool and shrink your C drive. The maximum shrinkable size depends on the current usage of the Disk. We need at least 10GB of free space in the new partition. 

If you are not able to get 10GB out, try deleting some files and try to shrink it again.

> Note: Just leave the free partition as it is. We will format it from Ubuntu, so, we don't have to anything to it from Windows

### The installation
#### Disable Secure Boot
Press the power button (hold it for a second to power it on) and then press `Fn+F2` to get into the BIOS

In the BIOS, use the right arrow to go to the `Configuration` and then disable `Secure Boot` from there.

#### Boot it up!
Connect the USB, power on the Laptop and press `Fn+F12` to get the boot menu. Choose your USB drive and press enter.

> WARNING!! : In the Grub menu, **DO NOT PRESS ENTER YET**

The thing is, with the default boot parameters, it just won't boot in this particular laptop. We need to change some boot paramaters so that it comes up.

In the grub menu, press `e` to edit the entry.

Above the line that starts with `linux`, add the following
```
set gfxpayload=keep
```
At the end of the line that starts with `linux`, add the following
```
nomodeset i915.modeset=1 fbcon=rotate:1
```
What `nomodeset` does is, it tells the kernel not to load the video drivers until the sytem has finished booting.

Also `fbcon=rotate:1` rotates the display clockwise. We need to do this because, otherwise Ubuntu will be in portrait mode. We don't want that.
So, the resulting screen would look something like this
```
set gfxpayload=keep
linux        /casper/vmlinuz.efi file=/cdrom/preseed/ubuntu.seed boot=casper quiet splash nomodeset i915.modeset=1 fbcon=rotate:1 ---
```
Press `Ctrl+X` to continue with the boot. It will go to the normal Ubuntu installation screen. I guess you know how to handle the installation.

Once the installation is finished, Reboot your laptop. Do not forget to remove the USB drive.

> IMPORTANT: Once you are at the Grub menu again, press `e` and do exactly the same as we did just above.

> NOTE: After the boot, chances are you will be greeted with a black screen. Just close the lid for a second and open it again and you should see the login screen

Once you boot into the Ubuntu desktop, open a terminal and edit the file `/etc/default/grub`
```shell
sudo nano /etc/default/grub
```
Add the following lines into it
```
GRUB_CMDLINE_LINUX="nomodeset i915.modeset=1 fbcon=rotate:1"
GRUB_GFXPAYLOAD_LINUX=keep
```
Press `Ctrl+X` and then `Y` and press `Enter` to save it.

Open a terminal and run the following
```
sudo update-grub
```
This will update your Grub with the parameters and you won't have to edit anything next time you boot.

> NOTE: Someone in the comment suggested to use `xrandr -o right` to rotate the display and this command is universal across distros. Thank you Taylor

### Fixing stuff
Now that we have our Ubuntu installation working, there are many things that still need work.
#### Disable touchpad while typing
This can be very annoying. By default, it doesn't disable the touchpad while typing. So, there is a good chance that you might end up touching your touchpad and cause a tragedy. Use the following command to disable touchpad while typing
```shell
syndaemon -i 0.5 -t -K -d
```
#### Fix the touch screen
Good news is that, the touch screen works nice. But, it is twisted to the right. You'd come to understand it if you try to scroll/touch the screen.

The following command should fix that and you should be able to use the touch screen properly in landscape.
```shell
xinput set-prop "04F3224A:00 04F3:237D" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
```
If this doesn't work for you, your 'ID' might be different. Use the following command to find out the correct ID
```shell
xinput --list
```
Look for the device id that looks similar to "04F3224A:00 04F3:237D" and use that in the command
```shell
xinput set-prop "your device id here" 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
```
#### Install Xubuntu
By default, Ubuntu 18.04 has Gnome as the desktop environment. While it is all shiny, it's quite heavy. For a tiny laptop like the Miix 320, we'd need something light.

> Note: this is optional - Only if you need a less resource hungry desktop environment

```shell
sudo apt-get update
sudo apt-get install xubuntu-desktop
```
Logout, Choose `Xubuntu` from the login screen and you should be good to go.

#### Fixing the brightness
Yeah, so another thing that doesn't work yet is the brightness control. But, we can have a hack for now. Please note that this thing doesn't help with the battery as it is more like an overlay that reduces the light intensity. But, surely it can help your eyes
```shell
sudo add-apt-repository ppa:apandada1/brightness-controller
sudo apt-get update
sudo apt-get install brightness-controller-simple
```
Then, search for `brightness controller` and you can adjust the intensity of the backlight

#### Powersaving
So, another bad thing is that the battery life would be not great. The following tool might help a bit.
```shell
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw smartmontools ethtool
```

### Footnotes
While Ubuntu 18.04 in the Lenovo Miix 320 hybrid laptop is not perfect, it works great. It works much much faster than Windows 10, and you can actually get some work done in this tiny little laptop.

#### So, what works?
 - Keyboard
 - Touchpad
 - Touchscreen
 - Sound
 - Battery indicator
 - WiFi
 - All Major functions

#### What doesn't work?
 - Camera
 - SD Card slot 
 - Brightness control


Well, that's all about it. Let me know if you have question in the comments and I'll try to address it. :)

