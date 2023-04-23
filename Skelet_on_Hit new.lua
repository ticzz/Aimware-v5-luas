-- strange lua but someone ask me about it)
local lua_ref = gui.Reference("Visuals", "World","Extra")

local lua_enable = gui.Checkbox(lua_ref,"enable", "Enable Skeleton on Hit", true)
local lua_skeleton_time =  gui.Slider(lua_ref, "hitlog_time", "Hitmarker Time of Visibility", 120, 10, 800, 10)
local lua_skeleton_anim_time =  gui.Slider(lua_ref, "hitlog_anim_time", "Animation Time", 120, 10, 200, 5)
local lua_skeleton_color = gui.ColorPicker(lua_ref, "skeleton_color", "Color", 188,97,255)

local particles = {}
local shot_info = {}

local function get_skeleton(GameEvent)
	if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then 
        return
    end
	if GameEvent then
		if GameEvent:GetName() == "player_hurt" then
            local user_id = GameEvent:GetInt("userid")
            local user = entities.GetByUserID(user_id)
            local attacker_id = GameEvent:GetInt("attacker")
            local attacker = entities.GetByUserID(attacker_id)
            local attacker_index = entities.GetByUserID(attacker_id):GetIndex()
            local localplayer_index = entities:GetLocalPlayer():GetIndex()
            if attacker_index == localplayer_index then
            	skeleton_shot_time = globals.TickCount() + lua_skeleton_time:GetValue()
            	skeleton_shot_time_anim = globals.TickCount() + lua_skeleton_time:GetValue() + lua_skeleton_anim_time:GetValue()
            	head_pos = user:GetHitboxPosition(1)
            	chest_pos = user:GetHitboxPosition(2)
            	stomach_pos = user:GetHitboxPosition(3)
            	left_arm_pos = user:GetHitboxPosition(4)
            	right_arm_pos = user:GetHitboxPosition(5)
            	left_leg_pos = user:GetHitboxPosition(6)
            	right_leg_pos = user:GetHitboxPosition(7)

            	shot_info = {}
                table.insert(shot_info, skeleton_shot_time)
                table.insert(shot_info, skeleton_shot_time_anim)

                table.insert(shot_info, head_pos.x)
                table.insert(shot_info, head_pos.y)
                table.insert(shot_info, head_pos.z)

                table.insert(shot_info, chest_pos.x)
                table.insert(shot_info, chest_pos.y)
                table.insert(shot_info, chest_pos.z)

                table.insert(shot_info, stomach_pos.x)
                table.insert(shot_info, stomach_pos.y)
                table.insert(shot_info, stomach_pos.z)

                table.insert(shot_info, left_arm_pos.x)
                table.insert(shot_info, left_arm_pos.y)
                table.insert(shot_info, left_arm_pos.z)

                table.insert(shot_info, right_arm_pos.x)
                table.insert(shot_info, right_arm_pos.y)
                table.insert(shot_info, right_arm_pos.z)

                table.insert(particles, shot_info)
            end
        end
    end
end
client.AllowListener("player_hurt");
callbacks.Register("FireGameEvent", get_skeleton);
callbacks.Register("Draw", get_skeleton);

local skeleton_timer = {}
local skeleton_timer_anim = {}

local function skeleton_draw()
	if not lua_enable:GetValue() then
		lua_skeleton_color:SetInvisible(true)
		lua_skeleton_time:SetInvisible(true)
		lua_skeleton_anim_time:SetInvisible(true)
	else
		lua_skeleton_color:SetInvisible(false)
		lua_skeleton_time:SetInvisible(false)
		lua_skeleton_anim_time:SetInvisible(false)
	end
    if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then
	    particles = {}
	    alpha = 0
	end
	local color_r, color_g, color_b, color_a = lua_skeleton_color:GetValue()
	if lua_enable:GetValue() then
		for i = 1, #particles, 1 do 
			if particles[i][1] ~= nil and particles[i][2] ~= nil then
				skeleton_timer[i] = particles[i][1] - globals.TickCount()
				skeleton_timer_anim[i] = particles[i][2] - globals.TickCount()

				head_pos_x, head_pos_y = client.WorldToScreen(Vector3(particles[i][3]-1, particles[i][4], particles[i][5]+5))

				chest_pos_x, chest_pos_y = client.WorldToScreen(Vector3(particles[i][6], particles[i][7], particles[i][8]+28))
				chest_pos_x_2, chest_pos_y_2 = client.WorldToScreen(Vector3(particles[i][6], particles[i][7], particles[i][8]+20))

				stomach_pos_x, stomach_pos_y = client.WorldToScreen(Vector3(particles[i][9], particles[i][10], particles[i][11]-3))

		 		left_arm_pos_x_2, left_arm_pos_y_2 = client.WorldToScreen(Vector3(particles[i][12] + 10, particles[i][13]-2, particles[i][14]+9))

		 		right_arm_pos_x_2, right_arm_pos_y_2 = client.WorldToScreen(Vector3(particles[i][15] - 10, particles[i][16]-2, particles[i][17]+4))

		 		left_arm_pos_x_1, left_arm_pos_y_1 = client.WorldToScreen(Vector3(particles[i][12] + 10, particles[i][13]-6, particles[i][14]+1))

		 		right_arm_pos_x_1, right_arm_pos_y_1 = client.WorldToScreen(Vector3(particles[i][15] - 10, particles[i][16]-6, particles[i][17]-4))

		 		left_arm_pos_x, left_arm_pos_y = client.WorldToScreen(Vector3(particles[i][12] + 2, particles[i][13]-15, particles[i][14]+1))

		 		right_arm_pos_x, right_arm_pos_y = client.WorldToScreen(Vector3(particles[i][15] - 2, particles[i][16]-15, particles[i][17]-4))

		 		left_leg_pos_x_1, left_leg_pos_y_1 = client.WorldToScreen(Vector3(particles[i][12] + 9, particles[i][13], particles[i][14]-25))

				right_leg_pos_x_1, right_leg_pos_y_1 = client.WorldToScreen(Vector3(particles[i][15] - 11, particles[i][16], particles[i][17]-30))

				left_leg_pos_x_2, left_leg_pos_y_2 = client.WorldToScreen(Vector3(particles[i][12] + 8, particles[i][13], particles[i][14]-20))

				right_leg_pos_x_2, right_leg_pos_y_2 = client.WorldToScreen(Vector3(particles[i][15] - 5, particles[i][16], particles[i][17]-20))

				left_leg_pos_x, left_leg_pos_y = client.WorldToScreen(Vector3(particles[i][12] + 14, particles[i][13], particles[i][14]-50))

				right_leg_pos_x, right_leg_pos_y = client.WorldToScreen(Vector3(particles[i][15] - 11, particles[i][16], particles[i][17]-50))

				if skeleton_timer[i] > 0 then
					alpha = 255 
				elseif skeleton_timer[i] <= 0 and skeleton_timer_anim[i] > 0 then 
					alpha = skeleton_timer_anim[i]
				elseif skeleton_timer_anim[i] <= 0 then
					alpha = 0
				end
				if skeleton_timer_anim[i] > 0 then
					if 	head_pos_x ~=nil and chest_pos_x ~= nil and chest_pos_x_2 ~= nil and stomach_pos_x ~= nil and head_pos_y ~= nil and chest_pos_y ~= nil and chest_pos_y_2 ~= nil and stomach_pos_y ~= nil and left_arm_pos_x ~= nil 
						and left_arm_pos_y~= nil and right_leg_pos_x~= nil and right_arm_pos_y ~= nil and left_leg_pos_x ~= nil and left_leg_pos_y ~= nil and right_leg_pos_x ~= nil and right_leg_pos_y ~= nil and left_arm_pos_x_1  ~= nil 
						and left_arm_pos_y_1 ~= nil and right_leg_pos_x_1 ~= nil and right_arm_pos_y_1 ~= nil and left_leg_pos_x_1 ~= nil and left_leg_pos_y_1 ~= nil and right_leg_pos_x_1 ~= nil and right_leg_pos_y_1 ~= nil and
						left_arm_pos_y_2~= nil and right_leg_pos_x_2~= nil and right_arm_pos_y_2 ~= nil and left_leg_pos_x_2 ~= nil and left_leg_pos_y_2 ~= nil and right_leg_pos_x_2 ~= nil and right_leg_pos_y_2 ~= nil and left_arm_pos_x_2 ~= nil   then
						--idk why, but another hitbox draw will draw something else

						draw.Color(color_r, color_g, color_b, alpha)

						draw.Line(stomach_pos_x, stomach_pos_y, chest_pos_x, chest_pos_y)

						draw.Line(chest_pos_x_2, chest_pos_y_2, left_arm_pos_x_2, left_arm_pos_y_2)

						draw.Line(chest_pos_x_2, chest_pos_y_2, right_arm_pos_x_2, right_arm_pos_y_2)

						draw.Line(left_arm_pos_x_2, left_arm_pos_y_2, left_arm_pos_x_1, left_arm_pos_y_1)

						draw.Line(right_arm_pos_x_2, right_arm_pos_y_2, right_arm_pos_x_1, right_arm_pos_y_1)

						draw.Line(right_arm_pos_x_2, right_arm_pos_y_2, right_arm_pos_x_1, right_arm_pos_y_1)

						draw.Line(right_arm_pos_x_1, right_arm_pos_y_1, right_arm_pos_x, right_arm_pos_y)

						draw.Line(left_arm_pos_x_1, left_arm_pos_y_1, left_arm_pos_x, left_arm_pos_y)

						draw.Line(stomach_pos_x, stomach_pos_y, left_leg_pos_x_2, left_leg_pos_y_2)

						draw.Line(stomach_pos_x, stomach_pos_y, right_leg_pos_x_2, right_leg_pos_y_2)

						draw.Line(right_leg_pos_x_2, right_leg_pos_y_2, right_leg_pos_x_1, right_leg_pos_y_1)

						draw.Line(right_leg_pos_x_1, right_leg_pos_y_1, right_leg_pos_x, right_leg_pos_y)

						draw.Line(stomach_pos_x, stomach_pos_y, left_leg_pos_x_2, left_leg_pos_y_2)

						draw.Line(left_leg_pos_x_2, left_leg_pos_y_2, left_leg_pos_x_1, left_leg_pos_y_1)

						draw.Line(left_leg_pos_x_1, left_leg_pos_y_1, left_leg_pos_x, left_leg_pos_y)
					end
				end
			end
		end
	end
end
callbacks.Register("Draw", skeleton_draw)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")