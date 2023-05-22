---
author: Mansoor A
date: "2012-10-01T17:19:00Z"
description: ""
draft: false
title: How to install Redhat Linux on Virtualbox
url: blog/how-to-install-redhat-linux-on
---


> Note : This blog post is pretty old and I'm showing you how to install Redhat Enterprise Linux 6
> The steps for RHEL 7 should be similar, but there will be few differences in the UI, be aware of it :)

This is a quick tutorial on how to properly install RedHat on Virtualbox. If you are going to study RedHat, you'd need a properly installed system to work on. You could use RedHat in Virtualbox. I recommend using virtualbox rather than installing as a main operating system. Because if something goes wrong, you can deal with it easily.
  
There is a slight confusion among most people about the price of the RedHat operating system. Like, Linux is opensource but why are they charging for it, and can I use RedHat without having a licence.? Actually, RedHat is free, but you are paying for the support from them. So, in a production environment, you might wanna subscribe, but, for now, we don't need a certificate/licence.
  
Another option is to use CentOs, which is totally free and you get support from the community. You might wanna try that.. 🙂
  
That's enough intro, let's get started.
  
First of all you need to download the iso image for RedHat from RedHat servers. Go <a href="https://access.redhat.com/downloads" target="_blank">HERE</a>. You may have to create an account.
Now you need to download the VirtualBox software from : <a href="https://www.virtualbox.org/wiki/Downloads" target="_blank">HERE</a>
Install it (obviously), and open it. Place the downloaded iso somewhere you can access (like in your desktop)

Open VirtualBox and Click on new, then give a name for your guest os. You could give a name you like, 
I'd give it "RedHat. Choose the operating system from the list. (I chose RedHat 64bit)

![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat1.png)

Now, click next and in the next screen you'd be asked to set the amount of ram you wish to give. I'd give it 1GB of ram. (This solely depends on the amount of ram available on your system)

Click next and then it will ask if you want to create a new harddisk, click yes. and then create. Then it will ask you to choose a hard-disk type. Select vdi, it works fine. and click next.

On the next screen you should choose dynamically allocated. On the next screen It will ask you to set the size of the hard disk. 8GB is enough. Click create.
      
Now, click on the virtual machine you just created and click start. Now it will ask you to point to the location where you put the iso of redhat. Browse to the iso and click open
![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat2.png)

Now, you will be presented with a boot menu. Press enter and os will boot up. On the next screen, you will see a blue screen. Press tab and skip the media test. It's used to check if the installation media is faulty or not.
      
On the next screen onwards, it is self explanatory, click next. Keep pressing next until you reach a window asking you to discard your data/keep data. Click on "Yes, discard any data"

> NOTE: When you click on the VirtualMachine, your mouse pointer will be trapped in the guest OS. Press the `Right Control` button to release the mouse pointer from the guest os

Click next, and then choose the Time Zone, Then choose an admin(root) password. It is important that you should not forget this password. Click next

Here comes the tricky part. Pay attention..!
![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat3.png)

Choose the last option (Create custom Layout)

We have to create two partitions in here. We have 8GB free space. Click on create, and choose standard partition and click create.
```
Mount point      : /
File system type : ext4
Size             : 7000MB
```
Press OK
![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat4.png)

We need to create one more partition - The swap partition. This is important. **DO NOT SKIP THIS STEP**.
Due to some bug or unknown reason, if you don't create a swap partition, then your OS won't boot. 
It will give a kernel panic message. So, click on the free space and click create. 
Choose standard partition and then choose the file system as "swap" and give a size of 100MB. 
(You can give as much swap as you want, BUT, YOU SHOULD LEAVE AT LEAST 500MB FREE SPACE. We need this space for later assignments)

![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat5.png)
 
Now click on next >> format >> write changes to disk. After the disk has been formated, click next.

This is another important step. Choose basic server, and at the bottom, click on Customize now and click next.
![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat6.png)
            
From the list of available packages, click on Desktops and from the list appeared on the right, Tick everything except KDE-Desktop.
(You can install KDE too, which will install lots of kde applications. We won't be using kde, so I'd just skip that one and install all the other packages. ) Click on next.

![Redhat](https://cdn.esc.sh/jekyll/posts/2014/redhat/redhat7.png)

The installation has started and you will have to wait for some time and once your installation is finished, click on reboot, and you're done.!If you face any problems, please leave a comment. I'll try my best to help.

