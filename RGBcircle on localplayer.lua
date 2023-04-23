local LUA_ring = gui.Reference("VISUALS", "MISC", "Yourself Extra")
local configure = gui.Checkbox(LUA_ring, "lua_configure", "Circle Configuration", 0)
local configure_window = gui.Window("lua_configure_window", "Circle Configuration", 255, 255, 382, 485)
local configure_groupbox = gui.Groupbox(configure_window, "General", 10, 10, 180, 434)
gui.Text(configure_groupbox, "Sides")
local step_size = gui.Editbox(configure_groupbox, "lua_ring_step", 360)
gui.Text(configure_groupbox, "Range")
local radius = gui.Editbox(configure_groupbox, "lua_ring_radius", 100)
local height = gui.Slider(configure_groupbox, "lua_ring_height", "Height", 30, 0, 100)
local thirdperson_circle = gui.Checkbox(configure_groupbox, "lua_thirdperson_circle", "Show Thirdperson", 1)
local firstperson_circle = gui.Checkbox(configure_groupbox, "lua_firstperson_circle", "Show Firstperson", 1)
local knife_range_active = gui.Checkbox(configure_groupbox, "lua_knife_range_active", "Knife Range", 0)
local zeus_range_active = gui.Checkbox(configure_groupbox, "lua_zeus_range_active", "Taser Range", 0)
local range_smooth = gui.Checkbox(configure_groupbox, "lua_range_smooth", "Smooth", 0)
local range_smooth_delay = gui.Slider(configure_groupbox, "lua_range_smooth_delay", "Smooth Delay", 36, 0, 100)
local configure_groupbox_fps = gui.Groupbox(configure_window, "Performance", 191, 10, 180, 195)
local fps_active = gui.Checkbox(configure_groupbox_fps, "lua_fps", "Adaptive Fps", 0)
gui.Text(configure_groupbox_fps, "Target Fps")
local fps_amount = gui.Editbox(configure_groupbox_fps, "lua_fps_amount", 144)
gui.Text(configure_groupbox_fps, "Max Sides")
local fps_max_faces = gui.Editbox(configure_groupbox_fps, "lua_max_faces", 720)
gui.Text(configure_groupbox_fps, "Min Sides")
local fps_min_faces = gui.Editbox(configure_groupbox_fps, "lua_min_faces", 360)
local follow_rotation = gui.Checkbox(configure_groupbox, "lua_follow_rotation", "Follow View Rotation", 0)
local corner = gui.Checkbox(configure_groupbox, "lua_corner", "Corners", 0)
local lines = gui.Checkbox(configure_groupbox, "lua_lines", "Line", 1)
local configure_groupbox_color = gui.Groupbox(configure_window, "Color", 191, 204, 180, 240)
local circle_rgb = gui.Checkbox(configure_groupbox_color, "lua_lines", "RGB Fade", 1)
local cricle_collision_active = gui.Checkbox(configure_groupbox, "lua_cricle_collision_active", "Collision", 1)
local circle_red = gui.Slider(configure_groupbox_color, "lua_ring_red", "Red", 255, 0, 255)
local circle_green = gui.Slider(configure_groupbox_color, "lua_ring_green", "Green", 255, 0, 255)
local circle_blue = gui.Slider(configure_groupbox_color, "lua_ring_blue", "Blue", 255, 0, 255)
local circle_alpha = gui.Slider(configure_groupbox_color, "lua_ring_alpha", "Opacity", 255, 0, 255)
local ring_fade_speed = gui.Slider(configure_groupbox_color, "lua_ring_fade_speed", "Fade Speed", 2, 0, 10)
local vec_ViewAngles = {0, 0, 0}
local frame_rate = 0.0
local deg = 0
local first_ray
local first_ray_x
local first_ray_y
local second_ray_x
local second_ray_y
local hue_extra
local r, g, b
local time = 0
local ease_now = false
local current_weapon = "weapon"
local current_weapon_old = "weapon"
local old_wep = "weapon"
local knife_range = 48
local taser_range = 132
local ease1 = 0
local ease2 = 0
local function getviewangles(UserCmd)
    if follow_rotation:GetValue() then
        vec_ViewAngles = {UserCmd:GetViewAngles()}
    else
        vec_ViewAngles = {0, 0, 0}
    end
end
local function hsv_to_rgb(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255, a * 255
end
function drawCircle(Position, Radius)
    second_ray_x, second_ray_y = nil, nil
    if tonumber(step_size:GetValue()) < 1 then
        gui.SetValue("lua_ring_step", 1)
    end
    deg = 360 / math.floor(tonumber(step_size:GetValue()))
    for degrees = 0, 360 + deg, deg do
        local ring_fade_val = ring_fade_speed:GetValue()
        if ring_fade_val < 0.1 then
            ring_fade_val = 0.1
        end
        hue_extra = globals.RealTime() % ring_fade_val / ring_fade_val
        r, g, b = hsv_to_rgb(degrees / 360 + hue_extra, 1, 1, 255)
        if circle_rgb:GetValue() then
            draw.Color(r, g, b, circle_alpha:GetValue())
        else
            draw.Color(circle_red:GetValue(), circle_green:GetValue(), circle_blue:GetValue(), circle_alpha:GetValue())
        end
        if cricle_collision_active:GetValue() then
        useless, first_ray = engine.TraceLine(Position[1], Position[2], Position[3], Position[1] + math.sin(math.rad(degrees - vec_ViewAngles[2] - 90)) * Radius, Position[2] + math.cos(math.rad(degrees - vec_ViewAngles[2] - 90)) * Radius, Position[3])
        else
            first_ray = 1
        end
        first_ray_x, first_ray_y = client.WorldToScreen(Position[1] + math.sin(math.rad(degrees - vec_ViewAngles[2] - 90)) * first_ray * Radius, Position[2] + math.cos(math.rad(degrees - vec_ViewAngles[2] - 90)) * first_ray * Radius, Position[3])
        if first_ray_x ~= nil and first_ray_y ~= nil and second_ray_x ~= nil and second_ray_y ~= nil then
            if lines:GetValue() then
                draw.Line(first_ray_x, first_ray_y, second_ray_x, second_ray_y)
            end
            if corner:GetValue() then
                --draw.TextShadow(second_ray_x, second_ray_y, math.floor(first_ray * 100))
                draw.TextShadow(second_ray_x, second_ray_y - 6, "+")
            end
        end
        second_ray_x, second_ray_y = client.WorldToScreen(Position[1] + math.sin(math.rad(degrees - vec_ViewAngles[2] - 90)) * first_ray * Radius, Position[2] + math.cos(math.rad(degrees - vec_ViewAngles[2] - 90)) * first_ray * Radius, Position[3])
    end
end
function get_abs_fps()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end
function check_stuff()
    if configure:GetValue() and gui.Reference("MENU"):IsActive() == true then
        configure_window:SetActive(1)
    else
        configure_window:SetActive(0)
    end
    if not thirdperson_circle:GetValue() or not firstperson_circle:GetValue() then
        if thirdperson_circle:GetValue() then
            if gui.GetValue("vis_thirdperson_dist") ~= 0 then
                draw_callback()
            end
        elseif firstperson_circle:GetValue() then
            if gui.GetValue("vis_thirdperson_dist") == 0 then
                draw_callback()
            end
        end
    else
        draw_callback()
    end
end
function func_smooth(time, start, difference, speed)
    time = time / speed - 1
    return difference * ((time ^ 5) + 1) + start
end
function draw_callback()
    if lines:GetValue() == nil or corner:GetValue() == nil or entities.GetLocalPlayer() == nil or tonumber(step_size:GetValue()) == nil or tonumber(radius:GetValue()) == nil or range_smooth_delay:GetValue() == nil then
        return
    end
    if fps_active:GetValue() then
        local fpss = get_abs_fps()
        local current_set_faces = tonumber(step_size:GetValue())
        local max_faces = tonumber(fps_max_faces:GetValue())
        local min_faces = tonumber(fps_min_faces:GetValue())
        local fps_cap = tonumber(fps_amount:GetValue())
        if max_faces ~= nil and fps_cap ~= nil and current_set_faces ~= nil and min_faces ~= nil then
            if fpss < fps_cap and current_set_faces > min_faces then
                gui.SetValue("lua_ring_step", current_set_faces - 1)
            elseif fpss > fps_cap and current_set_faces < max_faces then
                gui.SetValue("lua_ring_step", current_set_faces + 1)
            end
        end
    end
    local my_pos_x, my_pos_y, my_pos_z
    local current_radius = math.floor(tonumber(radius:GetValue()))
    if entities.GetLocalPlayer():IsAlive() then
        my_pos_x, my_pos_y, my_pos_z = entities.GetLocalPlayer():GetAbsOrigin()
        if current_weapon == current_weapon_old then
            current_weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetName()
            if string.match(current_weapon, "knife") or string.match(current_weapon, "axe") or string.match(current_weapon, "hammer") or string.match(current_weapon, "spanner") or string.match(current_weapon, "fists") or string.match(current_weapon, "bayonet") then
                current_weapon = "knife"
            end
            if (current_weapon ~= "taser" and current_weapon ~= "knife") or (not knife_range_active:GetValue() and current_weapon == "knife") or (not zeus_range_active:GetValue() and current_weapon == "taser") then
                current_weapon = "weapon"
            end
        end
    else
        local observ_target = entities.GetLocalPlayer():GetPropEntity("m_hObserverTarget")
        if observ_target == nil then
            return
        end
        my_pos_x, my_pos_y, my_pos_z = observ_target:GetAbsOrigin()
        current_weapon = "weapon"
    end
    if range_smooth:GetValue() and current_weapon_old ~= nil then
        if ease_now == true and current_radius ~= nil then
            time = time + globals.FrameTime()
            set_range_new = func_smooth(time, ease1, ease2 - ease1, range_smooth_delay:GetValue() / 100)
            if time > range_smooth_delay:GetValue() / 100 then
                ease_now = false
            end
        end
    elseif current_radius ~= nil then
        if current_weapon == "weapon" then
            set_range_new = current_radius
        elseif current_weapon == "taser" then
            set_range_new = taser_range
        elseif current_weapon == "knife" then
            set_range_new = knife_range
        else
            set_range_new = current_radius
        end
    end
    if current_weapon ~= current_weapon_old and current_weapon_old ~= nil then
        old_wep = current_weapon_old
        if current_weapon == "knife" and old_wep == "taser" then
            ease1, ease2 = taser_range, knife_range
        elseif current_weapon == "knife" and old_wep == "weapon" then
            ease1, ease2 = current_radius, knife_range
        elseif current_weapon == "taser" and old_wep == "weapon" then
            ease1, ease2 = current_radius, taser_range
        elseif current_weapon == "taser" and old_wep == "knife" then
            ease1, ease2 = knife_range, taser_range
        elseif current_weapon == "weapon" and old_wep == "knife" then
            ease1, ease2 = knife_range, current_radius
        elseif current_weapon == "weapon" and old_wep == "taser" then
            ease1, ease2 = taser_range, current_radius
        end
        time = 0
        ease_now = true
    end
    current_weapon_old = current_weapon
    if set_range_new == nil then
        return
    end
    if set_range_new < 0.5 then
        return
    end
    drawCircle({my_pos_x, my_pos_y, my_pos_z + math.floor(height:GetValue())}, set_range_new)
end
callbacks.Register("CreateMove", getviewangles)
callbacks.Register("Draw", "ring_thing", check_stuff)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

