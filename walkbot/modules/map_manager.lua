-- Walkbot by ShadyRetard

local walkbot_map_manager = {}
local walkbot = nil
local cached_map_data = {}
local sourcenav = nil

walkbot_map_manager.current_map = nil

local function load_map_data()
    walkbot.mesh_navigation.reset()

    if (walkbot_map_manager.current_map == nil) then
        walkbot.mesh_manager.set_mesh(nil)
        walkbot.gui.add_debug_variable(
            "walkbot_map_manager_loading_status",
            "Map loading status:",
            "Engine could not detect a map",
            {255, 0, 0, 255}
        )
        return
    end

    if (cached_map_data[walkbot_map_manager.current_map] ~= nil) then
        walkbot.mesh_manager.set_mesh(cached_map_data[walkbot_map_manager.current_map])
        walkbot.gui.add_debug_variable(
            "walkbot_map_manager_loading_status",
            "Map loading status:",
            "Cached map mesh loaded for map, " .. walkbot_map_manager.current_map,
            {36, 212, 8, 255}
        )
        return
    end

    local mesh_file_path = walkbot.config.data_directory .. "\\" .. walkbot_map_manager.current_map .. ".dat"

    local mesh_file = file.Open(mesh_file_path, "r")
    if (mesh_file == nil) then
        walkbot.gui.add_debug_variable(
            "walkbot_map_manager_loading_status",
            "Map loading status:",
            "Map mesh file cound not be found, " .. mesh_file_path,
            {255, 0, 0, 255}
        )
        return
    end

    local mesh_data = sourcenav.parse(mesh_file:Read())
    if (mesh_data == nil) then
        walkbot.gui.add_debug_variable(
            "walkbot_map_manager_loading_status",
            "Map loading status:",
            "Could not parse data file, " .. mesh_file_path,
            {255, 0, 0, 255}
        )
        return
    end

    walkbot.mesh_manager.set_mesh(mesh_data)
    mesh_file:Close()
    walkbot.gui.add_debug_variable(
        "walkbot_map_manager_loading_status",
        "Map loading status:",
        "Map mesh file successfully loaded, " .. mesh_file_path,
        {36, 212, 8, 255}
    )
end

local function on_draw()
    local current_map = engine.GetMapName();
    if (current_map == "") then current_map = nil end

    if (current_map ~= walkbot_map_manager.current_map) then
        walkbot_map_manager.current_map = current_map
        load_map_data()
    end
end

local function initialize()
    sourcenav = loadstring(file.Read(walkbot.config.modules_directory .. "\\sourcenav.lua"))()
    callbacks.Register("Draw", "walkbot_map_manager_draw", on_draw)
end

function walkbot_map_manager.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_map_manager