local FindByClass, lp, Text, Color, WorldToScreen = entities.FindByClass, entities.GetLocalPlayer, draw.Text, draw.Color, client.WorldToScreen

local function draw_decoys(team, index)
	local decoys = FindByClass('CDecoyProjectile')

	for i=1, #decoys do
		local decoy = decoys[i]
		local pX, pY, pZ = decoy:GetAbsOrigin()
		local tX, tY = WorldToScreen( pX, pY, pZ )
		if tX ~= nil then
			local thrower = decoy:GetPropEntity('m_hThrower')

			if thrower:GetIndex() == index then
				Color(255, 255, 255)
				Text(tX - 35, tY, 'Decoy')
			else
				local bX, bY = WorldToScreen( pX, pY, pZ )

				if thrower:GetTeamNumber() == team then
					Color(0, 255, 42)
					Text(bX, bY, ''.. thrower:GetName())
					Text(tX - 20, tY, 'Decoy')
				else
					Color(255, 0, 25)
					Text(bX, bY, ''.. thrower:GetName())
					Text(tX - 20, tY, 'Decoy')
				end
			end
		end
	end
end

local function draw_smokes(team, index)
	local decoys = FindByClass('CSmokeGrenadeProjectile')

	for i=1, #decoys do
		local decoy = decoys[i]
		local pX, pY, pZ = decoy:GetAbsOrigin()
		local tX, tY = WorldToScreen( pX, pY, pZ )
		if tX ~= nil then
			local thrower = decoy:GetPropEntity('m_hThrower')

			if thrower:GetIndex() == index then
				Color(255, 255, 255)
				Text(tX - 38, tY, 'Smoke')
			else
				local bX, bY = WorldToScreen( pX, pY, pZ )

				if thrower:GetTeamNumber() == team then
					Color(0, 255, 42)
					Text(bX, bY, ''.. thrower:GetName())
					Text(tX - 22, tY, 'Smoke')
				else
					Color(255, 0, 25)
					Text(bX, bY, ''.. thrower:GetName())
					Text(tX - 22, tY, 'Smoke')
				end
			end
		end
	end
end

callbacks.Register('Draw', function()
	if not entities.GetLocalPlayer() then return end;
	
	local lp = entities.GetLocalPlayer()
	local my_index = lp:GetIndex()
	local my_team = lp:GetTeamNumber()

	draw_decoys(my_team, my_index)
	draw_smokes(my_team, my_index)
end)














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

