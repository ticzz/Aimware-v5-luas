-- Walkbot by ShadyRetard

local walkbot_memory = {}
local walkbot = nil
local remembered_players = {}
local remembered_hostages = {}

local function memory_players_in_team(team)
    local players = {}

    for i=1, #remembered_players do
        if (remembered_players[i]["entity"]:GetTeamNumber() == team) then
            table.insert(players, remembered_players[i])
        end
    end

    return players
end

function walkbot_memory.enemy_players()
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return {} end

    local enemy_team_num = 2
    if (local_player:GetTeamNumber() == 2) then
        enemy_team_num = 3
    end

    return memory_players_in_team(enemy_team_num)
end

local function find_entity_in_table(table, index)
    for i=1, #table do
        if (table[i]["entity"]:GetIndex() == index) then
            return i
        end
    end
end

local function update_players(esp_builder)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end

    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local enemy_player = esp_builder:GetEntity()

    if (enemy_player:IsPlayer() == false or enemy_player:GetTeamNumber() == 0 or enemy_player:GetTeamNumber() == 1) then
        return
    end

    local player_index = find_entity_in_table(remembered_players, enemy_player:GetIndex())

    local player_memory_entity = {
        ["origin"] = enemy_player:GetAbsOrigin(),
        ["entity"] = enemy_player,
        ["updated_at"] = globals.RealTime()
    }

    if (player_index ~= nil) then
        remembered_players[player_index] = player_memory_entity
    else
        table.insert(remembered_players, player_memory_entity)
    end
end

local function remove_dormant_players()
    for i=#remembered_players, 1, -1 do
        if (globals.RealTime() - remembered_players[i]["updated_at"] > walkbot.config.memory_time) then
            table.remove(remembered_players, i)
        end
    end
end

local function update_player_by_noise(event)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end

    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local player_id = event:GetInt("userid")
    local enemy_player = entities.GetByUserID(player_id)
    if (enemy_player:GetIndex() == local_player:GetIndex()) then return end

    local player_index = find_entity_in_table(remembered_players, player_id)

    local player_memory_entity = {
        ["origin"] = enemy_player:GetAbsOrigin(),
        ["entity"] = enemy_player,
        ["updated_at"] = globals.RealTime()
    }

    if (player_index ~= nil) then
        remembered_players[player_index] = player_memory_entity
    elseif (event:GetName() == "weapon_fire") then
        table.insert(remembered_players, player_memory_entity)
    end
end

function walkbot_memory.hostages()
    local hostages = {}
    for i=1, #remembered_hostages do
        if (globals.RealTime() - remembered_hostages[i]["updated_at"] <= walkbot.config.memory_time) then
            table.insert(hostages, remembered_hostages[i])
        end
    end
    return hostages
end

local function update_hostages()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end

    local hostages = entities.FindByClass("CHostage")

    for i=1, #hostages do
        local hostage_index = find_entity_in_table(remembered_hostages, hostages[i]:GetIndex())
        local hostage_memory_entity = {
            ["origin"] = hostages[i]:GetBonePosition(8),
            ["entity"] = hostages[i],
            ["updated_at"] = globals.RealTime()
        }

        if (hostage_index ~= nil) then
            if (remembered_hostages[hostage_index]["origin"] ~= hostages[i]:GetBonePosition(8)) then
                remembered_hostages[hostage_index] = hostage_memory_entity
            end
        else
            table.insert(remembered_hostages, hostage_memory_entity)
        end
    end

end

local function initialize()
    callbacks.Register("FireGameEvent", "walkbot_memory_noise_update", update_player_by_noise)
    callbacks.Register("CreateMove", "walkbot_memory_remove_dormant_players", remove_dormant_players)
    callbacks.Register("DrawESP", "walkbot_memory_update_players", update_players)
    callbacks.Register("CreateMove", "walkbot_memory_update_hostages", update_hostages)

    client.AllowListener("player_footstep")
    client.AllowListener("weapon_fire")
end

function walkbot_memory.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_memory