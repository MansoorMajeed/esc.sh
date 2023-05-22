---
author: Mansoor A
date: "2016-10-15T00:07:00Z"
description: ""
draft: false
title: '[Kali Linux] Fixing Wpscan due to broken dependencies'
url: blog/kali-linux-fix-wpscan-dependencies
---


Let's keep it short and simple. You have a problem with Wpscan on your Kali Linux machine and you need to fix this thing and get to work.  
So, yeah. This is how the problem looks like.

When you try to run wpscan, it says "cannot load such file -- nokogiri/nokogiri". It basically means that a ruby gem that is required by wpscan is not installed. This probably happened after an update. 

```
root@kali:~# wpscan --help
[ERROR] cannot load such file -- nokogiri/nokogiri
```

Anyway, the fix is quite simple. Just install the gem. Go ahead and try that
```
gem install nokogiri
```
If the installation went fine and you did not see any errors, well, great then. You're good to go.  
But, if you see an error like this:
```
root@kali:~# gem install nokogiri
Fetching: mini_portile2-2.1.0.gem (100%)
Successfully installed mini_portile2-2.1.0
Fetching: nokogiri-1.6.8.1.gem (100%)
Building native extensions.  This could take a while...
ERROR:  Error installing nokogiri:
    ERROR: Failed to build gem native extension.
 
    current directory: /var/lib/gems/2.3.0/gems/nokogiri-1.6.8.1/ext/nokogiri
/usr/bin/ruby2.3 -r ./siteconf20161016-1558-1etjmne.rb extconf.rb
mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h
 
extconf failed, exit code 1
 
Gem files will remain installed in /var/lib/gems/2.3.0/gems/nokogiri-1.6.8.1 for inspection.
Results logged to /var/lib/gems/2.3.0/extensions/x86_64-linux/2.3.0/nokogiri-1.6.8.1/gem_make.out
```

We will need to install another few packages.
```
apt-get install ruby-dev libxml2 zlib1g-dev
```
Once that is done, you should be able to install nokogiri without any issues.

```
gem install nokogiri
```
There you go.

