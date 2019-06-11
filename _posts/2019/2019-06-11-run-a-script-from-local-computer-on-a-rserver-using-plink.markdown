---
layout: "post"
title: "Run a script from local computer on a Rserver using plink"
date: "2019-06-11 16:55"
---

You know Rstudio (Desktop) ? Do you Rstudio Server ?
Great solution for companies to avoid to install R on all computer (sounds logic ?).

Good as a programmer you are sometimes creating small tools for your colleagues... with R maybe. Well you do not want to install R on their computer (packages updates and so on, even Rportable is not a real option).
Why not using SSH to tell your Rserver to do a certain job ?
Why not doing this with unique user input ?

A small solution is to combine batch code and plink which would send command via ssh.

The idea is that you use batch language to ask your user 1 or several input (working directoy, a numeric variable or character variable).

Here how to do:

```shell
@echo off

:: ask input to your user
set /p wd=Give me an character input (for example working directory)
set /p characterVector=User, give a character vector (for example c('AP0001', 'AP0002') )

echo n | plink.exe -v -ssh <user> -pw <password> "Rscript <path-of-your-script-on-the-server> '%wd%' \"%characterVector%\""

```

To make this work you need to read those 2 arguments in the Rscript (`%wd%`, `%characterVector%`).

```r
args <- commandArgs(TRUE)
setwd(args[1])
yourVector <- eval(parse(text=args[2]))
```

You see here that I use `eval(parse(text=args[2]))` for the 2 element vector. This vector is actually just a character element  "c('AP0001', 'AP0002')" for example. You need to evaluate in R language to be able to extract each element of it (`'AP0001'` and `'AP0002'`).

You can adapt the batch script to your needs. You may find interesting ideas or codes on the net or even on the [Code](Code.html) section here.
