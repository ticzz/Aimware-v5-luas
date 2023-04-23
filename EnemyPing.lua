local lua_ref = gui.Reference("Visuals", "World","Extra")

local lua_enemy_ping = gui.Checkbox(lua_ref, "enemy_ping", "Enable Enemy Ping", true)

local particles = {{}}
local ping_particles = {}
function enemy_ping(GameEvent)
    if GameEvent then
        if lua_enemy_ping:GetValue() then
            if GameEvent:GetName() == "player_ping" then
                local user = GameEvent:GetInt("userid")
                local user_entity = entities.GetByUserID(GameEvent:GetInt("userid"))
                local user_index = entities.GetByUserID(GameEvent:GetInt("userid")):GetIndex()
                local local_index = entities:GetLocalPlayer():GetIndex()
                if local_index ~= user_index and user_entity:IsAlive() and user_entity:IsPlayer() and user_entity:GetTeamNumber() ~= entities:GetLocalPlayer():GetTeamNumber() then
                    local ping_pos_x = GameEvent:GetFloat("x")
                    local ping_pos_y = GameEvent:GetFloat("y")
                    local ping_pos_z = GameEvent:GetFloat("z")
                    local is_urgent = GameEvent:GetInt("urgent")

                    current_tick = globals.TickCount() + 720

                    ping_particles = {}
                    table.insert(ping_particles, ping_pos_x)
                    table.insert(ping_particles, ping_pos_y)
                    table.insert(ping_particles, ping_pos_z + 30)
                    table.insert(ping_particles, is_urgent)
                    table.insert(ping_particles, current_tick)
                    table.insert(ping_particles, 0)

                    table.insert(particles, ping_particles)
                end
            end
        end
    end
end
client.AllowListener("player_ping")
callbacks.Register('FireGameEvent', enemy_ping);
callbacks.Register('Draw', enemy_ping);

function draw_ping()
    if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then
        particles = {}
        timer = 0
    end
    if lua_enemy_ping:GetValue() then
        for i = 1, #particles, 1 do
            if particles[i][1] ~= nil then
                ping_screen_pos_x, ping_screen_pos_y = client.WorldToScreen(Vector3(particles[i][1], particles[i][2], particles[i][3]))     
                local timer = particles[i][5] - globals.TickCount()
                if math.floor(timer / 70) % 2 == 0 then
                   particles[i][6] = particles[i][6] - 0.05
                elseif math.floor(timer / 70) % 2 ~= 0 then
                    particles[i][6] = particles[i][6] + 0.05
                end
                if timer >= 255 then 
                    a = 255 
                elseif timer < 255 then
                    a = timer
                end

                if ping_screen_pos_x ~= nil and ping_screen_pos_y ~= nil and timer > 0 then
                    if particles[i][4] == 0 then
                        draw.Color(110, 170, 255, a)
                        draw.FilledRect(ping_screen_pos_x - 2, ping_screen_pos_y - 10 + particles[i][6],  ping_screen_pos_x + 2, ping_screen_pos_y + 10 + particles[i][6])
                        draw.Triangle(ping_screen_pos_x - 5, ping_screen_pos_y + 10 + particles[i][6],  ping_screen_pos_x + 5, ping_screen_pos_y + 10 + particles[i][6], ping_screen_pos_x, ping_screen_pos_y + 15 + particles[i][6])
                    elseif particles[i][4] == 1 then
                        draw.Color(255, 0, 0, a)
                        draw.FilledRect(ping_screen_pos_x - 2, ping_screen_pos_y - 10,  ping_screen_pos_x + 2, ping_screen_pos_y + 10 + particles[i][6])
                        draw.Triangle(ping_screen_pos_x - 5, ping_screen_pos_y + 10 + particles[i][6],  ping_screen_pos_x + 5, ping_screen_pos_y + 10 + particles[i][6], ping_screen_pos_x, ping_screen_pos_y + 15 + particles[i][6])
                    end
                end
            end
        end
    end
end
callbacks.Register('Draw', draw_ping);





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")