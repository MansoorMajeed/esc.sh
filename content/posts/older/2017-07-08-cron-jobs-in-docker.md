---
author: Mansoor A
date: "2017-07-08T00:07:00Z"
description: ""
draft: false
title: Using cron in Docker containers ( Kubernetes )
url: blog/cron-jobs-in-docker
---


When it comes to Docker containers, even a simple task can be pretty confusing, like the cron jobs.
I know it was confusing for me at least. And I had to spent a lot of time scratching my head because my cron job just won't start.

### Backstory
Before we dive into how to setup the cron daemon to work with Docker containers, let's look into a problem I ran into *AFTER* setting up the cron in Docker, in Kubernetes running on Google Container Engine. This will be particulary helpful to those who managed to setup cron in the container, but the job is not starting.

So, I was playing around with Docker and Kubernetes in Google Cloud, I wanted to setup a cron to do an `ansible-pull` every 10 minute. 
I managed to setup everything, the cron daemon is running in the foreground and all is well. Well, except that the job is not starting. 
I tried all different combinations, like tried using the `crontab /path/to/file` command, tried putting the job in `/etc/cron.d/job-name`.
None of them worked.

Finally, I installed `rsyslog` in the container to see what the heck is going on. If you are wondering on how to do it, this is how I did it.

Get a shell in the container running in Kubernetes
```
kubectl exec -it nginx-g435x bash
```
You will have to replace `nginx-g435x` with your container ID. 
Then,
```
apt-get update && apt-get install rsyslog
```
I took a look at `/var/log/syslog` and there it is
```
Jul  8 18:32:01 nginx-g435x cron[101]: (*system*) NUMBER OF HARD LINKS > 1 (/etc/crontab)
Jul  8 18:32:01 nginx-g435x cron[101]: (*system*ansible-pull) NUMBER OF HARD LINKS > 1 (/etc/cron.d/ansible-pull)
```
So the cron is complaining that the `/etc/crontab` and `/etc/cron.d/ansible-pull` files containing the cron jobs are layered hard links.
Well of course it is, because it is docker and that's how it works. There is a debian bug reported with it [HERE](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=647193) if you are interested. Anyway, I was able to fix it, and I'll explain that down below.

### How to get cron working in Docker
To explain things easily and avoid as much as technical jargon, we'll use an example to see how to do it.

So, in this example, we will have a container running `nginx` and `cron`. That's it. It is a simple container. 
We will be using [s6-overlay](https://github.com/just-containers/s6-overlay) as the process supervisor ( which will start and keep an eye on our nginx and cron processes )

Create a file `crontab` with the cron job
```
$ cat crontab
* * * * * root /bin/date >> /tmp/date.log 
```
It's a simple cron that will write to the file `/tmp/date.log` the current date and time, every minute. You can replace it with whatever job you want.


Here is the Dockerfile

```
# The base image is Ubuntu 16.04
FROM ubuntu:16.04

# Get the s6-overlay package
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz /tmp/

# Extract the scripts to the root of the container
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Install nginx and make sure it runs in the foreground
RUN apt-get update && \
    apt-get install -y nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

ADD crontab /etc/cron.d/ansible-pull
RUN chmod 0600 /etc/cron.d/ansible-pull

COPY ./services.d /etc/services.d

ENTRYPOINT ["/init"]
CMD []
```
That is all for our Dockerfile. Now we need to create a directory `services.d` in the same directory as the Dockefile
Inside the `services.d` directory, create two directories named `cron` and `nginx`. Inside them, create a file named `run` and `finish`.

This is how the entire thing looks like
```
$ tree
.
├── Dockerfile
├── crontab
├── services.d
│   ├── cron
│   │   └── run
│   └── nginx
│       ├── finish
│       └── run
```

The file `run` tells how to start the service and `finish` tells what to do when a service exits.
Let's take a look at the content of each of these `run` files
```
$ cat services.d/cron/run
#!/usr/bin/with-contenv sh

# this line here is what we should have to get rid of the hard link error
touch /etc/crontab /etc/cron.*/*

exec cron -f
```

```
$ cat services.d/nginx/run
#!/usr/bin/with-contenv sh

exec nginx
```

Basically, these `run` scripts just starts the services in the foreground. Should something happen to these services and they exit, the s6-overlay will start them back. 

If you want the container to exit when one of the process is exited, you should create the `finish` file. Like below

```
$ cat services.d/nginx/finish
#!/usr/bin/execlineb -S0

s6-svscanctl -t /var/run/s6/services
```

What this does is, if the `nginx` process exits due to an error, the entire container will exit so that we know something's up and we can take a look at.
If you don't want the container to exit during an error, just don't put the `finish` file.


And that's it. This is how you run cron and another service in the same container ( and have cron do its job )

