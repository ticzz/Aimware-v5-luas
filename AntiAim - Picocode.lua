local RotationJitter = 10
local LBYJitter = 1

local MENU = gui.Tab(gui.Reference("Ragebot"), "aa.settings", "PICOCODE AA")

local Jitter1 = gui.Slider(MENU, "first_jitter", "First Jitter", 0, -58, 58)
local Jitter2 = gui.Slider(MENU, "second_jitter", "Second Jitter", 0, -58, 58)
local LBYJitter1 = gui.Slider(MENU, "first_LBYjitter", "First LBY Jitter", 0, -180, 180)
local LBYJitter2 = gui.Slider(MENU, "second_LBYjitter", "Second LBY Jitter", 0, -180, 180)

local howmuchtime = gui.Slider(MENU, "timer_LBYjitter", "Timer LBY Jitter Updater", 0, 0, 1, 0.1)
local LBYFUCKER = gui.Slider(MENU, "fucker_LBYjitter", "LBY Fucker", 0, 0, 1, 0.1)

local fuckerbutton = gui.Checkbox(MENU, "fuckerbutton_LBYjitter", "LBY Fucker", false)

function JitterOffset()
    if (RotationJitter == 10) then
        gui.SetValue("rbot.antiaim.base.rotation", Jitter1:GetValue())
		gui.SetValue("rbot.antiaim.left.rotation", Jitter1:GetValue())
		gui.SetValue("rbot.antiaim.right.rotation", Jitter1:GetValue())
        RotationJitter = 11
    elseif (RotationJitter == 11) then
        gui.SetValue("rbot.antiaim.base.rotation", Jitter2:GetValue())
		gui.SetValue("rbot.antiaim.left.rotation", Jitter2:GetValue())
		gui.SetValue("rbot.antiaim.right.rotation", Jitter2:GetValue())
        RotationJitter = 10
        end
end

local last_lby = globals.RealTime();
local last_lbyfucker = globals.RealTime();
function LBY()
	if last_lby + howmuchtime:GetValue() < globals.RealTime() then
		if (LBYJitter == 1) then
			gui.SetValue("rbot.antiaim.base.lby", LBYJitter1:GetValue())
			gui.SetValue("rbot.antiaim.left.lby", LBYJitter1:GetValue())
			gui.SetValue("rbot.antiaim.right.lby", LBYJitter1:GetValue())
			LBYJitter = 0
		elseif (LBYJitter == 0) then
			gui.SetValue("rbot.antiaim.base.lby", LBYJitter2:GetValue())
			gui.SetValue("rbot.antiaim.left.lby", LBYJitter2:GetValue())
			gui.SetValue("rbot.antiaim.right.lby", LBYJitter2:GetValue())
			LBYJitter = 1
			end
			last_lby = globals.RealTime();
	end
end

function lbyfuckerfunction()
    if fuckerbutton:GetValue() then
			if last_lbyfucker + LBYFUCKER:GetValue() < globals.RealTime() then
			gui.SetValue("rbot.antiaim.base.lby", 0)
			last_lbyfucker = globals.RealTime() 
		end
	end
end

callbacks.Register("Draw", lbyfuckerfunction)
callbacks.Register("Draw", LBY)
callbacks.Register("Draw", JitterOffset)