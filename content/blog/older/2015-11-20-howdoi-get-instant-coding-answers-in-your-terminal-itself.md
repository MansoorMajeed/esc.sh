---
author: Mansoor A
date: "2015-11-20T13:12:43Z"
description: ""
draft: false
title: '"Howdoi" - Get instant coding answers in your terminal itself'
url: blog/howdoi-get-instant-coding-answers-in-your-terminal-itself
---


If you're  a sysadmin, programmer, or even a hacker, you might come across a situation where you quickly want to know an answer to a simple question, like "How to get epoch time on bash?", or whatever. What you usually do is, open up the browser, start searching in google. But, what if I told you you can get the answer from your command line / terminal itself? Sounds cool, right? There is this tool called "howdoi" which does exactly that. I'll show you a couple of examples to get the idea of how this tool can help you.

The following is several queries i made to check if this tool actually works. Don't ask me if it works, checkout for yourself.

```
root ~ # howdoi epoch time in bash
date +%s


root ~ # howdoi multiline comment in python
'''
This is a multiline
comment.
'''


root ~ # howdoi  sort ls by modified time
ls -t


root ~ # howdoi unique array python
my_list = list(set(my_list))


root ~ # howdoi unique php array
$input = array_map("unserialize", array_unique(array_map("serialize", $input)));


root ~ # howdoi declare hash perl
use strict;
use warnings;  # Must-haves

# ... Initialize your arrays

my @fields = ('currency_symbol', 'currency_name');
my @array = ('BRL','Real');

# ... Assign to your hash

my %hash;
@hash{@fields} = @array;
```

How about that? It does a  google search and gives you the best answer. I'm pretty sure that you're impressed. So, let me show you how you can install it

### How to install "howdoi" on your Linux Machine

#### For Ubuntu / Linux Mint and other derivatives:

```
# First of all, you need to install some libraries.. 
sudo apt-get install libxml2-dev libxslt-dev python-dev lib32z1-dev

# Install PIP if not already installed
sudo apt-get install python-pip

# install "howdoi" using pip
sudo pip install howdoi
```

#### For Centos 5/6/7 / Fedora 21/22 and other rpm based distros:

```
# Install the required packages and libraries
sudo yum install -y gcc libxml2 libxml2-devel libxslt libxslt-devel python-devel

# Install epel repo if not already installed
sudo yum install epel-release

# install pip
sudo yum --enablerepo=epel install python-pip

# install "howdoi" using pip
sudo pip install howdoi
```

That's it, "howdoi" is now installed on your machine. All you have to do is, open up a terminal and type "howdoi" followed by the query ( just like in the examples i presented above )

