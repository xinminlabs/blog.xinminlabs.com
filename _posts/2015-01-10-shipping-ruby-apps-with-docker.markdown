---
layout: post
title: Shipping Ruby Apps with Docker
author: Richard Huang
tags:
- talk
---

### 视频

<iframe width="560" height="315"
src="//www.youtube.com/embed/mVN7aTqr550" frameborder="0"
allowfullscreen></iframe>

### 介绍

It was a talk from Bryan Helmkamp at RedDotRubyConf 2014, introducing
Docker with ruby apps, he introduced

* Container-Based Virtualization
* Linux Container (LXC)

The benefits of Dockers are

* Isolated
* Low CPU / Memory overhead
* Low boot time
* High density

He also made a demo, running a sinatra app in the docker. From the demo,
we can see docker can cache the results for each execution, that makes
it boot faster. You can also to scale your app easily by starting
more containers.

Finally he discussed deliver unit, one process one docker container or
one app one docker container.

If you don't have used docker yet, the talk is a good start.
