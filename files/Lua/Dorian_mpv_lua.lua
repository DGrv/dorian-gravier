print("[INFO] - LUA_CPATH = "..package.path)
print("[INFO] - LUA_PATH = "..package.cpath)
print("[INFO] - Lua Version ".._VERSION)
function _86or64()
    if(0xfffffffff==0xffffffff) then return 32 else return 64 end
end
print("[INFO] - Lua bit version = ".._86or64());





-- local lanes = require('lanes')
 -- local luacom = require('luacom')
 -- local winapi = require("C:\\Program Files (x86)\\Lua\\5.1\\clibs\\winapi.dll")
 
`mp.add_key_binding('ü', function ()
	mp.osd_message("\n\n` - show console\n\n F2 - rename in console\n k - Text overlay right \n K - Text overlay left \n l - Text overlay mouse position \n I - Add circle gif \n n - Open Losslesscut \n b - Speed \n h - Sound reduce \n g - Sound increase \n Z - Zoom \n R - Rotate \n N - Remove noice \n y - Keyframes \n B - easyblur \n a - cut \n C - cropeasy \n D - delete file  \n S - Add picture or/and sound \n U - Add video overlay \n a - cut in 2 \n - - add bike trip location\n - Shift+T Always on Top\n - ä - Stabilization with vidstab", 10)
end)

-- mp.add_key_binding('W', function ()
	-- Shell = luacom.CreateObject("WScript.Shell")
	-- Shell:Run ("echo test", 0)
-- end)


------------------------------
 
mp.add_key_binding('N', function ()
	video_path = mp.get_property("path")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	timestamp = os.date("%Y%d%m_%H%M%S")
	video_in = video_path_noext..'_'..timestamp..'_old'..video_ext
	os.rename(video_path, video_in)
	strCmd = 'ffmpeg -stats -loglevel error  -i "' ..video_in.. '" -af arnndn=m="C\\\\:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/FFmpeg/filters/rnnoise-models/conjoined-burgers-2018-08-28/cb.rnnn" -c:v copy ' ..video_path..'"'
	print(strCmd)
	mp.osd_message("Remove noise")
	os.execute(strCmd)
end)

------------------------------
 
mp.add_key_binding('S', function ()
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	t2 = t1 + 6
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_Picture-sound_overlay_v02___FFMPEG.bat"'
	strCmd = 'cmder /x "/cmd '..strProgram..' "'..video_path..'" '..t1..' '..t2..'"'
	print(strCmd)
	mp.osd_message("Add picture or/and sound")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('D', function ()
	video_path = mp.get_property("path")
	mp.osd_message("Delete file")
	os.remove(video_path)
end)


------------------------------

mp.add_key_binding('n', function ()
	strProgram = '"C:\\Users\\doria\\scoop\\apps\\losslesscut\\current\\LosslessCut.exe"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' "'..video_path..'" && echo test'
	print(strCmd)
	mp.osd_message("Open Losslesscut")
	-- io.write(strCmd)
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('k', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v04___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	vpath = video_path:match("(.*[/\\])")

	local t1 = mp.get_property_number("time-pos")
	t2 = t1 + 6
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'cmder /x "/cmd '..strProgram..' "'..video_path..'" '..t1..' '..t2..' 50 TR"'
	print(strCmd)
	mp.osd_message("Text overlay right")
	-- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')
	os.execute(strCmd)
end)

------------------------------


mp.add_key_binding('U', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_video_overlay_v01___FFMPEG.bat"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..' '..t1..'"'
	print(strCmd)
	mp.osd_message("Add overlay video")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('K', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v04___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	vpath = video_path:match("(.*[/\\])")

	local t1 = mp.get_property_number("time-pos")
	t2 = t1 + 6
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..' '..t1..' '..t2..' 50 TL"'
	print(strCmd)
	mp.osd_message("Text overlay left")
	
	-- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('b', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\SpeedUp_v04___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..'"'
	print(strCmd)
	mp.osd_message("Speed")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('ä', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Stabilize_with_vidstab_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..'"'
	print(strCmd)
	mp.osd_message("Stabilization")
	os.execute(strCmd)
end)

------------------------------


mp.add_key_binding('h', function ()
	-- strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\FFMPEG_Volume_v01.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	timestamp = os.date("%Y%d%m_%H%M%S")
	video_in = video_path_noext..'_'..timestamp..'_old'..video_ext
	os.rename(video_path, video_in)
	strCmd = 'ffmpeg -stats -loglevel error  -i "' ..video_in.. '" -filter:a "volume=0.2" -c:v copy ' ..video_path..'"'
	print(strCmd)
	mp.osd_message("Sound reduce")
	os.execute(strCmd)
end)


------------------------------

mp.add_key_binding('g', function ()
	-- strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\FFMPEG_Volume_v01.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	video_path_noext = string.sub(video_path, 1, -5)
	video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	timestamp = os.date("%Y%d%m_%H%M%S")
	video_in = video_path_noext..'_'..timestamp..'_old'..video_ext
	os.rename(video_path, video_in)
	strCmd = 'ffmpeg -stats -loglevel error  -i "' ..video_in.. '" -filter:a "volume=6" -c:v copy ' ..video_path..'"'
	print(strCmd)
	mp.osd_message("Sound increase")
	os.execute(strCmd)
end)






------------------------------

mp.add_key_binding('Z', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\ZoomPanIn_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..'"'
	print(strCmd)
	mp.osd_message("Zoom")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('R', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Rotate_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..'"'
	print(strCmd)
	mp.osd_message("Rotate")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('y', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Keyframe_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..'"'
	print(strCmd)
	mp.osd_message("Keyframes")
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('-', function ()
	mp.osd_message("Add location bike trip")
	video_path = mp.get_property("path")
	vpath = video_path:match("(.*[/\\])")
	-- video_path_noext = string.sub(video_path, 1, -5)
	-- video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	-- timestamp = os.date("%Y%d%m_%H%M%S")
	-- video_in = video_path_noext..'_'..timestamp..'_old'..video_ext
	-- os.rename(video_path, video_in)
	t1 = mp.get_property_number("time-pos")
	t2 = t1 + 6
	
	strCmd = 'cmder /x "/cmd C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_Picture-location_overlay_v02___FFMPEG.bat "'..video_path..'" '..t1..' '..t2..'"'

	-- strCmd = 'ffmpeg -stats -loglevel error -i "'..video_in..'" -i "D:\\Pictures\\GoPro\\Map_bike\\Location_choose_white.png" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=0:0:enable='.."'".."between(t,"..t1..","..t2..")'"..'"'..' -c:a copy "'..video_path..'"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	print(strCmd)
	-- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')

	os.execute(strCmd)
end)



------------------------------


mp.add_key_binding('l', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_choosen_position_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	vpath = video_path:match("(.*[/\\])")
	
	mouse_pos = mp.get_property_native('mouse-pos')
    osd_dims = mp.get_property_native('osd-dimensions')
    video_params = mp.get_property_native('video-params')
	x = math.floor((mouse_pos.x - osd_dims.ml) * video_params.w / (osd_dims.w - osd_dims.ml - osd_dims.mr))
	y = math.floor((mouse_pos.y - osd_dims.mt) * video_params.h / (osd_dims.h - osd_dims.mt - osd_dims.mb))

	local t1 = mp.get_property_number("time-pos")
	t2 = t1 + 2
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..' '..t1..' '..t2..' 40 '..x..' '..y..'"'
	print(strCmd)
	mp.osd_message("White text where you need")
	
	-- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')
	os.execute(strCmd)
end)


------------------------------


mp.add_key_binding('I', function ()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_circle_overlay_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	vpath = video_path:match("(.*[/\\])")
	
	mouse_pos = mp.get_property_native('mouse-pos')
    osd_dims = mp.get_property_native('osd-dimensions')
    video_params = mp.get_property_native('video-params')
	x = math.floor((mouse_pos.x - osd_dims.ml) * video_params.w / (osd_dims.w - osd_dims.ml - osd_dims.mr))
	y = math.floor((mouse_pos.y - osd_dims.mt) * video_params.h / (osd_dims.h - osd_dims.mt - osd_dims.mb))

	local t1 = mp.get_property_number("time-pos")
	t2 = t1 + 3
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'cmder /x "/cmd '..strProgram..' '..video_path..' '..t1..' '..t2..' '..x..' '..y..' "'
	print(strCmd)
	mp.osd_message("Add circle")
	
	-- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')
	os.execute(strCmd)
end)



------------------------------

-- mp.add_key_binding('_', function ()
	-- mp.osd_message("Add location nobike")
	-- video_path = mp.get_property("path")
	-- vpath = video_path:match("(.*[/\\])")
	-- -- video_path_noext = string.sub(video_path, 1, -5)
	-- -- video_ext = string.sub(video_path, string.len(video_path) - 3, string.len(video_path))
	-- -- timestamp = os.date("%Y%d%m_%H%M%S")
	-- -- video_in = video_path_noext..'_'..timestamp..'_old'..video_ext
	-- -- os.rename(video_path, video_in)
	-- t1 = mp.get_property_number("time-pos")
	-- t2 = t1 + 6
	
	-- strCmd = 'cmder /x "/cmd C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_Picture-location_overlay_nobike_v01___FFMPEG.bat "'..video_path..'" '..t1..' '..t2..'"'

	-- -- strCmd = 'ffmpeg -stats -loglevel error -i "'..video_in..'" -i "D:\\Pictures\\GoPro\\Map_bike\\Location_choose_white.png" -filter_complex "[1:v]setpts=PTS-STARTPTS+(1/TB)[1v];[0:v][1v] overlay=0:0:enable='.."'".."between(t,"..t1..","..t2..")'"..'"'..' -c:a copy "'..video_path..'"'
	-- --video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	-- print(strCmd)
	-- -- os.execute('echo '..strCmd..' > '..vpath..'debugMPV')

	-- os.execute(strCmd)
-- end)





