---
author: Mansoor A
date: "2015-12-11T23:32:44Z"
description: ""
draft: false
title: Setting up VirtualHost in Centos 7
url: blog/setting-up-virtualhost-in-centos-7
---


This is gonna be a quick and dirty post about how to properly setup VirtualHost in Centos 7. I mainly made this as part of the Let's encrypt setup. So, yeah let's get started

First of all, you obviously need to install the LAMP stack in your server. Go <a href="https://digitz.org/blog/how-to-setup-xampp-lamp-in-centos-7/" target="_blank">HERE</a>

#### Create the directory structure

We need a specific directory structure so that we can easily manage the VirtualHosts. Here, I'll be using the structure `/var/www/site1.com/public_html` as the document root for site1.com and so on

```
# Let us create the directory
mkdir -p /var/www/dev1.digitz.org/public_html

# Here "dev1.digitz.org" is the domain name I'm gonna be using in this example
# replace it with your desired domain name

# Give the ownership of the directories to Apache
chown -R apache. /var/www/dev1.digitz.org

# Set the permissions properly
chmod -R 755 /var/www
```

Now let us create a "Hello World" index file. This is just to make sure that our new virtualhost works.

```
echo 'hello world' > /vaw/www/dev1.digitz.org/public_html/index.html
```

Make sure that you replace *dev1.digitz.org* with your domain name.

#### Configuring the VirtualHost

```
# Create a directory to hold the virtualhost configuration files
mkdir /etc/httpd/sites-enabled
mkdir -p /var/log/apache/dev1.digitz.org/ 

# Edit the "/etc/httpd/conf/httpd.conf" file and add the following at the end of the file
IncludeOptional sites-enabled/*.conf

# If you do not know how to edit the file, do the following
echo 'IncludeOptional sites-enabled/*.conf' >> /etc/httpd/conf/httpd.conf
```

Great.  Now let us create the VirtualHost configuration file.

```
nano /etc/httpd/sites-enabled/dev1.digitz.org.conf
```

Make sure you replace the domain name with your domain name. Now paste the following content in to the file

```
	<VirtualHost *:80>
	ServerName dev1.digitz.org
	DocumentRoot /var/www/dev1.digitz.org/public_html
	ErrorLog /var/log/apache/dev1.digitz.org/error.log
	CustomLog /var/log/apache/dev1.digitz.org/access.log combined
	</VirtualHost>
```

Now press `Ctrl+X` and then `Y` and press enter. The configuration now should be saved

```
# Restart apache
systemctl restart httpd
```

Aaanddd, done. That's it. Now, go ahead and open up your domain in your browser and you should see your "Hello world" message.

