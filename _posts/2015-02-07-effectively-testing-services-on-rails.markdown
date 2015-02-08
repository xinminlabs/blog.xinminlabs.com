---
layout: post
title: Effectively Testing Services on Rails
tags:
- talk
---

### Video

<iframe width="560" height="315"
src="https://www.youtube.com/embed/sMWthvdWS-w" frameborder="0"
allowfullscreen></iframe>

### Slides

<iframe src="//www.slideshare.net/slideshow/embed_code/33918753"
width="425" height="355" frameborder="0" marginwidth="0"
marginheight="0" scrolling="no" style="border:1px solid #CCC;
border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen>
</iframe> <div style="margin-bottom:5px"> <strong> <a
href="//www.slideshare.net/neal_kemp/effectively-testing-services-on-rails-railsconf-2014"
title="Effectively Testing Services on Rails - Railsconf 2014"
target="_blank">Effectively Testing Services on Rails - Railsconf
2014</a> </strong> from <strong><a href="//www.slideshare.net/neal_kemp"
target="_blank">neal_kemp</a></strong> </div>

### Introduction

It was a talk from Neal Kemp at RailsConf 2014, introducing how he tests
3rd party services on rails.

3rd party services could be twitter, facebook, amazon s3, etc., it's
faster to build, easier to scale and more shares on social networking to
use 3rd party services.

3rd party services probably become critical in your website, like log in
with twitter and facebook, but how could we test 3rd party services?

As 3rd party services are black box to your website and network could be
unstable or unreachable, you tests should not send real requests to 3rd
party services.

The talk introduced how to stub requests to 3rd party services.

1. `webmock`，a library to stub http requests and responses.
2. `fb_graph-mock`，a library to stub requests for facebook graph.
3. `sham_rack`，a built-in rack app to stub http requests and responses.
4. `vcr`，it sends a real http request and records response at first
   time, then stub responses for the next requests.

It makes testing 3rd party services much easier and faster by using
these gems.
