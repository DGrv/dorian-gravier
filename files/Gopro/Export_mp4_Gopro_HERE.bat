@echo off
SetLocal EnableDelayedExpansion


set actualdir=%cd%
REM set outfolder=D:\Pictures\GoPro\IMPORT
REM D:
REM cd %outfolder%

curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1

for /f %%p in ('curl --request GET   --url http://172.28.124.51:8080/gopro/media/list ^| jq ".media[].fs[].n"') do (
	set file=%%p
	echo file: !file!
	curl -O --request GET  --url http://172.28.124.51:8080/videos/DCIM/100GOPRO/!file!

)

REM for %%a in ("%actualdir%") do (
	REM set pathh=%%~dpa
	REM set filename=%%~nxa
	REM set filenamenoext=%%~na
	REM set filepathnoext=%%~dpna
	REM set ext=%%~xa
	REM set drive=%%~da
REM )  

REM %drive%
REM cd %actualdir%


