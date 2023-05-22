---
author: Mansoor A
categories:
- HomePage
- Ops
date: "2016-10-15T00:07:00Z"
description: ""
draft: false
tags:
- HomePage
- Ops
title: '[SSHUTTLE] SSH tunneling made simple'
url: blog/ssh-tunneling-made-simple
---


### Why SSH Tunnel?
Consider the situation you are in a network you don't trust, like a coffee house. You never know who is snooping around the network for any kind of information they can collect.  Or you are in a corporate network where the service you need is disabled in the network level, like spotify, or even steam. To make it worse, you do not have access to a VPN either.  What do you do? Well, if you have an SSH account in a remote server, that could serve you well in this situation

### What is an SSH Tunnel?
Using an SSH tunnel, you are creating an encrypted channel, or tunnel between your local machine and the remote server. Everything between your local machine and the server is encrypted and therefore no one in the local network can see what you are sending. From your network admin's perspective, you are just communicating with a remote server over SSH.  

It does not matter what kind of services/ports are blocked in the local firewall. As long as the SSH port is open, you should be able to get around any kind of firewall restrictions using SSH tunnel.  

### How to do that?
Enter `sshuttle`. It is a simple and humble tool that can be used to make ssh tunneling  a lot simple. 
> Note: One thing to make sure is that there are no firewalls in the remote server that is blocking your local requests
> For example, if the port 80 is blocked in the remote server's firewall, you won't be able to browse the web using the tunnel
> you created. Keep this in mind. Disable the firewall in the remote server or open up the ports required.

### Installing sshuttle
Issue one of the following command depending on your machine  

#### On Mac OS X
```
pip install sshuttle
```

#### Ubuntu/Debian
```
sudo apt-get install sshuttle
```

#### Centos/RHEL
```
sudo yum install sshuttle
```

### Starting the Tunnel
To start the tunnel, run the following command in your terminal
```
sudo sshuttle -r username@remoteserver 0.0.0.0/0 -vv
```
Replace username with your username and "remoteserver" with the hostname or IP address of your remote ssh server.
The tunnel should start in a few moments.

Once the connection is started, you can verify if your traffic is being tunneled through the server by checking your public IP address.
Enter the following in another  terminal window
```
curl ipinfo.io
```
You should see your server's IP address.
You're all set. Have fun.

