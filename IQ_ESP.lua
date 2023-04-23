callbacks.Register("DrawESP", function(esp)

    local e = esp:GetEntity();
    if (e:IsPlayer() ~= true or entities.GetLocalPlayer() == nil) or not e:IsAlive() then return end
    esp:Color(255, 255, 0, 255)
    esp:AddTextRight("IQ: " .. math.floor(Vector3(e:GetPropFloat("localdata", "m_vecVelocity[0]"), e:GetPropFloat("localdata", "m_vecVelocity[1]"), e:GetPropFloat("localdata", "m_vecVelocity[2]")):Length2D()))

end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

