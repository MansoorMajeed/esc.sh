---
author: Mansoor A
date: "2016-02-20T20:51:04Z"
description: ""
draft: false
title: Fixing the WiFi issue on Acer Laptops running Linux ( Qualcomm Atheros Device
  0042 )
url: blog/wifi-issue-on-acer-laptops-running-linux-qualcomm-atheros-device-0042
---


Last week, I bought an Acer Laptop which had Linpus Linux installed in it. The reason why I went for acer instead of HP was that I intend to use Linux Mint as my primary operating systems and HP systems are notorious when it comes to Linux and wifi drivers.

But, in my new laptop, I have installed Linux Mint 17.3 and I was shocked to see that the WiFi is not working. I was really frustrated. But, fortunately, later that day I found out that the WiFi card used in the Laptop is a fairly new one and Linux distros does not have the driver in the official installation ( or the repos, for that matter ). And I was able to fix the Wifi issue very easily

My Laptop : Acer Aspire E15 (E5-573G-3100)

> Note : This should work for any laptop with Qualcomm Atheros Device 0042

### This is how I fixed the WiFi issue in my Laptop

> Update : The WiFi issues are fixed in later versions of Linux Kernel. So, I'd suggest you to use a later version of Linux Distro Like Ubuntu 16.04, Linux Mint 18 or even the latest version of Kali Linux and you shouldn't face any WiFi issue

##### Identify your WiFi device. Open a terminal and issue 
  
```bash
lspci  | grep Network
# It should display the name of your WiFi card
# If the output is similar to the one below, you are in luck, we can fix this easily
mansoor ~ $ lspci  | grep Network
```

Once you have made sure that the Network device is the one above, follow the below steps to install the driver for WiFi
##### Install git and tools to compile the driver 

```bash
sudo apt-get install build-essential linux-headers-$(uname -r) git
```

##### Issue the following commands one by one. Anything written after "#" is a comment and you don't have to execute it. 
It's just there to help you understand what's going on 
```bash
# Modify the config files
echo "options ath10k_core skip_otp=y" | sudo tee /etc/modprobe.d/ath10k_core.conf

# Download the backport
wget https://www.kernel.org/pub/linux/kernel/projects/backports/2015/11/20/backports-20151120.tar.gz

# Extract it
tar zxvf backports-20151120.tar.gz

# cd to the directory, compile and install it. The commands 'make' and 'make install' will take some time to finish
cd backports-20151120
make defconfig-wifi
make
sudo make install

# Download the firmware for the WiFi card
git clone https://github.com/kvalo/ath10k-firmware.git

# Copy the firmware to appropriate locations. 
sudo cp -r ath10k-firmware/QCA9377 /lib/firmware/ath10k/
sudo cp /lib/firmware/ath10k/QCA9377/hw1.0/firmware-5.bin_WLAN.TF.1.0-00267-1 /lib/firmware/ath10k/QCA9377/hw1.0/firmware-5.bin
```

##### Reboot your machine. That's it. Your wifi should work now until you do a kernel update.

    
### What to do after a Kernel update

If you update your kernel after the above patch, you will have to recompile and re-install it. Follow the below steps in case you update your kernel and WiFi stopped working

```bash
cd backports-20151120
make clean
make defconfig-wifi
make
sudo make install
```

Alright. You're all set. I was able to make the WiFi work without having to sweat much. Pheww.. 😀

