-- notes for later
-- pelvis damage is 1.25x
-- we assume shots will be targeted at our pelvis

-- this is hardcoded as i didn't want to use ffi
-- btw fuck you aimware for not having an api call to get weapon data
-- [ItemDefinitionIndex] = { baseDamage, pentrationValue }
local damageTable = {
	[1] = { 63, 0.9320 }, -- deagle
	[2] = { 38, 0.5750 }, -- elites
	[3] = { 31, 0.9115 }, -- five seven
	[4] = { 30, 0.4700 }, -- glock
	[7] = { 35, 0.7750 }, -- ak47
	[8] = { 28, 0.9000 }, -- aug
	[9] = { 115, 0.9750 }, -- awp
	[10] = { 30, 0.7000 }, -- famas
	[11] = { 79, 0.8250 }, -- g3sg1
	[13] = { 30, 0.7750 }, -- galil
	[14] = { 32, 0.8000 }, -- m249
	[16] = { 33, 0.7000 }, -- m4a4
	[17] = { 28, 0.5750 }, -- mac10
	[19] = { 25, 0.6900 }, -- p90
	[23] = { 27, 0.6250 }, -- mp5
	[24] = { 35, 0.6500 }, -- ump
	[25] = { 120, 0.8000 }, -- xm1014
	[26] = { 27, 0.6000 }, -- bizon
	[27] = { 240, 0.7500 }, -- mag7
	[28] = { 35, 0.7100 }, -- negev
	[29] = { 256, 0.7500 }, -- sawed off
	[30] = { 33, 0.9015 }, -- tec9
	[31] = { 500, 1.0000 }, -- taser
	[32] = { 35, 0.5050 }, -- hkp2000
	[33] = { 29, 0.6250 }, -- mp7
	[34] = { 26, 0.6000 }, -- mp9
	[35] = { 234, 0.5000 }, -- nova
	[36] = { 38, 0.6400 }, -- p250
	[38] = { 80, 0.8250 }, -- scar20
	[39] = { 30, 1.0000 }, -- sg556
	[40] = { 88, 0.8500 }, -- ssg08
	[59] = { 33, 0.7000 }, -- m4a1-s
	[60] = { 35, 0.5050 }, -- usp-s
	[63] = { 31, 0.7765 }, -- cz75
	[64] = { 86, 0.9320 } -- revolver
}

local lethalEnemies = { }

callbacks.Register("CreateMove", function(UserCmd)
	lethalEnemies = { }
	
	local localPlayer = entities.GetLocalPlayer()
	local localPlayerTeam = localPlayer:GetTeamNumber()
	local localPlayerHealth = localPlayer:GetHealth()
	local localPlayerHasArmor = localPlayer:GetProp("m_ArmorValue") > 0
	local localPlayerDamageTable = damageTable[localPlayer:GetWeaponID()]
	for i = 1, globals.MaxClients() do
		local currentEntity = entities.GetByIndex(i)
		if currentEntity ~= nil then
			if currentEntity:IsPlayer() and currentEntity:IsAlive() and currentEntity:GetTeamNumber() ~= localPlayerTeam then
				-- 0 = not lethal
				-- 1 = enemy lethal to us
				-- 2 = we're lethal to enemy
				-- 3 = both
				local lethalMode = 0
				local weaponDamageTable = damageTable[currentEntity:GetWeaponID()]
				if weaponDamageTable ~= nil then
					if ((weaponDamageTable[1] * 1.25) * (localPlayerHasArmor and weaponDamageTable[2] or 1)) >= localPlayerHealth then
						lethalMode = 1
					end					
				end
				
				if localPlayerDamageTable ~= nil then
					if ((localPlayerDamageTable[1] * 1.25) * ((currentEntity:GetProp("m_ArmorValue") > 0) and localPlayerDamageTable[2] or 1)) >= currentEntity:GetHealth() then
						lethalMode = lethalMode + 2
					end
				end
				
				if lethalMode ~= 0 then
					lethalEnemies[#lethalEnemies + 1] = { currentEntity, lethalMode }
				end
			end
		end
	end
end)

callbacks.Register("DrawESP", function(EspBuilder)
	if not entities.GetLocalPlayer():IsAlive() then
		return
	end

	for i = 1, #lethalEnemies do
		local currentLethalEnemy = lethalEnemies[i]
		if currentLethalEnemy[1]:GetIndex() == EspBuilder:GetEntity():GetIndex() then
			local lethalMode = currentLethalEnemy[2]
			local currentColor = { 0, 0, 0, 255 }
			if lethalMode == 1 then
				currentColor[1] = 255
			elseif lethalMode == 2 then
				currentColor[2] = 255
			elseif lethalMode == 3 then
				currentColor[1] = 255
				currentColor[2] = 255
			end
			
			EspBuilder:Color(currentColor[1], currentColor[2], currentColor[3], currentColor[4])
			EspBuilder:AddTextRight("LETHAL")
		end
	end
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

