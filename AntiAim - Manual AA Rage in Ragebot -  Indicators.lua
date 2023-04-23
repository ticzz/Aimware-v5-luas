-- Manual AA & Indicators

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;
local rage_ref = gui.Reference("RAGEBOT", "Anti-Aim", "Advanced");
local check_indicator = gui.Checkbox( rage_ref, "Enable", "Manual AA", false)
local AntiAimleft = gui.Keybox(rage_ref, "Anti-Aim_left", "Left Keybind", 0);
local AntiAimRight = gui.Keybox(rage_ref, "Anti-Aim_Right", "Right Keybind", 0);
local AntiAimBack = gui.Keybox(rage_ref, "Anti-Aim_Back", "Back Keybind", 0);
local lby_angle = gui.Slider(rage_ref, "lbyangle", "LBY Offset", 58, 0, 180)
local current_angle = 3

lby_angle:SetDescription("Set LBY Flick angle")


-- fonts
local fatality_font = draw.CreateFont("Verdana", 20, 700)
local damage_font = draw.CreateFont("Verdana", 15, 700)
local arrow_font = draw.CreateFont("Marlett", 35, 700)
local normal_font = draw.CreateFont("Arial", 0, 0)

local function main()
    if AntiAimleft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimleft:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimBack:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimBack:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
        end
    end
end


function CountCheck()
   if ( LeftKey == 1 ) then
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 1 ) then
        LeftKey = 0;
        RightKey = 0;
    elseif ( RightKey == 1 ) then
        LeftKey = 0;
        BackKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( BackKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   elseif ( RightKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
   end       
end

function SetLeft()
   current_angle = current_angle == 0 and 1 or 0;
   local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
   local rotation = current_angle == 0 and 58 or -58
   gui_set("rbot.antiaim.base.lby", lby)
   gui_set("rbot.antiaim.base.rotation", rotation)
   gui_set("rbot.antiaim.base", 90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
   current_angle = 0
end

function SetBackWard()
   current_angle = current_angle == 0 and 1 or 0;
   local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
   local rotation = current_angle == 0 and 58 or -58
   gui_set("rbot.antiaim.base.lby", lby)
   gui_set("rbot.antiaim.base.rotation", rotation)
   gui_set("rbot.antiaim.base", 180);
   gui_set("rbot.antiaim.advanced.autodir", 0);
   current_angle = 1
end

function SetRight()
   current_angle = current_angle == 0 and 1 or 0;
   local lby = current_angle == 0 and -lby_angle:GetValue() or lby_angle:GetValue()
   local rotation = current_angle == 0 and 58 or -58
   gui_set("rbot.antiaim.base.lby", lby)
   gui_set("rbot.antiaim.base.rotation", rotation)
   gui_set("rbot.antiaim.base", -90);
   gui_set("rbot.antiaim.advanced.autodir", 0);
   current_angle = 2
end

function SetAuto()
   gui_set("rbot.antiaim.base", 0)
   gui_set("rbot.antiaim.base.rotation", 0)
   gui_set("rbot.antiaim.base.lby", 0)
   gui_set("rbot.antiaim.advanced.antialign", 0)
   current_angle = 3
end

function draw_indicator()
--142 122 240 255

    local active = check_indicator:GetValue()

    if active then
        local w, h = draw.GetScreenSize();
        draw.SetFont(fatality_font);
        if (LeftKey == 1) then
            SetLeft();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "left");
            draw.TextShadow(15, h - 560, "left");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 60, h/2 - 16, "3");
            draw.TextShadow( w/2 - 60, h/2 - 16, "3");
            draw.SetFont(fatality_font);
        elseif (BackKey == 1) then
            SetBackWard();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "back");
            draw.TextShadow(15, h - 560, "back");
            draw.SetFont(arrow_font);
            draw.Text( w/2 - 17, h/2 + 33, "6");
            draw.TextShadow( w/2 - 17, h/2 + 33, "6");
            draw.SetFont(fatality_font);
        elseif (RightKey == 1) then
            SetRight();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "right");
            draw.TextShadow(15, h - 560, "right");
            draw.SetFont(arrow_font);
            draw.Text( w/2 + 30, h/2 - 16, "4");
            draw.TextShadow( w/2 + 30, h/2 - 16, "4");
            draw.SetFont(fatality_font);
        elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0)) then
            SetAuto();
            draw.Color(142, 122, 240, 255);
            draw.Text(15, h - 560, "freestand");
            draw.TextShadow(15, h - 560, "freestand");
        end
        draw.SetFont(normal_font);
    end
end

callbacks.Register( "Draw", "main", main);
callbacks.Register( "Draw", "CountCheck", CountCheck);
callbacks.Register( "Draw", "SetLeft", SetLeft);
callbacks.Register( "Draw", "SetBackWard", SetBackWard);
callbacks.Register( "Draw", "SetRight", SetRight);
callbacks.Register( "Draw", "SetAuto", SetAuto);
callbacks.Register( "Draw", "draw_indicator", draw_indicator);
