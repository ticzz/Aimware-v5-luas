---- Lua prankster by Nyanpasu!
---- Version 1.1

-- Constants
local font_header = draw.CreateFont("Tahoma", 16, 16)
local font_main = draw.CreateFont("Small Fonts", 15, 15)
local font_tiny = draw.CreateFont("Small Fonts", 11, 11)
local list_grenades = {"CSmokeGrenadeProjectile", "CSensorGrenadeProjectile", "CMolotovProjectile", "CDecoyProjectile", "CBaseCSGrenadeProjectile"}


local mmcolors = 
{
	[-1] = {"Grey", {200, 200, 200, 255}},
	[0] = {"Yellow", {255, 255, 0, 255}},
	[1] = {"Purple", {110, 0, 255, 255}},
	[2] = {"Green", {0, 200, 0, 255}},
	[3] = {"Blue", {0, 75, 255, 255}},
	[4] = {"Orange", {255, 145, 0, 255}};
}
local buttons = 
{
	IN_ATTACK = 0,
	IN_ATTACK2 = 11,
	IN_SCORE = 16;
}
------------

-- Persistent Variables
local ent_LocalPlayer = entities.GetLocalPlayer()
local str_ServerIP = engine.GetServerIP()
local vec2_ScreenSize = {640, 480}
local bool_inGame = false
local vec_ViewAngles = {0, 0, 0}
local vec3_LocalShootPos = {0, 0, 0}
local int_LocalButtons = 0
local list_ButtonRequest = {} -- Functions can set button index to true to request a button
local list_teamdamage = {} -- {Team Damage, Team Kills, Name, Matchmaking Color} at Player Index
local int_selfNadeStart = nil -- CurTime of self nade start
local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 650, 10, 0, 0, 400, 50;
local shouldDrag = false;
-----------------------

-- GUI
local ref_msc_general_extra = gui.Reference("MISC", "GENERAL", "Extra")
	


gui.Combobox(ref_msc_general_extra, "msc_teamdamage", "#~#~# TeamDamage Scoreboard #~#~#", "Off", "Without Colors", "Matchmaking Colors")
gui.Keybox(ref_msc_general_extra, "msc_selfnade", "Self HE Grenade", 0)
gui.Slider(ref_msc_general_extra, "msc_selfnade_modifier", "Self HE Grenade Modifier", 7.5, 0, 15 )
gui.Button(ref_msc_general_extra, "Reset Team Damage", function() list_teamdamage = {} end)

local ref_vis_other_options = gui.Reference("VISUALS", "OTHER", "Options")

gui.Checkbox(ref_vis_other_options, "esp_other_grenadethrower", "Grenade Thrower Name", 0)
------



local function bit_GetBit(Source, Bit) -- Gets a bit from a bitmap
	Source = (Source >> Bit)

	if Source % 2 == 1 then
		return true
	else
		return false
	end

end

local function math_setbounds(int_min, int_max, int_value) -- Sets the bounds of a number
	return math.min(math.max(int_value, int_min), int_max)
end

local function color_gradient(clr_colorA, clr_colorB, int_percentage) -- Get a color that's inbetween clr_colorA and clr_colorB at int_percentage
	
	-- Limit the percentage to actually 0 and 100 and divide it by 100 to get multiplier
	int_percentage = math_setbounds(0, 100, int_percentage) / 100
	
	local byte_r = clr_colorA[1] * int_percentage + (1 - int_percentage) * clr_colorB[1]
	local byte_g = clr_colorA[2] * int_percentage + (1 - int_percentage) * clr_colorB[2]
	local byte_b = clr_colorA[3] * int_percentage + (1 - int_percentage) * clr_colorB[3]
	local byte_a = 255
	
	-- If both colors contain an alpha value
	if clr_colorA[4] ~= nil and clr_colorB[4] ~= nil then
		local byte_a = clr_colorA[4] * int_percentage + (1 - int_percentage) * clr_colorB[4]
	end
	
	-- Floor values
	byte_r = math.floor(byte_r)
	byte_g = math.floor(byte_g)
	byte_b = math.floor(byte_b)
	byte_a = math.floor(byte_a)
	
	return {byte_r, byte_g, byte_b, byte_a}
end

local function draw_progressbar(vec2_pos, vec2_size, clr_colorA, clr_colorB, int_percentage, bool_centered, bool_vertical, str_valuelabel) -- Draws a progress bar

	-- Calculate progress color
	local clr_progress = {0, 0, 0, 0}
	local vec2_progressPos = {0, 0}
	
	-- Center the text on pos
	if bool_centered then
		vec2_pos[1] = vec2_pos[1] - vec2_size[1] / 2
		vec2_pos[2] = vec2_pos[2] - vec2_size[2] / 2
	end
	
	clr_progress = color_gradient(clr_colorA, clr_colorB, int_percentage)

	-- Limit the percentage to actually 0 and 100 and divide it by 100 to get multiplier
	int_percentage = math_setbounds(0, 100, int_percentage) / 100
	
	-- Draw background
	draw.Color(gui.GetValue(0, 0, 0, 255))
	draw.FilledRect(vec2_pos[1], vec2_pos[2], vec2_pos[1] + vec2_size[1], vec2_pos[2] + vec2_size[2])
	
	-- Draw progress
	draw.Color(clr_progress[1], clr_progress[2], clr_progress[3], clr_progress[4])
	if bool_vertical then
		draw.FilledRect(vec2_pos[1] + vec2_size[1], vec2_pos[2] + vec2_size[2], vec2_pos[1], vec2_pos[2] + vec2_size[2] * (1 - int_percentage) )
		vec2_progressPos = {vec2_pos[1] + vec2_size[1] / 2, vec2_pos[2] + vec2_size[2] * (1 - int_percentage)}
	else
		draw.FilledRect(vec2_pos[1], vec2_pos[2], vec2_pos[1] + (vec2_size[1] * int_percentage), vec2_pos[2] + vec2_size[2])
		vec2_progressPos = {vec2_pos[1] + (vec2_size[1] * int_percentage), vec2_pos[2] + vec2_size[2]}
	end
	
	-- Draw outline
	draw.Color(gui.GetValue(0, 0, 0, 255))
	draw.OutlinedRect(vec2_pos[1], vec2_pos[2], vec2_pos[1] + vec2_size[1], vec2_pos[2] + vec2_size[2])
	
	-- Draw label if provided
	if str_valuelabel ~= nil then
		draw.SetFont(font_tiny)
		draw.Color(255, 255, 255, 255)
		local vec2_labelSize = {draw.GetTextSize(str_valuelabel)}
		draw.TextShadow(vec2_progressPos[1] - vec2_labelSize[1] / 2, vec2_progressPos[2] - vec2_labelSize[2] / 2, str_valuelabel)
	end	
end

-- Callbacks
local function onFrame_gatherdata()
	-- Get local player
	ent_LocalPlayer = entities.GetLocalPlayer()
	
	-- Get server ip
	str_ServerIP = engine.GetServerIP()
	
	-- Get screen size
	vec2_ScreenSize = {draw.GetScreenSize()}
	
	-- Check for game
	if ent_LocalPlayer == nil or str_ServerIP == nil then
		if bool_inGame then
			bool_inGame = false
		end
		return
	end
	
	-- Set inGame variable
	bool_inGame = true
	
	-- Get local shootpos (m_vecViewOffset[0] gets all 3 vector components despite the indexing)
	vec3_LocalShootPos = {vector.Add({ent_LocalPlayer:GetAbsOrigin()}, {ent_LocalPlayer:GetPropVector("localdata", "m_vecViewOffset[0]")})}
end
callbacks.Register("Draw", onFrame_gatherdata)

local function onEvent_teamDamage(GameEvent)
	
	-- On player hit
	if GameEvent:GetName() == "player_hurt" or GameEvent:GetName() == "player_death" then
		local ent_victim = entities.GetByUserID(GameEvent:GetInt("userid"))
		local ent_attacker = entities.GetByUserID(GameEvent:GetInt("attacker"))
		
		-- Return in case something is nil
		if ent_victim == nil or ent_attacker == nil then
			return
		end
		
		-- Return if attacker is victim
		if ent_victim:GetIndex() == ent_attacker:GetIndex() then
			return
		end
		
		local attacker_pinfo = client.GetPlayerInfo(ent_attacker:GetIndex())
		
		-- Return if playerinfo is nil
		if attacker_pinfo == nil then
			return
		end
		
		local attacker_steamid = attacker_pinfo["SteamID"]
		
		-- Return if steamid is nil
		if attacker_steamid == nil then
			return
		end
		
		-- If friendly-fire and local player's teammate
		if ent_attacker:GetTeamNumber() == ent_victim:GetTeamNumber() and ent_attacker:GetTeamNumber() == ent_LocalPlayer:GetTeamNumber() then	
		
			-- Add empty array if nil
			if list_teamdamage[attacker_steamid] == nil then
				list_teamdamage[attacker_steamid] = {0, 0, ent_attacker:GetName(), entities:GetPlayerResources():GetPropInt("m_iCompTeammateColor", ent_attacker:GetIndex())}
			end
			
			if GameEvent:GetName() == "player_hurt" then
				-- Increase team damage amount by the damage dealt
				list_teamdamage[attacker_steamid][1] = list_teamdamage[attacker_steamid][1] + GameEvent:GetInt("dmg_health")
			else
				-- Increase teamkill count by one
				list_teamdamage[attacker_steamid][2] = list_teamdamage[attacker_steamid][2] + 1
			end
		end
	end

end
client.AllowListener("player_hurt")
client.AllowListener("player_death")
callbacks.Register("FireGameEvent", onEvent_teamDamage)

local function onMove_handleRequests(UserCmd)	
	-- Get buttons
	int_LocalButtons = UserCmd:GetButtons()
	
	-- Get view angles
	vec_ViewAngles = {UserCmd:GetViewAngles()}
	
	-- Handle button requests
	local int_PendingButtons = int_LocalButtons
	
	for int_index, bool_request in pairs(list_ButtonRequest) do
		if bool_request then
			if not bit_GetBit(int_PendingButtons, int_index) then
				-- Add requested button to pending buttons
				int_PendingButtons = int_PendingButtons + (1 << int_index)
			end
		end
	end

	if int_PendingButtons ~= int_LocalButtons then
		UserCmd:SetButtons(int_PendingButtons)
	end
end
callbacks.Register("CreateMove", onMove_handleRequests)

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

callbacks.Register( "Draw", "drag", dragFeature)


local function onFrame_teamDamage()
	-- Check for game
	if not bool_inGame then
		-- Clear the list
		list_teamdamage = {}
		return
	end
	
	-- Check for enabled
	if gui.GetValue("msc_teamdamage") < 1 then
		return
	end
	
	-- Check for scoreboard
	if not bit_GetBit(int_LocalButtons, buttons.IN_SCORE) then
		return
	end
	
	-- Draw background
	draw.Color(gui.GetValue("clr_gui_window_background"))
	draw.FilledRect( vec2_ScreenSize[1] * 0.775, vec2_ScreenSize[2] * 0.225, vec2_ScreenSize[1] * 0.975, vec2_ScreenSize[2] * 0.250)

	-- Draw header
	draw.Color(gui.GetValue("clr_gui_text1"))
	draw.SetFont(font_header)
	draw.TextShadow(vec2_ScreenSize[1] * 0.780, vec2_ScreenSize[2] * 0.2375 - select(2, draw.GetTextSize("Team Damage Dealers")) / 2, "Team Damage Dealers")
	
	-- Draw meanies
	local int_drawnCount = 0
	for int_index, list_damage in pairs(list_teamdamage) do
		
		-- Draw background
		if int_drawnCount % 2 == 0 then
			draw.Color(130, 130, 130, 125)
		else
			draw.Color(80, 80, 80, 125)
		end
		
		local str_name = list_damage[3]
		
		-- Crop name if it's too long
		if str_name:len() > 14 then
			str_name = str_name:sub(1, 14) .. "..."
		end
		
		-- Draw background
		draw.FilledRect( vec2_ScreenSize[1] * 0.775, vec2_ScreenSize[2] * 0.250 + (vec2_ScreenSize[2] * 0.025 * int_drawnCount), vec2_ScreenSize[1] * 0.975, vec2_ScreenSize[2] * 0.250 + (vec2_ScreenSize[2] * 0.025 * (int_drawnCount + 1)) )
		
		-- Draw kills
		draw.Color(gui.GetValue("clr_gui_text1"))
		draw.SetFont(font_main)
		draw.TextShadow(vec2_ScreenSize[1] * 0.970 - select(1, draw.GetTextSize(list_damage[2] .. " Team Kills")), vec2_ScreenSize[2] * 0.2625 + (vec2_ScreenSize[2] * 0.025 * int_drawnCount) - select(2, draw.GetTextSize(str_name)) / 2, list_damage[2] .. " Team Kills")
		-- Draw name
		if gui.GetValue("msc_teamdamage") == 2 then
			-- Jump -2 color to -1
			local mmcolor = mmcolors[math.max(list_damage[4], -1)]
			draw.Color(mmcolor[2][1], mmcolor[2][2], mmcolor[2][3], mmcolor[2][4])
		end
		draw.TextShadow(vec2_ScreenSize[1] * 0.780, vec2_ScreenSize[2] * 0.2625 + (vec2_ScreenSize[2] * 0.025 * int_drawnCount) - select(2, draw.GetTextSize(str_name)) / 2, str_name)
		-- Draw damage dealt
		draw_progressbar({vec2_ScreenSize[1] * 0.875, vec2_ScreenSize[2] * 0.2625 + (vec2_ScreenSize[2] * 0.025 * int_drawnCount)}, {vec2_ScreenSize[2] * 0.1, vec2_ScreenSize[2] * 0.01}, {255, 0, 0, 255}, {0, 255, 0, 255}, (list_damage[1] / client.GetConVar("mp_td_dmgtokick")) * 100, true, false, list_damage[1] .. "/" .. client.GetConVar("mp_td_dmgtokick") .. "hp")
		
		int_drawnCount = int_drawnCount + 1
	end
	

dragFeature()
	
end

callbacks.Register("Draw", onFrame_teamDamage)

local function onFrame_selfGrenade()
	-- Check for game
	if not bool_inGame then
		return
	end
	
	-- Prevent stuck keys
	if int_selfNadeStart ~= nil and int_selfNadeStart ~= true then
		if globals.CurTime() - int_selfNadeStart > 1 then
			list_ButtonRequest[buttons.IN_ATTACK] = false
			list_ButtonRequest[buttons.IN_ATTACK2] = false
		end
	end
	
	-- Check for enabled
	if gui.GetValue("msc_selfnade") == 0 then
		return	
	elseif not input.IsButtonDown(gui.GetValue("msc_selfnade")) then
		-- Reset nade throw
		if int_selfNadeStart == true then
			int_selfNadeStart = nil
		end
		return
	end
	
	-- Check for completed throw
	if int_selfNadeStart == true then
		return
	end

	local str_info = "Throwing"
	local vec_LocalHeadPos = {ent_LocalPlayer:GetHitboxPosition(1)} -- For checking the roof height
	local ent_LocalWeapon = ent_LocalPlayer:GetPropEntity("m_hActiveWeapon")
	
	-- Return if weapon is nil
	if ent_LocalWeapon == nil then
		return
	end
	
	if not ent_LocalWeapon:GetName():find("hegrenade") then
		str_info = "Equip HE grenade"
	elseif vector.Length({ent_LocalPlayer:GetPropVector("localdata", "m_vecVelocity[0]")}) > 0 then
		str_info = "Stand still"
	elseif select(2, engine.TraceLine(vec3_LocalShootPos[1], vec3_LocalShootPos[2], vec3_LocalShootPos[3], vec3_LocalShootPos[1], vec3_LocalShootPos[2], vec3_LocalShootPos[3] + 130, 0x1)) < 1 then
		str_info = "Ceiling is too close"
	elseif vec_ViewAngles[1] > -88.975 then
		str_info = "Look straight up"
	elseif int_selfNadeStart == nil then
		int_selfNadeStart = globals.CurTime()
		list_ButtonRequest[buttons.IN_ATTACK2] = true
	else
		if globals.CurTime() - int_selfNadeStart > 0.75 then
			list_ButtonRequest[buttons.IN_ATTACK] = true
		end
	
		if globals.CurTime() - int_selfNadeStart > 0.75 + gui.GetValue("msc_selfnade_modifier") / 100 then
			list_ButtonRequest[buttons.IN_ATTACK] = false
			list_ButtonRequest[buttons.IN_ATTACK2] = false
			int_selfNadeStart = true
		end
	end
	
	draw.SetFont(font_header)
	draw.Color(gui.GetValue("clr_gui_text1"))
	draw.TextShadow(vec2_ScreenSize[1] / 2 - select(1, draw.GetTextSize(str_info)) / 2, vec2_ScreenSize[2] * 0.075 - select(2, draw.GetTextSize(str_info)) / 2, str_info)

end
callbacks.Register("Draw", onFrame_selfGrenade)

local function onEsp_grenadeInfo(EspBuilder)

	-- Check for enabled
	if not gui.GetValue("esp_other_grenadethrower") then
		return
	end

	local bool_isGrenade = false
	local ent_Entity = EspBuilder:GetEntity()
	
	-- Check if the entity is a grenade
	for int_index, str_grenade in pairs(list_grenades) do
		if ent_Entity:GetClass() == str_grenade then
			bool_isGrenade = true
			break
		end
	end
	
	-- Return if not a grenade
	if not bool_isGrenade then 
		return
	end

	-- Get thrower
	local ent_Thrower = ent_Entity:GetPropEntity("m_hThrower")
	if ent_Thrower == nil then 
		return
	end
	
	EspBuilder:AddTextBottom(ent_Thrower:GetName())
	
end
callbacks.Register("DrawESP", onEsp_grenadeInfo)

local function onFrame_grenadeInfo()

	-- Check for game
	if not bool_inGame then
		return
	end
	
	-- Check for enabled
	if not gui.GetValue("esp_active") or not gui.GetValue("esp_filter_grenades") or not gui.GetValue("esp_other_grenadethrower") then
		return
	end
	
	draw.SetFont(font_header)
	draw.Color(gui.GetValue("clr_gui_text1"))
	
	local int_visFilter = gui.GetValue("esp_visibility_other")

	for int_index, ent_molly in pairs(entities.FindByClass("CInferno")) do
		
		local vec_mollyTag = {vector.Add({ent_molly:GetAbsOrigin()}, {0, 0, 30})}
		local vec2_wtsMollyTag = {client.WorldToScreen(vec_mollyTag[1], vec_mollyTag[2], vec_mollyTag[3])}
		local ent_mollyOwner = ent_molly:GetPropEntity("m_hOwnerEntity")
		
		-- Gotta add nil checks everywhere
		if vec2_wtsMollyTag[1] ~= nil and vec2_wtsMollyTag[2] ~= nil and ent_mollyOwner ~= nil then
			
			-- Visibility check
			local int_traceContents = engine.TraceLine(vec3_LocalShootPos[1], vec3_LocalShootPos[2], vec3_LocalShootPos[3], vec_mollyTag[1], vec_mollyTag[2], vec_mollyTag[3], (0x1 | 0x2) )
	
			if int_visFilter == 0 or (int_traceContents == 0 and int_visFilter == 1) or (int_traceContents == 1 and int_visFilter == 2) then
				local str_label = ent_molly:GetPropEntity("m_hOwnerEntity"):GetName()
				
				-- Yes, more nil and empty checks
				if str_label ~= nil then
					if str_label ~= "" then
						draw.TextShadow(vec2_wtsMollyTag[1] - select(1, draw.GetTextSize(str_label)) / 2, vec2_wtsMollyTag[2] - select(2, draw.GetTextSize(str_label)) / 2, str_label)
					end		
				end
				
			end
			
		end
		
	end
	
end
callbacks.Register("Draw", onFrame_grenadeInfo)