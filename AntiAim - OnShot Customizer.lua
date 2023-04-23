--by w1ldac3

local ref = gui.Reference("Ragebot", "Anti-Aim", "Condition")
local check = gui.Checkbox(ref, "on.shot.customizer", "On Shot Customizer", false)
local ref3 = gui.Reference("Misc", "Enhancement", "Fakelag")
local flcheck = gui.Checkbox(ref3, "flmanonshot", "On Shot Customizer manipulations", false)
flcheck:SetDescription("Permission to customize your FakeLag.")
check:SetDescription("Enables On Shot customizer.")
local ref2 = gui.Reference("Misc", "Enhancement", "Fakelag", "Conditions")
local offflonshift = gui.Checkbox(ref2, "onshfshot", "Shift on Shot", false)
local multdef = gui.Multibox(ref, "Default on Shot")
multdef:SetDescription("Toggles Default on Shot for enabled weapons.")
local defpistol = gui.Checkbox(multdef, "def.onshot.pistols", "Pistols", true)
local defhpistol = gui.Checkbox(multdef, "def.onshot.hpistols", "HPistols", true)
local defscout = gui.Checkbox(multdef, "def.onshot.scout", "Scout", true)
local defasniper = gui.Checkbox(multdef, "def.onshot.asniper", "Auto-Snipers", true)
local defawp = gui.Checkbox(multdef, "def.onshot.awp", "AWP", true)
local defother = gui.Checkbox(multdef, "def.onshot.others", "Others (Next update)", true)
local multdes = gui.Multibox(ref, "Desync on Shot")
multdes:SetDescription("Toggles Desync on Shot for enabled weapons.")
local despistol = gui.Checkbox(multdes, "des.onshot.pistols", "Pistols", false)
local deshpistol = gui.Checkbox(multdes, "des.onshot.hpistols", "HPistols", false)
local desscout = gui.Checkbox(multdes, "des.onshot.scout", "Scout", false)
local desasniper = gui.Checkbox(multdes, "des.onshot.asniper", "Auto-Snipers", false)
local desawp = gui.Checkbox(multdes, "des.onshot.awp", "AWP", false)
local desother = gui.Checkbox(multdes, "des.onshot.others", "Others (Next update)", false)
local multshf = gui.Multibox(ref, "Shift on Shot")
multshf:SetDescription("Toggles Shift on Shot for enabled weapons.")
local shfpistol = gui.Checkbox(multshf, "shf.onshot.pistols", "Pistols", false)
local shfhpistol = gui.Checkbox(multshf, "shf.onshot.hpistols", "HPistols", false)
local shfscout = gui.Checkbox(multshf, "shf.onshot.scout", "Scout", false)
local shfasniper = gui.Checkbox(multshf, "shf.onshot.asniper", "Auto-Snipers", false)
local shfawp = gui.Checkbox(multshf, "shf.onshot.awp", "AWP", false)
local shfother = gui.Checkbox(multshf, "shf.onshot.others", "Others (Next update)", false)

local function checkweapon(event)
local WeaponID = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetWeaponID()
local USP = 61
local DUAL = 2
local P250 = 26
local REVOLVER = 64
local CZAUTO = 63
local DEAGLE = 1
local FIVESEVEN = 3
local GLOCK = 4
local P2000 = 32
local TEC9 = 30
local AK47 = 7
local AUG = 8
local FAMAS = 10
local GALIL = 13
local M4A1S = 60
local M4A4 = 16
local SG553 = 39
local MAC10 = 17
local MP7 = 33
local MP9 = 34
local MP5 = 23
local PPBIZON = 26
local P90 = 19
local UMP45 = 24
local MAG7 = 27
local NOVA = 35
local SAWEDOFF = 29
local XM1014 = 25
local M249 = 14
local NEGEV = 28
local AWP = 9
local G3SG1 = 11
local SCAR = 38
local SCOUT = 40
local ZEUS = 31
if WeaponID == USP or WeaponID == GLOCK or WeaponID == DUAL
or WeaponID == P250 or WeaponID == CZAUTO or WeaponID == FIVESEVEN 
or WeaponID == P2000 or WeaponID == TEC9 then
    Pistol = true else Pistol = false 
end
if WeaponID == REVOLVER or WeaponID == DEAGLE then 
    HPistol = true else HPistol = false 
end
if WeaponID == SCOUT then 
    Scout = true else Scout = false 
end
if WeaponID == G3SG1 or WeaponID == SCAR then 
    ASniper = true else ASniper = false 
end
if WeaponID == AWP then 
    Awp = true else Awp = false 
end
if WeaponID == AK47 or WeaponID == AUG or WeaponID == FAMAS
or WeaponID == GALIL or WeaponID == M4A1S or WeaponID == M4A4
or WeaponID == SG553 or WeaponID == MAC10 or WeaponID == P90
or WeaponID == UMP45 or WeaponID == MP7 or WeaponID == MP5
or WeaponID == MP9 or WeaponID == PPBIZON or WeaponID == MAG7
or WeaponID == NOVA or WeaponID == SAWEDOFF or WeaponID == XM1014
or WeaponID == NEGEV or WeaponID == M249 then
    Other = true else Other = false
    end
if WeaponID == ZEUS then
    gui.SetValue("rbot.antiaim.condition.onshot", 0)
end
if gui.GetValue("rbot.antiaim.condition.on.shot.customizer") then
if Pistol == true then
    if defpistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 0 )
    elseif despistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 1 )
    elseif shfpistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 2 )
    end
end
if HPistol == true then
    if defhpistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 0 )
    elseif deshpistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 1 )
    elseif shfhpistol:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 2 )
    end
end
if Scout == true then
    if defscout:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 0 )
    elseif desscout:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 1 )
    elseif shfscout:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 2 )
    end
end
if ASniper == true then
    if defasniper:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 0 )
    elseif desasniper:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 1 )
    elseif shfasniper:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 2 )
    end
end
if Awp == true then
    if defawp:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 0 )
    elseif desawp:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 1 )
    elseif shfawp:GetValue() then
        gui.SetValue("rbot.antiaim.condition.onshot", 2 )
    end
end
if flcheck:GetValue() then
if offflonshift:GetValue() then
    if gui.GetValue("rbot.antiaim.condition.onshot") == 2 then
    gui.SetValue("misc.fakelag.enable", true)
    end
else
if gui.GetValue("rbot.antiaim.condition.onshot") == 2 then
        gui.SetValue("misc.fakelag.enable", false)
else 
    gui.SetValue("misc.fakelag.enable", true)
        end
end
end
end
end
callbacks.Register("FireGameEvent", "checkweapon", checkweapon)