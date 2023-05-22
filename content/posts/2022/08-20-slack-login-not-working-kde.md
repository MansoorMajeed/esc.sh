
---
title: "Slack Login Not Working in Kde Plasma"
date: 2022-08-20T22:12:18-04:00
draft: false
url: blog/slack-login-issue-kde-plasma
---

## The Problem

You are running KDE Plasma on any flavour of Linux

You try to login to slack workspace using SSO/Google etc and even after loggin in the browser, nothing
happens in slack app.


This happens because of a bug that causes the slack workspace ID to be small case in the command line argument
used by slack to login.

## The Fix

The fix is pretty straight forward. Find the command used by slack to login to the workspace, edit it and
replace the workspace id with the upper case version of the same

1. Find the slack login command.

Open a terminal and run
```bash
while true; do ps aux|grep '[s]lack' | grep magic ; sleep 1; done
```

2. Open slack and try to login. Open the login page in the browser and continue until you see something in the terminal.

It should look something like this

```text
[mansoor@fedora ~]$ while true; do ps aux|grep [s]lack | grep magic ; sleep 1; done
mansoor     8504  0.0  0.2 34034340 52936 ?      Sl   12:40   0:00 /usr/lib/slack/slack --enable-crashpad slack://<your workspace id in small letters>/magic-login/<some long string>
```

3. Get the workspace ID, convert it into upper case, replace it into the same command, run it.

Like this:
```text
slack --enable-crashpad slack://WORKSPACE_ID_UPPERCASE/magic-login/<the same string from the previous command>
```


That's it, it should log you into slack this time
