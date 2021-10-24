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
echo Will download all gpx from the website theCrag by giving a txt file with link of all Site you want
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




REM sed -i "s/<a href=\"/\r\n/g" %input%
REM sed -i "s/\" data\-nid\=.*$//g" %input%
REM sed -i "s/^/https\:\/\/www.thecrag.com/" %input%



cat %input% | sed "s/$/\/gpx/" | sed "s/^/wget --user-agent=Mozilla --content-disposition /" > temp.bat
uniq temp.bat > temp_uniq.bat
rm temp.bat
echo exit >> temp_uniq.bat
start /wait temp_uniq.bat

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
		sed -i "/<wpt lat=.. lon=..>/{n;n;d}" "%%f"
		sed -i "/<wpt lat=.. lon=..>/{n;d}" "%%f"
		sed -i "/<wpt lat=.. lon=..>/{d}" "%%f"
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
