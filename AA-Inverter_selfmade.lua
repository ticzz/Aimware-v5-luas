local w, h = draw.GetScreenSize()
local x = w/2
local y = h/2
local current_angle = 0

local old_lby_offset = gui.GetValue("rbot.antiaim.base.lby")
local old_rotation_offset = gui.GetValue("rbot.antiaim.base.rotation")

local window = gui.Groupbox(gui.Reference("Ragebot", "Anti-Aim", "Extra"), "AntiAim Inverter")
local rotation_angle = gui.Slider(gb_r, "rotationangle", "Rotation Offset", old_rotation_offset, -58, 58)
local lby_angle = gui.Slider(gb_r, "lbyangle", "LBY Offset", old_lby_offset, -180, 180)
		
local invert_key = gui.Keybox(window,"invertkey","Invert Key", 88)
local MISC_INVERTER_ARROWSCOLOR = gui.ColorPicker(window, "misc.inverter.arrowscolor", "Arrows Color", 255, 0, 0, 255);
local SETTINGS_INDICATOR_X = gui.Slider( window, "settings.indicator.x", "X Offset", 20, 0, x*2 )
local SETTINGS_INDICATOR_Y = gui.Slider( window, "settings.indicator.y", "Y Offset", 950, 0, y*2 )
local SETTINGS_INDICATOR_COLOR_ENABLED = gui.ColorPicker( window, "settings.indicator.font.color.enabled", "Enabled Color", 124, 176, 34, 255)
local SETTINGS_INDICATOR_COLOR_DISABLED = gui.ColorPicker( window, "settings.indicator.font.color.disabled", "Disabled Color", 255, 25, 25, 255)

		
callbacks.Register( "Draw", function() 
	if gui.GetValue("rbot.master") == true then
		local invert = invert_key:GetValue()
		if invert ~= 0 and input.IsButtonPressed(invert) then
			
		current_angle = current_angle == 0 and 1 or 0;	--[[ == 0 and 1 or 0]]--;

		end

			if current_angle ~= 2 then
			local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
			local rotation = current_angle == 0 and -rotation_angle:GetValue() or rotation_angle:GetValue()
				lby = 0 and -lby or lby
				rotation = 0 and -rotation or rotation
				gui.SetValue("rbot.antiaim.base.lby", lby)
				gui.SetValue("rbot.antiaim.base.rotation", rotation)
			else
				gui.SetValue("rbot.antiaim.base.lby", -lby)
				gui.SetValue("rbot.antiaim.base.rotation", -rotation)
			end
		end
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

