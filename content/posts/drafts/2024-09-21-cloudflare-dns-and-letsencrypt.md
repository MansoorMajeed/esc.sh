---
title: "Cloudflare DNS and Letsencrypt"
description: ""
author: Mansoor
date: 2024-09-21T13:26:02.204461
lastmod: 2024-09-21T13:26:02.204482
draft: true
url: /blog/cloudflare-dns-and-letsencrypt
images: []
---

apt install python3-certbot-dns-cloudflare
certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.cloudflare-cred.ini -d over.ex.digitz.org
