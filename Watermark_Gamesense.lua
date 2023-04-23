local abs_frame_time = globals.AbsoluteFrameTime;     local frame_rate = 0.0; local get_abs_fps = function()  frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * abs_frame_time(); return math.floor((1.0 / frame_rate) + 0.5);  end
frequency = 0.1 -- range: [0, oo) | lower is slower
intensity = 180 -- range: [0, 255] | lower is darker
saturation = 1 -- range: [0.00, 1.00] | lower is less saturated

function hsvToR(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return r * intensity
end

function hsvToG(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return g * intensity
end

function hsvToB(h, s, v)
 local r, g, b

 local i = math.floor(h * 6);
 local f = h * 6 - i;
 local p = v * (1 - s);
 local q = v * (1 - f * s);
 local t = v * (1 - (1 - f) * s);

 i = i % 6

 if i == 0 then r, g, b = v, t, p
 elseif i == 1 then r, g, b = q, v, p
 elseif i == 2 then r, g, b = p, v, t
 elseif i == 3 then r, g, b = p, q, v
 elseif i == 4 then r, g, b = t, p, v
 elseif i == 5 then r, g, b = v, p, q
 end

 return b * intensity
end

-- credits to @Brotgeschmack#5901
function drawGradient(x,y,w,h,dir,colors)
    local size,clength = 0, 0;
    local red, green, blue,alpha = 0,0,0,0;
    local mr, mg, mb, ma= 0,0,0,0;
    
    for i = 1, #colors, 1 do
        size = size + 1;
    end
    
    if(dir == "up" or dir == "down") then
        clength = h / (size-1);
    else
        clength = w / (size-1);
    end
    
    for i,color in ipairs(colors) do
        local x1,y1 = x, y;
        local x2,y2 = x1+w, y1+h;
        if(colors[i+1] ~= nil) then
            red = color[1];
            mr = (color[1] - colors[i+1][1]) / clength;

            green = color[2];
            mg = (color[2] - colors[i+1][2]) / clength;
            
            blue = color[3];
            mb = (color[3] - colors[i+1][3]) / clength;

            alpha = color[4];
            ma = (color[4] - colors[i+1][4]) / clength;
            
            for j=0, clength, 1 do
                red = red - mr;
                green = green - mg;
                blue = blue - mb;
                alpha = alpha - ma;
                draw.Color(red,green,blue,alpha);
                if(dir == "right") then
                    draw.FilledRect(x1+j,y1,j+x1+1,y2+1);
                elseif(dir == "left") then
                    draw.FilledRect(x2-j,y1,x2-j+1,y2+1);    
                elseif(dir == "up") then
                    draw.FilledRect(x2+1,y2-j+1,x1,y2-j);                    
                else
                    draw.FilledRect(x1,y1+j,x2+1,y1+j+1);                                
                end
            end
            
            if(dir == "right") then
                x = x + clength;    
            elseif(dir == "left") then
                x = x - clength;    
            elseif(dir == "up") then
            else
                y = y + clength;
            end
        end
    end
end

local MSC_PART_2_REF = gui.Reference( "MISC" );

local TAB = gui.Tab(MSC_PART_2_REF, "wmark_tab", "Watermark");

local enablewm = gui.Checkbox( TAB, "lua_wm_enable", "Enable", 0 );
local aw_text = gui.Checkbox( TAB, "lua_wm_awtext", "Aimware text", 0);
local wmpos = gui.Combobox( TAB, "lua_wm_pos", "Position (WIP)", "Top left");
local show_fps = gui.Checkbox( TAB, "lua_wm_showfps", "Show fps", 0);
local show_ping = gui.Checkbox( TAB, "lua_wm_showping", "Show ping", 0);
local draw_line = gui.Checkbox( TAB, "lua_wm_drawline", "Draw line", 0);


function use_Crayon()
if entities.GetLocalPlayer() == nil then
      return
end
local wmpos1 = wmpos:GetValue();
local text = aw_text:GetValue();
local fps = show_fps:GetValue();
local ping = show_ping:GetValue();
local ff = draw.CreateFont('Tahoma', 60)
local classicf = draw.CreateFont('Tahoma', 12)
local name = client.GetPlayerNameByIndex(client.GetLocalPlayerIndex())
local x, y = draw.GetScreenSize()
   local R = hsvToR((globals.RealTime() * frequency) % 1, saturation, 1)
    local G = hsvToG((globals.RealTime() * frequency) % 1, saturation, 1)
    local B = hsvToB((globals.RealTime() * frequency) % 1, saturation, 1)

	if enablewm:GetValue() then
	   if (wmpos1 == 0) then
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 20, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 15, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 16, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 21, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 19, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(8, 11, 15, 12)
		   end
		if aw_text:GetValue() then
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 90, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 85, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 86, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 91, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 89, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(9, 11, 85, 12)
		   end
		end
		
	    if show_fps:GetValue() then
		   if aw_text:GetValue() then
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 130, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 125, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 126, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 131, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 129, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(9, 11, 125, 12)
		   end
		   else 
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 60, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 55, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 56, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 61, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 59, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(9, 11, 55, 12)
		   end
		   end
		end
		
		if show_ping:GetValue() then
		   if show_fps:GetValue() then
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 110, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 95, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 106, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 111, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 109, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(9, 11, 105, 12)
		   end
		   else
		   draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 60, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 55, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 56, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 61, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 59, 29)
		   if draw_line:GetValue() then
		   draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
		   draw.FilledRect(9, 11, 55, 12)
		   end
		   end
		end
		
		if show_ping:GetValue() then
		   if aw_text:GetValue() then
           draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 130, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 125, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 126, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 131, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 129, 29)
           if draw_line:GetValue() then
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.FilledRect(9, 11, 125, 12)
           end
		   end
        end
		
		if show_ping:GetValue() then
		   if aw_text:GetValue() then
		     if show_fps:GetValue() then
           draw.Color(35, 35, 35, 255)
           draw.FilledRect(3, 5, 180, 30)
           draw.Color(15, 15, 15, 180)
           draw.FilledRect(8, 10, 175, 25)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(8, 10, 176, 26)
           draw.Color(0, 0, 0, 255)
           draw.OutlinedRect(2, 4, 181, 31)
           draw.Color(70, 70, 70, 180)
           draw.OutlinedRect(3, 5, 179, 29)
           if draw_line:GetValue() then
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.FilledRect(9, 11, 175, 12)
           end
		   end
		   end
        end
		
		-- fps
		   if show_fps:GetValue() then  
                if aw_text:GetValue() then			  
           draw.SetFont(classicf)
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(82, 12, "fps: ".. get_abs_fps())
		   draw.Color(235, 235, 235, 255)
           draw.Text(74, 12, "|") 
		   else
		   draw.SetFont(classicf)
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(13, 12, "fps: ".. get_abs_fps())
		   draw.Color(235, 235, 235, 255)
		   end
		    end
		--ping
	       if show_ping:GetValue() then
			   if aw_text:GetValue() then
			     if not show_fps:GetValue() then
		   draw.SetFont(classicf)
           local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(80, 12, "Ping: ".. m_iPing)
           draw.Color(235, 235, 235, 255)
           draw.Text(73, 12, "|")  	   	
		      end
		  if show_fps:GetValue() then 
		    if aw_text:GetValue() then
		   draw.SetFont(classicf)
           local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(130, 12, "Ping: ".. m_iPing)
           draw.Color(235, 235, 235, 255)
           draw.Text(123, 12, "|")  
		   end
		   end
          end
		end
		if show_ping:GetValue() then
		  if not show_fps:GetValue() then
		    if not aw_text:GetValue() then
					   draw.SetFont(classicf)
           local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(15, 12, "Ping: ".. m_iPing)
		  end
		end
	  end
	  	if show_ping:GetValue() then 
		    if not aw_text:GetValue() then
			 if show_fps:GetValue() then
		   draw.SetFont(classicf)
           local m_iPing = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
           draw.Color(math.floor(R), math.floor(G), math.floor(B), 255)
           draw.Text(60, 12, "Ping: ".. m_iPing)
           draw.Color(235, 235, 235, 255)
           draw.Text(53, 12, "|")  
		   end
		   end
		   end
	end
        -- text		   
	       if aw_text:GetValue() then
           draw.SetFont(classicf)
           draw.Color(214, 214, 214, 230)
           draw.Text(15, 12, "aim")
           draw.Color(159, 202, 43, 230)
           draw.Text(31, 12, "ware") 
           draw.Color(214, 214, 214, 230)
           draw.Text(53, 12, ".net")		   
	       end
    end

end
callbacks.Register('Draw', 'use_Crayon', use_Crayon)