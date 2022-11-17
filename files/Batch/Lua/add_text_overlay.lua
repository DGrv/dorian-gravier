function add_text_overlay()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\FFMPEG_Add_text_overlay_v03.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	t2 = t1+5
	strCmd = 'call '..strProgram..' '..video_path..' "'..t1..','..t2..'" "50" "TR"'
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end



mp.add_key_binding("k", "add_text_overlay", add_text_overlay)
