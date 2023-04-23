

--- Name: Anti-Aim Angle Lines
--- Creator: Superyu'#7167
---

--- GUI Stuff
local pos = gui.Reference("Ragebot", "Anti-Aim", "Anti-Aim");
local enabled = gui.Checkbox(pos, "suyu_antiaimlines_enabled", "Anti-Aim Lines", 0);

--- Variables
local rx, ry;
local fx, fy;
local fx2, fy2;
local lby;
local pLocal = entities.GetLocalPlayer();
local choking;
local lastChoke;

--- Functions

-- Angle to vector function
local function AngleVectors(angles)

    local sp, sy, cp, cy;
    local forward = { }

    sy = math.sin(math.rad(angles[2]));
	cy = math.cos(math.rad(angles[2]));

	sp = math.sin(math.rad(angles[1]));
	cp = math.cos(math.rad(angles[1]));

	forward[1] = cp*cy;
	forward[2] = cp*sy;
    forward[3] = -sp;
    return forward;
end

local function doShit(t1, t2, m)
    local t3 ={};
    for i,v in ipairs(t1) do
        t3[i] = v + (t2[i] * m);
    end
    return t3;
end

local function iHateMyself(value, color, text)

    local forward = {};
    local origin = pLocal:GetAbsOrigin();
    forward = AngleVectors({0, value, 0});
    local end3D = doShit({origin.x, origin.y, origin.z}, forward, 25);
    local w2sX1, w2sY1 = client.WorldToScreen(origin);
    local w2sX2, w2sY2 = client.WorldToScreen(Vector3(end3D[1], end3D[2], end3D[3]));
    draw.Color(color[1], color[2], color[3], color[4])

    if w2sX1 and w2sY1 and w2sX2 and w2sY2 then
        draw.Line(w2sX1, w2sY1, w2sX2, w2sY2)
        local textW, textH = draw.GetTextSize(text);
        draw.TextShadow( w2sX2-(textW/2), w2sY2-(textH/2), text)
    end
end

--- Callbacks

-- Draw lines
callbacks.Register("Draw", function()

if pLocal == nil then 
return 
end

    pLocal = entities.GetLocalPlayer();
    lby = pLocal:GetProp("m_flLowerBodyYawTarget");
    fake = pLocal:GetProp("m_angEyeAngles");

    if lastChoke and lastChoke <= globals.CurTime() - 1 then
        choking = false;
    end
    if pLocal and pLocal:IsAlive() and enabled:GetValue()  then

        if lastChoked and choking and OriLua_LL_MISCS_LASTCHOKEDANG:GetValue() then iHateMyself(lastChoked.y, {25, 255, 25, 255}, "Last Choked") end
        if fake and OriLua_LL_MISCS_NETWORKED:GetValue() then iHateMyself(fake.y, {255, 25, 25, 255}, "Networked") end
        if localAngle and OriLua_LL_MISCS_LOCALANG:GetValue() then iHateMyself(localAngle.y, {25, 25, 255, 255}, "Local Angle") end
        if lby and OriLua_LL_MISCS_LBY:GetValue() then iHateMyself(lby, {255, 255, 255, 255}, "LBY") end
    end
end)

-- Get angles
callbacks.Register("CreateMove", function(pCmd)
    if pLocal and pLocal:IsAlive() and enabled:GetValue() then

        if not pCmd.sendpacket then
            lastChoked = pCmd.viewangles
            choking = true;
            lastChoke = globals.CurTime();
        else
            localAngle = pCmd.viewangles
        end
    end
end)

--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

