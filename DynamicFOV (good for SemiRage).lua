local ref = gui.Reference("Ragebot", "Aimbot", "Target")
local chk_dynfov = gui.Checkbox(ref, "chk_dynfov", "Dynamic FOV", false)
local sld_minfov = gui.Slider(ref, "sld_minfov", "Minimum Dynamic FOV", 5, 0, 30)
local sld_maxfov = gui.Slider(ref, "sld_maxfov", "Maximum Dynamic FOV", 25, 0, 30)

local viewangles;

local function dynamicfov_logic()
local pLocal = entities.GetLocalPlayer()

if not chk_dynfov:GetValue() then return end
if not pLocal then return end
if not pLocal:GetAbsOrigin() then return end

local dynamicfov_new_fov = gui.GetValue("rbot.aim.target.fov")
local players = entities.FindByClass("CCSPlayer")
local enemy_players = {}

local min_fov = sld_minfov:GetValue()
local max_fov = sld_maxfov:GetValue()

if min_fov > max_fov then
local store_min_fov = min_fov
min_fov = max_fov
max_fov = store_min_fov
end

for i = 1, #players do
if players[i]:GetPropInt("m_iTeamNum") ~= entities.GetLocalPlayer():GetPropInt("m_iTeamNum") and not players[i]:IsDormant() then
table.insert(enemy_players, players[i])
end
end

if #enemy_players ~= 0 then
local own_hitbox = pLocal:GetHitboxPosition(0)
local own_x, own_y, own_z = own_hitbox.x, own_hitbox.y, own_hitbox.z
local own_pitch, own_yaw = viewangles.pitch, viewangles.yaw
closest_enemy = nil
local closest_distance = math.huge

for i = 1, #enemy_players do
local enemy = enemy_players[i]
local enemy_x, enemy_y, enemy_z = enemy:GetHitboxPosition(0).x, enemy:GetHitboxPosition(0).y, enemy:GetHitboxPosition(0).z
local x = enemy_x - own_x
local y = enemy_y - own_y
local z = enemy_z - own_z

local yaw = (math.atan2(y, x) * 180 / math.pi)
local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)

            local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
            local pitch_dif = math.abs(own_pitch - pitch) % 360

            if yaw_dif > 180 then
                yaw_dif = 360 - yaw_dif
            end

            local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

            if closest_distance > real_dif then
                closest_distance = real_dif
                closest_enemy = enemy
            end
end

if closest_enemy ~= nil then
local closest_enemy_x, closest_enemy_y, closest_enemy_z = closest_enemy:GetHitboxPosition(0).x, closest_enemy:GetHitboxPosition(0).y, closest_enemy:GetHitboxPosition(0).z
            local real_distance = math.sqrt(math.pow(own_x - closest_enemy_x, 2) + math.pow(own_y - closest_enemy_y, 2) + math.pow(own_z - closest_enemy_z, 2))

            dynamicfov_new_fov = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
end
if (dynamicfov_new_fov > max_fov) then
            dynamicfov_new_fov = max_fov
        elseif dynamicfov_new_fov < min_fov then
            dynamicfov_new_fov = min_fov
        end

        dynamicfov_new_fov = math.floor(dynamicfov_new_fov + 0.5)

        if (dynamicfov_new_fov > closest_distance) then
            bool_in_fov = true
        else
            bool_in_fov = false
        end
    else
        dynamicfov_new_fov = min_fov
        bool_in_fov = false
    end

    if dynamicfov_new_fov ~= old_fov then
        gui.SetValue("rbot.aim.target.fov", dynamicfov_new_fov)
    end
end

callbacks.Register("Draw", "dynfov", dynamicfov_logic)

callbacks.Register("Draw", function()
sld_minfov:SetInvisible(not chk_dynfov:GetValue())
sld_maxfov:SetInvisible(not chk_dynfov:GetValue())
end)

callbacks.Register("CreateMove", function(cmd)
viewangles = cmd:GetViewAngles()
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

