---
author: Mansoor A
date: "2015-08-29T19:55:37Z"
description: ""
draft: false
title: How to install and use Google Chrome on Kali Linux 2.0
url: blog/how-to-install-and-use-google-chrome-on-kali-linux-2-0
---


Kali Linux 2.0 is here, which most of us love already. Also, we love Google Chrome, but these two ( Kali Linux 2.0 and Google chrome ) does not work well ( except when you do it right ). Today I will show you how to properly install google chrome on Kali Linux.

There is a video tutorial on how to do this.

> Update:
> Kali Linux is now a rolling release, meaning there is no specific version releases for the operating system, 
> If you are already using the rolling, you might want to setup your sources.lst for it. More information
> Here : [kali-linux-sources-list-repositories](http://docs.kali.org/general-use/kali-linux-sources-list-repositories)


### Step 1: Get the deb file

You need to download the Chrome .deb file to install on your Kali Machine. Go <a href="https://www.google.com/chrome/browser/desktop/index.html" target="_blank">HERE</a> and download the .deb ( Make sure you download the correct one - 32bit or 64bit )

### Step 2: Installing the deb using dpkg

Let's install the .deb file. For that, open up a terminal and "cd" to the directory where you have downloaded the deb file. Remember to use "sudo" if you're not root. As a side note, you can install any .deb file on Kali or any Debian based distro using the following command.

```shell
cd ~/Downloads
dpkg -i google-chrome-stable_current_amd64.deb
```

It will probably show you an error saying there is some dependency issue or some stuff like that. I don't actually remember the error.

But, install the following package and you should be good to go

```shell
apt-get install libappindicator1

# Once the above packages has been installed, issue the following command
# so that all the dependencies will get installed properly

apt-get -f install
```

The package manager will start to install all the dependencies and once that is finished, you could see that the package manager is setting up google chrome. And Google chrome should be installed in a few seconds.


### Step 3: Now comes the issue, you cannot run Chrome, yet

This is where things get ugly. If you try to open up google chrome, it won't open. Nothing would happen. Actually, you won't see any error messages. It just won't open. And there is a reason why it won't open, that's because you're trying to run it as "root".

Default user in Kali is "root" and it was done for a reason, Kali is not intended to use as a daily OS. But that does not mean that you can't use it as a daily OS. In fact, Kali 2.0 is my main OS and it runs without any issues.

#### If you want to use Chrome, you have two options:

In fact there are several methods by which you can use Google chrome. Most of them involve enabling chrome to be run as root. This is not the right way to handle things. There is a reason why chrome refuses to run as root. That's because, if you run the browser as root, then someone exploiting your browser could get root privileges. But, anyway, let's cut to the chase.

  Option 1. Create a normal user with sudo privileges to use daily, and use "sudo su -" to switch to root whenever you want.
  
  This is the preferred method. This is how I use Kali. If you want to know how to set up a sudo user in Kali, please go <a href="http://esc.sh/blog/how-to-create-new-normal-user-with-sudo/" target="_blank">HERE</a>

  Option 2. Create another user and switch to that user in a terminal and open up the applications like google chrome or VLC. Let me explain this for you:

This is how it's done in the second option:

```shell
# First of all, we need to enable access to X server for all users
# Otherwise, the newly created user won't be able to run applications with GUI
# Issue the following command
xhost +
# Create a new user. Here bob is the username
adduser bob
# Now the program will ask for password etc, provide them
# Once the user is created, you can switch to the new user using the following command 
su - bob
# Now you're in bob's terminal, and you can open google chrome by typing
google-chrome 
# It should open up the chrome browser
```

That's it. That way you can run chrome browser, without changing any system files. This is the same case with VLC. If you're not able to open VLC in Kali Linux 2.0, switch to a normal user and open vlc by typing the command "vlc".

If you do not have VLC installed, you can simply install it using the command "apt-get install vlc". If that shows "package not found", you might want to set up your sources.lst properly. Read <a href="http://esc.sh/blog/how-to-set-up-the-sources-lst-on-kali-linux-2-0/" target="_blank">THIS</a> to see how to do that.

