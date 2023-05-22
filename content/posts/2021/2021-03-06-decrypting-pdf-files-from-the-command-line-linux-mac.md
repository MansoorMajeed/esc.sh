---
author: Mansoor A
categories:
- HowTo
date: "2021-03-06T04:46:51Z"
description: ""
draft: false
summary: Sometimes you need to mass decrypt PDF files (Telephone bill comes to mind).
  Opening them one by one and entering the password, finding a way to export them
  to a non encrypted file all seem too tedious. Let's do it from the command line
tags:
- HowTo
title: Decrypting PDF files from the command line (Linux/Mac)
url: blog/decrypting-pdf-files-from-the-command-line-linux-mac
---


### Why?

Sometimes you need to mass decrypt PDF files (Telephone bill comes to mind). Opening them one by one and entering the password, finding a way to export them to a non encrypted file all seem too tedious. Let's do it from the command line

### Requirements

* MacOS or Linux or WSL with Linux

### How to do it

**On Mac**

Make sure you have homebrew installed. If not, go [HERE](https://brew.sh/)

```
brew install qpdf

```

**On Linux**

```
sudo apt install qpdf
```



**To decrypt a single file**

```
qpdf --password=yourpass --decrypt input.pdf output.pdf
```

**Decrypting everything in a directory**

For this, keep all your pdf files that needs to be decrypted into a single directory, and then from that directory, do:

```
mkdir decrypted

for i in `ls *.pdf`;do qpdf --password=yourpassword --decrypt $i decrypted/$i;done
```

This will put all the decrypted PDFs in the directory `decrypted`

**Take only one page from the PDF**

```
for i in `ls *.pdf`;do qpdf --password=<pdf password> --decrypt --pages . 1 --  $i decrypted/$i;done
```



