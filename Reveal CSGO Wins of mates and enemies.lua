--thanks to @uncomm and @m0nsterJ for the help
local Screen_Weight, Screen_Height = draw.GetScreenSize()

local lua_ref = gui.Reference("Visuals", "World", "Extra")

local lua_enable_competitive_wins = gui.Checkbox(lua_ref, "enable_competitive_wins", "Enable Competitive Wins", true)

local lua_competitive_wins_position_x = gui.Slider(lua_ref, "competitive_wins_position_x", "Position X", 600, 0, Screen_Weight, 1)
local lua_competitive_wins_position_y = gui.Slider(lua_ref, "competitive_wins_position_y", "Position Y", 190, 0, Screen_Height, 1)

local lua_line_color = gui.ColorPicker(lua_enable_competitive_wins, "line_color", "", 100, 55, 165)

local should_draw = true
local should_stop_draw = false

local win_particles = {}
local particles = {}

local player_counter = 0 
local stop_counting = 0
local biggest_text = 0
local biggest_win_text = 0
local a = 255

local lua_button_refresh = gui.Button(lua_ref, "Refresh List", function()
	a = 255
	particles = {}
	player_counter = 0 
	stop_counting = 0 
	should_stop_draw = false
	should_draw = true
end)

function get_wins( ... )
	if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then 
        return
    end
    if lua_enable_competitive_wins:GetValue() then
		if stop_counting == 0 then
		    for k, v in pairs(entities.FindByClass"CCSPlayer") do
		        if v:IsPlayer() then
		        	player_counter = player_counter + 1
		            if #particles <= player_counter then
				      	local player_mm_wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", v:GetIndex())
		            	local player_name = v:GetName()
			            win_particles = { }
			            table.insert(win_particles, player_mm_wins)
			            table.insert(win_particles, player_name)

			            if win_particles[1] ~= nil and  win_particles[2] ~= nil then
			            	table.insert(particles, win_particles)
			            end
			        end
		        end
		        stop_counting = 1
		    end
		end
	end
end
callbacks.Register("Draw", get_wins)


function draw_time(event)
    if lua_enable_competitive_wins:GetValue() then
    	if event then
		    if event then
		        if event:GetName() == "round_start" then
		        	a = 255
		        	particles = {}
					player_counter = 0 
		        	stop_counting = 0 
		            should_stop_draw = false
		            should_draw = true

		        elseif event:GetName() == "exit_buyzone" then
		            if client.GetPlayerIndexByUserID(event:GetInt("userid")) == client.GetLocalPlayerIndex() then
		                should_draw = false
		                should_stop_draw = true

		            end
		        end
		    end
		end
	end
end
client.AllowListener("round_start");
client.AllowListener("exit_buyzone");
callbacks.Register("FireGameEvent", draw_time);
callbacks.Register("Draw", draw_time)

function draw_wins()
    if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then 
        return
    end

    if lua_enable_competitive_wins:GetValue() then
	    if should_stop_draw == true and should_draw == false then
	    	a = a - 0.5
	    else
	    	a = 255
	    end

	    if a <= 95 then
	    	a = 0
	    end

	    if should_draw == true or a > 0 then
	    	draw.Color(15, 15, 15, a - 30)
	    	draw.FilledRect(lua_competitive_wins_position_x:GetValue(), lua_competitive_wins_position_y:GetValue(), lua_competitive_wins_position_x:GetValue() + biggest_text + biggest_win_text + 20, lua_competitive_wins_position_y:GetValue() - 20)
	    	draw.Color(255, 255, 255, a)
	    	draw.Text(lua_competitive_wins_position_x:GetValue() + 5, lua_competitive_wins_position_y:GetValue() - 15, "Players (" .. player_counter .. ")")
	    	draw.Color(25, 25, 25, a - 95)
		    draw.FilledRect(lua_competitive_wins_position_x:GetValue(), lua_competitive_wins_position_y:GetValue(), lua_competitive_wins_position_x:GetValue() + biggest_text + biggest_win_text + 20, lua_competitive_wins_position_y:GetValue() + 5 + (#particles * 20))
		    draw.Color(lua_line_color:GetValue())
		    draw.FilledRect(lua_competitive_wins_position_x:GetValue(), lua_competitive_wins_position_y:GetValue(), lua_competitive_wins_position_x:GetValue() + biggest_text + biggest_win_text + 20, lua_competitive_wins_position_y:GetValue() + 2)


		    for i = 1, #particles, 1 do 
		    	local text_x, text_y = draw.GetTextSize(particles[i][2])
		    	local text_win_x, text_win_y = draw.GetTextSize(particles[i][1])

		    	if biggest_text < text_x then
		    		biggest_text = text_x
		    	end

		    	if biggest_win_text < text_win_x then
		    		biggest_win_text = text_win_x
		    	end

			    if lua_enable_competitive_wins:GetValue() then
			    	draw.Color(255, 255, 255, a)
			    	draw.Text(lua_competitive_wins_position_x:GetValue() + 5, lua_competitive_wins_position_y:GetValue() + (i * 20) - 13, particles[i][2])
			    	--draw.FilledRect(lua_competitive_wins_position_x:GetValue() + 10 + biggest_text, lua_competitive_wins_position_y:GetValue() + (i * 20) - 20, lua_competitive_wins_position_x:GetValue() + 11 + biggest_text, lua_competitive_wins_position_y:GetValue() + 5 + (#particles * 20))
			    	draw.Text(lua_competitive_wins_position_x:GetValue() + 15 + biggest_text, lua_competitive_wins_position_y:GetValue() + (i * 20) - 13, particles[i][1])
			    end
		    end
		end
	end
end
callbacks.Register("Draw", draw_wins)