---
title: "Extract the first letter of each word in string via R"
date: "2022-11-22 09:00"
comments_id: 54
---

```r
library(data.table)

# example 

>     head(data[, .N, FARBE])

            FARBE  N
1: Royal / Indigo  1
2: Red / Dark Red  3
3: Dark Red / Red  2
4:          Black 51
5:       Sea Foam 13
6:      Navy Blue  3

>     data[, CC := gsub('\\b(\\pL)\\pL{2,}|.', '\\U\\1', FARBE, perl = TRUE)] # if 2 words get first letter

>     head(data[, .N, .(FARBE, CC)])

            FARBE  CC  N
1: Royal / Indigo  RI  1
2: Red / Dark Red RDR  3
3: Dark Red / Red DRR  2
4:          Black   B 51
5:       Sea Foam  SF 13
6:      Navy Blue  NB  3
```
 


