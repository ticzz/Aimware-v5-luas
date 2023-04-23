local tab = gui.Reference("Ragebot", "Anti-Aim", "Anti-Aim")
local font = draw.CreateFont("Verdana", 32, 700)

-- [manual aa] --

local manual_aa_group = gui.Groupbox(tab, "Manual Anti-Aim")
local manual_aa_box = gui.Checkbox(manual_aa_group, "manual_aa_switch", "Enable", false)
local manual_aa_ind_box = gui.Checkbox(manual_aa_group, "manual_aa_ind_switch", "Indicators", false)
local manual_aa_key_left = gui.Keybox(manual_aa_group, "manual_aa_left", "Left", 0);
local manual_aa_key_back = gui.Keybox(manual_aa_group, "manual_aa_back", "Back", 0);
local manual_aa_key_right = gui.Keybox(manual_aa_group, "manual_aa_right", "Right", 0);
local manual_aa_ind_color = gui.ColorPicker(manual_aa_group, "manual_aa_ind_color", "Color", 78, 126, 242, 255);

callbacks.Register('Draw', function(Event)
    if not manual_aa_box:GetValue() then
        return
    end

    if input.IsButtonPressed(manual_aa_key_left:GetValue()) then
        gui.SetValue('rbot.antiaim.yaw', 90)
    end

    if input.IsButtonPressed(manual_aa_key_back:GetValue()) then
        gui.SetValue('rbot.antiaim.yaw', 180)
    end

    if input.IsButtonPressed(manual_aa_key_right:GetValue()) then
        gui.SetValue('rbot.antiaim.yaw', -90)
    end
end)

callbacks.Register('Draw', function(Event)
    if (not manual_aa_ind_box:GetValue()) or (not manual_aa_box:GetValue()) then
        return
    end

    local w, h = draw.GetScreenSize();
    draw.SetFont(font);
    draw.Color(manual_aa_ind_color:GetValue());

    if gui.GetValue('rbot.antiaim.yaw') == 90 then
        draw.Text(w / 2 - 31, h / 2 - 13, "<");
        draw.TextShadow(w / 2 - 31, h / 2 - 13, "<");
    end

    if gui.GetValue('rbot.antiaim.yaw') == 180 then
        draw.Text(w / 2 - 10, h / 2 + 13, "V");
        draw.TextShadow(w / 2 - 10, h / 2 + 13, "V");
    end

    if gui.GetValue('rbot.antiaim.yaw') == -90 then
        draw.Text(w / 2 + 10, h / 2 - 13, ">");
        draw.TextShadow(w / 2 + 10, h / 2 - 13, ">");
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

