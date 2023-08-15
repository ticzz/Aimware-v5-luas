-- Walkbot by ShadyRetard

local walkbot_objective = {}
local walkbot = nil
local last_objective_id = nil
local current_objective = nil
local last_objective_update = nil

local force_objective = nil
local force_new_objective = false

local currently_available_objectives = {}

function walkbot_objective.get_available_objectives()
    return currently_available_objectives
end

function walkbot_objective.get_current_objective()
    return current_objective
end

function walkbot_objective.force_new_objective()
    force_new_objective = true
end

local function set_target()
    if (current_objective == nil) then
        walkbot.gui.remove_debug_variable("walkbot_objective_current_objective")
    else
        walkbot.gui.add_debug_variable(
            "walkbot_objective_current_objective",
            "Current objective:",
            current_objective["title"],
            {255, 255, 255, 255}
        )
    end

    walkbot.mesh_navigation.set_target(current_objective["origin"])
end

local function objective_available(objective_type_id)
    for i=1, #currently_available_objectives do
        if (currently_available_objectives[i]["type"] == objective_type_id) then return true end
    end

    return false
end

local function random_objective_by_id(objective_type_id)
    local available_objectives_for_id = {}

    for i=1, #currently_available_objectives do
        if (currently_available_objectives[i]["type"] == objective_type_id) then
            table.insert(available_objectives_for_id, currently_available_objectives[i])
        end
    end

    return available_objectives_for_id[math.random(#available_objectives_for_id)]
end

local function bomb_objectives(game_rule_proxy, player_resources)
    if (game_rule_proxy:GetPropBool("cs_gamerules_data", "m_bMapHasBombTarget") == false) then return end

    local bombsite_a_vector = player_resources:GetPropVector("m_bombsiteCenterA")
    if ((bombsite_a_vector - Vector3()):Length() > 0) then
        table.insert(currently_available_objectives, {
            ["title"] = "Bombsite A",
            ["type"] = 1,
            ["origin"] = bombsite_a_vector
        })
    end

    local bombsite_b_vector = player_resources:GetPropVector("m_bombsiteCenterB")
    if ((bombsite_b_vector - Vector3()):Length() > 0) then
        table.insert(currently_available_objectives, {
            ["title"] = "Bombsite B",
            ["type"] = 1,
            ["origin"] = bombsite_b_vector
        })
    end

    local planted_bomb = entities.FindByClass("CPlantedC4")[1]
    if (planted_bomb ~= nil and planted_bomb:GetPropBool("m_bBombDefused") == false) then
        table.insert(currently_available_objectives, {
            ["title"] = "Planted bomb",
            ["type"] = 2,
            ["origin"] = planted_bomb:GetAbsOrigin()
        })
    end

    local bomb = entities.FindByClass("CC4")[1]
    if (bomb ~= nil and bomb:GetProp("m_hOwner") == -1) then
        table.insert(currently_available_objectives, {
            ["title"] = "Dropped bomb",
            ["type"] = 3,
            ["origin"] = bomb:GetAbsOrigin()
        })
    end
end

local function player_objectives()
    local enemy_players = walkbot.memory.enemy_players()
    for i=1, #enemy_players do
        table.insert(currently_available_objectives, {
            ["title"] = "Enemy player " .. enemy_players[i]["entity"]:GetName(),
            ["player"] = enemy_players[i]["entity"],
            ["type"] = 6,
            ["origin"] = enemy_players[i]["entity"]:GetAbsOrigin()
        })
    end
end


local function hostages()
    local hostages = walkbot.memory.hostages()

    for i=1, #hostages do
        local hostage = hostages[i]["entity"]
        if (hostage:GetProp("m_leader") == -1) then
            table.insert(currently_available_objectives, {
                ["title"] = "Hostage " .. i,
                ["type"] = 4,
                ["origin"] = hostage:GetAbsOrigin()
            })
        end
    end

    return false
end

local function rescue_zones(player_resources)
    for i = 1, 3 do
        local rescue_x, rescue_y, rescue_z = player_resources:GetPropInt("m_hostageRescueX", i),
                                             player_resources:GetPropInt("m_hostageRescueY", i),
                                             player_resources:GetPropInt("m_hostageRescueZ", i)

        if (rescue_x ~= 0 or rescue_y ~= 0 or rescue_z ~= 0) then
            table.insert(currently_available_objectives, {
                ["title"] = "Rescue zone " .. i,
                ["type"] = 5,
                ["origin"] = Vector3(rescue_x, rescue_y, rescue_z)
            })
        end
    end
end

local function hostage_objectives(game_rule_proxy, player_resources)
    if (game_rule_proxy:GetPropBool("cs_gamerules_data", "m_bMapHasRescueZone") == false) then return end

    if (entities.GetLocalPlayer():GetProp("m_hCarriedHostage") == -1) then
        hostages()
    end

    rescue_zones(player_resources)
end

local function find_available_objectives()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local game_rule_proxy = entities.FindByClass("CCSGameRulesProxy")[1]
    if (game_rule_proxy == nil) then return end

    local player_resources = entities.GetPlayerResources()
    if (player_resources == nil) then return end

    currently_available_objectives = {}
    player_objectives()
    bomb_objectives(game_rule_proxy, player_resources)
    hostage_objectives(game_rule_proxy, player_resources)
end

local function determine_objective()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (walkbot.mesh_manager.areas() == nil) then
        currently_available_objectives = {}
        return
    end

    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end

    local game_rule_proxy = entities.FindByClass("CCSGameRulesProxy")[1]
    if (game_rule_proxy == nil) then return end

    local player_resources = entities.GetPlayerResources()
    if (player_resources == nil) then return end

    if (last_objective_update == nil) then
        last_objective_update = globals.RealTime()
    elseif (force_new_objective == false and globals.RealTime() - last_objective_update < walkbot.config.objective_switching_time) then
        return
    end

    local current_objective_id = 0

    -- Rescue zone (If carrying hostage)
    -- Random bomb site (If player has c4)
    -- Hostage (CT)
    -- Planted bomb (CT)
    -- Enemy players
    -- Planted bomb (T)
    -- Hostage (T)
    -- Random location

    if (entities.GetLocalPlayer():GetProp("m_hCarriedHostage") ~= -1) then
        current_objective_id = 5
        if (last_objective_id == current_objective_id and force_new_objective == false) then
            return
        end
    elseif (objective_available(1) and player_resources:GetProp("m_iPlayerC4") == local_player:GetIndex()) then
        current_objective_id = 1
        if (last_objective_id == current_objective_id and force_new_objective == false) then
            return
        end
    elseif (objective_available(4) and local_player:GetTeamNumber() == 3) then
        current_objective_id = 4
        if (last_objective_id == current_objective_id and force_new_objective == false) then
            return
        end
    elseif (objective_available(2) and local_player:GetTeamNumber() == 3) then
        current_objective_id = 2
    elseif (objective_available(3)) then
        current_objective_id = 3
    elseif (objective_available(6)) then
        current_objective_id = 6
    elseif (objective_available(2)) then
        current_objective_id = 2
    elseif (objective_available(4)) then
        current_objective_id = 4
    end

    if (current_objective_id == 0) then
        current_objective = {
            ["title"] = "Random location",
            ["type"] = 0,
            ["origin"] = walkbot.mesh_manager.center_of_node(walkbot.mesh_manager.areas()[math.random(#walkbot.mesh_manager.areas())])
        }
    else
        current_objective = random_objective_by_id(current_objective_id)
    end

    last_objective_id = current_objective_id
    force_new_objective = false
    last_objective_update = globals.RealTime()

    set_target()
end


local function initialize()
    callbacks.Register("CreateMove", "walkbot_find_objectives", find_available_objectives)
    callbacks.Register("CreateMove", "walkbot_determine_objective", determine_objective)
end

function walkbot_objective.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_objective