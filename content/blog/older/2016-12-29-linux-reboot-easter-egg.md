---
author: Mansoor A
date: "2016-12-29T00:07:00Z"
description: ""
draft: false
title: Linux Reboot System call and Linus' Birthday
url: blog/linux-reboot-easter-egg
---


Today (28-Dec)  is Linus Torvald, Linux creator's birthday and I wanted to share with you an easter egg hidden in the Linux `reboot()` system call.

#### From man page of reboot

```
SYNOPSIS:
--------
#include <unistd.h>
#include <linux/reboot.h>
int reboot(int magic, int magic2, int cmd, void *arg);

DESCRIPTION:
------------
The reboot() call reboots the system, or enables/disables the reboot
keystroke (abbreviated CAD, since the default is Ctrl-Alt-Delete; it
can be changed using loadkeys(1)).

This system call will fail (with EINVAL) unless magic equals
LINUX_REBOOT_MAGIC1 (that is, 0xfee1dead) and magic2 equals
LINUX_REBOOT_MAGIC2 (that is, 672274793).  However, since 2.1.17 also
LINUX_REBOOT_MAGIC2A (that is, 85072278) and since 2.1.97 also
LINUX_REBOOT_MAGIC2B (that is, 369367448) and since 2.5.71 also
LINUX_REBOOT_MAGIC2C (that is, 537993216) are permitted as values for
magic2.  (The hexadecimal values of these constants are meaningful.)
```

You can find these variables and their values in the `reboot.h` header file in the Linux kernel source repository.

```
root@server7:~/linux# grep 'LINUX_REBOOT_MAGIC' include/uapi/linux/reboot.h
#define     LINUX_REBOOT_MAGIC1     0xfee1dead
#define     LINUX_REBOOT_MAGIC2     672274793
#define     LINUX_REBOOT_MAGIC2A     85072278
#define     LINUX_REBOOT_MAGIC2B     369367448
#define     LINUX_REBOOT_MAGIC2C     537993216
```

So, there are few magic numbers `LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_MAGIC2A, LINUX_REBOOT_MAGIC2B, LINUX_REBOOT_MAGIC2C` in Linux, which are needed as the argument of the reboot system call. The values of these variables are mentioned in the man page itself. What are these numbers anyway? Well, it turns out these are not just random numbers. Let's see what we can find out.

Converting these numbers into hexadecimal reveals something interesting. In case you are confused, the `printf "%x\n" 1234` will convert 1234 into hexadecimal.

```
root@server7:~/linux# printf "%x\n" 672274793
28121969  ( 28-12-1969) - Birthday of Linus

root@server7:~/linux# printf "%x\n" 85072278
5121996  (5-12-1996) - Birthday of Patricia Miranda, Linus’ first daughter

root@server7:~/linux# printf "%x\n" 369367448
16041998 (16-04-1998) - Birthday of Daniela Yolanda, Linus’ second daughter

root@server7:~/linux# printf "%x\n" 537993216
20112000 (20-11-2000) - Birthday of Celeste Amanda, Linus’ third daughter.
```

I mean, that's kinda cool. :D 
Oh, and, *Happy Birthday, Linus. Thank you for giving us Linux. And git. ;)*

