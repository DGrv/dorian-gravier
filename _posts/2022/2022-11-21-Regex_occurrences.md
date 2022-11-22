---
layout: "post"
title: "Replace the Nth occurrence of a string via regex (and in R) or all the occurences after the Nth occurence"
date: "2022-11-21 09:00"
comments_id: 46
---

Via <kdb>R</kdb> using <kdb>Regex</kdb> expression (meaning almost any languages) you can replace the Nth occurrence of a character in a string ([source](https://stackoverflow.com/questions  /55874998/replace-nth-occurrence-of-a-character-in-a-string-with-something-else)).
Here a code example that I used in the past:

```r
# remove the third occurence of "_"
> string <- "Hello_world_I am a good_guy and want to_save_the_world"
> string
[1] "Hello_world_I am a good_guy and want to_save_the_world"
> gsub("((?:[^_]+_){2}[^_]+)_", "\\1 ", string)
[1] "Hello_world_I am a good guy and want to_save_the world"
```

But you can also replace all occurence of a character or a pattern after a specific occurence ([source](https://stackoverflow.com/a/26574134/2444948)).
I was looking for this for a long time, here an example

```r
> string <- gsub("_", " - ", string)
> string
[1] "Hello - world - I am a good - guy and want to - save - the - world"
> gsub("^((?! - ).+?(?= - ) - ){2}(*SKIP)(*F)| - ", " | ", string, perl=T)
[1] "Hello - world - I am a good | guy and want to | save | the | world"
```

Use [regex101.com](https://regex101.com/r/g409mK/2) to play around and understand exactly all parts :)

But here some info:

- `^` start of the line
- `(?! - )` different than " - "
- but `.+` meaning anything several times `?` except `(?= - )` " - "
- ` - ` match " - "
- `(.........){2}` what I explain can be repeated 2 times
- `(*SKIP)(*F)` stop the match
- `|`meaning OR (other pattern possible after the FAIL `*(F)`
- ` - ` match " - " that then will be replace

The help I got :
- https://stackoverflow.com/questions/5925738/which-regular-expression-operator-means-dont-match-this-character
- https://stackoverflow.com/questions/26574077/replace-all-occurrences-after-nth-occurrence-php
- https://stackoverflow.com/a/7124976/2444948
- https://stackoverflow.com/questions/55874998/replace-nth-occurrence-of-a-character-in-a-string-with-something-else
