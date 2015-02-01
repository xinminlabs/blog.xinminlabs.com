---
layout: post
title: Breaking Up With the Asset Pipeline
tags:
- talk
---

### Video

<iframe src="//player.vimeo.com/video/103438429" width="500"
height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen
allowfullscreen></iframe> <p><a href="http://vimeo.com/103438429">Alan
Peabody - Breaking Up With the Asset Pipeline - Burlington Ruby
Conference 2014</a> from <a
href="http://vimeo.com/burlingtonruby">Burlington Ruby</a> on <a
href="https://vimeo.com">Vimeo</a>.</p>

### Introduction

It was a talk from Alan Peabody at Burlington Ruby Conference 2014, he
gave us an alternative to asset pipeline.

First, it shown the problems of asset pipeline.

1. using gem to wrap js libraries, but some gems are not maintained,
some are out of date.
2. development is slow when there are many js / css files.

The alternative Alan gave is separating frontend and backend code, rails
serves as an api server, frontend codebase use js tech stack

* backbone / ember / angular
* npm
* bower
* browserify
* grunt / gulp

Then you can manage js / css libraries easier, it can automatically
compress and concat js / css files during development to speed up pages
load.

If you are interested in separating frontend and backend, you should
have a look at it.
