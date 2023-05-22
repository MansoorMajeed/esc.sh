---
author: Mansoor A
date: "2015-11-20T13:37:41Z"
description: ""
draft: false
title: How to fix python errors when installing modules
url: blog/how-to-fix-python-errors-when-installing-modules
---


This is a quick article showing how to fix common errors you might face when you install a python module using "pip" or by downloading and running "python setup.py install"

The Following are the common errors you might come across

```bash
fatal error: Python.h: No such file or directory
  
#include "Python.h"
  
^
  
compilation terminated.
  
Compile failed: command &#8216;x86_64-linux-gnu-gcc' failed with exit status 1
```
Well, this error means you do not have the python development tools installed. The fix is simple,

### For Ubuntu 14.04, 15.04, 15.10 / Linux Mint 16, 17, 17.x and other derivatives:

```
sudo apt-get install python-dev
```

### For Centos 5/6/7, Fedora 21/22/23 and other derivatives

```
sudo yum install python-devel
```

 

This is another error you might get into

```
> ERROR: /bin/sh: 1: xslt-config: not found
> 
> \*\* make sure the development packages of libxml2 and libxslt are installed \*\*
> 
> Using build configuration of libxslt
  
> In file included from src/lxml/lxml.etree.c:323:0:
  
> src/lxml/includes/etree_defs.h:14:31: fatal error: libxml/xmlversion.h: No such file or directory
  
> #include "libxml/xmlversion.h"
  
> ^
  
> compilation terminated.
> 
> or
> 
> fatal error: libxml/xpath.h: No such file or directory
  
> #include "libxml/xpath.h"
  
> ^
  
> compilation terminated.
```

Again, the fix is simple, you install the required packages

### For Ubuntu/ Mint and other derivatives

```
sudo apt-get install libxml2-dev libxslt-dev python-dev lib32z1-dev
```

### For Centos / Fedora and other derivatives

```
yum install -y gcc libxml2 libxml2-devel libxslt libxslt-devel python-devel
```

 

These should fix most problems with python and installing modules. If neither of them works, you need to install some other package depending on the error. Look through the error and search for the package name. It should be easily available on the internet.

