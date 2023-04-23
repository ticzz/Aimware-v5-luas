local lua_ref = gui.Tab(gui.Reference("Visuals"), "localtab", "Helper")

local lua_enable_trails = gui.Checkbox(lua_ref, "enable_trails", "Enable Trails", false)

local lua_trails_color = gui.ColorPicker(lua_enable_trails, "trails_color", "", 255, 255, 255)
local lua_trails_time_of_visibility = gui.Slider(lua_ref, "trails_time_of_visibility", "Trails Time Of Visibility", 150, 0, 300, 1) 
local lua_trails_color_rgb = gui.Checkbox(lua_ref, "trails_color_rgb", "Enable RGB trails", false) 
local lua_trails_rgb_speed = gui.Slider(lua_ref, "trails_rgb_speed", "RGB Speed", 0.15, 0.01, 2, 0.01) 

local trail_particles = { }
local particles = { }

local function RaibowColor(Step, Speed)
    local r = math.floor(math.sin(Step * Speed) * 127 + 128)
    local g = math.floor(math.sin(Step * Speed + 2) * 127 + 128)
    local b = math.floor(math.sin(Step * Speed + 4) * 127 + 128)
    return r, g, b;
end

function draw_trail()
    if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then 
        particles = { }
        return
    end
    if lua_enable_trails:GetValue() then
        if entities:GetLocalPlayer():GetAbsOrigin() ~= nil then
            local_pos = entities:GetLocalPlayer():GetAbsOrigin()
        end

        if local_pos.x ~= nil and local_pos.y ~= nil and local_pos.z ~= nil then
            trail_particles  = {}

            table.insert(trail_particles, local_pos.x)
            table.insert(trail_particles, local_pos.y)
            table.insert(trail_particles, local_pos.z)

            table.insert(trail_particles, globals.TickCount() + lua_trails_time_of_visibility:GetValue())

            if trail_particles[1] ~= nil and trail_particles[2] ~= nil and trail_particles[3] ~= nil and trail_particles[4] ~= nil then
                table.insert(particles, trail_particles)

                for i = 1, #particles, 1 do
                    if particles[i] then
                        if particles[i][4] - globals.TickCount() < 0 then
                            table.remove(particles, i)
                        end
                    end
                end
            end
        end

        for i = 1, #particles, 1 do
            if particles[i][1] ~= nil and particles[i][2] ~= nil and particles[i][3] ~= nil and particles[i][4] ~= nil then 
                if particles[i] and particles[i + 1] then
                    local position_x, position_y = client.WorldToScreen(Vector3(particles[i][1], particles[i][2], particles[i][3]))
                    local old_position_x, old_position_y = client.WorldToScreen(Vector3(particles[i + 1][1], particles[i + 1][2], particles[i + 1][3]))

                    if lua_trails_color_rgb:GetValue() then
                        draw.Color(RaibowColor(i / 10, lua_trails_rgb_speed:GetValue()))
                    else 
                        draw.Color(lua_trails_color:GetValue())
                    end

                    if position_x ~= nil and position_y ~= nil and old_position_x ~= nil and old_position_y ~= nil then
                        if particles[i][4] - globals.TickCount() > 0 then
                            draw.Line(old_position_x, old_position_y, position_x, position_y)
                            draw.Line(position_x+1, position_y+1, old_position_x+1, old_position_y+1)
                        end
                    end
                end
            end
        end
    end
end
callbacks.Register("Draw", draw_trail)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")