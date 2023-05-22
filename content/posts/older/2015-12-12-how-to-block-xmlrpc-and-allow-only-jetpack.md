---
author: Mansoor A
date: "2015-12-12T22:36:22Z"
description: ""
draft: false
title: How to block XMLRPC, and allow only Jetpack
url: blog/how-to-block-xmlrpc-and-allow-only-jetpack
---


XML-RPC is a remote procedure call protocol with the data in "XML" format and the transport mechanism is "HTTP". WordPress provides an XMLRPC interface to your WordPress installation so that you can do all kind of stuff like, "Create a post", "edit a post" etc, remotely. Basically, you can do pretty much everything through the XML-RPC interface. Okay, that sounds cool. What is the problem?

#### The Problem with WordPress and XML-RPC

The problem is that there are a number of ways an attacker can take advantage of the XML-RPC interface, including, but not limited to DDOS attacks, and bruteforce attacks. The common type of attack was using your site to be a part of a DDOS attack. That is, you, the poor Joe's pet shop site is being used to DDOS another site. The feature exploited here is the "ping back" feature of WP, that is you get a ping back notification if someone mentions your blog post in their blog post. This was misused widely to do DDOS, and the end result is that normal, legitimate, clean ( I repeat, Clean, without any malware ) sites were being used for DDOS

Then, another type of attack, which was seen in the wild recently, tries to bruteforce your WordPress login through XML-RPC. This is not normal bruteforce, it is an amplified attack. Meaning, the attacker will be able to guess many hundreds of passwords in a single request. This is really difficult to detect as the number of requests made to the server is really less, compared to traditional brute-force attacks.

#### How do we defend ourselves?

Answer is simple, disable XML-RPC if you don't use it. Here is the problem. XML-RPC is used by many services/plugins, including Jetpack. If you disable XML-RPC completely, your Jetpack plugin won't work as it depends heavily on XMLRPC. So, what do we do? We disable XML-RPC for everyone, and allow only for Jetpack. Simple enough right?

##### Here is how you will disable XMLRPC, except for Jetpack

> NOTE: Please note that the IP range of Jetpack servers COULD change any time. Keep that in mind.

Add the following in your ".htaccess" file. You can find it under your document root. In cPanel servers, it is under "/home/username/public_html". Please note that if your WordPress installation is inside a sub-directory, you need the .htaccess file to be inside that directory.

```
<Files xmlrpc.php>
Order Deny,Allow
Deny from all
Allow from 192.0.64.0/18
Satisfy All
ErrorDocument 403 http://127.0.0.1/
</Files>
```

In case of nginx, add the following to your nginx conf

```
location = /xmlrpc.php {
    allow 192.0.64.0/18;
    deny all;
    access_log off;
    log_not_found off;
}
```

What it does is pretty simple. The rule means this: Deny everyone from accessing the file &#8216;xmlrpc.php' except from the IP subnet 192.0.64.0/18, which is the IP address of "AUTOMATTIC" - creator of JetPack.

That's it. Now only JetPack can access XMLRPC in your server, and you're pretty much safe from the attacks targeting XMLRPC

