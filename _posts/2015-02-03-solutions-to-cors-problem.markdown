---
layout: post
title: solutions to cors problem
author: Richard Huang
tags:
- rails
- cors
---

It's more and more popular that engineers will use different subdomains
to build a website, like `www` for webapp, `api` for api server,
`assets` for asset host, then you probably face the [cors][1] problem.

It can be solved either on app server or web server.

On app server (rails server), you can just add [rack-cors][2] gem to
fix it.

On web server (apache or nginx), it can also be fixed by server config,
the following is a nginx config to fix font cors issue for asset host.

{% highlight nginx %}
server {
    server_name assets.xinminlabs.com;

    location ~* \.(eot|ttf|woff)$ {
        add_header Access-Control-Allow-Origin http://xinminlabs.com/;
    }
    ......
}
{% endhighlight %}


[1]: http://en.wikipedia.org/wiki/Cross-origin_resource_sharing
[2]: https://github.com/cyu/rack-cors
