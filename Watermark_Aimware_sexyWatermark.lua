local function watermark()
 
    drawline();
    drawrect();
    drawtext();
end
 
local frame_rate = 0.0
    local get_abs_fps = function()
        frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
        return math.floor((1.0 / frame_rate) + 0.5)
end
 
function drawrect()
 
    local sw, sh = draw.GetScreenSize();
    --aw
 
    draw.Color(44, 42, 99, 200); --thicc outline color
    draw.FilledRect(sw/1.186, sh/90, sw/1.139, sh/18.946); --outline rect
    draw.Color(34, 29, 70, 220); --inside rect color
    draw.FilledRect(sw/1.181, sh/63.529, sw/1.144, sh/20.769); --inside rect
    draw.Color(18, 12, 38, 255); --inside rect outline color
    draw.OutlinedRect(sw/1.182, sh/67.5, sw/1.143, sh/20.377); --inside rect outline
    draw.OutlinedRect(sw/1.186, sh/98.181, sw/1.139, sh/18.620); --outside rect outline
 
    --info
 
    draw.Color(44, 42, 99, 200); --thicc outline color
    draw.FilledRect(sw/1.138, sh/90, sw/1.053, sh/18.946); --outline rect
    draw.Color(34, 29, 70, 220); --inside rect color
    draw.FilledRect(sw/1.134, sh/63.529, sw/1.0565, sh/20.769); --inside rect
    draw.Color(18, 12, 38, 255); --inside rect outline color
    draw.OutlinedRect(sw/1.134, sh/67.5, sw/1.0565, sh/20.377); --inside rect outline
    draw.OutlinedRect(sw/1.138, sh/98.181, sw/1.053, sh/18.620); --outside rect outline
 
    --time
 
    draw.Color(44, 42, 99, 200); --thicc outline color
    draw.FilledRect(sw/1.052, sh/90, sw/1.0045, sh/18.946); --outline rect
    draw.Color(34, 29, 70, 220); --inside rect color
    draw.FilledRect(sw/1.048, sh/63.529, sw/1.008, sh/20.769); --inside rect
    draw.Color(18, 12, 38, 255); --inside rect outline color
    draw.OutlinedRect(sw/1.0485, sh/67.5, sw/1.0075, sh/20.377); --inside rect outline
    draw.OutlinedRect(sw/1.052, sh/98.181, sw/1.0047, sh/18.620); --outside rect outline
 
end
 
function drawtext()
 
    local sw, sh = draw.GetScreenSize();
    local f = draw.CreateFont("Arial", 20, 1200);
    local i = draw.CreateFont("Arial", 14, 500);
    local val = draw.CreateFont("Arial", 14, 600);
    local t = draw.CreateFont("Arial", 17, 600);
    local rw,rh;
   -- local date = os.date("*t")
 
    local speed = 0;
    local latency= 0;
     if entities.FindByClass( "CBasePlayer" )[1] ~= nil then
        latency=entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() )
     end
 
    --name
 
    draw.SetFont(f);
    draw.Color(255, 255, 255, 255);
    draw.TextShadow(sw/1.177, sh/54, "A");
    draw.Color(201, 47, 96, 255);
    draw.TextShadow(sw/1.163, sh/54, "W");
 
    --info
 
    --fps
    draw.SetFont(i);
    draw.Color(255, 255, 255, 255);
    draw.Text(sw/1.128, sh/29.189, "FPS");
    draw.SetFont(val);
    if (get_abs_fps() < 30) then
        draw.Color(255, 0, 0);
    else
        draw.Color(126, 183, 50);
    end
    rw,rh = draw.GetTextSize(get_abs_fps());
    draw.TextShadow(sw/1.121 - (rw/2), sh/49.09, get_abs_fps());
 
    --ping
    draw.SetFont(i);
    draw.Color(255, 255, 255, 255);
    draw.Text(sw/1.104, sh/29.189, "PING");
    draw.SetFont(val);
    draw.Color(126, 183, 50);
    rw,rh = draw.GetTextSize(latency);
    draw.TextShadow(sw/1.096 - (rw/2), sh/49.09, latency);
 
    --speed
    draw.SetFont(i);
    draw.Color(255, 255, 255, 255);
    draw.Text(sw/1.082, sh/29.189, "SPEED");
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
    draw.Color(126, 183, 50);
    draw.TextShadow(sw/1.070 - (rw/2), sh/49.09, speed);
 
    --time
	local realtime = 0
	local curtime = 0
	format_time = function()
	if not realtime then
    return "xx:xx:xx"
	end
	local T = (globals.RealTime() - curtime + realtime) % 86400
	local hours = math.floor(T / 3600)
	local minutes = math.floor(T % 3600 / 60)
	local seconds = T % 60
	return ("%02d:%02d:%02d"):format(hours, minutes, seconds)
	end
	local grab_time

	grab_time = function()
	curtime = globals.RealTime()
		return http.Get("http://worldtimeapi.org/api/ip", function(content)
    local js = json.parse(content)
    local time = js["unixtime"]
		if js["dst"] then
			time = time + js["dst_offset"]
		else
			time = time + js["raw_offset"]
		end
    realtime = time % 86400
		end)
	end
	grab_time()
    draw.SetFont(i);
    draw.Color(255, 255, 255, 255);
    draw.Text(sw/1.036, sh/29.189, "TIME");
    draw.SetFont(t);
    draw.Color(0, 170, 255, 255);
    draw.TextShadow(sw/1.046, sh/49.09, string.format("%02d:%02d:%02d"):format(hours, minutes, seconds));
 
end
 
function drawline()
 
    local screenSize = draw.GetScreenSize();
    local r = math.floor(math.sin(globals.RealTime() * 1) * 127 + 128);
    local g = math.floor(math.sin(globals.RealTime() * 1 + 2) * 127 + 128);
    local b = math.floor(math.sin(globals.RealTime() * 1 + 4) * 127 + 128);
 
    draw.Color(r, g, b, 255);
    draw.FilledRect(0, 0, screenSize, 5);
end
 
callbacks.Register('Draw', watermark );
--client.AllowListener( "player_disconnect" );
--client.AllowListener( "begin_new_match" )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

