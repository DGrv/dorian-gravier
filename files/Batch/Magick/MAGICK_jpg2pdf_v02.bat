@echo off
SETLOCAL ENABLEDELAYEDEXPANSION


WHERE magick
IF %ERRORLEVEL% NEQ 0 (
	set run=P:\Software\ImageMagick-7.0.9-10-portable-Q16-x64\magick.exe
) else (
	set run=magick
)
WHERE pdftk
IF %ERRORLEVEL% NEQ 0 (
	set runpdftk=P:\Software\PortableApps\PDFTKBuilderPortable\App\pdftkbuilder\pdftk.exe
) else (
	set runpdftk=pdftk
)



echo.
echo Batch script to convert jpg in pdf and merge them (created by Dorian Gravier)
echo.
echo.

echo Where are you files ?
echo.


set listfiles=powershell -NoP -C "[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms')|Out-Null;$OFD = New-Object System.Windows.Forms.OpenFileDialog;$OFD.Multiselect = $True;$OFD.InitialDirectory = '%mypath%';$OFD.ShowDialog()|out-null;$OFD.FileNames"

rem exec commands powershell and get result in FileName variable
for /f "delims=" %%i in ('%listfiles%') do (
	set dir=%%~dpi
	set drive=%%~di
	!drive!
	cd !dir!
	echo %%i>>list.txt
)

%drive%
cd %dir%
mkdir temppdf
set newdir=%dir%temppdf\
echo newdir: %newdir%
set file=%dir%list.txt


REM set filenamenoext=%%~np

for /F "usebackq tokens=*" %%p in (%file%) do (
	set ext=%%~xp
	echo call %run% convert "%%p" "%newdir%%%~np.pdf"
	call %run% convert "%%p" "%newdir%%%~np.pdf"
)


call %runpdftk% "%newdir%*.pdf" cat output newfile.pdf

:: Wait 5 second otherwise it is deleting the file before it is finished
ping 127.0.0.1 -n 5 > nul

del list.txt
rmdir temppdf /s /q

echo.
echo All DONE :)
echo.

