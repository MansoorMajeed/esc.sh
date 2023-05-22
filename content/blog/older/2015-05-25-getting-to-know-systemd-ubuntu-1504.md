---
author: Mansoor A
date: "2015-05-25T17:08:00Z"
description: ""
draft: false
title: 'Getting to Know Systemd : Ubuntu 15.04+ / Centos 7+, How to manage your system
  using systemd'
url: blog/getting-to-know-systemd-ubuntu-1504
---


Well, systemd is here. But, why should you care? If you're going to use ubuntu 15.04+ or Centos 7, you're gonna need systemd.
Because these operating systems use systemd rather than init. Before we get into how to use systemd,
we should have a basic idea about what it is. Systemd is a suite of daemons, libraries and utilities 
designed as a central management and configuration platform for the Linux computer operating system.
There is a reason why you're here, either you want to Learn about systemd or you just want to know how to get things done using systemd.
The latter one is the most probable one. Let's get started then.
              
### Listing Services:
To list all the services in your system, just use the command:              
```shell
systemctl list-units --type service
```
You can also do a `systemctl --help` to display a brief list of supported commands.            
This would display the currently loaded services.
            
### Displaying the status of a service
In init systems, we would simply do "service <name> status" to see the status of a service.
But, here things are a bit different. You'd do it as follows.  
```shell
systemctl status name.service
```
For example, if you wanted to know if sshd is running, you could use the following command.
```shell
systemctl status sshd.service
```          
This would show something like this. Pretty detailed than init, huh?

![Systemd 1](https://cdn.esc.sh/jekyll/systemd/systemd_centos.png)

> Note: One thing to be noted that, as of now, even if you use the old "service sshd status" command, it would work.
> The system would just redirect the command to systemd. But, it is better to start using systemd rather than "service" itself.
          
### How To Start / Stop A Service Using Systemd
Yep, you guessed it right. To start the service, just use the following.
        
This would start the service "name"
```shell
systemctl start name.service
```

**Example: To start sshd**
```shell
systemctl start sshd.service
```

#### To stop a service
```shell
systemctl stop sshd.service
```
This ain't so difficult, is it? All ok, but what about chkconfig? Do we still have that?<br /> Well, continue reading.. 
          
### Enable or disable a service on boot
If you want a service to be started automatically on boot, you would use this:
      
#### Enable a service
```shell
systemctl enable name.service
```
##### Example: This would enable sshd to start on boot
```shell
systemctl enable sshd.service
```

#### To disable a service on boot
```shell
systemctl disable name.service
```
      
But wait, there's more.
      
### Masking a service
This is an interesting thing. You can mask a service. What happens if you mask a service? 
Well, if you mask a service, no one can start the service. When you mask a service, system 
replaces the `/etc/systemd/system/name.service` file with a symbolic link to `/dev/null` ( The Linux blackhole  ).
    
#### How to mask a service using systemctl
```shell
systemctl mask name.service
```

#### To unmask it
```shell
systemctl unmask name.service
```
Well, I guess that's it for now. If you guys have any doubts, or opinion, leave a comment and I will try to respond to that. Thank you all.

