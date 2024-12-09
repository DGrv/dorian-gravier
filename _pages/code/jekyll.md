---
title: "Jekyll / Minimal Mistakes"
permalink: /code/jekyll/
toc: true
author_profile: false
layout: code
---



to docu : https://jekyllrb.com/docs/liquid/filters/

```
# ---------------------------------CAREFUL----------------------------------------
# do not use liquid filter in navigation. Jekyll take it as a static file
# so <img src="{{ '/files/icon/Tatoo_v02_icon.png' | absolute_url }}" class="emoji" />
# this will not work
```

make your modif in css only in assets/css/mains.css
https://github.com/mmistakes/minimal-mistakes/issues/1453



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

