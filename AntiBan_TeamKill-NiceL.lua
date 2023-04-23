-- Init Menu
Menu.Spacing()
Menu.Separator()
Menu.Spacing()
Menu.Checkbox("Show TeamKill Stats", "bShowTeamKill", true)
Menu.Combo( "Block Attack", "iBlockAttack", {"None", "If Critical", "Always" }, 1);

local iHealth_Offset = Hack.GetOffset("DT_BasePlayer", "m_iHealth") -- Get m_iHealth offset
local m_aimPunchAngle_Offset = Hack.GetOffset("DT_BasePlayer", "m_aimPunchAngle") -- Get m_aimPunchAngle offset

local Screen = IEngine.GetScreenSize()

local iDamage = 0;
local iKills = 0;
local bBlockedAttack = false;

local RedColor = Color.new(255, 100, 25, 255)
local GreenColor = Color.new(255, 255, 150, 255)
local BlueColor = Color.new(25, 100, 255, 255)

local OrangeColor = Color.new(255, 200, 100, 255)

function FireEventClientSideThink(Event)
    if (not Utils.IsLocal()) then 
        return
	end
	
	if (Event:GetName() == "player_death") then
        local IsLocalShot = IEngine.GetPlayerForUserID(Event:GetInt("attacker", 0)) == IEngine.GetLocalPlayer()
		if IsLocalShot then
			local Player = IEntityList.GetPlayer(IEngine.GetPlayerForUserID(Event:GetInt("userid", 0)))
			if (Player and Player:GetClassId() == 40 and Player:IsTeammate()) then 
				iKills = iKills + 1
			end
        end
	end 

	if (Event:GetName() == "player_hurt") then
		local attacker_EntInd = IEngine.GetPlayerForUserID(Event:GetInt("attacker", 0))
		local userid_EntInd = IEngine.GetPlayerForUserID(Event:GetInt("userid", 0))

        local IsLocalShot = attacker_EntInd == IEngine.GetLocalPlayer()
		local IsLocalIsTarget = userid_EntInd == IEngine.GetLocalPlayer() --or attacker_EntInd == userid_EntInd
		if (IsLocalShot and not IsLocalIsTarget) then
			local Player = IEntityList.GetPlayer(userid_EntInd)
			if (Player and Player:GetClassId() == 40 and Player:IsTeammate()) then 
				local Health = Player:GetPropInt(iHealth_Offset)
				if (Health >= Event:GetInt("dmg_health", 0)) then
					iDamage = iDamage + Event:GetInt("dmg_health", 0)
				else
					iDamage = iDamage + Health
				end
			end
        end
	end 
end
Hack.RegisterCallback("FireEventClientSideThink", FireEventClientSideThink)


function PaintTraverse()
	if (not Menu.GetBool("bShowTeamKill")) then 
		iDamage = 0;
		iKills = 0;
		bBlockedAttack = false;
        return
	end
	
	if (not Utils.IsLocal()) then 
		iDamage = 0;
		iKills = 0;
		bBlockedAttack = false;
        return
	end

	local col = Color.new(100, 225, 25, 255)
	if (iDamage >= 100 and iDamage < 200 or iKills >= 1 and iKills < 2) then
		col = Color.new(255, 150, 50, 255)
	end
	if (iDamage >= 200 or iKills >= 2) then
		col = Color.new(225, 50, 50, 255)
	end

	Render.Text_1("Damage: " .. tostring(iDamage) .. "/300", 5, 55, 18, col, false, true)
	Render.Text_1("Kills: " .. tostring(iKills).. "/3", 5, 75, 18, col, false, true)
	if (bBlockedAttack) then
		Render.Text_1("ATTACK IS BLOCKED!", Globals.ScreenWidth() / 2, Globals.ScreenHeight() / 2 - 50, 18, Color.new(225, 50, 50, 255), true, true)
	end
end
Hack.RegisterCallback("PaintTraverse", PaintTraverse)

local IN_ATTACK = 0
local function CreateMove(pCmd, p_bSendPacket)
	bBlockedAttack = false

	if (not Menu.GetBool("bShowTeamKill") or not Menu.GetInt("iBlockAttack")) then 
        return
	end

    if (not Utils.IsLocalAlive()) then 
        return
    end

	if (not IsBit(pCmd.buttons, IN_ATTACK)) then 
        return
	end

	local Local = IEntityList.GetPlayer(IEngine.GetLocalPlayer())
	if (not Local) then return end
	
	local ActiveWeapon = Local:GetActiveWeapon()
	if (not ActiveWeapon) then return end

	local WeaponData = ActiveWeapon:GetWeaponData()
	if (not WeaponData or WeaponData.iWeaponType < 1 or WeaponData.iWeaponType > 6) then return end
	
	
	local traceStart = Vector.new()
	local traceEnd = Vector.new()
	local tr = trace_t.new()
	local viewAngles = QAngle.new()

	IEngine.GetViewAngles(viewAngles)

	local LocalAngPunch  = QAngle.new()
	LocalAngPunch = Local:GetPropAngle(m_aimPunchAngle_Offset)

	local viewAngles_rcs = QAngle.new()
	viewAngles_rcs.pitch = viewAngles.pitch + LocalAngPunch.pitch * 2.0
	viewAngles_rcs.yaw = viewAngles.yaw + LocalAngPunch.yaw * 2.0
	viewAngles_rcs.roll = viewAngles.roll + LocalAngPunch.roll * 2.0

	Math.AngleVectors(viewAngles_rcs, traceEnd)

	traceStart = Local:GetEyePos()

	traceEnd.x = traceStart.x + traceEnd.x * 8192.0
	traceEnd.y = traceStart.y + traceEnd.y * 8192.0
	traceEnd.z = traceStart.z + traceEnd.z * 8192.0

	Utils.TraceLineOnlyEntities(traceStart, traceEnd, 0x46004003, Local, tr) 

	local Player = IEntityList.ToPlayer(tr.hit_entity)

	if (Player and Player:GetClassId() == 40 and Player:IsTeammate()) then
		if (Menu.GetInt("iBlockAttack") == 1) then -- Critical
			if (iKills >= 2 or iDamage >= 200) then
				pCmd.buttons = DelBit(pCmd.buttons, IN_ATTACK)
				bBlockedAttack = true
			end
		elseif (Menu.GetInt("iBlockAttack") == 2) then -- Always
			pCmd.buttons = DelBit(pCmd.buttons, IN_ATTACK)
			bBlockedAttack = true
		end
	end
end   
Hack.RegisterCallback("CreateMove", CreateMove)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

