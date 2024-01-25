---
title: "Batch"
permalink: /code/batch/
toc: true
author_profile: false
layout: code
---



# Delete files via a regex

- Open the batch file
- Give the path in string
- Give your regex
- The batch will print the list of file and tell you how many file it will delete, ask user yes or no

```batchfile
@echo off

set /p dirpath=Where are your files ?
:: set dirpath=%~dp0 :: if you want to use the directory where the batch file is
set /p pattern=Which pattern do you wanna search (use regex: *.xml e.g.) :
:: combinason /s /b for fullpath+filename, /b for filename
for /f %%A in ('dir /s /b "%dirpath%\%pattern%" ^| find /v /c ""') do set cnt=%%A
echo File count = %cnt%

call :MsgBox "Do you want to delete all %pattern% in %dirpath%? %cnt% files found"  "VBYesNo+VBQuestion" "Click yes to delete the %pattern%"
if errorlevel 7 (
    echo NO - quit the batch file
) else if errorlevel 6 (
    echo YES - delete the files
    :: set you regex, %%i in batch file, % in cmd
    for /f "delims=" %%a in ('dir /s /b "%dirpath%\%pattern%"') do del "%%a"
)

:: avoid little window to popup
exit /b

:: VBS code for the yesNo popup
:MsgBox prompt type title
    setlocal enableextensions
    set "tempFile=%temp%\%~nx0.%random%%random%%random%vbs.tmp"
    >"%tempFile%" echo(WScript.Quit msgBox("%~1",%~2,"%~3") & cscript //nologo //e:vbscript "%tempFile%"
    set "exitCode=%errorlevel%" & del "%tempFile%" >nul 2>nul
    endlocal & exit /b %exitCode%
```

# Change color console

I created a batch file to change the color of the windows cmd windows. It is using [Ansicon](https://github.com/adoxa/ansicon). The goal is to make the console a bit more clear: You can see you self the difference :

![Picture](/assets/images/cmd_no_ansicon.jpg) ![Picture](/assets/images/cmd_with_ansicon.jpg)

The batch file is checking which OS you have:

- 32 or 64bits, to know which .exe to install
- XP or above, to adapt the way to write the ‘promptx’ variable

The only things that you have to do is adapt where you exe is and if needed change the color and the output in the prompt : “$e[1;31m$p$s$e\[1;34m$g$s\$e\[1;37m”

\]

```batchfile
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other
if %OS%==32BIT (
    if exist H:\ (
        H:
        H:\TEMP\Software\ansi186\x86\ansicon.exe -i
    ) else (
        X:
        X:\TEMP\Software\ansi186\x86\ansicon.exe -i
    )
)
if %OS%==64BIT (
    if exist H:\ (
        H:
        H:\TEMP\Software\ansi186\x64\ansicon.exe -i
    ) else (
        X:
        X:\TEMP\Software\ansi186\x64\ansicon.exe -i
    )
)

if %ver%==XP (
    reg add HKCU\Environment /v PROMPT /d "$e[1;31m$p$s$e[1;34m$g$s$e[1;37m" /f
) else (
    setx prompt $e[1;31m$p$s$e[1;34m$g$s$e[1;37m
)
```

# Get system info

## OS bits

```batchfile
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT (
    echo 32bits
) else (
    echo 64bits
)
```

## OS version

```batchfile
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other
echo %ver%
```

## Format date or time

If the input locale is englisch the month and day are reversed. Here a solution to get it right.

```batchfile
systeminfo | findstr /B /C:"Input Locale:" | find /i "de;" > NUL && set lan=de || set lan=en
if %lan%==de (
    set month=%date:~-7,2%
    set day=%date:~-10,2%
) else (
    set day=%date:~-7,2%
    set month=%date:~-10,2%
)
```

## Get timestamp

```batchfile
:: ---------- Find Time ----------
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
::set secs=%time:~6,2%
::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set year=%date:~-4%
systeminfo | findstr /B /C:"Input Locale:" | find /i "de;" > NUL && set lan=de || set lan=en
if %lan%==de (
    set month=%date:~-7,2%
    set day=%date:~-10,2%
) else (
    set day=%date:~-7,2%
    set month=%date:~-10,2%
)
if "%month:~0,1%" == " " set month=0%month:~1,1%
if "%day:~0,1%" == " " set day=0%day:~1,1%
set datetimef=%year%%month%%day%%hour%%min%
```


# Network

https://www.libe.net/themen/Netzwerk_durchleuchtet.php \_

```batchfile
:: a bit like netscan
arp -a

netstat -ano
net use
ping 10.13.20.21
nslookup
route print
```

# Tips

https://jonlabelle.com/snippets/language/dos

## Path and filenames

In addition, substitution of FOR variable references has been enhanced.
You can now use the following optional syntax:

- %\~I : expands %I removing any surrounding quotes
- %\~fI : expands %I to a fully qualified path name 
- %\~dI : expands %I to a drive letter only
- %\~pI : expands %I to a path only 
- %\~nI : expands %I to a file name only
- %\~xI : expands %I to a file extension only
- %\~sI : expanded path contains short names only
- %\~aI : expands %I to file attributes of file
- %\~tI : expands %I to date/time of file 
- %\~zI : expands %I to size of file 
- %\~\$PATH:I : searches the directories listed in the PATH environment variable and expands %I to the fully qualified name of the first one found. If the environment variable name is not defined or the file is not found by the search, then this modifier expands to the empty string

The modifiers can be combined to get compound results:

- %\~dpI : expands %I to a drive letter and path only
- %\~nxI : expands %I to a file name and extension only
- %\~fsI : expands %I to a full path name with short names only 
- %\~dp\$PATH:I : searches the directories listed in the PATH environment variable for %I and expands to the drive letter and path of the first one found. 
- %\~ftzaI : expands %I to a DIR like output line

In the above examples %I and PATH can be replaced by other valid values.
The %\~ syntax is terminated by a valid FOR variable name. Picking upper
case variable names like %I makes it more readable and avoids confusion
with the modifiers, which are not case sensitive.

```batchfile
@echo off
setlocal

set filepath="C:\some path\having spaces.txt"

for /F "delims=" %%i in (%filepath%) do set dirname="%%~dpi"
for /F "delims=" %%i in (%filepath%) do set filename="%%~nxi"
for /F "delims=" %%i in (%filepath%) do set basename="%%~ni"

echo %dirname%
echo %filename%
echo %basename%

endlocal
exit /b %errorlevel%
```

## Modify Path

Echo PATH with new line

```sh
echo %PATH:;=&echo.%
```


Permanently add a directory to the system PATH variable (for all users):

```sh
setx /M path "%PATH%;C:\path\to\directory\"
```



## Find which OS

https://stackoverflow.com/questions/1738985/why-processor-architecture-always-returns-x86-instead-of-amd64

MOST RELIABLE SOLUTION: Method 1: (Two step Validation with
PROCESSOR_ARCHITECTURE and PROCESSOR_ARCHITEW6432) \_

set Arch=x64 if "%PROCESSOR_ARCHITECTURE%" == "x86" ( if not defined
PROCESSOR_ARCHITEW6432 set Arch=x86 )

if %Arch% == "x64" ( msg \* "yessss" ) else ( msg \* "noooo" ) Method 2:

reg Query
"HKLM`\Hardware`{=tex}`\Description`{=tex}`\System`{=tex}`\CentralProcessor`{=tex}\\0"
\| find /i "x86" \> NUL && set OS=32BIT \|\| set OS=64BIT

if %OS%==32BIT echo "YESSS" if %OS%==64BIT echo "NOOO"

## Rename

### brename

Can be installed via [scoop]().

```batchfile
:: to see what will be done
brename -d -p "(.+).mp4" -r "{nr}.mp4" --nr-width 3
:: to run it
brename -p "(.+).mp4" -r "{nr}.mp4" --nr-width 3
```


### jren batch file

Using jren.bat : https://www.dostips.com/forum/viewtopic.php?t=6081

    jren "(\d+)_(\d+).tif$" "$1+'___'+$n+'.tif'" /npad 1 /j /i /t

Rename with sed, grep and xargs Use the bin from git and not from Gow
(git/usr/bin)

```batchfile
:: Replace space in file
ls | grep " " | sed -e "p;s/ /_/g" | xargs -d "\n" -t -n2 mv

:: sed -e "p;s/ /_/g" ---> -e is for regex, it will print the line and exchange the space and print it again, the g means replace all occurences
:: xargs -d "\n" -t -n2 mv ---> this is the only way I found. Use mv insteand of rename which does not work because of single quotes. -d is the delimter, otherwise xargs take spaces, -t is too print as well the cmd to check, -n2 is telling 2 arguments to use
```



## Count number of lines in file

```batchfile
wc -l < %list% 
```

## Count number of files

```batchfile
dir /b "*.tif" | find /c "%%~na" > temp
set /p howmany= < temp
set /a howmany=howmany
del temp
```

## Get last file

´get the last file in the list to get the ext
https://stackoverflow.com/questions/47450531/batch-write-output-of-dir-to-a-variable

`for /f "delims=" %%a in ('dir /a-d /b /s %input%') do set "last=%%a"`

## sed - Print specific line or removes lines

You can use sed to print specific lines Mainly using `sed`

```batchfile
sed -n 1p example.txt :: print line 1
sed -n 3p example.txt :: print line 3
sed -n 1,3p example.txt :: print line 1 to 3
sed -n -e 1p -e 3p server.txt :: print line 1 and 3

sed "$ d" example.txt :: remove last line (you can also do it with tail)

head -5 example.txt :: will print first 5 lines
tail -5 example.txt

sed "s/  //g"
```

Source:
https://linuxcommando.blogspot.com/2008/03/using-sed-to-extract-lines-in-text-file.html

You can exchange strings or add strings after or before a certain line

```batchfile
sed -i "4 i   if( paste0(Sys.info()[4]) == 'DESKTOP-MG495PG' ) {" *
sed -i "5i       rootpath <- 'C:/Users/doria/Dropbox/Dorian/'" *
sed -i "6i      datapath <- 'file:///C:/Users/doria/Dropbox/Dorian/Firmen_Listen_EAN/'" *
sed -i "7i    } else {" *
sed -i "8i      rootpath <- 'L:/JTL/'" *
sed -i "9i      datapath <- 'file:///L:/Diverses/Firmen_Listen_EAN/'" *
sed -i "10i    }" *
sed -i "11i    source(paste0(rootpath, "Dorian/BM_Function_v01.r"))" *
sed -i "12d" *
```

-   `-i` apply to the files, do not use this parameter to test
-   `"8i` ist to add after the line 8, use `a` for before of `i` for
    after

Here to substitute:

```batchfile
sed -i -E "s/  info <- data.table\(filename = c\((.+)/ info <- data.table\(filename = p0\(datapath, c\(\1/g" *
```

-   sed -i -E
    "s/`info <- data.table\(filename = c\((.+)`/`info <- data.table\(filename = p0\(datapath, c\(\1`/g"
    `*`
-   `-E` is meaning regular expression
-   `"s/`is telling the start
-   the come the string to find, you can use regex here
-   `(.+)` define all character and will be a group
-   in the second part it is with what to replace. `\1` correspond to
    the group found before
-   `*` to apply to all files

You can also find a match and print `p` the next line or delete `d`

```batchfile
:: Print line after match
sed -n "/<wpt lat=.. lon=..>/{n;p}" file 
:: Print 2 line after match
sed -n "/<wpt lat=.. lon=..>/{n;n;p}" file
:: Print 3 line after match
sed -n "/<wpt lat=.. lon=..>/{n;n;n;p}" file
:: Delete line after match
sed -n "/<wpt lat=.. lon=..>/{n;d}" file
:: delete after you need to flip over the file
REM remove line before certain pattern I have to flip over the file sed can not delete lines before or it is difficult
sed "1!G;h;$!d" "%%f" > temp
sed -i "/<name>Region:.*<\/name>/{n;d}" temp
sed "1!G;h;$!d" temp > "%%f"
sed -i "/<name>Region:.*<\/name>/{n;d}" "%%f"
sed -i "/<name>Region:.*<\/name>/{d}" "%%f"
rm temp
REM TAKE CARE need here a ^escape for the special character ! in batch only
REM TAKE CARE need here a ^escape for the special character ! in batch only
REM TAKE CARE need here a ^escape for the special character ! in batch only
sed "1^!G;h;$^!d" "%%f" > temp
```

could do also like this

```batchfile
sed '/start/,+4d'  # to delete "start" plus the next 4 lines,          
```

Delete, remove line based on pattern (delete line - replace all)

```batchfile
:: print only
sed "/Practical/d" temp_title.txt
:: delete directly in the file
sed -i "/Practical/d" temp_title.txt 
:: for all files recursively
grep -rl "layout" | xargs sed -i "/layout: post/d"
```

## Reverse Lines order

```batchfile
sed "1!G;h;$!d" file
```

Source: https://catonmat.net/sed-one-liners-explained-part-one

## Strings

### replace balise or line feed or carriage return

Replace btw wpt balise :)

```batchfile
sed "/wpt lat=\"\"/,/wpt>/d" 921.gpx
```

Source: https://forum.ubuntu-fr.org/viewtopic.php?id=453941

This option did not work as expected for removing text btw 2 balises. It
was deleting the all content after first match, problem is certain .\*
\*

```batchfile
sed ':a;N;$!ba;s/\n/ /g' file
sed -i ":a;N;$!ba;s/<wpt lat=\"\" lon=\"\">\n.*\n<\/wpt>/test/g"
```

:a create a label 'a' N append the next line to the pattern space \$! if
not the last line, ba branch (go to) label 'a' s substitute,
/`\n`{=tex}/ regex for new line, / / by a space, /g global match (as
many times as it can) sed will loop through step 1 to 3 until it reach
the last line, getting all lines fit in the pattern space where sed will
substitute all `\n `{=tex}characters

(Source:)\[https://stackoverflow.com/questions/1251999/how-can-i-replace-each-newline-n-with-a-space-using-sed\]

### gsub extract group string

```batchfile
:: get the country out
echo https://www.thecrag.com/de/klettern/france/  | sed -nr "s/https\:\/\/www\.thecrag\.com\/..\/.*\/(.*)\//\1/p"
```

### substr or substitute / replace

```batchfile
:: remove last character
set out=!in:~0,-1!

:: start from char 3 and to right, 4 char
set out=!in:~3,4!

:: with sed
sed "s/  //g" | sed "s/^ //" :: replace 2 space with nothing, ^ means begin of line so here remove first space, pipe is combining commands
```

### Extract content balise html

Example of a html with a balise:

``` html
<div class="syllabus__img">
<img src="https://kajabi-storefronts-production.global.ssl.fastly.net/kajabi-storefronts-production//products/489707/images/zBynUn7QbCwNOKf3FGXg_dbdb1b80765e5c9f9b1a1f921403bf1a01a32417.jpg" class="thumb">
</div>
</div>
<div class="media-body media-middle">
<p class="syllabus__title">4.6 – Pattern Matrix of Tesselated Patterns [ANMTN]</p>
<p class="syllabus__text">Overview
A pattern of tessellated forms is loosely like a grid of squares that morph into hexago...</p>
</div>
```

I wanna extract only text in balise `<p class="syllabus__title">` `</p`

```batchfile
sed -n "s:.*<p class=\"syllabus__title\">\(.*\)</p>.*:\1:p" test.html
```

If I understood:

-   `s/`means match string
-   `:` is a delimitor
-   `.*<p class=\"syllabus__title\">\(.*\)</p>.*`
-   `.*`all characters before the balise
-   `<p class=\"syllabus__title\">`start of the balise,  permit to allow
    spezial characters like `"`
-   `\(.*\)` In order to extract a group of character btw the balise
-   `</p>.*` end of the balise + all character
-   `:` is a delimitor
-   `\1` replace with group 1 (the content of the balise)
-   `:` is a delimitor
-   `p` I am not sure what it is

Source:
(https://unix.stackexchange.com/questions/98217/using-sed-to-extract-text-between-2-tags)

### Remove accents or special characters

```batchfile
type %%~na_clean1.txt | C:\Users\gravier\Downloads\Software\Linux_exe\iconv\bin\iconv.exe -f utf-8 -t ascii//TRANSLIT > %%~na_noaccent.txt

:: type permit to print
:: tr delete certain characters, could use as well sed
:: iconv permit to transform encoding to divide accents for example or delete them (certainly works better on Linux), I did not succeed to use sed for this
```

### Leading 0

```batchfile
set p2=00000%%p
set p2=%p2:~-5%
echo %p2%
```

### Check if variable contains string

```batchfile
if /I "%rev:new=%" neq "%rev%" (
echo String has new
) else (
echo it doesnt has new
)
```

## path - working directory

```batchfile
set drive=%path:~0,2%
%drive%
```

## Loop

### Line in file

```batchfile
for /F "usebackq tokens=*" %%A in ("my file.txt") do [process] %%A
```

### Line in different files

```batchfile
@echo off
setlocal EnableDelayedExpansion
Rem First file is read with FOR /F command
Rem Second file is read via standard handle 3
3< file2.txt (for /F "delims=" %%a in (file1.txt) do (
Rem Read next line from file2.txt
set /P line2=<&3
Rem Echo lines of both files
echo %%a,!line2!
))
```

Source:
https://stackoverflow.com/questions/14521799/combining-multiple-text-files-into-one/14523100#14523100

### Folder

```batchfile
FOR /D %y IN (D:\movie\*) DO @ECHO %y
```

### Files in folder

```batchfile
for %%p in (*.csv) do [process] %%p
```

#### Delete all extension

```batchfile
del /S *.ppm
```

#### Delete all files with a specific string in filename

```batchfile
ls | grep yourstring | xargs rm -f 
```

-   `ls` to list your files in the directory
-   `grep` to select only the one you want
-   `xargs` to apply a command to each output line
-   `rm` to remove the files (`-f` force remove)

#### Recursive

```batchfile
for /R %%f in (*.tif) do echo "%%f"
```

#### Basename, Dirname

```batchfile
    FOR /d /r %%G in ("*") DO Echo We found %%~nxG
```

Old method, to try again

```batchfile
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

for /R %%f in (*.mp4) do (

    echo full.filename=%%f
    
    set full.dirname1=%%~dpf
    echo full.dirname1=!full.dirname1!
    
    set full.dirname1.b=!full.dirname1:~0,-1!
    echo full.dirname1.b=!full.dirname1.b!
    
    for /F %%d in ("!full.dirname1.b!") do (
        set dirname1=%%~nd
        echo dirname1=!dirname1!
        
        set full.dirname2=%%~dpd
        echo full.dirname2=!full.dirname2!
        
        set full.dirname2.b=!full.dirname2:~0,-1!
        echo full.dirname2.b=!full.dirname2.b!
        
        for /F %%e in ("!full.dirname2.b!") do (
            set dirname2=%%~ne
            echo dirname2=!dirname2!
        )       
        
    )
    
    echo -------
    
)
```

### get first file

```batchfile
(for %%i in (*.csv) do @echo %%i) > temp
set /p firstfile=<temp

sed -n 1p "%firstfile%" > X:\Routput\3056\PrS\Evaluation_9\test.csv
del temp 
```

### Bind csv

```batchfile
@echo off

echo.
echo Batch file to create a concatenation of QC csv file in the QC folder (X:\Routput\3056\PrS\Evaluation_9\QC).
echo You will need sed.exe to do this. Install Gow (https://github.com/bmatzelle/gow)
echo.

cd X:\Routput\3056\PrS\Evaluation_9\QC

:: Get the first file to get the headers
(for %%i in (*.csv) do @echo %%i) > temp
set /p firstfile=<temp

:: print first line for the header
sed -n 1p "%firstfile%" > X:\Routput\3056\PrS\Evaluation_9\3056_QC_Summary.csv
del temp 

echo Please wait until this is closing...
:: Print line number 2 from each file
for %%p in (*.csv) do sed -n 2p "%%p">>X:\Routput\3056\PrS\Evaluation_9\3056_QC_Summary.csv
```

## Get first line of list of file filtered

```sh
ls -1 | grep Prices | xargs head -1 -q >test.csv
```


## Variables

### Assign output command to variable

use \^ to escape special characters like \| or \< \> or \= **IMPORTANT**

```batchfile
for /f "tokens=*" %%i in ('sed -nr "s/.*<time>(.*)<\/time>/\1/p" %pathfile% ^| head -2 ^| tail -1') do set dayy=%%i
::or
for /f %%i in ('sed -nr "s/.*<time>(.*)<\/time>/\1/p" %pathfile% ^| head -2 ^| tail -1') do set dayy=%%i

```

### Arithmetic

    set /a channel=4
    set /a field=3
    dir /b "*.tif" | find /c "%%~na" > temp
    set /p howmany= < temp
    set /a howmany=howmany
    set /a loopch=howmany/channel
    set /a loopfi=howmany/field

Inside a loop

    set /a channel=4
    set /a field=3
    dir /b "*.tif" | find /c "%%~na" > temp
    set /p howmany= < temp
    set /a howmany=!howmany!
    set /a loopch=howmany/channel
    set /a loopfi=howmany/field
    
    
### Carriage return \n in variable

```sh
set text=hello\nworld
set "text=%text:\n= & echo %"
(echo %text%) > file.txt
cat file.txt
```

## If

### Command exist

Check if a command exist

```batchfile
WHERE magick
IF %ERRORLEVEL% NEQ 0 (
set run=H:\TEMP\Software\Pictures\ImageMagick-7.0.8-28-portable-Q16-x86\magick.exe
) else (
set run=magick
)

start %run% convert "H:\TEMP\Dorian\Batch_Files\Magick\test.jpg" -resize 30%% "H:\TEMP\Dorian\Batch_Files\Magick\test2.jpg"
```

## Multiple commands

In windows it is impossible to pass the output from a command as a
parameter. This is mainly only possible with linux command (ls, grep,
sed, awk, tr ...). Here an example for using it with ImageMagick

```batchfile
:: Will convert all jpg from a folder in a page in a pdf
for /F "usebackq delims=" %A in (`ls ^|grep -s jpg ^| tr "\n" " "`) do convert -quality 85 %A output.pdf

```

# Markdown

## TOC - Table of cont

``` sh
pandoc -s --toc --wrap=none -t gfm Portofolio_2.md -o Portofolio.md
::--toc create a table of content
::-s need to create --toc
::--wrap=none avoid wrapping to get good toc
::-t (to) format
::-t gfm (Github Flavoured Markdown) only format working to note change the html in the markdown code
```

# User input

## file choose

```batchfile
@echo off
call :filedialog file
echo selected  file is : "%file%
pause
exit /b


:filedialog :: &file
setlocal
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
endlocal  & set %1=%file%
```

## directory choose via file

```batchfile
@echo on 
SETLOCAL ENABLEDELAYEDEXPANSION

echo Choose where your flex files are (choose 1 flex):

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd %dir%
```



# Wget or curl

Present in Gow, but you may have to update it. Download the new version
exe and copy it in the Gow folder (PATH).

## Download all extension (pdf) website

Will download all pdf without the site structure

```batchfile
wget -A pdf -m -p -E -k -K -nd --user-agent=Mozilla your-url
```

Source:
https://stackoverflow.com/questions/8755229/how-to-download-all-files-but-not-html-from-a-website-using-wget

## Download all website

```batchfile
wget --wait=2 --level=inf --limit-rate=20K --random-wait --recursive --page-requisites --user-agent=Mozilla --no-parent --convert-links --adjust-extension --no-clobber -e robots=off http://tcpermaculture.com/site/plant-index
```

Source:
https://simpleit.rocks/linux/how-to-download-a-website-with-wget-the-right-way/

# PDF

## Reduce image quality

```batchfile
P:\software\PortableApps\Ghostscript\bin\gswin64c.exe -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=ouput.pdf input.pdf
```

Check out my blog post from this

## Extract text from pdf in txt file

```batchfile
P:\software\PortableApps\Ghostscript\bin\gswin64c.exe -sDEVICE=txtwrite -o %%~na.txt %%a
```

Source :
https://stackoverflow.com/questions/3650957/how-to-extract-text-from-a-pdf

## Extract pictures from pdf

```batchfile
C:\Users\gravier\Downloads\Software\xpdf-tools-win-4.02\bin64\pdfimages.exe -j input output
```

# wifi

## windows

[source](https://lazyadmin.nl/it/netsh-wlan-commands/)

show profile saved `netsh wlan show profiles`
`netsh wlan show profile name=LinkTest`

check the password
`netsh wlan show profile name=LinkTest key=clear`
now check in :  Key Content

show all networks available [(source)](https://superuser.com/questions/991457/how-do-i-display-a-list-of-wi-fi-connections-using-netsh)
`netsh wlan show networks`

show all possibilities from your chipset
`netsh wlan show all`
`netsh wlan show wirelesscapabilities`
`netsh wlan show drivers`

# compare

```sh
exiftool out.mp4 > out.txt && exiftool in.mp4 > in.txt && diff --color in.txt out.txt
```
