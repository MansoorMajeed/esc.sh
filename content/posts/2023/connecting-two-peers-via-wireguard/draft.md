---
title: "Connecting two peers via Wireguard"
description: "How can we connect two instances, such as from a local laptop to a remote VM via wireguard"
author: Mansoor
date: 2023-31-03T22:32:37-04:00
lastmod: 2023-31-03T22:32:37-04:00
draft: true
url: blog/connecting-two-peers-wireguard
images: []
---
In this post, I will show you how we can connect two peers (any two servers/instances) via Wireguard.
As long as at least one of the peer is able to connect directly to the other one, this should work
even if one of the peer is behind a NAT/firewall that blocks incoming connections.

In this post, I will connect my local laptop to a remote Cloud VM via Wireguard.

## Connecting local machine to a remote Cloud VM

For the sake of simplicity, let us call the Cloud VM the server and the local laptop the client.
>Note: As far as Wireguard is concerned, both partiers are peers.


## Setting up the "server"

First, let us setup the Cloud VM. In my case, it is running in DigitalOcean. The server
has Debian 12.


### Server: Installing Wireguard

Since we are using Debian 12, we can install Wireguard using apt

```bash
sudo apt install wireguard
```

### Server: Configuring

#### Generating keys

```bash
wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey
```

Removing unnecessary permissions from the private key
```bash
sudo chmod 400 /etc/wireguard/privatekey
```

#### Creating the config file

So, on the server, let us create a new config file using your favourite text editor

```bash
sudo vim /etc/wireguard/wg0.conf
```

And add the below
```text
[Interface]
Address = 10.0.0.1/24
SaveConfig = true
PrivateKey = [Server's Private Key]
ListenPort = 51820
```

Make sure to replace the `PrivateKey` with the privatekey we just created, which is located at
`/etc/wireguard/privatekey`

