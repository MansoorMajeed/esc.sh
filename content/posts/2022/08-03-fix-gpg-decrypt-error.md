---
title: "Fix Gpg Decrypt Error : Inappropriate ioctl for device"
description: ""
author: Mansoor
date: 2022-08-03T22:32:37-04:00
lastmod: 2022-08-03T22:32:37-04:00
draft: false
url: blog/gpg-error-inappopriate-ioctl-for-device
images: []
---

## The Error

When you try to decrypt something using gpg and if gpg is reading the input from a pipe, like this `echo "something encrypted" | gpg --decrypt`, it fails with the
following error

```text
gpg: public key decryption failed: Inappropriate ioctl for device
gpg: decryption failed: Inappropriate ioctl for device
```

## The solution

This happens because GPG does not know where to read the input from, simply set the env variable `GPG_TTY`.

```text
export GPG_TTY=$(tty)
```

If you use GPG more often and if you would like to persist this environment variable, append it to your `~/.zshrc` or `~/.bashrc`
