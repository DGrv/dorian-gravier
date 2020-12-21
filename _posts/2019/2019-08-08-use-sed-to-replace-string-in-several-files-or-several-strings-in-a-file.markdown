---
layout: "post"
title: "Use sed to replace string in several files or several strings in a file"
date: "2019-08-08 14:20"
comments_id: 	31
---

I used 'sed' not so often but each time it is a nice wonder to realize what you can do with it.

I am on Windows and I am using [Gow](https://github.com/bmatzelle/gow) to use such tool from linux (like grep, ls, and so on) with the cmd console.

You can do a lot of things with this tool that I will not explain (because actually I know really litle, [but you can find a lot on the web](https://likegeeks.com/regex-tutorial-linux/)).

The actual scenario I had was a logfile with several lines that I add to change.

I had to filter which line I wanna change and to just change the part I need so for each line I had a *sed* command like this one :

```shell
sed -i -E "s/(.+)S=2:C=4(.+)BAR CODE READ, NOCODE(.+)/\1S=2:C=4\2BAR CODE READ, AP0001\3/g" *
```
*_Explanation*_:

sed -i `-E` *(for regular expression)* "s/`(.+)` *(All character, group 1)* S=2:C=4`(.+)` *(All character, group 2)* BAR CODE READ, NOCODE`(.+)` *(All character, group 3)* /`\1` *(Past group 1)* S=2:C=4`\2` *(Past group 2)* BAR CODE READ, AP0001`\3` *(Past group 3)* /g" *


Was changing this
`[2019/08/07 11:11:33] INFO: [S=2:C=4(LDV384):I=32(sbcr):Q=50:M=2] DATA, BAR CODE READ, NOCODE^M`
in this
`[2019/08/07 11:11:33] INFO: [S=2:C=4(LDV384):I=32(sbcr):Q=50:M=2] DATA, BAR CODE READ, AP0001^M`

I was using 1 sed cmd per substitution because I had a lot of NOCODE to substitute in the same file so I had to be sure I am picking the right line to work on.

Parameter `-E` is meaning that Regex Expression is used.

