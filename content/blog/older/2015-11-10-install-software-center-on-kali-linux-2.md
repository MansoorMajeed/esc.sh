---
author: Mansoor A
date: "2015-11-10T18:48:33Z"
description: ""
draft: false
title: How to install Software Center on Kali Linux 2.0 Sana
url: blog/install-software-center-on-kali-linux-2
---


This is going to be a very quick tutorial on how to install the good old "Software Center"(the one we see in Ubuntu) in Kali Linux 2.0 ( Sana ). Some of you might ask, why the heck do we need a software center, well, admit it, not everyone knows their way around the command line. And if you're one of them, this post is for you.

If this seems extremely simple for you, don't point your finger at me.. 😉 Let's get started


> Update:
> It seems Kali removed the package from the repository and many people are having issues with installing software center.  
> Use "synaptic" to install softwares, it works just like software center. I'll update if I could get the software center to be working.

How to Install Synaptic in Kali Linux 2.0 ( Sana )

```shell
sudo apt-get install synaptic
```
 
First of all, you need to have a proper "sources.lst" file. Because, chances are software center won't be available in the base repository. Setting it up is a must and it is quite simple. I have already made a post on how to do that. Go <a href="https://digitz.org/blog/how-to-set-up-the-sources-lst-on-kali-linux-2-0/" target="_blank">HERE</a> and setup your sources.lst

```shell
sudo apt-get update
sudo apt-get install software-center```
```
See? I told you it's going to be simple. 😉 In case if that didn't work for you, do the following, and try installing again.

```
# update your OS
sudo apt-get update && sudo apt-get upgrade
```

In most case it is not needed. But, hey you should always keep your OS up to date. So, there's that. If you jump into any issues, leave a comment below and I'll try my best to sort it out for you.

