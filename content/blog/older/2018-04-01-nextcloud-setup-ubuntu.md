---
author: Mansoor A
categories:
- Ops
- Selfhost
- Linux
- HomePage
date: "2018-04-01T00:07:00Z"
description: ""
draft: false
summary: Setting up a private NextCloud server for Contacts, Files, Calendars, Tasks
  and even video calling
tags:
- Ops
- Selfhost
- Linux
- HomePage
title: Setting up Nextcloud on Ubuntu
url: blog/nextcloud-setup-ubuntu
---


Nextcloud is like Dropbox, except that you host, control and own your data. Nextcloud is one of the most amazing open source software available out there. It can do a lot of things. A few of my favourites are:
 - File hosting (Images, Videos)
 - File syncing
 - Auto upload of images/videos from your devices
 - Contacts
 - Calendars
 - Tasks
 - Notes
 - Talk

And the list goes on. You can find out all the features you can have on Nextcloud [HERE](https://apps.nextcloud.com/). Long story short: Nextcloud is amazing. 

And this blog post is about setting up Nextcloud on your own server. I will be using a Digital Ocean Droplet with Ubuntu 16.04. 

> If you are looking for a cloud provider, I recommend Digital Ocean. They are simply amazing and cheap. You get a 1vCPU, 1GB ram cloud server for just 5$/month. Use [my referral link](https://m.do.co/c/b63c500f6bcd) and you will get 10$ and it might help me run this blog for free, without any ads. :)

Let's get started.

### Setting up Nginx
We will be using Nginx as our web server. Let's go ahead and install it
```bash
sudo apt-get update
sudo apt install nginx
```

Once nginx is installed, start it using
```bash
sudo systemctl restart nginx
```

If everything went, nginx should be up and running. You can verify that by visiting your VPS's public IP in a browser. You can find out your server's public ip by using the following
```bash
curl ifconfig.co
```

### Setting up SSL using Let's Encrypt
We need to make sure that all our traffic from the web browser to the Nextcloud server is encrypted using SSL. Let's encrypt is an amazing yet free way to get SSL certificates. 
```bash
sudo apt install letsencrypt
```
> We'll be using a domain that points to the nextcloud instance you just setup. If you have a domain named `example.com`, then we'll be using `cloud.example.com` for the Nextcloud instance. In the following examples, I will be using `cloud.example.com` and you should replace it with the domain name you will be using

Next, we will be adding a configuration that is exclusive to Let's encrypt. 
Create a file `/etc/nginx/snippets/letsencrypt.conf` with the following content. You can use your editor of choice.

If you are not familiar with any command line text editors, I recommend you use nano.
```bash
sudo nano /etc/nginx/snippets/letsencrypt.conf
```
Paste the following
```nginx
location ^~ /.well-known/acme-challenge/ {
    default_type "text/plain";
    root /var/www/letsencrypt;
}
```
Then, press `Ctrl+X` and then `Y` and press enter. This file will let Let's Encrypt verify your domain without causing any issues when you redirect all http traffic to https.

We need to create the directory `/var/www/letsencrypt` manually too.
```bash
sudo mkdir /var/www/letsencrypt
```

**Next, we need to configure our nginx server.**

Create the file `/etc/nginx/sites-enabled/nextcloud` with the following content
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name cloud.example.com;
    include /etc/nginx/snippets/letsencrypt.conf;

    # enforce https
    return 301 https://$server_name$request_uri;
}
```
Don't forget to replace `cloud.example.com` with your domain for nextcloud.

#### Retrieving the SSL certificates
We have the webserver setup ready for us to retrieve the SSL certificates. Let's go ahead and do that.

Run the following as root

Again, don't forget to use the correct domain name. Also, give a valid email address. This will be used for alerts regarding renewals and in case you lose your certificates.
```bash
sudo letsencrypt certonly --email your@email.address --agree-tos -a webroot --webroot-path=/var/www/letsencrypt/ -d cloud.example.com
```
Once that is done, if everything went fine, you should see a message saying that it successfully retrieved the certificates.

Let's encrypt certificates are valid for 90 days only and should be renewed before they expire. Luckily, when we install `letsencrypt` package, it adds a cron to renew the certificates. But, we'll need to reload nginx after the new certificates are retrieved. Let's add a cron to do that. 

Create a file `/etc/cron.d/reload-nginx` with the following content
```bash
30 2 1 * * root  /bin/systemctl reload nginx > /dev/null 2>&1
```
This will reload the nginx configuration every month so that it will use the newly fetched certificates.

#### Final Nginx configuration
As of now, we have only installed Nginx, but we did not configure it. 
Edi the file `/etc/nginx/sites-enabled/nextcloud` and paste the following. In one of the previous step, we added a server block in the same file, please note that the same is present in the following snippet. So, you can simply delete `/etc/nginx/sites-enabled/nextcloud` and create it again with the following.

```nginx
upstream php-handler {
    server unix:/var/run/php/php7.0-fpm.sock;
}

server {
    listen 80;
    listen [::]:80;
    server_name cloud.example.com;
    include /etc/nginx/snippets/letsencrypt.conf;
    # enforce https
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
     listen [::]:443 ssl http2;

    server_name cloud.example.com;


    ssl_certificate   /etc/letsencrypt/live/cloud.example.com/cert.pem;
    ssl_certificate_key   /etc/letsencrypt/live/cloud.example.com/privkey.pem;


    # Add headers to serve security related headers
    # Before enabling Strict-Transport-Security headers please read into this
    # topic first.
    # add_header Strict-Transport-Security "max-age=15768000;
    # includeSubDomains; preload;";
    #
    # WARNING: Only add the preload option once you read about
    # the consequences in https://hstspreload.org/. This option
    # will add the domain to a hardcoded list that is shipped
    # in all major browsers and getting removed from this list
    # could take several months.
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Robots-Tag none;
    add_header X-Download-Options noopen;
    add_header X-Permitted-Cross-Domain-Policies none;

    # Path to the root of your installation
    root /var/www/html/nextcloud/;

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    # The following 2 rules are only needed for the user_webfinger app.
    # Uncomment it if you're planning to use this app.
    #rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
    #rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json
    # last;

    location = /.well-known/carddav {
      return 301 $scheme://$host/remote.php/dav;
    }
    location = /.well-known/caldav {
      return 301 $scheme://$host/remote.php/dav;
    }

    # set max upload size
    client_max_body_size 512M;
    fastcgi_buffers 64 4K;

    # Enable gzip but do not remove ETag headers
    gzip on;
    gzip_vary on;
    gzip_comp_level 4;
    gzip_min_length 256;
    gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
    gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;

    # Uncomment if your server is build with the ngx_pagespeed module
    # This module is currently not supported.
    #pagespeed off;

    location / {
        rewrite ^ /index.php$uri;
    }

    location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)/ {
        deny all;
    }
    location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console) {
        deny all;
    }

    location ~ ^/(?:index|remote|public|cron|core/ajax/update|status|ocs/v[12]|updater/.+|ocs-provider/.+)\.php(?:$|/) {
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param HTTPS on;
        #Avoid sending the security headers twice
        fastcgi_param modHeadersAvailable true;
        fastcgi_param front_controller_active true;
        fastcgi_pass php-handler;
        fastcgi_intercept_errors on;
        fastcgi_request_buffering off;
    }

    location ~ ^/(?:updater|ocs-provider)(?:$|/) {
        try_files $uri/ =404;
        index index.php;
    }

    # Adding the cache control header for js and css files
    # Make sure it is BELOW the PHP block
    location ~ \.(?:css|js|woff|svg|gif)$ {
        try_files $uri /index.php$uri$is_args$args;
        add_header Cache-Control "public, max-age=15778463";
        # Add headers to serve security related headers (It is intended to
        # have those duplicated to the ones above)
        # Before enabling Strict-Transport-Security headers please read into
        # this topic first.
        # add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload;";
        #
        # WARNING: Only add the preload option once you read about
        # the consequences in https://hstspreload.org/. This option
        # will add the domain to a hardcoded list that is shipped
        # in all major browsers and getting removed from this list
        # could take several months.
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";
        add_header X-Robots-Tag none;
        add_header X-Download-Options noopen;
        add_header X-Permitted-Cross-Domain-Policies none;
        # Optional: Don't log access to assets
        access_log off;
    }

    location ~ \.(?:png|html|ttf|ico|jpg|jpeg)$ {
        try_files $uri /index.php$uri$is_args$args;
        # Optional: Don't log access to other assets
        access_log off;
    }
}
``` 
In this snippet, you will have to replace `cloud.example.com` with your domain name. You can use this single command to do that

```bash
sudo sed -i "s/cloud.example.com/cloud.yourdomain.com/g" /etc/nginx/sites-enabled/nextcloud
```
That's it. We are done with the nginx configuration. Please note that, nginx won't start now because we haven't installed php yet.

### Installing and configuring the database for Nextcloud
Nextcloud needs a database server to store the configurations and whatnot. We will be using `mariadb` which is a fork of `mysql`
```bash
sudo apt install mariadb-server mariadb-client
```
This will install the database server and the client tool. Right now, the server does not have a password set. Let's fix that
```bash
sudo mysql_secure_installation
```
This will ask you few questions. Answer them as follows
```bash
Enter current password for root (enter for none): <Enter>
Set root password? [Y/n]: Y
New password: <super-strong-mariadb-root-password>
Re-enter new password: <super-strong-mariadb-root-password>
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]: Y
Reload privilege tables now? [Y/n]: Y
```
Make sure you replace `super-strong-mariadb-root-password` with an actual, strong password.
Now, create a new file `/root/.my.cnf` with the following content
```
[client]
user=root
password=super-strong-mariadb-root-password
```
This way, you don't have to enter the mariadb root password every time you want to access the database console.

Restart the database server
```bash
sudo systemctl restart mysql.service
```

#### Create the database and user for nextcloud
If you are logged in as the root user, type `mysql` and press enter to get to the mariadb console. If you are not root, you can use `mysql -u root -p` and then enter the mysql root password.

We will be creating a database and a database user for our Nextcloud installation
Do as follows. Replace `strong_password` with an actual, strong password.
```bash
MariaDB [(none)]> create database nextcloud;

MariaDB [(none)]> CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'strong_password';

MariaDB [(none)]> GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'strong_password' WITH GRANT OPTION;

MariaDB [(none)]> FLUSH PRIVILEGES;
```
Keep note of the password you chose there. We will need to update this later when Nextcloud asks us for the password.


### Setting up Nextcloud
Nextcloud is written in php. So, we need php to be able to run Nextcloud. Let's install it.
```bash
sudo apt install unzip php-fpm php-mbstring php-xmlrpc php-soap php-apcu php-smbclient php-ldap php-redis php-gd php-xml php-intl php-json php-imagick php-mysql php-cli php-mcrypt php-ldap php-zip php-curl
```
Let's download the latest stable version of Nextcloud. As of now, 13.01 is the latest version.
```bash
cd /tmp
wget https://download.nextcloud.com/server/releases/nextcloud-13.0.1.zip
unzip nextcloud-13.0.1.zip
sudo mv nextcloud /var/www/nextcloud
sudo chown -R www-data:www-data /var/www/nextcloud
```

And that's it. As a last step in the configuration, let's restart nginx so that it reloads the configuration and be ready to rock.

```bash
sudo systemctl restart nginx
```

Now, open `http://cloud.yourdomain.com` in your browser, it should redirect to `https://cloud.yourdomain.com`
and you should be greeted with the Nextcloud final setup screen. It will ask for the database details. Give it as follows
 - Database user : nextcloud
 - Database pasword : The one you set in the previous step (strong_password in my case)
 - Database name : nextcloud

Click on Finish setup.

That's it. Congratulations. You have successfully installed Nextcloud and is ready to use. If you have a question, leave a comment and I will try to address it as soon as possible :)

