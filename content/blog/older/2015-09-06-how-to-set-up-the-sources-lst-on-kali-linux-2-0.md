---
author: Mansoor A
date: "2015-09-06T17:55:21Z"
description: ""
draft: false
title: How to set up the sources.lst on Kali Linux 2.0
url: blog/how-to-set-up-the-sources-lst-on-kali-linux-2-0
---


If during the installation of Kali Linux 2.0, you have chose to not use any network mirrors, chances are you  will be using a pretty basic version of the sources.lst file. For those of you don't know, sources.lst file determines the software repositories from where you can install packages using "apt". If you have a minimal version of "sources.lst", you won't be able to install many of the packages. For example, if you try to install "htop", you will get an error saying "package not found". Follow the instructions below to get a full sources.lst file

First of all, let's move the previous sources.lst file to backup location and then let's create a new one with needed repositories.

```
mv /etc/apt/sources.list /etc/apt/sources.list-backup
```

Now open up a text editor of your choice and open the `/etc/apt/sources.list` file.

```
leafpad /etc/apt/sources.list
```

Now, copy the following content and paste it in the leafpad window, and save it.

The following is the Kali rolling repository. You should be using this unless you have some reasons to use the old repo.

```
deb http://http.kali.org/kali kali-rolling main contrib non-free

deb-src http://http.kali.org/kali kali-rolling main contrib non-free
```

The following is the old repositories. Use this only if you know what you are doing.

```
deb http://http.kali.org/kali sana main non-free contrib
deb http://security.kali.org/kali-security sana/updates main contrib non-free

deb-src http://http.kali.org/kali sana main non-free contrib
deb-src http://security.kali.org/kali-security sana/updates main contrib non-free
```

That's it, you should now have access to most of the packages. Once you save the file, do the following command once,

```
apt-get update
```

And you're good to go.

