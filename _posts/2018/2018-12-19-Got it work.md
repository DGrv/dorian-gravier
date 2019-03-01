---
layout: post
title: Got it work
---

Finally I got jekyll work on github ... as well as locally.
Took me a day to understand little mistakes I did. 2 version of jekyll test by using
```ruby
bundle list
bundle uninstall jekyll
# reinstall
bundle install jekyll
```

I add huge troubles with the _config.yml. It does not seems complex but I could not make it work.
Right it is working both locally via
```ruby
bundle exec jekyll serve
``` 
and on github.
It is actually minimalist for the moment:
```
theme: minima
repository: "DGrv/dorian.gravier.github.io"
github: [metadata]
```
