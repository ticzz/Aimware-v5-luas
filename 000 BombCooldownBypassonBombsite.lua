local function BombCooldownBypass(cmd)
    local localPlayer = entities.GetLocalPlayer()
    local inBombZone = localPlayer:GetPropBool("m_bInBombZone")
    if(localPlayer:GetWeaponID()==49 and not inBombZone) then
            cmd.buttons = bit.band(bit.bnot(bit.lshift(1, 5)), cmd.buttons) --IN USE
            cmd.buttons = bit.band(bit.bnot(bit.lshift(1, 0)), cmd.buttons) --IN ATTACK
    end
end

callbacks.Register( "CreateMove", BombCooldownBypass )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")