local warning = gui.Checkbox( gui.Reference( "Visuals", "Overlay", "Enemy" ), "vis.taserwarning", "Taserwarning", 1 )
local function drawEspHook(builder)
if warning:GetValue() then
        local lp = entities.GetLocalPlayer();
        local pe = builder:GetEntity();
        if pe:IsPlayer() and pe:IsAlive() and pe:GetTeamNumber() ~= lp:GetTeamNumber() and pe:GetWeaponID() == 31 then
                builder:Color(255, 0, 0)
                builder:AddTextTop("TASER")
            else
            return
        end
    end
end

callbacks.Register( 'DrawESP', "drawEspHook", drawEspHook )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

