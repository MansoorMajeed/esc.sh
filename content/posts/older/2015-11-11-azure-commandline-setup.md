---
author: Mansoor A
date: "2015-11-11T17:16:17Z"
description: ""
draft: false
title: How to Manage your Azure account from the command line
url: blog/azure-commandline-setup
---


Even though I'm a Linux guy, I'll agree on this - Azure is awesome. Especially for developers. If you have an MSDN subscription, things get a lot better. In essence, Azure is pure awesome. Create, deploy, test, destroy VMs and cloud services without any hiccups. Well, this post is for the command line junkies among you ( fortunately or unfortunately, I'm one of them.. 😉 ). Managing VMs ( or cloud services for that matter ) from the GUI is too main stream. Besides, it is insanely slow and considerably unproductive. Sometimes it takes too much time load the dashboard from where you can manage your VMs, mobile apps, cloud services etc. And I thought, there might be CLI for the azure cloud., and there is. Microsoft knew that some people will always prefer the good old "command line".

### So, Why command line?

  * It's way faster than a browser
  * It gets things done easily
  * Easy to use once you know your way around commands
  * Easily schedule things ( Like shutdown a VM at a specific time )
  * You don't need a super fast internet connection
  * And it's way cooler than the GUI 😉

> TL;DR: The post helps you to setup and manage your azure account from the command line.

**Note: This "How To" is for Linux users only. ( I'm using Linu Mint 17.2, but it should work on any Ubuntu and related distros )**

Let's get started

### Installing the azure-cli

Open a terminal ( Ctrl + Alt + T ) and issue the following commands one by one. ( Who am I kidding, You know the drill)

```
sudo apt-get install nodejs-legacy
sudo apt-get install npm
sudo npm install -g azure-cli
```

That's it, azure-cli should be installed now. You can verify if the installation was successful by issuing

```
azure
help
```

You will be greeted with all the available options. So it is working. Now let's connect your account

### Connecting to your Microsoft Azure Account

In the terminal window, type

```
azure login
```

You will be greeted with something like this:

> To sign in, use a web browser to open the page https://aka.ms/devicelogin. Enter the code XXXXXX to authenticate.

Go ahead and open the URL <a href="https://aka.ms/devicelogin" target="_blank">https://aka.ms/devicelogin</a> in your browser, and copy the code displayed in the terminal. We will need this.

Now, once the page is opened, you will be asked to enter the authorization code, paste the code and you will be redirected to Azure login page. Login using your email and password. And, that's it. You're in. Your account is now ready to be controlled from the command line.

### Managing your VMs using the command line

Once you have setup the login, it's dead easy to manage your account from the command line. Issue "azure help" and you will get all the options you can use. Here I'll discuss a few basic commands that can be used to manage your VMs

```
# List all your Virtual Machines
azure vm list

# Show details about your VirtualMachine
azure vm show <name of your vm>

# Start the VM
azure vm start <vm name>

# Stop the VM
azure vm shutdown <vm name>

```

### Easily Manage Ports ( End Points in your VM ) : Open or close Ports with a single command

You know what they say, "Security comes at the cost of convenience". If you know what "End points" in azure means, you probably know what I'm talking about. But, hey, it's really easy to open or close ports ( configure end points ) in your VMs from the command line.

```
# Create an END point ( Means open a port )
azure vm endpoint create <vm name> <public-port> [local-port]

# For example, if I wanted to open port 443 ( HTTPS ) on my vm named "centos7"
# I will use the following command
azure vm endpoint create centos7 443 443

# Delete an end point
azure vm endpoint delete [options] <vm-name> <endpoint-name>

# List all end points
azure vm endpoint list <vm name>
```

And, that's it for now. You can get almost everything done from the command line. Just use "azure help", and you're good to go.

