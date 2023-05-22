---
title: "Linux Bluetooth Error : Failed to start discovery: org.bluez.Error.InProgress"
description: ""
date: 2021-11-05T12:19:12+05:30
lastmod: 2021-11-05T12:19:12+05:30
draft: false
images: []
---

## Context

My Linux laptop running Pop OS! suddenly could not detect bluetooth devices anymore

And this was the error I found on the status
```text
Failed to start discovery: org.bluez.Error.InProgress
```

## Fix that worked for me

This may or may not work for you, but is worth a try

```bash
sudo hciconfig hci0 down
sudo rmmod btusb
sudo modprobe btusb
sudo hciconfig hci0 up
```
