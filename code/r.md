---
permalink: /code/r/
toc: true
---


# data.table tricks

## Add last row as colnames for html

``` r
listimg3 <- rbindlist(list(listimg3, as.list(colnames(listimg3)))) # put again name of columns at the end
```

## Create group ID or row ID

``` r
temp2 <- structure(list(CP = c("CRT_REF_0018", "CRT_REF_0019", "CRT_REF_0016",
"CRT_REF_0006", "CRT_REF_0007", "CRT_REF_0008", "CRT_REF_0009",
"CRT_REF_0003", "CRT_REF_0007", "CRT_REF_0015", "CRT_REF_0016",
"CRT_REF_0008", "CRT_REF_0007", "CRT_REF_0018", "CRT_REF_0017",
"CRT_REF_0015", "CRT_REF_0008", "CRT_REF_0008", "CRT_REF_0016",
"CRT_REF_0006", "CRT_REF_0018", "CRT_REF_0005", "CRT_REF_0007",
"CRT_REF_0006", "CRT_REF_0004", "CRT_REF_0015", "CRT_REF_0017",
"CRT_REF_0004", "CRT_REF_0019", "CRT_REF_0012", "CRT_REF_0004",
"CRT_REF_0012", "CRT_REF_0017", "CRT_REF_0018", "CRT_REF_0016",
"CRT_REF_0017", "CRT_REF_0015", "CRT_REF_0004", "CRT_REF_0009",
"CRT_REF_0019", "CRT_REF_0003", "CRT_REF_0005", "CRT_REF_0010",
"CRT_REF_0016", "CRT_REF_0016", "CRT_REF_0012", "CRT_REF_0007",
"CRT_REF_0015", "CRT_REF_0010", "CRT_REF_0017", "CRT_REF_0007",
"CRT_REF_0012", "CRT_REF_0015", "CRT_REF_0003", "CRT_REF_0009",
"CRT_REF_0003", "CRT_REF_0015", "CRT_REF_0009", "CRT_REF_0004",
"CRT_REF_0012", "CRT_REF_0019", "CRT_REF_0006", "CRT_REF_0008",
"CRT_REF_0018", "CRT_REF_0009", "CRT_REF_0011", "CRT_REF_0005",
"CRT_REF_0012", "CRT_REF_0016", "CRT_REF_0008", "CRT_REF_0009",
"CRT_REF_0008", "CRT_REF_0005", "CRT_REF_0019", "CRT_REF_0018",
"CRT_REF_0019", "CRT_REF_0005", "CRT_REF_0007", "CRT_REF_0009",
"CRT_REF_0017", "CRT_REF_0012", "CRT_REF_0006"), Session = c(17,
16, 12, 10, 7, 9, 12, 4, 11, 18, 13, 13, 12, 14, 18, 12, 12,
8, 18, 11, 15, 11, 10, 8, 4, 14, 19, 5, 20, 15, 7, 14, 14, 19,
14, 17, 13, 8, 11, 21, 6, 6, 7, 15, 17, 12, 13, 17, 10, 16, 9,
13, 16, 3, 14, 5, 15, 9, 6, 18, 18, 6, 7, 16, 10, 11, 10, 16,
16, 10, 7, 11, 9, 19, 18, 17, 8, 8, 13, 15, 17, 9)), .Names = c("CP",
"Session"), class = c("data.table", "data.frame"))

temp2
# temp2 need to be ordered depending on the 2 variable you are interested too.
# rowid is just creating an id depending on a variable (here CP), but of course the table as to be sorted if it is depending on another variable (here Session)
temp2[order(CP, Session), Usage_cycle := rowid(CP)]
temp2
all[order(CP, row, col, TD), Dupli := rowid(CP, row, col, TD)] # complexer example

# other group id exists but the output is different, just other purpose, still highly usefull
temp2[, groupid := .GRP, .(CP,Session)] # here is the group id per combinaison, so each combinaison (CP,Session) as a unique id
temp2
temp2[, groupid2 := seq_len(.N), .(CP,Session)] # here checking if the number of times the combinaison exists
temp2
temp2[, groupid3 := 1:.N, .(CP,Session)] # listimg2[, Repli := 1:.N, .(CPid, Field, What, CCM)]
temp2
```

    [Source 1](https://stackoverflow.com/questions/13018696/data-table-key-indices-or-group-counter) and [source 2](https://stackoverflow.com/questions/12925063/numbering-rows-within-groups-in-a-data-frame?noredirect=1&lq=1)

## Max of a variable per group of variable

``` r
dataCP <- data[data[, .I[Zprimefactor == max(Zprimefactor, na.rm = T)], .(CP, Q)]$V1] # take best QC for a CP-Q
```

## Calculation per group, by

``` r
rawWP[, MeasTime := .SD[1, MeasTime], Sample]
rawWP[, MeasTime := max(.SD$MeasTime), Sample]
```

## Best 3 of a variable per group of variable (same variante as before but for DRC, meaning take the 3 best plates per CP)

``` r
step1 <-  dataCP[, .N, .(CP, IP, Zprimefactor, Assay)] # summarize table to have 1 Zprimefactor per plate (due to use function sort)
step2 <- step1[, .I[Zprimefactor %in% sort(Zprimefactor, decreasing = T)[1:3]], .(CP, Assay)] # get the 3 best Zprimefactor per Assay and CP
step3 <- step1[step2$V1][, ':=' (Zprimefactor = NULL, N = NULL, Assay = NULL)] # get then the plate to keep
dataCP <- dtjoin(dataCP, step3, "inner") # join again both here used as a subset.
```

## Modify multiples columns at the same time

with user function:

``` r
grepcol <- function(pattern, data) {
return( names(data)[grep(pattern, names(data))] )
}

html1[ , (grepcol("DRC", html)) := lapply(.SD, function(x) gsub("~/HTS/", "H:/", x)), .SDcols = grepcol("DRC", html)]
html1 <- html1[ , (grepcol("DRC", html)) := lapply(.SD, function(x) addimgbalise(x, 100)), .SDcols = grepcol("DRC", html)]
htmlb64[ , (grepcol("DRC", html)) := lapply(.SD, function(x) mapply(image_uri, x, SIMPLIFY = T)), .SDcols = grepcol("DRC", html)]
```

## Order columns

``` r
setcolorder(html, c("sample", temp$colname))
```

## Summarize table depending on BY and .SDcols

``` r
temp <- rawWP[Sample %in% listsample[combin[,i]]]
temp2 <- rbind(temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What ="mean", lapply(.SD, mean)), .(row, col), .SDcols = coltokeep],
temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What = "sd", lapply(.SD, sd)), .(row, col), .SDcols = coltokeep],
temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What = "median", lapply(.SD, median)), .(row, col), .SDcols = coltokeep])
```

[Source 1](https://stackoverflow.com/questions/20459519/apply-function-on-a-subset-of-columns-sdcols-whilst-applying-a-different-func) and [source 2](https://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table?lq=1)

## Replace all values conditionnaly

``` r
for(col in names(dataBC2)) {
    set(dataBC2, i=which(dataBC2[[col]] %in% dataNoPrint$AP), j=col, value="NoPrint")
}
```

[Source](https://stackoverflow.com/questions/38226323/replace-all-values-in-a-data-table-given-a-condition?rq=1)

## sum of all previous row by a variable

``` r
setkey(dataPall, ID, Time) # important for ordering
# calculate theory volume
dataPall[, VolDispTT := cumsum(shift(VolumeTrans / 1000, fill=0)), by=ID] # order with setkey. sum of all previous rows per group, shift permit to shift the column of 1 row down.
```

## Access data.table with string

For i `DT[get("x") == "b"]`

For j `DT[, get("x")]`

With by `DT[, .N, "x"]` or `DT[, .N, c("x", "y")`

## find duplicated value in data.table

``` r
data[, check := .N > 1, .(Value.NPI, CPid, Sample, Hits)]
  data[check == T]


myDT <- data.table(id = sample(1e6),
                 fB = sample(seq_len(1e3), size= 1e6, replace=TRUE),
                 fC = sample(seq_len(1e3), size= 1e6,replace=TRUE ))
setkey(myDT, fB, fC)

microbenchmark(
   key=myDT[, fD := .N > 1, by = key(myDT)],
   unique=myDT[unique(myDT, by = key(myDT)),fD:=.N>1],
   dup = myDT[,fD := duplicated.data.frame(.SD)|duplicated.data.frame(.SD, fromLast=TRUE),
              .SDcols = key(myDT)],
   dup2 = {dups = duplicated(myDT, by = key(myDT)); myDT[, fD := dups | c(tail(dups, -1L), FALSE)]},
   dup3 = {dups = duplicated(myDT, by = key(myDT)); myDT[, fD := dups | c(dups[-1L], FALSE)]},
   times=10)

#   expr       min        lq      mean    median        uq       max neval
#    key  523.3568  567.5372  632.2379  578.1474  678.4399  886.8199    10
# unique  189.7692  196.0417  215.4985  210.5258  224.4306  290.2597    10
#    dup 4440.8395 4685.1862 4786.6176 4752.8271 4900.4952 5148.3648    10
#   dup2  143.2756  153.3738  236.4034  161.2133  318.1504  419.4082    10
#   dup3  144.1497  150.9244  193.3058  166.9541  178.0061  460.5448    10
```

[Source here](https://stackoverflow.com/questions/19392332/find-all-duplicated-records-in-data-table-not-all-but-one)

## Replace values of a table with values of another table

Simple idea :

BC2\[mapref, ‘:=’ (CCM = i.CCM, CPid = i.CPid), on=.(row, col, CP)\] Goal is to update values from 1 or several variables from a data.table (X) with values of variables from another data.table (Y).

Let’s imagine that you have in X 3 variables and Y with others

``` r
> X <- X2 <- X3 <- data.table(id = 1:5, L = letters[1:5], PS = rep(59, 5))
> X
   id L PS
1:  1 a 59
2:  2 b 59
3:  3 c 59
4:  4 d 59
5:  5 e 59


> Y <- data.table(id = 3:5, id2 = 11:13, L = c("z", "g", "h"), PS = rep(61, 3))
> Y
   id id2 L PS
1:  3  11 z 61
2:  4  12 g 61
3:  5  13 h 61
```

You wanna now based on ‘id’ exchange the variable ‘L’:

``` r
> update.DT(DATA1 = X, DATA2 = Y, join.variable = "id", overwrite.variable = c("L"), overwrite.with.variable = c("L"))
   id L PS
1:  1 a 59
2:  2 b 59
3:  3 z 59
4:  4 g 59
5:  5 h 59
```

Or ‘L’ and ‘PS’ based on ‘id’:

``` r
> update.DT(DATA1 = X2, DATA2 = Y, join.variable = "id", overwrite.variable = c("L", "PS"), overwrite.with.variable = c("L", "PS"))
   id L PS
1:  1 a 59
2:  2 b 59
3:  3 z 61
4:  4 g 61
5:  5 h 61
```

Or maybe you wanna also update ‘id’ in addition:

``` r
> update.DT(DATA1 = X2, DATA2 = Y, join.variable = "id", overwrite.variable = c("L", "PS", "id"), overwrite.with.variable = c("L", "PS", "id2"))
   id L PS
1:  1 a 59
2:  2 b 59
3: 11 z 61
4: 12 g 61
5: 13 h 61
```

Here the function resulting from this:

``` r
update.DT <- function(DATA1, DATA2, join.variable, overwrite.variable, overwrite.with.variable) {
  
  if( missing( overwrite.with.variable )) {
    overwrite.with.variable <- overwrite.variable
    cat("[INFO] - your 'overwrite.with.variable' will be 'overwrite.variable', since you did not defined it.\n\n")
  }
  
  DATA1[DATA2, c(overwrite.variable) := mget(p0("i.", overwrite.with.variable)), on = join.variable][]
  
}
```

Sources:

- <https://stackoverflow.com/questions/44433451/r-data-table-update-join/59091395#59091395>
- <https://stackoverflow.com/questions/32371188/merge-and-replace-values-in-two-data-tables>

## Remove or keep first row or other rows from a filtered data.table

Let’s imagine a table mpg

``` r
mpg2 <- data.table(mpg)


mpg2



     # manufacturer  model displ year cyl      trans drv cty hwy fl   class
  # 1:         audi     a4   1.8 1999   4   auto(l5)   f  18  29  p compact
  # 2:         audi     a4   1.8 1999   4 manual(m5)   f  21  29  p compact
  # 3:         audi     a4   2.0 2008   4 manual(m6)   f  20  31  p compact
  # 4:         audi     a4   2.0 2008   4   auto(av)   f  21  30  p compact
  # 5:         audi     a4   2.8 1999   6   auto(l5)   f  16  26  p compact
 # ---                                                                     
# 230:   volkswagen passat   2.0 2008   4   auto(s6)   f  19  28  p midsize
# 231:   volkswagen passat   2.0 2008   4 manual(m6)   f  21  29  p midsize
# 232:   volkswagen passat   2.8 1999   6   auto(l5)   f  16  26  p midsize
# 233:   volkswagen passat   2.8 1999   6 manual(m5)   f  18  26  p midsize
# 234:   volkswagen passat   3.6 2008   6   auto(s6)   f  17  26  p midsize


# I wanna first filter the table with year is 1999 and that it is an manual


mpg2[year == "1999" & grepl("manual", trans)]




    # manufacturer               model displ year cyl      trans drv cty hwy fl      class
 # 1:         audi                  a4   1.8 1999   4 manual(m5)   f  21  29  p    compact
 # 2:         audi                  a4   2.8 1999   6 manual(m5)   f  18  26  p    compact
 # 3:         audi          a4 quattro   1.8 1999   4 manual(m5)   4  18  26  p    compact
 # 4:         audi          a4 quattro   2.8 1999   6 manual(m5)   4  17  25  p    compact
 # 5:    chevrolet            corvette   5.7 1999   8 manual(m6)   r  16  26  p    2seater
 # 6:        dodge   dakota pickup 4wd   3.9 1999   6 manual(m5)   4  14  17  r     pickup
 # 7:        dodge   dakota pickup 4wd   5.2 1999   8 manual(m5)   4  11  17  r     pickup
 # 8:        dodge ram 1500 pickup 4wd   5.2 1999   8 manual(m5)   4  11  16  r     pickup
 # 9:         ford        explorer 4wd   4.0 1999   6 manual(m5)   4  15  19  r        suv
# 10:         ford     f150 pickup 4wd   4.2 1999   6 manual(m5)   4  14  17  r     pickup
# 11:         ford     f150 pickup 4wd   4.6 1999   8 manual(m5)   4  13  16  r     pickup
# 12:         ford             mustang   3.8 1999   6 manual(m5)   r  18  26  r subcompact
# 13:         ford             mustang   4.6 1999   8 manual(m5)   r  15  22  r subcompact
# 14:        honda               civic   1.6 1999   4 manual(m5)   f  28  33  r subcompact
# 15:        honda               civic   1.6 1999   4 manual(m5)   f  25  32  r subcompact
# 16:        honda               civic   1.6 1999   4 manual(m5)   f  23  29  p subcompact
# 17:      hyundai              sonata   2.4 1999   4 manual(m5)   f  18  27  r    midsize
# 18:      hyundai              sonata   2.5 1999   6 manual(m5)   f  18  26  r    midsize
# 19:      hyundai             tiburon   2.0 1999   4 manual(m5)   f  19  29  r subcompact
# 20:       nissan              altima   2.4 1999   4 manual(m5)   f  21  29  r    compact
# 21:       nissan              maxima   3.0 1999   6 manual(m5)   f  19  25  r    midsize
# 22:       nissan      pathfinder 4wd   3.3 1999   6 manual(m5)   4  15  17  r        suv
# 23:       subaru        forester awd   2.5 1999   4 manual(m5)   4  18  25  r        suv
# 24:       subaru         impreza awd   2.2 1999   4 manual(m5)   4  19  26  r subcompact
# 25:       subaru         impreza awd   2.5 1999   4 manual(m5)   4  19  26  r subcompact
# 26:       toyota         4runner 4wd   2.7 1999   4 manual(m5)   4  15  20  r        suv
# 27:       toyota         4runner 4wd   3.4 1999   6 manual(m5)   4  15  17  r        suv
# 28:       toyota               camry   2.2 1999   4 manual(m5)   f  21  29  r    midsize
# 29:       toyota               camry   3.0 1999   6 manual(m5)   f  18  26  r    midsize
# 30:       toyota        camry solara   2.2 1999   4 manual(m5)   f  21  29  r    compact
# 31:       toyota        camry solara   3.0 1999   6 manual(m5)   f  18  26  r    compact
# 32:       toyota             corolla   1.8 1999   4 manual(m5)   f  26  35  r    compact
# 33:       toyota   toyota tacoma 4wd   2.7 1999   4 manual(m5)   4  15  20  r     pickup
# 34:       toyota   toyota tacoma 4wd   3.4 1999   6 manual(m5)   4  15  17  r     pickup
# 35:   volkswagen                 gti   2.0 1999   4 manual(m5)   f  21  29  r    compact
# 36:   volkswagen                 gti   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 37:   volkswagen               jetta   1.9 1999   4 manual(m5)   f  33  44  d    compact
# 38:   volkswagen               jetta   2.0 1999   4 manual(m5)   f  21  29  r    compact
# 39:   volkswagen               jetta   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 40:   volkswagen          new beetle   1.9 1999   4 manual(m5)   f  35  44  d subcompact
# 41:   volkswagen          new beetle   2.0 1999   4 manual(m5)   f  21  29  r subcompact
# 42:   volkswagen              passat   1.8 1999   4 manual(m5)   f  21  29  p    midsize
# 43:   volkswagen              passat   2.8 1999   6 manual(m5)   f  18  26  p    midsize
    # manufacturer               model displ year cyl      trans drv cty hwy fl      class


# maybe I wanna order it


mpg2[year == "1999" & grepl("manual", trans)][order(model, -displ)]




    # manufacturer               model displ year cyl      trans drv cty hwy fl      class
 # 1:       toyota         4runner 4wd   3.4 1999   6 manual(m5)   4  15  17  r        suv
 # 2:       toyota         4runner 4wd   2.7 1999   4 manual(m5)   4  15  20  r        suv
 # 3:         audi                  a4   2.8 1999   6 manual(m5)   f  18  26  p    compact
 # 4:         audi                  a4   1.8 1999   4 manual(m5)   f  21  29  p    compact
 # 5:         audi          a4 quattro   2.8 1999   6 manual(m5)   4  17  25  p    compact
 # 6:         audi          a4 quattro   1.8 1999   4 manual(m5)   4  18  26  p    compact
 # 7:       nissan              altima   2.4 1999   4 manual(m5)   f  21  29  r    compact
 # 8:       toyota               camry   3.0 1999   6 manual(m5)   f  18  26  r    midsize
 # 9:       toyota               camry   2.2 1999   4 manual(m5)   f  21  29  r    midsize
# 10:       toyota        camry solara   3.0 1999   6 manual(m5)   f  18  26  r    compact
# 11:       toyota        camry solara   2.2 1999   4 manual(m5)   f  21  29  r    compact
# 12:        honda               civic   1.6 1999   4 manual(m5)   f  28  33  r subcompact
# 13:        honda               civic   1.6 1999   4 manual(m5)   f  25  32  r subcompact
# 14:        honda               civic   1.6 1999   4 manual(m5)   f  23  29  p subcompact
# 15:       toyota             corolla   1.8 1999   4 manual(m5)   f  26  35  r    compact
# 16:    chevrolet            corvette   5.7 1999   8 manual(m6)   r  16  26  p    2seater
# 17:        dodge   dakota pickup 4wd   5.2 1999   8 manual(m5)   4  11  17  r     pickup
# 18:        dodge   dakota pickup 4wd   3.9 1999   6 manual(m5)   4  14  17  r     pickup
# 19:         ford        explorer 4wd   4.0 1999   6 manual(m5)   4  15  19  r        suv
# 20:         ford     f150 pickup 4wd   4.6 1999   8 manual(m5)   4  13  16  r     pickup
# 21:         ford     f150 pickup 4wd   4.2 1999   6 manual(m5)   4  14  17  r     pickup
# 22:       subaru        forester awd   2.5 1999   4 manual(m5)   4  18  25  r        suv
# 23:   volkswagen                 gti   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 24:   volkswagen                 gti   2.0 1999   4 manual(m5)   f  21  29  r    compact
# 25:       subaru         impreza awd   2.5 1999   4 manual(m5)   4  19  26  r subcompact
# 26:       subaru         impreza awd   2.2 1999   4 manual(m5)   4  19  26  r subcompact
# 27:   volkswagen               jetta   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 28:   volkswagen               jetta   2.0 1999   4 manual(m5)   f  21  29  r    compact
# 29:   volkswagen               jetta   1.9 1999   4 manual(m5)   f  33  44  d    compact
# 30:       nissan              maxima   3.0 1999   6 manual(m5)   f  19  25  r    midsize
# 31:         ford             mustang   4.6 1999   8 manual(m5)   r  15  22  r subcompact
# 32:         ford             mustang   3.8 1999   6 manual(m5)   r  18  26  r subcompact
# 33:   volkswagen          new beetle   2.0 1999   4 manual(m5)   f  21  29  r subcompact
# 34:   volkswagen          new beetle   1.9 1999   4 manual(m5)   f  35  44  d subcompact
# 35:   volkswagen              passat   2.8 1999   6 manual(m5)   f  18  26  p    midsize
# 36:   volkswagen              passat   1.8 1999   4 manual(m5)   f  21  29  p    midsize
# 37:       nissan      pathfinder 4wd   3.3 1999   6 manual(m5)   4  15  17  r        suv
# 38:        dodge ram 1500 pickup 4wd   5.2 1999   8 manual(m5)   4  11  16  r     pickup
# 39:      hyundai              sonata   2.5 1999   6 manual(m5)   f  18  26  r    midsize
# 40:      hyundai              sonata   2.4 1999   4 manual(m5)   f  18  27  r    midsize
# 41:      hyundai             tiburon   2.0 1999   4 manual(m5)   f  19  29  r subcompact
# 42:       toyota   toyota tacoma 4wd   3.4 1999   6 manual(m5)   4  15  17  r     pickup
# 43:       toyota   toyota tacoma 4wd   2.7 1999   4 manual(m5)   4  15  20  r     pickup
    # manufacturer               model displ year cyl      trans drv cty hwy fl      class


# My wish would be to extract the model from 1999 with the highest displ (I could use max, but I will extract the first row)


mpg2[year == "1999" & grepl("manual", trans)][order(model, -displ), .SD[1], model]




                  # model manufacturer displ year cyl      trans drv cty hwy fl      class
 # 1:         4runner 4wd       toyota   3.4 1999   6 manual(m5)   4  15  17  r        suv
 # 2:                  a4         audi   2.8 1999   6 manual(m5)   f  18  26  p    compact
 # 3:          a4 quattro         audi   2.8 1999   6 manual(m5)   4  17  25  p    compact
 # 4:              altima       nissan   2.4 1999   4 manual(m5)   f  21  29  r    compact
 # 5:               camry       toyota   3.0 1999   6 manual(m5)   f  18  26  r    midsize
 # 6:        camry solara       toyota   3.0 1999   6 manual(m5)   f  18  26  r    compact
 # 7:               civic        honda   1.6 1999   4 manual(m5)   f  28  33  r subcompact
 # 8:             corolla       toyota   1.8 1999   4 manual(m5)   f  26  35  r    compact
 # 9:            corvette    chevrolet   5.7 1999   8 manual(m6)   r  16  26  p    2seater
# 10:   dakota pickup 4wd        dodge   5.2 1999   8 manual(m5)   4  11  17  r     pickup
# 11:        explorer 4wd         ford   4.0 1999   6 manual(m5)   4  15  19  r        suv
# 12:     f150 pickup 4wd         ford   4.6 1999   8 manual(m5)   4  13  16  r     pickup
# 13:        forester awd       subaru   2.5 1999   4 manual(m5)   4  18  25  r        suv
# 14:                 gti   volkswagen   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 15:         impreza awd       subaru   2.5 1999   4 manual(m5)   4  19  26  r subcompact
# 16:               jetta   volkswagen   2.8 1999   6 manual(m5)   f  17  24  r    compact
# 17:              maxima       nissan   3.0 1999   6 manual(m5)   f  19  25  r    midsize
# 18:             mustang         ford   4.6 1999   8 manual(m5)   r  15  22  r subcompact
# 19:          new beetle   volkswagen   2.0 1999   4 manual(m5)   f  21  29  r subcompact
# 20:              passat   volkswagen   2.8 1999   6 manual(m5)   f  18  26  p    midsize
# 21:      pathfinder 4wd       nissan   3.3 1999   6 manual(m5)   4  15  17  r        suv
# 22: ram 1500 pickup 4wd        dodge   5.2 1999   8 manual(m5)   4  11  16  r     pickup
# 23:              sonata      hyundai   2.5 1999   6 manual(m5)   f  18  26  r    midsize
# 24:             tiburon      hyundai   2.0 1999   4 manual(m5)   f  19  29  r subcompact
# 25:   toyota tacoma 4wd       toyota   3.4 1999   6 manual(m5)   4  15  17  r     pickup
                  # model manufacturer displ year cyl      trans drv cty hwy fl      class


# my goal now is actually from the orginal table to remove those rows, we will you then .I which will return the frow ID from those ones. However it should be a bit differently written. All of this in 1 line of code:
# mpg2[year == "1999" & grepl("manual", trans)] is same as mpg2[mpg2[, .I[year == "1999" & grepl("manual", trans)]]]
# mpg2[year == "1999" & grepl("manual", trans)] is same as mpg2[mpg2[, .I[year == "1999" & grepl("manual", trans)], model]$V1]

# goal is to first get row ID (V1) of filtered data and keep our important variable for future steps


mpg2[, .I[year == "1999" & grepl("manual", trans)], .(model, displ)]



                  # model displ  V1
 # 1:                  a4   1.8   2
 # 2:                  a4   2.8   6
 # 3:          a4 quattro   1.8   8
 # 4:          a4 quattro   2.8  13
 # 5:            corvette   5.7  24
 # 6:   dakota pickup 4wd   3.9  52
 # 7:   dakota pickup 4wd   5.2  56
 # 8: ram 1500 pickup 4wd   5.2  72
 # 9:        explorer 4wd   4.0  79
# 10:     f150 pickup 4wd   4.2  85
# 11:     f150 pickup 4wd   4.6  86
# 12:             mustang   3.8  91
# 13:             mustang   4.6  96
# 14:               civic   1.6 100
# 15:               civic   1.6 102
# 16:               civic   1.6 103
# 17:              sonata   2.4 110
# 18:              sonata   2.5 114
# 19:             tiburon   2.0 117
# 20:              altima   2.4 142
# 21:              maxima   3.0 149
# 22:      pathfinder 4wd   3.3 152
# 23:        forester awd   2.5 160
# 24:         impreza awd   2.2 167
# 25:         impreza awd   2.5 168
# 26:         4runner 4wd   2.7 174
# 27:         4runner 4wd   3.4 177
# 28:               camry   2.2 180
# 29:               camry   3.0 185
# 30:        camry solara   2.2 188
# 31:        camry solara   3.0 192
# 32:             corolla   1.8 196
# 33:   toyota tacoma 4wd   2.7 201
# 34:   toyota tacoma 4wd   3.4 204
# 35:                 gti   2.0 208
# 36:                 gti   2.8 212
# 37:               jetta   1.9 213
# 38:               jetta   2.0 214
# 39:               jetta   2.8 221
# 40:          new beetle   1.9 222
# 41:          new beetle   2.0 224
# 42:              passat   1.8 228
# 43:              passat   2.8 233
                  # model displ  V1


# then order and get the first row


mpg2[, .I[year == "1999" & grepl("manual", trans)], .(model, displ)][order(model, -displ), .SD[1], model]


                  # model displ  V1
 # 1:         4runner 4wd   3.4 177
 # 2:                  a4   2.8   6
 # 3:          a4 quattro   2.8  13
 # 4:              altima   2.4 142
 # 5:               camry   3.0 185
 # 6:        camry solara   3.0 192
 # 7:               civic   1.6 100
 # 8:             corolla   1.8 196
 # 9:            corvette   5.7  24
# 10:   dakota pickup 4wd   5.2  56
# 11:        explorer 4wd   4.0  79
# 12:     f150 pickup 4wd   4.6  86
# 13:        forester awd   2.5 160
# 14:                 gti   2.8 212
# 15:         impreza awd   2.5 168
# 16:               jetta   2.8 221
# 17:              maxima   3.0 149
# 18:             mustang   4.6  96
# 19:          new beetle   2.0 224
# 20:              passat   2.8 233
# 21:      pathfinder 4wd   3.3 152
# 22: ram 1500 pickup 4wd   5.2  72
# 23:              sonata   2.5 114
# 24:             tiburon   2.0 117
# 25:   toyota tacoma 4wd   3.4 204
                  # model displ  V1


# V1 is the row ID from original table, we have then just to remove it from it 


mpg2[!mpg2[, .I[year == "1999" & grepl("manual", trans)], .(model, displ)][order(model, -displ), .SD[1], model]$V1]


     # manufacturer  model displ year cyl      trans drv cty hwy fl   class
  # 1:         audi     a4   1.8 1999   4   auto(l5)   f  18  29  p compact
  # 2:         audi     a4   1.8 1999   4 manual(m5)   f  21  29  p compact
  # 3:         audi     a4   2.0 2008   4 manual(m6)   f  20  31  p compact
  # 4:         audi     a4   2.0 2008   4   auto(av)   f  21  30  p compact
  # 5:         audi     a4   2.8 1999   6   auto(l5)   f  16  26  p compact
 # ---                                                                     
# 205:   volkswagen passat   1.8 1999   4   auto(l5)   f  18  29  p midsize
# 206:   volkswagen passat   2.0 2008   4   auto(s6)   f  19  28  p midsize
# 207:   volkswagen passat   2.0 2008   4 manual(m6)   f  21  29  p midsize
# 208:   volkswagen passat   2.8 1999   6   auto(l5)   f  16  26  p midsize
# 209:   volkswagen passat   3.6 2008   6   auto(s6)   f  17  26  p midsize
```




