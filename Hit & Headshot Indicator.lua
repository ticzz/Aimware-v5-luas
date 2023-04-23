local ref = gui.Reference("Visuals", "World", "Extra");
local hitmarkerCheckbox = gui.Checkbox(ref, "lua_hitmarker", "Hit Indicators", true);  
local hitmarkerColor = gui.ColorPicker(hitmarkerCheckbox, "lua_hitmarker_color", "", 255, 255, 255, 255);
local markerSizeSlider = gui.Slider(ref, "lua_hitmarker_size", "Hitmarker Size", 12, 5, 25);
local headshotCheckbox = gui.Checkbox(ref, "lua_headshot", "Headshot Indicators", true);
local headshotColor = gui.ColorPicker(headshotCheckbox, "lua_headshot_color", "", 0, 255, 0, 255);
local fontHeadshot = gui.Combobox(ref, "lua_headshot_font", "Font", "Arial", "Verdana", "Sans-Serif", "Calibri");
local fadeTime = gui.Slider(ref, "lua_hitmarker_size_combo", "Fade Time", 1, 0.2, 5);
local fontSize = gui.Slider(ref, "lua_headshot_font_size", "Font Size", 12, 8, 32);
local fontWeight = gui.Slider(ref, "lua_headshot_font_weight", "Font Weight", 1200, 500, 3000);

hitmarkerCheckbox:SetDescription("After hitting an enemy, hitmarker shows up");
headshotCheckbox:SetDescription("After hitting an enemy in the head, 'HEADSHOT' shows up");

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
                if (deltaTime > fadeTime:GetValue()) then
                    RemoveHit(i);
                    goto continue;
                end

                if (hitTypes[i] == 1) then
                    hitPositions[i].z = hitPositions[i].z + deltaTime / fadeTime:GetValue();
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

                    if (hitTypes[i] == 1) then
                        local r, g, b, a = headshotColor:GetValue();
                        local font;
                        if (fontHeadshot:GetValue() == 1) then
                            font = draw.CreateFont("Verdana", fontSize:GetValue(), fontWeight:GetValue());
                        elseif (fontHeadshot:GetValue() == 2) then
                            font = draw.CreateFont("Sans-Serif", fontSize:GetValue(), fontWeight:GetValue());
                        elseif (fontHeadshot:GetValue() == 3) then
                            font = draw.CreateFont("Calibri", fontSize:GetValue(), fontWeight:GetValue());
                        else
                            font = draw.CreateFont("Arial", fontSize:GetValue(), fontWeight:GetValue());
                        end
                       
                        draw.SetFont(font);
                        draw.Color(r, g, b, alpha);
                        local width, height = draw.GetTextSize("HEADSHOT");
                        draw.Text(xHit - width / 2, yHit, "HEADSHOT");
                    else
                        local r, g, b, a = hitmarkerColor:GetValue();
                        draw.Color(r, g, b, alpha);
                        draw.Line(xHit - markerSizeSlider:GetValue(), yHit - markerSizeSlider:GetValue(), xHit - (12 / 4), yHit - (12 / 4));
                        draw.Line(xHit - markerSizeSlider:GetValue(), yHit + markerSizeSlider:GetValue(), xHit - (12 / 4), yHit + (12 / 4));
                        draw.Line(xHit + markerSizeSlider:GetValue(), yHit - markerSizeSlider:GetValue(), xHit + (12 / 4), yHit - (12 / 4));
                        draw.Line(xHit + markerSizeSlider:GetValue(), yHit + markerSizeSlider:GetValue(), xHit + (12 / 4), yHit + (12 / 4));
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
