local function require(name, url)
    package = package or {}

    package.loaded = package.loaded or {}

    package.loaded[name] =
        package.loaded[name] or RunScript(name .. ".lua") or
        http.Get(
            url,
            function(body)
                file.Write(name .. ".lua", body)
            end
        )

    return package.loaded[name] or error("unable to load module " .. name .. " ( try to reload )", 2)
end
local draw = require("libraries/draw", "https://aimware28.coding.net/p/coding-code-guide/d/aim_lib/git/raw/master/draw/draw.lua?download=false")

local function clamp(val, min, max)
    if val > max then
        return max
    elseif val < min then
        return min
    end
    return val
end

local globals_frametime, globals_CurTime, globals_TickInterval = globals.FrameTime, globals.CurTime, globals.TickInterval
local math_floor, math_min, math_abs = math.floor, math.min, math.abs
local function time_to_ticks(a)
    return math_floor(1 + a / globals_TickInterval())
end

local alpha = 0

local function on_draw()
    local lp = entities.GetLocalPlayer()

    if not (lp and lp:IsAlive()) then
        return
    end
    local fade = ((1.0 / 0.15) * globals_frametime()) * 100

    local lp_head_Pos = lp:GetHitboxPosition(0)
    local x, y = client.WorldToScreen(Vector3(lp_head_Pos.x, lp_head_Pos.y, lp_head_Pos.z + 20))

    local health = lp:GetHealth() or 0

    if x and y then
        draw.color(4, 4, 4, 150)

        alpha = health ~= 100 and clamp(alpha - fade, health, 100) or clamp(alpha + fade, 0, health)
        draw.color(4, 4, 4, 150)
        draw.circle_outline(x - 80, y, 24, 0, 1, 18, 10)
        draw.color(49, 199, 50)
        draw.circle_outline(x - 80, y, 23, 0, alpha * 0.01, 16, 10)

        local diff = engine.GetViewAngles().y - (lp:GetHitboxPosition(0) - lp:GetAbsOrigin()):Angles().y
        local ang = (diff * -1) / 8
        local ang = ang < 0 and 22.5 + (22.5 - math_abs(ang)) or ang

        draw.color(4, 4, 4, 150)
        draw.circle_outline(x - 80, y, 32, 0, 1, 7, 10)
        draw.color(49, 199, 50)
        draw.circle_outline(x - 80, y, 31, 0, math_min(ang * 0.05, 1), 5, 10)

        local fl = time_to_ticks(globals_CurTime() - lp:GetPropFloat("m_flSimulationTime")) + 2

        draw.color(4, 4, 4, 150)
        draw.circle_outline(x - 80, y, 40, 0, 1, 7, 10)
        draw.color(49, 199, 50)
        draw.circle_outline(x - 80, y, 39, 0, math_min(fl * 0.05, 1), 5, 10)
    end
end
callbacks.Register("Draw", on_draw)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

