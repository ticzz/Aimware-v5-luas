
local e_thing_legitaa_keybox = gui.Keybox(e_thing_gb,"e.thing.legitaa.bind", "OnPress Legit AA", 69)
e_thing_legitaa_keybox:SetDescription("Legit AA to counter Enemys who disabled Resolver (to counter your E Peaks)")


local function AA()
    if not e_thing_legitaa_keybox:GetValue() then 
		return
	end
        
	local old_aa_base_yaw = gui.GetValue("rbot.antiaim.base")

        if input.IsButtonDown(e_thing_legitaa_keybox:GetValue()) then
		
	    	gui.SetValue("rbot.antiaim.base", 0, "Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
			else
			gui.SetValue("rbot.antiaim.base", 180, "Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 1)
        end
    end

callbacks.Register("Draw", AA)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

