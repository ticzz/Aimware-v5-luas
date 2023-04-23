local OOV_always = gui.Checkbox(gui.Tab(gui.Reference("Visuals"), "localtab", "Helper"),"OOV.always", "Consider FOV", false);
local OOV_color = gui.ColorPicker(gui.Tab(gui.Reference("Visuals"), "localtab", "Helper"), "OOV.clr", "Out Of Viev Color", 255, 255, 255, 255)

local function bad_argument(expression, name, expected)
    assert(type(expression) == expected, " bad argument #1 to '%s' (%s expected, got %s)", 4, name, expected, tostring(type(expression)))
end

function circle_outline(x, y, r, g, b, a, radius, start_degrees, percentage, thickness, radian)
    bad_argument(x and y and radius and start_degrees and percentage and thickness, "circle_outline", "number")

    local thickness = radius - thickness
    local percentage = math.abs(percentage * 360)
    local radian = radian or 1

    draw.Color(r, g, b, a)

    for i = start_degrees + radian, start_degrees + percentage, radian do
        local cos_1 = math.cos(i * math.pi / 180)
        local sin_1 = math.sin(i * math.pi / 180)
        local cos_2 = math.cos((i + radian) * math.pi / 180)
        local sin_2 = math.sin((i + radian) * math.pi / 180)

        local x0 = x + cos_2 * thickness
        local y0 = y + sin_2 * thickness
        local x1 = x + cos_1 * radius
        local y1 = y + sin_1 * radius
        local x2 = x + cos_2 * radius
        local y2 = y + sin_2 * radius
        local x3 = x + cos_1 * thickness
        local y3 = y + sin_1 * thickness

        draw.Triangle(x1, y1, x2, y2, x3, y3)
        draw.Triangle(x3, y3, x2, y2, x0, y + sin_2 * thickness)
    end
end
local function clamp(val, min, max)
    if val > max then
        return max
    elseif val < min then
        return min
    else
        return val
    end
end

local alpha = {}
local players = {activity = {}}

local function Draw()
    local lp = entities.GetLocalPlayer()
    if not lp then return end

    local fade = ((1.0 / 0.15) * globals.FrameTime()) * 80
    local r, g, b, a = OOV_color:GetValue()

    local screen_size = {draw.GetScreenSize()}
    local screen_size_x = screen_size[1] * 0.5
    local screen_size_y = screen_size[2] * 0.5

    local out_of_view_scale = 15

    local temp = {}
    local lp_abs = lp:GetAbsOrigin()
    local view_angles = engine.GetViewAngles()

    local CCSPlayer = entities.FindByClass("CCSPlayer")
    for k, v in pairs(CCSPlayer) do
        local index = v:GetIndex()

        local v_abs = v:GetAbsOrigin()
        local dist = vector.Distance({v_abs.x, v_abs.y, v_abs.z}, {lp_abs.x, lp_abs.y, lp_abs.z})

        alpha[index] = alpha[index] or 0
        if players.activity[index] then
            alpha[index] = players[index] and lp:IsAlive() and clamp(alpha[index] + fade, 0, a) or clamp(alpha[index] - fade, 0, a)
        else
            alpha[index] =
                v:IsPlayer() and v:GetTeamNumber() ~= lp:GetTeamNumber() and v:IsAlive() and lp:IsAlive() and dist <= 1500 and
                clamp(alpha[index] + fade, 0, a) or
                clamp(alpha[index] - fade, 0, a)
        end

        if alpha[index] ~= 0 then
            table.insert(temp, CCSPlayer[k])
        end
        players[index] = nil
        players.activity[index] = nil
    end

    for k, v in pairs(temp) do
        local index = v:GetIndex()
        local v_abs = v:GetAbsOrigin()
		local psx,psy = client.WorldToScreen(v_abs);
        angle = (v_abs - lp_abs):Angles()
        angle.y = angle.y - view_angles.y
        for i = 1, 2, 0.2 do
            local alpha = i / 5 * alpha[index]
			
			if psx == nil and psy == nil or psx < 100 or psy < 100 or psx > screen_size_x+500 or psy > screen_size_y+100 or not OOV_always:GetValue() then					
            circle_outline(
                screen_size_x,
                screen_size_y,
                r,
                g,
                b,
                alpha,
                (125 + i),
                (270 - 0.13 * 170) - angle.y + (i * 0.2),
                0.075 + (i * 0.00005),
                (i * 2)
            )
			circle_outline(
                screen_size_x,
                screen_size_y,
                r,
                g,
                b,
                alpha,
                (130 + i),
                (270 - 0.13 * 170) - angle.y + (i * 0.2),
                0.075 + (i * 0.00005),
                (i * 0.5)
            )		
			end
        end
    end
end

callbacks.Register("Draw", Draw)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

