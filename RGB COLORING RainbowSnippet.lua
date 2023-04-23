local ref = gui.Tab(gui.Reference("Visuals"), "localtab", "Helper") --("Visuals", "Other", "Extra")

callbacks.Register( "Draw", function()

	if activate:GetValue() == true then
		local r = math.floor(math.sin(globals.RealTime() * delay:GetValue()) * 127 + 128)
		local g = math.floor(math.sin(globals.RealTime() * delay:GetValue() + 2) * 127 + 128)
		local b = math.floor(math.sin(globals.RealTime() * delay:GetValue() + 4) * 127 + 128)
		local a = 255
	
		for k, v in pairs({ "VARIABLE_OF_COLOR_FOR_RGB" }) do
						
			gui.SetValue(v, r,g,b,a)

			if rgbdebug:GetValue() then
        		print(r,g,b)
    		end
		end
	end
end);

local function UI()
	activate = gui.Checkbox(ref, "activatecheckbox", "ACTIVATING_NAME_CHECKBOX", true)
	delay = gui.Slider(ref, "RGBcycledelay", "CycleDelay", 25, 1, 50, 5)
	delay:SetDescription("Set Delay for RGBcycle (Smaller = slower)")
	rgbdebug = gui.Checkbox(ref, "rgbdebugging", "RGB Info (DEBUG)", false)
end
UI()

callbacks.Register( "Unload", function()
UnloadScript()
end);




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")