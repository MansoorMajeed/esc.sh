---
author: Mansoor A
categories:
- Ops
date: "2018-01-02T00:07:00Z"
description: ""
draft: false
summary: Allowing Let'sEncrypt to do the HTTP validation while enforcing HTTP to HTTPS
  redirection
tags:
- Ops
title: Fixing Letsencrypt renewal errors on SSL only domains
url: blog/letsencrypt-renewal-error
---


### The Problem
As you know, the Letsencrypt certificates are valid only for 90 days and you need to renew them before it expires. Most of us have a cron job that takes care of it using `letsencrypt renew` or `certbot renew`.

I've been using Let's Encrypt for quite some time and never faced any problems with the renewals, ( I use `certbot renew` as a cron job ) until now. The difference this time is that **the domain in this scenario 
had a rule to redirect all http traffic to https.** Now this is a problem because Let'sEncrypt will try to reach your domain to verify the ownership over http which will get redirected to `https` and that would cause problems.

You might have something like this in your nginx conf for the domain
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://yourdomain.com$request_uri;
}
```
which is the culprit.


### The Solution
The solution is quite simple, redirect everything except the Let's encrypt acme challenge (the domain verification request), ie the request made to `http://your-domain.com/.well-known/acme-challenge`. This is how you fix it for good:

First of all, we need to create the challenge directory for Letsencrypt

```bash
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge
```

Then we need to create a small snippet at the location `/etc/nginx/snippets/letsencrypt.conf` with the following content

```nginx
location ^~ /.well-known/acme-challenge/ {
    default_type "text/plain";
    root /var/www/letsencrypt;
}
```

This snippet tells nginx to set the docroot for any request made to `.well-known/acme-challenge` as `/var/www/letsencrypt`.

Now we need to include this snippet in your site's nginx configuration. Most of the time this will be in 
`/etc/nginx/sites-enabled/yourdomain.com`.

Modify your http server block to resemble below

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name yourdomain.com www.yourdomain.com;

    include /etc/nginx/snippets/letsencrypt.conf;

    location / {
        return 301 https://$host$request_uri;
    }
}
```

> NOTE: Please keep in mind that this is only for the `http` server block, whatever you had for your `https` server block should remain the same.

This should do the trick.

