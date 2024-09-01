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

I currently live in North America, while most of my friends and family are on the other side of
the planet, in Asia.  Streaming 4k media over such a long distance is challenging

Of course, you can't beat physics, packets can't travel faster than the speed of light. However, latency isn't the main issue for streaming; network stability is. One of the biggest factors contributing to an unstable network is the poor routes that packets take when traveling such a long distance. Not all routes are created equal—some are more congested and prone to network problems, including packet loss.

## Potential Solutions

Well, just use a CDN, right? Yes, sort of. Let's talk about it

### What about Cloudflare free tier?

Cloudflare's free tier seems like an obvious choice, but it can't be used for video streaming. Doing so violates their Terms of Service, and you risk getting your account banned.

### What about a paid CDN?

I am okay with paying a reasonable amount a month for this selfhosting hobby. Take a look at Fastly
pricing for just 1TB a month

![Fastly CDN Pricing](./fastly-pricing.png)

I am not paying $150 a month for this. 

## My Solution : Build a poor man's CDN

The reason streaming over such long distances can be problematic is that the routes often taken by the packets can be pretty bad. The traffic goes through several ISPs, and some of these routes can be quite congested. A potential solution is to rely on a cloud provider that can help mitigate these routing issues by setting up two virtual machines—one in North America and one in Asia.

### What makes a traffic between two Cloud VMs better

When we route between Cloud VMs, the packets between the VM in Asia and the VM in the US takes a much better
route which reduces the chances of congestion, offers better latency and offers a stable streaming experience.
This is because cloud providers usually have direct peering agreements and connections with major backbone providers.
As a result, even if the packets are not going through their own "private network", they are still routed through 
more reliable connections compared to if we were to route directly between two home ISPs

### What size Cloud VM do I need?

Honestly, if you will be doing only a few streams simultaneously, you can go with the smallest possible size.
The limit that matters it how much bandwidth it comes with

### Alright, which Cloud Provider?

I have personally used Google Cloud, Digital Ocean and Linode.

#### Google Cloud

**Pros**

Google Cloud offers global VPC (virtual private cloud), which means we can create a VM in Asia and one in US
both in the same private software defined network

Example: 
- 10.0.1.2 : asia-vm
- 10.0.1.3 : us-vm

Now we can connect the asia-vm directly to 10.0.1.3, which ensures that all the traffic remains within Google's
internal network which offers the best case scenario for our streams compared to a public route.

**Cons**

Google Cloud is great if you don't plan on streaming a lot. They offer free network egress for up to 200GB per month.
However, if you want to go above that, you will start spending some good money. Around `$0.12` per GB. 
That comes around to $120/TB. Again, that is too expensive for just the network egress for a homelab

#### Digital Ocean and Linode

I put both of them under the same umbrella because they feel more or less the same. 

- Digital Ocean offers 1TB network transfer per month for $6/month
- Linode offers 1TB transfer per month for $5/month

I initially used Digital Ocean and now trying Linode. I have no data to say one is better than the other.
However, anecdotally, I feel like Linode has better network performance. Don't quote me on this, I have no
proof.

## The Setup

It is very straight forward. Two VMs in the two geographic regions running Nginx. Using Route53 for DNS to have
latency based routing

![Plex CDN](./plex-diagram-dark.png)

### Route53 for latency / geolocation based routing

My plex domain is `plex.example.com`. This domain's DNS is handled by AWS Route53. Through the magic of latency based routing in AWS Route53, the domain `plex.example.com` will resolve to different IPs depending on where the client is.


