---
author: Mansoor A
categories:
- Linux
- ThinkPad-E14
date: "2021-03-06T04:10:28Z"
description: ""
draft: false
summary: The function keys on the new ThinkPad E14 AMD does not work on Linux. It
  works only after a suspend
tags:
- Linux
- ThinkPad-E14
title: ThinkPad E-14 AMD Function Keys not working
url: blog/thinkpad-e-14-fn-key
---


I recently got a ThinkPad E-14 Gen 2 with AMD Ryzen 5 and installed Ubuntu onto it only to realize that the function keys do not work at all. And I came to know that Lenovo does not certify the E series for Linux, so that was a bummer.

So, reading about the issue I came to know that the function keys starts working after the laptop has been suspended once, so I made this hack to make it seamless

## The solution

Open your crontab

```
sudo crontab -e
```

This will ask you to choose your favourite text editor, choose the one that you know. Add the following to the end of the file

```
# Fn key fix
@reboot sudo rtcwake -m mem -s 2
```

Save it and exit out of the editor. So what we are doing is, we are asking the system to suspend for 2 seconds after every reboot. This fixes our issue without us even noticing.

You can either reboot your system now and test it or just run `sudo rtcwake -m mem -s 2` from the terminal to have your Fn keys work immediately. Once rebooted, you don't have to worry about it at all

