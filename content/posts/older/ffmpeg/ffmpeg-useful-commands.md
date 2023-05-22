---
title: "FFmpeg Quick Reference"
description: ""
lead: ""
url: blog/ffmpeg-cheatsheet
date: 2022-08-19T10:45:01-04:00
lastmod: 2022-08-19T10:45:01-04:00
draft: false
contributors: []
---

## What is it?

This is basically a quick reference for myself, but I thought it could be useful to someone searching
certain ffmpeg commands as well. Feel free to improve

## Webm to MP4

### Converting a single file

```bash
ffmpeg -fflags +genpts -i input.webm -r 60 output.mp4
```

Replace `-r 60` with desired frames per second

### Converting a directory full of webm to mp4

```bash
for i in *.webm;do ffmpeg -fflags +genpts -i "$i" -r 60 "${i%.*}.mp4" ;done
```

replace `-r 60` with appropriate frames per second


## MOV to MP4

```bash
ffmpeg -i input.MOV -vcodec h264 -acodec mp2 output.mp4
```
