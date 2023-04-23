
--Here you can change code
--Function name
local function_list = {"Send '1' in Chat","Anti-Aim Yaw -90","Third Person OFF","Anti-Aim Yaw +90",  "ASUS Walls ON","Third Person ON","ASUS Walls OFF","None","None","None"}

--Function bind
local last_spam  = globals.TickCount()

function bind_function() 

	if input.IsButtonDown(96) then -- NUM 0
	   if globals.TickCount() - last_spam > 32 then
       client.ChatSay("1")
       last_spam = globals.TickCount()
	end
	end
	
	if input.IsButtonDown(97) then -- NUM 1
	gui.SetValue( "rbot.antiaim.base", -90.0, "Desync")
	gui.SetValue( "rbot.antiaim.left.rotation", 58.0 )
	end
	
	if input.IsButtonDown(98) then -- NUM 2
	gui.SetValue( "vis_thirdperson_dist", 0 )
	end
	
	if input.IsButtonDown(99) then -- NUM 3
	gui.SetValue( "rbot.antiaim.base", 90.0, "Desync")
	gui.SetValue( "rbot.antiaim.left.rotation", -58.0 )
	end
	
	if input.IsButtonDown(100) then -- NUM 4
	gui.SetValue( "vis_asus", 0.85 )
	gui.SetValue( "vis_asustype", 1 )
	end
	
	if input.IsButtonDown(101) then -- NUM 5
	gui.SetValue( "vis_thirdperson_dist", 200 )
	end
	
	if input.IsButtonDown(102) then -- NUM 6
	gui.SetValue( "vis_asus", 1 )
	gui.SetValue( "vis_asustype", 1 )
	end
	
	if input.IsButtonDown(103) then -- NUM 7
	-- then do this
	end
	
	if input.IsButtonDown(104) then -- NUM 8
	-- then do this
	end
	
	if input.IsButtonDown(105) then -- NUM 9
	-- then do this
	end
end

--////////////////////////////////////////////////////////////////////////

local show_menu = true;
local show_menu_click = false;

local pos_x = 200;
local pos_y = 200;

local top_w = 250;
local top_h = 40;

local body_w = 250;
local body_h = 188;

local panel_1_w = 230;
local panel_1_h = 180;

local bottom_w = 250;
local bottom_h = 20;

function color_id(id,alpha)
	if(id == 1)then
	draw.Color( 255, 33, 33, alpha ); -- RED
	end
	
	if(id == 2)then
	draw.Color( 252, 252, 252, alpha ); -- WHITE
	end
	
	if(id == 3)then
	draw.Color( 0, 0, 0, alpha ); -- BLACK
	end
	
	if(id == 4)then
	draw.Color( 217, 217, 217, alpha ); -- GREEY
	end
	
	if(id == 5)then
	draw.Color( 59, 185, 70, alpha ); -- GREEN
	end
end

function set_pos_meny() 
m_x, m_y = input.GetMousePos();
	if ( m_x >= pos_x) and ( m_x <= pos_x+top_w) and ( m_y >= pos_y-35) and ( m_y <= pos_y+top_h+35) and (input.IsButtonDown(1)) then
	pos_x = m_x-125
	pos_y = m_y-10
	end
end

function bind() 
bind_list() 
bind_function() 
end

function bind_list() 
pos_f_y = pos_y+top_h+20;


	for i = 0, 9 do 
		if input.IsButtonDown(96+i) then
		color_id(5,100)
		draw.FilledRect( pos_x+15, pos_f_y-2, pos_x+235, pos_f_y+14 )
		end
	color_id(3,255)	
	draw.Text( pos_x+20, pos_f_y, "NUM "..i )
	draw.Text( pos_x+60, pos_f_y, function_list[i+1] )
	pos_f_y = pos_f_y + 15 
	end
		
end

function show_hide_menu() 
	if input.IsButtonDown(36) then
		if show_menu_click == false then 
			if show_menu == false then
			show_menu = true
			else 
			show_menu = false
			end
			show_menu_click = true
		end	
	else	
		show_menu_click = false
	end
end

function bind_menu() 
show_hide_menu() 
	if show_menu == true then
	set_pos_meny()

	color_id(1,150)
	current_w = pos_x + top_w
	current_h = pos_y+top_h
	draw.FilledRect( pos_x, pos_y, current_w, current_h )

	color_id(2,230)
	current_h = current_h + body_h
	draw.FilledRect( pos_x, pos_y+top_h, current_w, current_h )

	color_id(4,255)
	panel_h = current_h - 10
	draw.RoundedRectFill( pos_x+10, pos_y+top_h+10, current_w-10, panel_h )
	color_id(3,100)
	draw.RoundedRect( pos_x+10, pos_y+top_h+10, current_w-10, panel_h )

	color_id(3,150)
	current_h = current_h + bottom_h
	draw.FilledRect( pos_x, pos_y+top_h+body_h, current_w, current_h )

	color_id(2,255)
	draw.TextShadow( pos_x+10, pos_y+14, "BIND MENU   Show/Hide - HOME" )
	draw.TextShadow( pos_x+3, pos_y+body_h+top_h+3, "fixed by ticzz" )

	bind() 
	end
end

callbacks.Register( "Draw", "bind_menu", bind_menu );







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

