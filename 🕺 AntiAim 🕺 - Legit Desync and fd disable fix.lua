
local w, h = draw.GetScreenSize()

local aa_ref = gui.Reference("Ragebot", "Anti-Aim")
local rb_ref = gui.Reference("ragebot")
local tab = gui.Tab(rb_ref, "legit_aa", "legit aa")
local tab_ref = gui.Reference("ragebot", "legit aa")
local gb_r = gui.Groupbox(tab, "Legit Anti-Aim", 15, 15, 600, 400)
local setting_r = gui.Combobox(gb_r, "setting_r", "Setting:", "Real", "Fake")
local nf_key = gui.Keybox(gb_r, "nkey", "No Fake", 0)
local invert_key = gui.Keybox(gb_r, "ikey", "Invert Key", 0)
local left_key = gui.Keybox(gb_r, "left", "Left Side", 0)
local right_key = gui.Keybox(gb_r, "right", "Right Side", 0)
local lby_angle = gui.Slider(gb_r, "lbyangle", "LBY Offset", 58, 0, 180)
local position_z = gui.Slider(gui.Reference("Visuals", "Other", "Extra"), "z", "Z Position", h / 2, 0, h)

local sr_ref = gui.Reference("Legitbot", "Semirage")
local gb_l = gui.Groupbox(sr_ref, "Legit Anti-Aim Inverter", 15, 360, 300, 400)
local invert_l = gui.Keybox(gb_l, "il", "Invert Key", 0)

position_z:SetDescription("Sets Z position for the indicator")
nf_key:SetDescription("Removes Legit Desync")
invert_key:SetDescription("Key used to invert anti-aim")
left_key:SetDescription("Rotates desync to left")
right_key:SetDescription("Rotates desync to right")
lby_angle:SetDescription("Set LBY Flick angle")
invert_l:SetDescription("Inverts Legit Anti-Aim")

local current_angle = 0

callbacks.Register(
    "Draw",
    "Inverter_rage",
    function()
        if gui.GetValue("rbot.master") == true then
            if invert_key:GetValue() ~= 0 then
                if input.IsButtonPressed(invert_key:GetValue()) then
                    current_angle = current_angle == 0 and 1 or 0
                end
            end

            if nf_key:GetValue() ~= 0 then
                if input.IsButtonPressed(nf_key:GetValue()) then
                    current_angle = 2
                end
            end

            if left_key:GetValue() ~= 0 then
                if input.IsButtonPressed(left_key:GetValue()) then
                    current_angle = 1
                end
            end

            if right_key:GetValue() ~= 0 then
                if input.IsButtonPressed(right_key:GetValue()) then
                    current_angle = 0
                end
            end

            if current_angle ~= 2 then
                local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
                local rotation = current_angle == 0 and 58 or -58
                lby = setting_r:GetValue() == 0 and -lby or lby
                rotation = setting_r:GetValue() == 0 and -rotation or rotation
                gui.SetValue("rbot.antiaim.base.lby", lby)
                gui.SetValue("rbot.antiaim.base.rotation", rotation)
                gui.SetValue("rbot.antiaim.base", input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) and [[0.0 "Off"]] or string.format([[%s "Desync"]], rotation == 58 and 29 or -29))
                gui.SetValue("rbot.antiaim.advanced.pitch", 0)
                gui.SetValue("rbot.antiaim.advanced.antialign", 0)
            else
                gui.SetValue("rbot.antiaim.base", 0)
                gui.SetValue("rbot.antiaim.base.rotation", 0)
                gui.SetValue("rbot.antiaim.base.lby", 0)
                gui.SetValue("rbot.antiaim.advanced.antialign", 0)
            end
        end
    end
)

callbacks.Register("Draw", "Inverter_legit", function()
    if gui.GetValue("lbot.master") == true then
        if invert_l:GetValue() ~= 0 then
            if input.IsButtonPressed(invert_l:GetValue()) then
                gui.SetValue("lbot.antiaim.direction", 2)
                if current_angle == 1 then
                    gui.SetValue("lbot.antiaim.leftkey", 0)
                    gui.SetValue("lbot.antiaim.rightkey", invert_l:GetValue())
                    current_angle = 2
                elseif current_angle == 2 or current_angle == 0 then
                    gui.SetValue("lbot.antiaim.leftkey", invert_l:GetValue())
                    gui.SetValue("lbot.antiaim.rightkey", 0)
                    current_angle = 1
                end
            end
        end
    end
end)

local textFont = draw.CreateFont("Verdana", 25, 3000)

callbacks.Register(
    "Draw",
    "Indicator",
    function()
        if not entities.GetLocalPlayer() then
            return
        end
        if not entities.GetLocalPlayer():IsAlive() then
            return
        end

        draw.SetFont(textFont)
        draw.Color(124, 176, 34, 200)

        if gui.GetValue("rbot.master") == true then
            if current_angle == 0 then
                draw.Text(5, position_z:GetValue(), "MANUAL:RIGHT")
            elseif current_angle == 1 then
                draw.Text(5, position_z:GetValue(), "MANUAL:LEFT")
            end
        elseif gui.GetValue("lbot.master") == true then
            if current_angle == 0 then
                draw.Text(5, position_z:GetValue(), "NO DESYNC")
            elseif current_angle == 1 then
                draw.Text(5, position_z:GetValue(), "MANUAL:LEFT")
            elseif current_angle == 2 then
                draw.Text(5, position_z:GetValue(), "MANUAL:RIGHT")
            end
        end
    end
)










--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

