---
author: Mansoor A
categories:
- Quick Notes
- Ops
- Kubernetes
date: "2020-04-19T09:01:23Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/04/eks-service.png
summary: How to properly do an http to https redirect while using an ELB for SSL termination
tags:
- Quick Notes
- Ops
- Kubernetes
title: Redirect HTTP to HTTPS on EKS behind ELB without using ingress
url: blog/redirect-http-to-https-on-eks-behind-elb
---




## The Problem

If you have a service in AWS that is frontend by an Elastic Load Balancer (ELB) (let the backend be EKS or plain EC2 VMs) with SSL certificates from ACM. Now, the SSL termination happens at the ELB itself. Meaning, from the ELB to the backend the communication is through HTTP.

> Note: This post is assuming that your backend is fronted by an Nginx. Whether in EC2 or EKS.

Now, to be able to redirect from HTTP to HTTPS, you have the option of enabling the redirection if you are using Ingress with Kubernetes. ELB by default do not have an option to redirect from HTTP to HTTPS.

## Solution

You can use the `http_x_forwarded_proto` http header to do this. Like below

```nginx
server {
        listen 80 default_server;
        server_name your-domain.com;

        # Hack to enforce SSL. 

        if ($http_x_forwarded_proto != "https") {
          return 301 https://$host$request_uri;
        }
 }
```

This ensures that the HTTP requests are redirected to HTTPS, and no infinite redirect loop.This is my service.yml for reference

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:<your-acm-entry>
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "https"
  labels:
    app: nginx
    env: production
    namespace: default
spec:
  type: LoadBalancer
  ports:
    - port: 80
      name: http
      targetPort: 80
      protocol: TCP
    - port: 443
      name: https
      targetPort: 80
      protocol: TCP
  selector:
    app: backend
```



