if not pcall(function() gui.GetValue("esp.tab_ind_opt") end) then
	local ind = http.Get("https://raw.githubusercontent.com/bean07/indicators-library/master/ind_lib.lua")
	local file = file.Open("ind_lib\\ind_lib.lua", "a")
	if file:Size() == 0 then
		file:Write(ind)
	end
	LoadScript("ind_lib\\ind_lib.lua")
end

local chk_fake = gui.Checkbox(gb_3, "chk_fake", "Fake Indicator", false)

local clr_fake = gui.ColorPicker(gb_4, "clr_fake", "Fake Indicator Color", 210, 210, 210, 255)

local fake = Indicator:Add("FAKE", {clr_fake:GetValue()}, false)

local indicators = {
fake
}


callbacks.Register("Draw",
	fake:SetColor({clr_fake:GetValue()})

	for i = 1, #indicators do
		indicators[i]:SetVisible(false)
		indicators[i]:SetDrawCircle(false)
	end

	if chk_fake:GetValue() then
		local lby = math.min(58, math.max(-58, (pLocal:GetProp("m_flLowerBodyYawTarget") - pLocal:GetProp("m_angEyeAngles").y + 180) % 360 - 180))
		local rot = nil
		if gui.GetValue("rbot.master") then
			rot = gui.GetValue("rbot.antiaim.desync")
		else
			if lby > 0 then
				rot = -58
			else
				rot = 58
			end
		end
		local delta = math.abs(lby - rot)
		local p = delta / 116
	    local percentage = p * 100
		fake:SetVisible(true)
		fake:DrawCircle(xpos + 75, Indicator.font.size/3, Indicator.font.size/3, 3, percentage)
	end
	end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

