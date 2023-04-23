-- RESET SCORE WHEN K/D IS NEGATIV

local function rs( Event ) 
    if ( Event:GetName() == 'player_death' ) then     
        local ME = client.GetLocalPlayerIndex();
        local INT_UID = Event:GetInt( 'userid' );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
        
        if (INDEX_Victim == ME) then
        local m_iKills = entities.GetPlayerResources():GetPropInt("m_iKills", client.GetLocalPlayerIndex())
        local m_iDeaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", client.GetLocalPlayerIndex())
        local kd = m_iKills / m_iDeaths;
            
			--chatmsg = string.format( "!rs" )	
			
			if (kd < 1) then
                client.Command(rs)
            end
        end        
    end 
end 

client.AllowListener( 'player_death' ); 
callbacks.Register( 'FireGameEvent', 'rs', rs )

----- End RESET SCORE WHEN K/D IS NEGATIV












--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

