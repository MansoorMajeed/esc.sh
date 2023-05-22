---
title: "Apple Mail Client - Adding Custom From Addresses for Catch-All mail accounts"
date: 2022-08-30T18:52:19-04:00
lastmod: 2022-08-30T18:52:19-04:00
url: blog/apple-mail-client-custom-from-address
draft: false
---
## The Problem

If you have a catch all email address for your custom domain, things are all sweet that you 
can use any email address like `random@yourdomain.com`, but if you receive an email in one 
of those addresses and if you want to reply to that email using `random@yourdomain.com`, you need
to configure those addresses in your mail client.

This blog post is about how to do that in apple mail client (in MacOS and iOS)


## Solution - Apple Mail on MacOS 

1. Open "Mail"
2. Go to preferences -> Accounts -> Account information -> Email addresses
3. Here you should see an option "Edit email addresses". You can add any address you like

> Note: I am assuming that your mail provider actually supports this "Catch all" and you are
> actually allowed to send from any name under your `@yourdomain.com`

{{< figure src="apple-mail-mac-com.png" class="border-0">}}

Now, you should be able to choose the "From" address when you are replying to an email
or composing a new email.

## Solution - Apple Mail on iOS

Go to Settings -> Mail -> Accounts -> Your catch all account -> IMAP Account > Email (right under your Name)

This should show you your current email address an option to `Add another Email...`

Tap on it and you should be able to add any email for your domain that you are authorized to.


