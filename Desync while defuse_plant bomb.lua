
local ref = gui.Reference("Ragebot", "Anti-aim", "Extra", "Conditions")
local chk = gui.Checkbox(ref, "chk_disable_on_use", "Custom Disable On Use", false)

chk:SetDescription("Disable on use with desync.")

local USED = false
local values = {
pitchstyle = 0,
yawfakestyle = 0,
yawstyle = 0,
yaw = 0,
autodir = 0,
autodirinvert = false,
desync = 0
}

callbacks.Register("CreateMove", function(cmd)
local pLocal = entities.GetLocalPlayer()

if not pLocal then return end
if not pLocal:IsAlive() then return end

local IN_USE = bit.lshift(1,5)

local IS_USING = bit.band(cmd.buttons, IN_USE) == IN_USE

local IS_DEFUSING = pLocal:GetProp("m_bIsDefusing")

local IS_RESCUING = pLocal:GetProp("m_bIsRescuing")

if chk:GetValue() then
gui.SetValue("rbot.antiaim.extra.condition.use", 0)

if IS_USING then
if not USED then
USED = true

values.pitchstyle = gui.GetValue("rbot.antiaim.pitchstyle")
values.yawfakestyle = gui.GetValue("rbot.antiaim.yawfakestyle")
values.yawstyle = gui.GetValue("rbot.antiaim.yawstyle")
values.yaw = gui.GetValue("rbot.antiaim.yaw")
values.autodir = gui.GetValue("rbot.antiaim.autodir")
values.autodirinvert = gui.GetValue("rbot.antiaim.autodirinvert")
values.desync = gui.GetValue("rbot.antiaim.desync")
end

if IS_DEFUSING or IS_RESCUING then
gui.SetValue("rbot.antiaim.yawfakestyle", 0)
else
gui.SetValue("rbot.antiaim.yawfakestyle", 1)
end
gui.SetValue("rbot.antiaim.yawfakestyle", 1)
gui.SetValue("rbot.antiaim.pitchstyle", 0)
gui.SetValue("rbot.antiaim.yawstyle", 0)
gui.SetValue("rbot.antiaim.yawfakestyle", values.yawfakestyle)
gui.SetValue("rbot.antiaim.autodir", 0)
gui.SetValue("rbot.antiaim.autodirinvert", 0)
gui.SetValue("rbot.antiaim.desync", 58)
gui.SetValue("rbot.antiaim.yaw", 0)
else
if USED then
USED = false

gui.SetValue("rbot.antiaim.pitchstyle", values.pitchstyle)
gui.SetValue("rbot.antiaim.yawstyle", values.yawstyle)
gui.SetValue("rbot.antiaim.yawfakestyle", values.yawfakestyle)
gui.SetValue("rbot.antiaim.autodir", values.autodir)
gui.SetValue("rbot.antiaim.autodirinvert", values.autodirinvert)
gui.SetValue("rbot.antiaim.desync", values.desync)
gui.SetValue("rbot.antiaim.yaw", values.yaw)
end
end
end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

