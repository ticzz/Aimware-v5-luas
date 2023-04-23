RunScript("Gznsters walkbot_mesh.lua");

-- Mesh Walkbot by ShadyRetard
local RESET_TIMEOUT = 30;
local RETARGET_TIMEOUT = 150;
local STUCK_TIMEOUT = 100;
local MESHWALK_MIN_DISTANCE = 15;
local STUCK_SPEED_MAX = 10;
local SHOT_TIMEOUT = 20;
local COMMAND_TIMEOUT = 100;
local AIMBOT_TIMEOUT = 25;
local RELOAD_THRESHOLD_PISTOL = 8;
local RELOAD_THRESHOLD_SNIPER = 3;
local RELOAD_THRESHOLD_SMG = 13;
local RELOAD_THRESHOLD_RIFLE = 10;
local RELOAD_THRESHOLD_SHOTGUN = 3;
local RELOAD_THRESHOLD_HEAVY = 30;

local SCRIPT_FILE_NAME = GetScriptName();

local VERSION_NUMBER = "1.0.0";
local version_check_done = false;


local WALKBOT_ENABLE_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_ENABLE_CB", "Enable Walkbot", false);
local WALKBOT_DRAWING_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_DRAWING_CB", "Walkbot Drawing", false);
local WALKBOT_TARGET_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_TARGET_CB", "Walkbot Target Enemies", false);
local WALKBOT_AUTORELOAD_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_AUTORELOAD_CB", "Walkbot Smart Reload", false);
local WALKBOT_AUTODEFUSE_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_AUTODEFUSE_CB", "Walkbot Autodefuse", false);
local WALKBOT_ANTIKICK_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Other"), "WALKBOT_ANTIKICK_CB", "Walkbot Anti-Kick", false);
local ANTIKICK_VOTE_THRESHOLD = gui.Slider(gui.Reference("MISC", "AUTOMATION", "Other"), "ANTIKICK_VOTE_THRESHOLD", "Scramble threshold %:", 80, 1, 100);
local WALKBOT_ENABLE_SETANGLE_CB = gui.Checkbox(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_ENABLE_SETANGLE_CB", "Walkbot Change Angles", false);
local WALKBOT_SMOOTHING_SLIDER = gui.Slider(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_SMOOTHING_SLIDER", "Walkbot Angle Smoothing", 40, 1, 100);
local WALKBOT_MOVEMENT_SPEED = gui.Slider(gui.Reference("MISC", "AUTOMATION", "Movement"), "WALKBOT_MOVEMENT_SPEED", "Walkbot walking speed", 250, 0, 250);

local last_command = globals.TickCount();
local aimbot_target_change_time = globals.TickCount();
local last_target_time = globals.TickCount();
local speed_slow_since = globals.TickCount();
local last_reset = globals.TickCount();
local last_shot = globals.TickCount();
local aimbot_target;
local is_shooting;
local is_defusing = false;
local moving_to_defuse = false;
local round_started;
local kick_command_id = 1;
local kick_potential_votes = 0;
local kick_yes_voters = 0;
local kick_getting_kicked = false;
local kick_last_command_time;
local last_ax, last_ay, last_az;

local current_map;
local current_map_name;
local next_target;
local path_to_follow;
local next_point;
local current_index;


function drawEventHandler()
    if (WALKBOT_ENABLE_CB:GetValue() == false) then
        return
    end

    if (WALKBOT_DRAWING_CB:GetValue() == false) then
        return;
    end

    if (path_to_follow == nil) then
        return;
    end

    local me = entities.GetLocalPlayer();
    if (me == nil) then
        return;
    end

    local my_x, my_y, my_z = me:GetAbsOrigin();
    for i=1, #path_to_follow do
        local mx, my = client.WorldToScreen(path_to_follow[i].x, path_to_follow[i].y, path_to_follow[i].z);

        if (mx ~= nil and my ~= nil and i >= current_index) then
            draw.Color(255,255,255,255);
            draw.Text(mx, my+10, i);
            draw.Color(255,0,0,255);
            draw.FilledRect(mx-4, my-4, mx+4, my+4);


            -- Also draw lines in between the rectangles
            if (i < #path_to_follow) then
                local m2x, m2y = client.WorldToScreen(path_to_follow[i+1].x, path_to_follow[i+1].y, path_to_follow[i+1].z);
                draw.Line(mx, my, m2x, m2y);
            end
        end
    end
end

function moveEventHandler(cmd)
    if (WALKBOT_ENABLE_CB:GetValue() == false) then
        return;
    end

    local active_map_name = engine.GetMapName();
    -- If we don't have an active map, stop
    if (active_map_name == nil) then
        return;
    end

    updateMap(active_map_name);

    local me = entities.GetLocalPlayer();

    if (current_map == nil or me == nil) then
        round_started = nil;
        last_shot = nil;
        is_shooting = false;
        last_command = nil;
        aimbot_target_change_time = nil;
        path_to_follow = nil;
        current_index = nil;
        last_reset = nil;
        next_target = nil;
        is_defusing = false;
        next_point = nil;
        moving_to_defuse = false;
        return;
    end

    if (round_started == false) then
        return;
    end

    doTimerReset();

    local my_x, my_y, my_z = me:GetAbsOrigin();
    if (is_defusing) then
        local bombs = entities.FindByClass("CPlantedC4");
        local bomb;
        for i=1, #bombs do
            if (bombs[i]:IsAlive()) then
                bomb = bombs[i];
            end
        end

        local bx, by, bz = bomb:GetAbsOrigin();
        local va_x, va_y, va_z = getAngle(my_x, my_y, my_z + 64, bx, by, bz);

        next_target = nil;
        path_to_follow = nil;
        current_index = nil;
        cmd:SetViewAngles(va_x, va_y, va_z);
        return;
    end

    local my_weapon = me:GetPropEntity("m_hActiveWeapon");
    doSmartReload(my_weapon, cmd);


    if (is_shooting and (last_shot == nil or globals.TickCount() - last_shot > SHOT_TIMEOUT)) then
        is_shooting = false;
    elseif (is_shooting) then
        -- We're shooting, stand still and let the aimbot do its thing
        return;
    end

    if (aimbot_target ~= nil and (aimbot_target_change_time == nil or globals.TickCount() - aimbot_target_change_time < AIMBOT_TIMEOUT)) then
        return;
    elseif(aimbot_target ~= nil) then
        aimbot_target = nil;
    end

    if (not me:IsAlive()) then
        path_to_follow = nil;
        current_index = nil;
        return;
    end

    local closest_enemy = getClosestPlayer(my_x, my_y, my_z);
    -- Auto enemy targeting
    if (WALKBOT_TARGET_CB:GetValue() == true and (last_target_time == nil or globals.TickCount() - last_target_time > RETARGET_TIMEOUT)) then
        if (closest_enemy ~= nil) then
            local ex, ey, ez = closest_enemy:GetAbsOrigin();
            path_to_follow = nil;
            current_index = nil;
            last_target_time = globals.TickCount();
            next_target = getClosestMesh(ex, ey, ez);
        end
    end

    -- Auto defusing
    if (WALKBOT_AUTODEFUSE_CB:GetValue() == true and me:GetTeamNumber() == 3 and closest_enemy == nil) then
        -- Find the bomb
        local bombs = entities.FindByClass("CPlantedC4");
        local bomb;
        for i=1, #bombs do
            if (bombs[i]:IsAlive()) then
                bomb = bombs[i];
            end
        end

        -- We have a bomb
        if (bomb ~= nil) then
            local bx, by, bz = bomb:GetAbsOrigin();
            -- Check if we are within range
            local distance = getDistanceToTarget(my_x, my_y, 0, bx, by, 0);
            local va_x, va_y, va_z = getAngle(my_x, my_y, 0, bx, by, 0);

            -- Defuse when in range
            if (distance < 60 and is_defusing == false) then
                is_defusing = true;
                client.Command("+use", true);
                return;
            end

            if (distance < 120 and is_defusing == false) then
                doMovement(va_x, va_y, va_z, cmd);
                moving_to_defuse = true;
                is_defusing = false;
                return;
            end

            moving_to_defuse = false;
            is_defusing = false;

            if (last_target_time == nil or globals.TickCount() - last_target_time > RETARGET_TIMEOUT) then
                last_target_time = globals.TickCount();
                path_to_follow = nil;
                current_index = nil;
                next_target = getClosestMesh(bx, by, bz);
            end
        end
    end

    doStuckCheck(cmd);

    -- If we currently don't have a target, get the closest mesh
    if (moving_to_defuse == false and path_to_follow == nil and (last_reset == nil or globals.TickCount() - last_reset > RESET_TIMEOUT)) then
        last_reset = globals.TickCount();
        local start_point = getClosestMesh(my_x, my_y, my_z);
        local end_point;
        if (next_target ~= nil) then
            end_point = next_target;
            next_target = nil;
        else
            end_point = current_map['nodes'][math.random(1, #current_map['nodes'])];
        end

        path_to_follow = path(start_point, end_point, current_map['nodes'], current_map['edges'], false);

        if (path_to_follow == nil) then
            return;
        end
    elseif (path_to_follow == nil) then
        return;
    end

    -- Start the path
    if (current_index == nil) then
        local first_point = path_to_follow[1];

        if (first_point ~= nil and next_point ~= nil and
            (
                (first_point.x == next_point.x and first_point.y == next_point.y and first_point.z == next_point.z)
                or (getDistanceToTarget(my_x, my_y, my_z, next_point.x, next_point.z, next_point.y) < getDistanceToTarget(my_x, my_y, my_z, first_point.x, first_point.z, first_point.y))
            )
        ) then
            current_index = 2;
        else
            current_index = 1;
        end
        -- Path ended, reset and retrieve a new path
    elseif (current_index == #path_to_follow) then
        current_index = nil;
        path_to_follow = nil;
        return;
    end

    local vx = me:GetPropFloat('localdata', 'm_vecVelocity[0]');
    local vy = me:GetPropFloat('localdata', 'm_vecVelocity[1]');
    local speed = math.floor(math.min(10000, math.sqrt(vx * vx + vy * vy) + 0.5));

    if (speed < STUCK_SPEED_MAX) then
        if (speed_slow_since == nil) then
            speed_slow_since = globals.TickCount();
            return;
        end

        if (globals.TickCount() - speed_slow_since > STUCK_TIMEOUT) then
            current_index = nil;
            path_to_follow = nil;
            return;
        end
    else
        speed_slow_since = nil;
    end

    local target = path_to_follow[current_index];
    if (target == nil) then
        current_index = nil;
        path_to_follow = nil;
        return;
    end

    next_point = path_to_follow[current_index + 1];

    local distance = getDistanceToTarget(my_x, my_y, 0, target["x"], target["y"], 0);

    -- We're close enough to the center of the mesh, pick the next target for 'smoothing' reasons
    if (distance < MESHWALK_MIN_DISTANCE) then
        current_index = current_index + 1;
        return;
    end

    -- Calculating the angle from the current target (absolute position)
    local wa_x, wa_y, wa_z = getAngle(my_x, my_y, my_z, target["x"], target["y"], target["z"]);
    local smoothing_factor = WALKBOT_SMOOTHING_SLIDER:GetValue();
    if (WALKBOT_ENABLE_SETANGLE_CB:GetValue()) then
        if (last_ax == nil) then
            last_ax, last_ay, last_az = cmd:GetViewAngles();
        end

        local new_x, new_y, new_z = last_ax - ((last_ax - wa_x) / smoothing_factor), last_ay - ((last_ay - wa_y) / smoothing_factor), last_az - ((last_az - wa_z) / smoothing_factor);
        cmd:SetViewAngles(new_x, new_y, new_z);
        last_ax, last_ay, last_az = new_x, new_y, new_z;
    end

    doMovement(wa_x, wa_y, wa_z, cmd);
end

function aimbotTargetHandler(ent)
    if (ent ~= nil) then
        aimbot_target_change_time = globals.TickCount();
        aimbot_target = ent;
    end
end

function updateMap(active_map_name)
    if (current_map_name ~= active_map_name) then
        -- Newer format (de_dust2)
        current_map = maps[active_map_name];

        -- Support for older versions that use the naming convention de_dust.bsp
        if (current_map == nil) then
            current_map = maps[active_map_name .. ".bsp"];
        end

        current_map_name = active_map_name;
    end
end

function kickEventHandler(event)
    local self_pid = client.GetLocalPlayerIndex();
    local self = entities.GetLocalPlayer();
    local this_map_name = engine.GetMapName();

    if (this_map_name == nil) then
        return;
    end

    updateMap(this_map_name);

    if (WALKBOT_ANTIKICK_CB:GetValue() == false or self_pid == nil or self == nil or current_map_name == nil) then
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

            -- We're voting NO, which means somebody else already voted yes
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
                client.Command("callvote ChangeLevel " .. current_map_name);
                kick_command_id = 1;
            end

            kick_last_command_time = globals.CurTime();
        end
    end
end

function gameEventHandler(event)
    local self_pid = client.GetLocalPlayerIndex();
    local self = entities.GetLocalPlayer();

    if (self_pid == nil or self == nil) then
        return;
    end

    if (event:GetName() == "round_start") then
        is_shooting = false;
        speed_slow_since = nil;
        path_to_follow = nil;
        current_index = nil;
        client.Command("-use", true);
        is_defusing = false;
    end

    if (event:GetName() == "round_freeze_end") then
        round_started = true;
    end

    if (event:GetName() == "round_officially_ended") then
        round_started = false;
        moving_to_defuse = false;
    end

    if (event:GetName() == "player_death") then
        local victim_pid = client.GetPlayerIndexByUserID(event:GetInt('userid'));

        if (aimbot_target ~= nil and aimbot_target:GetIndex() == victim_pid) then
            aimbot_target = nil;
        end
    end


    if (event:GetName() == "weapon_fire") then
        local shooter_pid = client.GetPlayerIndexByUserID(event:GetInt('userid'));
        local shooter = entities.GetByUserID(event:GetInt('userid'));

        if (shooter == nil) then
            return;
        end

        if (shooter_pid == self_pid) then
            is_shooting = true;
            last_shot = globals.TickCount();
        end
    end
end

function getClosestMesh(my_x, my_y, my_z)
    local closestMesh;
    local closestDistance;
    local nodes = current_map["nodes"];

    for k, v in pairs(nodes) do
        if (v ~= nil) then
            local distance = getDistanceToTarget(my_x, my_y, my_z, v["x"], v["y"], v["z"]);
            -- We don't want to go back to the last target
            if (closestDistance == nil or distance < closestDistance) then
                closestDistance = distance;
                closestMesh = v;
            end
        end
    end

    return closestMesh;
end

function getClosestPlayer(my_x, my_y, my_z)
    local closestPlayer;
    local closestDistance = 1000000; -- Arbitrary high number
    local players = entities.FindByClass("CCSPlayer");
    local self = entities.GetLocalPlayer();

    if (self == nil) then
        return;
    end

    for i = 1, #players do
        local player = players[i]
        -- We don't want to target ourselves or dead players
        if (player:GetIndex() ~= client.GetLocalPlayerIndex() and player:IsAlive() and player:GetTeamNumber() ~= self:GetTeamNumber()) then
            -- Find the closest player
            local px, py, pz = player:GetAbsOrigin();
            local distance = getDistanceToTarget(my_x, my_y, my_z, px, py, pz);
            if (distance < closestDistance) then
                closestDistance = distance;
                closestPlayer = player;
            end
        end
    end

    if (closestDistance == 1000000 or closestPlayer == nil) then
        return;
    end;

    return closestPlayer;
end

function doTimerReset()
    if (last_reset ~= nil and last_reset > globals.TickCount()) then
        last_reset = globals.TickCount();
    end

    if (last_command ~= nil and last_command > globals.TickCount()) then
        last_command = globals.TickCount();
    end

    if (last_target_time ~= nil and last_target_time > globals.TickCount()) then
        last_target_time = globals.TickCount();
    end

    if (aimbot_target_change_time ~= nil and aimbot_target_change_time > globals.TickCount()) then
        aimbot_target_change_time = globals.TickCount();
    end

    if (last_shot ~= nil and last_shot > globals.TickCount()) then
        last_shot = globals.TickCount();
    end
end

function doStuckCheck(cmd)
    -- If we've been stopped for a while, let's try to get unstuck
    if (speed_slow_since ~= nil) then

        if (globals.TickCount() - speed_slow_since > STUCK_TIMEOUT) then
            path_to_follow = nil;
            current_index = nil;
            speed_slow_since = nil;
            return;
        end

        if (globals.TickCount() - speed_slow_since > 80) then
            -- Move left or right randomly
            if (math.random() * 2 == 1) then
                cmd:SetSideMove(WALKBOT_MOVEMENT_SPEED:GetValue());
            end

            -- Move forward or back randomly
            if (math.random() * 2 == 1) then
                cmd:SetForwardMove(WALKBOT_MOVEMENT_SPEED:GetValue());
            end
        end

        if (globals.TickCount() - speed_slow_since > 60) then
            if (cmd:GetButtons() == 4 and math.random() * 2 == 1) then
                cmd:SetButtons(1);
            else
                cmd:SetButtons(4);
            end
        elseif (globals.TickCount() - speed_slow_since > 40) then
            -- Press spacebar to jump
            cmd:SetButtons(2);
        elseif (globals.TickCount() - speed_slow_since > 20) then
            -- Press E to open any doors
            cmd:SetButtons(32);
        end
    end
end

function doMovement(wa_x, wa_y, wa_z, cmd)
    local va_x, va_y, va_z = cmd:GetViewAngles();
    local d_v;
    local f1, f2;

    if (wa_y < 0.) then
        f1 = 360.0 + wa_y;
    else
        f1 = wa_y;
    end

    if (va_y < 0.0) then
        f2 = 360.0 + va_y;
    else
        f2 = va_y;
    end

    if (f2 < f1) then
        d_v = math.abs(f2 - f1);
    else
        d_v = 360.0 - math.abs(f1 - f2);
    end

    d_v = 360.0 - d_v;
    cmd:SetForwardMove(math.cos(d_v * (math.pi / 180)) * WALKBOT_MOVEMENT_SPEED:GetValue());
    cmd:SetSideMove(math.sin(d_v * (math.pi / 180)) * WALKBOT_MOVEMENT_SPEED:GetValue());
end

function doSmartReload(my_weapon, cmd)
    if (WALKBOT_AUTORELOAD_CB:GetValue() == true and my_weapon == nil) then
        if (last_command == nil or globals.TickCount() - last_command > (COMMAND_TIMEOUT)) then
            client.Command("slot2", true);
            client.Command("slot1", true);
            last_command = globals.TickCount();
        end
        return;
    end

    if (WALKBOT_AUTORELOAD_CB:GetValue() == true and my_weapon ~= nil) then
        local weapon_name = my_weapon:GetClass();
        weapon_name = weapon_name:gsub("CWeapon", "");
        weapon_name = weapon_name:lower();

        if (weapon_name:sub(1, 1) == "c") then
            weapon_name = weapon_name:sub(2)
        end

        if (weapon_name == "c4" and (last_command == nil or globals.TickCount() - last_command > (COMMAND_TIMEOUT))) then
            client.Command("drop", true);
            last_command = globals.TickCount();
            return;
        end

        local ammo = my_weapon:GetPropInt("m_iClip1");
        local ammo_reserve = my_weapon:GetPropInt("m_iPrimaryReserveAmmoCount");

        if (ammo == 0 and ammo_reserve == 0) then
            if (last_command == nil or globals.TickCount() - last_command > (COMMAND_TIMEOUT)) then
                client.Command("drop", true);
                last_command = globals.TickCount();
            end
        end

        if (weapon_name == "knife" or weapon_name == "smokegrenade" or weapon_name == "flashbang" or weapon_name == "molotovgrenade" or weapon_grenade == "hegrenade") then
            if (last_command == nil or globals.TickCount() - last_command > (COMMAND_TIMEOUT)) then
                client.Command("slot2", true);
                client.Command("slot1", true);
                last_command = globals.TickCount();
            end
        end

        -- Determine if we need to reload
        if (not is_shooting and aimbot_target == nil) then
            if (
            ((weapon_name == "glock" or weapon_name == "elite" or weapon_name == "p250" or weapon_name == "cz75a" or weapon_name == "tec9" or weapon_name == "hkp2000" or weapon_name == "fiveseven") and ammo < RELOAD_THRESHOLD_PISTOL)
                    or ((weapon_name == "mac10" or weapon_name == "mp7" or weapon_name == "ump45" or weapon_name == "p90" or weapon_name == "bizon" or weapon_name == "mp9") and ammo < RELOAD_THRESHOLD_SMG)
                    or ((weapon_name == "deagle" or weapon_name == "awp" or weapon_name == "g3sg1" or weapon_name == "ssg08" or weapon_name == "scar20") and ammo < RELOAD_THRESHOLD_SNIPER)
                    or ((weapon_name == "nova" or weapon_name == "xm1014" or weapon_name == "sawedoff" or weapon_name == "mag7") and ammo < RELOAD_THRESHOLD_SHOTGUN)
                    or ((weapon_name == "m249" or weapon_name == "negev") and ammo < RELOAD_THRESHOLD_HEAVY)
                    or ((weapon_name == "galilar" or weapon_name == "ak47" or weapon_name == "sg556" or weapon_name == "famas" or weapon_name == "m4a1" or weapon_name == "m4a1_silencer" or weapon_name == "aug") and ammo < RELOAD_THRESHOLD_RIFLE)
            ) then
                cmd:SetButtons(8192);
            end
        end
    end
end

function vectorAngles(d_x, d_y, d_z)
    local t_x;
    local t_y;
    local t_z;
    if (d_x == 0 and d_y == 0) then
        if (d_z > 0) then
            t_x = 270;
        else
            t_x = 90;
        end
        t_y = 0;
    else
        t_x = math.atan(-d_z, math.sqrt(d_x ^ 2 + d_y ^ 2)) * -180 / math.pi;
        t_y = math.atan(d_y, d_x) * 180 / math.pi;

        if (t_y > 90) then
            t_y = t_y - 180;
        elseif (t_y < 90) then
            t_y = t_y + 180;
        elseif (t_y == 90) then
            t_y = 0;
        end
    end

    t_z = 0;

    return t_x, t_y, t_z;
end

function normalizeAngles(a_x, a_y, a_z)
    while (a_x > 89.0) do
        a_x = a_x - 180.;
    end

    while (a_x < -89.0) do
        a_x = a_x + 180.;
    end

    while (a_y > 180.) do
        a_y = a_y - 360;
    end

    while (a_y < -180.) do
        a_y = a_y + 360;
    end

    return a_x, a_y, a_z;
end

function getAngle(my_x, my_y, my_z, t_x, t_y, t_z)
    local d_x = my_x - t_x;
    local d_y = my_y - t_y;
    local d_z = my_z - t_z;

    local va_x, va_y, va_z = vectorAngles(d_x, d_y, d_z);
    return normalizeAngles(va_x, va_y, va_z);
end

function getDistanceToTarget(my_x, my_y, my_z, t_x, t_y, t_z)
    local dx = my_x - t_x;
    local dy = my_y - t_y;
    local dz = my_z - t_z;
    return math.sqrt(dx^2 + dy^2 + dz^2);
end

local INF = 1 / 0;
local cachedPaths;

function dist(x1, y1, z1, x2, y2, z2)
    local dx = x1 - x2;
    local dy = y1 - y2;
    local dz = z1 - z2;

    return math.sqrt(dx^2 + dy^2 + dz^2);
end

function dist_between(nodeA, nodeB)
    return dist(nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z)
end

function heuristic_cost_estimate(nodeA, nodeB)
    return dist(nodeA.x, nodeA.y, nodeA.z, nodeB.x, nodeB.y, nodeB.z)
end

function lowest_f_score(set, f_score)
    local lowest, bestNode = INF, nil
    for _, node in ipairs(set) do
        local score = f_score[node]
        if score < lowest then
            lowest, bestNode = score, node
        end
    end
    return bestNode
end

function neighbor_nodes(theNode, nodes, edges)
    local neighbors = {}

    local neighbor_ids = edges[theNode.id];

    for _, node in ipairs(nodes) do
        if (neighbor_ids ~= nil and #neighbor_ids > 0 and not not_in(neighbor_ids, node.id)) then
            table.insert(neighbors, node);
        end
    end
    return neighbors
end

function not_in(set, theNode)
    for _, node in ipairs(set) do
        if node == theNode then return false end
    end
    return true
end

function remove_node(set, theNode)
    for i, node in ipairs(set) do
        if node == theNode then
            set[i] = set[#set]
            set[#set] = nil
            break
        end
    end
end

function unwind_path(flat_path, map, current_node)
    if map[current_node] then
        table.insert(flat_path, 1, map[current_node])
        return unwind_path(flat_path, map, map[current_node])
    else
        return flat_path
    end
end

function a_star(start, goal, nodes, edges)
    local closedset = {}
    local openset = { start }
    local came_from = {}

    local g_score, f_score = {}, {}
    g_score[start] = 0
    f_score[start] = g_score[start] + heuristic_cost_estimate(start, goal)

    while #openset > 0 do

        local current = lowest_f_score(openset, f_score)
        if current == goal then
            local path = unwind_path({}, came_from, goal)
            table.insert(path, goal)
            return path
        end

        remove_node(openset, current)
        table.insert(closedset, current)

        local neighbors = neighbor_nodes(current, nodes, edges)

        for _, neighbor in ipairs(neighbors) do
            if not_in(closedset, neighbor) then

                local tentative_g_score = g_score[current] + dist_between(current, neighbor)

                if not_in(openset, neighbor) or tentative_g_score < g_score[neighbor] then
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)
                    if not_in(openset, neighbor) then
                        table.insert(openset, neighbor)
                    end
                end
            end
        end
    end
    return nil -- no valid path
end
function clear_cached_paths()
    cachedPaths = nil
end

function distance(x1, y1, z1, x2, y2, z2)
    return dist(x1, y1, z1, x2, y2, z2);
end

function path(start, goal, nodes, edges, ignore_cache)

    if not cachedPaths then cachedPaths = {} end
    if not cachedPaths[start] then
        cachedPaths[start] = {}
    elseif cachedPaths[start][goal] and not ignore_cache then
        return cachedPaths[start][goal]
    end

    local resPath = a_star(start, goal, nodes, edges)
    if not cachedPaths[start][goal] and not ignore_cache then
        cachedPaths[start][goal] = resPath
    end

    return resPath
end

client.AllowListener("game_start");
client.AllowListener("vote_changed");
client.AllowListener("vote_cast");
client.AllowListener("round_freeze_end");
client.AllowListener("round_officially_ended");
callbacks.Register("Draw", "walkbot_draw_event", drawEventHandler);
callbacks.Register("FireGameEvent", "walkbot_game_event", gameEventHandler);
callbacks.Register("FireGameEvent", "walkbot_antikick_event", kickEventHandler);
callbacks.Register("CreateMove", "walkbot_move", moveEventHandler);
callbacks.Register("AimbotTarget", "walkbot_aimbot_target", aimbotTargetHandler);


--***********************************************--

print(GetScriptName() .. "  loaded without Errors ♥♥♥")
--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")