---
title: "Minimal Mistakes tips"
permalink: /code/minimal-mistakes/
toc: true
author_profile: false
layout: code
---


# Blog post

## Wide format

In header use `classes: wide`

## Layouts

In header use:

```
layout: code
layout: post
layout: single
```

# build offline or onlone

In _config.yml. Comment or not depending on your needs

```yml
# remote_theme: "mmistakes/minimal-mistakes"
theme: "minimal-mistakes-jekyll"
```

In Gemfile, keep it like this. If you change this one run `bundle install`

```
gem "jekyll-remote-theme"
gem "minimal-mistakes-jekyll", path: "./minimal-mistakes"
```

