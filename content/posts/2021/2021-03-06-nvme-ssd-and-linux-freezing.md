---
author: Mansoor A
categories:
- Linux
date: "2021-03-06T03:50:44Z"
description: ""
draft: false
summary: Some WD NVME SSDs are not working at all in Linux. It freezes randomly and
  is practically unusable. Here we discuss a solution to the problem
tags:
- Linux
title: WD NVME SSD Freezing on Linux
url: blog/nvme-ssd-and-linux-freezing
---


## Backstory

I recently got a ThinkPad E14 AMD Ryzen 5 that came with 256GB NVME SSD soldered and had a slot for one more SSD. So I bought a WD Blue SN550 500GB SSD to fill in that second slot, and all hell broke loose.



## The problem

The laptop freezes randomly and spits out these error messages

```
{ 206.681465] EXT4-fs error (device dm-4) in ext4 free. inode:355: IO failure
{ 206.775200] EXT4-fs error (device dm-4): ext4_wait_block_bitmap:520@: comm cheese:cs0: Cannot read block bitmap - block_group = 38, block_bitmap = 1048582
{ 206.775410] EXT4-fs error (device dm-4): ext4_discard_preallocations:4090: comm cheese:cs0: Error -5 reading block bitmap for 38
{ 213.584473] EXT4-fs error (device dm-4): ext4_journal_check_start :84: Detected aborted journal
```

And there is not much to do there other than hard rebooting the laptop.

## What I tried and failed

1. Installed multiple newer kernel versions : No luck ( The latest kernel I tried is `5.10.15-051015-generic` )
2. Reinstalled multiple different distros: Wanted to make sure that it wasn't any distro specific (I know it makes no sense, but I tried anyway) : No luck
3. Re-seated the SSD: No luck
4. Updated all the firmware using Windows: No luck

## What worked : A potential solution

I stumbled upon [THIS](https://bugzilla.kernel.org/show_bug.cgi?id=208123) bug report and it had the same issue. The suggestion was to try and disable APST. So I added the following to the kernel boot parameter

```
nvme_core.default_ps_max_latency_us=5500
```

### How to update the Kernel parameter

First of all, figure out if you are using Grub or systemd boot. If you are using Pop OS!, you are most probably using systemd-boot. I believe Ubuntu is still using Grub2, please do your research.

**For Grub**

Edit `/etc/default/grub` as root (You can use your favourite text editor). If you don't have one, do `sudo gedit /etc/default/grub`

Find the line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` and add the parameter there. Your line should look like this now (Make sure it is a single line with no line break)

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvme_core.default_ps_max_latency_us=5500"
```

And update grub using

```
sudo update-grub
```



**For Systemd boot**

Find your loader configuration. For example, Pop OS! conf path is

```
/boot/efi/loader/entries/Pop_OS-current.conf
```

Edit the file and find the line that starts with `options` and add the parameter to the end of the line. It should look like this after adding the entry

```
options root=UUID=350fc3dc-9ed1-440d-9a8f-922ee8c6511f ro quiet loglevel=0 systemd.show_status=false splash nvme_core.default_ps_max_latency_us=5500
```

And reboot. That's pretty much it.

### Conclusion

Although it works with these Kernel parameters, we are adjusting the power setting for these SSDs and I did not want it to affect my laptop battery. So I ended up returning the SSD and I am using the internal SSD. It just works

### References

Some of these threads are talking about the same thing

```
https://www.reddit.com/r/pop_os/comments/g8y3ae/experiencing_random_freezes_after_installing_new/


https://askubuntu.com/questions/1126456/wd-sandisk-nvme-m-2-stick-not-quite-working
```



