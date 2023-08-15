-- Walkbot by ShadyRetard

local walkbot_mesh_navigation = {}
local walkbot = nil

local current_target_id = nil
local current_target_location = nil
local current_origin_id = nil
local INF = 1 / 0;
local cached_paths = nil;
local current_route = {}

function walkbot_mesh_navigation.set_origin(origin_area_id)
    current_origin_id = origin_area_id
    walkbot_mesh_navigation.route_to_target()
end

function walkbot_mesh_navigation.set_target(target_vector)
    if (target_vector == nil) then return end

    local target_area = walkbot.mesh_manager.find_closest_area(target_vector)
    if (target_area == nil) then return end

    current_target_id = target_area.id
    current_target_location = target_vector
    walkbot_mesh_navigation.route_to_target()
end

function walkbot_mesh_navigation.final_destination()
    return current_target_location
end

function walkbot_mesh_navigation.get_target_id()
    return current_target_id
end

function walkbot_mesh_navigation.reset()
    cached_paths = nil
    current_route = nil
    current_origin_id = nil
    current_target_id = nil
end

local function current_route_area_index(area_id)
    if current_route == nil then return nil end

    for i=1, #current_route do
        if current_route[i].id == area_id then
            return i
        end
    end

    return nil
end

function walkbot_mesh_navigation.is_on_current_path(area_id)
    return current_route_area_index(area_id);
end

local function distance_between(node_a, previous_intersection, neighbor_connection)
    local cost = 0
    local connection_walking_point = walkbot.mesh_manager.connection_walking_point(neighbor_connection)
    local previous_intersection_center = walkbot.mesh_manager.center_of_node(node_a)
    local neighbor_center = walkbot.mesh_manager.center_of_node(neighbor_connection.area)

    if (previous_intersection ~= nil) then
        previous_intersection_center = entities.GetLocalPlayer():GetAbsOrigin()
        previous_intersection_center = walkbot.mesh_manager.center_of_intersection(previous_intersection)
    end

    previous_intersection_center["z"] = connection_walking_point["z"]

    local distance_to_center = (previous_intersection_center - connection_walking_point):Length()
    local distance_from_center_to_walking = (neighbor_center - connection_walking_point):Length()

    local distance = distance_to_center + distance_from_center_to_walking

    cost = distance

    if (bit.band(node_a.flags, walkbot.mesh_manager.NAV_MESH_CROUCH) ~= 0 or bit.band(node_a.flags, walkbot.mesh_manager.NAV_MESH_STAIRS) ~= 0) then
        cost = cost + (5 * distance)
    end

    return cost
end

local function heuristic_cost_estimate(node_a, node_b)
    local center_1 = walkbot.mesh_manager.center_of_node(node_a)
    local center_2 = walkbot.mesh_manager.center_of_node(node_b)
    return (center_1 - center_2):Length()
end

local function lowest_f_score(set, f_score)
    local lowest, bestNode = INF, nil
    for _, node in ipairs(set) do
        local score = f_score[node]
        if score < lowest then
            lowest, bestNode = score, node
        end
    end
    return bestNode
end

local function not_in(set, theNode)
    for _, node in ipairs(set) do
        if node == theNode then return false end
    end
    return true
end

local function remove_node(set, theNode)
    for i, node in ipairs(set) do
        if node == theNode then
            set[i] = set[#set]
            set[#set] = nil
            break
        end
    end
end

local function reconstruct_path(came_from, current)
    local total_path = {current}
    while (came_from[current] ~= nil) do
        current = came_from[current]
        table.insert(total_path, current)
    end

    return total_path
end

local function parsed_path(came_from)
    local areas_path = {}
    for i=#came_from, 1, -1 do
        local route_area = walkbot.mesh_manager.find_area_by_id(came_from[i])
        table.insert(areas_path, route_area)
    end
    return areas_path
end

local function a_star(start, goal)
    local open_set = { start.id }
    local came_from = {}
    local previous_intersection = nil

    local g_score, f_score = {}, {}
    g_score[start.id] = 0
    f_score[start.id] = heuristic_cost_estimate(start, goal)

    while #open_set > 0 do
        local current = lowest_f_score(open_set, f_score)
        if current == goal.id then
            return parsed_path(reconstruct_path(came_from, current))
        end

        previous_intersection = nil
        remove_node(open_set, current)

        local current_area = walkbot.mesh_manager.find_area_by_id(current)
        local neighbor_connections = walkbot.mesh_manager.find_connections(current_area)

        for _, neighbor_connection in ipairs(neighbor_connections) do
            local tentative_g_score = g_score[current] + distance_between(current_area, previous_intersection, neighbor_connection)

            if g_score[neighbor_connection.area.id] == nil or tentative_g_score < g_score[neighbor_connection.area.id] then
                came_from[neighbor_connection.area.id] = current
                g_score[neighbor_connection.area.id] = tentative_g_score
                f_score[neighbor_connection.area.id] = g_score[neighbor_connection.area.id] + heuristic_cost_estimate(neighbor_connection.area, goal)
                if not_in(open_set, neighbor_connection.area.id) then
                    previous_intersection = neighbor_connection.intersection
                    table.insert(open_set, neighbor_connection.area.id)
                end
            end
        end
    end
    return nil
end

local function shortest_path()
    if not cached_paths then cached_paths = {} end
    if not cached_paths[current_origin_id] then
        cached_paths[current_origin_id] = {}
    elseif cached_paths[current_origin_id][current_target_id] then
        return cached_paths[current_origin_id][current_target_id]
    end

    local resPath = a_star(walkbot.mesh_manager.find_area_by_id(current_origin_id), walkbot.mesh_manager.find_area_by_id(current_target_id))
    if not cached_paths[current_origin_id][current_target_id] then
        cached_paths[current_origin_id][current_target_id] = resPath
    end

    return resPath
end

function walkbot_mesh_navigation.route_to_target()
    if (current_target_id == nil) then
        current_route = {}
        return current_route
    end

    if (current_origin_id == nil) then
        local current_area = walkbot.mesh_manager.current_area()
        if (current_area == nil) then return current_route end
        current_origin_id = current_area.id
    end

    if (current_route ~= nil and current_route[#current_route] ~= nil and current_route[#current_route].id ~= current_target_id) then
        current_route = {}
    end

    current_route = shortest_path()

    return current_route
end

function walkbot_mesh_navigation.connect(walkbot_instance)
    walkbot = walkbot_instance
end

return walkbot_mesh_navigation