---
layout: post
title: eager_group
author: Richard Huang
tags:
- eager_group
- performance
- rails
---

TLDR, [eager_group][1] fixes n+1 aggregate sql functions for rails.

After consulting on some rails projects, I find most projects are still
suffering from N+1 query problem. Many rails developers aren't aware
that they generate hundreds sqls in one request, it's horrible.

### What's n+1 query problem?

It occurs when you fetch n records from database and send additional sql
for each record, let me give you an example, we have Post and Comment
models and one Post has many Comments.

```ruby
class Post < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord:Base
  belongs_to :post
end
```

Then you load 10 posts and all comments for each post

```ruby
Post.limit(10).each do |post|
  post.comments.each do |comment|
    comment.body
  end
end
```

It generates sqls like

```sql
SELECT * FROM posts LIMIT 10;
SELECT * FROM comments WHERE post_id = 1;
...
SELECT * FROM comments WHERE post_id = 10;
```

The problem with this is each sql has a bit overhead, it's much faster
to execute 1 query which returns 10 results than to execute 10 queries
which each return 1 result.

#### includes

Rails provides `includes` query method to solve this problem.

```ruby
Post.limit(10).includes(:comments).each do |post|
  post.comments.each do |comment|
    comment.body
  end
end
```

The generated sqls become

```sql
SELECT * FROM posts LIMIT 10;
SELECT * FROM comments WHERE post_id IN (1, ..., 10);
```

### n+1 aggregate sql functions

This is the simplest one, sometimes we want to query the count of
comments for each post.

```ruby
Post.limit(10).each do |post|
  post.comments.count
end
```

It generates sqls like

```sql
SELECT * FROM posts LIMIT 10;
SELECT COUNT(*) FROM comments WHERE post_id = 1;
...
SELECT COUNT(*) FROM comments WHERE post_id = 10;
```

Another n+1 query problem executing aggregate sql functions.

#### counter_cache

Rails' solution is counter cache, it adds a column to posts table to
cache comments count

```ruby
class Post < ActiveRecord::Base
  has_many :comments
  # adds one field comments_count
end

class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true
end

Post.limit(10).each do |post|
  post.comments.size
end
```

It generates only 1 sql as `comments_count` is already read from posts
rows.

```
SELECT * FROM posts LIMIT 10;
```

### Complex n+1 aggregate sql functions

Perfect? Yes, but real usecases are more complicated, e.g. Comment has a
`status` field, it can be one of initial, approved or deleted, and we
just want to query the count of approved comments, our ruby code look
like

```ruby
class Comment < ActiveRecord::Base
  belongs_to :post

  scope :approved, -> { where(status: 'approved') }
end

posts = Post.limit(10)
posts.each do |post|
  posts.comments.approved.count
end
```

The generated sqls are

```sql
SELECT * FROM posts LIMIT 10;
SELECT COUNT(*) FROM comments WHERE post_id = 1 AND status = 'approved';
...
SELECT COUNT(*) FROM comments WHERE post_id = 10 AND status = 'approved';
```

Now `counter_cache` can't help and there's no solution provided by
rails.

#### GROUP BY

When I did performance tuning for this case, I made use of `GROUP BY`
sql to generate just one sql to fetch all count of approved comments for
each post.

```ruby
class Post < ActiveRecord::Base
  attr_accessor :approved_comments_count

  has_many :comments
end

posts = Post.limit(10)
approved_comments_count_hash = Comment.where(post_id: posts.map(&:id)).approved.group(:post_id).count
posts.each { |post| post.approved_comments_count = approved_comments_count_hash[post.id] }
posts.each do |post|
  posts.comments.approved_comments_count
end
```

It generates 2 sqls

```sql
SELECT * FROM posts LIMIT 10;
SELECT COUNT(*), post_id FROM comments WHERE post_id IN (1, ..., 10) AND status = 'approved' GROUP BY post_id;
```

N+1 query problem is solved again, it run much faster. Awesome!

But code isn't clean, I have to add `attr_accessor` to model and write
additional 2 lines of code to fetch aggregations, I'd like to make it
easier and more transparent.

### eager_group

That's why [eager_group][1] borned. It adds one query method
`eager_group` and adds one class method `define_eager_group` to
activerecord.

First you need to define what aggregate sql function you want to eager
load.

```ruby
class Post < ActiveRecord::Base
  has_many :comments

  # eager load average rating of comments
  define_eager_group :comments_average_rating, :comments, :average, :rating
  # eager load count of approved comments
  define_eager_group :approved_comments_count, :comments, :count, :*, -> { approved }
end

class Comment < ActiveRecord::Base
  belongs_to :post

  scope :approved, -> { where(status: 'approved') }
end
```

Then you can use `eager_group` to fix n+1 aggregate sql functions when
querying.

```ruby
posts = Post.all.eager_group(:comments_average_rating, :approved_comments_count)
posts.each do |post|
  post.comments_average_rating
  post.approved_comments_count
end
```

The generated sqls are

```sql
SELECT * FROM posts;
SELECT AVG(rating), post_id FROM comments WHERE post_id IN (1, ..., 10) GROUP BY post_id;
SELECT COUNT(*), post_id FROM comments WHERE post_id IN (1, ..., 10) AND status = 'approved' GROUP BY post_id;
```

As you can see, `eager_group` can be used for AVG/COUNT/MIN/MAX/SUM sql
functions.

Further, I'm considering to add cache support to `eager_group`.

#### Benchmark

I also did a benchmark with eager group

```ruby
Benchmark.ips do |x|
  x.report("Without EagerGroup") do
    Post.limit(20).each do |post|
      post.comments.approved.count
      post.comments.approved.average('rating')
    end
  end

  x.report("With EagerGroup") do
    Post.eager_group(:approved_comments_count, :comments_average_rating).limit(20).each do |post|
      post.approved_comments_count
      post.comments_average_rating
    end
  end

  x.compare!
end

# Calculating -------------------------------------
#   Without EagerGroup     2.000  i/100ms
#      With EagerGroup    28.000  i/100ms
# -------------------------------------------------
#   Without EagerGroup     28.883  (± 6.9%) i/s -    144.000
#      With EagerGroup    281.755  (± 5.0%) i/s -      1.428k
#
# Comparison:
#      With EagerGroup:      281.8 i/s
#   Without EagerGroup:       28.9 i/s - 9.76x slower
```

It got 10 times faster, WOW!

Don't hesitate to use it to improve your server performance.

[1]: https://github.com/xinminlabs/eager_group
