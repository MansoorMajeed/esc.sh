---
author: Mansoor A
date: "2016-06-28T11:07:00Z"
description: ""
draft: false
title: Better RDP client for Fedora and Ubuntu
url: blog/remmina-ubuntu-fedora-rdp
---


The other day, I had to use RDP to connect to a customer's Windows Server 2012. I use a Linux Workstation, so normally, I use "rdesktop" to get things done. But, this time, when I did `rdesktop 95.x.x.x` I got the following error.

```
root@localhost ~ # rdesktop 95.xx.xx.xx                            
Autoselected keyboard map en-us
Failed to connect, CredSSP required by server.
```

I tried a quick google search and the results suggested me to uncheck "Allow connections only from computers running Remote Desktop with Network Level Authentication (recommended)" in the remote server.
I need to access the server to do that, don't I? :D  

The solutio is pretty simple, use "Remmina", a better RDP client.

### Install Remmina On Ubuntu 12.04 and above
It should work any Ubuntu version from 12.04 to 16.04.
```
sudo add-apt-repository ppa:remmina-ppa-team/remmina-master
sudo apt-get update
sudo apt-get install remmina remmina-plugin-rdp
```

### Install Remmina on Fedora 22/23/24 and above
```
yum install remmina remmina-plugins-rdp
```

You have to install the package `remmina-plugins-rdp` or you won't have the RDP feature in the installation. That's it. Plain and simple.

