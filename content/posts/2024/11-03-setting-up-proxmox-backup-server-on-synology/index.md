---
title: "Setting up Proxmox Backup Server on Synology"
description: ""
author: Mansoor
date: 2024-11-03T04:59:32.058445
lastmod: 2024-11-03T04:59:32.058496
draft: true
url: /blog/setting-up-proxmox-backup-server-on-synology
images: []
categories:
    - SelfHosting
url: /blog/proxmox-backup-synology-nas
images: {}
tags:
    - Selfhost
---


## outline


https://www.derekseaman.com/2023/04/how-to-setup-synology-nfs-for-proxmox-backup-server-datastore.html
https://4sysops.com/archives/proxmox-backup-server-install-and-configure/


### why pbs

### why on a synology nas

### how to

install the virtual machine manager on synology nas

- use the default settings
- choose a volume


download proxmox backup server iso 
https://www.proxmox.com/en/downloads/proxmox-backup-server

open file station and upload the iso to a location of your choosing

#### disks

- create at least two virtual dsks. 
I created one for 50GB (instal the os) and 1TB (for backup)


- you can keep the default vm network

Other settings -> `ISO file for bootup` choose the ISO we uploaded
Autostart : Yes
memory : Give at least 2GB 

rest of the settings : default

Assign power maangeemnt permissions : Give it to the user of your choosing, I gave only to my own local user

Click : `Create`

Once creation is successful, "Power on"

and click on `connect` and it will open up another browser tab


- choose install (graphical)

follow the instructions, choose the `Target harddisk` as the 50GB disk
- set timezone and country
- set root password
- set your hostname, IP address etc


configure the disk, create directory, create datastore, create user, give permiossion

### back in PVE

datacenter -> storage -> add -> proxmox backup server