---
author: Mansoor A
date: "2021-06-09T06:02:14Z"
description: ""
draft: false
summary: 'How to disable mouse acceleration in MacOS '
title: Disabling Mouse Acceleration in MacOS
url: blog/disabling-mouse-acceleration-in-mac
---

## The new method

Use [LinearMouse](https://linearmouse.org/). Seriously, after spending a ton of hours, this is what worked for me
on an M1 mac running MacOS Monterey.

Install the app, open it >> Preferences >> Pointer >> Check `Disable Pointer Acceleration`

Please note that You will have to give the app accessibility permissions


## The old method.

It used to work, but not sure if it works on the new machines.

Open a terminal and run

```
defaults write -g com.apple.mouse.scaling -integer -1
```

Now, logout and log back in - this is very important. The changes do not take effect until you have done that.

Tested this on MacOS Big Sur

