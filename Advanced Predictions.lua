-- using Scape's per weapon gui library https://github.com/lennonc1atwit/Luas/tree/master/Per%20Weapon%20Gui

local WEAPON_GROUPBOX_NAMES    = {"Shared", "Zeus", "Pistol", "Heavy Pistol", "Submachine Gun", "Rifle", "Shotgun", "Scout", "Auto Sniper", "Sniper", "Light Machine Gun"}
local WEAPON_SNIPER_CONVERSION = {["weapon_awp"] = "Sniper", ["weapon_g3sg1"] = "Auto Sniper", ["weapon_scar20"] = "Auto Sniper", ["weapon_ssg08"] = "Scout"}
local WEAPON_GROUPBOX_VARNAMES = {"shared", "zeus", "pistol", "hpistol", "smg", "rifle", "shotgun", "scout", "asniper", "sniper", "lmg"}
local WEAPON_TYPE_TO_NAME = {[0] = "Zeus", [1] = "Pistol", [2]= "Submachine Gun", [3] = "Rifle", [4] = "Shotgun", [6] = "Light Machine Gun"}
local PERWEAPON_ELEMENTS = {}

local function CreatePerWeaponCheckbox(parent, varname, name, value, description)
    local ID = #PERWEAPON_ELEMENTS + 1
    PERWEAPON_ELEMENTS[ID] = {}

    if type(parent) == "userdata" then
        for i = 1, 11 do
            local weapon = WEAPON_GROUPBOX_VARNAMES[i]

            local e = gui.Checkbox(parent, weapon.."."..varname, name, value)
            e:SetDescription(description)

            PERWEAPON_ELEMENTS[ID][WEAPON_GROUPBOX_NAMES[i]] =  {e, parent}
        end
    elseif type(parent) == "table" then -- Multi box parent
        for i = 1, 11 do
            local weapon = WEAPON_GROUPBOX_VARNAMES[i]

            local e = gui.Checkbox(parent[WEAPON_GROUPBOX_NAMES[i]][1], weapon.."."..varname, name, value)
            PERWEAPON_ELEMENTS[ID][WEAPON_GROUPBOX_NAMES[i]] =  {e, parent[WEAPON_GROUPBOX_NAMES[i]][2]}
        end
    end

    return PERWEAPON_ELEMENTS[ID]
end

local function CreatePerWeaponSlider(parent, varname, name, value, min, max, step, description)
    local ID = #PERWEAPON_ELEMENTS + 1
    PERWEAPON_ELEMENTS[ID] = {}

    for i = 1, 11 do
        local weapon = WEAPON_GROUPBOX_VARNAMES[i]

        local e = gui.Slider(parent, weapon.."."..varname, name, value, min, max, step)
        e:SetDescription(description)

        PERWEAPON_ELEMENTS[ID][WEAPON_GROUPBOX_NAMES[i]] =  {e, parent}
    end

    return PERWEAPON_ELEMENTS[ID]
end

local function CreatePerWeaponCombobox(parent, varname, name, description, ...) 
    local ID = #PERWEAPON_ELEMENTS + 1
    PERWEAPON_ELEMENTS[ID] = {}
    
    for i = 1, 11 do
        local weapon = WEAPON_GROUPBOX_VARNAMES[i]

        local e = gui.Combobox(parent, weapon.."."..varname, name, ...)
        e:SetDescription(description)

        PERWEAPON_ELEMENTS[ID][WEAPON_GROUPBOX_NAMES[i]] =  {e, parent}
    end
    
    return PERWEAPON_ELEMENTS[ID]
end

local function CreatePerWeaponMultibox(parent, name, description)
    local ID = #PERWEAPON_ELEMENTS + 1
    PERWEAPON_ELEMENTS[ID] = {}

    for i = 1, 11 do
        local e = gui.Multibox(parent, name)
        PERWEAPON_ELEMENTS[ID][WEAPON_GROUPBOX_NAMES[i]] =  {e, parent}
        e:SetDescription(description)
    end

    return PERWEAPON_ELEMENTS[ID]
end

local function getActiveWeaponIndex(ref)
    local active_weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    local weapon_name = active_weapon:GetName()
		
    if ref:GetValue() == "\"Shared\"" then
        return "Shared"
    elseif weapon_name == "weapon_revolver" or weapon_name == "weapon_deagle" then -- heavy pistol filter
        return "Heavy Pistol"
    elseif active_weapon:GetWeaponType() == 5 then -- snipers
         return WEAPON_SNIPER_CONVERSION[weapon_name]
    else
        return WEAPON_TYPE_TO_NAME[active_weapon:GetWeaponType()]
    end
end

local function getActiveWeaponVar(ref)
    local index = getActiveWeaponIndex(ref)

    for i = 1, 11 do 
        if WEAPON_GROUPBOX_NAMES[i] == index then
            return WEAPON_GROUPBOX_VARNAMES[i]
        end
    end
end

local function RefreshGUI()
    if gui.Reference("Menu"):IsActive() then
        for ID, group in pairs(PERWEAPON_ELEMENTS) do 
            for key, element in pairs(group) do
                if key == string.gsub(element[2]:GetValue(), "\"", "") then
                    element[1]:SetInvisible(false)
                else 
                    element[1]:SetInvisible(true)
                end
            end
        end
    end
end

local function ShutDown()
    for ID, group in pairs(PERWEAPON_ELEMENTS) do 
        for key, element in pairs(group) do
           element[1]:Remove()
        end
    end
end


callbacks.Register("Unload", ShutDown)
callbacks.Register("Draw", RefreshGUI)


local weapon_ref = gui.Reference("Ragebot", "Accuracy", "Weapon")

local min_damage_visible = CreatePerWeaponSlider(weapon_ref, "Chicken.dynamic_min_dmg.DamageVisible", "Damage Visible", 1, 1, 100, 1, "Min damage when aimbot target is visible.")
local min_damage_invisible = CreatePerWeaponSlider(weapon_ref, "Chicken.dynamic_min_dmg.DamageInvisible", "Damage Invisible", 1, 1, 100, 1, "Min damage when aimbot target is behind a wall")

local show_debug_window = gui.Checkbox(weapon_ref, "Chicken.dynamic_min_dmg.damage", "Show adaptive min damage debug window", false)

local debug_window = gui.Window("Chicken.dynamic_min_dmg.window", "Adaptive Min Damage Debug Window", 15, 15, 300, 570)

local debug_show_velocity_prediction_text  = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.draw_velocity_text", "Draw velocity prediction text", false)
local debug_show_tracers = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.draw_tracers", "Draw tracers", false)
local debug_draw_min_dmg = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.draw_min_damage", "Draw min damage at crosshair", true)

local debug_prediction_amount = gui.Slider(debug_window, "Chicken.dynamic_min_dmg.prediction_amount", "Prection amount", 0.2, 0, 1, 0.001)
debug_prediction_amount:SetDescription("How much to predict your velocity by.")

local debug_point_scale_amount = gui.Slider(debug_window, "Chicken.dynamic_min_dmg.hitbox_pointscale", "Hitbox point scale", 0, 0, 4)
debug_point_scale_amount:SetDescription("Increasing this number will impact your fps.")


local debug_hitbox_text = gui.Text(debug_window, "Hitboxes to check if the player is visible or not (You  can save FPS by checking less hitboxes)")

local debug_hitbox_head = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_head", "Head", true)
local debug_hitbox_chest = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_chest", "Chest", true)
local debug_hitbox_pelvis = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_Pelvis", "Pevlis", true)

local debug_hitbox_leftarm = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_leftarm", "Left Arm", false)
local debug_hitbox_rightarm = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_rightarm", "Right Arm", false)

local debug_hitbox_leftleg = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_leftleg", "Left Leg", false)
local debug_hitbox_rightleg = gui.Checkbox(debug_window, "Chicken.dynamic_min_dmg.debug.hitbox_rightleft", "Right Leg", false)



local cached_min_damages = {}
local function set_current_min_damage() -- sets the vis / invis sliders to the weapon's current min damage, so weapons min damages don't get set to 1 when you run this lua
	for i, v in ipairs(WEAPON_GROUPBOX_VARNAMES) do
		local current_min_dmg = gui.GetValue("rbot.hitscan.accuracy." .. v .. ".mindamage")
		
		local wep_group_name = WEAPON_GROUPBOX_NAMES[i]
		
		min_damage_visible[wep_group_name][1]:SetValue(current_min_dmg)
		min_damage_invisible[wep_group_name][1]:SetValue(current_min_dmg)
		
	end
end

set_current_min_damage()



local function is_vis(LocalPlayerPos)
    local is_vis = false
    local players = entities.FindByClass("CCSPlayer")
    local fps = 1
    for i, player in pairs(players) do
        if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and player:IsPlayer() and player:IsAlive() then
            for i = 0, 18 do
				if   i == 0 and debug_hitbox_head:GetValue() or
					 i == 6 and debug_hitbox_chest:GetValue() or
					 i == 3 and debug_hitbox_pelvis:GetValue() or
					 
					 i == 18 and debug_hitbox_leftarm:GetValue() or
					 i == 16 and debug_hitbox_rightarm:GetValue() or
					 
					 i == 7 and debug_hitbox_leftleg:GetValue() or
					 i == 8 and debug_hitbox_rightleg:GetValue() then
			
					for x = 0, debug_point_scale_amount:GetValue() do
						local v = player:GetHitboxPosition(i)
						if x == 0 then
							v.x = v.x
							v.y = v.y
						elseif x == 1 then
							v.x = v.x
							v.y = v.y + 4
						elseif x == 2 then
							v.x = v.x
							v.y = v.y - 4
						elseif x == 3 then
							v.x = v.x + 4
							v.y = v.y
						elseif x == 4 then
							v.x = v.x - 4
							v.y = v.y
						end

						local c = (engine.TraceLine(LocalPlayerPos, v, 0x1)).contents
						
						local x,y = client.WorldToScreen(LocalPlayerPos)
						local x2,y2 = client.WorldToScreen(v)
						
						
						if c == 0 then draw.Color(0,255,0) else draw.Color(225,0,0) end
						if debug_show_tracers:GetValue() and x and x2 then
							draw.Line(x,y,x2,y2)
						end
						
						
						if c == 0 then
							is_vis = true
							break
						end
						
						
					end
				end
            end
        end
    end
    return is_vis
end


function predict_velocity(entity, prediction_amount)
	local VelocityX = entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
	local VelocityY = entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
	local VelocityZ = entity:GetPropFloat( "localdata", "m_vecVelocity[2]" );
	
	absVelocity = {VelocityX, VelocityY, VelocityZ}
	
	pos_ = {entity:GetAbsOrigin()}
	
	modifed_velocity = {vector.Multiply(absVelocity, prediction_amount)}
	
	
	return {vector.Subtract({vector.Add(pos_, modifed_velocity)}, {0,0,0})}
end

local menu = gui.Reference("MENU")
callbacks.Register("Draw", function()
	debug_window:SetActive(show_debug_window:GetValue() and menu:IsActive())

	local LocalPlayer = entities.GetLocalPlayer()
	
	if not LocalPlayer or not LocalPlayer:IsAlive() then return end
	
	local my_pos = LocalPlayer:GetAbsOrigin()
	local prediction = predict_velocity(LocalPlayer, debug_prediction_amount:GetValue())
	
	local x,y,z = vector.Add(
		{my_pos.x, my_pos.y, my_pos.z},
		{prediction[1], prediction[2], prediction[3]}
	)

	local LocalPlayer_predicted_pos = Vector3(x,y,z)
	LocalPlayer_predicted_pos.z = LocalPlayer_predicted_pos.z + LocalPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z
	
	
	local index = getActiveWeaponIndex(weapon_ref)
	local current_weapon_ui_name = getActiveWeaponVar(weapon_ref)
	local visible = is_vis(LocalPlayer_predicted_pos)
	if index then
		if visible then
			gui.SetValue("rbot.hitscan.accuracy." .. current_weapon_ui_name .. ".mindamage", min_damage_visible[index][1]:GetValue())
		else
			gui.SetValue("rbot.hitscan.accuracy." .. current_weapon_ui_name .. ".mindamage", min_damage_invisible[index][1]:GetValue())
		end
	end
	
	if debug_draw_min_dmg:GetValue() then
		local current_weapon_min_dmg = gui.GetValue("rbot.hitscan.accuracy." .. current_weapon_ui_name .. ".mindamage")
		local t_x, t_y = draw.GetTextSize(current_weapon_min_dmg)

		
		local s_w, s_h = draw.GetScreenSize()
		if visible then draw.Color(0,255,0) else draw.Color(255,0,0)  end
		draw.Text(s_w / 2 - t_x / 2, s_h / 2 - 20, current_weapon_min_dmg)
	end

	if debug_show_velocity_prediction_text:GetValue() then
		local x, y = client.WorldToScreen(LocalPlayer_predicted_pos)
		local t_x, t_y = draw.GetTextSize("Velocity Prediction")
		draw.Color(255,255,255)
		draw.Text(x - t_x / 2,y, "Velocity Prediction")
	end
end)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")