@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo Will resize recursively all jpg and png to 800px and delete the original.
echo Where the bat is run !!!!!!!!!!!!!!!!!!!!!!!
REM set /p path=Give me your path: 

REM cd %path%

:: Bar progress -----------------------------------


set limsize=2000



FOR /R %%i IN ("*.jpg", "*.jpeg") DO (
	echo %%i
	for /f %%a in ('magick identify -format "%%w" "%%i"') do set /a width=%%a
	for /f %%a in ('magick identify -format "%%h" "%%i"') do set /a height=%%a
	REM del temp
	if !height! GTR !width! (
		if !height! GTR %limsize% (
			mogrify -resize %limsize% "%%i"
		)
	) else (
		if !width! GTR %limsize% (
			mogrify -resize %limsize% "%%i"
		)
	)
)


