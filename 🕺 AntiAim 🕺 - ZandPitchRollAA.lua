local lua_ref = gui.Reference("Ragebot", "Anti-aim", "Advanced")
 
local lua_enable = gui.Checkbox(lua_ref, "enable", "Enable Roll (VAC)", false)
local lua_ignore_targets = gui.Checkbox(lua_ref, "ignore_targets", "Ignore Targets", false)
lua_ignore_targets:SetDescription("Cheat wont shot, but roll will be active")

local lua_pitch_roll_angle = gui.Slider(lua_ref, "pitch_roll_angle", "Pitch Roll (VAC)", 130, -180, 180, 1)
local lua_z_roll_angle = gui.Slider(lua_ref, "z_roll_angle", "Z Roll (VAC)", 34, 0, 45, 1)

local has_target = false

--get aimbot targer
callbacks.Register("AimbotTarget", function(target)
    if target:GetIndex() then
        has_target = true
    else
        has_target = false
    end
end)

local function roll_anti_aim(cmd)
 if has_target == false or lua_ignore_targets:GetValue() then
 if lua_enable:GetValue() then
 if gui.GetValue('rbot.antiaim.base.rotation') < 0 then
         cmd.viewangles = EulerAngles(lua_pitch_roll_angle:GetValue(), cmd.viewangles.y, lua_z_roll_angle:GetValue())
     elseif gui.GetValue('rbot.antiaim.base.rotation') >= 0 then
         cmd.viewangles = EulerAngles(lua_pitch_roll_angle:GetValue(), cmd.viewangles.y, -lua_z_roll_angle:GetValue())
   end
     end
 else
 cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
 end
end
callbacks.Register('CreateMove', roll_anti_aim)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")