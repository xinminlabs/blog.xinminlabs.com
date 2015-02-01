---
layout: post
title: bower-rails
tags:
- gem
---

[bower-rails][1] make it easy to integrate bower to rails repos.

[bower][2] is a frontend package management, like bundler for ruby.
Comparing to using gem to require js / css libraries, using bower gives
some benefits

1. more straightforward, by using bundler, you have to open gem source
code to see what library is required by the gem and what version of the
library, by using bower, it's obvious.
2. you can specify what version of library to require, it's also easier
to upgrade and downgrade.
3. helpful to avoid conflicts, just like bunder, bower will warn you
when dependencies conflicted.

I'm always thinking it's wrong to use bundler to require js / css
libraries, let js (bower) to manage js itself.


[1]: https://github.com/42dev/bower-rails
[2]: https://github.com/bower/bower
