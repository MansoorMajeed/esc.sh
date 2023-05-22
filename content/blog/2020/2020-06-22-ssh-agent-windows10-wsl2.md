---
author: Mansoor A
categories:
- Linux
- Windows
date: "2020-06-22T06:49:38Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/06/blog-ssh-agent-1.PNG
summary: How to get your ssh-agent to persist between terminal sessions - the reliable
  way
tags:
- Linux
- Windows
title: Using SSH-Agent the right way in Windows 10/11 WSL2
url: blog/ssh-agent-windows10-wsl2
---


# The Problem

If you use `ssh-agent` with an encrypted ssh key, or use it for agent forwarding, you may have come to realize that even though you started an agent session using `eval $(ssh-agent -s)` it does not persist when you open a new terminal window. It does not even work with a new tmux window or pane.

# The Solution

Fortunately, it's pretty simple. `keychain` to the rescue.

Install `keychain`

```
 sudo apt-get install keychain
```

Edit your `~/.bashrc`, `~/.zshrc` or  whatever rc file that corresponds to your weird shell of choice (I'm not judging you) and add the following to the bottom of your file.

```
# For Loading the SSH key
/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh
```

So, this is how my `~/.zshrc` looks like

```
# For Loading the SSH key
/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/LAPTOP-C9EO4ILB-sh
```

And that is all. When you open a new shell, it will ask you to enter the password for your ssh key, and then onwards it will greet you with this sweet screen saying that `keychain` took care of loading your ssh-key

{{< figure src="https://cdn.esc.sh/2020/06/blog-ssh-agent-2.png" >}}

> Please note that this above screen won't show up if you used the `-q` option with keychain

