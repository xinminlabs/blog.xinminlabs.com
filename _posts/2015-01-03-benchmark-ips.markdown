---
layout: post
title: benchmark-ips
tags:
- gem
---

[benchmark-ips][1] is a new benchmark tool in ruby world, it reports how
many times a piece of code are executed within a specified time period.

Generally we use ruby standard library `benchmark` to test how long it
takes to run a piece of code, like


{% highlight ruby %}
require 'benchmark'

n = 1_000_000
Benchmark.bm(20) do |x|
  x.report('addition') { n.times { 1 + 2 } }
  x.report('addition with send') { n.times { 1.send(:+, 2) } }
end
{% endhighlight %}

{% highlight bash %}
#                          user     system      total        real
addition               0.060000   0.000000   0.060000 (  0.063733)
addition with send     0.120000   0.000000   0.120000 (  0.119405)
{% endhighlight %}

Although `benchmark-ips` is a new gem, it gets popular, even rails core
team recommend using it.

{% highlight ruby %}
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('addition') { 1 + 2 }
  x.report('addition with send') { 1.send(:+, 2) }
end
{% endhighlight %}

{% highlight bash %}
Calculating -------------------------------------
            addition    127559 i/100ms
  addition with send    116623 i/100ms
-------------------------------------------------
            addition  8343518.5 (±7.4%) i/s -   41456675 in   4.999424s
  addition with send  5721822.9 (±8.3%) i/s -   28456012 in   5.013402s
{% endhighlight %}

As you can see, `benchmark-ips` reports the execution count within 5
seconds by default.

Comparing to ruby stardard library `benchmark`, `benchmark-ips` has some
benefits.

1. You don't need to guess how many times to run a piece of code that
   makes benchmark result make sense, e.g. we run the code 1 million
   times when using `benchmark`.
2. It will warmup code in a period time, 100 ms by default before real
   benchmark, which makes benchmark result more accurate.
3. It gives better reports, you don't need to specify how long the note
   should be shown, like 20 we used for `benchmark` result.

No hesitate to try `benchmark-ips` to benchmark your code.

[1]: https://github.com/evanphx/benchmark-ips
