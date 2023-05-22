---
author: Mansoor A
date: "2015-10-04T14:57:44Z"
description: ""
draft: false
title: How to setup OpenVPN to browse internet securely - The easy way
url: blog/setup-openvpn-easyway
---


Setting up OpenVPN can be such a pain. I had a really hard time trying to figure out what went wrong. I set up everything correctly, the connection between the client and the server is getting established, but alas, I (the client) don't have internet access. I spent a lot of time figuring out what might be the issue, then I stumbled upon "OpenVPN Access Server". All It took was 1 minutes to setup everything. No kidding. I was able to connect to the server without any issue at all.

Today, I'll show you guys how to set up openvpn under a minute.

### **Things you need**

  1. A VPS running any Linux Distro ( RedHat 5/6/7, Ubuntu 12.04/13.04/14.04 or any other version, Centos 6.x/7.x, Fedora, Debian, OpenSuse, you name it)
  2. SSH Access to the VPS
  3. I think that's it 😉

### Let's get started

#### Step 0: Open the required ports in the firewall

If you forgot to open thses ports, well, you won't be able to connect to them. So, make sure you have ports "1194, 943" open.

#### Step 1: Installing the required packages:

Go <a href="https://openvpn.net/index.php/access-server/download-openvpn-as-sw.html" target="_blank">HERE</a> and click on the package corresponding to your operating system in the VPS. Since I am setting this up on an Ubuntu 14.04 server, I will click on the Ubuntu icon, in the next page, you will be presented with different versions of the Operating system. Right click and copy the link to download the file.

Login to your server using SSH. Switch to root using "sudo su -" and download the package using wget. Please make sure that you have downloaded the package corresponding to the VPS's OS.

```
wget http://swupdate.openvpn.org/as/openvpn-as-2.0.20-Ubuntu14.amd_64.deb
```

Now that you have downloaded the corresponding package, let's install it.

#### For Ubuntu and other derivatives:

Use the following command to install the package. Remember to replace the filename with the one you have downloaded.

```
dpkg -i openvpn-as-2.0.20-Ubuntu14.amd_64.deb
```

Wait for the installtion to finish

#### For RedHat/CentOS and other related OSs:

```
rpm -Uvh openvpn-as-2.0.20-CentOS6.x86_64.rpm
```

That's it, the packages should install in a couple of seconds. Once that's done,

### Setup password for the "openvpn" user:

By default "openvpn" is the admin user. You have to change the password for this user. To change the password for "openvpn", use the passwd command.

```
passwd openvpn
```

It will ask you to enter a new password. Choose a strong password. You know the drill.. 😉

### Add a new client to use the VPN service:

Now let us create a new user using which we will connect to the VPN from your computer.

```
adduser vpnuser
```
It will ask you to enter the password, and some other info.
only the password is needed, and you can keep pressing the enter key for other values

The user is now created. You can access the OpenVPN Access Server admin area by visting `https://your-server-ip:943/admin`

Login using the username "openvpn" and the password you have specified previously. Once you have set the options ( only if you want to, the default settings just work fine ), You can access the user panel and download the .ovpn config file which will be used to connect from the client.

### Getting your client profile to use with the VPN client:

Visit `https://your-server-ip:943` in a browser and login with the username "vpnuser" and the password you have specifed in the previous step.
Now, you can see that there is an option to download the user profile.

![OVPN](https://cdn.esc.sh/jekyll/posts/random/ovpn4.png)

Click on it, and you will get a "client.ovpn" file. This is the conf file with all the certificates and stuff. Copy this file to your desktop.

### Connecting to the VPN server:

#### Linux Users:

You have to install the openvpn client. It's in the default repository. So, you can install it very easily.

```
# For ubuntu and other derivatives
sudo apt-get install openvpn

# For Centos and other rpm based OSs
sudo yum install openvpn
```

Once the client is installed, you can connect to the VPN server using the following command.

```
cd ~/Desktop
sudo openvpn --config client.ovpn
```

That's it, you should get connected to your VPN in a matter of seconds

#### Windows Users:

You can download the OpenVPN client from <a href="https://openvpn.net/index.php/open-source/downloads.html" target="_blank">HERE</a>. Download it, and load the config file to the OpenVPN client, click on connect and you should be good to go. It's simple as that.

