------------------------------------------------------------------------------------
--written by Zixtty1887
------------------------------------------------------------------------------------
--Version v1.1
--Update log
--Add Trace Line Check
------------------------------------------------------------------------------------
local function NormalizeYaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
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

local set = false;
local cacheYaw;
local function createMove()
    local players = entities.FindByClass("CCSPlayer");
    local localPosition = entities.GetLocalPlayer():GetAbsOrigin()
    local angViewAngles = engine.GetViewAngles()
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", false)
    if(set == false)then
        cacheYaw = gui.GetValue("rbot.antiaim.base")
    end
    set = false;
    for i = 1, #players do
        local player = players[i];
        if player:IsDormant() == false and player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and player:IsAlive() and player:GetWeaponType() == 0 then
            local playerPosition = player:GetAbsOrigin()
            local distance = (playerPosition - localPosition):Length()
            if distance <= 125 then
                local endPos = engine.TraceLine(localPosition, playerPosition).endpos
                local content =  engine.GetPointContents(endPos, 0xFFFFFFFF)
                if(content == 0)then
                    local AtTargets = CalcAngle(localPosition.x, localPosition.y, playerPosition.x, playerPosition.y)
                    local Yaw = NormalizeYaw(AtTargets - 360 - angViewAngles.yaw)
                    gui.SetValue("rbot.antiaim.base", Yaw)
                    set = true; 
                end
            end
        end
    end
    if set == false then 
        gui.SetValue("rbot.antiaim.base", cacheYaw)
    end
end
callbacks.Register("CreateMove", "defendKnife" ,createMove)
