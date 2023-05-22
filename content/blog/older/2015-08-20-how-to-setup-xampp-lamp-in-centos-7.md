---
author: Mansoor A
date: "2015-08-20T18:37:39Z"
description: ""
draft: false
title: How To Setup XAMPP (LAMP) In Centos 7
url: blog/how-to-setup-xampp-lamp-in-centos-7
---


This is still confusing for so many people. They just started to use Linux and they get confused when told about LAMP instead of XAMPP. Let me explain this to you. LAMP stands for `Linux Apache MySQL and PHP`. ie, it is a stack of Apache, MySQL, and PHP in a Linux environment.


Now, what is XAMPP? Well, it is something similar, but it's like an all in one package, you get a lot of things ( that includes those packages you need and you don't need )

For example, the XAMPP version 1.83 has the following packages:

 - Apache 2.4.7
 - MySQL 5.6.14
 - PHP 5.5.6
 - PEAR + SQLite 2.8.17/3.7.17 + multibyte support (mbstring)
 - Perl 5.16.3
 - phpMyAdmin 4.0.9
 - OpenSSL 1.0.1e
 - ProFTPD 1.3.4c
 - GD 2.0.35    
 - Freetype2 2.4.8.

  
Now, should I go with XAMPP or LAMP? That depends, if you are lazy and wants to get everything in a few clicks, go with XAMPP. (That works for a desktop machne) But, if you want to go bit more deep, and you need a light environment, go with LAMP.



### Step 1 : Let's start with Apache:

Open up a terminal in your Centos 7 machine and type
```
  sudo yum install epel-release
  sudo yum install httpd
```
    
That was painless. Phew..
 
Now, start the server by issuing the following command  
```
  sudo service httpd start
```
  
You can check if Apache is working by visiting `http://your_server_ip`. You can find out the IP of your server using
```
  curl ifconfig.co
```

Or if you're doing this on a local machine, you can open up `http://127.0.0.1/`. You will be greeted with the default page.

Before doing any modification to the configuration, it is advised that you backup the configuration file, so that in case you mess things up, you could easily revert back to the original configuration.

```
  cp /etc/httpd/conf/httpd.conf  /etc/httpd/conf/httpd.conf.original
```
  
> A word about Firewall: If you are setting it up on a server and have some sort of Firewall enabled (and you should), make sure you open up port 80 so that you can access it over the internet. If you are setting it up on a local machine, don't worry about it.


### Step 2: Installing MySQL ( MariaDB )

What is MariaDB?, you may ask. Well, MariaDB is a community fork of MySQL. It's the truly open source version of MySQL. 
It works exactly like MySQL. When Oracle acquired MySQL, the original developers of MySQL itself forked MariaDB and released under GPL license, so that it stays open source. Anyway, let's install it
  
```
  sudo yum install mariadb-server
```
  
Now let's start the service and set it to run at system startup.
  
```
  sudo systemctl enable mariadb.service
  sudo systemctl start mariadb.service
```
  

Now that our MySQL ( MariaDB ) server is installed, let's secure it. Run the following command.

```
  mysql_secure_installation
```
  
This will ask you a couple of questions, like

 - To change the MySQL root password : You should use a strong password
 - Remove anonymous users : You should remove anonymous users ( type yes )
 - Remove test databases : You should remove it
  
Once that's done, MySQL should be all set and running. You can login to your MySQL server using the following command

```
  mysql -u root -p
```
  
It will ask you for the MySQL root password, type it and press enter. That's it.!

### Step 3: Installing PHP

```
  sudo yum install php php-pear php-mysqlnd
```
  
Aaannd PHP is installed. Restart `httpd` so that it loads php
```
  sudo systemctl restart httpd
```

To test if PHP was installed properly, create a test file under your document root ( `/var/www/html` )
  
```
  echo '<?php phpinfo();?>' > /var/www/html/test.php
```
  
Now, in your browser, open the page : `http://your_ip_here/test.php` and you should see the phpinfo page

You should delete the `test.php` file once you made sure that everything is working.

```
rm /var/www/html/test.php
```

And, that's it. Your server is all set ( well, basically ) Now, get to work 😉

