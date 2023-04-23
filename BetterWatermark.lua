----原文地址https://aimware.net/forum/thread/143817

local widget = {
    new = function(x, y, width, height, canResize)
        local self = {
            x = x, y = y, width = width, height = height, canResize = canResize ~= nil and canResize, sizeMinX = 50, sizeMinY = 50, sizeMaxX = 300, sizeMaxY = 300,
            drawShadow = false, shadowRad = 2, sColor = {0, 0, 0, 120}, gColor = {255, 255, 255, 80}, rColor = {200, 200, 200, 80}, disableAnim = false,
            rSize = 20, rOutsideRad = 2, mouseDeltaX = 0, mouseDeltaY = 0, g = false, r = false, visible = true, disableXr = false, disableYr = false,
        };
        self.handler = function()
            
            local menuX, menuY = gui.Reference("Menu"):GetValue(); local mouseX, mouseY = input.GetMousePos(); local screenX, screenY = draw.GetScreenSize();
            if (input.IsButtonDown(1) and gui.Reference("Menu"):IsActive()) and (mouseX < menuX or mouseX > menuX or mouseY < menuY or mouseY > menuY  or self.g or self.r) then
                if self.canResize and input.IsButtonPressed(1) and mouseX >= self.x + self.width - self.rSize and mouseX <= self.x + self.width + self.rOutsideRad and mouseY >= self.y + self.height - self.rSize and mouseY <= self.y + self.height + self.rOutsideRad then
                    if self.r == false then
                        self.mouseXDelta, self.mouseYDelta = self.x + self.width - mouseX, self.y + self.height - mouseY;
                    end;
                    self.r = true;
                elseif input.IsButtonPressed(1) and mouseX >= self.x and mouseX <= self.x + self.width and mouseY >= self.y and mouseY <= self.y + self.height then
                    if self.g == false then
                        self.mouseDeltaX, self.mouseDeltaY = mouseX - self.x, mouseY - self.y;
                    end;
                    self.g = true;
                end;
                if self.g then -- move
                    if mouseX - self.mouseDeltaX >= 0 and mouseX - self.mouseDeltaX + self.width <= screenX then
                        self.x = mouseX - self.mouseDeltaX;
                    end;
                    if mouseY - self.mouseDeltaY >= 0 and mouseY - self.mouseDeltaY + self.height <= screenY then
                        self.y = mouseY - self.mouseDeltaY;
                    end;
                elseif self.r then -- resize
                  
                end;
                
            else
                self.g, self.r = false, false;
            end;
        end;
        return self;
    end,
};
local watermarkBase = widget.new(1580, 15, 280, 30);

callbacks.Register("Draw", function()
    watermarkBase.handler();
end);
local font = draw.CreateFont('Verdana', 12.5, 11.5);
local font2 = draw.CreateFont('Verdana', 13, 11.5);

local function splitString(inputstr, sep)
    local t = {};
    for str in string.gmatch(inputstr, "([^".. sep .."]+)") do
        table.insert(t, str);
    end;
    return t;
end;

local time, bTime, sTime = {0, 0, 0,}, 0, 0;
callbacks.Register("Draw", "getTime", function()
    -- 20分钟同步一次
    if sTime == 0 or ((sTime + 1200 < common.Time()) and (entities.GetLocalPlayer() == nil or not entities.GetLocalPlayer():IsAlive())) then
        local data = http.Get("time.is/Berlin",body);
        if data ~= nil then
            for i, str in pairs(splitString(string.match(data, [[<time id="clock">(.-)</time>]]), ":")) do
                time[i] = tonumber(str);
            end;
            sTime = common.Time();
        end;
        bTime = common.Time();
    end;
    time[3] = time[3] + common.Time() - bTime;
    bTime = common.Time();
    if time[3] >= 60 then
        time[2], time[3], bTime = time[2] + 1, 0, common.Time();
    end;
    if time[2] >= 60 then
        time[1], time[2] = time[1] + 1, 0;
    end;
    if time[1] >= 24 then
        time[1] = 0;
    end;

end);   

callbacks.Register("Draw", function()
    if (watermark:GetValue() ~= true) then
        return
    end
    local lp = entities.GetLocalPlayer();
    local playerResources = entities.GetPlayerResources();

    local divider = ' | ';
    local cheatName = '      ware ';
    --local cheatName2 = 'Aim';
	local indexlp = client.GetLocalPlayerIndex()
    local userName = client.GetPlayerNameByIndex(indexlp);

    local delay;
    local tick;
	local fps = 'fps: ';
    local  string =  string.format(" %s:%s:%s", time[1] < 10 and "0" .. math.floor(time[1]) or math.floor(time[1]), time[2] < 10 and "0" .. math.floor(time[2]) or math.floor(time[2]), time[3] < 10 and "0" .. math.floor(time[3]) or math.floor(time[3]));
 
local frame_rate = 0/10
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1 / frame_rate))
end
 
    if (lp ~= nil) then
        delay = 'delay: ' .. playerResources:GetPropInt("m_iPing", lp:GetIndex()) .. 'ms';
     
    end
    local watermarkText = cheatName .. divider .. fps .. divider;
    if (delay ~= nil) then
        watermarkText = watermarkText .. delay .. divider..string.. divider;
    end

    watermarkText = watermarkText .. fps;
    draw.SetFont(font);
    local w, h = draw.GetTextSize(watermarkText);
    local weightPadding, heightPadding = 30, 15;
    local watermarkWidth = weightPadding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermarkWidth - 20, start_y * 0.0225+30;
    draw.Color(gui.GetValue("qiskaiindicator.watermark.wbgCol"));
    draw.FilledRect(watermarkBase.x-30, watermarkBase.y, watermarkBase.x + watermarkWidth-1 , watermarkBase.y + h + heightPadding );
    draw.Color(gui.GetValue("qiskaiindicator.watermark.wtextCol"));
    draw.TextShadow(watermarkBase.x + weightPadding / 2-30, watermarkBase.y + heightPadding / 2 , watermarkText .. get_abs_fps()/10)
    draw.SetFont(font2);
    draw.Color(gui.GetValue("qiskaiindicator.watermark.wbgCol2"));
    draw.TextShadow(watermarkBase.x + weightPadding / 2-35, watermarkBase.y + heightPadding / 2-0.3 , "Aim")
    draw.Color(gui.GetValue("qiskaiindicator.watermark.wmainCol"));
	draw.FilledRect(watermarkBase.x-30, watermarkBase.y, watermarkBase.x + watermarkWidth , watermarkBase.y +1.5);
    draw.Color(gui.GetValue("qiskaiindicator.watermark.wmainCol"));
    draw.FilledRect(watermarkBase.x-30, watermarkBase.y, watermarkBase.x + watermarkWidth ,watermarkBase.y +1.5);

    
end)


------------------------------------------------------------
--DrawUI
------------------------------------------------------------
local qiskaiindicator = gui.Checkbox( gui.Reference("Misc", "General", "extra"), "qiskaiindicator", "aimware指示器", 1);
local qiskaiindicatorWindow = gui.Window("qiskaiindicator", "aimware指示器", 100, 300, 300, 200);
local function qiskaiindicator_Window()
    if(qiskaiindicator:GetValue() == true) then
        qiskaiindicatorWindow:SetActive(gui.Reference("MENU"):IsActive())
    end
    if(qiskaiindicator:GetValue() == false) then
        qiskaiindicatorWindow:SetActive(false)
    end
end
callbacks.Register('Draw', 'qiskaiindicator_Window', qiskaiindicator_Window);

local function DrawUI()
    watermark = gui.Checkbox(qiskaiindicatorWindow,"watermark","Show watermark",1);
    watermark:SetDescription(" Show skeet watermark.");
    wcolorPicker = gui.ColorPicker(watermark, "wmainCol", "Main Colour", 200,0,0,255)
    wcolorPicker2 = gui.ColorPicker(watermark, "wtextCol", "Text Colour", 255,255,255,255)
    wcolorPicker3 = gui.ColorPicker(watermark, "wbgCol", "Bg Colour", 0,0,0,100)
    wcolorPicker4 = gui.ColorPicker(watermark, "wbgCol2", "Bg Colour2",200,0,0,255)

end
DrawUI();
local keybindsBase = widget.new(475, 241, 200, 30);

callbacks.Register("Draw", function()
    keybindsBase.handler();
end);

local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 600, 300, 0, 0, 300, 60;
local shouldDrag = false
--local svgData = http.Get( "https://www.csgo.com.cn/data/images/competitive_mode/global.png" );
local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local font = draw.CreateFont("Verdana", 12.5, 11.5);
local topbarSize = 23;

local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
local render = {};

local renderoutline = render.outline
local renderrect = render.rect
local renderrect2 = render.rect2
local rendergradient = render.gradient

local renderoutline = function( x, y, w, h, col )
    draw.Color( gui.GetValue("qiskaiindicator.keybindlist.kmainCol") );
    draw.OutlinedRect( x, y, x + w, y + h );
end
local renderrect = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    
end
local renderrect2 = function( x, y, w, h )
    draw.FilledRect( x, y, x + w, y + h );
end
local rendergradient = function( x, y, w, h, col1, col2, is_vertical )
    renderrect( x, y, w, h, col1 );

    local r, g, b = col2[1], col2[2], col2[3];

    if is_vertical then
        for i = 1, h do
            local a = i / h * 255;
            renderrect( x, y + i, w, 1, { r, g, b, a } );
        end
    else
        for i = 1, w do
            local a = i / w * 255;
            renderrect( x + i, y, 1, h, { r, g, b, a } );
        end
    end
end

local function getKeybinds()
    local Keybinds = {};
    local i = 1;

    hLocalPlayer = entities.GetLocalPlayer();
    wid = hLocalPlayer:GetWeaponID()
---------------------------

if gui.GetValue("lbot.trg.key") == 0 then
if gui.GetValue("lbot.master") and gui.GetValue("lbot.trg.enable") then
    Keybinds[i] = 'Trigger';
        i = i + 1;
    end
elseif gui.GetValue("lbot.trg.key") ~= 0 then
if gui.GetValue("lbot.master") and gui.GetValue("lbot.trg.enable") and input.IsButtonDown(gui.GetValue("lbot.trg.key")) then
    Keybinds[i] = 'Trigger';
        i = i + 1;
    end
end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.antiaim.type") ~= '"Off"' then
    Keybinds[i] = 'Legit AA';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.posadj.backtrack") then
    Keybinds[i] = 'Backtrack';
        i = i + 1;
    end
if gui.GetValue("lbot.master") and gui.GetValue("lbot.semirage.silentaimbot") then
    Keybinds[i] = 'Silent aim';
        i = i + 1;
    end


---------------------------
if gui.GetValue("rbot.master") and (wid == 1 or wid == 64) and gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.hitscan.accuracy.smg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire") ~= 0 then
    Keybinds[i] = 'Doubletap';
        i = i + 1;
    end
    if gui.GetValue("rbot.master") and (wid == 1 or wid == 64) and gui.GetValue("rbot.hitscan.mode.hpistol.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.hitscan.mode.pistol.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
        elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.hitscan.mode.rifle.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.hitscan.mode.asniper.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.hitscan.mode.smg.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.hitscan.mode.lmg.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.hitscan.mode.shotgun.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 40) and gui.GetValue("rbot.hitscan.mode.scout.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;
    elseif gui.GetValue("rbot.master") and (wid == 9) and gui.GetValue("rbot.hitscan.mode.sniper.autowall")  then
        Keybinds[i] = 'Auto wall';
            i = i + 1;        
        end
if gui.GetValue("rbot.master") and  gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
    Keybinds[i] = 'Fake duck';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.condition.shiftonshot") then
    Keybinds[i] = 'Hide shots';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then
    Keybinds[i] = 'Slow walk';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.advanced.autodir.targets") then
    Keybinds[i] = 'At targets';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.advanced.autodir.edges") then
    Keybinds[i] = 'At edges';
        i = i + 1;
    end 
if gui.GetValue("rbot.master") and gui.GetValue("rbot.hitscan.mode.asniper.forcesafe") then
    Keybinds[i] = 'Force safe';
        i = i + 1;
    end 
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.base.rotation") <= -1 then
    Keybinds[i] = 'Invert';
        i = i + 1;
    end 

---------------------------
if gui.GetValue("misc.fakelatency.key") == 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") then
    Keybinds[i] = 'Fake latency';
        i = i + 1;
    end
elseif gui.GetValue("misc.fakelatency.key") ~= 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") and input.IsButtonDown(gui.GetValue("misc.fakelatency.key")) then
    Keybinds[i] = 'Fake latency';
        i = i + 1;
    end
end

if gui.GetValue("misc.fakelag.key") == 0 then
    if gui.GetValue("misc.master") and gui.GetValue("misc.fakelag.enable") then
        Keybinds[i] = 'Fake lag';
            i = i + 1;
        end
    elseif gui.GetValue("misc.fakelag.key") ~= 0 then
    if gui.GetValue("misc.master") and gui.GetValue("misc.fakelag.enable") and input.IsButtonDown(gui.GetValue("misc.fakelag.key")) then
        Keybinds[i] = 'Fake lag';
            i = i + 1;
        end
    end

    return Keybinds;
end

local function drawkeybinds(Keybinds)
    local temp = false;
    for index in pairs(Keybinds) do
        
        if (temp) then
            rendergradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(gui.GetValue("qiskaiindicator.keybindlist.ktextCol"));
        draw.TextShadow(keybindsBase.x + 12, (keybindsBase.y + topbarSize + 5) + (index * 15), Keybinds[index])
        draw.TextShadow(keybindsBase.x + 105, (keybindsBase.y + topbarSize + 5) + (index * 15), "[holding]")

    end
end



local function drawWindow(Keybinds)
    local tW, _ = draw.GetTextSize(keytext);
    local h2 = 5 + (Keybinds * 15);
    local h = h + (Keybinds * 15);

    draw.Color(gui.GetValue("qiskaiindicator.keybindlist.kmainCol"));
    draw.FilledRect( keybindsBase.x+ 5 ,keybindsBase.y+ 22,keybindsBase.x+155,keybindsBase.y+20);
    draw.FilledRect( keybindsBase.x+ 5 ,keybindsBase.y+ 22,keybindsBase.x+155,keybindsBase.y+21);
    
    draw.Color(gui.GetValue("qiskaiindicator.keybindlist.kbgCol"));
    draw.FilledRect(keybindsBase.x+ 5 ,keybindsBase.y+ 22,keybindsBase.x+155,keybindsBase.y+42);

    draw.Color(gui.GetValue("qiskaiindicator.keybindlist.ktextCol"));
    draw.SetFont(font);
    local keytext = 'keybinds';
    draw.TextShadow(keybindsBase.x + ((110 - tW) / 2), keybindsBase.y + 27, keytext)


  --  draw.Color(255, 255, 255);
  --  draw.SetTexture( texture );
 --   draw.FilledRect( keybindsBase.x+30,keybindsBase.y-13,keybindsBase.x+130, keybindsBase.y+ 19 );
 --   draw.SetTexture( texture );

end


------------------------------------------------------------
--DrawUI
------------------------------------------------------------

local function DrawUI()
local keybindlist = gui.Checkbox(qiskaiindicatorWindow,"keybindlist","Show Keybinds",1);
keybindlist:SetDescription("Shows a list of active keybinds.");
local kcolorPicker = gui.ColorPicker(keybindlist, "kmainCol", "Main Colour", 255,0,0,255)
local kcolorPicker2 = gui.ColorPicker(keybindlist, "ktextCol", "Text Colour", 255, 255, 255, 255)
local kcolorPicker3 = gui.ColorPicker(keybindlist, "kbgCol", "Bg Colour", 0,0,0,100) 

end
DrawUI();
local spectatorsBase = widget.new(625, 241, 190, 30);

callbacks.Register("Draw", function()
    spectatorsBase.handler();
end);



local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 750, 300, 0, 0, 300, 60;
local shouldDrag = false;
local font = draw.CreateFont("Verdana", 12.5, 11.5);
local topbarSize = 25;

local render = {};

local renderoutline = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    draw.OutlinedRect( x, y, x + w, y + h );
end
local renderrect = function( x, y, w, h, col )
    draw.Color( col[1], col[2], col[3], col[4] );
    --draw.FilledRect( x, y, x + w, y + h );
end
local renderrect2 = function( x, y, w, h )
    draw.FilledRect( x, y, x + w, y + h );
end
local rendergradient = function( x, y, w, h, col1, col2, is_vertical )
    renderrect( x, y, w, h, col1 );
    local r, g, b = col2[1], col2[2], col2[3];
    if is_vertical then
        for i = 1, h do
            local a = i / h * 255;
            renderrect( x, y + i, w, 1, { r, g, b, a } );
        end
    else
        for i = 1, w do
            local a = i / w * 255;
            renderrect( x + i, y, 1, h, { r, g, b, a } );
        end
    end
end

local function getspectators()
    local spectators = {};
    local lp = entities.GetLocalPlayer();
    if lp ~= nil then
      local players = entities.FindByClass("CCSPlayer");    
        for i = 1, #players do
            local players = players[i];
            if players ~= lp and players:GetHealth() <= 0 then
                local name = players:GetName();
                if players:GetPropEntity("m_hObserverTarget") ~= nil then
                    local playerindex = players:GetIndex();
                    if name ~= "GOTV" and playerindex ~= 1 then
                        local target = players:GetPropEntity("m_hObserverTarget");
                        if target:IsPlayer() then
                            local targetindex = target:GetIndex();
                            local myindex = client.GetLocalPlayerIndex();
                            if lp:IsAlive() then
                                if targetindex == myindex then
                                    
                                    table.insert(spectators, players)
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

local function drawspectators(spectators)
    local temp = false;
    for index, players in pairs(spectators) do
        
        if (temp) then
            rendergradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
            
        end
        temp=true;
        draw.SetFont(font);
        draw.Color(gui.GetValue("qiskaiindicator.speclist.stextCol"));--观众名字颜色
        draw.TextShadow(spectatorsBase.x + 5, (spectatorsBase.y + topbarSize + 7) + (index * 16), players:GetName())
        draw.TextShadow(spectatorsBase.x + 135, (spectatorsBase.y + topbarSize + 7) + (index * 16), "❥")
     --   draw.SetTexture( texture2 );
      --  draw.FilledRect(spectatorsBase.x +2,(spectatorsBase.y + topbarSize + 0)+ (index * 16),spectatorsBase.x + 29,(spectatorsBase.y + topbarSize + 0)+ (index * 16)+ 26)
     --   draw.Color(255, 255, 255);
     --   draw.SetTexture( texture );
      --  draw.FilledRect( spectatorsBase.x+30,spectatorsBase.y-10,spectatorsBase.x+130, spectatorsBase.y+ 21 );

        
    end
end



local function drawRectFillcol(r, g, b, a, x, y, w, h, texture)
    if (texture ~= nil) then
        draw.SetTexture(texture);
    else
        draw.SetTexture(texture);
    end
    draw.Color(gui.GetValue("qiskaiindicator.speclist.smainCol"));--背景颜色
    draw.FilledRect(x, y, x + w, y + h);
end


local function drawWindow(Keybinds)
    local tW, _ = draw.GetTextSize(keytext);
    local h2 = 5 + (Keybinds * 15);
    local h = h + (Keybinds * 15);
    draw.Color(gui.GetValue("qiskaiindicator.speclist.sbgCol"));
    draw.FilledRect(spectatorsBase.x+ 5 ,spectatorsBase.y+ 22,spectatorsBase.x+155,spectatorsBase.y+42);
    draw.Color(gui.GetValue("qiskaiindicator.speclist.smainCol"));
    draw.FilledRect( spectatorsBase.x+ 5 ,spectatorsBase.y+ 22,spectatorsBase.x+155,spectatorsBase.y+20);
    draw.FilledRect( spectatorsBase.x+ 5 ,spectatorsBase.y+ 22,spectatorsBase.x+155,spectatorsBase.y+21);

    draw.Color(gui.GetValue("qiskaiindicator.speclist.stextCol"));
    draw.SetFont(font);
    local keytext = 'spectators'; 
    draw.TextShadow(spectatorsBase.x + ((110 - tW) / 2), spectatorsBase.y + 26, keytext)

  
end


callbacks.Register("Draw", function()
    if speclist:GetValue() == false then return end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end


    local spectators = getspectators();
    drawWindow(#spectators);

    drawspectators(spectators);

end)

callbacks.Register("Draw", function()
    if keybindlist:GetValue() == false then return end
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    local Keybinds = getKeybinds();
    drawWindow(#Keybinds);

    drawkeybinds(Keybinds);

end)


------------------------------------------------------------
--DrawUI
------------------------------------------------------------
local function DrawUI()
speclist = gui.Checkbox(qiskaiindicatorWindow,"speclist","Show spectators",1);
speclist:SetDescription("Skeet show spectators.");
scolorPicker = gui.ColorPicker(speclist, "smainCol", "Main Colour", 255,0,0,255)
scolorPicker2 = gui.ColorPicker(speclist, "stextCol", "Text Colour", 255, 255, 255, 255)
scolorPicker3 = gui.ColorPicker(speclist, "sbgCol", "Bg Colour", 0,0,0,100) 
end
DrawUI();





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")