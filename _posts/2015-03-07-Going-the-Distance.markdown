---
layout: post
title: Going the Distance
tags:
- talk
---

### Video

<iframe width="560" height="315"
src="https://www.youtube.com/embed/wujPwfY8t7Y" frameborder="0"
allowfullscreen></iframe>

### Slides

<script async class="speakerdeck-embed"
data-id="5e8cd5f024da01321f5106622b3e4870" data-ratio="1.33333333333333"
src="//speakerdeck.com/assets/embed.js"></script>

### Introduction

It was a talk from Richard Schneeman at Ruby Kaigi 2014, introducing the
distance algorithms to compare two strings.

First, Richard raised an question, when he used git, it will give you
some hints when you input typo, e.g.

```
$ git commmit -m first
WARNING: You called a Git command named 'commmit',
which does not exist.
Continuing under the assumption that you meant 'commit'
in 0.1 seconds automatically...
```

But how it's implemented? Richard gave 2 algorithms.

Hamming Distance is used to compare to strings of equal length,
it's good for detecting and correcting errors in binary and
telecommunications, but not for misspelled words.

Levenshtein Distance can be used to compare two strings of arbitrary length,
Richard shown two implementation, one by recursive, the other by matrix.

Then Richard sent a pull request to rails, to give hints for typos in
rails commands.

```
$ rails g migratoon
Could not find generator 'migratoon'. Maybe you meant 'migration' or 'generator' or 'mailer'
Run `rails generate --help` for more options.
```

Richard also mentioned some other algorithms, like
Longest common subsequence Distance and Manhattan Distance
