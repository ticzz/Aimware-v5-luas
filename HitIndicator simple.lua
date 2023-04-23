--Aimware V5 Locational Hit Indicator Lua By Rudi

local ref = gui.Reference("Visuals", "World", "Extra");
local hitmarkerCheckbox = gui.Checkbox(ref, "lua_hitmarker", "Hit Indicators", true);
local headshotCheckbox = gui.Checkbox(ref, "lua_headshot", "Headshot Indicators", true);
local hitmarkerColor = gui.ColorPicker(hitmarkerCheckbox, "lua_hitmarker_color", "", 255, 255, 255, 255);
local headshotColor = gui.ColorPicker(headshotCheckbox, "lua_headshot_color", "", 0, 255, 0, 255);

hitPositions = {};
hitTimes = {};
hitTypes = {};
bulletImpactPositions = {};
deltaTimes = {};

local hitCount = 0;
local newHitCount = 0;
local bulletImpactCount = 0;
local hitFlag = false;

--Change if you want
local markerSize = 5;
local fadeTime = 1;
local headshotSpeed = 5;

local function AddHit(hitPos, type)
    table.insert(hitPositions, hitPos);
    table.insert(hitTimes, globals.CurTime());
    table.insert(hitTypes, type);
    hitCount = hitCount + 1;
end

local function RemoveHit(index)
    table.remove(hitPositions, index);
    table.remove(hitTimes, index);
    table.remove(hitTypes, index);
    table.remove(deltaTimes, index);
    newHitCount = newHitCount - 1;
end

local function GetClosestImpact(point)
    local bestImpactIndex;
    local bestDist = 11111111111;
    for i = 0, bulletImpactCount, 1 do
        if (bulletImpactPositions[i] ~= nil) then
            local delta = bulletImpactPositions[i] - point;
            local dist = delta:Length();
            if (dist < bestDist) then
                bestDist = dist;
                bestImpactIndex = i;
            end
        end
    end

    return bulletImpactPositions[bestImpactIndex];
end

local function hFireGameEvent(GameEvent)
    if (GameEvent:GetName() == "bullet_impact") then
        local attacker = entities.GetByUserID(GameEvent:GetInt("userid"));
        if (attacker ~= nil and attacker:GetName() == entities.GetLocalPlayer():GetName()) then
            hitFlag = true;
            local hitPos = Vector3(GameEvent:GetFloat("x"), GameEvent:GetFloat("y"), GameEvent:GetFloat("z"));
            table.insert(bulletImpactPositions, hitPos);
            bulletImpactCount = bulletImpactCount + 1;
        end

    elseif (GameEvent:GetName() == "player_hurt") then
        local victim = entities.GetByUserID(GameEvent:GetInt("userid"));
        local attacker = entities.GetByUserID(GameEvent:GetInt("attacker"));
        if (attacker ~= nil and victim ~= nil and attacker:GetName() == entities.GetLocalPlayer():GetName() and victim:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber()) then
            local hitGroup = GameEvent:GetInt("hitgroup");
            if (hitFlag) then
                hitFlag = false;
                local impact = GetClosestImpact(victim:GetHitboxPosition(hitGroup));
                if (hitGroup == 1 and headshotCheckbox:GetValue()) then
                    impact.z = impact.z + 5
                    AddHit(impact, 1);
                elseif (hitmarkerCheckbox:GetValue()) then
                    AddHit(impact, 0);
                end
                bulletImpactPositions = {};
                bulletImpactCount = 0;
            end
        end
    end
end

local function hDraw()
    if ((headshotCheckbox:GetValue() or hitmarkerCheckbox:GetValue()) and entities.GetLocalPlayer() ~= nil) then
        newHitCount = hitCount;
        for i = 0, hitCount, 1 do
            if (hitTimes[i] ~= nil and hitPositions[i] ~= nil and hitTypes[i] ~= nil) then
                local deltaTime = globals.CurTime() - hitTimes[i];
                if (deltaTime > fadeTime) then
                    RemoveHit(i);
                    goto continue;
                end

                if (hitTypes[i] == 1) then
                    hitPositions[i].z = hitPositions[i].z + deltaTime / headshotSpeed;
                end

                local xHit, yHit = client.WorldToScreen(hitPositions[i]);
                if xHit ~= nil and yHit ~= nil then
                    local alpha;
                    if (deltaTime > fadeTime / 2) then
                        alpha = (1 - (deltaTime - deltaTimes[i]) / fadeTime * 2) * 255;
                        if (alpha < 0) then
                            alpha = 0
                        end
                    else
                        table.insert(deltaTimes, i, deltaTime)
                        alpha = 255;
                    end

                    if (hitTypes[i] == 1) then
                        local r, g, b, a = headshotColor:GetValue();
                        draw.Color(r, g, b, alpha);
                        local width, height = draw.GetTextSize("HEADSHOT");
                        draw.Text(xHit - width / 2, yHit, "HEADSHOT");
                    else
                        local r, g, b, a = hitmarkerColor:GetValue();
                        draw.Color(r, g, b, alpha);
                        draw.Line(xHit - markerSize, yHit - markerSize, xHit + markerSize, yHit + markerSize);
                        draw.Line(xHit - markerSize, yHit + markerSize, xHit + markerSize, yHit - markerSize);
                    end
                end
            end

            ::continue::
        end

        hitCount = newHitCount;
    end
end

client.AllowListener("bullet_impact");
client.AllowListener("player_hurt");
callbacks.Register("FireGameEvent", hFireGameEvent);
callbacks.Register("Draw", hDraw);







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

