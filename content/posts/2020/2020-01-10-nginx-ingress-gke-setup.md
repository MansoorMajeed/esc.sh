---
author: Mansoor A
categories:
- Kubernetes
- HomePage
date: "2020-01-10T00:07:00Z"
description: ""
draft: false
summary: How to setup the Nginx ingress controller in Google Kubernetes Engine to
  have better control over the controller
tags:
- Kubernetes
- HomePage
title: Setting up Nginx Ingress in GKE
url: blog/nginx-ingress-gke-setup
---


Nginx Ingress Controller offers a lot more features than the default ingress controller by GKE. This post explains how to quickly setup an Nginx ingress controller on your K8s cluster running on GKE

## The setup

First of all, we need to make your GCP user as the cluster admin so that you have the sufficient permissions to create the service accounts and whatnot

```bash
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin \
  --user $(gcloud config get-value account)
```

### If you have Kubernetes version older than 1.14

If you have an older version of Kubernetes, we need to make a small label change for it to work

```bash
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.2/deploy/static/mandatory.yaml
```

on line 217, change `kubernetes.io/os` to `beta.kubernetes.io/os`

Then
```bash
kubectl apply -f mandatory.yaml
```

If you don't do this, you will see an error as below

```bash
kubectl describe pod nginx-ingress-controller-5bcd4b688-9msjm -n ingress-nginx
Events:
  Type     Reason             Age                  From                Message
  ----     ------             ----                 ----                -------
  Warning  FailedScheduling   8s (x9 over 2m28s)   default-scheduler   0/3 nodes are available: 3 node(s) didn't match node selector.
  Normal   NotTriggerScaleUp  7s (x14 over 2m26s)  cluster-autoscaler  pod didn't trigger scale-up (it wouldn't fit if a new node is added): 3 node(s) didn't match node selector
```

This happens because in previous versions of k8s in GKE, the nodes are labelled as `beta.kubernetes.io/os=linux`



### If you have a newer than 1.14 k8s version

No need to edit anything

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.2/deploy/static/mandatory.yaml
```

### And finally

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.26.2/deploy/static/provider/cloud-generic.yaml
```

### Create the Ingress

Once you have created the ingress controller on your cluster, you can create the ingress resource.
An example is given below

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
  name: demo-ingress
  namespace: demo
spec:
  rules:
    - host: demo.example.com
      http:
        paths:
          - backend:
              serviceName: demo-backend
              servicePort: 9000
            path: /
    - host: demo2.example.com
      http:
        paths:
          - backend:
              serviceName: demo-backend-2
              servicePort: 9001
            path: /
  tls:
    - hosts:
        - demo.example.com
      secretName: tls-data
```

That's all

