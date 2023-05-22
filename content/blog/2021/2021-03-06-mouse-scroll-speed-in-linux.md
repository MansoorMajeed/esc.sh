---
author: Mansoor A
categories:
- Linux
date: "2021-03-06T03:17:23Z"
description: ""
draft: false
summary: How to increase the mouse scroll speed in Linux without messing up google
  chrome
tags:
- Linux
title: Increasing Mouse Scroll Speed in Linux
url: blog/mouse-scroll-speed-in-linux
---




By default the scroll speed in Linux is pretty slow, regardless of the distro. I tried so many imwheel configurations but many of them have issues with chrome scrolling being glitchy.

Finally, this is the one that works well for me, no issues with any applications

### Installation

Install `imwheel`

```bash
sudo apt update
sudo apt install imwheel
```

Create a file `~/.imwheelrc`. You can use your favourite text editor for it.

```
".*"
None,      Up,   Button4, 3
None,      Down, Button5, 3
Control_L, Up,   Control_L|Button4
Control_L, Down, Control_L|Button5
Shift_L,   Up,   Shift_L|Button4
Shift_L,   Down, Shift_L|Button5
```

And that's it

> You can adjust the scroll speed y changing the number 3. Higher value means faster scrolling. I found 3 to work best for me. Your mileage may vary. Make sure you use the below command to restart imwheel after updating the value

### Starting imwheel

You can manually start/restart imwheel using the command

```
imwheel -kill
```

### Auto-starting imwheel

For imwheel to start automatically on boot, you need to add it to the startup applications. Please note that we need imwheel to start after the X-window is started, so adding it to rc.d files won't work.

Open `Startup Applications` -> `Add` and add it like below

{{< figure src="https://cdn.esc.sh/2021/03/startup.png" caption="Startup applications" >}}

That's pretty much it

