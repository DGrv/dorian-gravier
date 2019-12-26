@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo --------------------------------------------
echo            FFmpeg Script
echo        Created by Dorian Gravier 
echo.
echo         PLEASE READ INSTRUCTIONS     
echo --------------------------------------------


echo.

echo This script will convert all format (video) that you choose RECURSIVELY in a certain folder of your choice.
echo It will also rename it depending on its 2 levels folder name.

set /p from.ext=From which extension you wanna convert ?  
set /p to.ext=To which extension ?  
set /p path=In which folder (copy path) ?  


echo.

set /p choice=Are you sure that you wanna convert all %from.ext% to %to.ext% in the folder %path% [ y / n ] ?  

cd %path%


if %choice%==y (
	for /R %%f in (*%from.ext%) do (
		
		echo WORK on %%f
		echo.
		rem echo full.filename=%%f
		
		set full.dirname1=%%~dpf
		rem echo full.dirname1=!full.dirname1!
		
		set full.dirname1.b=!full.dirname1:~0,-1!
		rem echo full.dirname1.b=!full.dirname1.b!
		
		for /F %%d in ("!full.dirname1.b!") do (
			set dirname1=%%~nd
			rem echo dirname1=!dirname1!
			
			set full.dirname2=%%~dpd
			rem echo full.dirname2=!full.dirname2!
			
			set full.dirname2.b=!full.dirname2:~0,-1!
			rem echo full.dirname2.b=!full.dirname2.b!
			
			for /F %%e in ("!full.dirname2.b!") do (
				set dirname2=%%~ne
				rem echo dirname2=!dirname2!
			)		
			
		)
		
		cd !full.dirname1!
		ffmpeg -stats -loglevel error -i "%%f" -vcodec libx264 -vbr 3 -vf "scale=720:-2" -preset fast -crf 23 -acodec mp3 "%%~nf.%to.ext%"
		
		
		FOR /L %%c IN (1,1,20) DO (
			if NOT EXIST "!dirname2!_!dirname1!_%%c.%to.ext%" rename "%%~nf.%to.ext%" "!dirname2!_!dirname1!_%%c.%to.ext%"
		)

		
		
		echo.
		echo -------
		
		
	)
)
