--- 
title: "How to find the longest common string in a vector in R" 
date: "2022-11-24 15:36" 
comments_id: 55
--- 
 
 To get the [longest common string](https://en.wikipedia.org/wiki/Longest_common_substring_problem) on a vector of strings in R, I adapted the answer of [@Rich Scriven](https://stackoverflow.com/a/28263447/2444948) to my purpose.
The goal is to find in a vector the longest commong string instead of the one between 2 strings. At the end it is possible use it then in data.table by group.

**Example:**

```r 
library(data.table)
library(stringi)

# create the function ------------------------------------

get.lcs.vector <- function(your.vector) {
  
  # get longest common string
  get.lcs <- function(x, y) {
    # get longest common string
    sb <- stri_sub(y, 1, 1:nchar(y))
    sstr <- na.omit(stri_extract_all_coll(x, sb, simplify=TRUE))
    result <- sstr[which.max(nchar(sstr))]
    return(result)
  }
  combi <- data.table(expand.grid(your.vector, your.vector, stringsAsFactors = F))[Var1 != Var2]
  combi.result <- unique(mapply(get.lcs, combi[[1]], combi[[2]]))
  lcs <- combi.result[which.min(nchar(combi.result))]
  return(lcs)
}

# example of data ------------------------------------

dt <- data.table(AN = c("APILCASERNB", "APILCASELNB", "APILCASEYHANB", 
                        "A15DPGY", "A15DPRD", "A15DPWH", "A15DPDB", "A15DPYW", "A15DPTL", 
                        "A15DP4PGY", "A15DP4PRD", "A15DP4PWH", "A15DP4PDB", "A15DP4PYW", 
                        "A15DP4PTL"),
                 Name = c("Example1", "Example1", "Example1", "Example2", 
                          "Example2", "Example2", "Example2", "Example2", "Example2", "Example3", 
                          "Example3", "Example3", "Example3", "Example3", "Example3"))

dt

##                AN     Name
##  1:   APILCASERNB Example1
##  2:   APILCASELNB Example1
##  3: APILCASEYHANB Example1
##  4:       A15DPGY Example2
##  5:       A15DPRD Example2
##  6:       A15DPWH Example2
##  7:       A15DPDB Example2
##  8:       A15DPYW Example2
##  9:       A15DPTL Example2
## 10:     A15DP4PGY Example3
## 11:     A15DP4PRD Example3
## 12:     A15DP4PWH Example3
## 13:     A15DP4PDB Example3
## 14:     A15DP4PYW Example3
## 15:     A15DP4PTL Example3


# smaller exmaple ------------------------------------

dt.ex <- dt[Name == unique(Name)[1]]
dt.ex

##               AN     Name
## 1:   APILCASERNB Example1
## 2:   APILCASELNB Example1
## 3: APILCASEYHANB Example1

get.lcs.vector(dt.ex$AN)

## [1] "APILCASE"

# you can also start from end like this
stri_reverse(get.lcs.vector(stri_reverse(dt.ex$AN)))



# Example on all data.table ------------------------------------

dt[, AN2 := get.lcs.vector(AN), Name]
dt

##                AN     Name      AN2
##  1:   APILCASERNB Example1 APILCASE
##  2:   APILCASELNB Example1 APILCASE
##  3: APILCASEYHANB Example1 APILCASE
##  4:       A15DPGY Example2    A15DP
##  5:       A15DPRD Example2    A15DP
##  6:       A15DPWH Example2    A15DP
##  7:       A15DPDB Example2    A15DP
##  8:       A15DPYW Example2    A15DP
##  9:       A15DPTL Example2    A15DP
## 10:     A15DP4PGY Example3  A15DP4P
## 11:     A15DP4PRD Example3  A15DP4P
## 12:     A15DP4PWH Example3  A15DP4P
## 13:     A15DP4PDB Example3  A15DP4P
## 14:     A15DP4PYW Example3  A15DP4P
## 15:     A15DP4PTL Example3  A15DP4P
```
 
