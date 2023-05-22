---
author: Mansoor A
date: "2016-05-29T11:07:00Z"
description: ""
draft: false
title: How To Fix Poor Font Rendering in Fedora
url: blog/fix-ugly-fonts-in-fedora
---


### Backstory
I've been using Linux Mint 17.3 for some time, and then Ubuntu 16.04 was released. I have this problem, you know,
like, if there is any distro release, I have to install it and use it. Be it Linux Mint, Ubuntu, Fedora, or whatever. 

So I installed Ubuntu 16.04. It was nice, for a while, then came quite a lot of bugs ( It's an LTS release for God's sake ).  
So I ditched Ubuntu and decided to go back to Fedora 23 KDE. And I did. 

Fedora is awesome. I mean, so many people underestimate Fedora and the work done by the good people at RedHat and the Fedora devs. 
It has the best hardware support, easily available packages, better performance ( Thanks to the latest versions of Linux Kernel, and other packages)

But, one thing I hated about Fedora, and loved about Ubuntu is the font rendering. The guys at Canonical did a very good job and
the UI is well polished. For Fedora, the fonts are ugly, at least for me. It looks distorted, no matter what font you use.

I did spend a lot of time trying to fix this poor font rendering and I was able to do it, after a couple of hours :/  

> Applies to : Fedora 22, 23, ( Possibly any newer version )

### How to Fix poor font rendering

*Step 1* : Open a terminal and install the `freetype-freeworld` package
```
sudo dnf install freetype-freeworld
```

If you get any error like "package not found", you need to install the RPMFusion repository

### Install RPMFusion Repository 

*This is for Fedora 21 and above*
```
su -c 'dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
```

Once the Repository is installed, install the package as mentioned in Step 1

*Step 2* : Now that you have installed the required package, open the file `/etc/fonts/local.conf` using your favourite text editor and paste the following content into it, and save the file.


```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="pattern">
    <test compare="eq" name="family" qual="any">
      <string>Arial</string>
    </test>
    <edit binding="same" mode="assign" name="family">
      <string>Noto Sans</string>
    </edit>
  </match>
  <match target="pattern">
    <edit name="dpi" mode="assign">96</edit>
  </match>
  <match target="font">
    <edit mode="assign" name="antialias" >
      <bool>true</bool>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="hinting" >
      <bool>true</bool>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="hintstyle" >
      <const>hintslight</const>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="rgba" >
      <const>rgb</const>
    </edit>
  </match>
  <match target="font">
    <edit mode="assign" name="lcdfilter">
      <const>lcddefault</const>
    </edit>
  </match>
  <alias binding="strong">
    <family>sans-serif</family>
    <prefer>
      <family>Open Sans</family>
    </prefer>
  </alias>
  <alias binding="strong">
    <family>serif</family>
    <prefer>
      <family>Bitstream Charter</family>
    </prefer>
  </alias>
  <alias binding="strong">
    <family>monospace</family>
    <prefer>
      <family>Source Code Pro</family>
    </prefer>
  </alias>
</fontconfig>
```

*Step 3* : Reboot! 

Once you login again, you should be greeted with a better renderd font. Have fun.



