---
author: Mansoor A
date: "2016-08-20T11:07:00Z"
description: ""
draft: false
title: OSX, iTerm2, ZSH and the tab title
url: blog/iterm-zsh-tab-title
---


### TL;DR
Add the following to your ~/.zshrc and use the command `tt <tab name>` to rename your tab

```bash
DISABLE_AUTO_TITLE="true"
tt () {
    echo -e "\033];$@\007"
}
```
-----------------------------------

iTerm2 is the best terminal emulator out there for OS X. No questions there. ( Or is there a better one I haven't tried yet? )
And ZSH is my favourite shell. Well, it's the favourite shell of a lot of people. If you're the kind of person who will have a ton 
of terminal tabs open at the same time, you will know that it is a PIA to differentiate between them. A right command at the wrong tab could 
fcuk things up quite a bit. So, we have tab titles. And this post is about tab titles itself. 

First of all, open up your zshrc file ( normally it will be  ~/.zshrc ) and add the following.

```bash
DISABLE_AUTO_TITLE="true"
tt () {
    echo -e "\033];$@\007"
}
```

Now, you can use the command `tt <tab name>` to rename the tabs. Please remember that this will not work when you have already SSH'd 
into another server ( obviously ).
In that case, you can press `Command + I` and type the tab title, and press `escape`

So, yeah. That's all for now.

