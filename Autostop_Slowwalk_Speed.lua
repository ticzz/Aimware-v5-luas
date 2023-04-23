
local autostop_slowwalk = gui.Slider(gui.Reference("Ragebot", "Accuracy", "Weapon Movement"), "Chicken.autostop.slowwalk.speed", "Auto Stop Slow Walk Speed", 30, 1, 30, 1, "%") -- maybe % will be appended to value text one day
local native_slowwalk = gui.Reference("Ragebot", "Accuracy", "Movement", "Slow Walk Speed")

local function GetVelocity(entity)
	local VelocityX = entity:GetPropFloat( "localdata", "m_vecVelocity[0]" )
	local VelocityY = entity:GetPropFloat( "localdata", "m_vecVelocity[1]" )
	local VelocityZ = entity:GetPropFloat( "localdata", "m_vecVelocity[2]" )
	
	return math.sqrt(VelocityX^2 + VelocityY^2)
end

local cached_slowwalk_key = gui.GetValue("rbot.accuracy.movement.slowkey")
local cached_native_slowwalk_speed_value = 0
local manually_changing = true -- bool to see if the script is changing the native slow walk speed value, or if it's the user
local has_target = false

callbacks.Register("AimbotTarget", function(t)
	has_target = t:GetIndex() and true or false
end)



callbacks.Register("Draw", function()
	if native_slowwalk:GetValue() ~= cached_native_slowwalk_speed_value and manually_changing then
		cached_native_slowwalk_speed_value = native_slowwalk:GetValue()
	end
	
	local lp = entities.GetLocalPlayer()
	
	if lp then
		local speed = GetVelocity(lp)
		if speed >= autostop_slowwalk:GetValue() * 2.25 and has_target then
				local movement_key_down = 0
				if input.IsButtonDown(87) then -- w
					movement_key_down = 87
				elseif input.IsButtonDown(65) then  -- a
					movement_key_down = 65
				elseif input.IsButtonDown(83) then  -- s
					movement_key_down = 83
				elseif input.IsButtonDown(68) then -- d
					movement_key_down = 68
				end
				
				manually_changing = false
				native_slowwalk:SetValue(autostop_slowwalk:GetValue())
				gui.SetValue("rbot.accuracy.movement.slowkey", movement_key_down)		
		else
			manually_changing = true
			gui.SetValue("rbot.accuracy.wpnmovement.asniper.autostop", true)
			gui.SetValue("rbot.accuracy.movement.slowkey", cached_slowwalk_key)
			native_slowwalk:SetValue(cached_native_slowwalk_speed_value)
		end	
	end
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

