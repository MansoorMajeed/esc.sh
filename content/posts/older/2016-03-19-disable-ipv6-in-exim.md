---
author: Mansoor A
date: "2016-03-19T22:45:58Z"
description: ""
draft: false
title: How to disable IPv6 in Exim
url: blog/disable-ipv6-in-exim
---


The other day I was just [ seriously, for no apparent reason 😀 ] going through the exim logs in my server and this error caught my eye.

```
ASPMX3.GOOGLEMAIL.com [2a00:1450:400b:c02::1b] Network is unreachable
```

Apparently, IPv6 wasn't configured properly in the server and this was causing issues when trying to communicate with google's IPv6 addresses. There are two ways you can fix this issue. The easy way and the correct way. The correct way would be to configure IPv6 properly ( obviously ). As lazy as I am, I chose the easy way.

Anyway, this is **how you would disable IPv6 in your exim mail server:**

Check if IPv6 is currently enabled. If you see tcp6, then it means IPv6 is enabled. 
```bash
[root@server ~]# netstat -tulpn | grep :25
tcp        0      0 0.0.0.0:25              0.0.0.0:*               LISTEN      23336/exim
tcp        0      0 0.0.0.0:2525            0.0.0.0:*               LISTEN      23336/exim
tcp6       0      0 :::25                   :::*                    LISTEN      23336/exim
tcp6       0      0 :::2525                 :::*                    LISTEN      23336/exim
```

If it is enabled, open exim configuration file ( /etc/exim/exim.conf ) and add the parameter `disable_ipv6=true` 
```
vi /etc/exim/exim.conf
# Add the following
disable_ipv6=true
```

Restart exim and you're done.

