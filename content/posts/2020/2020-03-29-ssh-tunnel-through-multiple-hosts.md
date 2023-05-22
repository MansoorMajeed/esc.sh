---
author: Mansoor A
categories:
- Ops
- HomePage
date: "2020-03-29T09:26:46Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/03/ssh_res.png
summary: Reaching databases behind firewall can be tricky. Here I am showing how to
  use the jumphost to tunnel to the database server
tags:
- Ops
- HomePage
title: Using SSH tunnel to reach a database server via JumpHost
url: blog/ssh-tunnel-through-multiple-hosts
---


Let's say you have a database server behind a firewall. Let it be a MySQL server at the host `mysql-server` at port number `3306`.

And the port number `3306` is not open to your local machine. But you have a JumpHost that have SSH to that `mysql-server` but it doesn't have direct access to port `3306`

The solution is pretty simple. You tunnel from your local machine to the jump host, from there you create another SSH tunnel to the `mysql-server` and then access the database

```
localhost (3306 via 22) --> jumphost (3306 via 22) --> mysql-server (3306 via 22)
```

This is how you can do it

```bash
ssh -A -t user@jumphost -L 3306:127.0.0.1:3306 ssh user@mysql-server -L 3306:127.0.0.1:3306 -N
```

The assumptions made:

* You have ssh access to jumphost over 22
* You have ssh access to mysql-server from jumphost
* You have your ssh key in the agent (`ssh-add ~/.your-key-location`)

