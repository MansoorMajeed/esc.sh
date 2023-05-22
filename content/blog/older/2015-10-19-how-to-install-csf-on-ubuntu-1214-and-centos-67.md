---
author: Mansoor A
date: "2015-10-19T17:19:55Z"
description: ""
draft: false
title: How to install CSF on Ubuntu 12/14, and Centos 6/7
url: blog/how-to-install-csf-on-ubuntu-1214-and-centos-67
---


CSF (ConfigServer Security and Firewall) is one of the best firewall/Intrusion detection-prevention tool out there for Linux. I myself use CSF on my server and it works just awesome. I don't have to worry about those bots trying to bruteforce my SSH, IMAP etc. CSF keeps all of them at the bay.

#### This tutorial applies to the following Operating Systems

  * Ubuntu 12.04
  * Ubuntu 14.04/15.04
  * Centos 6.5/6.6/6.7 and Centos 7

#### Features of CSF includes:

  * Checks login authentication failures for SSH, IMAP, FTP, etc
  * An awesome firewall
  * Login Notification for SSH
  * SU login notification
  * User interface integration for cPanel, Webmin and DirectAdmin
  * Excessive connection blocking
  * Syn flood protection
  * Ping of death protection
  * And a lot more

#### How to install CSF on Ubuntu 12.04/14.04/15.05

  1. Disable UFW ( uncomplicated firewall ) Ubuntu comes with UFW, which is good for basic protection. But since we are going to set up CSF, let us disable UFW 
```
ufw disable
```

  2. Downloading and installing CSF 
```
# Download the csf installation package
wget https://download.configserver.com/csf.tgz

# in case if you're getting "wget : command not found error", install wget using
apt -y install wget

# uncompress it
tar -zxvf csf.tgz

# cd to the extracted directory
cd csf

# install csf
sh install.sh
```
The installation should finish in a couple of seconds.
    
Make sure everything works. Even though CSF is now installed, some servers have some issues with IPTABLES modules. The following check makes sure that everything's working properly 

```
perl /usr/local/csf/bin/csftest.pl
```
    
That's it. We have installed CSF successfully. We will talk about basic configuration of CSF at the end of this post. Feel free to skip to the last part
    
#### How to install CSF firewall on Centos 5/6/7
    
1. Do this step only if you're using Centos 7. Centos 7 comes with another firewall ( firewalld). We have to disable it and install iptables so that we can use CSF. 
      
```
# Stop firewalld if it is already running
systemctl stop firewalld

# Remove firewalld from start up
systemctl disable firewalld

# Install iptables services
yum -y install iptables-services
```
    
2. Downloading and installing CSF 
```
# Download the csf installation package
wget https://download.configserver.com/csf.tgz

# in case if you're getting "wget : command not found" error, install wget using
yum -y install wget

# Install the required perl modules
yum install perl-libwww-perl -y

# uncompress it 
tar -zxvf csf.tgz 

# cd to the extracted directory 
cd csf 

# install csf 
sh install.sh
```
        
The installation should finish in a couple of seconds.
        
Make sure everything works. Even though CSF is now installed, some servers have some issues with IPTABLES modules. The following check makes sure that everything's working properly 
```
perl /usr/local/csf/bin/csftest.pl
```
        
That's it. We have installed CSF successfully. Now let us do some basic configuration to set up the firewall.
        
### Configuring CSF
        
The configuration file is located at
        
```
/etc/csf/csf.conf
# Edit the configuration file using "nano"
nano /etc/csf/csf.conf
```
        
#### Open only the necessary ports
        
There are four parameters that controls inbound and outbound ports. They are
  
TCP\_IN, TCP\_OUT, UDP\_IN, UDP\_OUT
        
Below are the common TCP ports used. You may want to open the ones you need.
        
```
21: FTP
	22: SSH
	23: TELNET
	25: SMTP
	53: DNS
	69: TFTP
	80: HTTP
	109: POP2
	110: POP3
	123: NTP
	137: NETBIOS-NS
	138: NETBIOS-DGM
	139: NETBIOS-SSN
	143: IMAP
	156: SQL-SERVER
	389: LDAP
	443: HTTPS
	546: DHCP-CLIENT
	547: DHCP-SERVER
	995: POP3-SSL
	993: IMAP-SSL
	2086: WHM/CPANEL
	2087: WHM/CPANEL
	2082: CPANEL
	2083: CPANEL
	3306: MYSQL
	8443: PLESK
	10000: VIRTUALMIN/WEBMIN
```
        
Below is the values for the above parameters on a basic server. You might want to open more ports depending what all services you're running. You can use the above list to figure out what all ports should be open
 
 ```
        TCP_IN= "22,80,53,443"
        
        TCP_OUT="22,80,53,443&#8243;
        
        UDP_IN="53&#8243;
        
        UDP_OUT="53&#8243;
 ```
        
If you have opened the configuration file using "nano", you can save changes and exit the editor using "Ctrl+X", and the type "Y" and press "Enter". Once you have saved the config file, reload csf using.
        
```
csf -r
```
        
And make sure that everything is working fine. The last thing you want is to lock yourself out of your server. Luckily, CSF has a "testing mode", which will flush the firewalls in a small interval so that you don't lock yourself out. If you have made sure that everything is working as expected, you can disable testing mode.
        
```
nano /etc/csf/csf.conf
```
        
And set `TESTING = "0"`
        
So we're all set, reload csf using `csf -r` and you have CSF protecting your server.
        
#### Basic CSF commands
        
```
# Start CSF firewall
csf -s

# Stop the firewall / Flush the rules
csf -f

# Restart the firewall
csf -r

# Add an IP to the whitelist
csf -a <ip address>

# Blacklist an IP ( the IP won't be able to connect to the server)
csf -d <ip address>

# Remove an IP from the allow list
csf -ar <ip>

# Remove an IP from the deny list
csf -dr <ip>

# Update/upgrade CSF
csf -u

# Disable CSF and LFD
csf -x

# Enable CSF and LFD 
csf -e
```
        
Well, that's it for now 🙂

