---
author: Mansoor A
categories:
- Quick Notes
- Ops
date: "2020-04-19T09:27:56Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/04/iptables.png
summary: A quick hack to block specific DNS queries like metadata.google.internal
  coming to a VPN server
tags:
- Quick Notes
- Ops
title: Blocking specific DNS queries in a VPN using iptables
url: blog/blocking-specific-dns-queries-using-iptables
---


## Backstory

I have a VPN running on a VM in Google Cloud and had recently came across  a problem of `metadata.google.internal` is getting resolved to the link-local address. `metadata.google.internal` is used by applications running in Google Cloud to read information about the host.

But the problem is, if you are developing applications that uses this `metadata.google.internal` to check if the app is running on the Google Cloud platform, this could cause problems when you are on the VPN.

## The Hack

One of the hack that I was successful in implementing was to use iptables to redirect these requests to the Google public resolver.

Here is the rule:

```
iptables -t nat -A PREROUTING -i tun0 -p udp --dport 53 -m string --hex-string "|08|metadata|06|google|08|internal|" --algo bm -j DNAT --to-destination 8.8.8.8:53
```

make sure to change the interface to the correct one.

To block any other domain, just change the string in this format:

`|number of following characters|the domain part|`

Example:

If you want to block `foo.bar.in`, it would be `|03|foo|03|bar|02|in|`

You get the idea.

> Note: I am redirecting these requests to 8.8.8.8 because they will reply with "NXDOMAIN" which should be the ideal case

