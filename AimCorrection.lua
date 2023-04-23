local lua_ref = gui.Reference("Legitbot", "Aimbot", "Toggle")

local aim_correction_enable = gui.Checkbox(lua_ref, "aim_correction_enable", "Enable Aim Correction", false)
local aim_correction_color = gui.ColorPicker(aim_correction_enable, "aim_correction_color", "", 255, 255, 255)

local function getPriorityEntity()
	local local_entity = entities.GetLocalPlayer()

	local nearest_ground = math.huge
	local head_z, local_head_z;

	for _, entity in pairs(entities.FindByClass("CCSPlayer")) do
		if entity:IsPlayer() and entity:IsAlive() and entity:GetTeamNumber() ~= local_entity:GetTeamNumber() and entity:GetIndex() ~= local_entity:GetIndex() then
			
			local hitbox_position = entity:GetHitboxPosition(1)
			local hitbox_position_local = local_entity:GetAbsOrigin()

			head_z = hitbox_position.z
			local_head_z = hitbox_position_local.z

			--get closest ground 
			if math.abs(head_z - local_head_z) < nearest_ground then
				nearest_ground = head_z

				local HEAD_POS_CORRECTION = Vector3(0, 0, 3)

				return {client.WorldToScreen(entity:GetHitboxPosition(1) + HEAD_POS_CORRECTION)}
			end
		end
	end
end


local function aimCorrection()
	
	if gui.GetValue("lbot.aim.enable") or not aim_correction_enable:GetValue() then return end

	local screen_width, screen_height = draw.GetScreenSize()

	local entity_head_2d = getPriorityEntity()

	--check valid of fucntion return
	if entity_head_2d and entity_head_2d[1] and entity_head_2d[2] then

		draw.Color(aim_correction_color:GetValue())
		
		draw.Line(screen_width / 2 - 10, entity_head_2d[2], screen_width / 2 - 3, entity_head_2d[2])
		draw.Line(screen_width / 2 + 10, entity_head_2d[2], screen_width / 2 + 3, entity_head_2d[2])
	end
end
callbacks.Register('Draw', aimCorrection)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
