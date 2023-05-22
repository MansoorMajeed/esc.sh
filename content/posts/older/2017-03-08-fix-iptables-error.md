---
author: Mansoor A
date: "2017-03-08T00:07:00Z"
description: ""
draft: false
title: Fixing the weird iptables error
url: blog/fix-iptables-error
---


I am gonna make it short and simple. This issue is something I have seen on so many Debian 7 servers.

### The Problem
It goes like this. You're trying to list your `iptables` rules and you're seeing weird stuff.
```
root@server~# iptables -L
WARNING: Could not open 'kernel/net/netfilter/x_tables.ko': No such file or directory
FATAL: Could not open 'kernel/net/ipv4/netfilter/ip_tables.ko': No such file or directory
iptables v1.4.2: can't initialize iptables table filter': iptables who? (do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
``` 

You go ???? and check if all the modules are installed properly, and they are. But iptables is saying it cannot find the kernel objects.

### The Fix
The fix is as simple as it gets
```
root@server~# depmod
 
root@server~# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```
That's it. A single command `depmod` is all it takes to fix this issue

### The How
How did `depmod` fix the dependency error? Well, that is what depmod do. `depmod` creates a dependecy file which will be then used by modeprobe to load all the modules correctly. By default, `depmod` will probe all the modules and create a dependecy file for all of them, including the iptables module.

