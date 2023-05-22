---
author: Mansoor A
categories:
- Blogging
- Gatsby
- HomePage
date: "2020-03-29T13:42:24Z"
description: ""
draft: false
image: https://cdn.esc.sh/2020/03/gatsby.jpeg
summary: This blog is powered by Gatsby and I was setting up Google Analytics and
  for some reason it didn't work for me. In this post, we'll fix it for good
tags:
- Blogging
- Gatsby
- HomePage
title: Google Analytics not working in Gatsby blog
url: blog/google-analytics-not-working-in-gatsby-powered-blog
---


### 

I recently moved from Jekyll to Gatsby and I was setting up Google Analytics on the Gatsby blog as documented [HERE](https://www.gatsbyjs.org/packages/gatsby-plugin-google-analytics/). Even after countless cache refreshes and incognito tabs, I couldn't get it to work. There is already a closed issue [HERE](https://github.com/gatsbyjs/gatsby/issues/12967) which talks about the same issue and luckily I found a solution from the same.

### The Solution

Simply copy the `gatsby-plugin-google-analytics` plugin entry in the `gatsby-config.js` to the top of the plugins list and remove the options except the `trackingId`, `head` and `anonymize`.

Basically, my `gatsby-config.js` looks like this now:

```javascript
plugins: [
        // Google analytics
        {
            resolve: `gatsby-plugin-google-analytics`,
            options: {
              trackingId: "your tracking code here",
              head: true,
              anonymize: true,
            },
        },
    	// Other plugins
```

That should be it. Now, I have no clue why it works, I didn't have the time or knowledge to dive into the plugin's source code.  🤷‍♂️ Hope this helps

