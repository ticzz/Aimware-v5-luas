local ui_checkbox = gui.Checkbox(gui.Reference( "Misc", "Movement", "Other" ), "fakebackwards.enable", "Enable Fake Backwards", false );
local ui_keybox = gui.Keybox( gui.Reference( "Misc", "Movement", "Other" ), "fakebackwards.key", "Fake Backwards Key", 0 )
local ui_slider = gui.Slider(  gui.Reference( "Misc", "Movement", "Other" ), "fakebackwards.speed", "Fake Backwards Speed", 0, 0, 20 , 0.1 )
local ui_slider = gui.Slider(  gui.Reference( "Misc", "Movement", "Other" ), "fakebackwards.speed.return", "Fake Backwards Return Speed", 0, 0, 20 , 0.1 )
local ui_checkbox1 =  gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra" ), "fakebackwards.status", "Fake Backwards Indicator", false );
local font = draw.CreateFont( "Verdana", 25 );



function angle_mod( angle )
	return ( ( 360/65536 )*( bit.band( angle *( 65536 / 360 ), 65535 ) ) )
end
 
function normalize( angle )
	while ( angle > 180 ) do
		angle = angle - 360
	end
	while ( angle < -180 ) do
		angle = angle + 360
	end
	return angle
end
 
function approach_angle( target, value, speed )
	target = angle_mod( target )
	value = angle_mod( value )
	
	delta = target - value
	
	if ( speed < 0 ) then
		speed = -speed
	end
	
	if ( delta < -180 ) then
		delta = delta + 360
	elseif ( delta > 180 ) then
		delta = delta - 360
	end
	
	if ( delta > speed ) then
		value = value + speed
	elseif ( delta < -speed ) then
		value = value - speed
	else
		value = target
	end
	
	return value
end

local cur_yaw = nil
local last_angle = nil
local random_angle = nil
local doonce = true
local active



callbacks.Register( "Draw", function( )
	if input.IsButtonPressed(gui.GetValue( "misc.fakebackwards.key" ) ) then
		if not active then
			active = true
		else
			active = false
		end
	end
end )

callbacks.Register( "CreateMove", function( cmd )



    if ( gui.GetValue( "misc.fakebackwards.enable" ) == 0 ) then
        return
    end

	if ( gui.GetValue( "misc.fakebackwards.key" ) == 0) then 
		return
	end

 	if ( gui.GetValue( "lbot.antiaim.type") == "maximum" )  then
        return
	end
	
	if ( doonce ) then
		random_angle = math.random( 160, 180)
		doonce = false
	end

	if ( input.IsButtonReleased( ui_keybox:GetValue( ) ) ) then
		doonce = true
	end

    local LocalAngles = cmd:GetViewAngles( )
    	cur_yaw = LocalAngles.y

		if ( last_angle == nil ) then
            last_angle = LocalAngles.y
		end
		
		local toggle = active and 1 or 2

        if ( toggle == 1 ) then
			last_angle = approach_angle( LocalAngles.y + random_angle, last_angle, gui.GetValue( "misc.fakebackwards.speed" ) )
		elseif ( toggle == 2 ) then    
			last_angle = approach_angle(LocalAngles.y, last_angle,  gui.GetValue( "misc.fakebackwards.speed.return" ) )
	end
		cmd:SetViewAngles( EulerAngles( LocalAngles.x, last_angle, LocalAngles.z ) )
end )


callbacks.Register( "Draw", function( )
	draw.SetFont( font )
	local screen = { draw.GetScreenSize( ) }
	draw.Color( 255, 255, 255, 255 );
	if (gui.GetValue( "esp.other.fakebackwards.status" ) ) then
		draw.Line( screen[ 1 ] / 2, screen[ 2 ] / 3, screen[ 1 ] / 2 + math.sin( math.rad( cur_yaw - last_angle + 180 ) ) * 15, screen[ 2 ] / 3+math.cos( math.rad( cur_yaw - last_angle + 180 ) )* 15 )
	end
end )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

