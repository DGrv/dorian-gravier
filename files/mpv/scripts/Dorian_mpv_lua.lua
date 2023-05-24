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
 
 mp.add_key_binding('i', function ()
	mp.osd_message(" k - Text overlay right \n K - Text overlay left \n n - Open Losslesscut \n b - Speed \n h - Sound reduce \n g - Sound increase \n Z - Zoom \n r - Rotate \n N - Remove noice \n y - Keyframes \n B - easyblur \n c - cut (not finished) \n C - cropeasy \n D - delete file  \n S - Add picture or/and sound", 10)
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
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_Picture-sound_overlay_v01___FFMPEG.bat"'
	strCmd = 'call '..strProgram..' '..video_path
	print(strCmd)
	mp.osd_message("Add picture or/and sound")
	os.execute(strCmd)
end)


------------------------------

function deletefile()
	video_path = mp.get_property("path")
	mp.osd_message("Delete file")
	os.remove(video_path)
end

mp.add_key_binding("D", "deletefile", deletefile)

------------------------------

function losslesscut()
	strProgram = '"C:\\Users\\doria\\Downloads\\Software\\LosslessCut-win-x64\\LosslessCut.exe"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' "'..video_path..'" && echo test'
	print(strCmd)
	mp.osd_message("Open Losslesscut")
	-- io.write(strCmd)
	os.execute(strCmd)
end

mp.add_key_binding("n", "losslesscut", losslesscut)


------------------------------

------------------------------

function add_text_overlay_TR()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v03___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'call '..strProgram..' '..video_path..' '..t1..' 50 TR'
	print(strCmd)
	mp.osd_message("Text overlay right")
	os.execute(strCmd)
end

mp.add_key_binding("k", "add_text_overlay_TR", add_text_overlay_TR)

------------------------------

function add_text_overlay_TL()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Add_text_overlay_v03___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	local t1 = mp.get_property_number("time-pos")
	-- keep "'..t1..','..t2..'" with " otherwise it is not working the , i making them separate
	strCmd = 'call '..strProgram..' '..video_path..' '..t1..' 50 TL'
	print(strCmd)
	mp.osd_message("Text overlay left")
	os.execute(strCmd)
end

mp.add_key_binding("K", "add_text_overlay_TL", add_text_overlay_TL)

------------------------------

function speed()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\SpeedUp_v04___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	mp.osd_message("Speed")
	os.execute(strCmd)
end

mp.add_key_binding("b", "speed", speed)



------------------------------

function reduce_sound_noise()
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
end

mp.add_key_binding("h", "reduce_sound_noise", reduce_sound_noise)	

------------------------------

function triple_sound()
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
end

mp.add_key_binding("g", "triple_sound", triple_sound)





------------------------------

function zoom()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\ZoomPanIn_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	mp.osd_message("Zoom")
	os.execute(strCmd)
end

mp.add_key_binding("Z", "zoom", zoom)

------------------------------

function rotate()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Rotate_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	mp.osd_message("Rotate")
	os.execute(strCmd)
end

mp.add_key_binding("R", "rotate", rotate)

------------------------------

function keyframes()
	strProgram = '"C:\\Users\\doria\\Downloads\\GitHub\\dorian.gravier.github.io\\files\\Batch\\FFmpeg\\Keyframe_v01___FFMPEG.bat"'
	--video_path = '"C:\\Users\\doria\\Downloads\\Pictures\\GoPro\\E9\\test\\0002.mp4"'
	video_path = mp.get_property("path")
	strCmd = 'call '..strProgram..' '..video_path..' '
	print(strCmd)
	mp.osd_message("Keyframes")
	os.execute(strCmd)
end

mp.add_key_binding("y", "keyframes", keyframes)




