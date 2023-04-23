
local ref = gui.Reference("Ragebot", "Anti-aim", "Advanced")
local checkbox = gui.Checkbox(ref, "enable_legit_e", "Legit AA on E (Freestand)", false)

local saved = false
local saved_values = {
["rbot.antiaim.base"] = gui.GetValue("rbot.antiaim.base"),
["rbot.antiaim.base.lby"] = gui.GetValue("rbot.antiaim.base.lby"),
["rbot.antiaim.base.rotation"] = gui.GetValue("rbot.antiaim.base.rotation"),
["rbot.antiaim.advanced.antialign"] = gui.GetValue("rbot.antiaim.advanced.antialign"),
["rbot.antiaim.advanced.autodir.edges"] = gui.GetValue("rbot.antiaim.advanced.autodir.edges"),
["rbot.antiaim.advanced.autodir.targets"] = gui.GetValue("rbot.antiaim.advanced.autodir"),
["rbot.antiaim.advanced.pitch"] = gui.GetValue("rbot.antiaim.advanced.pitch"),
["rbot.antiaim.condition.use"] = gui.GetValue("rbot.antiaim.condition.use")
}

callbacks.Register("CreateMove", function(cmd)
if not checkbox:GetValue() or bit.band(cmd.buttons, bit.lshift(1, 5)) == 0 then

if saved then
for i, v in next, saved_values do
gui.SetValue(i, v)
end
saved = false
end

return
end

if not cmd.sendpacket then return end

if not saved then
for i, v in next, saved_values do
saved_values[i] = gui.GetValue(i)
end
saved = true
end

local local_player = entities.GetLocalPlayer()

local eye_pos = local_player:GetAbsOrigin()
local yaw = cmd:GetViewAngles().yaw

local frac_num = {
["f_left"] = 0,
["f_right"] = 0
}

for i = yaw - 90, yaw + 90, 30 do
if i ~= yaw then
local rad = math.rad(i)

local destination = Vector3(eye_pos.x + 256 * math.cos(rad), eye_pos.y + 256 * math.sin(rad), eye_pos.z)

local trace = engine.TraceLine(eye_pos, destination, 0xFFFFFFFF)

local side = i < yaw and "f_left" or "f_right"

frac_num[side] = frac_num[side] + trace.fraction
end
end

gui.SetValue("rbot.antiaim.condition.use", 0)
gui.SetValue("rbot.antiaim.advanced.pitch", 0)
gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
gui.SetValue("rbot.antiaim.base", [[0 "Desync"]])
gui.SetValue("rbot.antiaim.base.rotation", frac_num["f_left"] > frac_num["f_right"] and 58 or -58)
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

