--[[alpha = 0


function hitmarker()
local screencenterX, screencenterY = draw.GetScreenSize() --getting the full screensize
screencenterX = screencenterX / 2; screencenterY = screencenterY / 2 --dividing the screensize by 2 will place it perfectly in the center no matter what resolution
draw.Color( 255, 255, 255, alpha)

draw.Line(screencenterX - 7, screencenterY + 7, screencenterX, screencenterY)
draw.Line(screencenterX - 7, screencenterY - 7, screencenterX, screencenterY)
draw.Line(screencenterX + 7, screencenterY + 7, screencenterX, screencenterY)
draw.Line(screencenterX + 7, screencenterY - 7, screencenterX, screencenterY)
if(alpha > 0) then
    alpha = alpha - 2.5
    end
end


function enemyhit(event)
    if(event:GetName() == "player_hurt") then --if the game event "player_hurt" gets called then
        local attacker = event:GetInt("attacker") --getting the attacker
        local attackerindex = client.GetPlayerIndexByUserID(attacker) --retrieves the attackers entity index by using the GetPlayerIndexByUserID function aimwares api provides us
        if(attackerindex == client.GetLocalPlayerIndex()) then --if the attackers index for the player who got hurt matches the localplayer index, it means we're the attacker
        alpha = 255
        end
    end
end

callbacks.Register( "FireGameEvent", "enemyhitfunction", enemyhit)
callbacks.Register( "Draw", "hitmarker", hitmarker)
--]]


--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#


--Aimware V5 Locational Hit Indicator Lua By Rudi
local ref = gui.Reference("Visuals", "World", "Extra");
local hitmarkerCheckbox = gui.Checkbox(ref, "lua_hitmarker", "Hit Indicators", true); 
local hitmarkerColor = gui.ColorPicker(hitmarkerCheckbox, "lua_hitmarker_color", "", 255, 255, 255, 255);
local markerSizeSlider = gui.Slider(ref, "lua_hitmarker_size", "Hitmarker Size", 12, 5, 25);
local fadeTime = gui.Slider(ref, "lua_hitmarker_size_combo", "Fade Time", 1, 0.2, 5);

hitmarkerCheckbox:SetDescription("After hitting an enemy, hitmarker shows up");

hitPositions = {};
hitTimes = {};
hitTypes = {};
bulletImpactPositions = {};
deltaTimes = {};

local hitCount = 0;
local newHitCount = 0;
local bulletImpactCount = 0;
local hitFlag = false;

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
                AddHit(impact, 0);
                bulletImpactPositions = {};
                bulletImpactCount = 0;
            end
        end
    end
end

local function hDraw()
    if (hitmarkerCheckbox:GetValue() and entities.GetLocalPlayer() ~= nil) then
        newHitCount = hitCount;
        for i = 0, hitCount, 1 do
            if (hitTimes[i] ~= nil and hitPositions[i] ~= nil and hitTypes[i] ~= nil) then
                local deltaTime = globals.CurTime() - hitTimes[i];
                if (deltaTime > fadeTime:GetValue()) then
                    RemoveHit(i);
                    goto continue;
                end

                if (hitTypes[i] == 1) then
                    hitPositions[i].z = hitPositions[i].z + deltaTime / headshotSpeed;
                end

                local xHit, yHit = client.WorldToScreen(hitPositions[i]);
                if xHit ~= nil and yHit ~= nil then
                    local alpha;
                    if (deltaTime > fadeTime:GetValue() / 2) then
                        alpha = (1 - (deltaTime - deltaTimes[i]) / fadeTime:GetValue() * 2) * 255;
                        if (alpha < 0) then
                            alpha = 0
                        end
                    else
                        table.insert(deltaTimes, i, deltaTime)
                        alpha = 255;
                    end
                        local r, g, b, a = hitmarkerColor:GetValue();
                        draw.Color(r, g, b, alpha);
                        draw.Line(xHit - markerSizeSlider:GetValue(), yHit - markerSizeSlider:GetValue(), xHit - (12 / 4), yHit - (12 / 4));
                        draw.Line(xHit - markerSizeSlider:GetValue(), yHit + markerSizeSlider:GetValue(), xHit - (12 / 4), yHit + (12 / 4));
                        draw.Line(xHit + markerSizeSlider:GetValue(), yHit - markerSizeSlider:GetValue(), xHit + (12 / 4), yHit - (12 / 4));
                        draw.Line(xHit + markerSizeSlider:GetValue(), yHit + markerSizeSlider:GetValue(), xHit + (12 / 4), yHit + (12 / 4));
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