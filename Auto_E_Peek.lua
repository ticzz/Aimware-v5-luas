local e_thing_tab = gui.Tab(gui.Reference("Ragebot"), "e.thing", "E Thing")
local e_thing_gb = gui.Groupbox(e_thing_tab, "E Thing", 10, 15, 600, 0 )
local e_thing_enabled = gui.Checkbox(e_thing_gb, "e.thing.enabled", "Enable", true)
local e_thing_prediction_amount = gui.Slider(e_thing_gb, "e.thing.prediction.amount", "Prediction amount", 0.30, 0.01, 1, 0.01)
local e_thing_draw_prediction = gui.Checkbox(e_thing_gb, "e.thing.draw.enabled", "Draw enable", true)


function predict_velocity(entity, prediction_amount)
	local VelocityX = entity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
	local VelocityY = entity:GetPropFloat( "localdata", "m_vecVelocity[1]" );
	local VelocityZ = entity:GetPropFloat( "localdata", "m_vecVelocity[2]" );
	
	absVelocity = {VelocityX, VelocityY, VelocityZ}
	
	pos_ = {entity:GetAbsOrigin()}
	
	modifed_velocity = {vector.Multiply(absVelocity, prediction_amount)}
	
	return {vector.Subtract({vector.Add(pos_, modifed_velocity)}, {0,0,0})}
end


function PlayersFilter(fn) -- not optimal for situation, should return stop loop after first time condition is met
	local valid = {}
	for k, player in pairs(entities.FindByClass("CCSPlayer")) do
		if fn and fn(player) then
			table.insert(valid, player)
		end
	end
	return valid
end

local IN_USE = false

callbacks.Register("Draw", function()
	if not e_thing_enabled:GetValue() then return end
	
	local LocalPlayer = entities.GetLocalPlayer()
	if not LocalPlayer then return end
		local my_pos = LocalPlayer:GetAbsOrigin()
		local prediction = predict_velocity(LocalPlayer, e_thing_prediction_amount:GetValue())
		local x,y,z = vector.Add(
			{my_pos.x, my_pos.y, my_pos.z},
			{prediction[1], prediction[2], prediction[3]}
		)
		
		prediction = Vector3(x,y,z + 32)
		local players = PlayersFilter(function(player)
			local tr = engine.TraceLine(prediction,
			player:GetAbsOrigin() + Vector3(0,0,32), 4294967295)
			
			return tr and tr.entity and tr.entity:IsPlayer() and
			tr.entity:GetTeamNumber() ~= LocalPlayer:GetTeamNumber()
			
		end)
		
		if #players ~= 0 and not IN_USE then
			IN_USE = true
			client.Command("+use", true)
		elseif #players == 0 and IN_USE then
			client.Command("-use", true)
			IN_USE = false
		end
		
		if e_thing_draw_prediction:GetValue() and LocalPlayer:IsAlive() then
			local x2,y2 = client.WorldToScreen(prediction)	
			draw.Color(255,0,0)
			draw.Text(x2, y2, "PREDICTION")
		end
	
end)


local has_target = false
callbacks.Register("AimbotTarget", function(t)
	has_target = t:GetIndex()
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

