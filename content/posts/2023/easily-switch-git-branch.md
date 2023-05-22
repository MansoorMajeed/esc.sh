---
title: "Easily switch between recent git branches"
description: "Here is a neat shell alias that allows you to easily switch between git branches using fuzzy search"
author: Mansoor
date: 2023-05-10T22:32:37-04:00
lastmod: 2023-05-10T22:32:37-04:00
lastmod: 2022-08-03T22:32:37-04:00
draft: false
url: blog/switch-git-branches-fzf
images: []
---
I have a very handy shell alias (a shortcut in the terminal) that allows me to easily switch between my most recent Git branches using fzf

## What is FZF
It's a tiny little "fuzzy finder". Fuzzy search means to find strings that matches patterns approximately.
For example if you have a string called database-server-12 and you want to fuzzy find it, you maybe able to use db12 to easily find it

## The Problem
When we work on a project, we often have to switch between several different branches, be it between a main and a feature branch, or between several feature branches. Remembering all of them can be difficult

## The Solution
Luckily, it is pretty straight forward to come up with an alias that makes our day a lot more easier (at least for switching between git branches)

### Install FZF
Install it following the instructions corresponding to your operating system

**If you use Ubuntu or other debian based distros**
```bash
sudo apt update
sudo apt install fzf
```

**Fedora and other RedHat based distros**
```bash
sudo dnf install fzf
```

**MacOS**
```bash
brew install fzf
```

**Windows (WSL)**

Depending on the OS you use, you can use `apt` or `dnf` as mentioned above

### The Alias
If you use bash, add the following to your `~/.bashrc` file or If you use zsh, add it to the `~/.zshrc`

```bash
alias gb="git checkout \$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ | fzf)"
```

That should be it. reload your terminal or `source ~/.bashrc` or `source ~/.zshrc` to reload your rc file and you are ready to use the alias.

Obviously you can use any shortcut instead of `gb`. Now just type `gb` in a git repo and you can use your arrow key and then press enter to choose the branch easily

