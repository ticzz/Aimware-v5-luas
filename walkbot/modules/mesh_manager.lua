-- Walkbot by ShadyRetard

local walkbot_mesh_manager = {}
local walkbot = nil

local current_area = nil
local cached_areas = {}
local cached_connections = {}
local current_mesh = nil

walkbot_mesh_manager.NAV_MESH_CROUCH = bit.lshift(1, 0)
walkbot_mesh_manager.NAV_MESH_JUMP = bit.lshift(1, 1)
walkbot_mesh_manager.NAV_MESH_NO_JUMP = bit.lshift(1, 3)
walkbot_mesh_manager.NAV_MESH_STAIRS = bit.lshift(1, 13)

function walkbot_mesh_manager.set_mesh(mesh_data)
    current_mesh = mesh_data
    current_area = nil
    cached_areas = {}
    cached_connections = {}
end

function walkbot_mesh_manager.areas()
    if (current_mesh == nil) then return end
    return current_mesh.areas
end

function walkbot_mesh_manager.find_place_by_id(place_id)
    if (current_mesh == nil) then return end
    if (current_mesh.places == nil) then return end
    local found_place = nil

    for i=1, #current_mesh.places do
        local place = current_mesh.places[i]

        if (place.id == place_id) then
            found_place = place
            break;
        end
    end

    return found_place
end

function walkbot_mesh_manager.is_current_area(area_id)
    if (current_area == nil) then return false end
    return area_id == current_area.id
end

function walkbot_mesh_manager.find_closest_area(area_vector)
    if (current_mesh == nil) then return end

    local within_areas = {}

    for i=1, #current_mesh.areas do
        local area = current_mesh.areas[i]

        if (area_vector.x >= area.north_west.x and
            area_vector.x <= area.south_east.x and
            area_vector.y >= area.north_west.y and
            area_vector.y <= area.south_east.y and
            #area.connections > 0
        ) then
            table.insert(within_areas, area)
        end
    end

    if (#within_areas > 0) then
        local within_areas_closest = nil
        local within_areas_closest_distance = 99999
        for i=1, #within_areas do
            local area = within_areas[i]
            local z_distance = math.abs((area_vector.z - area.north_west.z) + (area_vector.z - area.south_east.z))

            if z_distance <= within_areas_closest_distance then
                within_areas_closest_distance = z_distance

                within_areas_closest = area
            end
        end
        return within_areas_closest
    end

    local closest_area = nil
    local closest_area_distance = 99999
    for i=1, #current_mesh.areas do
        local area = current_mesh.areas[i]

        if (#area.connections > 0) then
            local distance = (area_vector - walkbot_mesh_manager.center_of_node(area)):Length()

            if distance < closest_area_distance then
                closest_area_distance = distance
                closest_area = area
            end
        end
    end

    return closest_area
end

function walkbot_mesh_manager.find_area_by_id(area_id)
    if (current_mesh == nil) then return end

    if (cached_areas[area_id] ~= nil) then
        return cached_areas[area_id]
    end

    local found_area = nil

    for i=1, #current_mesh.areas do
        local area = current_mesh.areas[i]

        if (area.id == area_id) then
            found_area = area
            break;
        end
    end

    if (found_area == nil) then return end

    cached_areas[area_id] = found_area

    return found_area
end

function walkbot_mesh_manager.find_ladder_by_id(ladder_id)
    if (current_mesh == nil) then return end
    local found_ladder = nil

    for i=1, #current_mesh.ladders do
        local ladder = current_mesh.ladders[i]

        if (ladder.id == ladder_id) then
            found_ladder = ladder
            break;
        end
    end

    return found_ladder
end

local function find_z_at_location(point1, point2, location)
    local z_angle = math.tan(math.rad((point1 - point2):Angles()["pitch"]))
    return point1["z"] + z_angle * (Vector3(point1["x"], point1["y"], 0) - location):Length()
end

local function intersection_north(area, connection_area)
    local north_y = connection_area.south_east.y
    local south_y = area.north_west.y
    local west_x = 0
    local east_x = 0

    local north_west_z = 0
    local north_east_z = 0
    local south_east_z = 0
    local south_west_z = 0

    if (area.north_west.x >= connection_area.north_west.x) then
        west_x = area.north_west.x
        south_west_z = area.north_west.z

        north_west_z = find_z_at_location(
            Vector3(connection_area.north_west.x, connection_area.south_east.y, connection_area.south_west_z),
            Vector3(connection_area.south_east.x, connection_area.south_east.y, connection_area.south_east.z),
            Vector3(area.north_west.x, area.north_west.y, 0)
        )

        if (area.north_west.x == connection_area.north_west.x) then
            north_west_z = connection_area.south_west_z
        end
    else
        west_x = connection_area.north_west.x
        north_west_z = connection_area.south_west_z

        south_west_z = find_z_at_location(
            Vector3(area.north_west.x, area.north_west.y, area.north_west.z),
            Vector3(area.south_east.x, area.north_west.y, area.north_east_z),
            Vector3(connection_area.north_west.x, area.north_west.y, 0)
        )
    end

    if (area.south_east.x <= connection_area.south_east.x) then
        east_x = area.south_east.x
        south_east_z = area.north_east_z

        north_east_z = find_z_at_location(
            Vector3(connection_area.north_west.x, connection_area.south_east.y, connection_area.south_west_z),
            Vector3(connection_area.south_east.x, connection_area.south_east.y, connection_area.south_east.z),
            Vector3(area.south_east.x, area.north_west.y, 0)
        )

        if (area.south_east.x == connection_area.south_east.x) then
            north_east_z = connection_area.south_east.z
        end
    else
        east_x = connection_area.south_east.x
        north_east_z = connection_area.south_east.z

        south_east_z = find_z_at_location(
            Vector3(area.north_west.x, area.north_west.y, area.north_west.z),
            Vector3(area.south_east.x, area.north_west.y, area.north_east_z),
            Vector3(connection_area.south_east.x, area.north_west.y, 0)
        )
    end

    return Vector3(west_x, north_y, north_west_z), Vector3(east_x, north_y, north_east_z), Vector3(east_x, south_y, south_east_z), Vector3(west_x, south_y, south_west_z)
end

local function intersection_west(area, connection_area)
    local north_y = 0
    local south_y = 0
    local west_x = connection_area.south_east.x
    local east_x = area.north_west.x

    local north_west_z = 0
    local north_east_z = 0
    local south_east_z = 0
    local south_west_z = 0

    if (area.north_west.y >= connection_area.north_west.y) then
        north_y = area.north_west.y
        north_east_z = area.north_west.z

        north_west_z = find_z_at_location(
            Vector3(connection_area.south_east.x, connection_area.north_west.y, connection_area.north_east_z),
            Vector3(connection_area.south_east.x, connection_area.south_east.y, connection_area.south_east.z),
            Vector3(area.north_west.x, area.north_west.y, 0)
        )

        if (area.north_west.y == connection_area.north_west.y) then
            north_west_z = connection_area.north_east_z
        end
    else
        north_y = connection_area.north_west.y
        north_west_z = connection_area.north_east_z

        north_east_z = find_z_at_location(
            Vector3(area.north_west.x, area.north_west.y, area.north_west.z),
            Vector3(area.north_west.x, area.south_east.y, area.south_west_z),
            Vector3(connection_area.south_east.x, connection_area.north_west.y, 0)
        )
    end

    if (area.south_east.y <= connection_area.south_east.y) then
        south_y = area.south_east.y
        south_east_z = area.south_west_z

        south_west_z = find_z_at_location(
            Vector3(connection_area.south_east.x, connection_area.north_west.y, connection_area.north_east_z),
            Vector3(connection_area.south_east.x, connection_area.south_east.y, connection_area.south_east.z),
            Vector3(area.north_west.x, area.south_east.y, 0)
        )

        if (area.south_east.y == connection_area.south_east.y) then
            south_west_z = connection_area.south_east.z
        end
    else
        south_y = connection_area.south_east.y
        south_west_z = connection_area.south_east.z

        south_east_z = find_z_at_location(
            Vector3(area.north_west.x, area.north_west.y, area.north_west.z),
            Vector3(area.north_west.x, area.south_east.y, area.south_west_z),
            Vector3(connection_area.south_east.x, connection_area.south_east.y, 0)
        )
    end

    return Vector3(west_x, north_y, north_west_z), Vector3(east_x, north_y, north_east_z), Vector3(east_x, south_y, south_east_z), Vector3(west_x, south_y, south_west_z)
end

local function intersection_south(area, connection_area)
    return intersection_north(connection_area, area)
end

local function intersection_east(area, connection_area)
    return intersection_west(connection_area, area)
end

local function find_connection_intersection(area, connection)
    local direction = connection.direction
    local connection_area = connection.area

    local north_west, north_east, south_east, south_west = nil, nil, nil, nil

    if (direction == 1) then
        north_west, north_east, south_east, south_west = intersection_north(area, connection_area)
    elseif (direction == 2) then
        north_west, north_east, south_east, south_west = intersection_east(area, connection_area)
    elseif (direction == 3) then
        north_west, north_east, south_east, south_west = intersection_south(area, connection_area)
    elseif (direction == 4) then
        north_west, north_east, south_east, south_west = intersection_west(area, connection_area)
    end

    return north_west, north_east, south_east, south_west
end

local function center_between_vectors(v1, v2)
    return (v2 + v1) / 2
end

function walkbot_mesh_manager.connection_walking_point(connection)
    local direction = connection.direction

    if (direction == 1) then
        return center_between_vectors(connection.intersection[1], connection.intersection[2])
    elseif (direction == 2) then
        return center_between_vectors(connection.intersection[2], connection.intersection[3])
    elseif (direction == 3) then
        return center_between_vectors(connection.intersection[3], connection.intersection[4])
    elseif (direction == 4) then
        return center_between_vectors(connection.intersection[1], connection.intersection[4])
    end
end

function walkbot_mesh_manager.center_of_node(node)
    local top_left = Vector3(node.north_west.x, node.north_west.y, node.north_west.z)
    local bottom_right = Vector3(node.south_east.x, node.south_east.y, node.south_east.z)
    return (top_left + bottom_right) / 2
end

function walkbot_mesh_manager.center_of_intersection(intersection)
    return (intersection[1] + intersection[3]) / 2
end

function walkbot_mesh_manager.find_connections(area)
    if (area == nil) then return {} end
    if (current_mesh == nil) then return end

    local connections = {}

    if (cached_connections[area.id] ~= nil) then
        return cached_connections[area.id]
    end

    local connection_id = 1

    for dir=1, 4 do
        for i=1, #area.connections[dir].connections do
            connections[connection_id] = {}
            connections[connection_id].direction = dir
            connections[connection_id].area = walkbot_mesh_manager.find_area_by_id(area.connections[dir].connections[i])
    
            local north_west, north_east, south_east, south_west = find_connection_intersection(area, connections[connection_id])
            connections[connection_id].intersection = {north_west, north_east, south_east, south_west}
            connection_id = connection_id + 1
        end
    end

    for dir=1, 2 do
        for i=1, #area.ladders[dir].connections do
            local ladder = area.ladders[dir].connections[i]

            connections[connection_id] = {}

            local ladder_entity = walkbot_mesh_manager.find_ladder_by_id(ladder)

            if (dir == 1) then
                connections[connection_id].area = walkbot_mesh_manager.find_area_by_id(ladder_entity.top_forward_area_id)
                if (ladder_entity.direction == 1) then
                    connections[connection_id].direction = 3
                elseif (ladder_entity.direction == 2) then
                    connections[connection_id].direction = 4
                elseif (ladder_entity.direction == 3) then
                    connections[connection_id].direction = 1
                elseif (ladder_entity.direction == 4) then
                    connections[connection_id].direction = 2
                end
            else
                connections[connection_id].area = walkbot_mesh_manager.find_area_by_id(ladder_entity.bottom_area_id)
                connections[connection_id].direction = ladder_entity.direction
            end

            connections[connection_id].ladder_direction = dir

            local north_west, north_east, south_east, south_west = find_connection_intersection(area, connections[connection_id])
            connections[connection_id].intersection = {north_west, north_east, south_east, south_west}

            connection_id = connection_id + 1
        end
    end

    cached_connections[area.id] = connections

    return connections
end

function walkbot_mesh_manager.find_connection_to_target_id(area, target_id)
    local connections =  walkbot_mesh_manager.find_connections(area)
    if (connections == nil) then return end

    for i=1, #connections do
        local connection = connections[i]
        if (connection.area.id == target_id) then
            return connection
        end
    end
end

function walkbot_mesh_manager.current_area()
    return current_area
end

local function update_current_area_id()
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local local_player_vector = local_player:GetAbsOrigin()

    current_area = walkbot_mesh_manager.find_closest_area(local_player_vector)

    if (current_area == nil) then return end

    walkbot.mesh_navigation.set_origin(current_area.id)

    return
end

local function initialize()
    callbacks.Register("CreateMove", "walkbot_debug_update_current_area", update_current_area_id)
end

function walkbot_mesh_manager.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_mesh_manager