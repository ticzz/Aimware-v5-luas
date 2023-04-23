local font = draw.CreateFont('Verdana', 12);

callbacks.Register("Draw", function()
    if (watermark:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();

    -- do not edit above

    local divider = ' | ';
    local cheatName = 'aimware';
    local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetPlayerNameByIndex(indexlp);
    
    -- Do not edit below
    local delay;
    local tick;
  
    if (lp ~= nil) then
        delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", lp:GetIndex()) .. 'ms';
        tick = math.floor(lp:GetProp("localdata", "m_nTickBase") + 0x20) .. 'tick';
    end
    local watermarkText = cheatName .. divider .. userName .. divider;
    if (delay ~= nil) then
        watermarkText = watermarkText .. delay .. divider;
    end
    if (tick ~= nil) then
        watermarkText = watermarkText .. tick;
    end 
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 20, 15;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 20, start_y * 0.0125;
    draw.Color(0, 0, 0, 150);
    draw.FilledRect(start_x + 10, start_y, start_x + watermarkWidth , start_y -5 + h + heightPadding);

    draw.Color(0, 0, 0, 255)
    draw.Text(start_x + weightPadding / 2+5, start_y + heightPadding / 2 - 2, watermarkText );

    draw.Color(255,255,255,255);
    draw.Text(start_x + weightPadding / 2+6, start_y + heightPadding / 2 - 3, watermarkText );


    draw.Color(78, 126, 242, 255);
    draw.FilledRect(start_x+10, start_y, start_x + watermarkWidth , start_y +1);
end)

------------------------------------------------------------
--DrawUI
------------------------------------------------------------
function DrawUI()
    watermark = gui.Checkbox(gui.Reference("Misc","General","Extra"),"watermark","Show Watermark",0);
    watermark:SetDescription("Shows watermark AIMWARE.net.");
end
DrawUI();









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

