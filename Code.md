---
layout: page
title: Code
permalink: /code/
---

<!-- TOC -->

- [Batch](#batch)
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
	- [Dose Response Curve](#dose-response-curve)
- [Youtube-dl](#youtube-dl)
	- [Easy Commands](#easy-commands)
	- [Batch](#batch-1)
- [Leaflet](#leaflet)
	- [Gpx](#gpx)
		- [Load multiple gpx](#load-multiple-gpx)
		- [Popup on click](#popup-on-click)

<!-- /TOC -->



# Batch

## Magick

### Merge in batch

```batch
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

```Batch
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


```Batch
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

## Record screen and audio

```Batch
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

```Batch
ffmpeg -f gdigrab -framerate 24 -i desktop -f dshow -i audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}" output.mp4
```

Stop with ctrl-c.

## Add variable to system variable PATH (Windows)

The first version of this batch file was pretty simple:

- ask user which path to add
- add it

The problem is that I realized that it was creating duplicates, and rapidly your system variable PATH is full.
I then created a version which would delete duplicated lines.

```batch
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
set path2=%path%%pathwanted%
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

## Dose Response Curve

# Youtube-dl

## Easy Commands

Command to dowload the audio from a video or playlist:

```batch
ffmpeg -x --audio-format "mp3" --audio-quality 0 -c --yes-playlist -i the-url-of-your-video
```

Command to download a video (best quality):

```batch
ffmpeg -f best the-url-of-your-video
```

Command to download a video (with choosen quality):
Get the list of possible format ...

```batch
ffmpeg -F the-url-of-your-video
```

Choose one and run the following line

```batch
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

```batch
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

[Example in plnkr](https://embed.plnkr.co/NO2acQlJPjnyQ3cF9qqW/)

```javascript
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
       "Elevation Gain: " + eleGain + " m </br>"

     // register popup on click
			gpx.getLayers()[0].bindPopup(info)

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
