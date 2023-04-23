--[[
Working on aimware legit low speed slow walk
by qi
]]

--gui
local ref = gui.Reference("Legitbot", "Other", "Movement")
local LegitSlow_Enable = gui.Checkbox(ref, "walkcustom2", "Low slow walk", 0)
local LegitSlow_speed = gui.Slider(ref, "slowspeed2", "Low slow walk speed", 25, 0, 75)

LegitSlow_Enable:SetDescription("Enable low walk speed.")
LegitSlow_speed:SetDescription("Modify low walk speed with this amount.")

--cmd
local function LegitSlow(cmd)

    local speed = LegitSlow_speed:GetValue()

    if  input.IsButtonDown(87) then
        cmd.forwardmove = (speed)
    end
    if input.IsButtonDown(83) then
        cmd.forwardmove = (-speed)
    end
    if input.IsButtonDown(65) then
        cmd.sidemove = (-speed)
    end
    if input.IsButtonDown(68) then
        cmd.sidemove = (speed)
    end

end

--callbacks
callbacks.Register("CreateMove", function(cmd)
    if gui.GetValue("lbot.master") and LegitSlow_Enable:GetValue() then
        LegitSlow(cmd)
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

