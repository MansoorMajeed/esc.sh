---
author: Mansoor A
date: "2021-06-21T14:45:00Z"
description: ""
draft: false
title: Installing MineCraft server on Debian 10
url: blog/installing-minecraft-server-on-debian-10
---
## The Problem

Minecraft does not work with older versions of Java, which is what is available on the debian repos by default.

## The Solution

### Installing Java


Go [HERE](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) and copy the link to the latest Java version Debian package. And download the package to the server

For example, this one was the latest at the time of writing. 
```bash
wget https://download.oracle.com/otn-pub/java/jdk/16.0.1+9/7147401fd7354114ac51ef3e1328291f/jdk-16.0.1_linux-x64_bin.deb
```

Install it 
```bash
sudo dpkg -i jdk-16.0.1_linux-x64_bin.deb
```

Now we need to link this installation to be used as the default one
> Note: I am assuming that there are no other apps that depends on other versions of Java.
> This makes Java 16 the default one. If this is a fresh server, go ahead and do this blindly

Obviously, make sure to change the path `jdk-16.0.1` to whatever you are installing

```bash
update-alternatives --install /usr/bin/java java  /usr/lib/jvm/jdk-16.0.1/bin/java 2
update-alternatives --config java
update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-16.0.1/bin/jar 2
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-16.0.1/bin/javac 2
update-alternatives --set jar /usr/lib/jvm/jdk-16.0.1/bin/jar
update-alternatives --set javac /usr/lib/jvm/jdk-16.0.1/bin/javac
```

Run `java -version` to verify that it has installed correctly

### Installing MineCraft

Go [HERE](https://www.minecraft.net/en-us/download/server) and get the latest download link.

In my case:
```
wget https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar
```

Once downloaded, run it using
```
java -Xmx1024M -Xms1024M -jar server.jar nogui
```

Now, this should complain that you need to accept the EULA. There should be a file `eula.txt` in the same directory.
Edit it using a text editor `vim eula.txt`

```
eula=true
```
Save the file and close the editor

### Running Minecraft

You can directly start it, but it is better to start it in a screen/tmux session. This way, it will keep running even
if you get disconnected from the server

Install Tmux
```
sudo apt install tmux
```

Start a new Tmux session
```
tmux new -s minecraft
```

Start the Minecraft server
```
java -Xmx1024M -Xms1024M -jar server.jar nogui
```

That's it. You can detach from the terminal by using `Ctrl + B`, release, then `D`

