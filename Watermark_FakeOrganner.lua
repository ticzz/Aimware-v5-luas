local font = draw.CreateFont('Tahoma', 14);
local UIwatermarkColor = gui.ColorEntry( "watermark_color", "Watermark Color", 204, 96, 112, 155);
local UIwatermarkTextColor = gui.ColorEntry( "watermark_text_color", "Watermark Text Color", 255, 255, 255, 200);


callbacks.Register("Draw", function()
    local LocalPlayer = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();
	local watermarkColor = { gui.GetValue( "watermark_color" ) };
	local watermarkTextColor= { gui.GetValue( "watermark_text_color" ) };

    local delay;
    local tick;
    local time = os.date("%X");
    if (LocalPlayer ~= nil) then
        delay = playerResources:GetPropInt("m_iPing", LocalPlayer:GetIndex()) .. 'ms';
        tick = math.floor(LocalPlayer:GetProp("localdata", "m_nTickBase") + 0x20);
    end

    local watermarkText = 'Organner.pl';			-- Change text here to get any Watermark u want
	    if (delay ~= nil) then
        watermarkText = watermarkText .. ' | rtt: ' .. delay;
    end
    if (tick ~= nil) then
        watermarkText = watermarkText .. ' | rate: ' .. tick .. ' | ';
    end
    watermarkText = watermarkText .. time;
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 10, 7;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 5, start_y * 0.008;
	draw.Color(gui.GetValue( "watermark_color" ));
    draw.FilledRect(start_x, start_y, start_x + watermarkWidth, start_y + h + heightPadding);
    draw.Color(gui.GetValue("watermark_text_color"));
    draw.Text(start_x + weightPadding / 2, start_y + heightPadding / 2, watermarkText)
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

