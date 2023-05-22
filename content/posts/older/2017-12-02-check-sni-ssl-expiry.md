---
author: Mansoor A
categories:
- Quick Notes
date: "2017-12-02T00:07:00Z"
description: ""
draft: false
summary: 'When using openssl to connect to a server that''s using SNI, you need to
  use the servername option '
tags:
- Quick Notes
title: Checking SNI SSL certificate expiry in Linux/Mac
url: blog/check-sni-ssl-expiry
---


### The Problem
This is how we *normally* check the expiry of an SSL certificate
```
echo | openssl s_client -connect your-domain-name.com:443 2>/dev/null | openssl x509 -noout -dates
```
This is all fine and dandy if you have only one SSL domain hosted in the same IP address. If you try to check the SSL expiry of another domain in the same server, it will show the expiry of the default one and this can lead to unintended consequences. The free SSL provider Letsencrypt uses SNI and I have faced the same issue trying to check the expiry of a domain.

### The Solution
The solution is very simple. Just use the `-servername` switch in the `openssl` tool. Like this.
```
echo | openssl s_client -connect yourdomain.com:443 -servername yourdomain.com 2>/dev/null | openssl x509 -noout -dates
```

