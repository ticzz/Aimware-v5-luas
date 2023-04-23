local ref = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
gui.Text(ref, "Legit Anti-Aim")
local Off_Key = gui.Keybox(ref , "OffKey", "Off Key", 0)
local Left_Key = gui.Keybox(ref , "Leftkey", "Left Key", 0)
local Right_Key = gui.Keybox(ref , "RightKey", "Right Key", 0)
local Left = true
local Off = true
local font = draw.CreateFont('Tahoma', 25, 100)

callbacks.Register( "Draw", function()
    draw.SetFont(font)
    draw.Color(128,0,0,255)
    if Left_Key:GetValue() ~= 0 then
        if input.IsButtonPressed(Left_Key:GetValue()) then
            Left = true
            Off = false
        end
    end
    if Right_Key:GetValue() ~= 0 then
        if input.IsButtonPressed(Right_Key:GetValue()) then
            Left = false
            Off = false
        end
    end
    if Off_Key:GetValue() ~= 0 then
        if input.IsButtonPressed(Off_Key:GetValue()) then
            Off = true
            gui.SetValue("rbot.antiaim.base", "0.0 Off")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
            gui.SetValue("rbot.antiaim.left", 0)
            gui.SetValue("rbot.antiaim.right", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
        end
    end
    if Left and not Off then
            gui.SetValue("rbot.antiaim.base", "29.0 Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 58)
            gui.SetValue("rbot.antiaim.base.lby", -58)
            gui.SetValue("rbot.antiaim.left", 0)
            gui.SetValue("rbot.antiaim.right", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
            draw.Text(748,1045, "Left")
    elseif not Left and not Off then
            gui.SetValue("rbot.antiaim.base", "-29.0 Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.base.rotation", -58)
            gui.SetValue("rbot.antiaim.base.lby", 58)
            gui.SetValue("rbot.antiaim.left", 0)
            gui.SetValue("rbot.antiaim.right", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
            draw.Text(748,1045, "Right")
    end
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

