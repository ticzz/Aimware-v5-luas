--[[--------------------------------------Credits---------------------------------------------------

                             Anti-Lagonpeek made by GLadiator                                       
                                     Found by Soufiw

------------------------------------------Credits-----------------------------------------------]]--

local CanEnable = false
local Enabled = false

callbacks.Register( 'Draw', 'AntiLagOnPeek', function( )
    if not entities.GetLocalPlayer( ) or Enabled == true then
        return
    end

    if not entities.GetLocalPlayer( ):IsAlive( ) then
        CanEnable = true
    else
        CanEnable = false
    end

    if CanEnable then
        client.Command( 'jointeam 1', true )
        client.SetConVar( 'cl_lagcompensation', 0, true )
        
        Enabled = true
    end
end )

callbacks.Register( 'Unload', function( )
    client.Command( 'jointeam 1', true )
    client.SetConVar( 'cl_lagcompensation', 1, true )
end )





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")