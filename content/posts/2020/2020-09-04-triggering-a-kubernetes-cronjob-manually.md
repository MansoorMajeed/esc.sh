---
author: Mansoor A
categories:
- Quick Notes
- Kubernetes
date: "2020-09-04T07:41:30Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/09/k8s-logo-dark.png
summary: What to do when you want to trigger a Kubernetes cronjob manually, once
tags:
- Quick Notes
- Kubernetes
title: Triggering a Kubernetes Cronjob manually
url: blog/triggering-a-kubernetes-cronjob-manually
---


Sometimes you may need to quickly trigger a kubernetes cronjob and the next interval of execution is pretty far. This is how you could do it.

The idea is pretty simple, you create a new job out of the cronjob definition and that job will run to finish. Nothing more to worry about

```
kubectl create job --from=cronjob/<cronhob> <job>
```

For example, let's say you have a cronjob named `backup` and you want to run it manually once. You can create a new job like this

```
kubectl create job --from=cronjob/backup backup-manual
```

That's all

