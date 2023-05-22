---
author: Mansoor A
categories:
- Linux
date: "2021-03-07T09:07:23Z"
description: ""
draft: false
summary: Linux on Razer Blade Stealth 2019 works great except for a few hiccups like
  suspend being broken. In this post, I explain how to fix it
tags:
- Linux
title: Fixing Linux on Razer Blade Stealth 2019
url: blog/fixing-linux-on-razer-blade-stealth-2019
---


## Problems

1. Does not wake up from sleep
2. Infinite suspend loop

## Fixes

### Upgrade Kernel to latest available

A lot of the issues are fixed on the later versions of the Kernel. First, make sure you have the latest available Kernel installed

We can use a simple script from [HERE](https://github.com/pimlie/ubuntu-mainline-kernel.sh) to easily install the latest Kernel.

> Note: If you are installing a Kernel manually, you will have to disable secure boot in bios

```
sudo apt install wget
wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
chmod +x ubuntu-mainline-kernel.sh
```

Now, to install the latest Kernel, simple run

```
sudo ./ubuntu-mainline-kernel.sh -i
```

Once the Kernel is installed, simply reboot

> Note, now check if suspend is functioning properly. These issues could be fixed in a future Kernel. If it still does not function properly, continue reading

### Fix suspend

To fix suspend, we need to add a Kernel parameter

```
button.lid_init_state=open
```

First of all, figure out if you are using Grub or systemd boot. If you are using Pop OS!, you are most probably using systemd-boot. I believe Ubuntu is still using Grub2, please do your research.

**For Grub**

Edit `/etc/default/grub` as root (You can use your favourite text editor). If you don't have one, do `sudo gedit /etc/default/grub`

Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` and add the parameter there. Your line should look like this now (Make sure it is a single line with no line break)

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash button.lid_init_state=open"
```

And update grub using

```
sudo update-grub
```



**For Systemd boot**

Find your loader configuration. For example, Pop OS! conf path is

```
/boot/efi/loader/entries/Pop_OS-current.conf
```

Edit the file and find the line that starts with `options` and add the parameter to the end of the line. It should look like this after adding the entry

```
options root=UUID=350fc3dc-9ed1-440d-9a8f-922ee8c6511f ro quiet loglevel=0 systemd.show_status=false splash button.lid_init_state=open
```

## Fix suspend loop

Create a new file at `/etc/modprobe.md/blacklist-nvidia.conf` with the content

```
blacklist i2c_nvidia_gpu
```



Reboot. Things should work now

