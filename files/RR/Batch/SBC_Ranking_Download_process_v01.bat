


@echo off
setlocal enabledelayedexpansion
del /q *.xlsx

echo.
set /p stageid="Give me the Stage ID: ? "
echo. 

echo [33m--------------------- Open webpage UCI ---------------------[37m

REM ::	UCI_EliteM
REM start "" "https://dataride.uci.ch/iframe/RankingDetails/148?disciplineId=7&groupId=35&momentId=191665&disciplineSeasonId=445&rankingTypeId=1&categoryId=22&raceTypeId=92"
REM ::	UCI_EliteW
REM start "" "https://dataride.uci.ch/iframe/RankingDetails/155?disciplineId=7&groupId=38&momentId=191666&disciplineSeasonId=445&rankingTypeId=1&categoryId=23&raceTypeId=92"
REM ::	UCI_JuniorM
REM start "" "https://dataride.uci.ch/iframe/RankingDetails/153?disciplineId=7&groupId=43&momentId=191664&disciplineSeasonId=445&rankingTypeId=1&categoryId=24&raceTypeId=92"
REM ::	UCI_JuniorW
REM start "" "https://dataride.uci.ch/iframe/RankingDetails/160?disciplineId=7&groupId=44&momentId=191667&disciplineSeasonId=445&rankingTypeId=1&categoryId=25&raceTypeId=92"

echo [31mDownload them in the right order EliteM, EliteW, JuniorM, JuniorW ![37m
pause


set i=0
for %%f in (*.xlsx) do (
    set /a i+=1
    if !i! equ 1 rename "%%f" "UCI_EliteM.xlsx"
    if !i! equ 2 rename "%%f" "UCI_EliteW.xlsx"
    if !i! equ 3 rename "%%f" "UCI_JuniorM.xlsx"
    if !i! equ 4 rename "%%f" "UCI_JuniorW.xlsx"
)

echo [32mRename done UCI[37
echo.
echo.




:: SwissCycling
echo [32m--------------------- Download SwissCycling ---------------------[37m

curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=elite-maenner&csv=true"	 -o "SC_EliteM.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=elite-frauen&csv=true"	 -o "SC_EliteW.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=master&csv=true"	 -o "SC_Master.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u23-maenner&csv=true"	 -o "SC_U23M.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u23-frauen&csv=true"	 -o "SC_U23W.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u19-maenner&csv=true"	 -o "SC_U19M.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u19-frauen&csv=true"	 -o "SC_U19W.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u17-maenner&csv=true"	 -o "SC_U17M.xlsx"
curl -L "https://www.swiss-cycling.ch/de/veranstaltungen/jahresklassement/?discipline=mtb-xco&category=u17-frauen&csv=true"	 -o "SC_U17W.xlsx"


echo [32mDownload done SC[37m
echo.
echo.

echo [32m--------------------- Convert in csv ---------------------[37m


for %%f in (*.xlsx) do (
	C:\Users\doria\scoop\apps\libreoffice\current\LibreOffice\program\soffice.exe  --headless --convert-to csv --outdir "%cd%" "%%f"
)

del /q *.xlsx

rscript "C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\files\RR\UCI_ranking_SBC_v01.R" "%cd%" "%stageid%"



