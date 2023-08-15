-- Walkbot by ShadyRetard

local walkbot_objective_use = {}
local walkbot = nil

walkbot_objective_use.IN_ATTACK = bit.lshift(1, 0)
walkbot_objective_use.IN_JUMP = bit.lshift(1, 1)
walkbot_objective_use.IN_DUCK = bit.lshift(1, 2)
walkbot_objective_use.IN_FORWARD = bit.lshift(1, 3)
walkbot_objective_use.IN_USE = bit.lshift(1, 5)
walkbot_objective_use.IN_RELOAD = bit.lshift(1, 13)

local function plant_bomb(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (local_player:GetTeamNumber() ~= 2) then return end

    local player_resources = entities.GetPlayerResources()
    if (player_resources == nil) then return end
    if (player_resources:GetProp("m_iPlayerC4") ~= local_player:GetIndex()) then return end
    if (local_player:GetPropBool("m_bInBombZone") ~= true) then return end

    cmd.buttons = bit.bor(cmd.buttons, walkbot_objective_use.IN_USE)
end

local function defuse(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (local_player:GetTeamNumber() ~= 3) then return end

    local planted_bomb = entities.FindByClass("CPlantedC4")[1]
    if (planted_bomb == nil) then return end
    if (planted_bomb:GetPropBool("m_bBombDefused") == true) then return end

    if ((local_player:GetAbsOrigin() - planted_bomb:GetAbsOrigin()):Length() < 50) then
        cmd.buttons = bit.bor(cmd.buttons, walkbot_objective_use.IN_USE)
        cmd.viewangles = ((local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]")) - planted_bomb:GetAbsOrigin()):Angles() * -1
        cmd.forwardmove = 0
        cmd.sidemove = 0
    end
end

local function grab_hostage(cmd)
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (local_player:GetTeamNumber() ~= 3) then return end
    if (local_player:GetProp("m_hCarriedHostage") ~= -1) then return end

    local hostages = entities.FindByClass("CHostage")
    local nearby_hostage = nil

    for i=1, #hostages do
        if ((hostages[i]:GetAbsOrigin() - local_player:GetAbsOrigin()):Length() < 50) then
            nearby_hostage = hostages[i]
            break
        end
    end

    if (nearby_hostage ~= nil) then
        cmd.buttons = bit.bor(cmd.buttons, walkbot_objective_use.IN_USE)
        cmd.viewangles = (nearby_hostage:GetBonePosition(8) - (local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]"))):Angles()
    end
end

local function initialize()
    callbacks.Register("CreateMove", "walkbot_objective_use_defuse", defuse)
    callbacks.Register("CreateMove", "walkbot_objective_use_plant_bomb", plant_bomb)
    callbacks.Register("CreateMove", "walkbot_objective_grab_hostage", grab_hostage)
end

function walkbot_objective_use.connect(walkbot_instance)
    walkbot = walkbot_instance
    initialize()
end

return walkbot_objective_use