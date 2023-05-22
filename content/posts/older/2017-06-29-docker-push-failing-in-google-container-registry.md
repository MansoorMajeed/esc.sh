---
author: Mansoor A
date: "2017-06-29T00:07:00Z"
description: ""
draft: false
title: Could not push Docker images to Google Container Registry
url: blog/docker-push-failing-in-google-container-registry
---


Today I updated the Docker daemon on my Mac ( Running macOS Sierra ) and after that, I just could not push any images to Google Container Registry. It fails with the following message

```
➜ gcloud docker -- push asia.gcr.io/my-project/my-image
ERROR: Docker CLI operation failed:

Error response from daemon: login attempt to https://appengine.gcr.io/v2/ failed with status: 404 Not Found

ERROR: (gcloud.docker) Docker login failed.
```

Luckily, the fix was simple enough.

Click on the Docker icon >> Preferences and uncheck `Securely store docker logins in macOS keychain`

![Docker Preferences](https://cdn.esc.sh/jekyll/docker/docker-preferences-1.png)

And then

![Docker Preferences](https://cdn.esc.sh/jekyll/docker/docker-preferences-2.png)

That's it. Restart the docker daemon and it should start working again.

