---
author: Mansoor A
date: "2016-06-28T11:07:00Z"
description: ""
draft: false
title: Perl CGI scripts and PATH env variable
url: blog/perl-cgi-path-env
---


If you are trying to invoke system commands from a Perl CGI script, chances are it won't work all the time. For example, if your CGI script has something like

```
system('uptime');
```

And if the location of the binary "uptime" is not in the "PATH", it will not work.
The solution is pretty simple, set the value of the environment variable whenever the script is being executed.

In perl, all environment variables are stored in a special has %ENV  
You can easily see the value of the `PATH` variable by including the following in the CGI script

```
print $ENV{'PATH'};
```

Now, all we have to do is to set the value of the "PATH" to the one we desire.  
Something like the following would do.

```
$ENV{'PATH'} = '/bin:/usr/bin:/usr/local/bin';
```

That's it. Simple and sweet. Now the system commands should work without any issue.

