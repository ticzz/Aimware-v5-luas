local Enable = gui.Checkbox(gui.Reference("Visuals","Local","Camera"),"animthirdperson", "Animate Thirdperson Toggle" , false);
Enable:SetDescription("Unbind Enable Third Person checkbox and bind this")
local Distance = gui.GetValue("esp.local.thirdpersondist")
local value = 0;

local function Thirdperson()
if value > Distance then value = Distance
elseif value < 0 then gui.SetValue("esp.local.thirdperson",false); value = 0 end
if Enable:GetValue() and value < Distance then gui.SetValue("esp.local.thirdperson",true); value = value + 8 end
if not Enable:GetValue() then value = value - 8 end
gui.SetValue("esp.local.thirdpersondist", value)
end

local function ReturnThirdperson() 
gui.SetValue("esp.local.thirdpersondist",Distance)
end

callbacks.Register("Draw",Thirdperson)
callbacks.Register("Unload",ReturnThirdperson)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")