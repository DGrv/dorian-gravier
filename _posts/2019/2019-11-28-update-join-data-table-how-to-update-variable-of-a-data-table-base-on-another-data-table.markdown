---
title: "Update join data.table: How to update variable of a data.table base on another data.table"
date: "2019-11-28 15:53"
comments_id: 	33
---


Goal is to update values from 1 or several variables from a data.table (X) with values of variables from another data.table (Y).

Let's imagine that you have in X 3 variables and Y with others

```r
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

You wanna now based on 'id' exchange the variable 'L':

```r
> update.DT(DATA1 = X, DATA2 = Y, join.variable = "id", overwrite.variable = c("L"), overwrite.with.variable = c("L"))
   id L PS
1:  1 a 59
2:  2 b 59
3:  3 z 59
4:  4 g 59
5:  5 h 59
```

Or 'L' and 'PS' based on 'id':

```r
> update.DT(DATA1 = X2, DATA2 = Y, join.variable = "id", overwrite.variable = c("L", "PS"), overwrite.with.variable = c("L", "PS"))
   id L PS
1:  1 a 59
2:  2 b 59
3:  3 z 61
4:  4 g 61
5:  5 h 61
```

Or maybe you wanna also update 'id' in addition:

```r
> update.DT(DATA1 = X2, DATA2 = Y, join.variable = "id", overwrite.variable = c("L", "PS", "id"), overwrite.with.variable = c("L", "PS", "id2"))
   id L PS
1:  1 a 59
2:  2 b 59
3: 11 z 61
4: 12 g 61
5: 13 h 61
```

Here the function resulting from this:

```r
update.DT <- function(DATA1, DATA2, join.variable, overwrite.variable, overwrite.with.variable) {
  
  if( missing( overwrite.with.variable )) {
    overwrite.with.variable <- overwrite.variable
    cat("[INFO] - your 'overwrite.with.variable' will be 'overwrite.variable', since you did not defined it.\n\n")
  }
  
  DATA1[DATA2, c(overwrite.variable) := mget(p0("i.", overwrite.with.variable)), on = join.variable][]
  
}
```


Sources:

- [https://stackoverflow.com/questions/44433451/r-data-table-update-join/59091395#59091395](https://stackoverflow.com/questions/44433451/r-data-table-update-join/59091395#59091395)
- [https://stackoverflow.com/questions/32371188/merge-and-replace-values-in-two-data-tables](https://stackoverflow.com/questions/32371188/merge-and-replace-values-in-two-data-tables)
