-- Walkbot by ShadyRetard

local walkbot_movement = {}
local walkbot = nil
local movement_speed = 250
local last_jump = nil
local last_use = nil
local last_shot = nil
local last_movement_speed_update = globals.RealTime()
local last_ladder_time = globals.RealTime()
local unstuck_attempt = 0
local last_unstuck_attempt = nil

function walkbot_movement.set_movement_speed(speed)
    movement_speed = speed
    last_movement_speed_update = globals.RealTime()
end

local function is_within_intersection(intersection, player_origin)
    return player_origin["x"] >= intersection[1]["x"] - 20 and player_origin["x"] <= intersection[2]["x"] + 20 and player_origin["y"] >= intersection[1]["y"] - 20 and player_origin["y"] <= intersection[3]["y"] + 20
end

local function player_velocity(player)
    local vx = player:GetPropFloat('localdata', 'm_vecVelocity[0]');
    local vy = player:GetPropFloat('localdata', 'm_vecVelocity[1]');

    return math.floor(math.min(10000, math.sqrt(vx * vx + vy * vy) + 0.5))
end

local function find_nearby_entity(class_name, position)
    local doors = entities.FindByClass(class_name)

    for i=1, #doors do
        if ((doors[i]:GetAbsOrigin() - position):Length() <= 100) then
            return doors[i]
        end
    end
end

local function corner_one(connection)
    local direction = connection.direction

    if (direction == 1) then
        return connection.intersection[1]
    elseif (direction == 2) then
        return connection.intersection[2]
    elseif (direction == 3) then
        return connection.intersection[3]
    elseif (direction == 4) then
        return connection.intersection[1]
    end
end

local function corner_two(connection)
    local direction = connection.direction

    if (direction == 1) then
        return connection.intersection[2]
    elseif (direction == 2) then
        return connection.intersection[3]
    elseif (direction == 3) then
        return connection.intersection[4]
    elseif (direction == 4) then
        return connection.intersection[4]
    end
end

local function movement(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end

    if (bit.band(cmd.buttons, walkbot.objective_use.IN_ATTACK) ~= 0) then
        walkbot_movement.set_movement_speed(0)
    end

    if (bit.band(cmd.buttons, walkbot.objective_use.IN_USE) ~= 0) then
        walkbot_movement.set_movement_speed(0)
    end

    if (movement_speed == 0) then
        if (globals.RealTime() - last_movement_speed_update > 0.3 and bit.band(cmd.buttons, walkbot.objective_use.IN_ATTACK) == 0 and bit.band(cmd.buttons, walkbot.objective_use.IN_USE) == 0) then
            walkbot_movement.set_movement_speed(250)
        end
        return
    end

    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    local player_origin = local_player:GetAbsOrigin()

    if (walkbot.mesh_navigation.route_to_target() == nil) then return end

    local current_area = walkbot.mesh_manager.current_area()
    if (current_area == nil) then return end

    local path_index = walkbot.mesh_navigation.is_on_current_path(current_area.id)
    if (path_index == nil) then return end

    local next_area = walkbot.mesh_navigation.route_to_target()[path_index + 1]

    if (current_area == nil) then return end
    local final_destination = walkbot.mesh_navigation.final_destination()

    if (next_area == nil and (final_destination ~= nil and (local_player:GetAbsOrigin() - final_destination):Length() > 50)) then
        local angle_to_target = (final_destination - player_origin):Angles()
        cmd.forwardmove = math.cos(math.rad((engine:GetViewAngles() - angle_to_target).y)) * movement_speed
        cmd.sidemove = math.sin(math.rad((engine:GetViewAngles() - angle_to_target).y)) * movement_speed
        return
    end

    if (next_area == nil) then
        walkbot.objective.force_new_objective()
        return
    end

    local connection_to_next_area = walkbot.mesh_manager.find_connection_to_target_id(current_area, next_area.id)
    local point_to_walk_to = walkbot.mesh_manager.connection_walking_point(connection_to_next_area)

    if (player_velocity(local_player) < 10) then
        if (last_unstuck_attempt == nil or globals.RealTime() - last_unstuck_attempt > 2) then
            last_unstuck_attempt = globals.RealTime()
            last_use = nil
            unstuck_attempt = unstuck_attempt + 1
        end

        local first_nearby_door = find_nearby_entity("CBasePropDoor", player_origin)
        local first_nearby_breakable_prop = find_nearby_entity("CBreakableProp", player_origin)
        if (first_nearby_door ~= nil and (last_use == nil or globals.TickCount() - last_use > 32)) then
            local aim_point = (first_nearby_door:GetAbsOrigin() - (local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]"))):Angles() * -1
            aim_point["pitch"] = 0
            cmd.viewangles = aim_point
            cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_USE)
            last_use = globals.TickCount()
        end

        if (first_nearby_breakable_prop ~= nil and (first_nearby_door == nil or (first_nearby_breakable_prop:GetAbsOrigin() - first_nearby_door:GetAbsOrigin()):Length() > 0) and (last_shot == nil or globals.TickCount() - last_shot > 32)) then
            local aim_point = (first_nearby_breakable_prop:GetAbsOrigin() - player_origin):Angles()
            aim_point["pitch"] = 0
            cmd.viewangles = aim_point
            cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_ATTACK)
            last_shot = globals.TickCount()
        end


        if (unstuck_attempt == 1) then
            point_to_walk_to = walkbot.mesh_manager.center_of_node(next_area)
        elseif (unstuck_attempt == 2) then
            point_to_walk_to = corner_one(connection_to_next_area)
        elseif (unstuck_attempt == 3) then
            point_to_walk_to = corner_two(connection_to_next_area)
        elseif (unstuck_attempt == 4) then
            cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_JUMP)
        elseif (unstuck_attempt == 5) then
            unstuck_attempt = 0
            if (bit.band(cmd.buttons, walkbot.objective_use.IN_USE) ~= 0) then
                walkbot.objective.force_new_objective()
            end
        end
    elseif(last_unstuck_attempt == nil or globals.RealTime() - last_unstuck_attempt > 2) then
        unstuck_attempt = 0
    end

    local angle_to_target = (point_to_walk_to - player_origin):Angles()
    cmd.forwardmove = math.cos(math.rad((engine:GetViewAngles() - angle_to_target).y)) * movement_speed
    cmd.sidemove = math.sin(math.rad((engine:GetViewAngles() - angle_to_target).y)) * movement_speed

    if (connection_to_next_area.ladder_direction ~= nil or (globals.RealTime() - last_ladder_time < 5 and #current_area.ladders > 0)) then
        cmd.viewangles = angle_to_target
        cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_FORWARD)
        last_ladder_time = globals.RealTime()
    end

    if (
        (last_jump == nil or globals.RealTime() - last_jump > 1)
        and bit.band(current_area.flags, walkbot.mesh_manager.NAV_MESH_NO_JUMP) == 0
        and (
            point_to_walk_to["z"] - player_origin["z"] > 18
            or (
                (bit.band(next_area.flags,  walkbot.mesh_manager.NAV_MESH_STAIRS) ~= 0
                 or bit.band(next_area.flags,  walkbot.mesh_manager.NAV_MESH_JUMP) ~= 0)
                and walkbot.mesh_manager.center_of_node(next_area)["z"] > player_origin["z"])
            )
        and is_within_intersection(connection_to_next_area.intersection, player_origin)
    ) then
        last_jump = globals.RealTime()
        cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_JUMP)
    end

    if (
        (last_jump ~= nil and globals.RealTime() - last_jump < 0.3)
        or bit.band(current_area.flags, walkbot.mesh_manager.NAV_MESH_CROUCH) ~= 0
        or (
            is_within_intersection(connection_to_next_area.intersection, player_origin)
            and bit.band(next_area.flags, walkbot.mesh_manager.NAV_MESH_CROUCH) ~= 0)
        ) then
        cmd.buttons = bit.bor(cmd.buttons, walkbot.objective_use.IN_DUCK)
    end
end

local function initialize()
    callbacks.Register("CreateMove", "walkbot_movement_movement", movement)
end

function walkbot_movement.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_movement