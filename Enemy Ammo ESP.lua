callbacks.Register("DrawESP", function(esp)

    local e = esp:GetEntity();
    if (e:IsPlayer() ~= true or entities.GetLocalPlayer():GetTeamNumber() == e:GetTeamNumber()) or not e:IsAlive() then return end
    esp:Color(62, 214, 209, 255)
    ActiveWeapon = e:GetPropEntity("m_hActiveWeapon")
    esp:AddTextBottom(ActiveWeapon:GetProp("m_iClip1") .. "/" .. ActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount") )

end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

