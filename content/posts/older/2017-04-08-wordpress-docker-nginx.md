---
author: Mansoor A
categories:
- HomePage
date: "2017-04-08T00:07:00Z"
description: ""
draft: false
tags:
- HomePage
title: Installing WordPress in Docker using Nginx and Php-Fpm 7
url: blog/wordpress-docker-nginx
---


It is evident that you don't need an introduction to Docker, WordPress or Nginx. So there is no point whatsoever in blabbering about each of these technologies, let's just jump right into the matter.

In this article, we will be looking into how you can setup a WordPress site in a Docker container that will be using Nginx along with php7-fpm.

### What's included in this Dockerfile?
The Docker image you create using the following Dockerfile will have the following

* Ubuntu 16.04
* Nginx (latest available for Ubuntu 16.04)
* PHP-FPM7
* WordPress (latest) 

Please note that this does not include a MySQL server. You either need a remote MySQL server or another container with MySQL setup properly to allow remote database access

### Okay, How to get things done?
I have made a github repository [HERE](https://github.com/MansoorMajeed/docker-wp-nginx-php7) Which contains all the information about how to set it up.
I am too lazy to have the instructions in here as well. 

If you need any help with any of it, leave a comment below and I shall try my best to address that, which is the purpose of this blog post.

