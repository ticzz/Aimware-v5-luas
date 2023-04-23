local show_proper_desync_viewangle = gui.Checkbox(gui.Reference("Ragebot", "Anti-Aim", "Condition"), "show_proper_desync_viewangle", "Show Proper Desync", false)

--converting degree to radian
local function degreeToRad(degree)
    return (degree / 180) * math.pi;
end


--clamping yaw between -180 and 180
local function clampYaw(yaw)

    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end

    return math.floor(yaw)
end


--some variables for data
local local_view_pos = {};
local desync_view_pos = {};
local local_abs_pos = {};

--that variable will collect only real angle
local last_view_angle = 0;


--getting data about viewangles, like desync angle, real angle
local function getAntiAimAngles(cmd)

    --collecting info about local player
    local local_entity = entities.GetLocalPlayer()

    local local_abs = local_entity:GetAbsOrigin()
    local_abs_pos = {client.WorldToScreen(Vector3(local_abs.x, local_abs.y, local_abs.z))}


    --desync viewangles requiring a not sendpackets to get correct pos
    if not cmd.sendpacket then

        --getting desync viewangles, they shouldn't be filtred
        local desync_view_angle = cmd:GetViewAngles()

        --making more real desync angle for current bones
        --2 its not proper(on chost chams), 4 its proper(on viewangles)
        local desync_angle_corrector = show_proper_desync_viewangle:GetValue() and 4 or 2.2

        --getting vector of desync
        local desync_y_vector = 40 * math.sin(degreeToRad(desync_view_angle.y - (desync_angle_corrector * gui.GetValue("rbot.antiaim.base.rotation"))))
        local desync_x_vector = 40 * math.cos(degreeToRad(desync_view_angle.y - (desync_angle_corrector * gui.GetValue("rbot.antiaim.base.rotation"))))

        --getting 2D of view angles, if u wanna get 3D just remove world to screen
        --they are will be in global scope, to draw function can collect them
        desync_view_pos = {client.WorldToScreen(Vector3(local_abs.x + desync_x_vector, local_abs.y + desync_y_vector, local_abs.z))}
    end


    --real viewangle requiring a sendpackets to get correct pos
    if cmd.sendpacket then

        --getting viewangles, that will be filtred for real
        local real_view_angle = cmd:GetViewAngles()

        --getting vector of real
        local y_vector = 40 * math.sin(degreeToRad(real_view_angle.y))
        local x_vector = 40 * math.cos(degreeToRad(real_view_angle.y))

        --getting 2D of view angles, if u wanna get 3D just remove world to screen
        --they are will be in global scope, to draw function can collect them
        local_view_pos = {client.WorldToScreen(Vector3(local_abs.x + x_vector, local_abs.y + y_vector, local_abs.z))}
    end
end
callbacks.Register("CreateMove", getAntiAimAngles)


--here we are drawing this indicators
callbacks.Register("Draw", function()

    --checking for valid 
    --drawing desync
    if local_abs_pos[1] and local_abs_pos[2] and desync_view_pos[1] and desync_view_pos[2] then

        draw.Color(255, 0, 0)
        draw.Line(local_abs_pos[1], local_abs_pos[2], desync_view_pos[1], desync_view_pos[2])
        draw.FilledRect(desync_view_pos[1] - 2, desync_view_pos[2] - 2, desync_view_pos[1] + 2, desync_view_pos[2] + 2)
    end

    --checking for valid
    --drawing real
    if local_abs_pos[1] and local_abs_pos[2] and local_view_pos[1] and local_view_pos[2] then

        draw.Color(0, 255, 0)
        draw.Line(local_abs_pos[1], local_abs_pos[2], local_view_pos[1], local_view_pos[2])
        draw.FilledRect(local_view_pos[1] - 2, local_view_pos[2] - 2, local_view_pos[1] + 2, local_view_pos[2] + 2)
    end

    --checking for valid
    --drawing local abs rect
    if local_abs_pos[1] and local_abs_pos[2] then

        draw.Color(50, 50, 50)
        draw.FilledRect(local_abs_pos[1] - 3, local_abs_pos[2] - 3, local_abs_pos[1] + 3, local_abs_pos[2] + 3)
    end
end)
