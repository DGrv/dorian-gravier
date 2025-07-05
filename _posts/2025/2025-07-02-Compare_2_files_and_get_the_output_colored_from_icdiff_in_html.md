--- 
title: "Compare 2 files and get the output colored from icdiff in html" 
date: "2025-07-02 15:26" 
comments_id: --------------------- 
--- 

I already posted the [icdiff](https://github.com/jeffkaufman/icdiff) tool to compare 2 files. 

I would like to do this on a large file and share the output console while keeping the colors.

```sh
icdiff file1.txt file2.txt -W | tee diff.ansi.txt

pip install ansi2html
ansi2html < diff.ansi.txt > diff.html

# if you wanna run this in Rtsudio:
system('bash -c "icdiff --cols=300 \\"file1.txt\\" \\"file2.txt\\" -W | tee diff.ansi.txt"')
system('cmd.exe /c "type diff.ansi.txt | ansi2html > diff.html"')



```





