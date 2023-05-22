---
author: Mansoor A
date: "2015-11-04T18:04:42Z"
description: ""
draft: false
title: Share a directory instantly through a simple HTTP server
url: blog/instant-http-server
---


## TL;DR
There is this amazing python module that allows you to server any directory in your file system through a web server
  
> just open up a terminal window and "cd" to the directory you want to server and type the command "python -m SimpleHTTPServer", then visit http://<your ip>:8000 to view the content

Imagine you're in a conference, or you're in your office and you want to quickly share a file, some code, a video, anything, with your colleague. Let's just say that you wanted to show the "cat video" you had in your laptop to your friend. What is the quickest way to do it? Well, there are many ways you could do this. But, today I'm gonna show you guys something different. It's not new, it has been here for a long time. And it's a python module.

This python module "SimpleHTTPServer" allows you to server any directory through a web server.
    
### Here's how you do it:

Open a terminal window and "cd" to the directory you want to server. Better yet, most modern linux distributions provide a context menu ( the thing you get when you right click ) from where you can open a terminal in any directory you want. 
And enter the following command and press enter.

```
python -m SimpleHTTPServer
```

There you go. You just started a simple HTTP server ( It is a python module, no wonder why python is so awesome, right? )

Now, any device in your network can view the contents of the directory. All they have to do is visit "http://<your machine ip>:8000. For example, "http://192.168.1.11:8000" where 192.168.1.11 is the IP address of your machine ( from where the content is being served ) and 8000 is the port where the SimpleHTTPServer is listening for requests. 

And you will see access log in the same terminal window, just as you would on any web server

