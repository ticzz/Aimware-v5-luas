local function DrawCircle2D(x, y, radius, start, angle)
    local angoff = 270 - angle / 2
    local OldAngle = math.rad(start + angoff);
    for NewAngle = start + angoff, start + angle + angoff do
        NewAngle = math.rad(NewAngle) --// Degrees to radians
        local OffsetX, OffsetY = math.cos(NewAngle) * radius, math.sin(NewAngle) * radius
        local OldOffsetX, OldOffsetY = math.cos(OldAngle) * radius, math.sin(OldAngle) * radius
        draw.Line( x + OldOffsetX , y + OldOffsetY, x + OffsetX, y + OffsetY )
        OldAngle = NewAngle --// Needed for next line
    end
end

local function amplify(a)
    return a * 10 - a * 0.5
end

local fPlayerDesyncAngle, fPlayerRealAngle,fDesyncAmount,fRawDesyncAmount = 1, 1, 1, 1;

callbacks.Register("CreateMove", function(cmd)

    if not cmd.sendpacket then
        fPlayerDesyncAngle = cmd.viewangles.y; -- if you are not choking packets, this is your desync angle
    else
        fPlayerRealAngle = cmd.viewangles.y; -- if you are choking packets, it's your real angle.
    end

    fDesyncAmount = math.min(58, math.ceil(math.abs((math.floor(fPlayerDesyncAngle) - math.floor(fPlayerRealAngle)) / 2.1))) -- adjusted for accuracy on the indicator and smoother math, there's probably a more efficient way to do this
    fRawDesyncAmount = math.abs((math.abs(fPlayerDesyncAngle) - math.abs(fPlayerRealAngle)) / 2.1) -- not adjusted, should be using this for everything else but i don't think it matters much.
end)

callbacks.Register("Draw", function()
    local lp = entities.GetLocalPlayer()
    if not lp or not fPlayerRealAngle then return end
    local lby = lp:GetProp('m_flLowerBodyYawTarget')
    local view = engine.GetViewAngles().y
    local x, y = draw.GetScreenSize()

    for i = 30, 35 do
        draw.Color(0, 0, 0, amplify(i))
        DrawCircle2D(x / 2, y / 2, i, 0, 360)
    end

    for i = 30, 35 do
        draw.Color(50, 125, 255, amplify(i + 12))
        DrawCircle2D(x / 2, y / 2, i, view - fDesyncAmount, 45) -- could also use fDesyncAmount instead of fPlayerDesyncAngle to make the bar larger as the desync amount increases
    end

    for i = 36, 42 do
        draw.Color(50, 125, 255, 180)
        DrawCircle2D(x / 2, y / 2, i, view - fDesyncAmount, 43 - i )
    end

    for i = 30, 35 do
        draw.Color(255, 50, 50, amplify(i + 12))
        DrawCircle2D(x / 2, y / 2, i, view - fPlayerRealAngle, 45)
    end

    for i = 36, 42 do
        draw.Color(255, 50, 50, 180)
        DrawCircle2D(x / 2, y / 2, i, view - fPlayerRealAngle, 43 - i )
    end


    for i = 30, 35 do
        draw.Color(255, 255, 50, amplify(i + 12))
        DrawCircle2D(x / 2, y / 2, i, view - lby, 15)
    end

    for i = 36, 42 do
        draw.Color(255, 255, 50, 180)
        DrawCircle2D(x / 2, y / 2, i, view - lby, 43 - i )
    end
end)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

