---
author: Mansoor A
date: "2014-10-11T18:16:00Z"
description: ""
draft: false
title: How To install and use tor in centos 7
url: blog/how-to-install-and-use-tor-in-centos-7-2
---


> Note: This is an old post. 
Today, I'll help you guys to install and use tor in your centos 7 machine. This method works with other versions of centos or fedora too.

Here's how you will do it.
    
We have to add the repository to install tor. For that, we need to create a new repo file in the yum.repos.d folder. For that, issue the following command (Please note that you need to be root to edit this file)
```shell
sudo gedit /etc/yum.repos.d/torproject.repo
```
  
Now, paste the following text into that file and save it
```shell  
[tor]
name=Tor repo
enabled=1
baseurl=http://deb.torproject.org/torproject.org/rpm/el/7/$basearch/
gpgcheck=1
gpgkey=http://deb.torproject.org/torproject.org/rpm/RPM-GPG-KEY-torproject.org.asc

[tor-source]
name=Tor source repo
enabled=1
autorefresh=0
baseurl=http://deb.torproject.org/torproject.org/rpm/el/7/SRPMS
gpgcheck=1
gpgkey=http://deb.torproject.org/torproject.org/rpm/RPM-GPG-KEY-torproject.org.asc
```
  
If you want to install tor in your other versions of fedora or centos or redhat, check the following table.
```shell
fedora 19 - fc/19
fedora 20 - fc/20
centos 6 - el/6
```
And reaplace "el/7" in the repo file with the corresponding one. (If you have Centos 7, then you don't need to replace it - obviously )
    
> Important Note<: If you have epel.repo enabled in your system, then you should open that file( /etc/yum.repos.d/epel.repo) and edit it to add the following line to it.<br /> Exclude=torSave the file.
  
Once the repo file is in position, we can simply install it by issuing
```shell
sudo yum install tor
```
    
Once the installation is finished, we can start the service by typing this command
```
tor
```

