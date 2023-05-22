---
title: "Local Development on Kubernetes using Skaffold"
description: ""
lead: ""
date: 2022-10-04T11:28:46-04:00
lastmod: 2022-10-04T11:28:46-04:00
draft: false
url: blog/local-development-on-kubernetes-using-skaffold/
---
## What is Skaffold

[Skaffold](https://skaffold.dev/) is a local Kubernetes development tool that can help in building and deploying applications locally (or to any Kubernetes cluster for that matter).

It's like docker compose, but with just Kubernetes.

{{< vimeo 756884582 >}}

## What can I use it for?

Say you have an app you are developing, and it will be running in a Kubernetes cluster in production, then it makes sense to have a similar Kubernetes environment for developing. You can use Skaffold instead of docker compose for local development

Take a peek [HERE](https://skaffold.dev/docs/#features) for a list of features


## How to use it

TL;DR : [Git Repo](https://github.com/mansoormajeed/skaffold-poc)

Here I will show you a quick demo on how to use Skaffold in developing a Golang based app.

### 1. Install Skaffold CLI on your local machine

This is the only installation you need.

Go [HERE](https://skaffold.dev/docs/install/) and install the tool following instructions specific to your local operating system.

For MacOS, you can install it using
```shell
brew install skaffold
```

### 2. Make sure your local Kubernetes cluster is up and ready

You would need a local Kubernetes cluster (obviously), it is up to you to use which environment because it depends on your already existing workflow.

Here are few things to consider

#### If you are using Linux

You are probably using the native docker daemon and all you need is a Kubernetes cluster. To keep things simple, I would recommend you to try [minikube](https://minikube.sigs.k8s.io/docs/start/) 

#### If you are using MacOS

You probably are using Docker Desktop for all your docker needs. Then I recommend you to use the Kubernetes option that comes with docker desktop. You can enable it in Docker settings.

You can also use Minikube, but one thing to note here is that Docker Desktop uses its own Virtual Machine, if you use Minikube in addition to that, Minikube is going to use another Virtual Machine. So, there will be two VMs.

IMO, it would be better to go with Docker Desktop + Kubernetes cluster that comes with it

#### If you are using Windows

> Why are you doing this to yourself?

But, yeah, Docker Desktop comes with Kubernetes, give that a try first. Then look into Minikube if it does not work.

### 3. Get the Skaffold POC repo

This is completely optional. If you want to start from scratch, you can run `skaffold init` on a project directory and go from there. Maybe just use the [repo](https://github.com/mansoormajeed/skaffold-poc) as a reference.

It would be much easier to just clone it and modify it to your needs, or just to get a feel of how things work for the first time.

```shell
git clone https://github.com/MansoorMajeed/skaffold-poc.git
```


#### Contents of the repo

- Dockerfile : You know what this is
- main.go, go.mod : The demo app and the module file
- k8s-pod.yml : The kuberenetes deployment that will run the demo app
- k8s-service.yml : The Kubernetes service that will expose our demo app
- skaffold.yaml : The skaffold specific configuration

### 4. Running it

There are a few different ways you can run it.

#### Running it once (no reload)
```bash
skaffold run --kube-context docker-desktop
```
This will run the whole stack.
The `--kube-context` argument is specified so that we are forcing skaffold to run it on our local cluster. Make sure to use the correct one depending on docker-desktop or minikube

> By default skaffold will try to use the current cluster context

#### Development mode (use this when you are developing)

This is my favourite mode.

```bash
skaffold dev --kube-context docker-desktop --port-forward
```

This will start a development environment with live reload. Every time you save your codebase, it will rebuild the image and redeploy the pods. Sweet!

