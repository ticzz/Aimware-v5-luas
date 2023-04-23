--- Name: Anti-Aim Angle Lines
--- Creator: Superyu'#7167
---
--- GUI stuff
local POS = gui.Reference('Visuals', 'Local', 'Helper')
local MULTI = gui.Multibox(POS, 'Antiaim lines')
local NETWORKED = gui.Checkbox(MULTI, 'vis.local.aalines.networked', 'Fake', false)
local LBY = gui.Checkbox(MULTI, 'vis.local.aalines.lby', 'LBYaw', false)
local LOCALANG = gui.Checkbox(MULTI, 'vis.local.aalines.local', 'Real', false)
local LASTCHOKEDANG = gui.Checkbox(MULTI, 'vis.local.aalines.lastchoked', 'Desync', false)

--- Variables
local lastChoked = nil
local fake = nil
local localAngle = nil
local lby = nil
local pLocal = entities.GetLocalPlayer()
local choking
local lastChoke

local function AngleVectors(angles)
    local sp, sy, cp, cy
    local forward = {}

    sy = math.sin(math.rad(angles[2]))
    cy = math.cos(math.rad(angles[2]))

    sp = math.sin(math.rad(angles[1]))
    cp = math.cos(math.rad(angles[1]))

    forward[1] = cp * cy
    forward[2] = cp * sy
    forward[3] = -sp
    return forward
end

local function doShit(t1, t2, m)
    local t3 = {}
    for i, v in ipairs(t1) do
        t3[i] = v + (t2[i] * m)
    end
    return t3
end

local function iHateMyself(value, color, text)
    local forward = {}
    local origin = pLocal:GetAbsOrigin()
    forward = AngleVectors({0, value, 0})
    local end3D = doShit({origin.x, origin.y, origin.z}, forward, 25)
    local w2sX1, w2sY1 = client.WorldToScreen(origin)
    local w2sX2, w2sY2 = client.WorldToScreen(Vector3(end3D[1], end3D[2], end3D[3]))
    draw.Color(color[1], color[2], color[3], color[4])

    if w2sX1 and w2sY1 and w2sX2 and w2sY2 then
        draw.Line(w2sX1, w2sY1, w2sX2, w2sY2)
        local textW, textH = draw.GetTextSize(text)
        draw.TextShadow(w2sX2 - (textW / 2), w2sY2 - (textH / 2), text)
    end
end

--- Callbacks
callbacks.Register(
    'Draw',
    function()
        pLocal = entities.GetLocalPlayer()
        lby = pLocal:GetProp('m_flLowerBodyYawTarget')
        fake = pLocal:GetProp('m_angEyeAngles')

        if lastChoke and lastChoke <= globals.CurTime() - 1 then
            choking = false
        end

        if pLocal and pLocal:IsAlive() then
            if lastChoked and choking and LASTCHOKEDANG:GetValue() then
                iHateMyself(lastChoked.y, {25, 255, 25, 255}, 'Desync')
            end
            if fake and NETWORKED:GetValue() then
                iHateMyself(fake.y, {255, 25, 25, 255}, 'Fake')
            end
            if localAngle and LOCALANG:GetValue() then
                iHateMyself(localAngle.y, {25, 25, 255, 255}, 'Real')
            end
            if lby and LBY:GetValue() then
                iHateMyself(lby, {255, 255, 255, 255}, 'LBYaw')
            end
        end
    end
)

callbacks.Register(
    'CreateMove',
    function(pCmd)
        if pLocal and pLocal:IsAlive() then
            if not pCmd.sendpacket then
                lastChoked = pCmd.viewangles
                choking = true
                lastChoke = globals.CurTime()
            else
                localAngle = pCmd.viewangles
            end
        end
    end
)
