function wm()
 
    drawrect();
    drawtext();
 
end
 
local frame_rate = 0.0
    local get_abs_fps = function()
        frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
        return math.floor((1.0 / frame_rate) + 0.5)
end
 
local kills  = {}
local deaths = {}
 
local function KillDeathCount(event)
 
    local local_player = client.GetLocalPlayerIndex( );
    local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
    local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );
 
    if (event:GetName( ) == "player_disconnect") or (event:GetName( ) == "begin_new_match") then
        kills = {}
        deaths = {}
    end
 
    if event:GetName( ) == "player_death" then
        if INDEX_Attacker == local_player then
            kills[#kills + 1] = {};
        end
       
        if (INDEX_Victim == local_player) then
            deaths[#deaths + 1] = {};
        end
 
    end
end
 
function drawrect()
 
end
 
function drawtext()
 
    local i = draw.CreateFont("Arial", 14, 700);
    local val = draw.CreateFont("Arial", 15, 1700);
    local rw,rh;
 
    local speed = 0;
    local latency= 0;
     if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
        latency=entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() )
     end
 
    --info
 
    --fps
    draw.SetFont(i);
    draw.Color(255, 127, 0, 255);
    draw.Text(17, 945, "FPS");
    draw.TextShadow(17, 945, "FPS");
    draw.SetFont(val);
    draw.Color(255, 40, 40, 255);
    rw,rh = draw.GetTextSize(get_abs_fps());
    draw.Text(28 - (rw/2), 928, get_abs_fps());
    draw.TextShadow(28 - (rw/2), 928, get_abs_fps());
 
    --ping
    draw.SetFont(i);
    draw.Color(255, 127, 0, 255);
    draw.Text(53, 945, "PING");
    draw.TextShadow(53, 945, "PING");
    draw.SetFont(val);
    draw.Color(22, 255, 41, 255);
    rw,rh = draw.GetTextSize(latency);
    draw.Text(66 - (rw/2), 928, latency);
    draw.TextShadow(66 - (rw/2), 928, latency);
 
    --speed
    draw.SetFont(i);
    draw.Color(255, 127, 0, 255);
    draw.Text(89, 945, "SPEED");
    draw.TextShadow(89, 945, "SPEED");
    draw.SetFont(val);
    if entities.GetLocalPlayer() ~= nil then
 
        local Entity = entities.GetLocalPlayer();
        local Alive = Entity:IsAlive();
        local velocityX = Entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
        local velocityY = Entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
        local velocity = math.sqrt( velocityX^2 + velocityY^2 );
        local FinalVelocity = math.min( 9999, velocity ) + 0.2;
        if ( Alive == true ) then
          speed= math.floor(FinalVelocity) ;
        else
          speed=0;
        end
    end
    rw,rh = draw.GetTextSize(speed)
    draw.Color(222, 28, 241, 255);
    draw.Text(107 - (rw/2), 928, speed);
    draw.TextShadow(107 - (rw/2), 928, speed);
 
    --kd
    draw.SetFont(i);
    draw.Color(255, 127, 0, 255);
    draw.Text(145, 945, "KD");
    draw.TextShadow(145, 945, "KD");
    draw.SetFont(val);
	draw.Color(1,1,1, 255);
	draw.Text(150, 928, "/");
    draw.TextShadow(150, 928, "/");
	
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
	
    draw.Color(255, 255, 255, 255);
    rw,rh = draw.GetTextSize(#kills);
    draw.Text(140 - (rw/2) - 1, 928, #kills);
    draw.TextShadow(140 - (rw/2) - 1, 928, #kills);
    rw,rh = draw.GetTextSize(#deaths);
    draw.Text(158 + (rw/2) + 1, 928, #deaths);
    draw.TextShadow(158 + (rw/2) + 1, 928, #deaths);
 
 
end
 
callbacks.Register('Draw', 'wm', wm);
callbacks.Register( "FireGameEvent", "KillDeathCount", KillDeathCount);
client.AllowListener( "player_death" );
client.AllowListener( "player_disconnect" );
client.AllowListener( "begin_new_match" );