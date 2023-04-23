local ui_keybox = gui.Keybox(gui.Reference( "MISC","Movement", "Jump"),"msc_movement_edge", "edgebug", 0 )
local main_font = draw.CreateFont("Verdana", 26)

local function get_local_player( )
 local player = entities.GetLocalPlayer( )
 if player == nil then return end
 if ( not player:IsAlive( ) ) then
 player = player:GetPropEntity( "m_hObserverTarget" )
 end
 return player
end

local function EDGEBUG_CREATEMOVE( UserCmd )
 local flags = get_local_player():GetPropInt( "m_fFlags" )
 if flags == nil then return end
    local onground = bit.band(flags, 1) ~= 0
 if ui_keybox:GetValue() == 0 then return end
 if onground and input.IsButtonDown( ui_keybox:GetValue( ) ) then 
 UserCmd:SetButtons( 4 )
 return 
    end
end
callbacks.Register("CreateMove", EDGEBUG_CREATEMOVE)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

