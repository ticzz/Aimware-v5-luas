local x, y = draw.GetScreenSize()
local aa_ref = gui.Reference("Ragebot", "Anti-Aim")
local gb = gui.Groupbox(aa_ref, "Legit Anti-Aim", 15, 720, 300, 400)
local nf_key = gui.Keybox(gb, "nkey", "Off Key", 0)
local left_key = gui.Keybox(gb, "leftkey", "Left Key", 0)
local right_key = gui.Keybox(gb, "rightkey", "Right Key", 0)
local invert_key = gui.Keybox(gb, "ikey", "Invert Key", 0)
local lby_angle = gui.Slider(gb, "lbyangle", "LBY Offset", 58, 0, 180)
local xposition = gui.Slider(gb, "x", "X Position", x/2, 0, x)
local yposition = gui.Slider(gb, "y", "Y Position", y/2, 0, y)

nf_key:SetDescription("Removes Legit Desync")
left_key:SetDescription("Key used to set Fake to Left Side")
right_key:SetDescription("Key used to set Fake to Right Side")
lby_angle:SetDescription("Set LBY Flick angle")
xposition:SetDescription("Sets X Screenposition for the Indicator")
yposition:SetDescription("Sets Y Screenposition for the Indicator")

local current_angle = 0
local left = true
local nofake = true
   
local textFont = draw.CreateFont('Tahoma', 25, 100)

callbacks.Register( "Draw", "Inverter", function()
    draw.SetFont(textFont)
    draw.Color(128,0,0,255)

    if engine.GetServerIP() == nil then
	return
	end
	
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
    if left_key:GetValue() ~= 0 then
        if input.IsButtonPressed(left_key:GetValue()) then
            left = true
            nofake = false
        end
    end

    if right_key:GetValue() ~= 0 then
        if input.IsButtonPressed(right_key:GetValue()) then
            left = false
            nofake = false
        end
    end

    if nf_key:GetValue() ~= 0 then
        if input.IsButtonPressed(nf_key:GetValue()) then
            nofake = true
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", 0)
            current_angle = 3
        end
    end

    if left and not nofake or current angle == 1 then
        gui.SetValue("rbot.antiaim.base.lby", lby_angle:GetValue() * -1)
        gui.SetValue("rbot.antiaim.base.rotation", 58)
        gui.SetValue("rbot.antiaim.base", 0)
        gui.SetValue("rbot.antiaim.advanced.pitch", 0)
        gui.SetValue("rbot.antiaim.advanced.antialign", 1)
		draw.Text(xposition:GetValue(),yposition:GetValue(), "L <--")
		

    elseif not left and not nofake or current angle == 0  then
        gui.SetValue("rbot.antiaim.base.lby", lby_angle:GetValue())
        gui.SetValue("rbot.antiaim.base.rotation", -58)
        gui.SetValue("rbot.antiaim.base", 0)
        gui.SetValue("rbot.antiaim.advanced.pitch", 0)
        gui.SetValue("rbot.antiaim.advanced.antialign", 1)
        draw.Text(xposition:GetValue(),yposition:GetValue(), "R -->")
		
    end
end);


