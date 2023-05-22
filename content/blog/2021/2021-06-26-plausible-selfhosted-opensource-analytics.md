---
title: "Plausible - How to setup self hosted analytics on Debian 10"
description: "Plausible is an open source analytics software that can be used on apps and websites"
date: 2021-06-26T19:03:00+05:30
lastmod: 2021-06-26T19:03:00+05:30
draft: false
images: []
url: blog/plausible-analytics-selfhosting
---
I've been trying to get rid of Google analytics and use a self hosted solution instead and I finally
found a worthy replacement - [Plausible](https://plausible.io/). Simple, fast, and clean UI.

What I did was, I signed up for their free trial and after using it for few days, I really liked it and wanted
to self host it on my own server.

Here is how to set it up on your own server

> I am using Google Cloud to host my VM, the instructions are the same regardless of where you host it
> I am using Debian 10 here, I recommend you do the same.

## What we will be doing here

- Install docker and docker compose
- Bring up Plausible and associated services
- Setup Nginx reverse proxy
- Setup free SSL certificate using let's encrypt
- Cron to renew certificates

## Step 1 : Install docker

We will be using docker to bring up the services as it would be 100 times easier this way than to try and install
each component manually on the VM directly

```bash
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Now we need docker-compose to bring up everything in single command. Install docker compose using:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Step 2 : Get Plausible

Plausible have already created a `docker-compose.yml` for us so it is pretty straight forward to get started.

```bash
git clone https://github.com/plausible/hosting
mv hosting/ plausible
cd plausible
```

> I am renaming `hosting` to `plausible` to avoid future confusions


## Step 3 : Configure Plausible


Edit the file `plausible-conf.env` and update it with relevant information.

- `BASE_URL` should be where your analytics service running. Example `stats.example.com`
- `SECRET_KEY_BASE` can be generated using the command `openssl rand -base64 64`

```
ADMIN_USER_EMAIL=you@email.com
ADMIN_USER_NAME=username
ADMIN_USER_PWD=xxxxxx
BASE_URL=https://stats.esc.sh
SECRET_KEY_BASE=xxxxxxxxxxxxxxx==
```


## Step 4 : Change network interface for plausible

By default, the plausible docker container will be listening on all network interfaces (`0.0.0.0`). We don't need this as we will
be configuring our Nginx reverse proxy. So let's change it to `127.0.0.1`.

Edit the `docker-compose.yml` and change the `ports` value to `- 127.0.0.1:8000:8000`.
The section should look like this
```yml
plausible:
    image: plausible/analytics:latest
    command: sh -c "sleep 10 && /entrypoint.sh db createdb && /entrypoint.sh db migrate && /entrypoint.sh db init-admin && /entrypoint.sh run"
    depends_on:
      - plausible_db
      - plausible_events_db
      - mail
    ports:
      - 127.0.0.1:8000:8000
```

## Step 5 : Bring it up!

Let's start all the services using
```
sudo docker-compose up -d
```

This does the following things:

- Creates a Postgres database for user data
- Creates a Clickhouse database for stats
- Runs migrations on both databases to prepare the schema
- Creates an admin account (which is just a normal account with a generous 100 years of free trial)
- Starts the server on port 8000


At first run, the plausible container will fail. Just restart it once and it should work fine
```
sudo docker-compose restart plausible
```


## Step 6 : Configuring Reverse Proxy

### Setup the domain

We obviously need a domain pointing to the server's IP address. This should be the same as `BASE_URL` in the `plausible-conf.env`
I will use `stats.esc.sh` as an example here. Go to your DNS provider and add an `A` record pointing to your server IP address

### Install Nginx and Certbot

We will install Nginx for reverse proxy, certbot for free SSL certificate
```bash
sudo apt install nginx certbot python3-certbot-nginx
```

### Configure Nginx for Let's Encrypt

We will be using Let's Encrypt for free SSL certificates, also we will be redirecting http to https.
When we do that, we still want the let's encrypt challenges that happen over http to continue to work
without getting redirected. So, we use the following snippet

Create `/etc/nginx/snippets/letsencrypt.conf` with the following content

```nginx
location ^~ /.well-known/acme-challenge/ {
    default_type "text/plain";
    root /var/www/letsencrypt;
}
```

Now, create the directory
```bash
sudo mkdir /var/www/letsencrypt
```

Create nginx config `/etc/nginx/sites-enabled/stats.esc.sh`

```nginx
server {
    listen 80;

    include /etc/nginx/snippets/letsencrypt.conf;

    server_name stats.esc.sh;
}
```

> Make sure to update it to use your own domain name

Verify that Nginx is working fine and restart it
```bash
sudo nginx -t
sudo systemctl restart nginx
```

### Fetch the TLS certificates

Now we can request for certificates using:
```bash
sudo certbot --nginx -d stats.yourdomain.com
```
This should show a few prompts
- enter email to get notifications of expiry
- `A` for agree
- Choose Y/N
- 1 - No redirection

At this point certbot would have updated the nginx configuration.. should look like this

```nginx
server {
    listen 80;

    include /etc/nginx/snippets/letsencrypt.conf;

    server_name stats.esc.sh;

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/stats.esc.sh/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/stats.esc.sh/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}
```

### Plausible reverse proxy configuration

Now, we need to enable http -> https redirection. Also, we need to add the proxy config for plausible.

Make changes to look like this. Make sure to use your own domain name

```nginx
server {
    listen 80;

    include /etc/nginx/snippets/letsencrypt.conf;

    server_name stats.esc.sh;

    location / {
       return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/stats.esc.sh/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/stats.esc.sh/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

    server_name stats.esc.sh;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```



## Step 7 : Setup Plausible

Login at https://stats.domain.com with the username and password from the config

It will ask to activate the account, we can do this manually.

```bash
sudo docker exec plausible_plausible_db_1 psql -U postgres -d plausible_db -c "UPDATE users SET email_verified = true;"
```

This should set your account as verified and you should be able to start using Plausible
