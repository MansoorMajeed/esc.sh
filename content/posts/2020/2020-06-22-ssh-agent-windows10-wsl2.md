---
author: Mansoor A
categories:
- Linux
- WSL
date: "2020-06-22T06:49:38Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/06/blog-ssh-agent-1.PNG
summary: How to get your ssh-agent to persist between terminal sessions - the reliable way
tags:
- WSL2
- Windows
- SSH
title: Using SSH-Agent the right way in Windows 10/11 WSL2
url: blog/ssh-agent-windows10-wsl2
---

# The Problem

If you use `ssh-agent` with an encrypted ssh key, or use it for agent forwarding, you may have come to realize that even though you started an agent session using `eval $(ssh-agent -s)` it does not persist when you open a new terminal window. It does not even work with a new tmux window or pane.

# The Solution

Fortunately, it's pretty simple. `keychain` to the rescue.

Install `keychain`

```bash
 sudo apt-get install keychain
```

Edit your `~/.bashrc`, `~/.zshrc` or  whatever rc file that corresponds to your shell of choice and add the following to the bottom of your file. 

> Note: If you are not sure which shell you are using,you can run the command `echo $SHELL`
> and it will show you whether you are using BASH or ZSH

```bash
# For Loading the SSH key
/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOST-sh
```

So, this is how my `~/.zshrc` looks like

```bash
# For Loading the SSH key
/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/LAPTOP-C9EO4ILB-sh
```

And that is all. When you open a new shell, it will ask you to enter the password for your ssh key, and then onwards `keychain` takes care of loading your ssh-key
