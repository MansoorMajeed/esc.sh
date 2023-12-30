---
title: "How I expose my selfhosted services to the Internet"
description: "In this post I explain how I expose the services that are hosted on my local network on a laptop to the Internet so that it is publicly accessible in a safe manner"
author: Mansoor
date: 2023-12-27T22:32:37-04:00
lastmod: 2023-12-27T22:32:37-04:00
draft: true
url: blog/selfhosting/how-i-expose-local-services-to-internet
categories: ["SelfHosting"]
images: []
---

## My Setup

I have an old ThinkPad laptop running Debian 12 that is hosting some services that I use
on a daily basis. I also use the same laptop to host some internet facing services. That is,
it should be accessible to everyone on the internet. And this is the setup I came up with
which seem to be a good tradeoff between cost, complexity and security.

## Common ways to expose a service to the Internet

First let us address some of the common ways to expose a service to the Internet


### Port Forwarding

Port forwarding is when you configure your router to redirect requests from the internet to a specific machine in your local network.

**Pros**:
- Fairly easy to set up
- Direct access, no added cost

**Cons**:
- Huge security risk : It exposes your local network directly to the internet.
- Privacy concerns : Your home IP address is exposed. You can use services such as cloudflare to get slightly better protection
- Need for Dynamic DNS : Since your ISP probably uses dynamic IP address, you need to setup something to map a DNS address to your current IP address

**My advice**:
I personally recommend that you skip this option unless you know exactly what you are doing

### Using a traditional/Mesh VPN

While using a VPN is not directly exposing a service to the internet, I'm mentioning it because there are folks who just want to access their services while away from home. The VPN setup means creating a secure tunnel from the internet to your local network, effectively making your remote device part of the local network.

**Pros**:

- Very secure as long as you don't lose your VPN configuration
- Fairly easy to set up
- Privacy friendly

**Cons**:
- Public internet users cannot access your service if you want them to.
- Complicated (Unless you use Tailscale, then it cannot be any simpler)


**My advice**: If all you need is to access your self hosted services on your own devices, just use [TailScale](https://tailscale.com/) and do nothing else. But of course, keep reading for educational purposes

### Tunneling services

Services like Cloudflare Tunnel and Ngrok offer easy ways to expose your local services to the internet. 


**Pros**:
- Very easy to setup
- Secure

**Cons**:
- Thirdparty services, less flexibility


**My advice**: If you want a fairly easy setup, but are willing to trade privacy and flexibility, I suggest [Cloudflare tunnel](https://www.cloudflare.com/products/tunnel/)
But if you are willing to put a little bit  more effort, I suggest you try the method
I use, which is explained below.

## How I Expose my services to the Internet

TL;DR : I have a Cloud virtual machine running Nginx that acts as a reverse proxy. I have a Wireguard
server on the Cloud VM. My ThinkPad laptop connects to this CloudVM via Wireguard. The Nginx reverse
proxies directly to the VPN interface. I use Docker to run all of the services

Here is a simplified diagram showing how it fits together

![SelfHosting Setup Diagram](selfhosting-setup.png)

**Pros**:
- Secure
- Very flexible
- Private
- Does not depend on a third party
- It's fun

**Cons**:
- You gotta pay $5 a month at least
- A bit more involve setup

## How to set it up

For this example, I will use my laptop to host a simple web service and then I will
use my Digital Ocean VM to expose it to the internet, with SSL and everything.
You can replicate the same example with slight modifications for any sort of service.

### Step 1 : Let's host a simple service locally

I have a simple demo app [HERE](https://github.com/MansoorMajeed/go-hello-world), I am going to use that.

I assume you have Docker setup and running, if not, it does not matter how you host your service,
it just have to be listening on a local port.

In my case, I am going to start my demo application

```bash
docker run -p 8080:8080 mansoor1/go-hello-world
```
Once that is running, from the same machine (in my case it is my laptop), I can access this service
```
➜  ~ curl localhost:8080
Hello from: dc886e373e2b
Current Time: Sat, 30 Dec 2023 21:21:16 UTC
```

Great! So we have our service running locally

### Step 2 : Setting up our CloudVM

For this, you will need a Cloud VM. I personally recommend DigitalOcean or Linode.
We only need the smallest possible instance since the server will be using only
minimal stuff. You can even sign up for a AWS free account or Google Cloud trial.

For this, I will  use a DigitalOcean VM I already have.


