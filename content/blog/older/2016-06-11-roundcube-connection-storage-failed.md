---
author: Mansoor A
date: "2016-06-11T11:07:00Z"
description: ""
draft: false
title: Fix 'Roundcube - Connection to storage server failed' error
url: blog/roundcube-connection-storage-failed
---


This is going to be a very short post. I faced this issue on a Plesk server. All of a sudden ( it was after a reboot ), Roundcube stopped working. No matter what you do, this is the error you get

> Connection to storage server failed

Not very helpful, I know. This is a generic error, there could be a 100 reason why it happens. But, if this happened all of a sudden, then it must be easy to fix.

### Make sure that dovecot is running
```
/etc/init.d/dovecot status
```

If it isn't, restart it
```
/etc/init.d/dovecot restart
```

Yeah, I know, the classic, "did you try restarting the service?" It could help someone.
But the actual issue I faced was "SELinux". Every freaking time. :D 

### Set SELinux to "Permissive"
This was the real culprit in my case. I guess SELinux wasn't configured properly for roundcube. 
```
setenforce 0
```

This will set SELinux to Permissive. This should fix the issue, in most cases. If it does not, then, well, dig deep. Have fun :D

