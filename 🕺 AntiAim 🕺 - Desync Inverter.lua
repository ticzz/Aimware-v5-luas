local MULTIBOX = gui.Multibox(gui.Reference("Ragebot","SestainScript", "Anti-Aim & Other"), "AutoInvert Modes");
local INVERTORSTANDING = gui.Checkbox(MULTIBOX,"invertor.stand", "Standing" , false);
local INVERTORWALK = gui.Checkbox(MULTIBOX,"invertor.walk", "Walk" , false);
local INVERTORSLOWWALK = gui.Checkbox(MULTIBOX,"invertor.slowwalk", "Slowwalk" , false);
local INVERTORAIR = gui.Checkbox(MULTIBOX,"invertor.air", "In Air" , false);
local INVERTORWHENDAMAGEME = gui.Checkbox(MULTIBOX,"invertor.localhurt", "Local Get Damaged" , false);
local INVERTORWHENHIT = gui.Checkbox(MULTIBOX,"invertor.whenhit", "When Hit my Shot" , false);
local INVERTORATANYSHOT = gui.Checkbox(MULTIBOX,"invertor.atanyshot", "At Any Shot" , false);

local lby = gui.GetValue('rbot.antiaim.base.lby')
local function invert()

if gui.GetValue("rbot.antiaim.base.rotation") == 58 then
  gui.SetValue("rbot.antiaim.base.rotation", -58)
  elseif gui.GetValue("rbot.antiaim.base.rotation") == -58 then
  gui.SetValue("rbot.antiaim.base.rotation", 58)
end 
if gui.GetValue("rbot.antiaim.base.lby") < 0 then
  lby == lby + 179 
  elseif gui.GetValue("rbot.antiaim.base.lby") > 0 then
  lby == lby - 179
end

--	while Yaw > 0 do
--        Yaw = Yaw - 180
--	while Yaw < 0 do
--		Yaw = Yaw + 180
--	end
end 

callbacks.Register("CreateMove", function()
local hLocalPlayer = entities.GetLocalPlayer();
  if not hLocalPlayer then return end
    if invert_key:GetValue() ~= 0 then
        if input.IsButtonDown(invert_key) then
          invert()  
        end
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")