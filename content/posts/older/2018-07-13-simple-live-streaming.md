---
author: Mansoor A
categories:
- Linux
date: "2018-07-13T00:07:00Z"
description: ""
draft: false
summary: Setting up a private streaming server
tags:
- Linux
title: Live streaming in two commands
url: blog/simple-live-streaming
---


Setting up a private live streaming server doesn't sound that simple. But, it is dead simple.
I'm gonna explain how to setup your own streaming server using Nginx. No expensive
software required, all open source tools.

For you to go live, you need three things:
1. A device to record the stream
2. A server to receive the stream and serve to the viewers
3. Optionally, someone to view the stream (duh!)

## Setting up Nginx + RTMP module

You might be familiar with Nginx and what all it can do. With the help of an [rtmp module](https://github.com/arut/nginx-rtmp-module)
nginx can handle RTMP streams (RTMP is a protocol using which we can send live videos over the internet)

To setup the streaming server, you can either go ahead and compile the module into Nginx. The instructions
are available in the repository [HERE](https://github.com/arut/nginx-rtmp-module)

I am going to go with an easier approach, Nginx+RTMP module in Docker.

> We will be setting it up in the local machine. To stream to the internet, you might
> want to setup your streaming server on a VPS. The instructions are the same

First of all, install docker if you don't have it already. The instructions are [HERE](https://docs.docker.com/install/)

Once you have docker installed and running, things are quite easy
```shell
docker pull alfg/nginx-rtmp
docker run -it -p 1935:1935 -p 8080:80 --rm alfg/nginx-rtmp
```
This will pull the Docker image with Nginx+RTMP module and start the server. Port 1935 is
exposed as RTMP input and the 8080 for the m3u8 viewing

The Dockerfile is available [HERE](https://github.com/alfg/docker-nginx-rtmp). If you want to make
any modifications, go ahead and clone the repo and build your own image. The instructions are
mentioned in the repository

Now that we have a streaming server running, let's push an RTMP stream to it

## Going Live!

Now we need a device to record the stream and a software to send it as an RTMP stream to our
server. You can use FFMPEG to go live in a single command.

This should work on a Mac

```
ffmpeg -f avfoundation -r 30 -i "0:0" -deinterlace -vcodec libx264 -pix_fmt yuv420p -preset medium -g 250 -b:v 25000k -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k -f flv  rtmp://localhost:1935/stream/stream1
```
Notice the URL and name at the end of the command. Our stream's name will be `stream1`

But, just FFmpeg is not that easy. You might want something better for streaming.
Go ahead and download [OBS Studio](https://obsproject.com/). It's an open source software that can
be used for live streaming. It's available for Linux, Mac and Windows.

Once you have OBS installed, create a new profile `profile > new`. Give it a name
Then under `Settings > Stream` set the Stream type as `Custom Streaming Server`

Enter the URL as `rtmp://localhost:1935/stream`
Stream key: `stream1`

Under `Sources` click on the plus button, then `Video Capture Device`, give it a name and press OK,
then under `Devices` you should be able to see your webcam. Choose it and press OK. You're good to go

After that's done, click on `Start streaming` and you're live!!

### Going Live From Android

There is an app in the playstore by the name `RTMP Camera`. It's nothing fancy, but it works just fine.
Install the app, the under `options >> Publish address`, set the stream name and RTMP server URL.
Now, please note that since you are streaming from your Android device, if your laptop and the Android
device are in the same network, you can use the local private IP like this

```
Stream name: stream1
url: blog/rtmp://192.168.1.100:1935/stream
```

Where `192.168.1.100` is the IP address of your laptop where Nginx is running.

You can also set it up using a VPS, in that case, you will have to use the public IP of the VPS(obviously)

## Viewing the stream

Once you are live, you should be able to view the video using VLC or Safari

In Safari, go to the URL `http://localhost:8080/live/stream1.m3u8` and you should be able to see
yourself

Note the stream name `stream1` is the same as the stream key you chose while sending the stream
using OBS/FFmpeg. This can be anything. But to view the stream, you should use the correct
stream key

In VLC, `File >> Open Network` then paste the URL `http://localhost:8080/live/stream1.m3u8` and wait for
a few seconds, you should be able to see the stream.

Now, all of this is happening in your local machine itself. If you want other people to see the
stream, you obviously need to set it up on a VPS. Then you will need to replace `localhost` with the
IP address of your VPS. You will probably need to open the firewall to allow port number 1935 for
incoming and 8080 for outgoing

That's it for now!

