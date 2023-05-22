---
author: Mansoor A
categories:
- HomePage
- Ops
date: "2016-10-28T00:07:00Z"
description: ""
draft: false
tags:
- HomePage
- Ops
title: Pritunl - Easiest way to setup OpenVPN
url: blog/pritunl-easy-openvpn-management
---


Setting up OpenVPN on your own server can be real pain in the a**. I know a lot of you would agree with me there. 
Today, I'll show you guys how to setup OpenVPN and manage users without any hiccups. I don't think this can get any easier. Enter `Pritunl`. You install a few packages and you're done. You have a fully functional VPN server with a web interface where you can manage your users, servers, organizations etc.

### What is Pritunl?
Pritunl is a distributed enterprise vpn server built using the OpenVPN protocol. It is free and open source. For more information, go to [Pritunl.com](https://pritunl.com)


### How to setup Pritunl in your VPS
Pritunl should work on any Linux Distro. But, I'd advice you to use Ubuntu 14.04. 
For this setup, I have a 512MB DigitalOcean VPS running Ubuntu 14.04. Let's get started

#### Installing the required packages
**If you're using anything other than Ubuntu 14.04, go to [https://github.com/pritunl/pritunl](https://github.com/pritunl/pritunl) 
And follow the instructions corresponding to your distro, install the packages and continue with this article.**

If you are using an Ubuntu 14.04 machine, Open a Terminal and issue the following commands one by one. 

```
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
echo "deb http://repo.pritunl.com/stable/apt trusty main" > /etc/apt/sources.list.d/pritunl.list

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 42F3E95A2C4F08279C4960ADD68FA50FEA312927
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get update
apt-get install pritunl mongodb-org
service pritunl start
```
And, that should install and start the Pritunl server on your VPS.

#### The initial setup
* Once the installation is finished, go to `https://your-server-ip`. You can use the command `curl ip.esc.sh` to get the public IP of your VPS.  
You will get a warning from your browser sayin that the connection is insecure, you can safely discard this warning as this is caused by the self signed certificates being used by pritunl. 
* Run the command `pritunl setup-key` in the VPS and copy the setup key. Paste it in the web interface. Leave the mongodb url as it is and click save

#### Create a Server and User
* Now click on `Servers` and then `Add server` give any name you like, and click "add"
* Now we need to create an organization and a user. Click on `users` --> `Add organization`. Give a name for your organization, and click add.
* Back in the servers tab, click on `attach organization`, and then attach the server to the organization you just created. 

#### Create a user and start the server
* Click on the users tab, and then `Add user`. Give a name for the user, and a pin. This pin is used for the authentication. So, give something strong. For now, i will use "123456".
* Back in `Servers` tab, start the server by pressing "Start server".

#### Final steps
* Download the configuration from the users tab. It should be a tar file. Extract the tar file and you will get a file in the format "organization_user_servername.ovpn". This is the OpenVPN config file we will be using to connect to the VPN server.
* For us to connect to the VPN, we need a vpn client. Go to [https://client.pritunl.com/](https://client.pritunl.com/) and download the vpn client depending on your local machine from where you will be connecting to the VPN. 
* Once you have installed the "pritunl client", open it up. Click on "import profile" and then choose the "ovpn" file we extracted in the previous step. Now click on the three dashes, and click "connect". It will ask you to enter the pin. Enter the pin you used while creating the user.
* Wait for it to connect and there you go. You're now connected to the vpn and all the traffic is now being routed through the vpn.
* You can verify this by visiting this url [ip.esc.sh](http://ip.esc.sh). It should show your VPS's IP address. 

Have fun :D

