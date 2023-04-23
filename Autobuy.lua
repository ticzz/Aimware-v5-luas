local GUIR = gui.Reference("MISC")
local GUI = gui.Tab(GUIR, "autobuy.tab", "Autobuy")
local GroupBox = gui.Groupbox(GUI, "Autobuy")
--[[
local ActiveCheckBox = gui.Checkbox(GroupBox, "ActiveCheckBox", "Activate", false)
local PrimaryWeapons = gui.Combobox( GroupBox, 'PrimaryWeapons', "Primary Weapons", "Off", "AK | M4", "Scout", "AWP", "Auto")
local SecondaryWeapons = gui.Combobox( GroupBox, 'SecondaryWeapons', "Secondary Weapons", "Off", "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle")
--]]
local AutoBuy = gui.Checkbox(GroupBox, "autobuy", "Auto Buy", true)
local AutoBuyP = gui.Combobox(GroupBox, "autobuyp", "Auto Buy Primary", "Auto Sniper", "AWP", "Scout")
local AutoBuyS = gui.Combobox(GroupBox, "autobuys", "Auto Buy Secondary", "Dualies", "Heavy")
--local Nades = gui.Checkbox( GroupBox, "Nades", "Grenades", true);
--local Zeus = gui.Checkbox( GroupBox, "Zeus", "Zeus", true);
--local Armor = gui.Checkbox( GroupBox, "Armor", "Armor", true);
--local Defuser = gui.Checkbox( GroupBox, "Defuser", "Defuser", true);

local function MISC_AUTOBUY(event)
    if(entities.GetLocalPlayer() == nil) then return end
 
   if(event:GetName() == "round_prestart" and AutoBuy:GetValue()) then
        client.Command("buy ".. pirmaryAutoBuy[AutoBuyP:GetValue()])
        client.Command("buy ".. secondaryAutoBuy[AutoBuyS:GetValue()])
        client.Command("buy vesthelm; buy vest; buy smokegrenade; buy hegrenade; buy incgrenade; buy flashbang")
    end
end

client.AllowListener('round_prestart');
callbacks.Register("FireGameEvent", "MISC_AUTOBUY", MISC_AUTOBUY);









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

