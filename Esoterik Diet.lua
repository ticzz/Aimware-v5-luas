local function Draw()
    if entities.GetLocalPlayer() == nil then
        return
    end
    local player = entities.GetLocalPlayer()
    if player:IsAlive() then
        player:SetProp("m_flModelScale", 0.5, 12)
    end
end
callbacks.Register("Draw", "Draw", Draw)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

