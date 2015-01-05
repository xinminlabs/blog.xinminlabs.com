---
layout: post
title: "Keith and Mario's Guide to Fast Websites"
author: Richard Huang
tags:
- talk
---

### Video

<iframe src="//player.vimeo.com/video/61342267" width="500" height="281"
frameborder="0" webkitallowfullscreen mozallowfullscreen
allowfullscreen></iframe> <p><a href="http://vimeo.com/61342267">Keith
Pitt & Mario Visic - Keith and Mario's Guide to Fast Websites</a> from
<a href="http://vimeo.com/rubyau">Ruby Australia</a> on <a
href="https://vimeo.com">Vimeo</a>.</p>

### Slides

<script async class="speakerdeck-embed"
data-id="ac0c8af05fc10130a2f822000a1c835e" data-ratio="1.33333333333333"
src="//speakerdeck.com/assets/embed.js"></script>

### Introduction

Is was a talk from Keith Pitt and Mario Visic at Ruby Conference
Australia 2013, introducing how they make a website page load from 9157
ms to under 2s.

As 80% to 90% of total page load time are used on front side, so the
talk is talking mainly about front side performance tuning.

Before we can start performance tuning, we must have some tools to
measure time, it used wbench and browser built-in tool in this talk.

The methods to do performance tuning are including

1. minify css and js files.
2. gzip html, css and js responses.
3. compress images, use css sprites or use font instead of image.
4. put script to the bottom of html body tag.
5. asynchronously load js.
6. use CDN to speed up images, css and js load
7. use SPDY

After these steps, it spends only 20% of time to render page.

If you are interested in website performance tuning, you can't miss this
talk.
