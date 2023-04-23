-- aimware menu reference
local menuReference = gui.Reference("MISC", "General", "Logs")

-- our menu references
local masterSwitch = gui.Checkbox(menuReference, "misc.yeehaw.master", "Enable yeehaw ricochets", false)
local volumeSlider = gui.Slider(menuReference, "misc.yeehaw.volume", "Yeehaw ricochet volume", 100, 1, 100)
local maximumDistance = gui.Slider(menuReference, "misc.yeehaw.distance", "Yeehaw ricochet maximum distance", 64, 8, 128)
local volume = volumeSlider:GetValue() / 100

-- seed random number generator
math.randomseed(common.Time() * 65535)

-- helper function for later
local function PlaySound()
	client.Command(string.format("playvol shot%i.mp3 %f", math.random(1, 15), volume), true)
end

-- i dont remember where i stole this from
local function GetClosestPoint(A, B, P)
    local a_to_p = Vector3(P.x - A.x, P.y - A.y, 0)
    local a_to_b = Vector3(B.x - A.x, B.y - A.y, 0)

    local atb2 = a_to_b.x^2 + a_to_b.y^2

    local atp_dot_atb = a_to_p.x*a_to_b.x + a_to_p.y*a_to_b.y
    local t = atp_dot_atb / atb2
    
    return Vector3(A.x + a_to_b.x*t, A.y + a_to_b.y*t, 0)
end

local localPlayerHurtThisTick = false
local enemyMissThisTick = false

-- callbacks
local function OnFireGameEvent(gameEvent)
	if not masterSwitch:GetValue() then
		return
	end

	local localPlayer = entities.GetLocalPlayer()

	-- handle player_hurt
	if gameEvent:GetName() == "player_hurt" then
		-- yes this is really needed, simple comparison of two entities doesn't work
		local victimIndex = entities.GetByUserID(gameEvent:GetInt("userid")):GetIndex()
		local attackerIndex = entities.GetByUserID(gameEvent:GetInt("attacker")):GetIndex()
		local localPlayerIndex = localPlayer:GetIndex()
		
		if victimIndex == localPlayerIndex and attackerIndex ~= localPlayerIndex then
			localPlayerHurtThisTick = true
		end
	end
	
	-- handle bullet_impact
	if gameEvent:GetName() == "bullet_impact" then
		local shooterEntity = entities.GetByUserID(gameEvent:GetInt("userid"))
		if shooterEntity:GetProp("m_iTeamNum") == localPlayer:GetProp("m_iTeamNum") then
			return
		end
		
		local impactPosition = Vector3(gameEvent:GetFloat("x"), gameEvent:GetFloat("y"), gameEvent:GetFloat("z"))

		local shooterOrigin = shooterEntity:GetAbsOrigin()
		local shooterViewOffset = shooterEntity:GetPropVector("localdata", "m_vecViewOffset[0]")
		local shooterShootPosition = shooterOrigin + shooterViewOffset

		local localHeadPosition = localPlayer:GetHitboxPosition(0)

		local closestPoint = GetClosestPoint(shooterShootPosition, impactPosition, localHeadPosition)
		local closestPointDelta = localHeadPosition - closestPoint
		
		if closestPointDelta:Length2D() < maximumDistance:GetValue() then
			enemyMissThisTick = true
		end
	end
end

local function OnCreateMove(UserCmd)
	if not masterSwitch:GetValue() then
		return
	end

	if not localPlayerHurtThisTick and enemyMissThisTick then
		PlaySound()
	end
	
	localPlayerHurtThisTick = false
	enemyMissThisTick = false
end

callbacks.Register("FireGameEvent", OnFireGameEvent)
callbacks.Register("CreateMove", OnCreateMove)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

