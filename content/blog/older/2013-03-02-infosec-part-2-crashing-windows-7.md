---
author: Mansoor A
date: "2013-03-02T07:39:00Z"
description: ""
draft: false
title: 'InfoSec - Crashing A Windows 7 System Using Metasploit : MS10-006'
url: blog/infosec-part-2-crashing-windows-7
---


Today I'll show you how to crash an unpatched Windows 7 machine, and how to protect yourselves from such attacks.
  
Now, this attack can be used to do remote code execution in compromised systems. But, today I'll be demonstrating how to crash a windows 7 system. Before we get into the attack phase, I'd like to give you guys some background information about what we are doing here.
  
The vulnerability is called MS10-006. You can read more about it from Microsoft website itself: <a href="https://technet.microsoft.com/library/security/ms10-006" target="_blank">HERE</a>
  
Basically, the vulnerability is in the SMB protocol. What the heck does this protocol do? Well, the SMB stands for "Server Message Block". It is used to share files,printers etc among computers in a network.
    
How is this being exploited? When an SMB client ( our target machine ) gets a specially crafted SMB response from the attacker (us) the system crashes. Microsoft already patched this vulnerability back in 2010 itself. But, the reason why we should know about it now is because, there are a lot of people who don't update their windows machines. They will suffer if someone is gonna go and exploit all these vulnerabilities.
    
Okay, enough with all that, let's start our business.
  
> Caution:
> This is for educational purposes, and to see how the attackers can make a lot of mess in a production environment.
> Please do not try these kinds of attacks on production networks, do this on test environments only,
> and only on machines owned by you or machines you have permissions to do so.
  
### Requirements:  
- Attacker Machine: Kali Linux / Backbox or any distro with Metasploit installed
- Victim : Windows  7 un-patched
- Victim and attacker should be on the same network
  
### How To Do It?
  
First of all, open up your attacker machine, open a terminal and type "msfconsole" as root. This should open up Metasploit Console window

![Msfconsole](https://cdn.esc.sh/jekyll/posts/metasploit/console1.jpg)
        
Now that msfconsole is open, we are going to use the following exploit to take advantage of the above stated vulnerability.  Type the following in the console:
```shell
use auxiliary/dos/windows/smb/ms10_006_negotiate_response_loop
```    
Now the console has chosen the specific exploit, and if you type "show options" you can see a lot of options. Let's not confuse you with all the jargons, we'll only be using the "SRVHOST" option, for now. And will leave all the other options with default values.

Now we need to put the value of the SRVHOST. This should be the IP address of your attacking machine.

![Msfconsole](https://cdn.esc.sh/jekyll/posts/metasploit/console2.jpg)

That's it, type "run" and the server will start. Now, all you have to do is, trick the victim to access this SMB server. For that, in the victim machine, press Win+R to open up the run window and type the IP address of the malicious server. Check the below image to see how to do that properly.

![Msfconsole](https://cdn.esc.sh/jekyll/posts/metasploit/win_run.jpg)

Upon pressing "OK", you will see that your windows system is crashed. Now, this is called DOS, not Disc Operating System, but Denial Of Service 😛 Windows just got pwned.
                
### How To Protect Yourselves?             
Just update your windows machine. Seriously, windows updates is your golden armor ( not really, ehm, plastic maybe. 😉 ) against these kinds of attacks.

