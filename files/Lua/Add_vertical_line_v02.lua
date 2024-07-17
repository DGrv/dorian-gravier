local msg = require('mp.msg')
local assdraw = require('mp.assdraw')
local utils = require "mp.utils"


local draw_cropper = function ()
	osd_w, osd_h = mp.get_property("osd-width"), mp.get_property("osd-height")
	mp.set_osd_ass(osd_w, osd_h, "")
	ass = assdraw.ass_new()
	ass:draw_start()
	ass:pos(0, 0)
	mx, my = mp.get_mouse_pos()
	print("mouse poisition "..mx)
	ass:move_to(tonumber(mx), 0)
	ass:line_to(tonumber(mx), osd_h)
	ass:draw_stop()
	mp.set_osd_ass(osd_w, osd_h, ass.text)
end

mp.add_key_binding("F3", draw_cropper)
-- mp.add_key_binding("mouse_move", draw_cropper)
-- mp.add_key_binding("F3", cropeasy_activate)
