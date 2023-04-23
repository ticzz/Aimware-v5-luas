local REFER = gui.Reference("Misc")
local BEEPTAB = gui.Tab(REFER, "sonar.esp.tab", "Sonar Sound ESP")
local GROUP = gui.Groupbox(BEEPTAB, "Sonar ESP", 16, 16, 297, 300)
local ENABLE = gui.Checkbox(GROUP, "sonar.enabled", "Enable", false)
local VOLUME = gui.Slider(GROUP, "sonar.volume", "Volume", 50, 1, 100, 1)
local SOUND = gui.Combobox(GROUP, "sonar.sound", "Sound", "Button 17", "Button 15", "Blip 1", "Blip 2", "Bell", "Button 10")
local DISTANCE = gui.Slider(GROUP, "sonar.distance", "Distance", 200, 100, 1500, 50)
local FOV = gui.Slider(GROUP, "sonar.fov", "FOV", 180, 1, 180, 1)
local FOV_ROTATION = gui.Slider(GROUP, "sonar.rotation", "FOV rotation", 180, 0, 360, 1)
local DISTANCEBASED = gui.Checkbox(GROUP, "sonar.distancebasedfreq", "Distancebased Beep frequency", false)
local DISTANCEBASED_VOLUME = gui.Checkbox(GROUP, "sonar.distancebasedvol", "Distancebased Beep frequency", false)
local VISUALIZE_FOV = gui.Checkbox(GROUP, "sonar.visualize", "Visualize FOV", false)

--- Descriptions
ENABLE:SetDescription("Enables Sonar ESP.")
SOUND:SetDescription("Select which sound should be played.")
VOLUME:SetDescription("Master volume of the sound.")
DISTANCE:SetDescription("Distance of the FOV.")
FOV:SetDescription("Field of view of the sonar.")
FOV_ROTATION:SetDescription("Rotation of the FOV.")
DISTANCEBASED:SetDescription("Play sound more frequently when enemies are near.")
DISTANCEBASED_VOLUME:SetDescription("Play sound louder when enemies are near.")
VISUALIZE_FOV:SetDescription("Visualize the FOV.")

--- Variables
local lastBeep = 0
local sounds = {"button17", "button15", "blip1", "blip2", "bell1", "button10"}

--- Localize API
local rad = math.rad
local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt
local atan = math.atan
local w2s = client.WorldToScreen
local renderLine = draw.Line

local function drawFOV(vector, radius, color)
    local oldX, oldY
    draw.Color(color[1], color[2], color[3], color[4])
    local fov = FOV:GetValue()
    local fovRotation = 180 - FOV_ROTATION:GetValue()
    local engineAngles = engine.GetViewAngles()
    engineAngles.y = engineAngles.y+fovRotation+(180-fov)
    engineAngles:Normalize()

    for rotation = engineAngles.y, engineAngles.y+(fov*2), 1 do
        local rotRad = rad(rotation)
        local newVector = Vector3(radius * cos(rotRad) + vector.x, radius * sin(rotRad) + vector.y, vector.z)
        local x, y = w2s(newVector)

        if fov ~= 180 then
            if rotation == engineAngles.y or rotation == engineAngles.y+(fov*2) then
                local x2, y2 = w2s(vector)
                if x ~= nil and x2 ~= nil then
                    renderLine(x, y, x2, y2)
                    for i = 0, 4 do
                        renderLine(x, y + i, x2, y2 + i)
                    end
                end
            end
        end

        if x ~= nil and oldX ~= nil then
            renderLine(x, y, oldX, oldY)
            for i = 0, 4 do
                renderLine(x, y + i, oldX, oldY + i)
            end
        end
        oldX, oldY = x, y
    end
end

local function Magnitude(vec)
    return sqrt(vec.x*vec.x + vec.y*vec.y + vec.z*vec.z);
end

local function Subtract(vector1, vector2)
    return Vector3(vector1.x - vector2.x, vector1.y - vector2.y, vector1.z - vector2.z);
end

local function calcAngle(src, dst) --- From source sdk, thx valve

    local angles = EulerAngles(0, 0, 0);
    local delta = Subtract(src, dst);
    local hyp = Magnitude(delta);
    angles.x = atan(delta.z / hyp) * 180.0 / 3.14159265358979323846;
    angles.y = atan(delta.y / delta.x) * 180.0 / 3.14159265358979323846;
    angles.z = 0.0;

    if delta.x >= 0.0 then
        angles.y = angles.y + 180.0;
    end

    angles:Normalize()
    return angles;
end

local function hkDraw()

    local pLocal = entities.GetLocalPlayer();

    if pLocal and pLocal:IsAlive() and ENABLE:GetValue() then
        local absOrigin = pLocal:GetAbsOrigin();
        local enemiesInRange = 0;
        local enemies = 0;
        local replayGap = 1;
        local closestDistance = 9999;
        local fov = FOV:GetValue()
        local fovRotation = FOV_ROTATION:GetValue()
        local engineAngles = engine.GetViewAngles()
        local maxDistance = DISTANCE:GetValue()

        for i=1, 64, 1 do
            local pEntity = entities.GetByIndex(i)

            if pEntity and pEntity:IsAlive() then
                if pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() then
                    enemies = enemies + 1;
                    local pEntityOrigin = pEntity:GetAbsOrigin()
                    local CalcAngles = calcAngle(absOrigin, pEntityOrigin)
                    local originDelta = sqrt((absOrigin.x-pEntityOrigin.x)^2 + (absOrigin.y-pEntityOrigin.y)^2)

                    if originDelta <= maxDistance then
                        CalcAngles.y = (CalcAngles.y - (engineAngles.y)+fovRotation)
                        CalcAngles:Normalize()

                        if CalcAngles.y < 0 then
                            if CalcAngles.y >= (fov * -1) then
                                enemiesInRange = enemiesInRange + 1
                            end
                        elseif CalcAngles.y > 0 then
                            if CalcAngles.y <= fov then
                                enemiesInRange = enemiesInRange + 1
                            end
                        end
                        if originDelta < closestDistance then
                            closestDistance = originDelta;
                        end
                    end
                end
            end
        end

        if DISTANCEBASED:GetValue() then
            replayGap = 0.1 + ((0.8) * (closestDistance / 1500));
        end

        if enemiesInRange > 0 and lastBeep < globals.RealTime() - replayGap then
            local button = sounds[SOUND:GetValue()+1]
            local vol = VOLUME:GetValue() / 100

            if DISTANCEBASED_VOLUME:GetValue() then
                vol = (1 - (closestDistance / 1500)) * vol
            end

            client.Command("playvol buttons/".. button .. " " .. vol, true)
            lastBeep =  globals.RealTime()
        end

        if VISUALIZE_FOV:GetValue() then
            drawFOV(absOrigin, maxDistance, {255*(enemiesInRange/enemies), 25, 25, 155});
        end
    end
end

callbacks.Register("Draw", hkDraw)