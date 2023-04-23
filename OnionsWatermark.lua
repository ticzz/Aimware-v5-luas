local IsButtonDown, GetMousePos, AbsoluteFrameTime, Color, FilledRect, OutlinedRect, RoundedRectFill, Line, Text, RealTime, sin, floor, CreateFont, GetLocalPlayer, GetLocalPlayerIndex, GetPlayerResources, GetScreenSize, GetConVar, SetFont = input.IsButtonDown, input.GetMousePos, globals.AbsoluteFrameTime, draw.Color, draw.FilledRect, draw.OutlinedRect, draw.RoundedRectFill, draw.Line, draw.Text, globals.RealTime, math.sin, math.floor, draw.CreateFont, entities.GetLocalPlayer, client.GetLocalPlayerIndex, entities.GetPlayerResources, draw.GetScreenSize, client.GetConVar, draw.SetFont

local w=gui.Window('ow_wm_pos_wn','onion wm',0,0,0,0)local sX,sY=gui.Slider(w,"ow_wm_pos_x","x",0,900,1280),gui.Slider(w,"ow_wm_pos_y","y",0,0,960)w:SetActive(0)

local frame_rate = 0
local get_fps = function(t) if t then 
		return math.floor((1 / AbsoluteFrameTime()) + 0.5)
			else frame_rate = 0.9 * frame_rate + (1 - 0.9) * AbsoluteFrameTime()
		return math.floor((1 / frame_rate) + 0.5)
	end
end
local get_rainbow = function() local r, g, b = floor( sin( RealTime() ) * 127 + 128 ), floor( sin( RealTime() + 2) * 127 + 128 ), floor( sin( RealTime() + 4) * 127 + 128 ) return r, g, b end
local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end

local function draw_rect(x, y, w, h, r, g, b, a) Color(r, g, b, a) FilledRect(x, y, w, h) end
local function draw_rounded_rect(x1, y1, x2, y2, r, g, b, a) Color(r, g, b, a) RoundedRectFill(x1, y1, x2, y2) end
local function draw_outlined_rect(x, y, w, h, r, g, b, a) Color(r, g, b, a) OutlinedRect(x, y, w, h) end
local function draw_line(x1, y1, x2, y2, r, g, b, a) Color(r, g, b, a) Line(x1, y1, x2, y2) end
local function draw_text(x, y, r, g, b, a, font, str) SetFont(font) Color(r, g, b, a) Text(x, y, str) end

local font = {
	V12 = CreateFont('verdana', 12, 0),
	V13 = CreateFont('verdana', 13, 0)
}

local MENU = gui.Reference('MENU')
local tX, tY, offsetX, offsetY, _drag
local drag_menu = function(x, y, w, h)
local ping, tick
	if not MENU:IsActive() then
		return tX, tY
	end

	local mouse_down = IsButtonDown(1)

	if mouse_down then
		local X, Y = GetMousePos()

		if not _drag then
			local w, h = x + w, y + h
			if is_inside(X, Y, x, y, w, h) then
				offsetX, offsetY = X - x, Y - y
				_drag = true
			end
		else
			tX, tY = X - offsetX, Y - offsetY
			sX:SetValue(tX) sY:SetValue(tY)
		end
	else
		_drag = false
	end

	return tX, tY
end

local function MAIN()
	if not tX then
		tX, tY = sX:GetValue(),sY:GetValue()
	end

	local x, y = drag_menu(tX, tY, 314, 55)

	local local_player = GetLocalPlayer()
	local player_resources = GetPlayerResources()

	local fps = get_fps(true) 
	--local time = os.date('%h:%m:%s: %p:') --os.date()

	local ping = local_player and player_resources:GetPropInt( 'm_iPing', GetLocalPlayerIndex() ).. ' ms' or ''
	--local tick = local_player and floor( local_player:GetProp( 'localdata', 'm_nTickBase' ) + 0x40 ) or ''
	local tick = client.GetConVar("sv_maxcmdrate").. ''

	--- BACKGROUND ---
	draw_rect(x, y + 2, x + 318, y + 55 + 2, 30, 30, 30, 150)
	draw_outlined_rect(x, y + 2, x + 318, y + 55 + 2, 30, 30, 30, 255)
	draw_rect(x + 5, y + 7, x + 313, y + 45 + 7, 30, 30, 30, 255)

	--- FPS ---
	draw_outlined_rect(x + 22, y + 33, x + 21 + 22, y + 13 + 33, 120, 120, 120, 255)
	draw_outlined_rect(x + 24, y + 31, x + 21 + 24, y + 13 + 31, 120, 120, 120, 255)
	draw_rect(x + 20, y + 35, x + 21 + 20, y + 13 + 35, 30, 30, 30, 255)
	draw_outlined_rect(x + 20, y + 35, x + 21 + 20, y + 13 + 35, 120, 120, 120, 255)
	draw_text(x + 23, y + 35, 120, 120, 120, 255, font.V12, 'FPS')

	if fps < 30 then
		draw_text(x + 50, y + 33, 255, 0, 0, 230, font.V13, fps)
	else
		draw_text(x + 50, y + 33, 0, 255, 0, 230, font.V13, fps)
	end


	--- TICK ---
	draw_outlined_rect(x + 80, y + 33, x + 80 + 23, y + 33 + 13, 120, 120, 120, 255)
	draw_text(x + 82, y + 33, 120, 120, 120, 255, font.V12, 'TCK')
	draw_text(x + 110, y + 33, 255, 255, 255, 200, font.V13, tick)


	--- PING ---
	draw_outlined_rect(x + 153, y + 33, x + 157, y + 46, 120, 120, 120, 255)
	draw_rect(x + 148, y + 36, x + 152, y + 46, 120, 120, 120, 255)
	draw_rect(x + 143, y + 39, x + 147, y + 46, 120, 120, 120, 255)
	draw_rect(x + 138, y + 42, x + 142, y + 46, 120, 120, 120, 255)
	draw_text(x + 160, y + 33, 255, 255, 255, 200, font.V13, ping)


	--- TIME ---
	draw_rounded_rect(x + 206, y + 33, x + 221, y + 48, 120, 120, 120, 255)
	draw_text(x + 212, y + 35, 30, 30, 30, 255, font.V12, '-')
	draw_text(x + 210, y + 30, 30, 30, 30, 255, font.V12, '|')
	draw_text(x + 208, y + 30, 30, 30, 30, 255, font.V12, ' Time:')
	draw_text(x + 225, y + 33, 255, 255, 255, 200, font.V13, time)


	--- AIMWARE.net ---
	draw_text(x + 130, y + 9, 255, 255, 255, 200, font.V13, 'AIMWARE.net')
	local r, g, b = get_rainbow()
	draw_rect(x + 10, y + 25, x + 308, y + 28, r, g, b, 255)
end

callbacks.Register('Draw', MAIN)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

