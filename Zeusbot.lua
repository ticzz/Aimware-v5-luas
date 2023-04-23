-------------------- Zeusbot
local zeusbot = gui.Checkbox(gui.Reference("Legitbot", "Other", "Extra"), "enable_zeusbot_chkbox", "Enable Zeusbot", 0)

zeusbot:SetDescription("Enable Zeus Triggerbot")
local function zeuslegit()
if not zeusbot:GetValue() or entities.GetLocalPlayer() == nil then 
return 
end

local Weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon") 
if Weapon == nil then 
return 
end

local CWeapon = Weapon:GetClass() 
local trige, trigaf, trighc = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance")

if trige ~= 1 and trigaf ~= 1 and trighc ~= gui.GetValue("rbot.hitscan.accuracy.zeus.hitchance") then 
trige2, trigaf2, trighc2 = gui.GetValue("lbot.trg.enable"), gui.GetValue("lbot.trg.autofire"), gui.GetValue("lbot.trg.zeus.hitchance") 
end

if CWeapon == "CWeaponTaser" then 
gui.SetValue("lbot.trg.enable", 1) 
gui.SetValue("lbot.trg.autofire", 1) 
gui.SetValue("lbot.trg.zeus.hitchance", gui.GetValue("rbot.hitscan.accuracy.zeus.hitchance"))
else 
gui.SetValue("lbot.trg.enable", trige2) 
gui.SetValue("lbot.trg.autofire", trigaf2) 
gui.SetValue("lbot.trg.zeus.hitchance", trighc2) 
end 
end

callbacks.Register("Draw", zeuslegit)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

