local font = draw.CreateFont('Arial', 14);
local windowW, windowH, menuPressed, j = 240, 440, 1, 0;
local mainWindow = gui.Window("rab_onetap_watermark", "Onetap watermark", 200, 200, windowW, windowH);
local settingsGroup = gui.Groupbox(mainWindow, "Settings", 13, 13, windowW - 25, windowH - 55);
local enabled = gui.Checkbox(settingsGroup, 'rab_onetap_watermark_enable', 'Enable', true);
local colorType = gui.Combobox(settingsGroup, "rab_onetap_watermark_color_type", 'Color Type', 'Static', 'Chroma');
local rainbowSpeed = gui.Slider(settingsGroup, "rab_onetap_watermark_rainbow_speed", "Rainbow Fade Speed", 1, 1, 10);
local r = gui.Slider(settingsGroup, "rab_onetap_watermark_r", "R", 0, 0, 255);
local g = gui.Slider(settingsGroup, "rab_onetap_watermark_g", "G", 0, 0, 255);
local b = gui.Slider(settingsGroup, "rab_onetap_watermark_b", "B", 0, 0, 255);
local a = gui.Slider(settingsGroup, "rab_onetap_watermark_a", "A", 100, 0, 255);

local function getTextColor()
    local luminance = math.sqrt(0.241 * (r:GetValue() ^ 2) + 0.691 * (g:GetValue() ^ 2) + 0.068 * (b:GetValue() ^ 2));
    if (luminance >= 130) then
        return 0, 0, 0;
    end
    return 255, 255, 255;
end

local function doRainbow()
    local speed = rainbowSpeed:GetValue();
    r:SetValue(math.floor(math.sin((globals.RealTime()) * speed) * 127 + 128));
    g:SetValue(math.floor(math.sin((globals.RealTime()) * speed + 2) * 127 + 128));
    b:SetValue(math.floor(math.sin((globals.RealTime()) * speed + 4) * 127 + 128));
end

callbacks.Register("Draw", function()
    if input.IsButtonPressed(45) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    mainWindow:SetActive(menuPressed);
    if (enabled:GetValue() ~= true) then
        return
    end
    if (colorType:GetValue() == 1) then
        doRainbow();
    end
    local lp = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();

    -- do not edit above

    local divider = ' | ';
    local cheatName = 'aimware.net ';
    local userName = ' kriZz ';
    
	-- Do not edit below
    local delay;
    local tick;
	local fps = 'FPS: ';
  
local frame_rate = 0/10
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1 / frame_rate))
end

 
    if (lp ~= nil) then
        delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", lp:GetIndex()) .. 'ms';
        tick = math.floor(lp:GetProp("localdata", "m_nTickBase") + 0x20) .. 'tick';
    end
    local watermarkText = cheatName .. divider .. userName .. divider;
    if (delay ~= nil) then
        watermarkText = watermarkText .. delay .. divider;
    end
    if (tick ~= nil) then
        watermarkText = watermarkText .. tick .. divider;
    end 
    watermarkText = watermarkText .. fps .. get_abs_fps()/10;
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 20, 15;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 20, start_y * 0.0225;
    draw.Color(r:GetValue(), g:GetValue(), b:GetValue(), a:GetValue());
    draw.FilledRect(start_x, start_y, start_x + watermarkWidth, start_y + h + heightPadding);
    draw.Color(getTextColor());
    draw.Text(start_x + weightPadding / 2, start_y + heightPadding / 2, watermarkText)
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

