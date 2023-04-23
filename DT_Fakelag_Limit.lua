local ref = gui.Reference("Misc", "Enhancement", "Fakelag")
local sld_nrm = gui.Slider(ref, "sld_nrm_limit", "Normal Limit", 3, 0, 16)
local sld = gui.Slider(ref, "sld_dtfl_limit", "DT Fakelag Limit", 3, 0, 16)

local function weapon_info(id)
if id == 1 then
return "hpistol"
elseif id == 2 or id == 3 or id == 4 or id == 30 or id == 32 or id == 36 or id == 61 or id == 63 then
return "pistol"
elseif id == 7 or id == 8 or id == 10 or id == 13 or id == 16 or id == 39 or id == 60 then
return "rifle"
elseif id == 11 or id == 38 then
return "asniper"
elseif id == 17 or id == 19 or id == 23 or id == 24 or id == 26 or id == 33 or id == 34 then
return "smg"
elseif id == 14 or id == 28 then
return "lmg"
elseif id == 25 or id == 27 or id == 29 or id == 35 then
return "shotgun"
elseif id == 9 then
return "sniper"
elseif id == 40 then
return "scout"
end
end

local function is_dt(name)
if name ~= nil then
if name == "sniper" or name == "scout" then
return false
end
return gui.GetValue("rbot.hitscan.accuracy." .. name .. ".doublefire") ~= 0
else
return false
end
end

callbacks.Register("Draw", function()
local lp = entities.GetLocalPlayer()
if not lp then return end
if not lp:IsAlive() then return end
local dt = is_dt(weapon_info(lp:GetWeaponID()))
if dt then
gui.SetValue("misc.fakelag.enable", sld:GetValue() >= 3)
gui.SetValue("misc.fakelag.factor", sld:GetValue())
else
gui.SetValue("misc.fakelag.enable", sld_nrm:GetValue() >= 3)
gui.SetValue("misc.fakelag.factor", sld_nrm:GetValue())
end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

