@echo off
SetLocal EnableDelayedExpansion

:: Loop over video files

set cdd=%CD%

for %%F in (1 2 3 4 5 6 7 8 15 123 132 213 231 312 321) do (

	echo Contest %%F ----------------------------------------------------------------------------
	
	ffmpeg -stats -loglevel error -i Countdown.gif -i Start1.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -filter_complex "[0:v][1:v][2:v][3:v][4:v][5:v][6:v][7:v][8:v][9:v][10:v][11:v][12:v][13:v][14:v][15:v][16:v][17:v][18:v][19:v]concat=n=20:v=1:a=0[gif];movie=C\\:/Users/doria/Downloads/20250803__Pitz_Alpine_Glacier_Trail_2025/PAGT_2025_v01/896x128/Images/Background/%%F.png,scale=3840:548[bg];[bg][gif]overlay=format=auto" -loop 1 -shortest -pix_fmt yuv420p -y Start_Contest_%%F.mp4
	
	echo Done.
)

echo All done :)

REM ffmpeg -i Countdown.gif -i Start1.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -i Start2.gif -filter_complex "[0:v][1:v][2:v][3:v][4:v][5:v][6:v][7:v][8:v][9:v][10:v][11:v][12:v][13:v][14:v][15:v][16:v][17:v][18:v][19:v]concat=n=20:v=1:a=0[gif];movie=C\\:/Users/doria/Downloads/20250803__Pitz_Alpine_Glacier_Trail_2025/PAGT_2025_v01/896x128/Images/Background/1.png,scale=3840:548[bg];[bg][gif]overlay=format=auto" -loop 1 -shortest -pix_fmt yuv420p -y Start_Contest_1.mp4
