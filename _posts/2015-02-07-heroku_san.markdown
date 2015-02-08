---
layout: post
title: heroku_san
tags:
- gem
---

[heroku_san][1] provides many helpful tasks to manage heroku apps,
especailly when you deploy one website to multiple heroku apps, like
staging and production.

You can save your heroku info in `config/heroku.yml` file

```
production:
  stack: cedar
  app: xinminlabs-production
  config:
    WEB_CONCURRENCY: 2
    DB_POOL: 10
  addons:
    - heroku-postgresql:crane
    - newrelic:wayne

staging:
  stack: cedar
  app: xinminlabs-staging
  config:
    WEB_CONCURRENCY: 2
    DB_POOL: 10
  addons:
    - heroku-postgresql:dev
```

It's obvious how many heroku apps it uses, what configs and addons each
app has.

Then you can use many tasks heroku_san provides, like

```
rake production heroku:addons # Sync production addons
rake staging heroku:config # Sync staging config
rake production heroku:push #  Deploy to production
rake staging heroku:logs:tail # Tail staging logs
rake production heroku:console # Run rails console on production
......
```

If you have multiple apps on heroku, heroku_san will save time for you.


[1]: https://github.com/fastestforward/heroku_san
