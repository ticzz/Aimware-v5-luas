local w, h = draw.GetScreenSize()

local aa_ref = gui.Reference("Ragebot", "Anti-Aim")
local gb = gui.Groupbox(aa_ref, "Legit Anti-Aim", 15, 650, 300, 400)
local nf_key = gui.Keybox(gb, "nkey", "No Fake", 0)
local invert_key = gui.Keybox(gb, "ikey", "Invert Key", 0)
local lby_angle = gui.Slider(gb, "lbyangle", "LBY Offset", 58, 0, 180)
local position = gui.Slider(gb, "z", "Z Position", h/2, 0, h)

position:SetDescription("Sets Z position for the indicator")
nf_key:SetDescription("Removes Legit Desync")
invert_key:SetDescription("Key used to invert anti-aim")
lby_angle:SetDescription("Set LBY Flick angle")

local current_angle = 0
    
local textFont = draw.CreateFont('Verdana', 25, 3000)
callbacks.Register( "Draw", "Inverter", function()
    draw.SetFont(textFont)
    draw.Color(124,176,34,200)
    if invert_key:GetValue() ~= 0 then
        if input.IsButtonPressed(invert_key:GetValue()) then
            current_angle = current_angle == 0 and 1 or 0;
            local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
            local rotation = current_angle == 0 and 58 or -58
            gui.SetValue("rbot.antiaim.base.lby", lby)
            gui.SetValue("rbot.antiaim.base.rotation", rotation)
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", 1)
        end
    end
    if nf_key:GetValue() ~= 0 then
        if input.IsButtonPressed(nf_key:GetValue()) then
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", 0)
            current_angle = 3
        end
    end
    if not entities.GetLocalPlayer() then return end
    if not entities.GetLocalPlayer():IsAlive() then return end
    if current_angle == 0 then
        draw.Text(5, position:GetValue(), "MANUAL:RIGHT")
    elseif current_angle == 1 then
        draw.Text(5, position:GetValue(), "MANUAL:LEFT")
    end
end);
