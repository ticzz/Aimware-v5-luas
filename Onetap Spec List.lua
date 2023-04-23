--Made by Rab(SamzSakerz#4758)
local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
local shouldDrag = false;
local font_title = draw.CreateFont("Arial", 16, 16);
local font_spec = draw.CreateFont("Arial", 15, 15);
local topbarSize = 25;
local windowW, windowH, menuPressed, j = 240, 105, 1, 0;
local mainWindow = gui.Window("rab_onetap_speclist", "Onetap Speclist", 200, 200, windowW, windowH);
local settingsGroup = gui.Groupbox(mainWindow, "Settings", 13, 13, windowW - 25, windowH - 55);
local enabled = gui.Checkbox(settingsGroup, 'rab_onetap_speclist_enable', 'Enable', true);
local gradientOne = gui.ColorEntry("rab_onetap_speclist_gradient_one", "OT Spec List Gradient 1", 52, 63, 65, 255);
local gradientTwo = gui.ColorEntry("rab_onetap_speclist_gradient_two", "OT Spec List Gradient 2", 190, 205, 216, 255);

local function getSpectators()
    local spectators = {};
    local lp = entities.GetLocalPlayer();
    if lp ~= nil then
        local players = entities.FindByClass("CCSPlayer");
        local specI = 1;
        for i = 1, #players do
            local player = players[i];
            if player ~= lp and player:GetHealth() <= 0 then
                local name = player:GetName();
                if player:GetPropEntity("m_hObserverTarget") ~= nil then
                    local playerindex = player:GetIndex();
                    if name ~= "GOTV" and playerindex ~= 1 then
                        local target = player:GetPropEntity("m_hObserverTarget");
                        if target:IsPlayer() then
                            local targetindex = target:GetIndex();
                            local myindex = client.GetLocalPlayerIndex();
                            if lp:IsAlive() then
                                if targetindex == myindex then
                                    spectators[specI] = player;
                                    specI = specI + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return spectators;
end

local function drawRectFill(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(r, g, b, a);
    end
    draw.Color(r, g, b, a);
    draw.FilledRect(x, y, x + w, y + h);
end

local function drawGradientRectFill(col1, col2, x, y, w, h)
    drawRectFill(col1[1], col1[2], col1[3], col1[4], x, y, w, h);
    local r, g, b = col2[1], col2[2], col2[3];
    for i = 1, h do
        local a = i / h * col2[4];
        drawRectFill(r, g, b, a, x + 2, y + i, w - 2, 1);
    end
end

local function dragFeature()
    if input.IsButtonDown(1) then
        mouseX, mouseY = input.GetMousePos();
        if shouldDrag then
            x = mouseX - dx;
            y = mouseY - dy;
        end
        if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
            shouldDrag = true;
            dx = mouseX - x;
            dy = mouseY - y;
        end
    else
        shouldDrag = false;
    end
end

local function drawOutline(r, g, b, a, x, y, w, h, howMany)
    for i = 1, howMany do
        draw.Color(r, g, b, a);
        draw.OutlinedRect(x - i, y - i, x + w + i, y + h + i);
    end
end

--This draws the nice looking material window designed and developed by Rab
local function drawWindow(spectators)
    local h2 = 10 + (spectators * 15);
    local h = h + (spectators * 15);

    -- Draw small outline
    draw.Color(0, 0, 0, 255);
    draw.OutlinedRect(x - 6, y - 6, x + w + 6, y + h + 6);

    -- Draw big outline
    drawOutline(74, 65, 54, 200, x, y, w, h, 5);

    -- Draw the main bg
    drawRectFill(11, 11, 11, 150, x, y, w, h);


    -- Draw the text
    draw.Color(255, 255, 255);
    draw.SetFont(font_title);
    local spectext = 'spectators(' .. spectators .. ')';
    local tW, _ = draw.GetTextSize(spectext);
    draw.Text(x + ((w - tW) / 2), y + 5, spectext)

    -- draw the gradient divider
    drawGradientRectFill({ gradientOne:GetValue() }, { gradientTwo:GetValue() }, x + 5, y + 23, w - 10, 5, true)

    drawRectFill(27, 24, 25, 255, x + 7, y + 40, w - 14, h2);

    drawOutline(41, 35, 36, 255, x + 7, y + 40, w - 14, h2, 2);
end

local function drawSpectators(spectators)
    for index, player in pairs(spectators) do
        draw.SetFont(font_spec);
        draw.Color(255, 255, 255, 255);
        draw.Text(x + 15, (y + topbarSize + 5) + (index * 15), player:GetName())
    end
end

callbacks.Register("Draw", function()
    if input.IsButtonPressed(gui.GetValue("adv.menukey")) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    mainWindow:SetActive(menuPressed);
    if (enabled:GetValue() ~= true) then
        return
    end
    local spectators = getSpectators();
    if (#spectators == 0) then
        return
    end
    drawWindow(#spectators);
    drawSpectators(spectators);
    dragFeature();
end)