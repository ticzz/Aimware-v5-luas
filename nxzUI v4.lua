--[[


nxzUI v4.1 by naz.


nxzUI is a user interface lua for aimware.net intended for use with legit and rage cheating.
I update this lua whenever I can be bothered to work on it, so don't expect super frequent updates over a long period of time.
aimware still hasn't updated the docs which makes it kinda hard to make new features/ideas.

https://raw.githubusercontent.com/n4zzu/nxzUI/main/nxzUI.lua

]]--
--[[
local SCRIPT_FILE_NAME = GetScriptName()
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/n4zzu/nxzUI/main/nxzUI.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/n4zzu/nxzUI/main/version.txt"
local VERSION_NUMBER = "4.1"
local version_check_done = false
local update_downloaded = false
local update_available = false
local up_to_date = false
local updaterfont1 = draw.CreateFont("Bahnschrift", 18)
local updaterfont2 = draw.CreateFont("Bahnschrift", 14)
local updateframes = 0
local fadeout = 0
local spacing = 0
local fadein = 0

callbacks.Register( "Draw", "handleUpdates", function()
    if updateframes < 5.5 then
        if up_to_date or updateframes < 0.25 then
            updateframes = updateframes + globals.AbsoluteFrameTime()
            if updateframes > 5 then
                fadeout = ((updateframes - 5) * 510)
            end
            if updateframes > 0.1 and updateframes < 0.25 then
                fadein = (updateframes - 0.1) * 4500
            end
            if fadein < 0 then fadein = 0 end
            if fadein > 650 then fadein = 650 end
            if fadeout < 0 then fadeout = 0 end
            if fadeout > 255 then fadeout = 255 end
        end
        if updateframes >= 0.25 then fadein = 650 end
        for i = 0, 600 do
            local alpha = 200-i/3 - fadeout
            if alpha < 0 then alpha = 0 end
            draw.Color(15,15,15,alpha)
            draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30)
            draw.Color(239, 150, 255,alpha)
            draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31)
        end
        draw.SetFont(updaterfont1)
        draw.Color(239, 150, 255,255 - fadeout)
        draw.Text(7 - 650 + fadein, 7, "nxz")
        draw.Color(225,225,225,255 - fadeout)
        draw.Text(7 + draw.GetTextSize("nxz") - 650 + fadein, 7, "UI BETA ")
        draw.Color(239, 150, 255,255 - fadeout)
        draw.Text(7 + draw.GetTextSize("nxzUI BETA  ") - 650 + fadein, 7, "\\\\")
        spacing = draw.GetTextSize("nxzUI BETA \\    ")
        draw.SetFont(updaterfont2)
        draw.Color(225,225,225,255 - fadeout)
    end

    if (update_available and not update_downloaded) then
        draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false
        update_downloaded = true
    end
        
    if (update_downloaded) then
        draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.")
        return
    end
    
    if (not version_check_done) then
        version_check_done = true
        local version = http.Get(VERSION_FILE_ADDR)
        version = string.gsub(version, "\n", "")
        if (version ~= VERSION_NUMBER) then
            update_available = true
        else 
            up_to_date = true
        end
    end
        
    if up_to_date and updateframes < 5.5 then
        draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER)
    end
end)
]]

local Library_INSTALLED = false;
local Library_REWRITE = false;
file.Enumerate(function(filename)
    if filename == "Libraries/GraphicLib.lua" then
        Library_REWRITE = true;
        Library_INSTALLED = true;
    end;
end)
if not Library_INSTALLED or Library_REWRITE then
    local body = http.Get("https://raw.githubusercontent.com/BigGoosie/Meteor/main/Meteor.lua");
    file.Write("Libraries/GraphicLib.lua", body);
end
RunScript("Libraries/GraphicLib.lua");
-- Include the graphic lib

local font = draw.CreateFont('Verdana', 12)
local font2 = draw.CreateFont('Verdana', 16)
local settingsRef = gui.Reference("SETTINGS")
local miscRef = gui.Reference("MISC")
local miscTab = gui.Tab(miscRef, "miscTab", "nxzUI Misc")
local infoTab = gui.Tab(settingsRef, "infoTab", "nxzUI v4")
local rain_alpha = 0

local infoMainGroup = gui.Groupbox(infoTab, "Credits", 16,16,610,100)
local miscGroup = gui.Groupbox(miscTab, "Main Settings", 16,16,296,100)
local colorGroup = gui.Groupbox(visualTab, "Colours", 328,16,296,100)

local watermark = gui.Checkbox(mainGroup, "watermark", "Watermark", true)
local visualsRef = gui.Reference("VISUALS")
local visualTab = gui.Tab(visualsRef, "visualTab", "nxzUI Visuals")
local mainGroup = gui.Groupbox(visualTab, "Main Settings", 16,16,296,100)
local infolist = gui.Checkbox(mainGroup, "infolist", "pLocal Info", false)
local leftHandKnife = gui.Checkbox(mainGroup, "lefthandknife", "Left Hand Knife", false)
local sniperXHair = gui.Checkbox(mainGroup, "sniperxhair", "Sniper Crosshair", false)
local rainbowBar = gui.Checkbox(mainGroup, "rainbowBar", "Rainbow Bar", false)
local killEffect = gui.Checkbox(mainGroup, "killEffect", "Kill Effect", false)
local killEffectTime = gui.Slider(mainGroup, "killEffectTime", "Kill Effect Time", 3, 3, 10)
local ezfrags = gui.Checkbox(miscGroup, "ezfragsKS", "EZ Frags Kill Say", false)
local customKillSay = gui.Checkbox(miscGroup, "customKS", "Custom Killsay", false)
local ui_keybox = gui.Keybox(miscGroup, "edgeBug", "Edgebug", 0 )
local engineGrenadePred = gui.Checkbox(mainGroup, "grenPred", "Engine Grenade Prediction", false)
local customKSEditBox = gui.Editbox(miscGroup, "KSEditBox", "Custom Killsay")
local rainCheckBox = gui.Checkbox(mainGroup, "rainCheckBox", "Rain Effects", false)
local rainSpeed = gui.Slider(mainGroup, "rainSpeed", "Rain Speed", 700, 500, 2500)

local colorPickerBar1 = gui.ColorPicker(colorGroup, "mainCol1", "Main Colour", 251, 145, 255,255)
local colorPickerBar2 = gui.ColorPicker(colorGroup, "mainCol2", "Gradient", 52, 235, 232, 255)
local colorPickerBar = gui.ColorPicker(colorGroup, "mainRainCol", "Rain Colour",  255, 255, 255, rain_alpha - 75)

gui.Text(infoMainGroup, "nxzUI v4.1")
gui.Text(infoMainGroup, "-------------------------------------------------------------------------------------------------------------------")
gui.Text(infoMainGroup, "Made by naz#6660 (UID:71838)")
gui.Text(infoMainGroup, "nxzUI is a user interface lua for aimware.net intended for use with legit and rage cheating.")
gui.Text(infoMainGroup, "I update this lua whenever I can be bothered to work on it, so don't expect super frequent updates over a long     period of time.")
gui.Text(infoMainGroup, "aimware still hasn't updated the docs which makes it kinda hard to make new features/ideas.")
gui.Text(infoMainGroup, "-------------------------------------------------------------------------------------------------------------------")

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if not entities.GetLocalPlayer() then return end
	if not entities.GetLocalPlayer():IsAlive() then return end
    return math.floor(num * mult + 0.5) / mult
end

local function Getserver()
    if (engine.GetServerIP() == "loopback") then return "Local Server" 
    elseif (engine.GetServerIP() == nil) then return "Main Menu"
    else return engine.GetServerIP();        
    end
end
local function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local ScreenX, ScreenY = draw.GetScreenSize();
local SetX, SetY = false, false;

--[[WATERMARK START]]--
local WatermarkOUTLINE = Render.Rectangle:Create(0, 0, 100, 22);
local WatermarkBACKGROUND = Render.Rectangle:Create(0, 0, 100, 20);
local WatermarkSTRING = Render.String:Create(0, 0, "Something Went Really Wrong...");
local X, Y = 0, 0;

local function DrawWatermark() 
    local Localplayer, LocalplayerIndex, LocalplayerVALID = entities.GetLocalPlayer(), client.GetLocalPlayerIndex(), false;
    if (Localplayer ~= nil) then LocalplayerVALID = true; end

    local Latency = LocalplayerVALID and 
        tostring(entities.GetPlayerResources():GetPropInt("m_iPing", LocalplayerIndex)) 
        or "0";

    local Velocity = LocalplayerVALID and 
        Round(math.sqrt(Localplayer:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + Localplayer:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2), 0)
        or "0";

    local userName = "DEV"	--client.GetConVar( "name" )

    local String2Calc = "nxzUI v4.1 | " .. userName .. " | Velocity: " .. Velocity .. " | Server: " .. Getserver() .. " | Latency: " .. Latency;
    WatermarkSTRING.s = String2Calc;
    local StringSIZE = WatermarkSTRING:Size().width + 5;
    if (not SetX and not SetY) then
        X, Y = (ScreenX) - StringSIZE - 5, 5;
        SetX, SetY = true, true;
    end

    if (not WatermarkOUTLINE:IsClicked()) then 
        WatermarkOUTLINE.x = X - 1;
        WatermarkOUTLINE.y = Y - 1;
        WatermarkOUTLINE.w = StringSIZE + 1;
    
        WatermarkBACKGROUND.x = WatermarkOUTLINE.x + 1;
        WatermarkBACKGROUND.y = WatermarkOUTLINE.y + 1;
        WatermarkBACKGROUND.w = StringSIZE;
    
        WatermarkSTRING.x = WatermarkBACKGROUND.x + 2;
        WatermarkSTRING.y = WatermarkBACKGROUND.y + 5;
    else 
        X = WatermarkOUTLINE.x;
        Y = WatermarkOUTLINE.y;

        WatermarkBACKGROUND.x = WatermarkOUTLINE.x + 1;
        WatermarkBACKGROUND.y = WatermarkOUTLINE.y + 1;
        WatermarkBACKGROUND.w = StringSIZE;

        WatermarkSTRING.x = WatermarkBACKGROUND.x + 2;
        WatermarkSTRING.y = WatermarkBACKGROUND.y + 5;
    end

    local col1 = Color:New(gui.GetValue("esp.visualTab.mainCol1"));
    local col2 = Color:New(gui.GetValue("esp.visualTab.mainCol2"));
    if gui.GetValue("esp.visualTab.watermark") == true then
        WatermarkOUTLINE:Draw(5, { false --[[ Vertical or not ]] }, col1, col2);
        WatermarkBACKGROUND:Draw(1, { false --[[ No need for this but what ever ]] }, Color:New(15, 15, 15, 255));
        WatermarkSTRING:Draw(true, false); -- [[ Using no font / color will use the defaults... ]]
        WatermarkOUTLINE:HandleDrag(); -- Only need the drag for the gradient; due to it being the largest rectangle being drawn.
    else return
    end
end
--[[WATERMARK END]]--

--[[pLOCAL INFO START]]--
callbacks.Register("Draw", function()

    if not entities.GetLocalPlayer() then return end
    local localName = entities.GetLocalPlayer():GetName()
    local health = entities.GetLocalPlayer():GetHealth()
    local maxHealth = entities.GetLocalPlayer():GetMaxHealth()
    local whatTeam = entities.GetLocalPlayer():GetTeamNumber()
    local weaponInacc = entities.GetLocalPlayer():GetWeaponInaccuracy()

draw.SetFont(font2);

if whatTeam == 3 then
    pLocalTeam = "CT"
    elseif whatTeam == 2 then
    pLocalTeam = "T"
end

if infolist:GetValue() == true then
    local weaponInacc = entities.GetLocalPlayer():GetWeaponInaccuracy()
        if not entities.GetLocalPlayer() then return end
        if not entities.GetLocalPlayer():IsAlive() then return end
        
        inaccuracy = round(weaponInacc, 3) * 100;
        inaccuracy2 = 100 - inaccuracy;

        local LocalPlayer = entities.GetLocalPlayer()
        local WeaponID = LocalPlayer:GetWeaponID()
        local WeaponType = LocalPlayer:GetWeaponType()

            if inaccuracy <= 5 then
                inaccuracyText = "Accurate"
            elseif inaccuracy <= 15 then
                inaccuracyText = "Somewhat Accurate"
            elseif inaccuracy <= 30 then
                inaccuracyText = "Inaccurate"
            elseif inaccuracy >= 31 then
                inaccuracyText = "Very Inaccurate"
            end
draw.TextShadow(5, 600, "Name: " .. localName)
draw.TextShadow(5, 620, "Health: " .. health .. "/" .. maxHealth)
draw.TextShadow(5, 640, "Team: " .. pLocalTeam)
if WeaponType == 0 and WeaponID ~= 31 then return
else draw.TextShadow(5, 660, inaccuracyText .. " (" .. inaccuracy2 .. "% Accurate)")
end
elseif infolist:GetValue() == false then return end
end)
--[[pLOCAL INFO END]]--

--[[LEFT HAND KNIFE START]]--
callbacks.Register('Draw', function()
    if not entities.GetLocalPlayer() then return end
    
    if not leftHandKnife:GetValue() then
        client.Command('cl_righthand 1', true)
		return
	end

	local LocalPlayer = entities.GetLocalPlayer()

	local WeaponID = LocalPlayer:GetWeaponID()
	local WeaponType = LocalPlayer:GetWeaponType()

	if WeaponType == 0 and WeaponID ~= 31 then
		client.Command('cl_righthand 0', true)
	else
		client.Command('cl_righthand 1', true)
	end
end)
--[[LEFT HAND KNIFE END]]--

--[[MENU RESIZE START]]--
local menu = gui.Reference("MENU");
local opt_pos = false;
local bounds = false;
local show_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Show Boundaries", function()
    bounds = true
end )

local hide_bounds = gui.Button( gui.Reference( "Settings", "Advanced", "Manage Advanced Settings" ), "Hide Boundaries", function()
    bounds = false
end )

local function handle_dpi(dpi)
    local value = dpi
    if value == 1 then
        return 1
    elseif value == 0 then
        return 0.75
    elseif value == 2 then
        return 1.25
    elseif value == 3 then
        return 1.5
    elseif value == 4 then
        return 1.75
    elseif value == 5 then
        return 2
    elseif value == 6 then
        return 2.25
    elseif value == 7 then
        return 2.5
    elseif value == 8 then
        return 2.75 
    elseif value == 9 then
        return 3
    end
end

local function gay()
    if menu:IsActive() then
        local x, y = menu:GetValue()
        local mx, my = input.GetMousePos()
        local x2 = x + 800 * handle_dpi(gui.GetValue("adv.dpi"))
        local y2 = y + 600 * handle_dpi(gui.GetValue("adv.dpi"))
        local a = (bounds == true) and 255 or 0
        draw.Color(25, 255, 255, a)
        draw.OutlinedRect(x, y, x2, y2)
        draw.OutlinedRect(x2 + 5, y2 + 5, x2 - 20, y2 - 20)
        if input.IsButtonDown("Mouse1") then    
            if mx > x2-20 and mx < x2+5 and my > y2-20 and my < y2+5 then
                opt_pos = true;
            end
            if opt_pos == true then 
                local ops = (gui.GetValue("adv.dpi") == 0) and 0 or 1
                draw.Line( x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops), y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops), x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1), y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) )
                if mx > x + 800 * handle_dpi(gui.GetValue("adv.dpi") + 1) and my > y + 600 * handle_dpi(gui.GetValue("adv.dpi") + 1) then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") + 1)
                end
                if mx < x + 800 * handle_dpi(gui.GetValue("adv.dpi") - ops) and my < y + 600 * handle_dpi(gui.GetValue("adv.dpi") - ops) and gui.GetValue("adv.dpi") ~= 0 then
                    gui.SetValue("adv.dpi", gui.GetValue("adv.dpi") - 1)
                end
            end 
        else
            opt_pos = false;
        end
    end
end

callbacks.Register("Draw", gay)
--[[MENU RESIZE END]]--

--[[RAINBOW BAR START]]--

callbacks.Register('Draw', function()
    if rainbowBar:GetValue() == true then
        local screenSize = draw.GetScreenSize();
        local r = math.floor(math.sin(globals.RealTime() * 1) * 127 + 128);
        local g = math.floor(math.sin(globals.RealTime() * 1 + 2) * 127 + 128);
        local b = math.floor(math.sin(globals.RealTime() * 1 + 4) * 127 + 128);
    
        draw.Color(r, g, b, 255);
        draw.FilledRect(0, 0, screenSize, 2.5);
    end
end)
--[[RAINBOW BAR END]]--

--[[EZ FRAGS KILLSAY START]]--
local killsays = {
    [1] = "Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
   [2] = "Stop being a noob! Get good with www.EZfrags.co.uk",
   [3] = "I'm not using www.EZfrags.co.uk, you're just bad",
   [4] = "You just got owned by EZfrags, the #1 CS:GO cheat",
   [5] = "If I was cheating, I'd use www.EZfrags.co.uk",
   [6] = "Think you could do better? Not without www.EZfrags.co.uk",
}

function CHAT_KillSay( Event )
   if ezfrags:GetValue() == true then
   if ( Event:GetName() == 'player_death' ) then
       
       local ME = client.GetLocalPlayerIndex();
       
       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );
       
       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
       
       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
       
       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
       
               local response = tostring(killsays[math.random(#killsays)]);
               response = response:gsub("name", NAME_Victim);
               client.ChatSay( ' ' .. response );
       else
        return;
       end
       
       end
   
   end
end

client.AllowListener( 'player_death' );

callbacks.Register('FireGameEvent', 'AWKS', CHAT_KillSay);
--[[EZ FRAGS KILLSAY END]]--

--[[CUSTOM KILLSAY START]]--
function CHAT_customKillSay( Event )
    if customKillSay:GetValue() == true then
    if ( Event:GetName() == 'player_death' ) then
        
        local ME = client.GetLocalPlayerIndex();
        
        local INT_UID = Event:GetInt( 'userid' );
        local INT_ATTACKER = Event:GetInt( 'attacker' );
        
        local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
        local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
        
        local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
        local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
        
        if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
        
                local response = tostring(killsays[math.random(#killsays)]);
                response = response:gsub("name", NAME_Victim);
                client.ChatSay(gui.GetValue("misc.miscTab.KSEditBox"));
        else
         return;
        end
        
        end
    
    end
 end

client.AllowListener( 'player_death' );

callbacks.Register('FireGameEvent', 'AWKS', CHAT_customKillSay);
--[[CUSTOM KILLSAY END]]--

--[[KILL EFFECT START]]--
function Kill_Effect( Event )
    if killEffect:GetValue() == true then
        if ( Event:GetName() == 'player_death' ) then
            local ME = client.GetLocalPlayerIndex();

            local INT_UID = Event:GetInt( 'userid' );
            local INT_ATTACKER = Event:GetInt( 'attacker' );

            local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
            local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

            if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
                entities.GetLocalPlayer():SetPropFloat(globals.CurTime() + (gui.GetValue( "esp.visualTab.killEffectTime" ) * 0.1), "m_flHealthShotBoostExpirationTime");
            else
                return;
            end
        end
    end
end

client.AllowListener( 'player_death' );

callbacks.Register('FireGameEvent', 'AWKS', Kill_Effect);
--[[KILL EFFECT END]]--

--[[SNIPER CROSSHAIR START]]--
callbacks.Register('Draw', function()
    if sniperXHair:GetValue() then 
        client.SetConVar( "weapon_debug_spread_show", 3, true )
    else
        client.SetConVar( "weapon_debug_spread_show", 0, true )
    end
     
end)
--[[SNIPER CROSSHAIR END]]--

--[[RAIN START]]--
local rain_alpha = 0

local background_alpha = 0
local rain = {}
local time = 0
local stored_time = 0
local screen = {draw.GetScreenSize()}

local function clamp(min, max, val)
    if val > max then return max end
    if val < min then return min end
    return val
end

local function draw_rain(x, y, size)
    local base = 4 + size
    draw.Color(gui.GetValue("esp.visualTab.mainRainCol"))
    draw.Line(x, y - base, x, y + base + 1)
end

local function drawRain()
    if gui.GetValue("esp.visualTab.rainCheckBox") == true then
        local frametime = globals.FrameTime()
        time = time + frametime

        if background_alpha ~= 255 then
            background_alpha = clamp(0, 255, background_alpha + 10)
            rain_alpha = clamp(0, 255, rain_alpha + 10)
        end

        if not background_alpha ~= 0 then
            background_alpha = clamp(0, 255, background_alpha - 10)
            rain_alpha = clamp(0, 255, rain_alpha - 10)
        end

        if #rain < 128 then
            if time > stored_time then
                stored_time = time

                table.insert(rain, {
                    math.random(10, screen[1] - 10),
                    1,
                    math.random(1, 3),
                    math.random(-60, 60) / 100,
                    math.random(-3, 0)
                })
            end
        end

        local fps = 1 / frametime

        for i = 1, #rain do
            local rain = rain[i]
            local x, y, vspeed, hspeed, size = rain[1], rain[2], rain[3], rain[4], rain[5]

            if screen[2] <= y then
                rain[1] = math.random(10, screen[1] - 10)
                rain[2] = 1
                rain[3] = math.random(1, 3)
                rain[4] = math.random(-60, 60) / 100
                rain[5] = math.random(-3, 0)
            end

            draw_rain(x, y, size)

            rain[2] = rain[2] + vspeed / fps * gui.GetValue("esp.visualTab.rainSpeed")
            rain[1] = rain[1] + hspeed / fps * gui.GetValue("esp.visualTab.rainSpeed")
        end
    else return
    end
    
end
--[[RAIN END]]--

--[[GRENADE PRED START]]--
local function engineNadePred()
    if gui.GetValue("esp.visualTab.grenPred") == true then
        if gui.GetValue("esp.world.nadetracer.local") == true then
            gui.SetValue("esp.world.nadetracer.local", 0)
            client.SetConVar("cl_grenadepreview", 1, 1)
        else
            client.SetConVar("cl_grenadepreview", 1, 1)
        end
    else
        client.SetConVar("cl_grenadepreview", 0, 1)
    end
end
--[[GRENADE PRED END]]--

--[[EDGEBUG START]]--
local function get_local_player( )
    local player = entities.GetLocalPlayer( )
    if player == nil then return end
    if ( not player:IsAlive( ) ) then
    player = player:GetPropEntity( "m_hObserverTarget" )
    end
    return player
   end
   
   local function EDGEBUG_CREATEMOVE( UserCmd )
    local flags = get_local_player():GetPropInt( "m_fFlags" )
    if flags == nil then return end
       local onground = bit.band(flags, 1) ~= 0
    if ui_keybox:GetValue() == 0 then return end
    if onground and input.IsButtonDown( ui_keybox:GetValue( ) ) then 
    UserCmd:SetButtons( 4 )
    return 
       end
    end
--[[EDGEBUG END]]--

callbacks.Register("CreateMove", EDGEBUG_CREATEMOVE)
callbacks.Register("Draw", engineNadePred)
callbacks.Register("FireGameEvent", "nadePredict", engineNadePred)
callbacks.Register("Draw", drawRain)
callbacks.Register("Draw", DrawWatermark);
callbacks.Register("Draw", function() killEffectTime:SetInvisible(killEffect:GetValue() == false) end)
callbacks.Register("Draw", function() rainSpeed:SetInvisible(rainCheckBox:GetValue() == false) end)
callbacks.Register("Draw", function() customKSEditBox:SetInvisible(customKillSay:GetValue() == false) end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

