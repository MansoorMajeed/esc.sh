---
author: Mansoor A
categories:
- Blogging
- Jekyll
date: "2018-03-30T00:07:00Z"
description: ""
draft: false
summary: Making sure that Disqus doesn't slow down your website for no reason. By
  making disqus load only when a button is clicked, we can improve the page load speed
  dramatically
tags:
- Blogging
- Jekyll
title: Load disqus comments on button click (Jekyll)
url: blog/load-disqus-on-click
---


Most of us use Disqus for comments, especially with static blog generators like Jekyll. The reason
behind Disqus' popularity is quite simple. It is extremely easy to use and provides many features
like email notifications, moderation, reply via email etc. 

But the problem with it is that disqus makes a lot of external requests for the comments to load. This 
includes a lot of requests to third party ad providers and trackers (even when there are no comments
on the post). And this is a huge deal. I tried alternatives to Disqus and wasn't impressed with anything
and decided to stick with Disqus for now.

A better solution would be to continue to use Disqus itself, but load it manually, on click of a button
instead of loading it automatically. And this helped a lot. 


#### Here is how to do it in Jekyll
The idea is same, you can use it anywhere, but I will be showing how to do it on Jekyll.  

Create a new file at `_includes/show-disqus.html` with the following content
```html
<div class="show-comments">
    <button id="show-comments-button" onclick="disqus();return false;">Show Comments</button>
</div>

<div id="disqus_thread"></div>

<script>
var disqus_loaded = false;
var disqus_shortname = 'xxxxxxxx'; //Add your shortname here
function disqus() {
    if (!disqus_loaded)  {
        disqus_loaded = true;
        var e = document.createElement("script");
        e.type = "text/javascript";
        e.async = true;
        e.src = "//" + disqus_shortname + ".disqus.com/embed.js";
        (document.getElementsByTagName("head")[0] ||
        document.getElementsByTagName("body")[0])
        .appendChild(e);
        //Hide the button after opening
        document.getElementById("show-comments-button").style.display = "none";
    }
}
//Opens comments when linked to directly
var hash = window.location.hash.substr(1);
if (hash.length > 8) {
    if (hash.substring(0, 8) == "comment-") {
        disqus();
    }
}
//Remove this if you don't want to load comments for search engines
if(/bot|google|baidu|bing|msn|duckduckgo|slurp|yandex/i.test(navigator.userAgent)) {
   disqus();
}
</script>
```
> Note: Don't forget to replace the `disqus_shortname` with yours

The above snippet is taken from this [GIST](https://gist.github.com/robwent/e9c321b5c200370da0cadb69e40379b7) and I verified that it is working fine.

Now you need to find where is disqus included in your theme. Most of the time, it will be at `_layouts/post.html`.

This is how it was for me, in the file `_layouts/post.html`
```html
{% raw %}
</article>
<!-- Disqus -->
{% if site.theme_settings.disqus_shortname %}
<div class="comments">
  {% include disqus.html %}
</div>
{% endif %}
<!-- Post navigation -->
{% endraw %}
```

So, all we have to do is, instead of `disqus.html`, we use our new `show-disqus.html`

```html
{% raw %}
<!-- Disqus -->
{% if site.theme_settings.disqus_shortname %}
<div class="comments">
  {% include show-disqus.html %}
</div>
{% endif %}
{% endraw %}
```

This should add the button to load Disqus and prevent it from loading automatically.
The button won't be pretty, and you might have to do some CSS foo to make it look pretty.
This is what I did:

Add the follwing in `_sass/layouts/_posts.scss`
> Note: The location of the scss file might be different for you, you just add it the 
> scss file related to your posts

```css
#show-comments-button {
    background-color: #008CBA;
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    font-size: 20px;
    margin: 0px 0px;
    width: 100%;
}
```
And that's it. It should be now a prettier button (That's the best I could do, I'm a CLI person, sorry! )

