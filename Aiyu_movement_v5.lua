
local draw_Line, draw_TextShadow, draw_Color, draw_Text, g_tickinterval, string_format, http_Get, file_Open, math_random, math_exp, math_rad, math_max, math_abs, math_tan, math_sin, math_cos, math_fmod, draw_GetTextSize, draw_FilledRect, draw_RoundedRect, draw_RoundedRectFill, draw_CreateFont, draw_SetFont, client_WorldToScreen, draw_GetScreenSize, client_GetConVar, client_SetConVar, client_exec, PlayerNameByUserID, PlayerIndexByUserID, entities_GetByIndex, GetLocalPlayer, gui_SetValue, gui_GetValue, LocalPlayerIndex, c_AllowListener, cb_Register, g_tickcount, g_realtime, g_curtime, g_absoluteframetime, g_maxclients, math_floor, math_ceil, math_sqrt, GetPlayerResources, entities_FindByClass, IsButtonPressed, IsButtonDown, client_ChatSay, vector_Distance, draw_OutlinedCircle, table_concat = draw.Line, draw.TextShadow, draw.Color, draw.Text, globals.TickInterval, string.format, http.Get, file.Open, math.random, math.exp, math.rad, math.max, math.abs, math.tan, math.sin, math.cos, math.fmod, draw.GetTextSize, draw.FilledRect, draw.RoundedRect, draw.RoundedRectFill, draw.CreateFont, draw.SetFont, client.WorldToScreen, draw.GetScreenSize, client.GetConVar, client.SetConVar, client.Command, client.GetPlayerNameByUserID, client.GetPlayerIndexByUserID, entities.GetByIndex, entities.GetLocalPlayer, gui.SetValue, gui.GetValue, client.GetLocalPlayerIndex, client.AllowListener, callbacks.Register, globals.TickCount, globals.RealTime, globals.CurTime, globals.AbsoluteFrameTime, globals.MaxClients, math.floor, math.ceil, math.sqrt, entities.GetPlayerResources, entities.FindByClass, input.IsButtonPressed, input.IsButtonDown, client.ChatSay, vector.Distance, draw.OutlinedCircle, table.concat
------------- Listeners
local listeners = {'round_end','round_freeze_end','round_prestart','round_start','bomb_beginplant','bomb_abortplant','bomb_planted','bomb_defused','bomb_exploded','bomb_begindefuse','bomb_abortdefuse','round_officially_ended','player_spawn','player_hurt','player_death','player_connect_full','smokegrenade_detonate','molotov_detonate','inferno_startburn','inferno_expire','inferno_extinguish','grenade_thrown','bullet_impact'}
-- draw UI
local windowW, windowH = 700, 750;
local mainWindow = gui.Window("aiyu_movement_menu", "aiyu movement menu fixed for V5 by ahh/sjors#7911", 100, 200, windowW - 60, windowH);
local settingsGroup = gui.Groupbox(mainWindow, "Movement", 13, 13, windowW - 500, windowH - 200);
local miscGroup = gui.Groupbox(mainWindow, "Misc", 13, 340, windowW - 500, windowH - 255);
local indicatorsGroup = gui.Groupbox(mainWindow, "Draw", 220, 13, windowW - 500, windowH - 200);
--local Edgegroup = gui.Groupbox(mainWindow, "EdgeBug Lineup Helper", 220, 220, windowW - 500, windowH - 254);

local VelocityGroup = gui.Groupbox(mainWindow, "Velocity Graph", 428, 13, windowW - 500, windowH - 47);
local ljbind = gui.Checkbox(settingsGroup, "lj_bind", "lj bind on edgejump", false);
local ljbindforward = gui.Checkbox(settingsGroup, "lj_bind_forward", "lj bind -forward", false);
local ljbindbackward = gui.Checkbox(settingsGroup, "lj_bind_backward", "lj bind -back", false);
local ljbindmoveleft = gui.Checkbox(settingsGroup, "lj_bind_left", "lj bind -moveleft", false);
local ljbindmoveright = gui.Checkbox(settingsGroup, "lj_bind_right", "lj bind -moveright", false);
local edgebug = gui.Checkbox(settingsGroup, "eb_lol", "Edgebug", false);
local ebbind = gui.Keybox(settingsGroup,"eb_bind","Edgebug Keybind",0x06)

local ljbindstatus = gui.Checkbox(indicatorsGroup, "lj_bind_status", "lj bind status", false);
local jbstatus = gui.Checkbox(indicatorsGroup, "jb_status", "jb status", false);
local edgebugstatus = gui.Checkbox(indicatorsGroup, "eb_status", "edgebug status", false);
local autostrafestatus = gui.Checkbox(indicatorsGroup, "autostrafe_status", "autostrafe status", false);
local jumpstatus = gui.Checkbox(indicatorsGroup, "jump_status", "jump status", false);

local lowHPIndicator = gui.Checkbox(indicatorsGroup, "low_hp", "enemy low hp indicator", false);
local beams = gui.Checkbox(miscGroup, "beams_enable", "player trail", false);
local coolzeusbug = gui.Checkbox(miscGroup, "zeus_bug", "zeus lightning shot", false);
local wasdIndicator = gui.Checkbox(indicatorsGroup, "wasd_enable", "wasd indicator", false);
local TeamDamageShow = gui.Checkbox(indicatorsGroup, "msc_showteamdmg", "Show Team Damage", false)

local enableVelGraph = gui.Checkbox(VelocityGroup, "aiyu_velocity_graph_enabled", "Enable", false);
local uiSpeed = gui.Checkbox(VelocityGroup, "aiyu_velocity_graph_speed_indicator", "Enable Speed Indicator", false);
local uiGraph = gui.Checkbox(VelocityGroup, "aiyu_velocity_graph_graph_ui", "Enable Graph UI", false);
--local uiGraphJumps = gui.Checkbox(VelocityGroup, "aiyu_velocity_graph_ui_jumps", "Enable Graph UI Jumps", false);
local uiGraphWidth = gui.Slider(VelocityGroup, "aiyu_velocity_graph__ui_width", "Speed graph width", 250, 1, 700);
local uiGraphMaxY = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_maxy", "Speed graph max speed", 400, 1, 5000);
local uiGraphCompression = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_compress", "Speed graph compression", 3, 1, 15);
local uiGraphFreq = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_freq", "Speed graph delay", 0, 0, 150);
local uiGraphSpread = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_spread", "Speed graph spread", 1, 1, 50);
local uiGraphColorType = gui.Combobox(VelocityGroup, "aiyu_velocity_graph_ui_colortype", "Spread Graph Color Type", "Static", "Gradient Chroma", "Static Chroma");
local uiGraphColorRed = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_red", "Red", 255, 0, 255);
local uiGraphColorGreen = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_green", "Green", 255, 0, 255);
local uiGraphColorBlue = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_blue", "Blue", 255, 0, 255);
local uiGraphStaticChromaSpeed = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_static_chroma_speed", "Static Chroma Speed", 1, 1, 10);
local uiGraphAlpha = gui.Slider(VelocityGroup, "aiyu_velocity_graph_ui_alpha", "Speed graph alpha", 255, 0, 255);

local main_font = draw.CreateFont("Verdana Bold", 28);
local font_small = draw.CreateFont("Verdana Bold", 14);
local superSpoopyIndeed = 0;

--[[
    aiyu's creates like 10 createmove hooks, which is retarded so we do it all in one!!

    also the way he does stuff is retarded, like: he draws over his indicators??

    fix/remake by sjors#7911 / ahh on forums

    also aiyu pasted alot of features, not my problem!
]]

--pasted low hp indicator!
local GetLocalPlayer,draw_GetScreenSize,string_format,draw_SetFont,draw_GetTextSize,draw_Color,draw_Text,entities_FindByClass,pos=entities.GetLocalPlayer,draw.GetScreenSize,string.format,draw.SetFont,draw.GetTextSize,draw.Color,draw.Text,entities.FindByClass,0
local hp_max = 5
local function drawLowHP()
	if not lowHPIndicator:GetValue() then
		return
	end

	local _,y = draw_GetScreenSize()
	local y_half, pos = y/2, 0
	local players = entities_FindByClass('CCSPlayer')

	for i=1, #players do
		local player = players[i]
		local is_enemy = player:GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber()

		if is_enemy and player:IsAlive() then
			local playername, hp, location = player:GetName(), player:GetPropInt('m_iHealth'), player:GetPropString('m_szLastPlaceName')

			if location == 'unknown' then
				location = 'Nearby'
			end

			local str = string_format('%s - %s (%i HP)', location, playername, hp)
			local low = hp <= hp_max

			draw_SetFont(main_font)
			local _,tH = draw_GetTextSize(str)

			if low then
				draw_Color(255, 255, 255, 255)
				draw_Text(20, y_half + 400+ pos, str)
				pos = pos + tH*1.5
			end
		end
	end
end

local graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
local lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
local graphHistory = {};
local font_small = draw.CreateFont("Verdana Bold", 12);

local function round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end

-- Gets prop float
local function getPropFloat(lp, wat)
    return lp:GetPropFloat("localdata", wat)
end

local function colour(dist)
    if dist >= 235 then
        return { 255, 137, 34 }
    elseif dist >= 230 then
        return { 255, 33, 33 }
    elseif dist >= 227 then
        return { 57, 204, 96 }
    elseif dist >= 225 then
        return { 91, 225, 255 }
    else
        return { 170, 170, 170 }
    end
end


function HUEtoRGB(h)
    local z = math.floor(h / 60)
    local hi = z % 6;
    local f = h / 60 - z;

    local r = hi == 0 and 1
            or hi == 1 and (1 - f)
            or hi == 2 and 0
            or hi == 3 and 0
            or hi == 4 and 1 - (1 - f)
            or hi == 5 and 1
            or 0;

    local g = hi == 0 and 1 - (1 - f)
            or hi == 1 and 1
            or hi == 2 and 1
            or hi == 3 and 1 - f
            or hi == 4 and 0
            or hi == 5 and 0
            or 0;

    local b = hi == 0 and 0
            or hi == 1 and 0
            or hi == 2 and 1 - (1 - f)
            or hi == 3 and 1
            or hi == 4 and 1
            or hi == 5 and 1 - f
            or 0;

    return r * 255, g * 255, b * 255;
end
local function getFadeRGB(rgbSpeed)
    local r = math.floor(math.sin(globals.RealTime() * rgbSpeed) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * rgbSpeed + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * rgbSpeed + 4) * 127 + 128)
    return r, g, b;
end
-- idc not pasting
function drawGraph(velocity, x, y, tickCount)
    local alpha, width, compress, spread = uiGraphAlpha:GetValue(), uiGraphWidth:GetValue(), uiGraphCompression:GetValue(), uiGraphSpread:GetValue();
    x = x - (width / 2)
    if ((lastGraph + uiGraphFreq:GetValue()) < tickCount) then
        local temp = {  };
        temp.velocity = math.min(velocity, uiGraphMaxY:GetValue());
        if (graphJump) then
            graphJump, temp.jump, temp.speed, temp.jumpPos = false, true, speed, jumpPos;
        end
        if (graphLand) then
            graphLand, temp.landed, temp.landPos = false, true, landPos
        end
        table.insert(graphHistory, temp)
        lastGraph = tickCount
    end
    local over = #graphHistory - (width / spread);
    if (over > 0) then
        table.remove(graphHistory, 1)
    end
    for i = 2, #graphHistory, 1 do
        local curVelocity, prevVelocity = graphHistory[i].velocity, graphHistory[i - 1].velocity;
        local curX, prevX = x + (i * spread), x + ((i - 1) * spread);
        local curY, prevY = y - (curVelocity / compress), y - (prevVelocity / compress);
        --[[
        if (uiGraphJumps:GetValue()) then
            if graphHistory[i].jump then
                local index
                for q = i + 1, #graphHistory, 1 do
                    if (graphHistory[q].jump or graphHistory[q].landed) then
                        index = q
                        break
                    end
                end
                if (index) then
                    if graphHistory[index].landPos and graphHistory[index].landPos[1] then
                        local jSpeed = graphHistory[i].speed
                        local lSpeed = graphHistory[index].velocity
                        local speedGain = lSpeed - jSpeed
                        if speedGain > -100 then
                            local jPos = graphHistory[i].jumpPos
                            local lPos = graphHistory[index].landPos
                            local dist = math.sqrt((math.abs(lPos[1] - jPos[1]) ^ 2.0) + (math.abs(lPos[2] - jPos[2]) ^ 2.0)) + 32
                            if dist > 150 then
                                local jumpX = curX - 1
                                local jumpY = curY
                                local landX = x + (index * spread)
                                local landY = y - (graphHistory[index].velocity / compress)
                                local topY = landY - 13
                                if topY > jumpY or topY > jumpY - 13 then
                                    topY = jumpY - 13
                                end

								draw.Color(30, 255, 109, alpha)
                                draw.Line(jumpX, jumpY, jumpX, topY)
								draw.Color(255, 119, 119, alpha)
                                draw.Line(landX, topY, landX, landY)

                                local text = speedGain > 0 and "+" or ""
                                text = text .. speedGain;
                                local middleX = (jumpX + landX) / 2
                                draw.SetFont(font_small);
                                draw.Color(255, 255, 255, alpha)
                                draw.Text(middleX - 10, topY - 18, text)
                                local ljColour = colour(dist)
                                draw.SetFont(font_small);
                                draw.Color(ljColour[1], ljColour[2], ljColour[3], alpha)
                                draw.Text(middleX - 12 , topY - 8, "(" .. math.floor(dist+0.5) .. ")") -- fixed to round to whole number

                                local ljColour = colour(dist)
                                draw.Color(ljColour[1], ljColour[2], ljColour[3], alpha)
                                fuck = round(dist, 2) .. " units ".. "[" .. text .. " vert]" --round to 2 decimal place

                                if speedGain == 0  then
                                    fuck = "       " .. round(dist, 2) .. " units ", 255 -- roudn to 2 num
                                end
                            end
                        end
                    end
                end
            end
        end]]
							
        local colorType = uiGraphColorType:GetValue();
        local r, g, b = uiGraphColorRed:GetValue(), uiGraphColorGreen:GetValue(), uiGraphColorBlue:GetValue();
        if (colorType == 1) then
            r, g, b = HUEtoRGB((i) - superSpoopyIndeed);
        elseif (colorType == 2) then
            r, g, b = getFadeRGB(uiGraphStaticChromaSpeed:GetValue());
        end
        draw.Color(r, g, b, alpha)
        draw.Line(prevX, prevY, curX, curY)
    end
    superSpoopyIndeed = superSpoopyIndeed + 1;
    if (superSpoopyIndeed == 360) then
        superSpoopyIndeed = 0;
    end
end

local function lightning(Event)
	if coolzeusbug:GetValue() then
        if (Event and Event:GetName() == 'player_death') then
            local ME = client.GetLocalPlayerIndex();
            
            local INT_UID = Event:GetInt( 'userid' );
            local INT_ATTACKER = Event:GetInt( 'attacker' );
            
            local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
            local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
            
            local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
            local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
            
            if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
                client.Command("use weapon_taser", true);
            end
        end
    end
end

client.AllowListener('player_death');
callbacks.Register('FireGameEvent','lightning',lightning);

local TickCountValue = 64 * 2;
local DataItems = { };
local LastTickCount = globals.TickCount();

local function GetFadeRGB(Factor, Speed)
    local r = math.floor(math.sin(Factor * Speed) * 127 + 128)
    local g = math.floor(math.sin(Factor * Speed + 2) * 127 + 128)
    local b = math.floor(math.sin(Factor * Speed + 4) * 127 + 128)
    return r, g, b;
end

local function MotionTrajectory()
	if beams:GetValue() then
        local LocalPlayer = entities.GetLocalPlayer();
        if (LocalPlayer == nil or LocalPlayer:IsAlive() ~= true) then
            DataItems = { };
            return;
        end
        
        ScreenX, ScreenY = draw.GetScreenSize();
        
        for i = 1, #DataItems do
            local ItemCurrent = DataItems[i];
            local ItemNext = DataItems[i + 1];
            
            if (ItemCurrent ~= nil and ItemNext ~= nil) then
                local CPosX, CPosY = client.WorldToScreen(ItemCurrent.x, ItemCurrent.y, ItemCurrent.z);
                local NPosX, NPosY = client.WorldToScreen(ItemNext.x, ItemNext.y, ItemNext.z);

                if (CPosX ~= nil and CPosY ~= nil and NPosX ~= nil and NPosY ~= nil and CPosX < ScreenX and CPosY < ScreenY and NPosX < ScreenX and NPosY < ScreenY) then
                    local ColorR, ColorG, ColorB = GetFadeRGB(i / 10, 1);
                    draw.Color(255, 255, 255, 100);
                    draw.Line(CPosX, CPosY, NPosX, NPosY);
                    draw.Line(CPosX + 1, CPosY + 1, NPosX + 1, NPosY + 1);
                end
            end
        end
        
        local CurrentTickCount = globals.TickCount();
        if (CurrentTickCount - LastTickCount < 1) then
            return;
        elseif (CurrentTickCount < LastTickCount) then
            LastTickCount = 0;
        end
        
        LastTickCount = CurrentTickCount;

        local LocX, LocY, LocZ = LocalPlayer:GetAbsOrigin();
        local ItemData = { x = LocX, y = LocY, z = LocZ };

        table.insert(DataItems, 1, ItemData);
        if (#DataItems == TickCountValue + 1) then
            table.remove(DataItems, TickCountValue + 1);
        end
    end
end

local function EDGEBUG_CREATEMOVE(UserCmd,lp)
    local flags = lp:GetPropInt("m_fFlags")
    if flags == nil and edgebug:GetValue() then 
        return 
    end
    local onground = bit.band(flags, 1) ~= 0
    if ebbind:GetValue() == 0 then 
        return 
    end
    if onground and input.IsButtonDown(ebbind:GetValue()) then 
        UserCmd:SetButtons(4)
        return 
    end
end-- edgebug ebbind

callbacks.Register("CreateMove", function(cmd)
    --binds
    local edgejump = gui.GetValue("misc.edgejump");

    local lp = entities.GetLocalPlayer()

    EDGEBUG_CREATEMOVE(cmd,lp)

    --longjump on edgejump
    if ljbind:GetValue() and edgejump ~= 0 then
        local flags = lp:GetPropInt("m_fFlags")
        if edgejump ~= 0 and flags and flags == 256 and input.IsButtonDown(edgejump) then
            cmd:SetButtons(86)
            if (ljbindforward:GetValue() ~= false) then
				client.Command("-forward", true)
			end	
			if (ljbindbackward:GetValue() ~= false) then
				client.Command("-back", true)
			end
			if (ljbindmoveright:GetValue() ~= false) then
				client.Command("-moveright", true)
			end
			if (ljbindmoveleft:GetValue() ~= false) then
				client.Command("-moveleft", true)
			end
        end
    end
end)

callbacks.Register("Draw",function()
    mainWindow:SetActive(gui.Reference("Menu"):IsActive())
    local lp = entities.GetLocalPlayer()
    if lp == nil then
        if enableVelGraph:GetValue() then
            graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
            lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
            graphHistory = {};
        end
        return
    end

    drawLowHP()
    lightning()
    MotionTrajectory()

    local jumpbug = gui.GetValue("misc.autojumpbug");
    local edgejump = gui.GetValue("misc.edgejump");
    local ebbint = ebbind:GetValue()
    local counter = 960

    local flags = lp:GetPropInt("m_fFlags")
    --edgebug indicator
    if edgebug:GetValue() and edgebugstatus:GetValue() then
        if flags and ebbint ~= 0 and input.IsButtonDown(ebbint) then
            draw.SetFont(main_font)
            draw.Color(255, 119, 119)
            if flags == 256 then
                draw.Color(255, 255, 255, 255)
            end
            draw.Text(950, counter, "eb")
            counter = counter + 25
        end
    end
    --jumpbug indicator
    if jbstatus:GetValue() then
        if flags and jumpbug ~= 0 and input.IsButtonDown(jumpbug) then
            draw.SetFont(main_font)
            draw.Color(255, 119, 119)
            if flags == 256 then
                draw.Color(255, 255, 255, 255)
            end
            draw.Text(953, counter, "jb")
            counter = counter + 25
        end
    end
    --longjump indicator
    if ljbindstatus:GetValue() and edgejump ~= 0 then
        if flags and edgejump ~= 0 and input.IsButtonDown(edgejump) then
            draw.SetFont(main_font)
            draw.Color(255, 255, 255, 255)
            if flags == 256 then
                draw.Color(30, 255, 10)
            end
            draw.Text(955, counter, "lj")
            counter = counter + 25
        end
    end
    --jump indicator
    if jumpstatus:GetValue() then
        draw.SetFont(main_font)
        if input.IsButtonDown(32) then
            draw.Color(255, 255, 255, 255)
            draw.Text(1800, 500, "JUMP")
        end
    end
    --autostrafe indicator
    if autostrafestatus:GetValue() then
        draw.SetFont(main_font)
        if gui.GetValue("misc.strafe.air") and gui.GetValue("misc.strafe") then
            draw.Color(255, 255, 255, 255)
            draw.Text(890, 200, "autostrafing")
        end
    end
    --WASD indicator
    if wasdIndicator:GetValue() then
        draw.SetFont(main_font)
        if input.IsButtonDown(87) then
            draw.Color(255, 255, 255, 255)
            draw.Text(130, 580, "W") 
        else 
            draw.Color(255, 255, 255, 100)
            draw.Text(136, 580, "_") 
            draw.Color(255, 255, 255, 255)
        end

        if input.IsButtonDown(83) then
            draw.Color(255, 255, 255, 255)
            draw.Text(136, 610, "S") 
        else
            draw.Color(255, 255, 255, 100)
            draw.Text(136, 610, "_") 
        end

        if input.IsButtonDown(65) then
            draw.Color(255, 255, 255, 255)
            draw.Text(97, 610, "A") 
        else
            draw.Color(255, 255, 255, 100)
            draw.Text(97, 610, "_") 
        end

        if input.IsButtonDown(68) then
            draw.Color(255, 255, 255, 255)
            draw.Text(175, 610, "D") 
        else
            draw.Color(255, 255, 255, 100)
            draw.Text(175, 610, "_") 
        end

        if input.IsButtonDown(32) then
            draw.Color(255, 255, 255, 255)
            draw.Text(175, 580, "J") 
        else
            draw.Color(255, 255, 255, 100)
            draw.Text(175, 580, "_") 
        end

        if input.IsButtonDown(17) then
            draw.Color(255, 255, 255, 255)
            draw.Text(97, 580, "C") 
        else
            draw.Color(255, 255, 255, 100)
            draw.Text(97, 580, "_") 
        end

        if input.IsButtonDown(65) and input.IsButtonDown(68) then
            draw.Color(255, 0, 0, 255)
            draw.Text(175, 610, "D") 
            draw.Text(97, 610, "A") 
        end

        if input.IsButtonDown(87) and input.IsButtonDown(83) then
            draw.Color(255, 0, 0, 255)
            draw.Text(130, 580, "W") 
            draw.Text(136, 610, "S") 
        end
    end
    --velo graph
    if enableVelGraph:GetValue() then
        local playerIsInGround = flags == 256 and false or true-- bitwise and (m & n)
        local moveType = lp:GetPropInt('movetype');
        if (moveType == 9) then
            playerIsJumping = false;
        end
        local x, y, z = lp:GetAbsOrigin();
        local vX, vY = getPropFloat(lp, 'm_vecVelocity[0]'), getPropFloat(lp, 'm_vecVelocity[1]');
        if (playerIsInGround ~= true and playerIsJumping ~= true) then
            graphJump, playerIsJumping, jumpPos, speed, fuck = true, true, { x, y, z }, math.floor(math.min(9999, math.sqrt(vX ^ 2 + vY ^ 2)) + 0.2);
        end
        if (playerIsInGround and playerIsJumping) then
            playerIsJumping, graphLand, landPos = false, true, { x, y, z };
        end
        if (lastDelay == 0 or lastDelay + 4 < globals.RealTime()) then
            speed = 0;
            lastDelay = globals.RealTime();
        end
        local velocity = math.floor(math.min(10000, math.sqrt(vX * vX + vY * vY) + 0.5))
        local screenX, screenY = draw.GetScreenSize();
        local bottomX, bottomY = screenX / 2, screenY / 1.2;
        
    
        if (uiSpeed:GetValue()) then
            local r, g, b = 255, 255, 255
            if lastVelocity < velocity then
                r, g, b = 30, 255, 109
            end
            if lastVelocity == velocity then
                r, g, b = 255, 199, 89
            end
            if lastVelocity > velocity then
                r, g, b = 255, 119, 119
            end
            if lastVelocity >= 300 then 
            r, g, b = 178, 102 ,255
            end
            
            local text = velocity;
            if speed ~= 0 then
                text = text .. " (" .. speed .. ")"
            end
            draw.SetFont(main_font)
            draw.Color(r, g, b, 255)
            local tW, _ = draw.GetTextSize(text);
            draw.Text(bottomX - tW / 2, bottomY, text)
            
            draw.Color(255,255,255, 150)
            draw.Text(bottomX - 140, bottomY + 30, fuck)
    
        end
        
        local tickCount = globals.TickCount();
        if (uiGraph:GetValue()) then
            drawGraph(velocity, bottomX, bottomY - (bottomY * 0.03), tickCount)
        end
        if (prevTick + 5) < tickCount then
            lastVelocity, prevTick = velocity, tickCount;
        end
    end
end)

callbacks.Register('FireGameEvent', function(e)
    local en = e:GetName();
    if (en == "game_start" or en == "round_start") then
        graphJump, graphLand, playerIsJumping, jumpPos, landPos, speed = false, false, false, {}, {}, 0;
        lastDelay, lastGraph, prevTick, lastVelocity = 0, 0, 0, 0;
        graphHistory = {};
    end
end)

--pasted team damage!
local distance3D = function(a, b)
    distance = vector_Distance(a, b)
    return {
        ["normal"] = distance,
        ["u"] = string_format("%.0fu", distance),
        ["ft"] = string_format("%.0fft", distance * 0.083333),
        ["m"] = string_format("%.1fm", distance / 39.370)
    }
end
local is_enemy = function(index)
    if entities_GetByIndex(index) == nil then
        return
    end
    return entities_GetByIndex(index):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber()
end
for i = 1, #listeners do
    c_AllowListener(listeners[i])
end
local team_stuff = {0, 0}
function KillsAndDamage(e)
    if PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() and not is_enemy(PlayerIndexByUserID(e:GetInt("userid"))) then
        if e:GetName() == "player_hurt" then 
            team_stuff[1] = team_stuff[1] + e:GetInt("dmg_health") 
        end 
        if e:GetName() == "player_death" then 
                team_stuff[2] = team_stuff[2] + 1 
        end 
    end
    if e:GetName() == "player_connect_full" then 
        if PlayerIndexByUserID(e:GetInt("userid")) == LocalPlayerIndex() then 
            team_stuff = {0, 0} 
        end 
    end
end
function DrawsTKsDMG() 
    if not TeamDamageShow:GetValue() or GetLocalPlayer() == nil then 
        return 
    end
    local X, Y = draw_GetScreenSize() 
    if team_stuff[2] <= 0 or team_stuff[1] <= 0 then 
        r1,g1,b1,a1 = 255,255,255,255 
    elseif (team_stuff[2] <= 1 or team_stuff[1] <= 100) then
        r1,g1,b1,a1 = 255,178,102,255
    elseif (team_stuff[2] <= 2 or team_stuff[1] <= 200) then
        r1,g1,b1,a1 = 255, 119, 119, 255
    else
        r1,g1,b1,a1 = 255,255,255,255 
    end
    draw.SetFont(main_font)
    local _,tH = draw_GetTextSize(str)
    pos = pos + tH
    draw.Text(35, tH , "team damage")
    draw_Color(r1,g1,b1,a1) 
    draw.Text(35, tH + 30,   team_stuff[1] .. "/300 damage")
    draw.Text(35, tH +  60, team_stuff[2] .. "/3 kills")
end 
cb_Register("Draw", DrawsTKsDMG) cb_Register("FireGameEvent", KillsAndDamage)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

