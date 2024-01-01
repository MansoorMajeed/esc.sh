---
title: "Setting up Wireguard VPN"
description: "How can we connect two instances, such as from a local laptop to a remote VM via wireguard"
author: Mansoor
date: 2024-01-01T10:32:37-04:00
lastmod: 2024-01-01T10:32:37-04:00
draft: false
url: blog/wireguard-vpn-setup
images: []
---
In this post, I will show you how we can connect two peers (any two servers/instances) via Wireguard.
As long as at least one of the peer is able to connect directly to the other one, this should work
even if one of the peer is behind a NAT/firewall that blocks incoming connections.

In this post, I will connect a local Virtual Machine to a remote Cloud VM via Wireguard.

> Towards the end of the post, I will also show you how you can route the client's internet traffic via the CloudVM through Wireguard

## Connecting local machine to a remote Cloud VM
For the sake of simplicity, let us call the Cloud VM the server and the local laptop the client.
## Setting up the server

First, let us setup the Cloud VM. In my case, it is running in DigitalOcean. The server
has Debian 12.

If you are not familiar with setting up an instance in DigitalOcean, their docs are pretty easy.
Check it out [HERE](https://docs.digitalocean.com/products/droplets/how-to/create/)

And you can choose these options

- Size : choose the smallest possible under "shared cpu". Should be around $5/month
- Additional storage: You don't need any
- Authentication method: Choose SSH key
- Region: Choose what is closest to you
- Operating system : Debian 12 (or whatever the latest version of Debian is)

### Server: Installing Wireguard

Since we are using Debian 12, we can install Wireguard using apt

```bash
sudo apt update
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
PrivateKey = [Server's Private Key]
ListenPort = 51820
```

Make sure to replace the `PrivateKey` with the privatekey we just created, which is located at
`/etc/wireguard/privatekey`



## Setting up the client

In my case, the client is also using Debian 12

```bash
mansoor@debian:~$ sudo apt update
mansoor@debian:~$ sudo apt install wireguard
```

### Client : Configuring

#### Generating keys

```bash
wg genkey | sudo tee /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey
```

Removing unnecessary permissions from the private key
```bash
sudo chmod 400 /etc/wireguard/privatekey
```

#### Creating the config file


Create a file `/etc/wireguard/wg0.conf` with the config like below

```text
[Interface]
PrivateKey = [Client's Private Key]
Address = 10.0.0.2/32

[Peer]
PublicKey = [Server's Public Key]
Endpoint = [Server's Public IP]:51820
AllowedIPs = 10.0.0.1/32
PersistentKeepalive = 25
```

Ensure the following
- You are replacing the client's private key correctly in the config file
- You are replacing the server's PUBLIC KEY correctly in the config file. You need to copy it from the server we generated in the previous step
- You are replacing `Endpoint` with the server's public IP.

Again, as you can see, we are configuring `AllowedIPs` to be only the server's IP we configured
with wireguard. If you need ALL your client traffic to go through wireguard, you need to change that to
```text
AllowedIPs = 0.0.0.0/0
```


### Server : Updating the server with client public key

This is very important

On the server, now we need to tell it the public key of the client.
Edit the `/etc/wireguard/wg0.conf` on the **server** and add the following

Make sure you place the public key of the **client**
```text
[Peer]
PublicKey = [Public key of the client]
AllowedIPs = 10.0.0.2/32 # This is the IP we gave the client
```

### Server: Bringing it up

We can bring up our VPN server using `wg-quick`. Remember, the name here `wg0` needs to match the name of the config file, that is, `wg0.conf`.

We can also enable it to start on boot using systemd
```bash
sudo systemctl start wg-quick@wg0
# enable it on boot
sudo systemctl enable wg-quick@wg0
```


### Client : Bringing it up

Once the configs are in place, we can start our tunnel with

```bash
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0
```

Check that it has started
```bash
sudo systemctl status wg-quick@wg0
```

## Verifying the connection

### On the server

We can use `sudo wg show` to see the status

```text
mansoor@demo:~$ sudo wg show
interface: wg0
  public key: +SvTJijfLvluSdBwM5o8OZMBBkTA2OCjAxIl6Ms2zTU=
  private key: (hidden)
  listening port: 51820

peer: mBYIhwX3YCO5CxPwfbhGR7rRaKAddm/C3aGQZ4VT/3A=
  endpoint: <public ip of my home network>:52857
  allowed ips: 10.0.0.2/32
  latest handshake: 54 seconds ago
  transfer: 2.36 KiB received, 1.52 KiB sent
mansoor@demo:~$
```

We can also ping the client from the server

```text
mansoor@demo:~$ ping -c 2 10.0.0.2
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=16.3 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=64 time=8.21 ms

--- 10.0.0.2 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 8.212/12.261/16.310/4.049 ms
```

We can see that the server is able to reach the client over the VPN tunnel

### On the client

```text
mansoor@debian:~$ sudo wg show
interface: wg0
  public key: mBYIhwX3YCO5CxPwfbhGR7rRaKAddm/C3aGQZ4VT/3A=
  private key: (hidden)
  listening port: 52857

peer: +SvTJijfLvluSdBwM5o8OZMBBkTA2OCjAxIl6Ms2zTU=
  endpoint: 138.197.67.72:51820   # that is the public ip of my server
  allowed ips: 10.0.0.1/32
  latest handshake: 52 seconds ago
  transfer: 2.98 KiB received, 5.99 KiB sent
  persistent keepalive: every 25 seconds
mansoor@debian:~$
```

Let's try a ping as well

```text
mansoor@debian:~$ ping -c 2 10.0.0.1
PING 10.0.0.1 (10.0.0.1) 56(84) bytes of data.
64 bytes from 10.0.0.1: icmp_seq=1 ttl=64 time=14.5 ms
64 bytes from 10.0.0.1: icmp_seq=2 ttl=64 time=16.7 ms

--- 10.0.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 14.468/15.582/16.696/1.114 ms
mansoor@debian:~$
```

Great, that works too.


## [ONLY IF YOU NEED IT] Sending the client's internet traffic via Wireguard


So far we created a "tunnel" between our local VM and a remote server.

If **you want to route all the traffic** from the client via the Wireguard VPN (so that it will go out to the internet via your CloudVM), we need to make some changes.

### On the server

You will need to edit `/etc/sysctl.conf` to ensure `net.ipv4.ip_forward=1` is uncommented.
and apply the changes with
```bash
sudo sysctl -p
```

#### Server : Stop Wireguard

> Note: This is important! Stop wireguard first on the server before proceeding

```bash
 sudo systemctl stop wg-quick@wg0
```

#### Server: Update the config

And update the `wg0.conf` on the server. and add the following under the `[Interface]`

```text
PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PostUp = iptables -A FORWARD -i %i -j ACCEPT
PostUp = iptables -A FORWARD -o %i -j ACCEPT
PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
PreDown = iptables -D FORWARD -i %i -j ACCEPT
PreDown = iptables -D FORWARD -o %i -j ACCEPT
```

so, on the server, the full config looks something like this
```text
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = eWEgc25lYWt5LCB3YXRjaGEgZG9pbiBoZXJlPz8/

PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PostUp = iptables -A FORWARD -i %i -j ACCEPT
PostUp = iptables -A FORWARD -o %i -j ACCEPT
PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
PreDown = iptables -D FORWARD -i %i -j ACCEPT
PreDown = iptables -D FORWARD -o %i -j ACCEPT

[Peer]
PublicKey = mBYIhwX3YCO5CxPwfbhGR7rRaKAddm/C3aGQZ4VT/3A=
AllowedIPs = 10.0.0.2/32
```


and finally restart

```bash
 sudo systemctl restart wg-quick@wg0
```

### On the client

All we have to do is edit the `AllowedIPs` under `/etc/wireguard/wg0.conf`

Make it so that :
```text
AllowedIPs = 0.0.0.0/0  # Send all traffic via Wireguard
```

The full config looks like this

```text
mansoor@debian:~$ sudo cat /etc/wireguard/wg0.conf
[Interface]
PrivateKey = aHR0cHM6Ly95b3V0dS5iZS9kUXc0dzlXZ1hjUQ==
Address = 10.0.0.2/32

[Peer]
PublicKey = +SvTJijfLvluSdBwM5o8OZMBBkTA2OCjAxIl6Ms2zTU=
Endpoint = 138.197.67.72:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25

mansoor@debian:~$
```

> Note: go ahead and hack me with those exposed private keys :(

Restart WireGuard
```bash
sudo systemctl restart wg-quick@wg0
```

Verify that the connection is working
```text
mansoor@debian:~$ sudo wg show
[sudo] password for mansoor:
interface: wg0
  public key: mBYIhwX3YCO5CxPwfbhGR7rRaKAddm/C3aGQZ4VT/3A=
  private key: (hidden)
  listening port: 37044
  fwmark: 0xca6c

peer: +SvTJijfLvluSdBwM5o8OZMBBkTA2OCjAxIl6Ms2zTU=
  endpoint: 138.197.67.72:51820
  allowed ips: 0.0.0.0/0
  latest handshake: 1 minute, 59 seconds ago
  transfer: 2.27 KiB received, 5.12 KiB sent
  persistent keepalive: every 25 seconds
```

### Testing internet access

At this point, the client VM is sending all the traffic via the VPN (the CloudVM)
We can verify this by checking the client's public IP

```text
mansoor@debian:~$ curl ip.esc.sh
Your IP : 138.197.67.72
mansoor@debian:~$
```

As you can see, the client VM now have the server's public IP, which means we are tunneling
all the traffic via the CloudVM
