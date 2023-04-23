local ref = gui.Reference("Ragebot", "Anti-Aim", "Advanced");

local method = gui.Combobox(ref, "aalua.antibrute.targetmethod", "Anti Brute Selection Method", "Off", "Distance", "Fov");
local targetDraw = gui.Checkbox(ref, "aalua.antibrute.targetdraw", "Draw Anti-Aim target", true);
local lbyEnable = gui.Checkbox(ref, "aalua.lbysway", "Enable LBY Sway", true);
local targetColor = gui.ColorPicker(targetDraw, "aalua.antibrute.targetcolor", "", 255, 0, 0, 255);
local deadZone = gui.Slider(ref, "aalua.deadzone", "Deadzone", 12, 0, 30);
local desyncDelay = gui.Slider(ref, "aalua.delay", "Delay", 4, 1, 10);


local localPlayer = entities.GetLocalPlayer();
local desyncTick = -1;
local nextLBYUpdate = -1;
local targetEntity = nil;

local function closestFov(players)
    local bestDelta = math.huge;
    local bestEntity = nil;
    
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
                bestEntity = player;
            end
            
        end
    end

    return bestEntity;
end

local function closestDist(players)
    local bestDist = math.huge;
    local bestEntity = nil;
    
    for i = 1, #players do
        local player = players[i];
        
        if player and player:GetIndex() ~= localPlayer:GetIndex() then
            local localPos = localPlayer:GetAbsOrigin();
            local playerPos = player:GetAbsOrigin();
            local currDistance = (localPos - playerPos):Length();
            
            if currDistance < bestDist then
                bestDist = currDistance;
                bestEntity = player;
            end
        end
    end
    
    return bestEntity;
end 

local function updateDesync()
    local fakeAmount = gui.GetValue("rbot.antiaim.base.rotation");

    if(fakeAmount >= 58) then
        fakeAmount = -58;
    else
        fakeAmount = fakeAmount + 6;
    end
  
    if fakeAmount >= -deadZone:GetValue() and fakeAmount <= deadZone:GetValue() then
        fakeAmount = deadZone:GetValue();
    end

    gui.SetValue("rbot.antiaim.base.rotation", fakeAmount);
end

local function updateLBY()
    local lbyAmount = gui.GetValue("rbot.antiaim.base.lby");

    if lbyAmount > 0 then
        lbyAmount = -lbyAmount
    else
        lbyAmount = -lbyAmount
    end

    gui.SetValue("rbot.antiaim.base.lby", lbyAmount);
end

local function shouldUpdate()
    local vx = localPlayer:GetPropFloat("localdata", "m_vecVelocity[0]");
    local vy = localPlayer:GetPropFloat("localdata", "m_vecVelocity[1]");
    local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5));
    local serverTime = globals.TickInterval() * globals.TickCount(); --localPlayer:GetProp("m_nTickBase");
    local onGround = bit.band(localPlayer:GetPropInt("m_fFlags"), 1) ~= 0;

    if velocity > 0.1 and onGround then
        nextLBYUpdate = serverTime + 0.22;
    end

    if serverTime >= nextLBYUpdate and onGround then
        nextLBYUpdate = serverTime + 1.1;

        return true;
    end

    return false;
end

local function hFireGameEvent(event)
    if event:GetName() == "weapon_fire" then
        local entity = entities.GetByUserID(event:GetInt("userid"));

        if targetEntity and entity:GetIndex() == targetEntity:GetIndex() then
            local fakeAmount = gui.GetValue("rbot.antiaim.base.rotation");
            gui.SetValue("rbot.antiaim.base.rotation", -fakeAmount);
        end
    end
end

local function hCreateMove(pCmd)
    if localPlayer and localPlayer:IsAlive() then

        if not pCmd.sendpacket then
            lastChoked = pCmd.viewangles
            choking = true;
            lastChoke = globals.CurTime();
        else
            localAngle = pCmd.viewangles
        end
    end
end

local function hDraw()
    localPlayer = entities.GetLocalPlayer();
    local players = entities.FindByClass("CCSPlayer");

    for i = 1, #players do         
        if players[i]:GetTeamNumber() == localPlayer:GetTeamNumber() or not players[i]:IsAlive() then
            players[i] = nil;
        end
    end

    if localPlayer and localPlayer:IsAlive() then
        if math.abs(globals.TickCount() - desyncTick) >= 10 then
            desyncTick = -1;
        end

        if desyncTick <= globals.TickCount() then
            updateDesync();
            desyncTick = globals.TickCount() + desyncDelay:GetValue();
        end

        if lbyEnable:GetValue() and shouldUpdate() then
           updateLBY();
        end

 
        
        if method:GetValue() == 0 then
            targetEntity = nil;
        elseif method:GetValue() == 1 then
            targetEntity = closestDist(players);
        elseif method:GetValue() == 2 then
            targetEntity = closestFov(players);
        end
    end
end

local function hDrawESP(builder)
    local entity = builder:GetEntity();

    if targetDraw:GetValue() and targetEntity and entity:GetIndex() == targetEntity:GetIndex() then
        local r, g, b, a = targetColor:GetValue();
        builder:Color(r,g,b,a);
        builder:AddTextTop("TARGET");
    end
end

client.AllowListener("weapon_fire");

callbacks.Register("FireGameEvent", hFireGameEvent );
callbacks.Register("Draw", hDraw);
callbacks.Register("DrawESP", hDrawESP);



