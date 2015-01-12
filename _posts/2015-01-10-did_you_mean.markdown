---
layout: post
title: did_you_mean
tags:
- gem
---

[did_you_mean][1] is a magic gem. When you ruby app raises an error,
did_you_mean will tell you if it's caused by a typo in the exception
backtrace.

{% highlight ruby %}
class User
  attr_accessor :first_name, :last_name

  def to_s
    "#{f1rst_name} #{last_name}" # f1rst_name ???
  end
end

user.to_s
# => NameError: undefined local variable or method `f1rst_name' for #<User:0x0000000928fad8>
#
#     Did you mean? #first_name
#
{% endhighlight %}

{% highlight ruby %}
class Book
  class TableOfContents
    # ...
  end
end

Book::TableofContents # TableofContents ???
# => NameError: uninitialized constant Book::TableofContents
#
#     Did you mean? Book::TableOfContents
#
{% endhighlight %}

As you can see, did_you_mean gives you hints according to the context,
class names, constant names, etc.

I can't remember how many times I complained "what the hell" when apps
raised an error and turned out it was a typo. But after using
did_you_mean gem, I don't waste time to check typos anymore.


[1]: https://github.com/yuki24/did_you_mean
