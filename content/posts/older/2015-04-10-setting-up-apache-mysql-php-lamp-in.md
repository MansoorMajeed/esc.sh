---
author: Mansoor A
date: "2015-04-10T06:16:00Z"
description: ""
draft: false
title: Setting up Apache, MySQL, PHP ( LAMP) in Elementary OS, Ubuntu 14.04, 14.10,
  15.04
url: blog/setting-up-apache-mysql-php-lamp-in
---


I'm gonna jump right into the "how to" part, cuz I know you are not gonna read the rest of it.</p> 


So, LAMP?

 - L - Linux
 - A - Apache
 - M - MySQL
 - P - PHP


How to set it up in your local machine or VPS running Ubuntu 14.04 or other derivatives like Elementary OS ( my favorite ). Well, here is how you will do it.
  
```shell
sudo apt-get update

# Install Apache
sudo apt-get install apache2

# Install MySQL
# Please note that this will ask you to setup a root password. Set up a strong one. 
# If you are only gonna use it in your local network, you don't have to worry about it. But, again, better
# be careful than be sorry.
sudo apt-get install mysql-server php5-mysql

# Install PHP and other modules so that everything works without any hiccup
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt

```
      
Well, that's it. We are all set. Everything should be installed without any problem. Now let's make sure that everything is working.


#### Check to see if apache is working
Open your browser and enter "localhost" in the address bar and you should see the default page of apache in ubuntu. If that does not work, if you are in a VPS try visiting your public IP address.

#### Check if MySQL is working:
In terminal, type:  "mysql -u root -p" and press enter. It should ask you for the mysql root password you set in the previous session. Once you enter the proper password, you should be in the MySQL command line.

#### Check to see if PHP is working properly:

Create a test file. Use your favorite text editor. For the sake of simplicity, we will just use nano.
    
```shell
nano /var/www/html/testing.php
```
    
Now, type in the following. And save it.
```php      
<?php phpinfo(); ?>
```

Now, visit "localhost/testing.php" and you should be greeted with a php info page. Basically, this page contains so much information about the configuration of your set up, and once you know php is working fine, you should delete the file "testing.php".

