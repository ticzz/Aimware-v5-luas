local ref = gui.Reference("misc");
local autobuy_ref = gui.Groupbox(ref, "Autobuy by LookAtMeNow", 800, 100, 300);
local autobuy_check = gui.Checkbox(autobuy_ref, "auto_check", "Activate Autobuy", false);
local autobuy_primary = gui.Combobox(autobuy_ref, "autobuy_primary", "Pistol", "Off", "Deagle | Revolver", "Tec9 | CZ" , " Dual Elite ");
local autobuy_second = gui.Combobox(autobuy_ref, "autobuy_second", "SSG / Auto / AWP", "Off", "SSG08", "Autosniper" , "AWP");
local autobuy_vest = gui.Checkbox(autobuy_ref,"autobuy_vest", "Vest + Helmet", false);
local autobuy_nades = gui.Checkbox(autobuy_ref,"autobuy_nades", "Nades", false);
local autobuy_taser = gui.Checkbox(autobuy_ref,"autobuy_taser", "Zeus", false);
local autobuy_defuser = gui.Checkbox(autobuy_ref,"autobuy_defuser", "Defuse Kit", false);

local function autobuy(event)
    if event:GetName() == "round_prestart" and autobuy_check:GetValue() then
        local primary = autobuy_primary:GetValue()
        local second = autobuy_second:GetValue()
  
        if primary == 1 then
            client.Command("buy deagle", true)
        end
        if primary == 2 then
            client.Command("buy tec9", true)
      end
        if primary == 3 then
            client.Command("buy elite", true)
        end
        if second == 1 then
            client.Command("buy ssg08", true)
        end
        if second == 2 then
            client.Command("buy scar20", true)
        end
      if second == 3 then
            client.Command("buy awp", true)
        end
        if autobuy_vest:GetValue() then
            client.Command("buy vesthelm; buy vest", true)
      end
        if autobuy_taser:GetValue() then
            client.Command("buy taser", true)
     end
        if autobuy_defuser:GetValue() then
            client.Command("buy defuser", true)
        end
        if autobuy_nades:GetValue() then
            client.Command("buy incgrenade; buy molotov; buy hegrenade; buy smokegrenade", true)
        end
    end
end

client.AllowListener("round_prestart");

callbacks.Register("FireGameEvent", "autobuy", autobuy);


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")