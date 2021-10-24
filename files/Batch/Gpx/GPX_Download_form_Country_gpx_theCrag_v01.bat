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
echo Will download all gpx from the website theCrag for a specified Country by giving an url (e.g. https://www.thecrag.com/de/klettern/france/)
echo.

echo Unfortunately does not work since wget get an error "too many fds open", it will not download them all ....
pause

set /p output=Where to save the gpx:   
for /F %%i in ("%output%") do @set drive=%%~di
%drive%
cd "%output%"

set /p url=Give me an url in this form: https://www.thecrag.com/de/klettern/france/   
set last=%url:~-1%
if not %last%==/ (
	set url=%url%/
)


:: get name country to avoid to download other country gpx
echo %url% | sed -nr "s/https\:\/\/www\.thecrag\.com\/..\/.*\/(.*)\//\1/p" > temp
set /p country=<temp
:: remove space
set country=%country: =%
rm temp


echo.
echo Getting links with wget, will take a while, make me a Coffee :)
echo.

wget --spider --recursive --force-html --no-parent --no-directories --no-cache --no-http-keep-alive --no-dns-cache --user-agent=Mozilla %url% -o temp.log
cat temp.log | grep "^--" | grep -E ".*%country%/.*area/[0-9]*$" | awk "{print $3}" | sed "s/$/\/gpx/" | sed "s/^/wget --user-agent=Mozilla --content-disposition /" > temp.bat
uniq temp.bat > temp_uniq.bat
rm temp.bat
temp_uniq.bat

set /p fine=Are you fine with result ? I will delete the temp files
rm temp.log temp.bat temp_uniq.bat

set /p rmdesc=Do you wanna remove all comments or description from gpx (save space) [y/n]   
if %rmdesc%==y (
	for %%f in (*.gpx) do (
		echo %%f
		sed -i "/\<desc\>\|\<\/desc\>/d" "%%f"
	)
	ls | grep "^sed.*" | xargs rm
)

:: maybe need to be tested here
set /p merge=Do you wanna merge all gpx [y/n]:   

if %merge%==y (
	ls | grep gpx.1 | xargs rm
	ls | grep gpx.2 | xargs rm
	ls | grep gpx.3 | xargs rm
	for %%f in (*.gpx) do (
		copy "%%f" "Merge.gpx"
		goto :continue
	)
	:continue
	for %%f in (*.gpx) do "C:\Program Files (x86)\GPSBabel\gpsbabel.exe" -i gpx -f Merge.gpx -f "%%f" -x duplicate,location,shortname -o gpx -F Merge.gpx
)

