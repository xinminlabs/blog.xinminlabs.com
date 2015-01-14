---
layout: post
title: New rails-bestpractices.com on github
author: Richard Huang
tags:
- rails
---

We built [rails-bestpractices.com][1] 4 years ago, many rails developers
come, discuss and share, we really appreciate it.

rails-bestpractices.com was built by rails, old code is on [github][2],
old website askd developer sign in first, then he can share post, vote
to like or dislike a post, ask or answer a question, etc.

It works good, but we look a bit arbitrary, when developer shares his
post, it won't be shown until we "publish" it on the admin panel, and
other developers can say they like or dislike only after the post is
published. But the decision made by us may not good.

So we decided to rebuild rails-bestpractices.com by [jekyll][3] instead
of by rails, new repo is [here][4]. Then if developer wants to share
their best practices, he can fork the repo, write a new post then send a
pull request, other developers can vote on the pull request, so everyone
can express his idea before we "publish" the post. It sounds more
democratic.

We also removed Q&A, job board, etc., they are not important, let's focus
on the best practices.

Of course, all contributions are welcome: ideas, patches, documentation,
bug reports, complaints, and even something you drew up on a napkin.


[1]: http://rails-bestpractices.com
[2]: https://github.com/railsbp/rails-bestpractices.com
[3]: http://jekyllrb.com
[4]: https://github.com/xinminlabs/rails-bestpractices.com
