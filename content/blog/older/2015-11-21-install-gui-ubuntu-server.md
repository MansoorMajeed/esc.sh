---
author: Mansoor A
date: "2015-11-21T17:22:00Z"
description: ""
draft: false
title: How to install GUI (X-Server) on Ubuntu Server
url: blog/install-gui-ubuntu-server
---


The thing about Linux servers is that, they don't come with a GUI for obvious reasons, including but not limited to "to conserve resource usage". I mean, you don't want your X server to be eating up all your RAM and CPU, do you?

So the question comes, do you need  a GUI (X11 server ) on your Linux server ( Ubuntu /Centos / Whatever )? If you ask me, my answer would be "HECK NO!!". Well, it's just my opinion. So, for some weird reasons ( or you're  a newbie and you are scared of the command line ) you wanted to install a graphical user interface to your Ubuntu server, this is what you should do

This tutorial applies to : Ubuntu 12.04/14.04/15.04/16.04, well, basically any modern version of Ubuntu. 😉

### How to install GUI on your Server

If you want the original Ubuntu desktop feel, then install this

```shell
sudo apt-get install ubuntu-desktop
```

But, let me remind you one thing, Ubuntu's default desktop ( Unity ) is going to use a Lot of resource. If I were you, I'd install a lightweight desktop environment. LXDE is such a lightweight desktop. You can install LXDE using the following command

```shell
sudo apt-get install lxde
```

Basically, this is all you need. But if you need to run some desktop applications, you'd probably need some other packages too.

```
# Java run time environment
sudo apt-get install openjdk-7-jre 

# and webkit gtk library
sudo apt-get install libwebkitgtk-1.0-0
```

Well, that's it. Now, logout and log back in. You should be able to see your new Desktop.

