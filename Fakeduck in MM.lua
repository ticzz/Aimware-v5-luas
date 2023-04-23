local max_ticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks")
local fd_max_ticks_slider = gui.Slider(gui.Reference("Ragebot", "Anti-Aim", "Extra"), "Chicken.fd_max_ticks", "Max ticks on fakeduck", 25, 15, 61)

callbacks.Register("Draw", function()
	if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
		max_ticks:SetValue(fd_max_ticks_slider:GetValue())
	else
		max_ticks:SetValue(16)
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

