-- Walkbot by ShadyRetard

local walkbot_aimbot = {}
local walkbot = nil

local visible_enemy_players = {}
local HITBOXES = {6, 5, 0, 1, 4, 3, 2, 7, 8, 9, 10, 15, 16, 17, 18}
local angle_target = nil
local last_shot = nil
local angle_target_is_enemy = false
local last_command = nil

local function set_aim_angle(angle, is_enemy)
    angle_target = angle
    angle_target_is_enemy = is_enemy
end

local function check_hitbox_visibility(esp_builder)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (gui.GetValue("rbot.master") == true and gui.GetValue("rbot.aim.enable") == true) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local enemy_player = esp_builder:GetEntity()
    if (enemy_player:IsPlayer() == false or enemy_player:GetTeamNumber() == 0 or enemy_player:GetTeamNumber() == 1 or enemy_player:GetTeamNumber() == local_player:GetTeamNumber()) then
        return
    end

    local visible_enemy_hitboxes = {}
    for i=1, #HITBOXES do

        local hitbox_trace = engine.TraceLine(
            local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]"),
            enemy_player:GetHitboxPosition(HITBOXES[i])
        )


        if (hitbox_trace.entity == nil) then
            table.insert(visible_enemy_hitboxes, enemy_player:GetHitboxPosition(HITBOXES[i]))
        end
    end

    if (#visible_enemy_hitboxes > 0) then
        table.insert(visible_enemy_players, {
            ["entity"] = enemy_player,
            ["hitboxes"] = visible_enemy_hitboxes,
            ["updated_at"] = globals.RealTime()
        })
    end
end

local function remove_dormant_players()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    for i=#visible_enemy_players, 1, -1 do
        if (globals.RealTime() - visible_enemy_players[i]["updated_at"] > 0.1) then
            table.remove(visible_enemy_players, i)
        end
    end
end

local function enemy_aim_position(local_player)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (gui.GetValue("rbot.master") == true and gui.GetValue("rbot.aim.enable") == true) then return end
    local closest_hitbox = nil
    local closest_hitbox_distance = nil

    for i=1, #visible_enemy_players do
        local enemy = visible_enemy_players[i]

        local first_hitbox = enemy["hitboxes"][1]
        local distance = (local_player:GetAbsOrigin() - first_hitbox):Length()

        local hitbox_distance = distance
        if (closest_hitbox == nil or hitbox_distance < closest_hitbox_distance) then
            closest_hitbox_distance = hitbox_distance
            closest_hitbox = first_hitbox
        end
    end

    return closest_hitbox
end

local function update_aim_angle()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (gui.GetValue("rbot.master") == true and gui.GetValue("rbot.aim.enable") == true) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local aim_position = nil
    local is_enemy = false

    if (#visible_enemy_players > 0) then
        aim_position = enemy_aim_position(local_player)
        is_enemy = true
    else
        angle_target = nil
        local current_area = walkbot.mesh_manager.current_area()
        if (current_area == nil) then return end
        local path_index = walkbot.mesh_navigation.is_on_current_path(current_area.id)
        if (path_index == nil) then return end
        local next_area = walkbot.mesh_navigation.route_to_target()[path_index + 2]
        if (next_area == nil) then 
            next_area = walkbot.mesh_navigation.route_to_target()[path_index + 1]
            if (next_area == nil) then
                return
            end
        end

        aim_position = walkbot.mesh_manager.center_of_node(next_area)
        aim_position["z"] = aim_position["z"] + 64
    end
    local aim_angles = (aim_position - (local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]"))):Angles()

    local weapon_recoil_scale = client.GetConVar("weapon_recoil_scale")
    local punch_angle = local_player:GetPropVector("localdata", "m_Local", "m_aimPunchAngle")
    set_aim_angle(aim_angles - EulerAngles(punch_angle["x"] * weapon_recoil_scale, punch_angle["y"] * weapon_recoil_scale, 0), is_enemy)
end

local function aim(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (gui.GetValue("rbot.master") == true and gui.GetValue("rbot.aim.enable") == true) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (angle_target == nil) then return end

    local angle = (engine.GetViewAngles() - angle_target)

    if (angle["yaw"] > 300) then
        angle["yaw"] = (360 - angle["yaw"]) * -1
    elseif (angle["yaw"] < -300) then
        angle["yaw"] = (-360 - angle["yaw"]) * -1
    end

    local current_weapon = local_player:GetPropEntity("m_hActiveWeapon")
    local ammo = current_weapon:GetPropInt("m_iClip1")

    local smoothing = walkbot.config.aim_smoothing

    if (angle_target_is_enemy and angle["pitch"] < walkbot.config.aimbot_fov and angle["yaw"] < walkbot.config.aimbot_fov) then
        smoothing = walkbot.config.aimbot_smoothing
    end

    if (
        angle_target_is_enemy
        and angle["pitch"] < walkbot.config.aimbot_fov
        and angle["yaw"] < walkbot.config.aimbot_fov
        and ammo > 0
        and (
            globals.CurTime() >= current_weapon:GetPropFloat("LocalActiveWeaponData", "m_flNextPrimaryAttack")
            or (last_shot == nil or globals.CurTime() - last_shot >= 1)
        )
    ) then
        cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_ATTACK)
        last_shot = globals.CurTime()
        walkbot.movement.set_movement_speed(0)
    end

    local pitch = angle["pitch"] / smoothing
    local yaw = angle["yaw"] / smoothing

    engine.SetViewAngles(engine.GetViewAngles() - EulerAngles(pitch, yaw, 0))
end

local function current_weapon_name(current_weapon)
    local weapon_name = current_weapon:GetClass();
    weapon_name = weapon_name:gsub("CWeapon", "");
    weapon_name = weapon_name:lower();

    if (weapon_name:sub(1, 1) == "c") then
        weapon_name = weapon_name:sub(2)
    end

    return weapon_name
end

local function is_under_threshold(weapons, threshold, weapon_name, ammo)
    for i=1, #weapons do
        if (weapon_name == weapons[i] and ammo < threshold) then
            return true
        end
    end

    return false
end

local function switch_to_gun(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    local current_weapon = local_player:GetPropEntity("m_hActiveWeapon")
    if (current_weapon == nil) then return end

    if (bit.band(cmd.buttons, walkbot.objective_use.IN_USE) ~= 0 or bit.band(cmd.buttons, walkbot.objective_use.IN_ATTACK) ~= 0) then
        return
    end

    local ammo = current_weapon:GetPropInt("m_iClip1")
    local ammo_reserve = current_weapon:GetPropInt("m_iPrimaryReserveAmmoCount")

    if (ammo == 0 and ammo_reserve == 0) then
        if (last_command == nil or globals.RealTime() - last_command > 1) then
            client.Command("drop", true)
            last_command = globals.RealTime()
        end
        return
    end

    local weapon_name = current_weapon_name(current_weapon)

    if ((last_command == nil or globals.RealTime() - last_command > 1) and (weapon_name == "c4" or weapon_name == "knife" or weapon_name == "smokegrenade" or weapon_name == "flashbang" or weapon_name == "molotovgrenade" or weapon_name == "hegrenade")) then
        client.Command("slot2", true)
        client.Command("slot2", true)
        last_command = globals.RealTime()
    end
end

local function reload(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    if (angle_target_is_enemy) then return end

    local current_weapon = local_player:GetPropEntity("m_hActiveWeapon")
    if (current_weapon == nil) then return end

    local weapon_name = current_weapon_name(current_weapon)

    local ammo = current_weapon:GetPropInt("m_iClip1")

    if (
        is_under_threshold({"glock", "elite", "p250", "cz75a", "tec9", "hkp2000", "fiveseven"}, walkbot.config.reload_threshold_pistol, weapon_name, ammo)
        or is_under_threshold({"deagle", "awp", "g3sg1", "ssg08", "scar20"}, walkbot.config.reload_threshold_sniper, weapon_name, ammo)
        or is_under_threshold({"mac10", "mp7", "ump45", "p90", "bizon", "mp9"}, walkbot.config.reload_threshold_smg, weapon_name, ammo)
        or is_under_threshold({"nova", "xm1014", "sawedoff", "mag7"}, walkbot.config.reload_threshold_shotgun, weapon_name, ammo)
        or is_under_threshold({"m249", "negev"}, walkbot.config.reload_threshold_heavy, weapon_name, ammo)
        or is_under_threshold({"galilar", "ak47", "sg556", "famas", "m4a1", "m4a1_silencer", "aug"}, walkbot.config.reload_threshold_rifle, weapon_name, ammo)
    ) then
        cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_RELOAD)
    end
end

local function initialize()
    callbacks.Register("DrawESP", "walkbot_aimbot_check_head_visibility", check_hitbox_visibility)
    callbacks.Register("CreateMove", "walkbot_aimbot_remove_dormant_players", remove_dormant_players)
    callbacks.Register("CreateMove", "walkbot_aimbot_update_aim_angle", update_aim_angle)
    callbacks.Register("CreateMove", "walkbot_aimbot_aim", aim)
    callbacks.Register("CreateMove", "walkbot_aimbot_reload", reload)
    callbacks.Register("CreateMove", "walkbot_aimbot_switch_to_gun", switch_to_gun)
end

function walkbot_aimbot.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_aimbot