---
author: Mansoor A
date: "2015-06-15T17:21:10Z"
description: ""
draft: false
title: Unity is not displaying the dash or window borders?
url: blog/unity-is-not-displaying-the-dash-or-windows-borders
---


This happens sometimes. Unity does not load at all. All you can see in your ubuntu desktop  wallpaper ( Ubuntu 14.04/15.04, or whatever version that is using unity). If you use any keyboard shortcuts to open up a window, like terminal, you won't see any window border. This happens because the unity plugin is not enabled in compiz. Fixing this is an easy task. Here is how you could fix it

First of all, you need a terminal to type in some commands. For that, try Ctrl+Alt+T. In most cases, a terminal should pop up. But if not, nothing to worry about. Press Ctrl+Alt+F1. You should be asked to enter your login. Type in your username and then your password. Now you should get into a terminal.

Now, you need to install CCSM. For that, type in the following commands. You need a working internet connection, obviously.

```
sudo apt-get install compizconfig-settings-manager
```

Now, you can open CCSM ( Compiz configuration settings manager). Using the following command

```
DISPLAY=:0 ccsm
```

The first part means that this window (ccsm) should be displayed on the first display on the local machine. Now, a window of ccsm should be opened in your GUI. If you typed in all these commands in a terminal opened using Ctrl+Alt+T, you could see the CCSM window in the desktop. On the other hand, if you have typed in all these commands in the tty, you could press Ctrl+Alt+F7 ( or Ctrl+Alt+F8 if the other one does not work) to get back to your normal desktop. There you can see a window of ccsm waiting for you.

Now that you have CCSM opened, you need to enable the unity plugin.

Now you should see your desktop coming back to normal. Just in case if it does not, do a reboot and everything will be all right

