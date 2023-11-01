---
title: "How I expose my selfhosted services to the internet"
description: "I have a local server (an old thinkpad laptop) that hosts a few services. This is how I expose them to the internet"
author: Mansoor
date: 2023-10-01T00:32:37-04:00
lastmod: 2023-10-01T00:32:37-04:00
draft: true
url: blog/exposing-selfhosted-services-to-internet
images: []
---
## Background

> Feel free to skip this section if you don't feel like reading it.

You have started to self host a service or two (Jellyfin/Plex for example), and you want to expose them over the internet. There are a number of ways you can go about it


### 1. Use Port Forwarding

#### The Good

- It is very easy to set up
- Works with almost any router and does not require extra services/hardware etc

#### The Bad

- It has the potential to accidentally expose local services to various threats if not setup correctly
- Sort of cumbersome to map different ports for different services
- Potentially exposing your public IP to the internet which can be a privacy concern

### 2. Use a VPN

If you are the only person who will be using your services and you have a small number of services where
you can configure the VPN, this may be the safest option.

#### The Good

- 