-- Scape#4313 if you need help

-- Basic Gui stuff for testing
local refa = gui.Reference("Ragebot", "Hitscan", "Advanced");
local ref = gui.Groupbox(refa, "Adv TargetSelection");
local enabler = gui.Checkbox(ref, "enabler", "Enable", 1)
local teamTarget = gui.Checkbox(ref, "testTeam", "TargetTeam (for DM)", false);
local method = gui.Combobox(ref, "testMethod", "Select ScanMethod", "Distance", "Fov", "Health", "Manual");
local keybox = gui.Keybox(ref, "testKey", "ManualKey", nil);
local manualRange = gui.Slider(ref, "testSlider", "ManualRange", 1, 1, 5);


-- A collection of player target selection systems for anyone to use in their lua scrips
-- Each function takes a list of entites to target and the localPlayer
-- Feel free to expand upon these and add more

local targetIndex = nil;
-- Closest to player every frame
local function distance(players, localPlayer)
    local bestDist = math.huge;
    local bestIndex = nil;
    
    for i = 1, # players do
        local player = players[i];
        
        if player and player:GetIndex() ~= localPlayer:GetIndex() then
            local localPos = localPlayer:GetAbsOrigin();
            local playerPos = player:GetAbsOrigin();
            local currDistance = (localPos - playerPos):Length();
            
            if currDistance < bestDist then
                bestDist = currDistance;
                bestIndex = player:GetIndex();
            end
            
        end
    end
    
    return bestIndex;
end

-- Closest to xHair every frame
local function fov(players, localPlayer)
    local bestDelta = math.huge;
    local bestIndex = nil;
    
    for i = 1, # players do
        local player = players[i];
        
        if player and player:GetIndex() ~= localPlayer:GetIndex() then
            local localPos = localPlayer:GetAbsOrigin();
            local playerPos = player:GetAbsOrigin();
            local viewAngles = engine.GetViewAngles();
            
            localPos.z = localPos.z + localPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z;
            playerPos.z = playerPos.z + player:GetPropVector("localdata", "m_vecViewOffset[0]").z;
            
            local angle = (playerPos - localPos):Angles();
            local delta = math.abs((angle - viewAngles).y);    
            
            if delta < bestDelta then
                bestDelta = delta;
                bestIndex = player:GetIndex();
            end
            
        end
    end
    
    return bestIndex;
end

-- Lowest Hp
local function health(players, localPlayer)
    local lowestHp = math.huge;
    local bestIndex = nil;
    
    for i = 1, # players do
        local player = players[i];
        
        if player and player:GetIndex() ~= localPlayer:GetIndex() then
            local currHealth = player:GetHealth();
            
            if currHealth < lowestHp then
                lowestHp = currHealth;
                bestIndex = player:GetIndex();
            end
            
        end
    end
    
    return bestIndex;
end

-- Closest to xHair within a tolerance on keyPress
local function manualSelect(players, localPlayer)
    local index = targetIndex

    if keybox:GetValue() ~= 0 and input.IsButtonPressed(keybox:GetValue()) then
        local bestDelta = math.huge;
    
        for i = 1, # players do
            local player = players[i];
        
            if player and player:GetIndex() ~= localPlayer:GetIndex() then
                local localPos = localPlayer:GetAbsOrigin();
                local playerPos = player:GetAbsOrigin();
                local viewAngles = engine.GetViewAngles();
            
                localPos.z = localPos.z + localPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z;
                playerPos.z = playerPos.z + player:GetPropVector("localdata", "m_vecViewOffset[0]").z;
            
                local angle = (playerPos - localPos):Angles();
                local delta = math.abs((angle - viewAngles).y);    
                
                if delta < bestDelta and delta <= manualRange:GetValue() then
                    bestDelta = delta;
                    index = player:GetIndex();
                end
            
            end
        end
    end
    
    return index;
end

-- Setting target index
local function hDraw()
    local players = entities.FindByClass("CCSPlayer");
    local localPlayer = entities.GetLocalPlayer(); 	
	if not enabler:GetValue() then return end   
    if not teamTarget:GetValue() then
        for i = 1, # players do         
            if players[i]:GetTeamNumber() == localPlayer:GetTeamNumber() then
                players[i] = nil;
            end
        end
    end

    if method:GetValue() == 0 then
        targetIndex = distance(players, localPlayer);
    elseif method:GetValue() == 1 then
        targetIndex = fov(players, localPlayer);
    elseif method:GetValue() == 2 then
        targetIndex = health(players, localPlayer);
    elseif method:GetValue() == 3 then
        targetIndex = manualSelect(players, localPlayer);
    end
    
end

-- Drawing target
local function esp(builder)
    local player = builder:GetEntity();
    
    if targetIndex and player:GetIndex() == targetIndex then
        builder:Color(255, 0, 0, 255);
        builder:AddTextTop("TARGET");
    end
end

callbacks.Register("Draw", "hDraw", hDraw);
callbacks.Register("DrawESP", "esp", esp);





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")