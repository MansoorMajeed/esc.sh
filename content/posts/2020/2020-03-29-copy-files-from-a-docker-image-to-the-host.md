---
author: Mansoor A
categories:
- Docker
- Ops
- Quick Notes
date: "2020-03-29T14:01:45Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/03/docker.png
summary: 'A quick way of copying files stored in a docker image to the host system '
tags:
- Docker
- Ops
- Quick Notes
title: Copy files from a Docker image to the host
url: blog/copy-files-from-a-docker-image-to-the-host
---


For whatever reason if you would like to copy a file or directory from a Docker image to the host system, this is how you can do it

```bash
docker run --rm -v /path/on/image:/path/on/host name-of-your-docker-image:tag sh -c "cp -r /path/on/image /path/on/host"
```

For example, if I want to copy `/app/build` from the Docker image to `/tmp/build` on my host machine, I can do

```bash
docker run --rm -v /app/build:/tmp/build name-of-your-docker-image:tag sh -c "cp -r /app/build /tmp/build"
```



