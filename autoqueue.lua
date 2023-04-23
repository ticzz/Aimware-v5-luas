-- Walkbot by ShadyRetard

local walkbot_autoqueue = {}
local walkbot
local gamemodes_info = nil

local autoqueue_enabled_checkbox = nil
local autoqueue_mode_listbox = nil
local autoqueue_type_listbox = nil
local autoqueue_map_listbox = nil
local last_enabled_status = false
local last_mode = nil
local last_type = nil
local last_map = nil

local type_listboxes = {}
local mode_listboxes = {}
local map_listboxes = {}

local function panorama_toggle_autoqueue(enabled)
    panorama.RunScript("autoqueueEnabled = " .. tostring(enabled) .. ";")
end

local function panorama_set_autoqueue_mode(mode)
    panorama.RunScript("autoqueueMode = '" .. mode  .. "';")
end

local function panorama_set_autoqueue_type(type)
    panorama.RunScript("autoqueueType = '" .. type  .. "';")
end

local function panorama_set_autoqueue_map(map)
    panorama.RunScript("autoqueueMap = '" .. map  .. "';")
end

local function initializePanorama()
    panorama.RunScript([[
        var autoqueueMode = "";
        var autoqueueType = "";
        var autoqueueMap = "";
        var autoqueueEnabled = false;
    
        function queueMatchmaking() {
            $.Schedule(1, queueMatchmaking)
    
            if (autoqueueEnabled == false) {
                return;
            }
    
            if (!LobbyAPI.BIsHost()) {
                LobbyAPI.CreateSession();
            }
    
            LobbyAPI.UpdateSessionSettings({
                update: {
                    Options: {
                        action: "custommatch",
                        server: "official"
                    },
                    Game: {
                        mode: autoqueueMode,
                        type: autoqueueType,
                        mapgroupname: autoqueueMap,
                        questid: 0
                    }
                }
            });
    
            if (!GameStateAPI.IsConnectedOrConnectingToServer()) {
                LobbyAPI.StartMatchmaking("", "", "", "");
            }
        }
    
        queueMatchmaking();
    ]])
end

local function get_game_type_values()
    local type_values = {}

    for i=1, #gamemodes_info do
        table.insert(type_values, gamemodes_info[i]["gametype"])
    end
    
    return type_values
end

local function get_game_mode_values(type_index)
    local game_modes = gamemodes_info[type_index]["gameModes"]
    local mode_values = {}

    for i=1, #game_modes do
        table.insert(mode_values, game_modes[i]["gamemode"])
    end

    return mode_values
end

local function update_values()
    if (gamemodes_info == nil) then return end

    local autoqueue_enabled = autoqueue_enabled_checkbox:GetValue()
    local autoqueue_type = autoqueue_type_listbox:GetValue()
    local autoqueue_mode = autoqueue_mode_listbox:GetValue()
    local autoqueue_map = autoqueue_map_listbox:GetValue()

    local type_name = gamemodes_info[autoqueue_type + 1]["gametype"]

    if (type_name == nil) then return end
    if (autoqueue_mode > #gamemodes_info[autoqueue_type + 1]["gameModes"]) then
        autoqueue_mode_listbox:SetOptions(unpack(get_game_mode_values(autoqueue_type + 1)))
        autoqueue_mode_listbox:SetValue(0)
        autoqueue_map_listbox:SetOptions(unpack(gamemodes_info[autoqueue_type + 1]["gameModes"][1]["maps"]))
        autoqueue_map_listbox:SetValue(0)
        return
    end

    local mode_name = gamemodes_info[autoqueue_type + 1]["gameModes"][autoqueue_mode + 1]["gamemode"]
    if (mode_name == nil) then return end
    local map_name = gamemodes_info[autoqueue_type + 1]["gameModes"][autoqueue_mode + 1]["maps"][autoqueue_map + 1]
    if (map_name == nil) then return end

    if (last_enabled_status ~= autoqueue_enabled) then
        last_enabled_status = autoqueue_enabled
        panorama_toggle_autoqueue(autoqueue_enabled)
    elseif last_mode ~= mode_name then
        last_mode = mode_name
        panorama_set_autoqueue_mode(mode_name)
        autoqueue_map_listbox:SetOptions(unpack(gamemodes_info[autoqueue_type + 1]["gameModes"][autoqueue_mode + 1]["maps"]))
    elseif last_type ~= type_name then
        last_type = type_name
        panorama_set_autoqueue_type(type_name)
        autoqueue_mode_listbox:SetOptions(unpack(get_game_mode_values(autoqueue_type + 1)))
    elseif last_map ~= map_name then
        last_type = map_name
        panorama_set_autoqueue_map(map_name)
    end
end

local function initialize()
    local gamemodes_info_file = file.Open(walkbot.config.data_directory .. "\\gamemodes.txt", "r")
    if (gamemodes_info_file ~= nil) then
        local info = gamemodes_info_file:Read()
        gamemodes_info = walkbot.json.decode(info)
        autoqueue_type_listbox:SetOptions(unpack(get_game_type_values()))
        autoqueue_mode_listbox:SetOptions(unpack(get_game_mode_values(1)))
        autoqueue_map_listbox:SetOptions(unpack(gamemodes_info[1]["gameModes"][1]["maps"]))
    end

    initializePanorama()
    callbacks.Register("Draw", "walkbot_autoqueue_update_values", update_values)
end

function walkbot_autoqueue.connect(walkbot_instance)
    walkbot = walkbot_instance
    local groupbox = walkbot_instance.gui.add_groupbox("Autoqueue", nil, 500)
    autoqueue_enabled_checkbox = gui.Checkbox(groupbox, "walkbot_autoqueue_enabled", "Autoqueue Enabled", 0)
    autoqueue_type_listbox = gui.Listbox(groupbox, "walkbot_autoqueue_type", 100, "")
    autoqueue_mode_listbox = gui.Listbox(groupbox, "walkbot_autoqueue_mode", 100, "")
    autoqueue_map_listbox = gui.Listbox(groupbox, "walkbot_autoqueue_map", 100, "")

    initialize()
end

return walkbot_autoqueue