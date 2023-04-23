--[[--------------------------------------Credits---------------------------------------------------
                      Reverse Slide Walk made in Ukraine by GLadiator           
------------------------------------------Credits-----------------------------------------------]]--

local gui_SetValue 
=
      gui.SetValue
;

local RSW = gui.Checkbox( gui.Reference( 'Misc', 'Movement', 'Other' ), 'misc.slidewalk.reverse', 'Reverse Slide Walk', false );

callbacks.Register( 'PreMove', 'PreMoveRSW', function( UserCmd )
    if RSW:GetValue( ) then
        gui_SetValue( 'misc.slidewalk', not UserCmd.sendpacket );
    end
end );
