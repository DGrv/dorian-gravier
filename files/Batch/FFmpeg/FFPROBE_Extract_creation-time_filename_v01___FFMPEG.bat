@echo off

	REM https://ourcodeworld.com/articles/read/1484/how-to-get-the-information-and-metadata-of-a-media-file-audio-or-video-in-json-format-with-ffprobe
	REM Get all info available ffprobe : ffprobe -hide_banner -loglevel fatal -show_error -show_format -show_streams -show_programs -show_chapters -show_private_data -print_format json file.mp4

echo Extract filename and creation time in 2 txt files.

rm Creation_time.txt Filename.txt

for %%p in (*.mp4) do (
	ffprobe -v error -show_entries format_tags=creation_time -of default=noprint_wrappers=1:nokey=1 %%p >> Creation_time.txt
	echo %%p >> Filename.txt
)
