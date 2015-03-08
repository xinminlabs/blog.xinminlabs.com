---
layout: post
title: Incremental GC for Ruby Interpreter
tags:
- talk
---

### Video

<iframe width="560" height="315"
src="https://www.youtube.com/embed/4UO60ocw52w" frameborder="0"
allowfullscreen></iframe>

### Introduction

It was a talk from Koichi Sasada at RubyConf 2014, Koichi Sasada is one
of the ruby core team members, this talk was before ruby 2.2 released,
it introduced Ruby 2.1 RGenGC and Ruby 2.2 RincGC.

RGenGC can dramatically decrease GC time and stop the world time.

RincGC plus RGenGC decrease stop the world time.

The talk introduced the theory and implementation of RGenGC and RinGC.
