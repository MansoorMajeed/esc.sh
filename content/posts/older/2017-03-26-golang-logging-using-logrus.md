---
author: Mansoor A
date: "2017-03-26T00:07:00Z"
description: ""
draft: false
title: Logging in Golang using logrus
url: blog/golang-logging-using-logrus
---


If you just started out with Golang, you'd find it a bit difficult to handle logging with the default pacakge `log`
Don't get me wrong, it's powerful and all, but for a beginner, you have to do a lot of stuff manually. For example,
it doesn't have log levels like `Info, Warning, Debug, Error` by default. You have to add them manually.

If you come from a language like Python (like me), you would find it a bit different. Anyway, `logrus` to the rescue.

[Logrus](https://github.com/sirupsen/logrus) is a logger module for go, which works flawlessly and has a ton of features.
Besides, it's quite simple to configure it, just like you'd do with the `logger` module in Python. Anyway, let's get started.
I will simply provide you with the sample code and that should be it.

### Install the module first
```
go get "github.com/Sirupsen/logrus"
```

### Logging to console (stderr)
 
```go
package main

import (
    log "github.com/Sirupsen/logrus"
)

func main(){
    Formatter := new(log.TextFormatter)
    Formatter.TimestampFormat = "02-01-2006 15:04:05"
    Formatter.FullTimestamp = true
    log.SetFormatter(Formatter)
    log.Info("Some info. Earth is not flat.")
    log.Warning("This is a warning")
    log.Error("Not fatal. An error. Won't stop execution")
    log.Fatal("MAYDAY MAYDAY MAYDAY. Execution will be stopped here")
    log.Panic("Do not panic")
}
```

This will produce the following output
```
INFO[26-03-2017 12:01:34] Some info. Earth is not flat.
WARN[26-03-2017 12:01:34] This is a warning
ERRO[26-03-2017 12:01:34] Not fatal. An error. Won't stop execution
FATA[26-03-2017 12:01:34] MAYDAY MAYDAY MAYDAY. Execution will be stopped here
exit status 1
```
`Fatal` will stop the execution right there. It didn't get a chance to reach the `Panic` part.

This is how `Panic` will look like
```
PANI[26-03-2017 12:04:30] Do not panic
panic: (*logrus.Entry) (0xc3440,0xc420010410)

goroutine 1 [running]:
panic(0xc3440, 0xc420010410)
    /usr/local/go/src/runtime/panic.go:500 +0x1a1
github.com/Sirupsen/logrus.Entry.log(0xc420010190, 0xc4200162a0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xc420010100, ...)
    /Users/mansoor/gocode/src/github.com/Sirupsen/logrus/entry.go:124 +0x423
github.com/Sirupsen/logrus.(*Entry).Panic(0xc4200101e0, 0xc42003fee8, 0x1, 0x1)
    /Users/mansoor/gocode/src/github.com/Sirupsen/logrus/entry.go:169 +0x124
github.com/Sirupsen/logrus.(*Logger).Panic(0xc420010190, 0xc42003fee8, 0x1, 0x1)
    /Users/mansoor/gocode/src/github.com/Sirupsen/logrus/logger.go:235 +0x6e
github.com/Sirupsen/logrus.Panic(0xc42003fee8, 0x1, 0x1)
    /Users/mansoor/gocode/src/github.com/Sirupsen/logrus/exported.go:107 +0x4b
main.main()
    /tmp/log1.go:15 +0x286*
exit status 2
```

### Logging to file
This will log to `logfile.log`. 
```go
package main

import (
    log "github.com/Sirupsen/logrus"
    "os"
    "fmt"
)

func main(){
    var filename string = "logfile.log"
    // Create the log file if doesn't exist. And append to it if it already exists.
    f, err := os.OpenFile(filename, os.O_WRONLY | os.O_APPEND | os.O_CREATE, 0644)
    Formatter := new(log.TextFormatter)
    // You can change the Timestamp format. But you have to use the same date and time.
    // "2006-02-02 15:04:06" Works. If you change any digit, it won't work
    // ie "Mon Jan 2 15:04:05 MST 2006" is the reference time. You can't change it
    Formatter.TimestampFormat = "02-01-2006 15:04:05"
    Formatter.FullTimestamp = true
    log.SetFormatter(Formatter)
    if err != nil {
        // Cannot open log file. Logging to stderr
        fmt.Println(err)
    }else{
        log.SetOutput(f)
    }

    log.Info("Some info. Earth is not flat")
    log.Warning("This is a warning")
    log.Error("Not fatal. An error. Won't stop execution")
    log.Fatal("MAYDAY MAYDAY MAYDAY")
    log.Panic("Do not panic")
}
```

This should get you going.

