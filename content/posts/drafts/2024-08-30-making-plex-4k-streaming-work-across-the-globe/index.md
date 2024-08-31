---
title: "Making Plex 4k streaming work across the globe"
description: ""
author: Mansoor
date: 2024-08-30T23:34:35.840888
lastmod: 2024-08-30T23:34:35.841289
draft: true
url: /blog/plex-4k-streaming-across-the-globe
images: []
---
## Background

I have a Plex server, I want to share that with my friends and family

## 1st attempt : Simply host the Plex server and expose it directly + reverse proxy

This is the simplest solution. I have the Plex server running on an old Mini PC in my home
network. I have a Digital Ocean VPS acting as a reverse proxy so that I don't have to expose
my home IP directly to the internet. 

If you are interested in reading more about it, I have a post explaining how I expose my selfhosted
services to the internet, [HERE](https://esc.sh/blog/expose-selfhosted-services-to-internet/)

It worked great for people who live close to me.

## The Problem

I currently live in North America and most of my friends and family live across
the planet, in Asia.  But streaming 4k is a problem due to the distance.

Of course, you can't beat physics, packets cannot travel faster than light. But latency
is not really a problem for streaming, unstable network is. One of the biggest
factor of an unstable network is poorer routes the packets take when traveling such a long
distance. All routes are not created equal, some are more congested and experience network
problems including packet loss.

## Potential Solutions

Well, just use a CDN, right? Yes, sort of. Let's talk about it

### What about Cloudflare free tier?

Can't use it for video streaming. It is against the TOS and you could get your account banned

### What about a paid CDN?

I am okay with paying a reasonable amount a month for this selfhosting hobby. Take a look at Fastly
pricing for just 1TB a month

![Fastly CDN Pricing](./fastly-pricing.png)

I am not paying $150 a month for this. 

## My Solution : Build a poor man's CDN

The reason why streaming over such distance sucks is because the routes it usually takes is pretty bad.
It goes through several ISPs and some of them could be pretty congested. A solution is to rely on a
Cloud provider that will take care of that route issue and have two virtual machines. One in North America
and the other in Asia.

Let me explain

![Plex CDN](./plex-diagram-dark.png)