-- ClientInfo
local kills = {}
local deaths = {}
local kdratio = #kills/#deaths
local frametimes = {}
local fps_prev = 0;
local skeet_font = draw.CreateFont("KaushanScript", 14, 9999);
local GetPropInt = nil
local PING = 0;
local local_player = client.GetLocalPlayerIndex()
local lp = local_player



-- Draw PINGIndicator

local function DrawPingColor()

	if ( PING <= 20 ) then
		draw.Color(0, 255, 0, 255); -- Green
	elseif ( PING <= 30 ) then
		draw.Color( 50, 255, 0, 255 );
	elseif ( PING <= 40 ) then
		draw.Color( 100, 255, 0, 255 );
	elseif ( PING <= 50 ) then
		draw.Color( 150, 255, 0, 255 );
	elseif ( PING <= 60 ) then
		draw.Color( 200, 255, 0, 255 );
	elseif ( PING <= 70 ) then
		draw.Color( 255, 255, 0, 255 ); -- Orange
	elseif ( PING <= 80 ) then
		draw.Color( 255, 200, 0, 255 ); 
	elseif ( PING <= 90 ) then
		draw.Color( 255, 150, 0, 255 );
	elseif ( PING <= 100 ) then
		draw.Color( 255, 100, 0, 255 );
	elseif ( PING <= 150 ) then
		draw.Color( 255, 50, 0, 255 );
	else
		draw.Color( 255, 0, 0, 255 ); -- Red
	end
	
end

callbacks.Register( "Draw", "DrawPingColor", DrawPingColor );

local function accumulate_fps()
   local ft = globals.AbsoluteFrameTime()
   if ft > 0 then
       table.insert(frametimes, 1, ft)
   end

   local count = #frametimes
   if count == 0 then
       return 0
   end

   local i, accum = 0, 0
   while accum < 0.5 do
       i = i + 1
       accum = accum + frametimes[i]
       if i >= count then
           break
       end
   end
   accum = accum / i
   while i < count do
       i = i + 1
       table.remove(frametimes)
   end
   
   local fps = 1 / accum
   local rt = globals.RealTime()
   if math.abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
       fps_prev = fps
       last_update_time = rt
   else
       fps = fps_prev
   end
   
   return math.floor(fps + 0.5)
end


local function events(event)
      		
		if (event:GetName( ) == "begin_new_match") or (event:GetName( ) == "round_announce_match_start" ) then
        kills = {}
        deaths = {}
    end
  
		if event:GetName() == "player_death" then
			local local_player = client.GetLocalPlayerIndex()
			local attacker = client.GetPlayerIndexByUserID(event:GetInt("attacker"))
			local victim = client.GetPlayerIndexByUserID(event:GetInt("userid"))

         
		if attacker == local_player then
            kills[#kills + 1] = {};
    end
        if victim == local_player then
			deaths[#deaths + 1] = {};
	end
        

	end

end

callbacks.Register( "FireGameEvent", "events", events );

local function DrawPING()
 draw.SetFont(skeet_font);

	local w, h = draw.GetScreenSize();
	
	if entities.GetPlayerResources() ~= nil then
	
		PING = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() );
		DrawPingColor();
		draw.Text(45, 360, PING);
		draw.TextShadow(45, 360, PING);
		
		draw.Color( 200, 30, 200, 255 );
		draw.Text( 15, 360, "Ping: ");
		draw.TextShadow( 15, 360, "Ping: ");

	else

		draw.Color( 200, 200, 20, 255 );
		draw.Text( 15, 360, "Offline" );
		draw.TextShadow( 15, 360, "Offline" );

	end

end

callbacks.Register( "Draw", "DrawPING", DrawPING );


local function getColor(number, max)
    local r, g, b
    i = math.abs(number, max, 9)

    if i <= 1 then r, g, b = 255, 0, 0
        elseif i == 2 then r, g, b = 237, 27, 3
        elseif i == 3 then r, g, b = 235, 63, 6
        elseif i == 4 then r, g, b = 229, 104, 8
        elseif i == 5 then r, g, b = 228, 126, 10
        elseif i == 6 then r, g, b = 220, 169, 16
        elseif i == 7 then r, g, b = 213, 201, 19
        elseif i == 8 then r, g, b = 176, 205, 10
        elseif i == 9 then r, g, b = 124, 195, 13
    end

    return r, g, b
end

local function drawing_stuff()

if lp == nil then
return 
end

	if entities.GetLocalPlayer() then

local w,h = draw.GetScreenSize();
draw.SetFont(skeet_font)

-- fps Zeile


local r, g, b = getColor(accumulate_fps(), 100)
   
	
	 
	if accumulate_fps() > 59 then
        r, g, b = 0, 255, 0
    else
        r, g, b = 255, 0, 0
	end
	
	draw.Color(r, g, b, 255)
    rw,rh = draw.GetTextSize(accumulate_fps())
    draw.Text(45, 380, accumulate_fps())
    draw.TextShadow(45, 380, accumulate_fps())

	draw.Color(255, 255, 255, 255);
	draw.Text(15, 380, "FPS:" );
   draw.TextShadow(15, 380, "FPS:" );
 


--kills und death anzeige

	draw.SetFont(skeet_font);
	draw.Color(255,255,255,255)
	draw.Text(15, 300, "kills: ")     
	draw.TextShadow(15, 300, "kills: ")   
  	draw.Text(15, 315, "deaths: ")      
	draw.TextShadow(15, 315, "deaths:") 	
	draw.Text(15, 330, "kd/r: ")   
	draw.TextShadow(15, 330, "kd/r: ")
	
		draw.SetFont(skeet_font);

	if #kills/#deaths > 1 then
	  draw.Color(0,255,0,255)
	  else
	  draw.Color(255,0,0,255)
	  end
	
	if #kills == 0 and #deaths == 0 then
	         draw.Color(255,255,255,255)
	end
	
	if #deaths > 0 then 
		kdratio = string.format("%.2f", math.floor(#kills/#deaths))
	  else
		kdratio = string.format("%.2f", #kills/1)
		end 
		draw.SetFont(skeet_font);

	draw.Text(88, 300,  #kills)     
	draw.TextShadow(88, 300,  #kills) 
	draw.Text(88, 315,  #deaths)      
	draw.TextShadow(88, 315,  #deaths) 		
	draw.Text(88, 330,  kdratio)   
	draw.TextShadow(88, 330,  kdratio)	
	
	

-- legitbot line

	if (gui.GetValue("lbot.master") == true ) and (gui.GetValue("lbot.aim.enable") == true) then
		onoroff = "On"
		draw.Color(0,175,205, 255)
		draw.Text(15, 400, "LegitAimbot: ")     
		draw.TextShadow(15, 400, "LegitAimbot: ") 
		draw.Color(0, 200, 0, 255)
		draw.Text(88, 400, onoroff)     
		draw.TextShadow(88, 400, onoroff)
		else
		onoroff = "Off"
		draw.Color(0,175,205, 255)
		draw.Text(15, 400, "LegitAimbot: ")    		--w/w +15, h/2 +450
		draw.TextShadow(15, 400, "LegitAimbot: ")  	--w/w +15, h/2 +450
		draw.Color(200, 0, 0, 255)
		draw.Text(88, 400, onoroff)     
		draw.TextShadow(88, 400, onoroff) 
	end 


-- legitAA line	
	if (gui.GetValue("lbot.master") == true) and (gui.GetValue("lbot.antiaim.type") == 2) then		
		onoroff = "-->"
		draw.Color(0,175,205, 255)
		draw.Text(15, 415, "Legit AA: ")     
		draw.TextShadow(15, 415, "Legit AA: ") 
		draw.Color(0, 200, 0, 255)
		draw.Text(88, 415, onoroff)     
		draw.TextShadow(88, 415, onoroff)
		elseif (gui.GetValue("lbot.master") == true) and (gui.GetValue("lbot.antiaim.type") == 3) then		
		onoroff = "<--"
		draw.Color(0,175,205, 255)
		draw.Text(15, 415, "Legit AA: ")    		--w/w +15, h/2 +450
		draw.TextShadow(15, 415, "Legit AA: ")  	--w/w +15, h/2 +450
		draw.Color(0, 200, 0, 255)
		draw.Text(88, 415, onoroff)     
		draw.TextShadow(88, 415, onoroff) 
		else 
		onoroff = "Off"
		draw.Color(0,175,205, 255)
		draw.Text(15, 415, "Legit AA: ")    		--w/w +15, h/2 +450
		draw.TextShadow(15, 415, "Legit AA: ")  	--w/w +15, h/2 +450
		draw.Color(200, 0, 0, 255)
		draw.Text(88, 415, onoroff)     
		draw.TextShadow(88, 415, onoroff) 		
	end			
	

-- Triggerbot line 
	if (gui.GetValue("lbot.trg.enable") == true ) then
			onoroff = "On"
			draw.Color(0,175,205, 255)
			draw.Text(15, 430, "Triggerbot: ")     
			draw.TextShadow(15, 430, "Triggerbot: ") 
			draw.Color(0, 200, 0, 255)
			draw.Text(88, 430, onoroff)     
			draw.TextShadow(88, 430, onoroff)
			else
			onoroff = "Off"
			draw.Color(0,175,205, 255)
			draw.Text(15, 430, "Triggerbot: ")    		--w/w +15, h/2 +450
			draw.TextShadow(15, 430, "Triggerbot: ")  	--w/w +15, h/2 +450
			draw.Color(200, 0, 0, 255)
			draw.Text(88, 430, onoroff)     
			draw.TextShadow(88, 430, onoroff) 
		end 
		
		
	
-- rageaimbot line
	
	if (gui.GetValue("rbot.master") == true ) and (gui.GetValue("rbot.aim.enable") == true) then
		onoroff = "On"
		draw.Color(40, 100, 205, 255)
		draw.Text(15, 445, "RageAimbot: ")     
		draw.TextShadow(15, 445, "RageAimbot: ") 
		draw.Color(0, 255, 0, 255)
		draw.Text(88, 445, onoroff)     
		draw.TextShadow(88, 445, onoroff)
		else
		onoroff = "Off"
		draw.Color(40, 100, 205, 255)
		draw.Text(15, 445, "RageAimbot: ")    		--w/w +15, h/2 +450
		draw.TextShadow(15, 445, "RageAimbot: ")  	--w/w +15, h/2 +450
		draw.Color(255, 0, 0, 255)
		draw.Text(88, 445, onoroff)     
		draw.TextShadow(88, 445, onoroff) 
	end					
 
-- resolver line	

	if (gui.GetValue("rbot.master") == true) and (gui.GetValue("rbot.aim.enable") == true) and (gui.GetValue("rbot.accuracy.posadj.resolver") == true) then
			onoroff = "On"
			draw.Color(40, 100, 205, 255)
			draw.Text(15, 460, "Resolver: ")     
			draw.TextShadow(15, 460, "Resolver: ") 
			draw.Color(0, 255, 0, 255)
			draw.Text(88, 460, onoroff)     
			draw.TextShadow(88, 460, onoroff)
		else
			onoroff = "Off"
			draw.Color(40, 100, 205, 255)
			draw.Text(15, 460, "Resolver: ")     
			draw.TextShadow(15, 460, "Resolver: ")  
			draw.Color(255, 0, 0, 255)
			draw.Text(88, 460, onoroff)     
			draw.TextShadow(88, 460, onoroff)   
	end
end	
end


client.AllowListener( "player_death" );
client.AllowListener( "player_disconnect" );
client.AllowListener( "round_announce_match_start" );
client.AllowListener( "begin_new_match" );
client.AllowListener( "m_iPing" );
callbacks.Register( "Draw", "drawing_stuff", drawing_stuff );

-- End ClientInfo

