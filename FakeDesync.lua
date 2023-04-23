local ref = gui.Reference("Ragebot", "Anti-Aim", "Extra")
local check = gui.Checkbox(ref, "check", "Fake Desync", false)
local base = gui.GetValue("rbot.antiaim.base")
local rotation = gui.GetValue("rbot.antiaim.base.rotation")
local antialign = gui.GetValue("rbot.antiaim.advanced.antialign")

local function predlol()

    if check:GetValue() then
        if globals.TickCount() % 5 == 0 then
            gui.SetValue("rbot.antiaim.base", "180 Desync")
            gui.SetValue("rbot.antiaim.base.rotation", 1)
            gui.SetValue("rbot.antiaim.advanced.antialign", 1)
        else
            gui.SetValue("rbot.antiaim.base", "180 Backward")
        end
    else
        gui.SetValue("rbot.antiaim.base", base)
        gui.SetValue("rbot.antiaim.base.rotation", rotation)
        gui.SetValue("rbot.antiaim.advanced.antialign", antialign)
    end
end

