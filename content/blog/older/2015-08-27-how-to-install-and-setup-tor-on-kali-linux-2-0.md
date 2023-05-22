---
author: Mansoor A
date: "2015-08-27T15:13:54Z"
description: ""
draft: false
title: How to install and setup Tor on Kali Linux 2.0
url: blog/how-to-install-and-setup-tor-on-kali-linux-2-0
---


I've been using Kali Linux 2.0 for a couple of weeks and one thing I missed from the default install was the tor browser.

As it turns out, Kali does not come pre-installed with tor. But fear not, I'll help you in setting up tor in your Kali desktop. Trust me, it's easier than you think. I'm pretty sure that you know what tor is and what is it used for, otherwise you wouldn't be here reading how to install it on Kali, eh? 😉

### Step 1: Installing Tor

There are several ways you can install tor, the easiest way is to use the Kali repository and that's what we're going to use today

Open up a terminal window and run the following command as root or use sudo if you're not root.

```shell
apt-get install tor
```

That's it, see I told you it's simple. Now let's set up the tor browser bundle

### Step 2: Downloading and Setting up the Tor bundle

Go to <a href="https://www.torproject.org/projects/torbrowser.html.en" target="_blank">https://www.torproject.org/projects/torbrowser.html.en</a> and download the appropriate one. For me, the 64bit English version of the bundle was <a href="https://www.torproject.org/dist/torbrowser/5.0.1/tor-browser-linux64-5.0.1_en-US.tar.xz" target="_blank">THIS</a>

Now, "cd" to the directory where you downloaded and extract the archive

```shell
cd ~/Downloads/
tar -xJf tor-browser-*
```
Once the archive is extracted successfully, cd into the extracted folder and run the bundle.

```
cd tor-browser*
./start-tor-browser.desktop
```

This should start the tor bundle and you're good to go.!

NOTE: If you're running the bundle as root, it will run into problems ( Most probably, it won't simply open ).  In that case, I'd suggest you to create a new normal user and run the bundle as that user, which should make the tor browser bundle to open up without any issue. If you need help in creating a normal user with sudo privileges, please read <a href="http://esc.sh/blog/how-to-create-new-normal-user-with-sudo/" target="_blank">THIS article</a>. If you need any help with this, leave a comment and I'll help you with the best of my knowledge 🙂

