local aa_adv = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
local enable = gui.Checkbox(aa_adv, "at_targets", "At Targets", false)
local yaw_slider = gui.Slider(aa_adv, "aa_yaw", "At Targets Yaw", 180, -180, 180)

local function NormalizeYaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function WorldDistance(xdelta, ydelta)
    if xdelta == 0 and ydelta == 0 then
        return 0
    end
    return math.deg(math.atan2(ydelta, xdelta))
end

local function CalcAngle(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
    local ydelta = localplayerypos - enemyypos
    local xdelta = localplayerxpos - enemyxpos
    relativeyaw = math.atan(ydelta / xdelta)
    relativeyaw = NormalizeYaw(relativeyaw * 180 / math.pi)
    if xdelta >= 0 then
        relativeyaw = NormalizeYaw(relativeyaw + 180)
    end
    return relativeyaw
end

callbacks.Register("Draw", function()
    if not gui.GetValue("rbot.antiaim.advanced.at_targets") then
        return
    end

    local pLocal = entities.GetLocalPlayer()
  
    if pLocal == nil then
        return toreturn
    end

    if not pLocal:IsAlive() then
        return toreturn
    end

    local vecLocalPos = pLocal:GetAbsOrigin()

    local BestEnemy = nil
    local BestDistance = math.huge
    local vecLocalPos = pLocal:GetAbsOrigin()
    local angViewAngles = engine.GetViewAngles()
    local Enemies = entities.FindByClass("CCSPlayer")
    local DesiredYaw = gui.GetValue("rbot.antiaim.advanced.aa_yaw")
  
    for i, Enemy in pairs(Enemies) do
        if Enemy:GetPropInt("m_iTeamNum") ~= pLocal:GetPropInt("m_iTeamNum") then

            local vecEnemyPos = Enemy:GetAbsOrigin()
            local Distance = math.abs(NormalizeYaw(WorldDistance(vecLocalPos.x - vecEnemyPos.x, vecLocalPos.y - vecEnemyPos.y) - angViewAngles.y + 180))

            if Distance < BestDistance then
                BestDistance = Distance
                BestEnemy = Enemy
            end
        end
    end

    if BestEnemy ~= nil then
        local vecEnemyPos = BestEnemy:GetAbsOrigin()
        local AtTargets = CalcAngle(vecLocalPos.x, vecLocalPos.y, vecEnemyPos.x, vecEnemyPos.y)
        local Yaw = NormalizeYaw(AtTargets + DesiredYaw - angViewAngles.yaw)
        gui.SetValue("rbot.antiaim.base", Yaw, Yaw)
    else
        gui.SetValue("rbot.antiaim.base", DesiredYaw, DesiredYaw)
    end
end)