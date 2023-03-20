-- local lanes = require('lanes')

function add_text_overlay_TR()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v03___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'call '..strProgram..' '..video_path..' '..t1..' 7 50 TR'
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("k", "add_text_overlay_TR", add_text_overlay_TR)

function add_text_overlay_TL()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v03___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'call '..strProgram..' '..video_path..' '..t1..' 7 50 TL'
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("K", "add_text_overlay_TL", add_text_overlay_TL)

function speed()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\SpeedUp_v04___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("b", "speed", speed)



function reduce_sound_noise()
	-- strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\FFMPEG_Volume_v01.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	os.rename(video_path, video_in)
	strCmd = 'ffmpeg -stats -loglevel error  -i "' ..video_in.. '" -filter:a "volume=0.2" -c:v copy ' ..video_path..'"'
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("h", "reduce_sound_noise", reduce_sound_noise)	

function triple_sound()
	-- strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\FFMPEG_Volume_v01.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	video_in = video_path_noext..'_old'..video_ext
	os.rename(video_path, video_in)
	strCmd = 'ffmpeg -stats -loglevel error  -i "' ..video_in.. '" -filter:a "volume=3" -c:v copy ' ..video_path..'"'
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("g", "triple_sound", triple_sound)





function zoom()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\ZoomPanIn_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("Z", "zoom", zoom)

function rotate()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Rotate_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("R", "rotate", rotate)