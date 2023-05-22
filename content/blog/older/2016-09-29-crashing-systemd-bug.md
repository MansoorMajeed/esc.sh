---
author: Mansoor A
date: "2016-09-29T00:07:00Z"
description: ""
draft: false
title: Crashing systemd in one command by any user in the system
url: blog/crashing-systemd-bug
---


This post is in no way aimed at bashing systemd. It simply demonstrates a simple but crazy bug in systemd that could cause so much trouble for the sysadmins.

```
NOTIFY_SOCKET=/run/systemd/notify systemd-notify ""
```

Run the above command on a systemd machine, by *any* user and you will cause a DOS on that machine. 
Without getting much into the technical aspects of the bug, I'll demonstrate what actually happens if someone run the above command.  

Check this out:

I'm running the command on a Linux Mint 18 machine, which uses systemd. 
![Systemd 1](https://cdn.esc.sh/jekyll/systemd/systemd-bug-1.jpg)

And there. You can no longer restart any services, or not even reboot the system. This is what happens when you try to reboot or restart any services.

![Systemd 1](https://cdn.esc.sh/jekyll/systemd/systemd-bug-2.jpg)

The serious thing about this bug is that any user on a system can do this and that will cause a lot of problems ( if that wasn't so obvious :D ). 

For more technical information about the bug, go here [https://www.agwa.name/blog/post/how_to_crash_systemd_in_one_tweet](https://www.agwa.name/blog/post/how_to_crash_systemd_in_one_tweet)

The guy who discovered this vulnerability ( yes, I'd call this a security vulnerability ) has already opened the issue in systemd gitub page.  
You can see the status of the bug here : [https://github.com/systemd/systemd/issues/4234](https://github.com/systemd/systemd/issues/4234)

