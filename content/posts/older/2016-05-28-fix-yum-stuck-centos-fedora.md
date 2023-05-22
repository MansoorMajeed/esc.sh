---
author: Mansoor A
date: "2016-05-28T20:57:40Z"
description: ""
draft: false
title: Fix YUM getting stuck - Centos 6/7
url: blog/fix-yum-stuck-centos-fedora
---


Some times it happens.  You were trying to install something and Yum gets stuck. No error messages,
it's just stuck. After you do several Ctrl+C, you're back in the shell. But, yum is still not working
as it should. There could be several reasons why it happens, and the fixes are pretty simple. 

> Applicable to : Centos 6/7, Fedora

* Check if you have the DNS set properly in your server. You can try something like   
`ping www.google.com`  
If you are getting a response, your DNS is working fine. If not, check the `/etc/resolv.conf` file
Add the following in it ( if not already exists )

```bash
nameserver 8.8.8.8
```

Now try again. If it still does not work, check step 2

* Clean and rebuild the RPM databases
```bash
rm -f /var/lib/rpm/__*
rpm --rebuilddb -v -v
yum clean all
```

It should work now. If you're still facing issues, it's probably the firewall. Check your firewall rules
and make sure that the server can contact the remote repositories.

