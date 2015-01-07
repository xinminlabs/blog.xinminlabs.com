---
layout: post
title: Asset Pipeline in ActionMailer on a different host
author: Richard Huang
tags:
- rails
- asset pipeline
---

We have a rails project which sends email in sidekiq job, it's working
well until it's deployed to production server, we found images in email
are all not found.

The problem is we have 2 servers on production, app and db, we
precompile assets on app server but run sidekiq on db server, then we
call `image_tag` in mailer view, it generates image path as
`/assets/user.png` but app server doesn't recognize such asset path, it
expects image path as
`/assets/user-b1dbf9eed0aec90667f9589d7e0264c3.png`.

Why `image_tag` in db server can't generate asset path with md5
fingerprint? Because we just precompile assets on app server rather
than on db server.

How can we solve this problem? The quickest solution is to precompile
assets on db server, then `image_tag` can genearte image path with md5
fingerprint, but that means we have to install nodejs on db server. I
don't like it.

So how did we solve it? We just copy precompile assets from app server
to db server, here is our capistrano script.

{% highlight ruby %}
namespace :deploy do
  task :sync_assets do
    on roles(:app) do
      execute "scp -r #{release_path}/public/assets deploy@db.xinminlabs.com:#{release_path}/public/assets"
    end
  end

  before :publishing, :sync_assets
end
{% endhighlight %}

Now `image_tag` generates image path with md5 fingerprint in
email correctly.
