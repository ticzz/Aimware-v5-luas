----- Luzog Lua By LunarLuzog Aka OriginalLuzog/ShiinaChan#5523 (Menu By The_Belch (Essentials Lua Then U Can't Load With Essentials Lua))

----- Nedded

print("Successfully Loaded Luzog Lua")

local menuloc = gui.Reference("SETTINGS", "MISCELLANEOUS");

local draw_Line, draw_TextShadow, draw_Color, draw_Text, draw_FilledRect, client_WorldToScreen, draw_GetScreenSize, client_GetConVar, client_SetConVar, client_exec, PlayerNameByUserID, PlayerIndexByUserID, GetLocalPlayer, gui_SetValue, gui_GetValue, LocalPlayerIndex, c_AllowListener, cb_Register, g_tickcount, g_realtime, g_curtime, math_floor, math_sqrt, GetPlayerResources, entities_FindByClass, GetPlayerResources = draw.Line, draw.TextShadow, draw.Color, draw.Text, draw.FilledRect, client.WorldToScreen, draw.GetScreenSize, client.GetConVar, client.SetConVar, client.Command, client.GetPlayerNameByUserID, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, gui.SetValue, gui.GetValue, client.GetLocalPlayerIndex, client.AllowListener, callbacks.Register, globals.TickCount, globals.RealTime, globals.CurTime, math.floor, math.sqrt, entities.GetPlayerResources, entities.FindByClass, entities.GetPlayerResources

----- GUI

local essentialsmenu = gui.Checkbox(menuloc, "LuzogLua", "Show Luzog Lua", false);

	----- window
	
		local window = gui.Window("aimwarewindow", "Luzog Lua", 500, 1, 500, 500)
		local miscgroupbox = gui. Groupbox(window, "Miscs", 10, 20, 230, 280)
		local hvhgroupbox = gui.Groupbox(window, "HvH", 10, 320, 230, 125)
		local autogroupbox = gui.Groupbox(window, "Auto", 260, 20, 230, 400)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----- Bomb Timer

local GetPlayerResources, vector_Distance, PlayerNameByUserID, g_curtime, entities_GetByIndex, draw_GetScreenSize, string_format, draw_SetFont, draw_GetTextSize, draw_Color, draw_Text, draw_FilledRect, entities_FindByClass, GetLocalPlayer, math_sqrt, math_exp, math_ceil = entities.GetPlayerResources, vector.Distance, client.GetPlayerNameByUserID, globals.CurTime, entities.GetByIndex, draw.GetScreenSize, string.format, draw.SetFont, draw.GetTextSize, draw.Color, draw.Text, draw.FilledRect, entities.FindByClass, entities.GetLocalPlayer, math.sqrt, math.exp, math.ceil

local BombTimer = gui.Checkbox(miscgroupbox, "esp_other_better_c4timer", "Bomb Timer", false)
local Bomb_Damage = gui.Checkbox(miscgroupbox, "esp_other_bombdamage", "Bomb Damage", false)

local Vf30 = draw.CreateFont("Verdana", 30)

local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage)
	local x = (x2 - x1) * percentage + x1
	local y = (y2 - y1) * percentage + y1
	local z = (z2 - z1) * percentage + z1

	return x, y, z
end

local function get_site_name(site)
	local a_x, a_y, a_z = GetPlayerResources():GetProp("m_bombsiteCenterA")
	local b_x, b_y, b_z = GetPlayerResources():GetProp("m_bombsiteCenterB")

	local site_x1, site_y1, site_z1 = site:GetMins()
	local site_x2, site_y2, site_z2 = site:GetMaxs()

	local site_x, site_y, site_z = lerp_pos(site_x1, site_y1, site_z1, site_x2, site_y2, site_z2, 0.5)

	local distance_a = vector_Distance(site_x, site_y, site_z, a_x, a_y, a_z)
	local distance_b = vector_Distance(site_x, site_y, site_z, b_x, b_y, b_z)

	return distance_b > distance_a and "A" or "B"
end

function bombEvents(e)
	if not BombTimer:GetValue() or e:GetName() ~= "bomb_beginplant" and
	e:GetName() ~= "bomb_abortplant" and e:GetName() ~= "bomb_planted" and
	e:GetName() ~= "bomb_begindefuse" and e:GetName() ~= "bomb_abortdefuse" and
	e:GetName() ~= "bomb_defused" and e:GetName() ~= "round_officially_ended" and 
	e:GetName() ~= "round_prestart" and e:GetName() ~= 'bomb_exploded' then
		return
	end

	if e:GetName() == "bomb_beginplant" then
		planter, plantPercent, plantingStarted, plantingSite, drawPlant = PlayerNameByUserID(e:GetInt("userid")), 0, g_curtime(), get_site_name(entities_GetByIndex(e:GetInt("site"))), true
	end

	if e:GetName() == "bomb_abortplant" then
		drawPlant = false
	end

	if e:GetName() == "bomb_planted" then
		drawPlant = false
		plantedPercent, plantedAt, drawBombPlanted = 0, g_curtime(), true
	end

	if e:GetName() == "bomb_begindefuse" then
		defuser, defusePercent, defuseStarted, drawDefuse = PlayerNameByUserID(e:GetInt("userid")), 0, g_curtime(), true
	end

	if e:GetName() == "bomb_abortdefuse" then
		drawDefuse = false
	end

	if e:GetName() == "bomb_defused" or e:GetName() == 'bomb_exploded' or e:GetName() == "round_prestart" or e:GetName() == "round_officially_ended" then
		drawBombPlanted, drawDefuse, drawPlant = false, false, false
	end
end

function drawBombTimers()
	if not BombTimer:GetValue() then
		return
	end

	local screenX, screenY = draw_GetScreenSize()

	if drawPlant then
		local plantTime = string_format("%s - %0.1fs", planter, plantingStarted - g_curtime() + 3.125)
		local plantingInfo = string_format("%s - Planting", plantingSite)
		local plantPercent = (g_curtime() - plantingStarted) / 3.125
		draw_SetFont(Vf30)

		local tW, tH = draw_GetTextSize(plantingInfo)
		draw_Color(124, 195, 13, 255)
		draw_Text(20, 0, plantingInfo)
		draw_Color(255, 255, 255, 255)
		draw_Text(20, tH, plantTime)

		if plantPercent < 1 and plantPercent > 0 then
			local plantingBar = (1 - plantPercent) * screenY
			draw_Color(13, 13, 13, 70)
			draw_FilledRect(0, 0, 16, screenY)
			draw_Color(0, 150, 0, 255)
			draw_FilledRect(1, plantingBar, 15, screenY+plantingBar)
		end
	end

	if drawBombPlanted and entities_FindByClass("CPlantedC4")[1] ~= nil then
		local plantedBomb = entities_FindByClass("CPlantedC4")

		for i=1, #plantedBomb do
			bLength = plantedBomb[i]:GetPropFloat("m_flTimerLength")
			dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength")
			bSite = plantedBomb[i]:GetPropInt("m_nBombSite") == 0 and "A" or "B"
		end

		local plantedInfo = string_format("%s - %0.1fs", bSite, (plantedAt - g_curtime()) + bLength)
		local plantedPercent = (g_curtime() - plantedAt) / bLength

		if plantedAt - g_curtime() + bLength > 0 then
			draw_SetFont(Vf30)
			pTW, pTH = draw_GetTextSize(plantedInfo)

			if GetLocalPlayer():GetTeamNumber() == 3 and (not GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 10.1 or
															  GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 5.1) then
				r, g, b, a = 255,13,13,255
			else
				r, g, b, a = 124, 195, 13, 255
			end

			draw_Color(r, g, b, a)
			draw_Text(20, 0, plantedInfo)
			if plantedPercent < 1 and plantedPercent > 0 then
				local plantedBar = (1 - plantedPercent) * screenY
				draw_Color(13, 13, 13, 70)
				draw_FilledRect(0, 0, 16, screenY)
				draw_Color(0, 150, 0, 255)
				draw_FilledRect(1, screenY-plantedBar, 15, screenY)
			end
		end
	end

	if drawDefuse and entities_FindByClass("CPlantedC4")[1] ~= nil then
		local plantedBomb = entities_FindByClass("CPlantedC4")

		for i=1, #plantedBomb do
			dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength")
		end

		local defuseInfo = string_format("%s - %0.1fs", defuser, (defuseStarted - g_curtime()) + dLength)
		local defusePercent = (g_curtime() - defuseStarted) / dLength

		if (defuseStarted - g_curtime()) + dLength > 0 then
			draw_SetFont(Vf30)
			draw_Color(255, 255, 255, 255)
			draw_Text(20, pTH+pTH, defuseInfo)

			if defusePercent < 1 and defusePercent > 0 then
				local defuseBar = (1 - defusePercent) * screenY
				draw_Color(13, 13, 13, 70)
				draw_FilledRect(0, 0, 16, screenY)
				draw_Color(0, 0, 150, 255)
				draw_FilledRect(1, screenY-defuseBar, 15, screenY)
			end
		end
	end
end

function BombDamageIndicator()
	if not Bomb_Damage:GetValue() or entities_FindByClass("CPlantedC4")[1] == nil then
		return
	end

	local Bomb = entities_FindByClass("CPlantedC4")[1]

	if Bomb:GetPropBool("m_bBombTicking") and g_curtime() - 1 < Bomb:GetPropFloat("m_flC4Blow") and not Bomb:GetPropBool("m_bBombDefused") then
		local bDamage = DamagefromBomb(Bomb, GetLocalPlayer())
		local bDmgInfo = string_format("-%i", bDamage)

		if bDamage >= GetLocalPlayer():GetHealth() then
			draw_SetFont(Vf30)
			draw_Color(255, 0, 0, 255)
			draw_Text(20, pTH, "FATAL")
		elseif bDamage < GetLocalPlayer():GetHealth() and bDamage - 1 > 0 then
			draw_SetFont(Vf30)
			draw_Color(255,255,255,255)
			draw_Text(20, pTH, bDmgInfo)
		end
	end
end

function DamagefromBomb(Bomb, Player)
	if not Bomb_Damage:GetValue() then
		return
	end

	local Bxyz = {Bomb:GetAbsOrigin()}
	local Pxyz = {Player:GetAbsOrigin()}
	local ArmorValue = Player:GetPropInt("m_ArmorValue")
	local C4Distance = math_sqrt((Bxyz[1] - Pxyz[1]) ^2 + (Bxyz[2] - Pxyz[2]) ^2 + (Bxyz[3] - Pxyz[3]) ^2)
	local d = ((C4Distance-75.68) / 789.2)
	local f1Damage = 450.7*math_exp(-d * d)

	if ArmorValue > 0 then
		local f1New = f1Damage * 0.5
		local f1Armor = (f1Damage - f1New) * 0.5

		if f1Armor > ArmorValue then
			f1Armor = ArmorValue * 2
			New = f1Damage - f1Armor
		end

		f1Damage = f1New
	end

	return math_ceil(f1Damage + 0.5)
end

callbacks.Register("Draw", drawBombTimers)
callbacks.Register("Draw", BombDamageIndicator)
callbacks.Register("FireGameEvent", bombEvents)

client.AllowListener("bomb_beginplant")
client.AllowListener("bomb_abortplant")
client.AllowListener("bomb_planted")
client.AllowListener("bomb_begindefuse")
client.AllowListener("bomb_abortdefuse")
client.AllowListener("bomb_defused")
client.AllowListener('bomb_exploded')
client.AllowListener("round_officially_ended")
client.AllowListener("round_prestart")

----- Disable Post Prossesing

local disablepost = gui.Checkbox(miscgroupbox, "vis_disable_post", "Disable Post Processing", false)
function disablepp() 
if disablepost:GetValue() then client_SetConVar("mat_postprocess_enable", 0, true); else client_SetConVar("mat_postprocess_enable", 1, true); end end
cb_Register('Draw', "Disable Post Processing" ,disablepp);

----- Legit ZeusBot

local GetLocalPlayer, gui_GetValue, gui_SetValue = entities.GetLocalPlayer, gui.GetValue, gui.SetValue

local zeusbot = gui.Checkbox(miscgroupbox, "lbot_zeusbot_enable", "Zeusbot", false)
local trige, trigaf, trighc, trigm
local set_values = false

callbacks.Register("Draw", 'Uses Triggerbot to autoshoot Zeus', function()
	if not zeusbot:GetValue() or GetLocalPlayer() == nil then 
		return 
	end 

	local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
	local alive = weapon ~= nil and GetLocalPlayer():IsAlive()
	local ready = alive and weapon:GetClass() == "CWeaponTaser"

	if ready then 
		gui_SetValue("lbot_trg_enable", 1) 
		gui_SetValue("lbot_trg_autofire", 1)
		gui_SetValue("lbot_trg_hitchance", gui_GetValue("rbot_taser_hitchance"))
		gui_SetValue("lbot_trg_mode", 0) 
		set_values = true
	else
		if not set_values then
			trige, trigaf, trighc, trigm = gui_GetValue("lbot_trg_enable"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance"), gui_GetValue("lbot_trg_mode")
		else
			gui_SetValue("lbot_trg_enable", trige)
			gui_SetValue("lbot_trg_autofire", trigaf)
			gui_SetValue("lbot_trg_hitchance", trighc)
			gui_SetValue("lbot_trg_mode", trigm)
			set_values = false
		end
	end 
end)

----- Grenate Timer

local enable = gui.Checkbox(miscgroupbox, "esp_molotovesp", "Molotov ESP", false)
local color = gui.ColorEntry("esp_molotovesp_circle_clr", "Molotov ESP", 255, 255, 255, 255 )
local colorCircle = gui.ColorEntry("esp_molotovesp_clr", "Molotov ESP Circle", 255, 255, 255, 255 )
local Molotovs = {} 
client.AllowListener("inferno_startburn") 

callbacks.Register("FireGameEvent", function(event)

    if enable:GetValue() then
        if event:GetName() == "inferno_startburn" then

            local x, y, z = event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z")
            table.insert(Molotovs, {x,y,z,globals.CurTime()})
        end
    end
end)

local function drawCircle(x, y, z, radius, thickness, quality)
    local quality = quality or 20
    local thickness = thickness or 8
    local Screen_X_Line_Old, Screen_Y_Line_Old
    for rot = 0, 360, quality do
        local rot_temp = math.rad(rot)
        local LineX, LineY, LineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
        local Screen_X_Line, Screen_Y_Line = client.WorldToScreen(LineX, LineY, LineZ)
        if Screen_X_Line ~= nil and Screen_X_Line_Old ~= nil then
            draw.SetFont(draw.CreateFont("Tahoma", 12));
            draw.Line(Screen_X_Line, Screen_Y_Line, Screen_X_Line_Old, Screen_Y_Line_Old)
            for i = 0, thickness do
                draw.Line(Screen_X_Line, Screen_Y_Line + i, Screen_X_Line_Old, Screen_Y_Line_Old + i)
            end
        end
        Screen_X_Line_Old, Screen_Y_Line_Old = Screen_X_Line, Screen_Y_Line
    end
end

callbacks.Register("Draw", function ()
   
    if enable:GetValue() then

        local font = draw.CreateFont("Tahoma", 20, 250)
        draw.SetFont(font)

        for k, v in pairs(Molotovs) do
            local w2sX, w2sY = client.WorldToScreen(Molotovs[k][1], Molotovs[k][2], Molotovs[k][3]) 
            if w2sX and w2sY then
                draw.Color(color:GetValue())
                draw.Text(w2sX, w2sY, "Molotov")
                draw.Color(colorCircle:GetValue())
                drawCircle(Molotovs[k][1], Molotovs[k][2], Molotovs[k][3], 133, 1, 1)
                if Molotovs[k][4] <= globals.CurTime() - 7.03125 then
                    table.remove(Molotovs, k)
                end
            end
        end
    end
end)

----- Engine Radar

local ERadar = gui.Checkbox(miscgroupbox, "esp_engine_radar", "Engine Radar", false)
function engineradar()
if ERadar:GetValue() then ERval = 1; else ERval = 0; end
for o, radar in pairs(entities_FindByClass("CCSPlayer")) do radar:SetProp("m_bSpotted", ERval); end end
cb_Register("Draw", "engine radar", engineradar);

----- Full Bright

local fullbright = gui.Checkbox(miscgroupbox, "fulbright", "Full Bright", false)
function full_bright() if fullbright:GetValue() then client_SetConVar("mat_fullbright", 1, true); else client_SetConVar("mat_fullbright", 0, true); end end
cb_Register('Draw', "Full brightness" ,full_bright);

----- Rainbow Hand

local SetValue, floor, sin, RealTime = gui.SetValue, math.floor, math.sin, globals.RealTime
local r = gui.Reference('VISUALS', 'Shared')
local rainbowhands = gui.Checkbox( miscgroupbox, 'lua_rainbow_hands', 'Rainbow Hand', false)

----- Stretched Resolution

local aspect_ratio_table = {};
local aspect_ratio_check = gui.Checkbox(miscgroupbox, "msc_aspect_enable", "Stretched Resolution", false) 

----- Anti Kick

local kick_command_id = 1;
local kick_potential_votes = 0;
local kick_yes_voters = 0;
local kick_getting_kicked = false;
local kick_last_command_time;
local ANTIKICK_CB = gui.Checkbox( miscgroupbox, "ANTIKICK_CB", "Anti Vote-kick (No Ranked)", false);

----- Thirdperson

local tpkey = gui.Keybox( miscgroupbox, "thirdperson_bind", "Third Person", 0 )

----- DTaps Fix

local enabled = gui.Checkbox(hvhgroupbox, "rbot_doublefire", "Double Fire Fix", false)
local shouldRecover = false;

callbacks.Register("CreateMove", function(pCmd)

    if enabled:GetValue() then

        local IN_ATTACK = 1 << 0;

        if (( pCmd:GetButtons() & IN_ATTACK) ==IN_ATTACK) then
            gui.SetValue("msc_fakelag_enable", 0)
            shouldRecover = true;
        elseif shouldRecover then
            gui.SetValue("msc_fakelag_enable", 1)
            shouldRecover = false
        end
    end
end)

----- AA Angle Lines

local pos = gui.Reference("RAGE", "MAIN", "Anti-Aim Main");
local enabled = gui.Checkbox(hvhgroupbox, "suyu_antiaimlines_enabled", "Anti-Aim Lines", 0);


local rx, ry;
local fx, fy;
local fx2, fy2;
local lby;
local pLocal = entities.GetLocalPlayer();
local choking;
local lastChoke;

local function AngleVectors(angles)

    local sp, sy, cp, cy;
    local forward = { }

    sy = math.sin(math.rad(angles[2]));
	cy = math.cos(math.rad(angles[2]));

	sp = math.sin(math.rad(angles[1]));
	cp = math.cos(math.rad(angles[1]));

	forward[1] = cp*cy;
	forward[2] = cp*sy;
    forward[3] = -sp;
    return forward;
end

local function doShit(t1, t2, m)
    local t3 ={};
    for i,v in ipairs(t1) do
        t3[i] = v + (t2[i] * m);
    end
    return t3;
end

local function iHateMyself(value, color, text)

    local forward = {};
    local originX, originY, originZ = pLocal:GetAbsOrigin();
    forward = AngleVectors({0, value, 0});
    local end3D = doShit({ originX, originY, originZ }, forward, 25);
    local w2sX1, w2sY1 = client.WorldToScreen(originX, originY, originZ);
    local w2sX2, w2sY2 = client.WorldToScreen(end3D[1], end3D[2], end3D[3]);
    draw.Color(color[1], color[2], color[3], color[4])

    if w2sX1 and w2sY1 and w2sX2 and w2sY2 then
        draw.Line(w2sX1, w2sY1, w2sX2, w2sY2)
        local textW, textH = draw.GetTextSize(text);
        draw.TextShadow( w2sX2-(textW/2), w2sY2-(textH/2), text)
    end
end

callbacks.Register("Draw", function()

    pLocal = entities.GetLocalPlayer();
    lby = pLocal:GetProp("m_flLowerBodyYawTarget");
    fx, fy = pLocal:GetProp("m_angEyeAngles");

    if lastChoke and lastChoke <= globals.CurTime() - 1 then
        choking = false;
    end

    if pLocal and pLocal:IsAlive() and enabled:GetValue()  then

        if ry and choking then iHateMyself(ry, {25, 255, 25, 255}, "Last Choked") end
        if fy then iHateMyself(fy, {255, 25, 25, 255}, "Networked") end
        if fy2 then iHateMyself(fy2, {25, 25, 255, 255}, "Local Angle") end
        if lby then iHateMyself(lby, {255, 255, 255, 255}, "Networked LBY") end
    end
end)

callbacks.Register("CreateMove", function(pCmd)
    if pLocal and pLocal:IsAlive() and enabled:GetValue() then

        if not pCmd:GetSendPacket() then
            rx, ry = pCmd:GetViewAngles();
            choking = true;
            lastChoke = globals.CurTime();
        else
            fx2, fy2 = pCmd:GetViewAngles()
        end
    end
end)

----- Jumpshot Fix

local jumpshot = gui.Checkbox(hvhgroupbox, "jumpshot", "Jumpscout Fix", false)

local function jumpshot()
    if gui.GetValue("jumpshot") == true and entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName():match("knife")then
        local velocity = vector.Length(entities.GetLocalPlayer():GetPropVector("localdata", "m_vecVelocity[0]"))
        gui.SetValue("msc_autostrafer_enable", 0)
        if input.IsButtonDown(32) then -- key 32 is space bar
            local x,y,z = entities.GetLocalPlayer():GetPropVector("localdata", "m_vecVelocity[0]")
            local velocity = math.sqrt(x^2 + y^2)
            if velocity >= 5 then
                gui.SetValue("msc_autostrafer_enable", 1)
            else
                gui.SetValue("msc_autostrafer_enable", 0)
            end
        end
    end
end
callbacks.Register("CreateMove", jumpshot)

----- Auto Resolver

local enabled = gui.Checkbox(hvhgroupbox, "rbot_autoresolver", "Automatic Resolver", false)
local warningEnabled = gui.Checkbox(hvhgroupbox, "rbot_autoresolver_warning", "Desync Warning", false)
local listEnabled = gui.Checkbox(hvhgroupbox, "rbot_autoresolver_list", "Desync List", false)

local isDesyncing = {};
local lastSimtime = {};
local desyncCooldown = {};

local lastTick = 0;
local pLocal = entities.GetLocalPlayer();
local resolverTextCount = 0;
local sampleTextWidth, sampleTextHeight

local function drawHook()
    pLocal = entities.GetLocalPlayer();

    if listEnabled:GetValue() then

        if engine.GetMapName() ~= "" then
            draw.Text(2, 400, gui.GetValue("rbot_resolver") and "Desyncing Players - Resolver: On" or "Desyncing Players - Resolver:  Off")
        end
        sampleTextWidth, sampleTextHeight = draw.GetTextSize("Sample Text")
    end

    if enabled:GetValue() then
        resolverTextCount = 0;
        for pEntityIndex, pEntity in pairs(entities.FindByClass("CCSPlayer")) do
            if pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() and pEntity:IsPlayer() and pEntity:IsAlive() then
                if globals.TickCount() > lastTick then
                    if lastSimtime[pEntityIndex] ~= nil then
                        if pEntity:GetProp("m_flSimulationTime") == lastSimtime[pEntityIndex] then
                            isDesyncing[pEntityIndex] = true;
                            desyncCooldown[pEntityIndex] = globals.TickCount();
                        else
                            if desyncCooldown[pEntityIndex] ~= nil then
                                if desyncCooldown[pEntityIndex] < globals.TickCount() - 128 then
                                    isDesyncing[pEntityIndex] = false;
                                end
                            else
                                isDesyncing[pEntityIndex] = false;
                            end
                        end
                    end
                    lastSimtime[pEntityIndex] = pEntity:GetProp("m_flSimulationTime")
                end

                if engine.GetMapName() ~= "" then
                    if isDesyncing[pEntityIndex] then
                        if listEnabled:GetValue() then
                            local pos = 410 + (sampleTextHeight * resolverTextCount)
                            draw.Text(2, pos, pEntity:GetName())
                        end
                        resolverTextCount = resolverTextCount+1
                    end
                end
            end
        end
        lastTick = globals.TickCount();
        if resolverTextCount ~= 0 then
            gui.SetValue("rbot_resolver", 1);
        else
            gui.SetValue("rbot_resolver", 0);
        end
    end
end

local function aimbotTargetHook(pEntity)
    if enabled:GetValue() then

        if not isDesyncing[pEntity:GetIndex()] then
            gui.SetValue("rbot_resolver", 0);
        else
            gui.SetValue("rbot_resolver", 1);
        end
    end
end

local function drawEspHook(builder)

    if warningEnabled:GetValue() then
        local pEntity = builder:GetEntity()

        if pEntity:IsPlayer() and pEntity:IsAlive() and pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() then

            if isDesyncing[pEntity:GetIndex()] then
                builder:Color(255, 25, 25, 255)
                builder:AddTextBottom("Desync")
            else
                builder:Color(255, 255, 25, 255)
                builder:AddTextBottom("No Desync")
            end
        end
    end
end

callbacks.Register("Draw", drawHook)
callbacks.Register("AimbotTarget", aimbotTargetHook)
callbacks.Register("DrawESP", drawEspHook)

----- Auto Buy

local Autobuy_Text = gui.Text( autogroupbox, "Autobuy" );
local Autobuy_Enable = gui.Checkbox( autogroupbox, "lua_autobuy_enable", "Enable", 0 );

local Autobuy_PrimaryWeapon = gui.Combobox( autogroupbox, "lua_autobuy_primaryweapon", "Primary Weapon", "Off", "Auto", "Scout", "AWP", "Rifle", "Famas : Galil AR", "AUG : SG 553", "MP9 : MAC-10", "MP7 : MP5-SD", "UMP-45", "P90", "PP-Bizon", "Nova", "XM1014", "MAG-7 : Sawed-Off", "M249", "Negev" );
local Autobuy_SecondaryWeapon = gui.Combobox( autogroupbox, "lua_autobuy_secondaryweapon", "Secondary Weapon", "Off", "Dual Berettas", "P250", "Five-Seven : CZ75-Auto : Tec-9", "Desert Eagle : R8 Revolver" );

local Autobuy_Armor = gui.Combobox( autogroupbox, "lua_autobuy_armor", "Armor", "Off", "Kevlar", "Kevlar + Helmet" );
local Autobuy_Defuser = gui.Checkbox( autogroupbox, "lua_autobuy_defuser", "Defuser", 0 );
local Autobuy_Taser = gui.Checkbox( autogroupbox, "lua_autobuy_taser", "Taser", 0 );

local Autobuy_HEGrenade = gui.Checkbox( autogroupbox, "lua_autobuy_hegrenade", "HE Grenade", 0 );
local Autobuy_Smoke = gui.Checkbox( autogroupbox, "lua_autobuy_smoke", "Smoke", 0 );
local Autobuy_Molotov = gui.Checkbox( autogroupbox, "lua_autobuy_molotov", "Molotov", 0 );
local Autobuy_Flashbang = gui.Checkbox( autogroupbox, "lua_autobuy_flashbang", "Flashbang", 0 );
local Autobuy_Decoy = gui.Checkbox( autogroupbox, "lua_autobuy_decoy", "Decoy", 0 );

local Money = 0

local function LocalPlayerMoney()
	if Autobuy_Enable:GetValue() then
		if entities.GetLocalPlayer() ~= nil then
			Money = entities.GetLocalPlayer():GetProp( "m_iAccount" )
		end
	end
end

local function Autobuy( Event )

	local PrimaryWeapon = Autobuy_PrimaryWeapon:GetValue()
	local SecondaryWeapon = Autobuy_SecondaryWeapon:GetValue()
	local Armor = Autobuy_Armor:GetValue()

	if Autobuy_Enable:GetValue() then

		if Event:GetName() ~= "player_spawn" then
			return;
		end

		local INT_UID = Event:GetInt( "userid" );
		local PlayerIndex = client.GetPlayerIndexByUserID( INT_UID );
		
		if client.GetLocalPlayerIndex() == PlayerIndex then
			ME = true
		else
			ME = false
		end

		if ME and Money == 0 then
			-- Primary Weapon
			if PrimaryWeapon == 1 then client.Command( "buy scar20", true ); -- Auto
			elseif PrimaryWeapon == 2 then client.Command( "buy ssg08", true ); -- Scout
			elseif PrimaryWeapon == 3 then client.Command( "buy awp", true ); -- AWP
			elseif PrimaryWeapon == 4 then client.Command( "buy ak47", true ); -- Rifle
			elseif PrimaryWeapon == 5 then client.Command( "buy famas", true ); -- Famas : Galil AR
			elseif PrimaryWeapon == 6 then client.Command( "buy aug", true ); -- AUG : SG 553
			elseif PrimaryWeapon == 7 then client.Command( "buy mac10", true ); --  MP9 : MAC-10
			elseif PrimaryWeapon == 8 then client.Command( "buy mp7", true ); -- MP7 : MP5-SD
			elseif PrimaryWeapon == 9 then client.Command( "buy ump45", true ); -- UMP-45
			elseif PrimaryWeapon == 10 then client.Command( "buy p90", true ); -- P90
			elseif PrimaryWeapon == 11 then client.Command( "buy bizon", true ); -- PP-Bizon
			elseif PrimaryWeapon == 12 then client.Command( "buy nova", true ); -- Nova
			elseif PrimaryWeapon == 13 then client.Command( "buy xm1014", true ); -- XM1014
			elseif PrimaryWeapon == 14 then client.Command( "buy mag7", true ); -- MAG-7 : Sawed-Off
			elseif PrimaryWeapon == 15 then client.Command( "buy m249", true ); -- M249
			elseif PrimaryWeapon == 16 then client.Command( "buy negev", true ); -- Negev
			end
			-- Secondary Weapon
			if SecondaryWeapon == 1 then client.Command( "buy elite", true ); -- Dual Berettas
			elseif SecondaryWeapon == 2 then client.Command( "buy p250", true ); -- P250
			elseif SecondaryWeapon == 3 then client.Command( "buy tec9", true ); -- Five-Seven : CZ75-Auto : Tec-9
			elseif SecondaryWeapon == 4 then client.Command( "buy deagle", true ); -- Desert Eagle : R8 Revolver
			end
			-- Taser
			if Autobuy_Taser:GetValue() then
				client.Command( "buy taser", true );
			end
		elseif ME and Money <= 800 then
			-- Secondary Weapon
			if SecondaryWeapon == 1 then client.Command( "buy elite", true ); -- Dual Berettas
			elseif SecondaryWeapon == 2 then client.Command( "buy p250", true ); -- P250
			elseif SecondaryWeapon == 3 then client.Command( "buy tec9", true ); -- Five-Seven : CZ75-Auto : Tec-9
			elseif SecondaryWeapon == 4 then client.Command( "buy deagle", true ); -- Desert Eagle : R8 Revolver
			end
			-- Taser
			if Autobuy_Taser:GetValue() then
				client.Command( "buy taser", true );
			end
		elseif ME and Money > 800 then
			-- Primary Weapon
			if PrimaryWeapon == 1 then client.Command( "buy scar20", true ); -- Auto
			elseif PrimaryWeapon == 2 then client.Command( "buy ssg08", true ); -- Scout
			elseif PrimaryWeapon == 3 then client.Command( "buy awp", true ); -- AWP
			elseif PrimaryWeapon == 4 then client.Command( "buy ak47", true ); -- Rifle
			elseif PrimaryWeapon == 5 then client.Command( "buy famas", true ); -- Famas : Galil AR
			elseif PrimaryWeapon == 6 then client.Command( "buy aug", true ); -- AUG : SG 553
			elseif PrimaryWeapon == 7 then client.Command( "buy mac10", true ); --  MP9 : MAC-10
			elseif PrimaryWeapon == 8 then client.Command( "buy mp7", true ); -- MP7 : MP5-SD
			elseif PrimaryWeapon == 9 then client.Command( "buy ump45", true ); -- UMP-45
			elseif PrimaryWeapon == 10 then client.Command( "buy p90", true ); -- P90
			elseif PrimaryWeapon == 11 then client.Command( "buy bizon", true ); -- PP-Bizon
			elseif PrimaryWeapon == 12 then client.Command( "buy nova", true ); -- Nova
			elseif PrimaryWeapon == 13 then client.Command( "buy xm1014", true ); -- XM1014
			elseif PrimaryWeapon == 14 then client.Command( "buy mag7", true ); -- MAG-7 : Sawed-Off
			elseif PrimaryWeapon == 15 then client.Command( "buy m249", true ); -- M249
			elseif PrimaryWeapon == 16 then client.Command( "buy negev", true ); -- Negev
			end
			-- Secondary Weapon
			if SecondaryWeapon == 1 then client.Command( "buy elite", true ); -- Dual Berettas
			elseif SecondaryWeapon == 2 then client.Command( "buy p250", true ); -- P250
			elseif SecondaryWeapon == 3 then client.Command( "buy tec9", true ); -- Five-Seven : CZ75-Auto : Tec-9
			elseif SecondaryWeapon == 4 then client.Command( "buy deagle", true ); -- Desert Eagle : R8 Revolver
			end

			-- Armor
			if Armor == 1 then client.Command( "buy vest", true );
			elseif Armor == 2 then client.Command( "buy vesthelm", true );
			end
			-- Defuser
			if Autobuy_Defuser:GetValue() then
				client.Command( "buy defuser", true );
			end
			-- Taser
			if Autobuy_Taser:GetValue() then
				client.Command( "buy taser", true );
			end

			-- HE Grenade
			if Autobuy_HEGrenade:GetValue() then
				client.Command( "buy hegrenade", true );
			end
			-- Smoke
			if Autobuy_Smoke:GetValue() then
				client.Command( "buy smokegrenade", true );
			end
			-- Molotov
			if Autobuy_Molotov:GetValue() then
				client.Command( "buy molotov", true );
			end
			-- Flashbang
			if Autobuy_Flashbang:GetValue() then
				client.Command( "buy flashbang", true );
			end
			-- Decoy
			if Autobuy_Decoy:GetValue() then
				client.Command( "buy decoy", true );
			end
		end

	end

end

client.AllowListener( "player_spawn" )

callbacks.Register( "Draw", "Local Player Money", LocalPlayerMoney )
callbacks.Register( "FireGameEvent", "Autobuy", Autobuy )
---------- Sliders

----- Rainbow Hand

local rainbow_speed = gui.Slider( miscgroupbox, 'lua_rainbow_speed', 'Rainbow Hand Speed', 50, 0, 100)

local weapon = {
    'clr_chams_weapon_primary',
    'clr_chams_weapon_secondary',
}

local hands = {
    'clr_chams_hands_primary',
    'clr_chams_hands_secondary',
}

local get_rgb = function()
    local speed = rainbow_speed:GetValue()
    local r = floor(sin(RealTime() * speed) * 127 + 128)
    local g = floor(sin(RealTime() * speed + 2) * 127 + 128)
    local b = floor(sin(RealTime() * speed + 4) * 127 + 128)
    return r, g, b
end

callbacks.Register('Draw', 'Rainbow Weapons', function()
    if rainbowhands:GetValue() then
        for i=1, #hands do
            local r,g,b = get_rgb()
            SetValue(hands[i], r,g,b,255)
        end
    end
end)

----- Stretched Resolution

local aspect_ratio_reference = gui.Slider(miscgroupbox, "msc_aspect_value", "Stretched Resolution %", 100, 1, 199)
local function gcd(m, n) while m ~= 0 do m, n = math.fmod(n, m), m; end return n; end
local function set_aspect_ratio(aspect_ratio_multiplier) local screen_width, screen_height = draw_GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height; if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0; end client_SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end
local function on_aspect_ratio_changed() local screen_width, screen_height = draw_GetScreenSize(); for i=1, 200 do local i2=i*0.01;    i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height); if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end local aspect_ratio = aspect_ratio_reference:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
cb_Register('Draw', "Stretched Resolution" ,on_aspect_ratio_changed);

----- Anti Kick

local ANTIKICK_VOTE_THRESHOLD = gui.Slider(miscgroupbox, "ANTIKICK_VOTE_THRESHOLD", "Antikick Vote Threshold %", 50, 1, 100);

function kickEventHandler(event)
    local self_pid = client.GetLocalPlayerIndex();
    local self = entities.GetLocalPlayer();

    local active_map_name = engine.GetMapName();

    if (ANTIKICK_CB:GetValue() == false or self_pid == nil or self == nil or active_map_name == nil) then
        return;
    end

    if (event:GetName() == "game_start") then
        kick_last_command_time = nil;
        return;
    end

    if (event:GetName() == "vote_changed") then
        kick_potential_votes = event:GetInt("potentialVotes");
        return;
    end

    if (event:GetName() == "vote_cast") then
        local vote_option = event:GetInt("vote_option");
        local voter_eid = event:GetInt("entityid");

        if (self_pid ~= voter_eid and vote_option == 0) then
            kick_yes_voters = kick_yes_voters + 1;
        end

        if (self_pid == voter_eid and vote_option == 1) then
            kick_getting_kicked = true;

            kick_yes_voters = 1;
        end

        if (kick_getting_kicked == false) then
            return;
        end

        local kick_percentage = ((kick_yes_voters - 1) / (kick_potential_votes / 2) * 100);

        if (kick_yes_voters > 0 and kick_potential_votes > 0 and kick_percentage >= ANTIKICK_VOTE_THRESHOLD:GetValue() and (kick_last_command_time == nil or globals.CurTime() - kick_last_command_time > 120)) then
            if (kick_command_id == 1) then
                client.Command("callvote SwapTeams");
                kick_command_id = 2;
            elseif (kick_command_id == 2) then
                client.Command("callvote ScrambleTeams");
                kick_command_id = 3;
            elseif (kick_command_id == 3) then
                client.Command("callvote ChangeLevel " .. active_map_name);
                kick_command_id = 1;
            end

            kick_last_command_time = globals.CurTime();
        end
    end

end

client.AllowListener("game_start");
client.AllowListener("vote_changed");
client.AllowListener("vote_cast");
callbacks.Register("FireGameEvent", "antikick_event", kickEventHandler);

----- Thirdperson

local gui_get = gui.GetValue
local tp_val = 0
local tpamount = gui.Slider( miscgroupbox, "thirdperson_distance", "Thirdperson Distance", 100, 50, 800 )
function mainthirdperson()
    if tpkey:GetValue() ~= 0 then
        if input.IsButtonPressed( tpkey:GetValue() ) then
            tp_val = tp_val + 1
        end
    end
end
function Check()
    if (tp_val == 2) then
    tp_val = 0
   end
end
function thirdperson()
    if (tp_val == 1) then
        gui.SetValue( "vis_thirdperson_dist", tpamount:GetValue() )
    elseif (tp_val == 0) then
        gui.SetValue( "vis_thirdperson_dist", 0 )
    end
end
callbacks.Register( "Draw", "mainthirdperson", mainthirdperson );
callbacks.Register( "Draw", "Check", Check );
callbacks.Register( "Draw", "thirdperson", thirdperson );

----- Menu Toggle

local awMenu = gui.Reference("MENU");

local function hideMenu()
    if awMenu:IsActive() then
        eActive = 1
    else
        eActive = 0
    end
    if (essentialsmenu:GetValue()) then
        window:SetActive(eActive);
    else
        window:SetActive(0);
    end
end
callbacks.Register("Draw", "hideMenu", hideMenu)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

