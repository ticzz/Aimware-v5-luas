local ui, add_checkbox, get_int, set_int, int, entitylist, get_local_player = gui, Checkbox, GetValue, SetValue, value, entities, GetLocalPlayer

local ui.add_checkbox("Enable Pitch Zero On Land")
local pitchch = ui.get_int("rbot.antiaim.advanced.pitch")
local int = 0
function createmove_func(cmd)
    if ui.get_bool("Enable Pitch Zero On Land") == false then return end
    if entitylist.get_local_player() == nil then return end
flag = entitylist.get_local_player():GetPropInt("CBasePlayer","m_fFlags")
if flag == 256 or flag == 262 then
    int = 0
end
if flag == 257 or flag == 261 or flag == 263 then
    int = int + 4
end
if int > 45 and int < 250 then
    ui.set_int("rbot.antiaim.advanced.pitch", 0)
else
    ui.set_int("rbot.antiaim.advanced.pitch", pitchch)
end
end

local font = render.setup_font ("Sagta",12,500,true,true,false)

local function draw() -- Function 
local ping = globalvars.get_ping() -- Ping
local fps = globalvars.get_frametime() -- Fps
local systemtime = globalvars.get_time() -- Time
local x, y= engine.get_screen_width(),engine.get_screen_height() -- Screen
local text = "Future  |  Yehuo#1337  |  Last Update  -  19/12/21"  -- Text 
local textsize = draw.GetTextSize(font,text)
draw.FilledRect(x - textsize - 15,12, textsize + 10,16, color.new(0,0,0,120)) -- Color 1
draw.FilledRect(x - textsize - 15,12, textsize + 10,2, color.new(135,27,156)) -- Color 2
draw.TextShadow(font, x - textsize -10,14, color.new(255,255,255,255), text) -- Color 3 & Text


end

callbacks.Register("Draw", "on_paint", draw)


ui.add_checkbox("Enable Animation")
local font = render.setup_font("DisposableDroid BB", 12, 0, true, false, true) --change the shitty fonts 
local font1 = render.setup_font("Verdana", 12, 500, true, false, false)
local function getvector()

local sc = { x = engine.get_screen_width(), y = engine.get_screen_height() } 

local size = render.get_text_width(font)
local offset = 15  
local alpha = math.random (0,400)
local alpha_fade = math.floor(math.sin(globalvars.get_realtime() * 5) * 127 + 128)
local rechdt = globalvars.get_dt_recharging()

 
render.text(font, sc.x/2 - size/2, sc.y/2 + 20, color.new(255,255,255,255), "Future")
if ui.get_bool("Enable Animation") then
	render.text(font, sc.x/1.92 - size/2, sc.y/2 + 20, color.new(120, 120, 120, alpha_fade), "DEV")
	render.text(font, sc.x/2 - size/2, sc.y/2 + 20, color.new(255,255,255,255), "Future")
end



render.text(font, sc.x/2 - size/2, sc.y/2 + 30, color.new(141,137,180), "FAKE YAW:") 
if(ui.get_keybind_state(keybinds.flip_desync)) then
    	render.text(font, sc.x/1.895 - size/2, sc.y/2 + 30, color.new(255,255,255,255), "R")
 	offset = offset + 10
    	else
    	render.text(font, sc.x/1.895 - size/2, sc.y/2 + 30, color.new(255,255,255,255), "L")
    	offset = offset + 10
    	end

if(ui.get_keybind_state(keybinds.double_tap)) then   
    	render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(18,255,18), "DT")
        else
			render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(177,22,36,0), "DT")
			offset = offset + 10
		end
        
		if not(ui.get_keybind_state(keybinds.double_tap)) then
		render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(177,22,36,255), "DT")
    	offset = offset + 10
    	end
		if(ui.get_keybind_state(keybinds.automatic_peek)) then
			render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(177,22,36,0), "DT")
        end
		if(ui.get_keybind_state(keybinds.automatic_peek)) then
		render.text(font, sc.x/2 + 20 - size/2, sc.y/2 + 40, color.new(255,255,255,255), "PEEK")
		if rechdt then
			render.text(font, sc.x/2 + 20 - size/2, sc.y/2 + 40, color.new(177,22,36,255), "PEEK")
		end
	    end

       
		if(ui.get_keybind_state(keybinds.body_aim)) then
        render.text(font, sc.x/2 - size/2, sc.y/2 + 50, color.new(24,116,205), "BM")
		else
		render.text(font, sc.x/2 - size/2, sc.y/2 + 50, color.new(130,130,130), "BM")
    	offset = offset + 10
    	end

if(ui.get_keybind_state(keybinds.safe_points)) then    	
    	render.text(font, sc.x/2 + 20 - size/2, sc.y/2 + 50, color.new(24,116,205), "SP")
		else
		render.text(font, sc.x/2 + 20 - size/2, sc.y/2 + 50, color.new(130,130,130), "SP")
    	offset = offset + 10
    	end

if(ui.get_keybind_state(keybinds.fakeduck)) then
        render.text(font, sc.x/2 + 36 - size/2, sc.y/2 + 50, color.new(24,116,205), "FD")
		else
		render.text(font, sc.x/2 + 36 - size/2, sc.y/2 + 50, color.new(130,130,130), "FD")
    	offset = offset + 10
    	end

if(ui.get_keybind_state(keybinds.hide_shots)) then   

		render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(81,144,204), "HS")
        else
		render.text(font, sc.x/2- size/2, sc.y/2 + 40, color.new(177,22,36,0), "HS")
		offset = offset + 10
		end
		
	end


cheat.RegisterCallback("on_paint", getvector) 

cheat.RegisterCallback("on_paint", getvector) 




local function calc_angle(x_src, y_src, z_src, x_dst, y_dst, z_dst)
	local x_delta = x_src - x_dst
	local y_delta = y_src - y_dst
    local z_delta = z_src - z_dst
	local hyp = math.sqrt(x_delta^2 + y_delta^2)
	local x = math.atan2(z_delta, hyp) * 57.295779513082
	local y = math.atan2(y_delta , x_delta) * 90 / 3.14159265358979323846
 
    if y > 90 then
        y = y - 90
    end
    if y < -90 then
        y = y + 90
    end
    return y
end




local math_pi   = math.pi
local math_min  = math.min
local math_max  = math.max
local math_deg  = math.deg
local math_rad  = math.rad
local math_sqrt = math.sqrt
local math_sin  = math.sin
local math_cos  = math.cos
local math_atan = math.atan
local math_atan2 = math.atan2
local math_acos = math.acos
local math_fmod = math.fmod
local math_ceil = math.ceil
local math_pow = math.pow
local math_abs = math.abs
local math_floor = math.floor




abs_yaw_set = { }
latest_bullet_impact = { }
latest_shot_yaw = { }
old_simulation_time = { }
local function resolve_onshot_records( )
	local enemies = entity.get_players( true )
	if not enemies then
		return
	end
	
    for i = 1, #enemies do
		local player = enemies[ i ]
		local weapon = entity.get_player_weapon( player )
		if weapon then	
			local last_shot_time = entity.get_prop( weapon, "m_fLastShotTime" )
			if last_shot_time then
				local simulation_time = entity.get_prop( player, "m_flSimulationTime" )
				if old_simulation_time[ player ] then
					if last_shot_time > old_simulation_time[ player ] and last_shot_time <= simulation_time then				
						if latest_bullet_impact[ player ] and latest_shot_yaw[ player ] and latest_bullet_impact[ player ] ~= vec_3( 0, 0, 0 ) then
							local origin = vec_3( entity.get_prop( player, "m_vecOrigin" ) )
							local view_offset = vec_3( entity.get_prop( player, "m_vecViewOffset" ) )
							local eye_position = vec_3( origin.x + view_offset.x, origin.y + view_offset.y, origin.z + view_offset.z )
							local eye_angles = vec_3( entity.get_prop( player, "m_angEyeAngles" ) )
							local abs_yaw_positive = normalize_as_yaw( eye_angles.y + math.abs( get_max_feet_yaw( player ) ) ) -- eye_angles.y +
							local abs_yaw_negetive = normalize_as_yaw( eye_angles.y - math.abs( get_max_feet_yaw( player ) ) ) --  eye_angles.y -

end
                                 end
	                   end
 
			end
		end
	end
end









function angle_to(destination)
	-- Calculate the delta of vectors.
	local delta_vector = vector(destination.x - self.x, destination.y - self.y, destination.z - self.z)

	-- Calculate the yaw.
	local yaw = math.deg(math.atan2(delta_vector.y, delta_vector.x))

	-- Calculate the pitch.
	local hyp = math.sqrt(delta_vector.x * delta_vector.x + delta_vector.y * delta_vector.y)
	local pitch = math.deg(math.atan2(-delta_vector.z, hyp))

	return angle(pitch, yaw)
end



function trace_line_skip_class(destination, skip_classes, skip_distance)
	local should_skip = function(index, skip_entity)
		local class_name = entity.get_classname(index) or ""
		for i in 1, #skip_entity do
			if class_name == skip_entity[i] then
				return true
			end
		end

		return false
	end

	local angles = self:angle_to(destination)
	local direction = angles:to_forward_vector()

	local last_traced_position = self

	while true do  -- Start tracing.
		local fraction, hit_entity = last_traced_position:trace_line_to(destination)

		if fraction == 1 and hit_entity == -1 then  -- If we didn't hit anything.
			return 1, -1  -- return nothing.
		else  -- BOIS WE HIT SOMETHING.
			if should_skip(hit_entity, skip_classes) then  -- If entity should be skipped.
				-- Set last traced position according to fraction.
				last_traced_position = vector_internal_division(self, destination, fraction, 1 - fraction)

				-- Add a little gap per each trace to prevent inf loop caused by intersection.
				last_traced_position = last_traced_position + direction * skip_distance
			else  -- That's the one I want.
				return fraction, hit_entity, self:lerp(destination, fraction)
			end
		end
	end
end

function clone_offset(p, y, r)
	p = self.p + p or 0
	y = self.y + y or 0
	r = self.r + r or 0

	return angle(
		self.p + p,
		self.y + y,
		self.r + r
	)
end


function clone_set(p, y, r)
	p = p or self.p
	y = y or self.y
	r = r or self.r

	return angle(
		p,
		y,
		r
	)
end

function unpack()
	return self.p, self.y, self.r
end

--- Set the angle's euler angles to 0.
--- @return void
function nullify()
	self.p = 0
	self.y = 0
	self.r = 0
end

--- Returns a string representation of the angle.
function tostring(operand_a)
	return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Concatenates the angle in a string.
function concat(operand_a)
	return string.format("%s, %s, %s", operand_a.p, operand_a.y, operand_a.r)
end

--- Adds the angle to another angle.
function add(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a + operand_b.p,
			operand_a + operand_b.y,
			operand_a + operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p + operand_b,
			operand_a.y + operand_b,
			operand_a.r + operand_b
		)
	end

	return angle(
		operand_a.p + operand_b.p,
		operand_a.y + operand_b.y,
		operand_a.r + operand_b.r
	)
end

--- Multiplies the angle with another angle.
function mul(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a * operand_b.p,
			operand_a * operand_b.y,
			operand_a * operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p * operand_b,
			operand_a.y * operand_b,
			operand_a.r * operand_b
		)
	end

	return angle(
		operand_a.p * operand_b.p,
		operand_a.y * operand_b.y,
		operand_a.r * operand_b.r
	)
end

--- Divides the angle by the another angle.
function div(operand_a, operand_b)
	if (type(operand_a) == "number") then
		return angle(
			operand_a / operand_b.p,
			operand_a / operand_b.y,
			operand_a / operand_b.r
		)
	end

	if (type(operand_b) == "number") then
		return angle(
			operand_a.p / operand_b,
			operand_a.y / operand_b,
			operand_a.r / operand_b
		)
	end

	return angle(
		operand_a.p / operand_b.p,
		operand_a.y / operand_b.y,
		operand_a.r / operand_b.r
	)
end

function math.round(number, precision)
	local mult = 10 ^ (precision or 0)

	return math.floor(number * mult + 0.5) / mult
end

function resolver()

    local me = entity.get_local_player()

    if not me or not entity.is_alive(me) then
        return
    end

    local entities = get_entities(true, true)

    if #entities == 0 then
        self.animlayer_data = {}
        return
    end

    for i=1, #entities do
        local target = entities[i]
        local lpent = get_client_entity(ientitylist, target)
        local lpentnetworkable = get_client_networkable(ientitylist, target)

		local max_yaw = self:GetPlayerMaxFeetYaw(target)

        self.animstate_data[target] = {
            max_yaw = max_yaw
        }

        local act_table = {}

		for i=1, 12 do
            local layer = get_anim_layer(lpent, i)

            if layer.m_pOwner ~= nil then
                local act = get_sequence_activity(lpent, lpentnetworkable, layer.m_nSequence)

                --[[ if act ~= -1 then
                    --print(string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))
                end

                if act == 964 then
                    --print(string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))
                end

                --renderer.text(10, 200 + 15*i, 255, 255, 255, 255, nil, 0, string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle))

                if i == 12 then 
                    renderer.text(10, 200 + 15*13, 255, 255, 255, 255, nil, 0, string.format("max_desync: %s", self:GetPlayerMaxFeetYaw(target)))
                end

                --renderer.indicator(255, 255, 255, 255, string.format('act: %.5f weight: %.5f cycle: %.5f', act, layer.m_flWeight, layer.m_flCycle)) --]]

                act_table[act] = {
                    ["m_nSequence"] = layer.m_nSequence,
                    ["m_flPrevCycle"] = layer.m_flPrevCycle,
                    ["m_flWeight"] = layer.m_flWeight,
                    ["m_flCycle"] = layer.m_flCycle
                }

            end
        end

        self.animlayer_data[target] = act_table

        local lp_origin = vector(entity.get_origin(me))
        local entity_eye_yaw = vector_c.eye_position(target)--vector(self:GetAnimationState(target).m_flEyeYaw)
		local entity_angle = entity_eye_yaw:angle_to(lp_origin)--vector(self:GetAnimationState(target).m_flEyeYaw)
		local entity_set_prop = entity.set_prop
		local entity_get_prop = entity.get_prop
		local flags = entity.get_prop( entity.get_local_player( ), "m_fFlags" )

        local trace_data = {left = 0, right = 0}

        --:trace_line_impact(destination, skip_entindex)
        for i = entity_angle.y - 90, entity_angle.y + 90, 25 do
            if i ~= entity_angle.y then
                local rad = math.rad(i)
                
                local point_start = vector(entity_eye_yaw.x + 50 * math.cos(rad), entity_eye_yaw.y + 50 * math.sin(rad), entity_eye_yaw.z)
                local point_end = vector(entity_eye_yaw.x + 256 * math.cos(rad), entity_eye_yaw.y + 256 * math.sin(rad), entity_eye_yaw.z)
                
                local fraction, eid, impact = point_start:trace_line_impact(point_end, me)
                
                local side = i < entity_angle.y and "left" or "right"

                trace_data[side] = trace_data[side] + fraction

            end
        end
        local side = trace_data.left < trace_data.right and 1 or 2
        if not self.freestand_data[target] then
            self.freestand_data[target] = {}
        end

        self.freestand_data[target] = {
			side = side,
			side_fix = ""
		}

		local hitbox_pos = {x,y,z}
		hitbox_pos.x,hitbox_pos.y,hitbox_pos.z = entity.hitbox_position(target, 0)
		local local_x, local_y, local_z = entity.get_prop(entity.get_local_player(), "m_vecOrigin")

		local dynamic = calc_angle(local_x, local_y, local_z, hitbox_pos.x,hitbox_pos.y,hitbox_pos.z)
		local Pitch = entity.get_prop(target, "m_angEyeAngles[0]")
		local FakeYaw = math.floor(normalize_yaw(entity.get_prop(target, "m_angEyeAngles[1]")))
				
		local BackAng = math.floor(normalize_yaw(dynamic+180))
		local LeftAng = math.floor(normalize_yaw(dynamic-90))
		local RightAng = math.floor(normalize_yaw(dynamic+90))
		local ForwAng = math.floor(normalize_yaw(dynamic))
		local AreaDist = 58
				
				
		if (RightAng-FakeYaw <= AreaDist and RightAng-FakeYaw > -AreaDist) or (RightAng-FakeYaw >= -AreaDist and RightAng-FakeYaw < AreaDist) then
			targetAngle[target] = "right"
		elseif (LeftAng-FakeYaw <= AreaDist and LeftAng-FakeYaw > -AreaDist) or (LeftAng-FakeYaw >= -AreaDist and LeftAng-FakeYaw < AreaDist) then
			targetAngle[target] = "left"
		elseif (BackAng-FakeYaw <= AreaDist and BackAng-FakeYaw > -AreaDist) or (BackAng-FakeYaw >= -AreaDist and BackAng-FakeYaw < AreaDist) then
			targetAngle[target] = "backward"
		elseif (ForwAng-FakeYaw <= AreaDist and ForwAng-FakeYaw > -AreaDist) or (ForwAng-FakeYaw >= -AreaDist and ForwAng-FakeYaw < AreaDist) then
			targetAngle[target] = "forward"
		else
			targetAngle[target] = nil
		end

        -- velocity
        local vec_vel = vector(entity.get_prop(target, 'm_vecVelocity'))
		local velocity = math.floor(math.sqrt(vec_vel.x^2 + vec_vel.y^2) + 0.5)

		-- standing
		local standing = velocity < 1.1
		-- slowwalk
		local slowwalk = in_air(target) == false and velocity > 1.1 and self:GetPlayerMaxFeetYaw(target) >= 37
		--moving
		local moving = in_air(target) == false and velocity > 1.1 and self:GetPlayerMaxFeetYaw(target) <= 36
		-- air
		local air = in_air(target)

		local pitch_e = Pitch >= 0 and Pitch <= 52
		local pitch_sideways = Pitch <= 90 and Pitch >= -90
		local e_check = targetAngle[target] == "forward" and pitch_e
		local sideways_forward = targetAngle[target] == "forward" and pitch_sideways
		local sideways_left_right = ((targetAngle[target] == "left") or (targetAngle[target] == "right")) and pitch_sideways

		if e_check then
			if pressing_e_timer[target] == nil then
				pressing_e_timer[target] = 0
			end
			pressing_e_timer[target] = pressing_e_timer[target] + 0.5
		else
			pressing_e_timer[target] = 0
		end
		
		local pressing_e = e_check and pressing_e_timer[target] > 5 and not in_air(target)
		local onshot = e_check and pressing_e_timer[target] < 5 and not in_air(target)
		
		local calculate_angles = side == 1 and -1 or 1
        local calculate_phase = self.entity_data[target] and (self.entity_data[target].miss % 4 < 2 and 1 or 2) or 1
		local calculate_phase_sw = self.entity_data[target] and (self.entity_data[target].miss % 5 < 1 and 1 or ( self.entity_data[target].miss % 5 < 3 and 2 or 3) ) or 1
        local calculate_invert = self.entity_data[target] and (self.entity_data[target].miss % 2 == 1 and 1 or -1 ) or -1

		bruteforce_phases = {
            -- Stanidng players
            standing = {
                [1] = -50,
				[2] = 60,
				[3] = 30,
				[4] = 0
			},
			moving = {
				[1] = -max_yaw,
				[2] = max_yaw,
				[3] = max_yaw,
				[4] = 0
			},
			air = {
				[1] = -max_yaw,
				[2] = max_yaw,
				[3] = max_yaw,
				[4] = 0
			},
			slowwalk = {
                [1] = 30,
				[2] = -max_yaw,
				[3] = max_yaw,
				[4] = max_yaw,
				[5] = 0
			},
			pressing_e = {
				[1] = 0,
				[2] = -60,
				[3] = 60,
				[4] = 60
			},
			onshot = {
				[1] = 60,
				[2] = -60,
				[3] = -60
			},
        }



		local fix_value = bruteforce_phases.other[calculate_phase]*calculate_invert*calculate_angles
		local state = nil

		--standing
		if standing then
			fix_value = bruteforce_phases.standing[calculate_phase]*calculate_invert*calculate_angles
			state = "standing"
		end
		--moving
		if moving then
			fix_value = bruteforce_phases.moving[calculate_phase]*calculate_invert*calculate_angles
			state = "moving"
		end
		--slowwalk
		if slowwalk then
			fix_value = bruteforce_phases.slowwalk[calculate_phase]
			state = "slowwalk"
		end
		--in air
		if air then
			fix_value = bruteforce_phases.air[calculate_phase]*calculate_invert*calculate_angles
			state = "in air"
		end
		--e peek
		if pressing_e then
			fix_value = bruteforce_phases.pressing_e[calculate_phase]*calculate_invert*calculate_angles
			state = "e"
		end
		--e peek
		if onshot then
			fix_value = bruteforce_phases.onshot[calculate_phase]*calculate_invert*calculate_angles
			state = "fired"
		end
		--forward
		if sideways_forward then
			fix_value = (max_yaw/2 + (max_yaw/4))*calculate_invert*calculate_angles*(-2)
			state = "forward"
		end
		--sideways
		if sideways_left_right then
			fix_value = (max_yaw/2 - 4)*calculate_invert*calculate_angles
			state = "left/right"
		end


		self.freestand_data[target].side_fix = fix_value > 0 and "right" or "left"
        plist.set(target, "Force body yaw", true)
        plist.set(target, "Force body yaw value", fix_value)
    end
end

function GetPlayerMaxFeetYaw(_Entity)
    local S_animationState_t = self:GetAnimationState(_Entity)
    local nDuckAmount = S_animationState_t.m_fDuckAmount
    local nFeetSpeedForwardsOrSideWays = math.max(0, math.min(1, S_animationState_t.m_flFeetSpeedForwardsOrSideWays))
    local nFeetSpeedUnknownForwardOrSideways = math.max(1, S_animationState_t.m_flFeetSpeedUnknownForwardOrSideways)
    local nValue =
        (S_animationState_t.m_flStopToFullRunningFraction * -0.30000001 - 0.19999999) * nFeetSpeedForwardsOrSideWays +
        1
    if nDuckAmount > 0 then
        nValue = nValue + nDuckAmount * nFeetSpeedUnknownForwardOrSideways * (10.5 - nValue)
    end
    local nDeltaYaw = S_animationState_t.m_flMaxYaw * nValue
    return nDeltaYaw < 60 and nDeltaYaw >= 60 and nDeltaYaw or 60
end

local print = cheat.notify
local menu = ui

-- lua elements
menu.add_checkbox('Desync Indicator')
menu.add_colorpicker('Color')

-- code
local callbacks = {
    on_paint = {
        screen = { x = engine.get_screen_width(), y = engine.get_screen_height() }, -- get screen size
        desync_indicator = function(self)
            if not menu.get_bool('Desync Indicator') then return end -- checkbox check


            -- colors
            local col = menu.get_color('Color')
            local r, g, b = col:r(), col:g(), col:b()
            local manual_color_left = color.new(0, 0, 0, 80)
            local manual_color_right = color.new(0, 0, 0, 80)
            local def_r_col = color.new(0, 0, 0, 80)
            local def_l_col = color.new(0, 0, 0, 80)

            -- get values from menu
            local type = menu.get_int('0Antiaim.desync')

            -- get state
            local invert = menu.get_keybind_state(keybinds.flip_desync)
            local left_manual = menu.get_keybind_state(keybinds.manual_left)
            local right_manual = menu.get_keybind_state(keybinds.manual_right)

            -- set values
            if left_manual then manual_color_left = color.new(255, 255, 255, 100) end
            if right_manual then manual_color_right = color.new(255, 255, 255, 100) end
            if type == 1 then if invert then def_l_col = color.new(r,g,b) else def_r_col = color.new(r,g,b) end elseif type == 2 then if globalvars.get_tickcount() % 6 < 3 then def_l_col = color.new(r,g,b) else def_r_col = color.new(r,g,b) end end

            -- render
            render.triangle(self.screen.x/2 + 39 + 15, self.screen.y/2, self.screen.x/2 + 39, self.screen.y/2 + 9, self.screen.x/2 + 39, self.screen.y/2 - 9, manual_color_right)
            render.triangle(self.screen.x/2 - 39, self.screen.y/2 + 9, self.screen.x/2 - 39 - 15, self.screen.y/2, self.screen.x/2 - 39, self.screen.y/2 - 9, manual_color_left)

            render.rect_filled(self.screen.x/2 - 37, self.screen.y/2 - 9, 2, 18, def_r_col) -- desync deff right rect
            render.rect_filled(self.screen.x/2 + 35, self.screen.y/2 - 9, 2, 18, def_l_col) -- desync deff left rect
        end,
    },
}
cheat.RegisterCallback("on_paint", function()
    callbacks.on_paint:desync_indicator()
end)


local font = render.setup_font("Verdana", 12, 500, true, true, false)
local venfont = render.setup_font("Verdana", 12, 400, true )
local acafont = render.setup_font("Small Fonts", 9, 150, true, false, true)
local font_med = render.setup_font("Verdana", 14, 500, true, true, false)
local font_netgraph = render.setup_font("Verdana", 16, 400, true, true, false)
local font_big = render.setup_font("Verdana", 24, 500, true, true, false)
local font_small = render.setup_font("Verdana", 10, 400, true, true, false)
local font_small_calibri = render.setup_font("Calibri", 16, 200, true, false, false)
local halffont = render.setup_font( "Small Fonts", 9, 450, false, false, true )
local INDS = ui.get_bool("Keybinds")
local acafont1 = render.setup_font("Small Fonts", 12, 150, true, false, true)
local offset = 10


ui.add_checkbox("Keybinds")
ui.add_sliderint("x", 0, engine.get_screen_width() - 110)
ui.add_sliderint("y", 0, engine.get_screen_height() - 19)
ui.add_combobox("Keybinds style", {"Fade", "Gradient"})
ui.add_checkbox("Enable viewmodel in scope")


local swtich = true




local function paint()
 	local y = engine.get_screen_height()
	local x = engine.get_screen_width()
	local xmen = globalvars.get_menu_pos_x()
	local ymen = globalvars.get_menu_pos_y()
	local menu_opened = globalvars.is_open_menu()
	local fps = globalvars.get_framerate()	
	
	local rb = math.floor(math.sin(globalvars.get_realtime() * 2) * 127 + 128)
    	local gb =  math.floor(math.sin(globalvars.get_realtime() * 2 + 2) * 127 + 128)
    	local bb = math.floor(math.sin(globalvars.get_realtime() * 2 + 4) * 127 + 128)
    	
    	
    	local rbb = math.floor(math.sin(globalvars.get_realtime() * 3) * 127 + 128)
    	local gbb =  math.floor(math.sin(globalvars.get_realtime() * 3 + 2) * 127 + 128)
    	local bbb = math.floor(math.sin(globalvars.get_realtime() * 3 + 4) * 127 + 128)
 

	
	offset = 10
        
        	
	
if ui.get_bool("Enable viewmodel in scope") then
            if ui.get_keybind_state( "misc.third_person_key" ) then
                console.set_int( "fov_cs_debug", 0 )
            else
                console.set_int( "fov_cs_debug", 90 )
		 end
else
console.set_int( "fov_cs_debug", 0 )
end
   	
   	   if ui.get_bool("Keybinds") then 
   local x_pos = ui.get_int("x")
   local y_pos = ui.get_int("y")
   local offsett = 15  
   local hsmode = ui.get_keybind_mode(keybinds.hide_shots)
   local dtmode = ui.get_keybind_mode(keybinds.double_tap)
   local apmode = ui.get_keybind_mode(keybinds.automatic_peek)
   local spmode = ui.get_keybind_mode(keybinds.safe_points)
   local aamode = ui.get_keybind_mode(keybinds.flip_desync)
   local baimode = ui.get_keybind_mode(keybinds.body_aim)
   local swmode = ui.get_keybind_mode(keybinds.slowwalk)
   local fdmode = ui.get_keybind_mode(keybinds.fakeduck)
   local ejmode = ui.get_keybind_mode(keybinds.edge_jump)
   local dmgmode = ui.get_keybind_mode(keybinds.damage_override)
   if ui.get_int("Keybinds style") == 0 then
render.gradient(x_pos, y_pos, 60, 2, color.new(0,0,0,0), color.new(255,255,255))
render.gradient(x_pos + 60, y_pos, 60, 2, color.new(255,255,255), color.new(0,0,0,0))
end
if ui.get_int("Keybinds style") == 1 then
render.triplegradient(x_pos, y_pos, 120, 2, color.new(1,212,255,255), color.new(207,32,192,255), color.new(255,248,1,255), 0)
end
render.rect_filled(x_pos, y_pos + 2, 120, 15, color.new(0,0,0, 180))
render.text(font, x_pos + 40 - 3, y_pos + 3, color.new(255,255,255), "keybinds")
if (ui.get_keybind_state(keybinds.double_tap)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "DT")
render.text(font, x_pos + 110 - 5 - 5 - 2,y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end
if (ui.get_keybind_state(keybinds.hide_shots)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "HS")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.flip_desync)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "Inverter")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.body_aim)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "BAIM")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.slowwalk)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "Slowwalk")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.fakeduck)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "FD")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.edge_jump)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "EJ")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.automatic_peek)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "AP")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.damage_override)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "DMG")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end

if (ui.get_keybind_state(keybinds.safe_points)) then
render.text(font, x_pos + 2, y_pos + 3 + offsett, color.new(255,255,255), "SP")
render.text(font, x_pos + 110 - 5 - 5 - 2, y_pos + 3 + offsett, color.new(255,255,255), "[" .. "on" .. "]")
offsett = offsett + 15
end
end   	
   	  
  	if menu_opened == true then
   		x_wat = lerp(x_wat, 205, 0.05, false)
   	else
   		x_wat = lerp(x_wat, 0, 0.05, false)
   	end
   	
end

cheat.RegisterCallback("on_paint", paint)

cheat.RegisterCallback("on_createmove", resolver)

cheat.notify("This Script is coded by Yehuo#1337")
cheat.notify("Credit to All features developer")
cheat.notify("More Info & Support on dsc.gg/hvhclub")

local randomz

events.register_event("player_death", function(e)
    local attacker = e:get_int("attacker")
    local attacker_to_player = engine.get_player_for_user_id(attacker)
    
    local lp_idx = engine.get_local_player_index()
    
    if attacker_to_player == lp_idx then
     phrases = {"Mad? Get Good Get Future.lua dsc.gg/hvhclub",
                 "Rawetrip Resolver Improve All in Future.lua",
                 "Imagine so trash, Get Good Get Future.lua",
                 "Wanna be a Pro Player? Get Future.lua dsc.gg/hvhclub",
                 "H$, Noobs againest Future.lua = TRASH"}
            randomz = math.random(1,13)
        console.execute_client_cmd("say " .. phrases[randomz])
    end
end)