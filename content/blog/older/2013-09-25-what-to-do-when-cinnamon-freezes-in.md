---
author: Mansoor A
date: "2013-09-25T18:12:00Z"
description: ""
draft: false
title: What to do when cinnamon freezes in your Linux machine?
url: blog/what-to-do-when-cinnamon-freezes-in
---


We have all been there. We love Linux, we love Linux Mint, and we love Cinnamon.
But some truths are bitter. While doing some important work, cinnamon just freezes. 
You don't know what the hell just happened. Everything is stuck. You can't click anywhere, you can't open any window,  nothing.

I had to face this issue so many times in my Linux Mint 15 machine. 

You know that you can restart cinnamon by using cinnamon -replace command. 
But hey, you can't even open a terminal to do that, right?

But, this is what you could do to restart cinnamon, and hopefully, you won't loose any unsaved work.

When everything is stuck, press `Ctrl+Alt+F1` to open the tty. And issue the following command.
```shell
cinnamon --replace -d :0.0 > /dev/null 2>&1 &
```
This will do the trick and you can press Ctrl+Alt+F7 to get back to your work.
    
If cinnamon is freezing occasionally, and if you want to do this occasionally, I'd suggest you to add the command as an alias in your .bashrc file
    
#### Here is how you can do it
Open up your .bashrc using a text editor. For the sake of simplicity, we will just use "nano" to edit the file
  
```
nano ~/.bashrc
```
Now, the above command will open up your .bashrc file. Add the following line to the file
```shell
alias cinnamon-restart='cinnamon -replace -d :0.0 > /dev/null 2>&1 &'
```
Now, you can use the command "cinnamon-restart" to restart cinnamon in case it freezes.

