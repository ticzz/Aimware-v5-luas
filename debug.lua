-- Walkbot by ShadyRetard

local walkbot_debug = {}
local walkbot = nil

local function draw_area(area)
    local nw_wtc_x, nw_wtc_y = client.WorldToScreen(Vector3(area.north_west.x + 1, area.north_west.y + 1, area.north_west.z))
    local ne_wtc_x, ne_wtc_y = client.WorldToScreen(Vector3(area.south_east.x - 1, area.north_west.y + 1, area.north_east_z))
    local se_wtc_x, se_wtc_y = client.WorldToScreen(Vector3(area.south_east.x - 1, area.south_east.y - 1, area.south_east.z))
    local sw_wtc_x, sw_wtc_y = client.WorldToScreen(Vector3(area.north_west.x + 1, area.south_east.y - 1, area.south_west_z))

    if nw_wtc_x == nil or ne_wtc_x == nil or sw_wtc_x == nil or se_wtc_x == nil then return end

    draw.Line(nw_wtc_x, nw_wtc_y, ne_wtc_x, ne_wtc_y) --top
    draw.Line(nw_wtc_x, nw_wtc_y, sw_wtc_x, sw_wtc_y) --left
    draw.Line(ne_wtc_x, ne_wtc_y, se_wtc_x, se_wtc_y) --right
    draw.Line(sw_wtc_x, sw_wtc_y, se_wtc_x, se_wtc_y) --bottom

    draw.Text(nw_wtc_x, nw_wtc_y, "NW")
    draw.Text(ne_wtc_x, ne_wtc_y, "NE")
    draw.Text(sw_wtc_x, sw_wtc_y, "SW")
    draw.Text(se_wtc_x, se_wtc_y, "SE")
end

local function draw_areas()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (walkbot.gui.debug_enabled_checkbox:GetValue() == false) then return end
    if (walkbot.mesh_manager.areas() == nil) then return end

    for i=1, #walkbot.mesh_manager.areas() do
        local area = walkbot.mesh_manager.areas()[i]

        local r, g, b, a = 0, 0, 0, 100

        if (walkbot.mesh_navigation.is_on_current_path(area.id)) then
            r, g, b, a = 255, 255, 255, 255
        end

        if (walkbot.mesh_manager.is_current_area(area.id)) then
            r, g, b, a = 2, 218, 237, 255
        end

        draw.Color(r, g, b, a)

        draw_area(area)
    end
end

local function draw_connections()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (walkbot.gui.debug_enabled_checkbox:GetValue() == false) then return end
    if (walkbot.mesh_manager.areas() == nil) then return end

    local current_area = walkbot.mesh_manager.current_area()
    local connections = walkbot.mesh_manager.find_connections(current_area)
    draw.Color(237, 186, 2, 100)

    for i=1, #connections do
        if (connections[i] ~= nil) then
            local nw_wtc_x, nw_wtc_y = client.WorldToScreen(connections[i].intersection[1])
            local ne_wtc_x, ne_wtc_y = client.WorldToScreen(connections[i].intersection[2])
            local se_wtc_x, se_wtc_y = client.WorldToScreen(connections[i].intersection[3])
            local sw_wtc_x, sw_wtc_y = client.WorldToScreen(connections[i].intersection[4])

            if (nw_wtc_x ~= nil and ne_wtc_x ~= nil and se_wtc_x ~= nil and sw_wtc_x ~= nil) then
                draw.Line(nw_wtc_x, nw_wtc_y, ne_wtc_x, ne_wtc_y)
                draw.Line(nw_wtc_x, nw_wtc_y, sw_wtc_x, sw_wtc_y)
                draw.Line(ne_wtc_x, ne_wtc_y, se_wtc_x, se_wtc_y)
                draw.Line(sw_wtc_x, sw_wtc_y, se_wtc_x, se_wtc_y)

                draw.Text(nw_wtc_x, nw_wtc_y, "NW")
                draw.Text(ne_wtc_x, ne_wtc_y, "NE")
                draw.Text(sw_wtc_x, sw_wtc_y, "SW")
                draw.Text(se_wtc_x, se_wtc_y, "SE")
            end
        end
    end
end

local function area_to_text(area)
    if (area == nil) then return "" end

    local area_string = area.id
    local place = walkbot.mesh_manager.find_place_by_id(area.place_id)
    if (place ~= nil) then
        area_string = area_string .. " @ " .. place.name
    end

    return area_string
end

local function update_current_route()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local current_area = walkbot.mesh_manager.current_area()

    if current_area == nil or walkbot.mesh_navigation.get_target_id() == nil then
        walkbot.gui.remove_debug_variable("walkbot_debug_current_route")
        return
    end

    walkbot.gui.add_debug_variable(
        "walkbot_debug_current_route",
        "Current route:",
        area_to_text(current_area) .. " -> " .. area_to_text(walkbot.mesh_manager.find_area_by_id(walkbot.mesh_navigation.get_target_id())),
        {255, 255, 255, 255}
    )
end

local function update_current_position()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then
        walkbot.gui.remove_debug_variable("walkbot_debug_current_location")
        return
    end

    walkbot.gui.add_debug_variable(
        "walkbot_debug_current_location",
        "Current location:",
        tostring(local_player:GetAbsOrigin()),
        {255, 255, 255, 255}
    )
end

local function draw_objectives()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (walkbot.gui.debug_enabled_checkbox:GetValue() == false) then return end
    local current_objectives = walkbot.objective.get_available_objectives()
    for i=1, #current_objectives do
        local objective = current_objectives[i]

        local objective_wtc_x, objective_wtc_y = client.WorldToScreen(Vector3(objective["origin"]["x"], objective["origin"]["y"], objective["origin"]["z"] + 50))
        if (objective_wtc_x ~= nil) then
            if (objective == walkbot.objective.get_current_objective()) then
                draw.Color(51, 204, 0, 255)
            else
                draw.Color(255, 255, 255, 200)
            end
            local w, _ = draw.GetTextSize(objective["title"])
            draw.Text(objective_wtc_x - (w / 2), objective_wtc_y, objective["title"])
        end
    end
end

local function initialize()
    callbacks.Register("Draw", "walkbot_debug_draw_areas", draw_areas)
    callbacks.Register("Draw", "walkbot_debug_draw_connections", draw_connections)
    callbacks.Register("Draw", "walkbot_debug_draw_objectives", draw_objectives)
    callbacks.Register("CreateMove", "walkbot_debug_draw_route", update_current_route)
    callbacks.Register("CreateMove", "walkbot_debug_draw_current_position", update_current_position)
end

function walkbot_debug.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_debug