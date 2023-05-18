-- clip=require 'winapi'

mp.add_key_binding('F1', function ()
    mouse_pos = mp.get_property_native('mouse-pos')
    osd_dims = mp.get_property_native('osd-dimensions')
    video_params = mp.get_property_native('video-params')
	x = math.floor((mouse_pos.x - osd_dims.ml) * video_params.w / (osd_dims.w - osd_dims.ml - osd_dims.mr))
	y = math.floor((mouse_pos.y - osd_dims.mt) * video_params.h / (osd_dims.h - osd_dims.mt - osd_dims.mb))
    mp.osd_message(x..':'..y, 5)
	-- clip.set_clipboard('"'..x..':'..y..'"')
end)