@echo off
SetLocal EnableDelayedExpansion

REM spleeter separate -o spleeter_out Etape_9_BikeTrip2022_Le_debut_des_Pyrenees_AUDIO.mp3 Etape_8_BikeTrip2022_La_Vallée_de_l'Orb__AUDIO.mp3 Etape_7_BikeTrip2022_La_Dourbie_et_Navacelles_AUDIO.mp3 Etape_6_Bike_Trip_2022_Les_Gorges_du_Tarn_et_de_la_Jonte_AUDIO.mp3 Etape_5_Bike_Trip_2022_L'Aubrac_AUDIO.mp3 Etape_4-_Bike_Trip_2022_-_De_Champeix_a_Aurillac_AUDIO.mp3 Etape_3_Bike_Trip_2022_Du_Morvan_a_la_montagne_Bourbonaise_AUDIO.mp3 Etape_2_Bike_Trip_2022_Du_Morvan_a_la_montagne_Bourbonaise_AUDIO.mp3 Etape_1_Bike_Trip_2022_Vosges_to_Morvan_AUDIO.mp3


for /r %%i in (*.wav) do (
	set pathh=%%~dpi
	set pathh=!pathh:~,-1!
	set ext=%%~xi
	set cd2=%cd:\=\\\\%
	set cd2=!cd2::=\:!
	for /f %%p in ('echo !pathh! ^| sed "s/!cd2!\\\\//"') do set dirname=%%p
	echo !dirname!
	REM rename %%i !dirname!!ext!
	ffmpeg -stats -loglevel error -i %%i -y !dirname!.mp3
)

