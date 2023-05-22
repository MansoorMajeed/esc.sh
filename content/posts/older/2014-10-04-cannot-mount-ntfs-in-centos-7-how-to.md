---
author: Mansoor A
date: "2014-10-04T10:50:00Z"
description: ""
draft: false
title: Cannot mount NTFS in Centos 7? Here's how you will fix it
url: blog/cannot-mount-ntfs-in-centos-7-how-to
---


Yesterday, I installed Centos 7 and when I tried to open one of my partitions, (which is NTFS file system), it showed me an error saying that It cannot mount ntfs file systems. Then I did some research and found a solution, which works great.

So, how would you make your Centos 7 to recognize NTFS hard drives? Her's how you will do it.

First of all, we have to install the "epel" repository in your server.

```shell
yum install epel-release
```

Now that we have the repository in place, all we have to do is install the ntfs-3g package

```shell
yum install ntfs-3g
```

Andd!!, That's it. You're done. Now try opening the NTFS system, and it will mount without any problems.

