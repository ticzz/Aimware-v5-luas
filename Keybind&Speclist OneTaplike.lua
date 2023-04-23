local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    local function decodeB64(data)
        data = string.gsub(data, '[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
        end))
    end;

local base64 = {
        fontIcon = [[
	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
]]};
local FIcon = draw.AddFontResource(decodeB64(base64.fontIcon));
local FontIcon = draw.CreateFont("aimware_thekorol", 13)
local FontDefault = draw.CreateFont("Calibri Bold", 13)
local x,y = draw.GetScreenSize();

function gradientH(x1, y1, x2, y2,col1, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * 200
        local r, g, b = col1[1], col1[2], col1[3];
        draw.Color(r,g,b, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end
local function getKeybinds()
    local Keybinds = {};
    local i = 1;
    hLocalPlayer = entities.GetLocalPlayer();
    wid = hLocalPlayer:GetWeaponID()
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
    if gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then
    Keybinds[i] = 'Slowwalk';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.base.rotation") > 1 then
    Keybinds[i] = 'Anti-Aim Inverted';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
    Keybinds[i] = 'Fake Duck';
        i = i + 1;
    end
if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.condition.shiftonshot") then
    Keybinds[i] = 'Hideshots';
        i = i + 1;
    end
if gui.GetValue("esp.master") and gui.GetValue("esp.local.thirdperson") then
    Keybinds[i] = 'Thirdperson';
        i = i + 1;
    end
---------------------------
if gui.GetValue("misc.fakelatency.key") == 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
elseif gui.GetValue("misc.fakelatency.key") ~= 0 then
if gui.GetValue("misc.master") and gui.GetValue("misc.fakelatency.enable") and input.IsButtonDown(gui.GetValue("misc.fakelatency.key")) then
    Keybinds[i] = 'Fakelatency';
        i = i + 1;
    end
end
    return Keybinds;
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

local function drawkeybinds(Keybinds)
    for index in pairs(Keybinds) do
        draw.Color(255, 255, 255, 255);
		draw.SetFont(FontDefault);
        draw.Text(20,y/2 + (index * 15), Keybinds[index])
		draw.SetFont(FontIcon);
        draw.Text(3,y/2 + 3 + (index * 15), "{")    
    end
end

local function drawspectators(spectators)
    for index, players in pairs(spectators) do
	    draw.Color(255, 255, 255, 255);
		draw.SetFont(FontDefault);
        draw.Text(20,y/2 - 6 + (index * -15), players:GetName())
		draw.SetFont(FontIcon);
        draw.Text(3,y/2 - 3 + (index * -15), "}")  	
    end
end

callbacks.Register("Draw", function()
if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
    gradientH(0,y/2+6,150,y/2-6,{ 0,0,0,200 }, false);
    local Keybinds = getKeybinds();
    drawkeybinds(Keybinds);	
    local spectators = getspectators();
    drawspectators(spectators);
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

