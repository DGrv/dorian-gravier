@echo off
SetLocal EnableDelayedExpansion


set actualdir=%cd%
set outfolder=D:\Pictures\GoPro\IMPORT
D:
cd %outfolder%

curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=1

for /f %%p in ('curl --request GET   --url http://172.28.124.51:8080/gopro/media/list ^| jq ".media[].fs[].n"') do (
	set file=%%p
	echo [33mCheck file: !file! ------------------------------[37m
	if not exist !file! ( 
		echo [32mDownload !file![37m
		curl -O --request GET  --url http://172.28.124.51:8080/videos/DCIM/100GOPRO/!file!
	) else (
		echo [31m!file! exists, does not download[37m
	)
	echo.
	echo.

)

curl --request GET --url http://172.28.124.51:8080/gopro/camera/control/wired_usb?p=0



for %%a in ("%actualdir%") do (
	set pathh=%%~dpa
	set filename=%%~nxa
	set filenamenoext=%%~na
	set filepathnoext=%%~dpna
	set ext=%%~xa
	set drive=%%~da
)  

%drive%
cd %actualdir%


