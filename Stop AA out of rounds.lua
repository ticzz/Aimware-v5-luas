StopAA = gui.Checkbox(gui.Reference("Ragebot", "Anti-Aim", "Anti-Aim"),"stopaa","Stop Freeze-AA",0);
StopAA:SetDescription("Stop AntiAim out of rounds.");

local function FireGameEvent ( Event )
    local player = entities.GetLocalPlayer()
	if StopAA:GetValue() == false or nil then return end;
    if ( Event:GetName() == 'round_prestart' ) then
        gui.SetValue( "rbot.antiaim.enable", 0 )
    elseif ( Event:GetName() == 'round_freeze_end' or Event:GetName() == 'game_newmap' ) then
        gui.SetValue( "rbot.antiaim.enable", 1 )
    end
end

client.AllowListener( 'round_prestart' );
client.AllowListener( 'round_freeze_end' );
client.AllowListener( 'game_newmap' );
callbacks.Register( 'FireGameEvent', 'FireGameEvent', FireGameEvent )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

