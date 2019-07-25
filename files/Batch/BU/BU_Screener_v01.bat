@echo off

:: ---------- Setup ----------
echo Will BU the /home/Screener folder from one of the screener server.
echo.
echo Be sure that you have mapping network as S: for the 'screener' server and T: for the 'screenertest'
echo.
echo (If not use 'net use S: \\screener\share yourpassword /user:yourusername /persistent:yes')



set /p which=Which server folder you wanna BU (1: Screener, 2: Screenertest. 3: Both) ?   
set /p info=Give an extra info name for the zip, explaining why you do a BU (use - for space) : 


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



:: ---------- BU ----------


if %which%==1 (
	S:
	L:\Doku\IT\Software\Screener\BU\7za\7za.exe a "L:\Doku\IT\Software\Screener\BU\Screener\%datetimef%_Screener_BU_%info%.zip" -r @"L:\Doku\IT\Software\Screener\BU\List_path_BU_Screener.txt" -mx9
) 
if %which%==2 (
	T:
	L:\Doku\IT\Software\Screener\BU\7za\7za.exe a "L:\Doku\IT\Software\Screener\BU\Screenertest\%datetimef%_Screenertestc_BU_%info%.zip" -r @"L:\Doku\IT\Software\Screener\BU\List_path_BU_Screenertest.txt" -mx9
)
if %which%==3 (
	T:
	L:\Doku\IT\Software\Screener\BU\7za\7za.exe a "L:\Doku\IT\Software\Screener\BU\Screenertest\%datetimef%_Screenertestc_BU_%info%.zip" -r @"L:\Doku\IT\Software\Screener\BU\List_path_BU_Screenertest.txt" -mx9
	
	S:
	L:\Doku\IT\Software\Screener\BU\7za\7za.exe a "L:\Doku\IT\Software\Screener\BU\Screener\%datetimef%_Screener_BU_%info%.zip" -r @"L:\Doku\IT\Software\Screener\BU\List_path_BU_Screener.txt" -mx9
)








