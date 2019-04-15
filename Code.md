---
layout: page
title: Code
order: 3
---

<!-- TOC -->

- [Batch](#batch)
	- [Change color console](#change-color-console)
	- [Get system info](#get-system-info)
		- [OS bits](#os-bits)
		- [OS version](#os-version)
		- [Format date or time](#format-date-or-time)
		- [Get timestamp](#get-timestamp)
	- [Magick](#magick)
		- [Merge in batch](#merge-in-batch)
		- [Convert in batch](#convert-in-batch)
			- [level brightness](#level-brightness)
			- [flex files to tiff](#flex-files-to-tiff)
	- [FFmpeg](#ffmpeg)
		- [Record screen and audio](#record-screen-and-audio)
	- [Add variable to system variable PATH (Windows)](#add-variable-to-system-variable-path-windows)
- [R](#r)
	- [data.table tricks](#datatable-tricks)
		- [Add last row as colnames for html](#add-last-row-as-colnames-for-html)
		- [Create group ID or row ID](#create-group-id-or-row-id)
		- [Max of a variable per group of variable](#max-of-a-variable-per-group-of-variable)
		- [Calculation per group, by](#calculation-per-group-by)
		- [Best 3 of a variable per group of variable (same variante as before but for DRC, meaning take the 3 best plates per CP)](#best-3-of-a-variable-per-group-of-variable-same-variante-as-before-but-for-drc-meaning-take-the-3-best-plates-per-cp)
		- [Modify multiples columns at the same time](#modify-multiples-columns-at-the-same-time)
		- [Order columns](#order-columns)
		- [Summarize table depending on BY and .SDcols](#summarize-table-depending-on-by-and-sdcols)
		- [Replace all values conditionnaly](#replace-all-values-conditionnaly)
		- [sum of all previous row by a variable](#sum-of-all-previous-row-by-a-variable)
		- [Access data.table with string](#access-datatable-with-string)
		- [find duplicated value in data.table](#find-duplicated-value-in-datatable)
	- [Dose Response Curve](#dose-response-curve)
- [Youtube-dl](#youtube-dl)
	- [Easy Commands](#easy-commands)
	- [Batch](#batch-1)
- [Leaflet](#leaflet)
	- [Gpx](#gpx)
		- [Load multiple gpx](#load-multiple-gpx)
		- [Popup on click](#popup-on-click)
		- [Popup on mouseover](#popup-on-mouseover)
		- [Highlight or change color on mouseover](#highlight-or-change-color-on-mouseover)
- [Other](#other)
	- [Add context menu (right clik) for files](#add-context-menu-right-clik-for-files)
- [HTML](#html)
	- [Image adjustement via css filter and slider](#image-adjustement-via-css-filter-and-slider)

<!-- /TOC -->


# Batch

## Change color console

I created a batch file to change the color of the windows cmd windows. It is using [Ansicon](https://github.com/adoxa/ansicon).
The goal is to make the console a bit more clear: You can see you self the difference :

![Picture](files/picture/cmd_no_ansicon.jpg)
![Picture](files/picture/cmd_with_ansicon.jpg)

The batch file is checking which OS you have:

- 32 or 64bits, to know which .exe to install
- XP or above, to adapt the way to write the 'promptx' variable

The only things that you have to do is adapt where you exe is and if needed change the color and the output in the prompt : "$e[1;31m$p$s$e[1;34m$g$s$e[1;37m"


```shell
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

## Get system info

### OS bits

```shell
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT (
	echo 32bits
) else (
	echo 64bits
)
```
### OS version

```shell
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" | find /i "XP" > NUL && set ver=XP || set ver=other
echo %ver%
```

### Format date or time

If the input locale is englisch the month and day are reversed.
Here a solution to get it right.

```shell
systeminfo | findstr /B /C:"Input Locale:" | find /i "de;" > NUL && set lan=de || set lan=en
if %lan%==de (
	set month=%date:~-7,2%
	set day=%date:~-10,2%
) else (
	set day=%date:~-7,2%
	set month=%date:~-10,2%
)
```

### Get timestamp

```shell
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

## Magick

### Merge in batch

```shell
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set /p which="Do you want to merge jpg (type 1) or png (type 2) ? : "

if %which%==1 set format="jpg"
if %which%==2 set format="png"

echo Choose where your jpg are (choose 1 file):

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd "%dir%"

:: give info on what will be done
dir /a-d /b "*%format%" | find /c %format% > temp
set /p nfiles= < temp
::set /a nfiles=nfiles
del temp

magick montage *.%format% -tile 1x%nfiles% -geometry +0+0 Merge.%format%
magick convert Merge.%format% Merge.pdf

echo DEBUG --------------------------
echo drive %drive%
echo dir %dir%
echo which %which%
echo format %format%
echo magick montage *.%format% -tile 1x%nfiles% -geometry +0+0 Merge.%format%
echo magick convert Merge.%format% Merge.pdf
```

### Convert in batch

#### level brightness

```shell
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Choose where your jpg files are (choose 1 jpg):

:: file choose and get dir
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "input=%%p"
for /F %%i in ("%input%") do @set dir=%%~dpi
for /F %%i in ("%input%") do @set drive=%%~di

%drive%
cd %dir%


:: User input number of channel

set /p channel="At which level do you wanna set the white point ? (20 mean 20 percent of the actual, just test and MAKE A COPY OF YOUR FILE) : "
set /a channel=channel

:: give info on what will be done
dir /a-d /b "*jpg" | find /c "jpg" > temp
set /p nfiles= < temp
set /a nfiles=nfiles
set /a xfile=1
del temp

set /p tt=%nfiles% jpg will be processed, type Enter to continue.


:: convert in tiff and rename it
FOR /F "delims=" %%a IN ('dir /a-d /b "*jpg"') DO (
	H:\TEMP\Software\ImageMagick-7.0.8-Q16\magick.exe convert %%a -level "0%%,%channel%%%,1" %%a
	echo 1 more done ...
)

```

#### flex files to tiff


```shell
@echo off
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
mkdir TIFF

:: User input number of channel

set /p channel="How many Channel you have ? "
set /a channel=channel

:: give info on what will be done
dir /a-d /b "*flex" | find /c "flex" > temp
set /p nfiles= < temp
set /a nfiles=nfiles
set /a xfile=1
del temp

set /p tt=%nfiles% flex will be processed, type Enter to continue.


:: convert in tiff and rename it
FOR /F "delims=" %%a IN ('dir /a-d /b "*flex"') DO (
	H:\TEMP\Software\ImageMagick-7.0.8-Q16\magick.exe convert %%a -set filename:f "%%t_%%s" +adjoin "TIFF\%%[filename:f].tif"
	dir /b "*.tif" | find /c "%%~na" > temp
	set /p howmany= < temp
	set /a howmany=!howmany!
	del temp
	set /a loopfi=howmany/channel
	:: order dir by date /od
	cd TIFF
	FOR /F "delims=" %%b IN ('dir /a-d /b /od "%%~na*tif"') DO (
		FOR /l %%c IN (1, 1, !loopfi!) DO (
			FOR /l %%d IN (1, 1, %channel%) DO (
				ren %%b TIFF\%%~na_ch%%d_fi%%c.tif

			)
		)
	)
	cd ..
	echo !xfile! flex / !nfiles!
)


```


## FFmpeg

### Record screen and audio

```shell
ffmpeg -list_devices true -f dshow -i dummy
```

You will get information on your micro e.g.:

```console
[dshow @ 0000023325be21c0] DirectShow video devices (some may be both video and audio devices)
[dshow @ 0000023325be21c0]  "Integrated Camera"
[dshow @ 0000023325be21c0]     Alternative name "@device_pnp_\\?\usb#vid_0bda&pid_5719&mi_00#6&2f2aea22&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"
[dshow @ 0000023325be21c0] DirectShow audio devices
[dshow @ 0000023325be21c0]  "Internal Microphone (Conexant 20751 SmartAudio HD)"
[dshow @ 0000023325be21c0]     Alternative name "@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}"
```
Copy the **@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}**

```shell
ffmpeg -f gdigrab -framerate 24 -i desktop -f dshow -i audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}" output.mp4
```

Stop with ctrl-c.

Batch file to automate it : *v02*

```shell
@echo off






:: ---------- User input ----------

set /p xp=Are you on XP ? (0: NO, 1: Yes) :
set /p audio=Do you want to record audio ? (0: NO, 1: Yes) :




:: ---------- Find Time ----------
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
::set secs=%time:~6,2%
::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set year=%date:~-4%
set month=%date:~-7,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~-10,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%


set datetimef=%year%%month%%day%%hour%%min%

:: ---------- Start ----------
echo Batch script to record screen and audio

if %audio%==1  (
	ffmpeg -list_devices true -f dshow -i dummy
	echo.
	echo.
	echo Copy the alternative name of your microphone:
	echo Example : @device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{4286150F-8585-41D6-BA56-49CFB8009DDA}
	echo.
	set /p micro="Paste it here : "
	echo.
)


set /p framer="Which frame rate per second do you want ? "


echo.
echo.
echo Type CTRL-C to stop the recording.
echo The recording will be stop and you will be asked if you want to terminate the batch job Y/N, choose N.
echo The video will be created in the same folder as the batch file and a reduze resolution will be created.
echo.
set /p info=Type Enter to continue



if %audio%==1  (
	if %xp%==1 (
		ffmpeg -f gdigrab -framerate %framer% -i desktop -f dshow -i audio="%micro%" %datetimef%_ScreenCapture.mkv
		ffmpeg -i %datetimef%_ScreenCapture.mkv -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mkv
	) ELSE (
		ffmpeg -f gdigrab -framerate %framer% -i desktop -f dshow -i audio="%micro%" %datetimef%_ScreenCapture.mp4
		ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mp4
	)
) else (
	if %xp%==1 (
		ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mkv
		ffmpeg -i %datetimef%_ScreenCapture.mkv -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mkv
	) ELSE (
		ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mp4
		ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset slow -crf 18 %datetimef%_ScreenCapture_low.mp4
	)
)

```

### Record screen and convert into gif

Here a small example of how to record your screen, resize the video and create from it a gif.

```shell
	ffmpeg -f gdigrab -framerate 24 -i desktop screen.mp4
	ffmpeg -i screen.mp4 -vcodec libx264 -vbr 3 -vf "scale=640:-2" -preset fast -crf 23 screen640.mp4
	ffmpeg -y -i screen640.mp4 -vf palettegen palette.png
	ffmpeg -y -i screen640.mp4 -i palette.png -filter_complex paletteuse -r 20 screen640.gif
```

Via a batch file (you will have to modify it depending on your needs): *v02*

```shell
	@echo off

	:: ---------- Find Time ----------
	set hour=%time:~0,2%
	if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
	set min=%time:~3,2%
	if "%min:~0,1%" == " " set min=0%min:~1,1%
	::set secs=%time:~6,2%
	::if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

	set year=%date:~-4%
	set month=%date:~-7,2%
	if "%month:~0,1%" == " " set month=0%month:~1,1%
	set day=%date:~-10,2%
	if "%day:~0,1%" == " " set day=0%day:~1,1%

	set datetimef=%year%%month%%day%%hour%%min%

	:: ---------- Start ----------
	echo Batch script to record screen and create a gif

	set framer=24

	ffmpeg -f gdigrab -framerate %framer% -i desktop %datetimef%_ScreenCapture.mp4
	ffmpeg -i %datetimef%_ScreenCapture.mp4 -vcodec libx264 -vbr 3 -vf "scale=640:-2" -preset fast -crf 23 %datetimef%_ScreenCapture640.mp4
	ffmpeg -y -i %datetimef%_ScreenCapture640.mp4 -vf palettegen palette.png
	ffmpeg -y -i %datetimef%_ScreenCapture640.mp4 -i palette.png -filter_complex paletteuse -r 20 %datetimef%_ScreenCapture640.gif
	del palette.png
	del %datetimef%_ScreenCapture.mp4


```


## Add variable to system variable PATH (Windows)

The first version of this batch file was pretty simple:

- ask user which path to add
- add it

The problem is that I realized that it was creating duplicates, and rapidly your system variable PATH is full.
I then created a version which would delete duplicated lines.

```shell
:: Code ----------------------------------------------------------------------------
@echo off
setlocal enableDelayedExpansion


set /p pathwanted="Path you wanna add to the PATH variable: "

echo Do you really want this path added : %pathwanted% ?
echo.
echo To this actual path :
echo. %path%
pause


:: get path and write file with replace ; as LF
set path2=%path%;%pathwanted%
echo %path% > BUpath.txt
for %%a in ("%path2:;=" "%") do echo %%~a >> temp2.txt


:: sort files
setlocal disableDelayedExpansion
set "file=temp2.txt"
set "sorted=%file%.sorted"
set "deduped=%file%.deduped"
::Define a variable containing a linefeed character
set LF=^


::The 2 blank lines above are critical, do not remove
sort "%file%" > "%sorted%"
>"%deduped%" (
  set "prev="
  for /f usebackq^ eol^=^%LF%%LF%^ delims^= %%A in ("%sorted%") do (
    set "ln=%%A"
    setlocal enableDelayedExpansion
    if /i "!ln!" neq "!prev!" (
      endlocal
      (echo %%A)
      set "prev=%%A"
    ) else endlocal
  )
)
>nul move /y "%deduped%" "%file%"
del "%sorted%"
:: end sort file


(set all=)
FOR /f "delims=" %%x IN (temp2.txt) DO call SET all=%%all%%;%%x
set all=%all: ;=;%
set all=%all:~1,20000%

:: remove the '%all%; in the string
echo %all% > NEWpath.txt
echo %all%

setx path=%all%
del temp2.txt

```

# R

## data.table tricks

### Add last row as colnames for html

```r
listimg3 <- rbindlist(list(listimg3, as.list(colnames(listimg3)))) # put again name of columns at the end
```

### Create group ID or row ID
```r
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



### Max of a variable per group of variable

```r
dataCP <- data[data[, .I[Zprimefactor == max(Zprimefactor, na.rm = T)], .(CP, Q)]$V1] # take best QC for a CP-Q
```

### Calculation per group, by

```r
rawWP[, MeasTime := .SD[1, MeasTime], Sample]
rawWP[, MeasTime := max(.SD$MeasTime), Sample]
```

### Best 3 of a variable per group of variable (same variante as before but for DRC, meaning take the 3 best plates per CP)

```r
step1 <-  dataCP[, .N, .(CP, IP, Zprimefactor, Assay)] # summarize table to have 1 Zprimefactor per plate (due to use function sort)
step2 <- step1[, .I[Zprimefactor %in% sort(Zprimefactor, decreasing = T)[1:3]], .(CP, Assay)] # get the 3 best Zprimefactor per Assay and CP
step3 <- step1[step2$V1][, ':=' (Zprimefactor = NULL, N = NULL, Assay = NULL)] # get then the plate to keep
dataCP <- dtjoin(dataCP, step3, "inner") # join again both here used as a subset.
```

### Modify multiples columns at the same time

with user function:
```r
grepcol <- function(pattern, data) {
return( names(data)[grep(pattern, names(data))] )
}

html1[ , (grepcol("DRC", html)) := lapply(.SD, function(x) gsub("~/HTS/", "H:/", x)), .SDcols = grepcol("DRC", html)]
html1 <- html1[ , (grepcol("DRC", html)) := lapply(.SD, function(x) addimgbalise(x, 100)), .SDcols = grepcol("DRC", html)]
htmlb64[ , (grepcol("DRC", html)) := lapply(.SD, function(x) mapply(image_uri, x, SIMPLIFY = T)), .SDcols = grepcol("DRC", html)]
```

### Order columns

```r
setcolorder(html, c("sample", temp$colname))
```

### Summarize table depending on BY and .SDcols

```r
temp <- rawWP[Sample %in% listsample[combin[,i]]]
temp2 <- rbind(temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What ="mean", lapply(.SD, mean)), .(row, col), .SDcols = coltokeep],
temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What = "sd", lapply(.SD, sd)), .(row, col), .SDcols = coltokeep],
temp[, c(Sample = paste(listsample[combin[,i]], collapse ="."), What = "median", lapply(.SD, median)), .(row, col), .SDcols = coltokeep])
```

[Source 1](https://stackoverflow.com/questions/20459519/apply-function-on-a-subset-of-columns-sdcols-whilst-applying-a-different-func) and [source 2](https://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table?lq=1)

### Replace all values conditionnaly

```r
for(col in names(dataBC2)) {
	set(dataBC2, i=which(dataBC2[[col]] %in% dataNoPrint$AP), j=col, value="NoPrint")
}
```

[Source](https://stackoverflow.com/questions/38226323/replace-all-values-in-a-data-table-given-a-condition?rq=1)

### sum of all previous row by a variable

```r
setkey(dataPall, ID, Time) # important for ordering
# calculate theory volume
dataPall[, VolDispTT := cumsum(shift(VolumeTrans / 1000, fill=0)), by=ID] # order with setkey. sum of all previous rows per group, shift permit to shift the column of 1 row down.
```

### Access data.table with string

For i `DT[get("x") == "b"]`

For j	`DT[, get("x")]`

With by `DT[, .N, "x"]` or `DT[, .N, c("x", "y")`


### find duplicated value in data.table


```r
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

## Dose Response Curve

# Youtube-dl

## Easy Commands

Command to dowload the audio from a video or playlist:

```shell
ffmpeg -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i the-url-of-your-video
```

Command to download a video (best quality):

```shell
ffmpeg -f best the-url-of-your-video
```

Command to download a video (with choosen quality):
Get the list of possible format ...

```shell
ffmpeg -F the-url-of-your-video
```

Choose one and run the following line

```shell
ffmpeg -f format-choosen the-url-of-your-video
```

## Batch

This little batch file will ask you the url of a video and give you the choise to download only the audio or the video (with choosing the format if you need).

You will have to change the 2 variables:

- pathexe
- wd

_E.g.:_

- set pathexe=C:\\Users\\DGrv\\Downloads\\Software\\Youtube-dl\\youtube-dl.exe
- set wd=C:\\Users\\DGrv\\Downloads\\Youtube_music

_Use brackets "" if you have space in your path._

For noobies.

- Download [Youtube-dl](https://rg3.github.io/youtube-dl/download.html), if you have windows, download the Windows.exe. Move it to a safe folder where you know where it is. Note path of the file.
- Copy the following lines of codes in a txt file (with notepad for example), change the 2 variables explained above and save it as a .bat file.
- Run the bat file and enjoy.

```shell
@echo off
echo Will download the audio of a youtube video in C:Users\DGrv\Downloads\Software\Youtube-dl
set pathexe=C:\path-of-your\youtube-dl.exe
set wd=path-of-your-output-folder

cd %wd%

set /p url="Enter the url: "
set /p choice="Do you want to download the audio or the video ? (Audio=1, Video=2)   "

if "%choice%"=="1" (
	%pathexe% -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i %url%
)
if "%choice%"=="2" (
	set /p choice2="Choose your format (1) and choose best (2): "
	if "%choice2%"=="2" (
		%pathexe% -f best %url%
	)
	if "%choice2%"=="1" (
		set choice=3
		%pathexe% -F %url%
		set /p format="Which one do you want: "
	)
)
if "%choice%"=="3" (
	%pathexe% -f %format% %url%
)
```


# Leaflet

Complexer example in [my leaflet page](../leaflet.md)

## Gpx

[Leaflet-gpx Github](https://github.com/mpetazzoni/leaflet-gpx)

### Load multiple gpx

```javascript
var Schitour = ['gpx/Schitour/2016_biet_weglosen.gpx',
'gpx/Schitour/2016_ober_kamorschitour.gpx',
'gpx/Schitour/2017_Innerlatenrns.gpx',
'gpx/Schitour/201711_LindauHutte.gpx',
'gpx/Schitour/2018_Fullfirst.gpx']

for (var i = 0; i < Schitour.length; i += 1) {
  var g = new L.GPX(Schitour[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue'}});
  g.addTo(map);
};
```


### Popup on click

[Example in plnkr](https://embed.plnkr.co/NO2acQlJPjnyQ3cF9qqW)

```js
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });

	 g.on('loaded', function(e) {
     var gpx = e.target,
       name = gpx.get_name(),
       distM = gpx.get_distance(),
       distKm = distM / 1000,
       distKmRnd = distKm.toFixed(1),
       eleGain = gpx.get_elevation_gain().toFixed(0),
       eleLoss = gpx.get_elevation_loss().toFixed(0);

     var info = "Name: " + name + "</br>" +
       "Distance: " + distKmRnd + " km </br>" +
       "Elevation Gain: " + eleGain + " m </br>";

     // register popup on click
			gpx.getLayers()[0].bindPopup(info);
		});

   g.addTo(map);

```




### Popup on mouseover

[Example in plnkr](https://embed.plnkr.co/eJXZYyFXDjfjvyozyD8I/)

```javascript
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });


   g.on('mouseover', function(e) {
     var gpx = e.target,
       name = gpx.get_name(),
       distM = gpx.get_distance(),
       distKm = distM / 1000,
       distKmRnd = distKm.toFixed(1),
       eleGain = gpx.get_elevation_gain().toFixed(0),
       eleLoss = gpx.get_elevation_loss().toFixed(0);
     var info = "Name: " + name + "</br>" +
       "Distance: " + distKmRnd + " km </br>" +
       "Elevation Gain: " + eleGain + " m </br>"
     var popLocation = e.latlng;
     var popup = L.popup()
       .setLatLng(popLocation)
       .setContent(info)
       .openOn(map);
   });

   g.on('mouseout', function(e) {
     map.closePopup();
   });

   g.addTo(map);
```

### Highlight or change color on mouseover

[Example in plnkr](https://embed.plnkr.co/plunk/BWsn5CFrsgarwcFa)

```javascript
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });

   g.on('mouseover', function(e) {
		 e.target.setStyle({opacity: 0.7, weight: 10});
		 // if you want only to keep same color and change weight and so on ...
		 //e.target.setStyle({color: 'yellow'});
   });

   g.on('mouseout', function(e) {
		 e.target.setStyle({color: 'blue'});
		 // if you want only to keep same color and change weight and so on ...
		 //e.target.setStyle({opacity: 1, weight: 3});
   });

   g.addTo(map);
```

# Other

## Add context menu (right clik) for files

The only good solution I found a really working is : https://superuser.com/questions/1097054/shell-context-menu-registry-extension-doesnt-work-when-default-program-is-other

Add keys in HKEY_CLASSES_ROOT\SystemFileAssociations\\**your.extension**\\shell\command
Modify the last key with the command you wanna do.

For my purpose it was :

`"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -r -i gpx -f "%1" -x simplify,count=1000 -o gpx -F "%1.gpx"`


If I export the it I get a .reg :

```
[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=1000 -o gpx -F \"%1.gpx\""
```

I created for example a small reg file to be able to convert rapidly my gpx. I guess a dropdown menu is possible but I was satisfied with this:


```
[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 500pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=500 -o gpx -F \"%1_500.gpx\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 250pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=250 -o gpx -F \"%1_250.gpx\""

[HKEY_CLASSES_ROOT\SystemFileAssociations\.gpx\shell\Simplify gpx 100pts\command]
@="\"C:\\Program Files (x86)\\GPSBabel\\gpsbabel.exe\" -r -i gpx -f \"%1\" -x simplify,count=100 -o gpx -F \"%1_100.gpx\""
```

[Posted on Stackoverflow](https://stackoverflow.com/a/54953717/2444948)

# HTML

## Image adjustement via css filter and slider

I discovered that the user can have the possibility to modify image (brightness, contrast and so on - [more info here](https://www.w3schools.com/cssref/css3_pr_filter.asp)).

I finally wrote with help of google and all those nice programmers posting () a little script giving the possibility to modify the brigntess of all 'img' balise in a html page.

```js
<div class="slidecontainer">
	<input type="range" min="-500" max="1000" value="10" class="slider" id="myRange">
<p><font color="white">Brightness (%): <span id="demo"></span></font></p>
</div>

<button onclick="reset()">Reset</button><br><br>

<script>
	function reset() {
		var input = document.getElementsByTagName("img");
		var inputList = Array.prototype.slice.call(input);
		for(i = 0;i < inputList.length; i++) {
			inputList[i].style = "filter: brightness(100%)";
		};
	};

	var slider = document.getElementById("myRange");
	var output = document.getElementById("demo");
	output.innerHTML = slider.value;
	slider.oninput = function() {
		output.innerHTML = this.value;
		var input = document.getElementsByTagName("img");
		var inputList = Array.prototype.slice.call(input);
		for(i = 0;i < inputList.length; i++) {
			inputList[i].style = "filter: brightness(" + this.value + "%)";
		};
	};

</script>
```

Here a little example:


<div class="example">
	<div class="slidecontainer">
		<input type="range" min="-500" max="1000" value="10" class="slider" id="myRange">
	<p><font color="white">Brightness (%): <span id="demo"></span></font></p>
</div>

	<button onclick="reset()">Reset</button><br><br>

	<script>
		function reset() {
			var input = document.getElementsByTagName("img");
			var inputList = Array.prototype.slice.call(input);
			for(i = 0;i < inputList.length; i++) {
				inputList[i].style = "border-radius: 0px; box-shadow: none; filter: brightness(100%)";
			};
		};

		var slider = document.getElementById("myRange");
		var output = document.getElementById("demo");
		output.innerHTML = slider.value;
		slider.oninput = function() {
			output.innerHTML = this.value;
			var input = document.getElementsByTagName("img");
			var inputList = Array.prototype.slice.call(input);
			for(i = 0;i < inputList.length; i++) {
				inputList[i].style = "border-radius: 0px; box-shadow: none; filter: brightness(" + this.value + "%)";
			};
		};

	</script>


<tr><td id="tableHTML_column_3"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001001000Channel1_0.jpg'  />	</td>
		<td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001002000Channel1_0.jpg'  />	</td>
		<td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001003000Channel1_0.jpg'  />	</td></tr>
<tr><td id="tableHTML_column_3"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001001000Channel1_1.jpg'  />	</td>
		<td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001002000Channel1_1.jpg'  />	</td>
		<td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001003000Channel1_1.jpg'  />	</td></tr>
<tr><td id="tableHTML_column_3"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001001000Channel1_2.jpg' />	</td>
		<td id="tableHTML_column_4"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001002000Channel1_2.jpg' />	</td>
		<td id="tableHTML_column_5"><img style="border-radius: 0px; box-shadow: none" src='/files/picture/microscope/001003000Channel1_2.jpg' />	</td></tr>
</div>
