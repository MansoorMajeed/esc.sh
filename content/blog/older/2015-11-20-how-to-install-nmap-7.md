---
author: Mansoor A
date: "2015-11-20T08:39:59Z"
description: ""
draft: false
title: How to install nmap 7
url: blog/how-to-install-nmap-7
---


Nmap, the ultimate security scanner has released the latest version - nmap v7.

### What's new in nmap 7?

  * Major Nmap Scripting Engine (NSE) Expansion : 171 new scripts and 20 libraries since Nmap 6 ( Including firewall bypass )
  * Mature IPv6 support
  * Faster Scans : New Nsock engines give a performance boost to Windows and BSD systems
  * SSL/TLS scanning solution of choice : Scan for Heartbleed, POODLE, and FREAK vulnerabilities
  * Ncat Enhanced
  * Extreme Portability

### How to install Nmap 7 in Linux Distros ( Ubuntu / Mint / Kali 2.0 Sana )

Well, this can be used to install nmap 7 in almost any Linux systems. The steps are simple enough. Open a terminal ( Ctrl + Alt + T ) and issue the following commands one by one.

* Download the latest nmap package 
```
wget https://nmap.org/dist/nmap-7.00.tar.bz2
```
    
* Extract the downloaded package 
```
bzip2 -cd nmap-7.00.tar.bz2 | tar xvf -
```

* Compile and install it. 
```
cd nmap-7.00
./configure
make
sudo make install
```

    
That's it. Nmap v7 is now installed in your machine.
    
### How to install nmap 7 on Windows 7/8/8.1/10
    
Installing nmap in windows is just about running the executable.
    
Download the installer from [HERE](https://nmap.org/dist/nmap-7.00-setup.exe) and run it.  
you should have nmap installed on your PC/Laptop now

