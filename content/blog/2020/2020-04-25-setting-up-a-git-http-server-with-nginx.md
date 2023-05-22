---
author: Mansoor A
categories:
- SRE
- Ops
date: "2020-04-25T06:53:55Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/04/git-http.png
summary: How to easily setup a git http server using nginx and git-smart-http
tags:
- SRE
- Ops
title: Setting up a Git HTTP server with Nginx
url: blog/setting-up-a-git-http-server-with-nginx
---


Recently, I was in a situation where I had a few hundred clients reading from a git repository simultaneously. The default git over ssh was painfully for my use case and I started looking for git over http. This is how I was able to make it work with `Nginx` and `git-smart-http`

## Install the required packages

```
sudo apt-get install nginx git fcgiwrap apache2-utils -y
```

```
nginx: is needed as the webserver
git: well, git. 
fcgiwrap: will be our interface to the git-http-backend
apache2-utils: is needed to generate the password hash for authentication
```

## Configure the repository

Create the directory where you want to store the repositories.

```bash
sudo mkdir /srv/git
```

Make sure nginx has proper permissions to this directory

```bash
sudo chown -R www-data. /srv/git
```

Let's create our repository, let's call it `repo1`

```bash
sudo cd /srv/git
sudo mkdir repo1
sudo cd repo1
sudo git init . --bare --shared 
sudo git update-server-info
```

### Enable git push

By default the service that is used for git push (receivepack) is disabled, meaning you won't be able to push to the repository via http. Let's enable that

Navigate to your repository `/srv/git/repo1` and edit the file `config` in your favourite text editor (I mean vim. If you prefer emacs, stop reading and go somewhere else. If you prefer nano, you can stay ;) )

Add the following entry to the /`srv/git/repo1/config` file

```
[http]
    receivepack = true
```

This is how my `/srv/git/repo1/config` file look like

```
root@debian:~# cat /srv/git/repo1/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        sharedrepository = 1
[receive]
        denyNonFastforwards = true
[http]
    receivepack = true
root@debian:~#
```

Once that is done, run the following commands for the changes to take effect (Obviously, these commands needs to be run from the repository on the server)

```bash
git config --bool core.bare true
git reset --hard
```

Let's set the permissions once again

```bash
sudo chown -R www-data:www-data /srv/git
```

## Configuring Nginx

Now that we have our repository ready to serve, let's setup Nginx.

Create your nginx config file at `/etc/nginx/sites-enabled/git` or whatever file you want to. Copy the following into it

```nginx
server {
    listen       80;
    server_name  git.mydomain.com;

    # This is where the repositories live on the server
    root /srv/git;


    location ~ (/.*) {
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/.gitpasswd;
        fastcgi_pass  unix:/var/run/fcgiwrap.socket;
        include       fastcgi_params;
        fastcgi_param SCRIPT_FILENAME     /usr/lib/git-core/git-http-backend;
        # export all repositories under GIT_PROJECT_ROOT
        fastcgi_param GIT_HTTP_EXPORT_ALL "";
        fastcgi_param GIT_PROJECT_ROOT    /srv/git;
        fastcgi_param PATH_INFO           $1;
    }
}
```

### Generating the password hash

As you may have noticed, we are restricting the access to the git repository using http basic authentication. Now we need to generate a username and password.

Run the following. Make sure to replace `user` with a username of your choice.

This will ask you to enter a password. Enter a strong one. You will be using this password for authenticating to this repository

```bash
sudo htpasswd -c /etc/nginx/.gitpasswd user
```

## Starting services

Now that we have everything installed and configured, we can start our services

Before starting, verify that you didn't mess up the nginx configuration. Run the below command

```bash
sudo nginx -t
```

If you did something wrong, Nginx won't be shy to pointing it out. Fix it before continuing.

```bash
# Make sure these services start on boot
sudo systtemctl enable fcgiwrap
sudo systtemctl enable nginx

# Start them now
sudo systtemctl start fcgiwrap
sudo systtemctl start nginx
```

## Let's test it

By this point, you should have everything you need (theoretically speaking)

Let's see if it works.

From one of your client, run the below command. Make note of the username and password. `user:foo` and make sure you replace it with the correct username and password from the previous step.

```bash
git clone http://user:foo@git.mydomain.com/repo1
```

Now you should be able to do your usual git things. (At least it works for me :shrug: )

```bash
➜  /tmp git clone http://user:foo@git.mydomain.com/repo1
Cloning into 'repo1'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
➜  /tmp
➜  /tmp cd repo1
➜  repo1 git:(master)
➜  repo1 git:(master) ls -l
total 4
-rw-r--r-- 1 mansoor wheel 5 Apr 25 12:14 hello.md
➜  repo1 git:(master) echo 'version 2' > hello.md
➜  repo1 git:(master) ✗
➜  repo1 git:(master) ✗ git add . && git commit -m "version 2"
[master b20c024] version 2
 1 file changed, 1 insertion(+), 1 deletion(-)
➜  repo1 git:(master)
➜  repo1 git:(master) git push origin master
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Writing objects: 100% (3/3), 251 bytes | 251.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To http://git.mydomain.com/repo1
   5d42d6c..b20c024  master -> master
➜  repo1 git:(master)
➜  repo1 git:(master)
```

Alright, that's it. Leave a comment if it didn't work

