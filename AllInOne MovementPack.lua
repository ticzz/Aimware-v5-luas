
--NULLING IN AIR--
--by aiyu - https://aimware.net/forum/thread-113688.html--
local last_a, last_d = 0
local font = draw.CreateFont( "Verdana", 25 );
local ui_checkbox = gui.Checkbox( gui.Reference( "MISC","Movement", "Strafe" ),"kz.null.strafe", "Null Strafe", 1 )
local ui_checkbox1 = gui.Checkbox( gui.Reference( "Visuals","Other", "Extra" ),"kz.null.strafe.indicator", "Null Strafe Indicator", 1 )
ui_checkbox:SetDescription( "Prevents you from pressing two strafe keys together in air." )
local ui_colourpicker = gui.ColorPicker( ui_checkbox1, "nullbindcolour", "null_bind_colour",  252, 61, 3, 180 )

local function get_local_player( )

    local player = entities.GetLocalPlayer( )
   
    if player == nil then return end
   
    if ( not player:IsAlive( ) ) then
       
        player = player:GetPropEntity( "m_hObserverTarget" )
       
    end
   
    return player
   
end

callbacks.Register( "CreateMove", function( cmd )

    local ui_null_strafe = gui.GetValue( "misc.strafe.kz.null.strafe" )
    if ( ui_null_strafe == 0 ) then
        return
    end

    local flags = get_local_player():GetPropInt( "m_fFlags" )
   
    if flags == nil then
        return
     end
   
    local onground = bit.band(flags, 1) ~= 0

    if ( onground ) then
        return
    end


    if ( input.IsButtonDown( 65 ) and input.IsButtonDown( 68)  ) then
        if( last_a ~= nil and last_d ~= nil ) then
            if( last_d < last_a ) then
                cmd.sidemove = 450
            elseif( last_d > last_a ) then
                cmd.sidemove = -450
            end
        end
    return
    end

    if ( input.IsButtonDown( 65 ) ) then
        last_a = globals.CurTime( )
    end

    if ( input.IsButtonDown( 68 ) ) then
        last_d = globals.CurTime( )
    end
end)

callbacks.Register( "Draw", function( )
    local ui_null_strafe_indicator = gui.GetValue( "esp.other.kz.null.strafe.indicator" )
    if ( ui_null_strafe_indicator == 0 ) then
        return
    end
    local lp = entities.GetLocalPlayer( );

    if (lp == nil) then
        return
    end


    local flags = get_local_player():GetPropInt( "m_fFlags" )
   


    if flags == nil then
        return
     end
   
    local onground = bit.band(flags, 1) ~= 0

    if ( onground ) then
        return
    end

    draw.SetFont( font )

    r, g, b, a = ui_colourpicker:GetValue( )
    local x, y = draw.GetScreenSize( )
    local centerX = x / 2
   if ( gui.GetValue("esp.other.kz.null.strafe.indicator") and not onground and input.IsButtonDown( 65 ) and input.IsButtonDown( 68 ) ) then

    draw.Color( r, g, b, a )
    draw.Text( centerX , y - 200, "nulling" )

end
end)
--END - NULLING LUA--

--LongJump on EDGE--
--by uvxxvu - https://aimware.net/forum/thread-128304.html--
local main_font = draw.CreateFont("Verdana", 26);
local combo = gui.Combobox(gui.Reference( "MISC","Movement", "Jump"), 'msc_edgejump_vars','Long Jump Type','Normal', 'LJ Bind -forward', 'LJ Bind -back', 'LJ Bind -moveleft', 'LJ Bind -moveright')
local ljbind = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "lj_bind", "LJ Bind Edge Jump", true);
ljbind:SetDescription("Allows you to jump further with one unit extra height.")
local ui_checkbox = gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra"), "lj_bind_status", "LJ Bind Status", false);

local edgejump = gui.GetValue("misc.edgejump");
callbacks.Register("CreateMove", function(cmd)
    
    if (ljbind:GetValue() ~= true) then
        return
    end
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
    
    local onground = bit.band(flags, 1) ~= 0

    
    if (not onground and input.IsButtonDown(edgejump)) then
        cmd:SetButtons( 86 )
        if (combo:GetValue() == 0) then
            return;
        end
            if (combo:GetValue() == 1) then
                client.Command("-forward", true)
                end
                
            if (combo:GetValue() == 2) then
                client.Command("-back", true)
                end
            if (combo:GetValue() == 3) then
                client.Command("-moveright", true)
                end
            if (combo:GetValue() == 4) then
                client.Command("-moveleft", true)
                end
        return
    end

end)

callbacks.Register("Draw", function()

    local x, y = draw.GetScreenSize()
    local centerX = x / 2

    local lp = entities.GetLocalPlayer(); -- Get our local entity and check if its `nil`, If it's nil lets abort from here
        local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end

    local onground = bit.band(flags, 1) ~= 0
 	if ui_checkbox:GetValue() then
   draw.SetFont(main_font)
        if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
            draw.Color(255, 255, 255, 255)
            draw.Text( centerX , y - 150, "lj")
        end
    if (onground) then return end
    if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
    draw.Color(30, 255, 109)
    draw.Text( centerX , y - 150, "lj")
    end
end
end)
--END - LONGJUMP--

--Fake Scroll on JumpBug--
--by uvxxvu - https://aimware.net/forum/thread-128377.html--
local ui_checkbox = gui.Checkbox( gui.Reference("MISC","Movement", "Jump"),"misc.autojumpbug.scroll", "Fake Scroll On Jump-bug Miss", 1 )
ui_checkbox:SetDescription( "Fakes scroll input if Auto Jump-Bug fails." )

local function get_local_player( )

    local player = entities.GetLocalPlayer( )
   
    if player == nil then return end
   
    if ( not player:IsAlive( ) ) then
       
        player = player:GetPropEntity( "m_hObserverTarget" )
       
    end
   
    return player
   
end

local function JUMPBUG_SCROLL( UserCmd )

    local flags = get_local_player():GetPropInt( "m_fFlags" )
   
    if flags == nil then return end

    local onground = bit.band( flags, 1 ) ~= 0
   
    if onground and input.IsButtonDown( gui.GetValue("misc.autojumpbug" ) )then

        UserCmd:SetButtons( 4 )
        return   

    end
end


callbacks.Register( "CreateMove", JUMPBUG_SCROLL )
--END - JumpBug lua--

--Fake Sideways--
--by uvxxvu - https://aimware.net/forum/thread-129165.html--
--added left and right sides - by w1ldac3--
local ref_sideways = gui.Reference("Misc", "Movement", "Other")
local ui_checkbox = gui.Checkbox(ref_sideways, "fakesideways.enable", "Enable Fake Sideways", false );
local ui_keybox = gui.Keybox(ref_sideways, "fakesideways.key", "Fake Sideways Key", 0 )
local ui_groupbox = gui.Combobox(ref_sideways, "fakesideways.type", "Sides", "Backwards", "Left", "Right")
local ui_slider = gui.Slider(ref_sideways, "fakesideways.speed", "Fake Sideways Speed", 0, 0, 20 , 0.1 )
local ui_slider = gui.Slider(ref_sideways, "fakesideways.speed.return", "Fake Sideways Return Speed", 0, 0, 20 , 0.1 )
local ui_checkbox1 =  gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra" ), "fakesideways.status", "Fake Sideways Indicator", false );
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
	if input.IsButtonPressed(gui.GetValue( "misc.fakesideways.key" ) ) then
		if not active then
			active = true
		else
			active = false
		end
	end
end )

callbacks.Register( "CreateMove", function( cmd )



    if ( gui.GetValue( "misc.fakesideways.enable" ) == 0 ) then
        return
    end

	if ( gui.GetValue( "misc.fakesideways.key" ) == 0) then 
		return
	end

 	if ( gui.GetValue( "lbot.antiaim.type") == "maximum" )  then
        return
	end
	if gui.GetValue("misc.fakesideways.type") == 0 then
	if ( doonce ) then
		random_angle = math.random( 160, 180)
        doonce = false
	end
    elseif gui.GetValue("misc.fakesideways.type") == 1 then
        if ( doonce ) then
            random_angle = math.random( 70, 90)
            doonce = false
        end
    elseif gui.GetValue("misc.fakesideways.type") == 2 then
        if ( doonce ) then
            random_angle = math.random( 0-70, 0-90)
            doonce = false
        end
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
			last_angle = approach_angle( LocalAngles.y + random_angle, last_angle, gui.GetValue( "misc.fakesideways.speed" ) )
		elseif ( toggle == 2 ) then    
			last_angle = approach_angle(LocalAngles.y, last_angle,  gui.GetValue( "misc.fakesideways.speed.return" ) )
	end
		cmd:SetViewAngles( EulerAngles( LocalAngles.x, last_angle, LocalAngles.z ) )
end )


callbacks.Register( "Draw", function( )
	draw.SetFont( font )
	local screen = { draw.GetScreenSize( ) }
	draw.Color( 255, 255, 255, 255 );
    if (gui.GetValue( "esp.other.fakesideways.status" ) ) then
        if input.IsButtonDown(gui.GetValue( "misc.fakesideways.key" ) ) then
		draw.Line( screen[ 1 ] / 2, screen[ 2 ] / 3, screen[ 1 ] / 2 + math.sin( math.rad( cur_yaw - last_angle) ) * 15, screen[ 2 ] / 3+math.cos( math.rad( cur_yaw - last_angle) )* 15 )
        end
    end
end )
--End - Fake Sideways--

--EdgeBug Assist--
--by uvxxvu - https://aimware.net/forum/thread-128250.html--
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
callbacks.Register( "Draw", "EDGEBUG", DRAW_STATUS);
--End - EdgeBug--

--HL Speed Indicator--
--by arpac - https://aimware.net/forum/thread-93805.html--
local ref_speed = gui.Reference("Visuals", "Other", "Extra")
local speed_check = gui.Checkbox(ref_speed, "hl2.speed.indicator", "HL2 Speed Indicator (FPS Consumable)", false) 
local curspeed_color = gui.ColorPicker(speed_check, "hl2.speed.ind.color", 255,255,255,255)
local speed = 0
local last_onground_speed = 0
local last_flags = 0;

local fade_time = 0;
local old_onground_speed = 0;

    function testflag(set, flag)
      return set % (2*flag) >= flag
    end
    
function paint_traverse()
if speed_check:GetValue() then
   local x, y = draw.GetScreenSize()
   local centerX = x / 2
     if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
    end;

    local font = draw.CreateFont( "Verdana", 30 );
  
   draw.SetFont( font );



   if entities.GetLocalPlayer() ~= nil then

       local Entity = entities.GetLocalPlayer();
       local Alive = Entity:IsAlive();
       local velocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
       local velocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
      
       local flags = Entity:GetPropInt( "m_fFlags" );
      
      
       local velocity = math.sqrt( velocityX^2 + velocityY^2 );
       local FinalVelocity = math.min( 9999, velocity ) + 0.2;
       if ( Alive == true ) then
         speed= math.floor(FinalVelocity) ;
        
        
       if(testflag(flags, 1) and not testflag(last_flags, 1)) then
       old_onground_speed = last_onground_speed;
       last_onground_speed = speed
       fade_time = 1;
       end
       last_flags = flags;
        
       else
         speed=0;
         last_onground_speed = 0;
       end
   end
    rw,rh =draw.GetTextSize(speed)
    
    if(fade_time > globals.FrameTime()) then
        fade_time = fade_time - globals.FrameTime();
    end
    
    local speed_delta = last_onground_speed - old_onground_speed;
    
    draw.Color(curspeed_color:GetValue());
    draw.Text(centerX -(rw/2), y - 170, speed);
    
    local r = 255;
    local g = 255;
    local b = 255;
    
    if(speed_delta > 0 and fade_time > 0.5) then
        r = 30
        g = 220
        b = 30
    end
    
    if(speed_delta < 0 and fade_time > 0.5) then
        r = 220
        g = 30
        b = 30
    end
    
    
    
    rw2,rh2 =draw.GetTextSize(last_onground_speed)
    draw.Color( r, g, b, 220 );
    draw.Text(centerX -(rw2/2), y - 200, last_onground_speed)

end
end

callbacks.Register("Draw", "paint_traverse", paint_traverse)
--End - HL Speed Indicator--
--End - LUA--