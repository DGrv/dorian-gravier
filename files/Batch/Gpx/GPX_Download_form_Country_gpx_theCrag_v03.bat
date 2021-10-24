@echo off
SetLocal EnableDelayedExpansion


echo "--------------------------------------------------------------------------------"
echo "   _____             _                _____                 _                   "
echo "  |  __ \           (_)              / ____|               (_)                  "
echo "  | |  | | ___  _ __ _  __ _ _ __   | |  __ _ __ __ ___   ___  ___ _ __         "
echo "  | |  | |/ _ \| '__| |/ _` | '_ \  | | |_ | '__/ _` \ \ / / |/ _ \ '__|        "
echo "  | |__| | (_) | |  | | (_| | | | | | |__| | | | (_| |\ V /| |  __/ |           "
echo "  |_____/ \___/|_|  |_|\__,_|_| |_|  \_____|_|  \__,_| \_/ |_|\___|_|           "
echo "                                                                                "
echo "--------------------------------------------------------------------------------"
REM http://www.network-science.de/ascii/
echo.

echo.
echo Will download all gpx from the website theCrag by giving a txt file that you got from the website with the developper tool.
echo first open developer tools with F12, go in sources, at the bottom search "get('/api/node/id/'+nid+'/children/area", should be in common-1......js 
echo modify the last part of the line where you have expire=10, increase this number 100 e.g.
echo Then go back to the page, do not load a new page and with your mouse just go through the all dropdown menu to allow the source code to create
echo Search the dropdown menu for your country and copy the all dropdown to a txt file that you give to this script :)
echo.

REM set input=C:\Users\doria\Downloads\Topo\GPX\FR\FR.txt
set /p input=Where your txt is:   
for /F %%i in ("%input%") do (
	set drive=%%~di
	set filepath=%%~dpi
)

echo [DEBUG] -------
echo input=%input%
echo drive=%drive%
echo filepath=%filepath%

%drive%
cd "%filepath%"


:: get all links from the balise
copy %input% %input%BU
sed -i "s/<a href=\"/\r\n/g" %input%
sed -i "s/\" data\-nid\=.*$//g" %input%
sed -i "s/^/https\:\/\/www.thecrag.com/" %input%
:: delete 2 first lines
sed -i "1,2d" %input%
ls | grep "^sed.*" | xargs rm




cat %input% | sed "s/$/\/gpx/" | sed "s/^/wget --user-agent=Mozilla --content-disposition /" > temp.bat
uniq temp.bat > temp_uniq.bat
rm temp.bat
echo exit >> temp_uniq.bat
start /wait temp_uniq.bat


:: delete file bites = 0
for /F %%A in (*.gpx) do If %%~zA equ 0 del

:: remove single quotes
for %%f in (*'*) do (
	set new=%%f
    rename "%%f" "!new:'=!"
)


REM set /p rmdesc=Do you wanna remove all comments or description from gpx (save space) [y/n]   
REM if %rmdesc%==y (
	for %%f in (*.gpx) do (
		echo %%f
		sed -i "/\<desc\>\|\<\/desc\>/d" "%%f"
		sed -i "/\<cmt\>\|\<\/cmt\>/d" "%%f"
		sed -i "/<wpt lat=\"\" lon=\"\">/{n;n;d}" "%%f"
		sed -i "/<wpt lat=\"\" lon=\"\">/{n;d}" "%%f"
		sed -i "/<wpt lat=\"\" lon=\"\">/{d}" "%%f"
		REM need here a ^escape for the special character ! in batch only
		sed "1^!G;h;$^!d" "%%f" > temp
		sed -i "/<name>Region:.*<\/name>/{n;d}" temp
		sed "1^!G;h;$^!d" temp > "%%f"
		sed -i "/<name>Region:.*<\/name>/{n;d}" "%%f"
		sed -i "/<name>Region:.*<\/name>/{d}" "%%f"
		rm temp
		ls | grep "^sed.*" | xargs rm
	)
REM )

:: maybe need to be tested here
REM set /p merge=Do you wanna merge all gpx [y/n]:   

REM if %merge%==y (
	ls | grep gpx.1 | xargs rm
	ls | grep gpx.2 | xargs rm
	ls | grep gpx.3 | xargs rm
	ls | grep gpx.4 | xargs rm
	ls | grep gpx.5 | xargs rm
	ls | grep gpx.6 | xargs rm
	ls | grep gpx.7 | xargs rm
	ls | grep gpx.8 | xargs rm
	ls | grep gpx.9 | xargs rm
	for %%f in (*.gpx) do (
		copy "%%f" "Merge.gpx"
		goto :continue
	)
	:continue
	for %%f in (*.gpx) do "C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f Merge.gpx -f "%%f" -o gpx -F Merge.gpx
	
REM )
"C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f Merge.gpx -x duplicate,location,shortname -o gpx -F Merge_uniq.gpx


:: delete useless balise
sed -i "/\<desc\>\|\<\/desc\>/d" Merge_uniq.gpx
sed -i "/\<cmt\>\|\<\/cmt\>/d" Merge_uniq.gpx

:: remove empty points
sed -i "/<wpt lat=.. lon=..>/{n;n;d}" Merge_uniq.gpx
sed -i "/<wpt lat=.. lon=..>/{n;d}" Merge_uniq.gpx
sed -i "/<wpt lat=.. lon=..>/{d}" Merge_uniq.gpx
sed -i "/<wpt lat=\"0\.000000000\" lon=\"0\.000000000\">/{n;n;d}" Merge_uniq.gpx
sed -i "/<wpt lat=\"0\.000000000\" lon=\"0\.000000000\">/{n;d}" Merge_uniq.gpx
sed -i "/<wpt lat=\"0\.000000000\" lon=\"0\.000000000\">/{d}" Merge_uniq.gpx
sed -i "/<link href=\"https\:\/\/www\.thecrag\.com\">/{n;n;d}" Merge_uniq.gpx
sed -i "/<link href=\"https\:\/\/www\.thecrag\.com\">/{n;d}" Merge_uniq.gpx
sed -i "/<link href=\"https\:\/\/www\.thecrag\.com\">/{d}" Merge_uniq.gpx
ls | grep "^sed.*" | xargs rm
