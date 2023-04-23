local ui_keybox = gui.Keybox(gui.Reference( "MISC","Movement", "Jump"),"msc_movement_edge", "Auto Edge-Bug", 0 )
ui_keybox:SetDescription( "No fall damage by hitting exact edge of object clipbrush." )
local font = draw.CreateFont( "Verdana", 25 );
local ui_checkbox = gui.Checkbox( gui.Reference("Visuals","Other", "Extra"),"msc_edgebug_status", "Auto Edge-Bug Status", 0 )
local ui_colourpicker = gui.ColorPicker( ui_checkbox, "edgebugcolour", "edge_bug_colour", 255, 255, 255, 255 )

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

local function DRAW_STATUS( )

    local x, y = draw.GetScreenSize( )
    r, g, b, a = ui_colourpicker:GetValue( )
    local centerX = x / 2
    local edgebug =  gui.GetValue( "misc.msc_movement_edge" )

    if edgebug ~= 0 and  input.IsButtonDown( ui_keybox:GetValue( ) ) and gui.GetValue( "esp.other.msc_edgebug_status" ) then
        
        draw.Color( r, g, b, a )
        draw.SetFont( font )    
        draw.Text( centerX , y - 170, "eb" );
        
    end
end

callbacks.Register( "CreateMove", EDGEBUG_CREATEMOVE )
callbacks.Register( "Draw", "EDGEBUG", DRAW_STATUS)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

