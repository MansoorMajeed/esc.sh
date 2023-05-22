---
author: Mansoor A
categories:
- Quick Notes
date: "2020-03-29T14:11:33Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/03/git_res.png
summary: The correct way to use a specific SSH key for a single (or multiple if you
  wish) git command(s)
tags:
- Quick Notes
title: Using specific SSH key for a single Git command
url: blog/using-different-ssh-key-for-a-single-git-command
---


Sometimes we would like to use a specific SSH key for a git command, this is how to do so.

```bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_rsa_example -F /dev/null" git clone git@whatever.git
```

Here `-F /dev/null` is used to make sure that ssh doesn't load any parameters from any of the ssh config files

