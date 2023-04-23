local lp = entities.GetLocalPlayer()

function is_scoped(player)
return player:GetPropBool("m_bIsScoped")
end

local viewmodel = function() 
if lp:IsAlive() == false then

client.SetConVar("r_drawvgui", 1, true)
client.SetConVar("fov_cs_debug", 0, true)
end
if is_scoped(lp) then
if gui.GetValue("esp.local.thirdperson") == false then
client.SetConVar("fov_cs_debug", 90, true)
end 
else
client.SetConVar("r_drawvgui", 1, true)
client.SetConVar("fov_cs_debug", 0, true)
end
end

callbacks.Register("CreateMove", viewmodel)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")