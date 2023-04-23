local weapon_groups = {pistol = {2, 3, 4, 30, 32, 36, 61, 63}, sniper = {9}, scout = {40}, hpistol = {1, 64}, smg = {17, 19, 23, 24, 26, 33, 34}, rifle = {60, 7, 8, 10, 13, 16, 39}, shotgun = {25, 27, 29, 35}, 
                      asniper = {38, 11}, lmg = {28, 14}, knife = {505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 42}, zeus = {31}, grenade = {44, 45, 47, 43, 46, 48}}

local screen_width, screen_height = draw.GetScreenSize()
local aimbot_target = nil

local function getWeaponGroup()
    local local_entity = entities.GetLocalPlayer()
    if not local_entity or not local_entity:IsAlive() then          --check is local entity valid
        return 
    end

    local weapon_id = local_entity:GetWeaponID()                    --get weapon id

    for weapon_group, group_weapon_ids in pairs(weapon_groups) do  --check for weapon_group and weapon ids
        for id = 1, #group_weapon_ids, 1 do                        --check for every id in group weapon ids
            if weapon_id == group_weapon_ids[id] then
                return weapon_group
            end
        end
    end
end

local function getClosestToCrosshair()
    local nearest_distance = math.huge                              --giant number
    local local_entity = entities.GetLocalPlayer()

    for _, entity in pairs(entities.FindByClass("CCSPlayer")) do
        --check entity for valid
        if entity:GetTeamNumber() ~= local_entity:GetTeamNumber() and entity ~= local_entity and entity:IsPlayer() and entity:IsAlive() then

            local entity_on_screen = {client.WorldToScreen(entity:GetAbsOrigin())}
            local distance_to_entity = {vector.Distance(screen_width / 2, screen_height / 2, 0, entity_on_screen[1], entity_on_screen[2], 0)}

            if distance_to_entity[1] < nearest_distance then
                nearest_distance = distance_to_entity[1]
                return entity
            end
        end
    end
end

local function setAutoDelay()
    if getClosestToCrosshair() then                                --check for we have target or not
        local FIRST_HITBOX = 0                                      --head hitbox
        local LAST_HITBOX = 7                                      --right leg hitbox
        local MAX_HITBOX_DISTANCE = 15                              --how many pixels can be between crosshair and enemy's hitbox

        for hitbox = FIRST_HITBOX, LAST_HITBOX, 1 do                --?hecking all hitboxes
            local target_hitbox_screen_position = {client.WorldToScreen(getClosestToCrosshair():GetHitboxPosition(hitbox))}

            local distance_to_hitbox = {vector.Distance(screen_width / 2, screen_height / 2, 0, target_hitbox_screen_position[1], target_hitbox_screen_position[2], 0)}

            local aim_distance = distance_to_hitbox[1] 

            --check weapon group
            if getWeaponGroup() ~= 'grenade' and getWeaponGroup() ~= 'knife' then
                local smooth = gui.GetValue('lbot.weapon.aim.' .. getWeaponGroup() .. '.smooth')
                local delay = (aim_distance * (smooth + 1))          --calculate delay

                gui.SetValue('lbot.weapon.target.' .. getWeaponGroup() .. '.fsd', delay)
            end
        end
    end
end
callbacks.Register('Draw', setAutoDelay)


print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")