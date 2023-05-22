---
author: Mansoor A
categories:
- Kubernetes
- Google Cloud
date: "2017-10-21T00:07:00Z"
description: ""
draft: false
summary: Google Kubernetes Engine nodes do not have a package manager to install debug
  tools. You need to use `toolbox` for that
tags:
- Kubernetes
- Google Cloud
title: Debugging in Google Container Engine nodes
url: blog/debugging-gke-nodes
---


If you are using Kubernetes in Google Container Engine, at some point, you might have to debug from the node level (Nodes are the virtual machines where the entire cluster lives). For any debugging, you might need some additional packages, like `tcpdump` or `netstat`. The catch here is that the operating system of these hosts (CoreOS) does not have a package manager installed and you cannot install packages directly. Here is how you do it.

### Installing packages
Fortunately, installing stuff is pretty easy. Google provides a utility called `toolbox` which is located at `/usr/bin/toolbox` which gives you a shell in a debian environment. You can read more about it [HERE](https://cloud.google.com/container-optimized-os/docs/how-to/toolbox)

#### Installing tcpdump and netstat
SSH into to the host you want to debug. I will use `gcloud` to ssh into the VM
Don't forget to replace the name of the instance, region and the project name
```
gcloud compute ssh gke-dev-cluster-default-pool-53b7e787-580g --zone asia-southeast1-a —project=yourproject
```
Once logged in, switch to root
```
sudo su -
```
Invoke the `toolbox`. Just enter the below and press enter.  
```
/usr/bin/toolbox
```
This will pull a docker image and launch a container for you. You should see something like below
```
gke-dev-cluster-default-pool-53b7e787-580g ~ # toolbox
20161110-02: Pulling from google-containers/toolbox
386a066cd84a: Pull complete
e4bd24d76b78: Pull complete
a3ed95caeb02: Pull complete
e0a28bda554d: Pull complete
1c74c5568007: Pull complete
a11e1fa3c419: Pull complete
b04881debfe0: Pull complete
19c641096a39: Pull complete
Digest: sha256:a13ab5b2feaeef9dbe42f3a5cdbf9fcdd92f3ea020249cd37d80777d44897de7
Status: Downloaded newer image for gcr.io/google-containers/toolbox:20161110-02
06ee30a75d92f22aea424d373c3faa40e6e87438c671bd0af09be954ae677b18
root-gcr.io_google-containers_toolbox-20161110-02
Spawning container root-gcr.io_google-containers_toolbox-20161110-02 on /var/lib/toolbox/root-gcr.io_google-containers_toolbox-20161110-02.
Press ^] three times within 1s to kill container.
root@gke-dev-cluster-default-pool-53b7e787-580g:~#
```
Now you are presented with a SHELL in a debian container. You can install whatever package you want. Let's install `tcpdump` and `netstat`
```
apt-get update
apt-get install tcpdump net-tools
```
Done! You're good to go. You should be able to use this environment to do any kind of debugging just as you would do on a normal debian VM

