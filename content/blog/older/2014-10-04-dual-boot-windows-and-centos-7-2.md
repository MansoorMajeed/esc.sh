---
author: Mansoor A
date: "2014-10-04T11:35:00Z"
description: ""
draft: false
title: Dual boot Windows and Centos 7
url: blog/dual-boot-windows-and-centos-7-2
---


After I installed centos 7 in my system, I noticed that my windows 8 installation is not showing in the grub. Then I realised that, it is due to the fact that windows uses ntfs partition and by default, ntfs cannot be mounted in centos. (Don't worry, its an easy fix).

So, the First thing you should do is enable NTFS support in Centos 7.
 
I have  a blog post </b><a href="https://esc.sh/blog/cannot-mount-ntfs-in-centos-7-how-to/" target="_blank">HERE</a> explaining how to deal with that. Read the post and get your ntfs system ready to work with Centos.
  
Once you have that fixed, Open a terminal and issue the command (You have to be root)  
```shell        
grub2-mkconfig
```
Note the output. Find the entry which corresponds to Windows 8. It will look something like
```shell  
Found windows 8 (loader) on sda8 ...
```
Copy the entire entry of windows 8 (From one # to the next #). Refer to the following image.
![grub]( https://cdn.esc.sh/jekyll/posts/2014/centos/grub_centos.png )
 
Here, What's shown in black is what you should select and copy. Select till the next hash.
Now, open another terminal and run the following command as root.
```shell        
nano /etc/grub2.cfg
```
Scroll down to the bottom of the file and then right click and paste the copied entry. Then press `Ctrl + X`, and when asked type `Y` and press enter. 
  
And done.! Everything is fine. You should see the windows 8 entry the next time you reboot.

