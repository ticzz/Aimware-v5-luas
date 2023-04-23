local killArray = {}
local guiref = gui.Reference("Visuals","Overlay","Enemy")
local recentkillcheck = gui.Checkbox(guiref, "recentkill", "Draw Recent Kill", 0)
local recentkilltime = gui.Slider(guiref, "recentkilltimer", "Recent Kill Timer", 5, 1, 30)
local iconcolor = gui.ColorPicker( guiref, "iconcolor", "", 240, 60, 30, 255)
local killTexture = draw.CreateTexture(common.RasterizeSVG('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 32 32"><g><path fill-rule="evenodd" clip-rule="evenodd" fill="#FFF" d="M15.5-4.2l0.75-1.05l1-3.1l3.9-2.65v-0.05 c0.067-0.1,0.1-0.233,0.1-0.4c0-0.2-0.05-0.383-0.15-0.55c-0.167-0.233-0.383-0.35-0.65-0.35l-4.3,1.8l-1.2,1.65l-1.5-3.95 l2.25-5.05l-3.25-6.9c-0.267-0.2-0.633-0.3-1.1-0.3c-0.3,0-0.55,0.15-0.75,0.45c-0.1,0.133-0.15,0.25-0.15,0.35 c0,0.067,0.017,0.15,0.05,0.25c0.033,0.1,0.067,0.184,0.1,0.25l2.55,5.6L10.7-14l-3.05-4.9L0.8-18.7 c-0.367,0.033-0.6,0.184-0.7,0.45c-0.067,0.3-0.1,0.467-0.1,0.5c0,0.5,0.2,0.767,0.6,0.8l5.7,0.15l2.15,5.4l3.1,5.65L9.4-5.6 c-1.367-2-2.1-3.033-2.2-3.1C7.1-8.8,6.95-8.85,6.75-8.85C6.35-8.85,6.1-8.667,6-8.3C5.9-8,5.9-7.8,6-7.7H5.95l2.5,4.4l3.7,0.3 L14-3.5L15.5-4.2z M14.55-2.9c-0.333,0.4-0.45,0.85-0.35,1.35c0.033,0.5,0.25,0.9,0.65,1.2S15.7,0.066,16.2,0 c0.5-0.067,0.9-0.3,1.2-0.7c0.333-0.4,0.467-0.85,0.4-1.35c-0.066-0.5-0.3-0.9-0.7-1.2c-0.4-0.333-0.85-0.45-1.35-0.35 C15.25-3.533,14.85-3.3,14.55-2.9z"/><path fill-rule="evenodd" clip-rule="evenodd" fill="#FFF" d="M28.443,16.724c0.02-1.733-0.59-1.772-0.629-2.835 c-0.021-0.532,0.044-2.025,0-3.464c-0.045-1.434-0.198-2.817-0.315-3.15c-0.236-0.669-0.504-1.773-2.52-3.465 c-2.206-1.851-6.459-3.426-8.82-3.465c-2.363-0.04-5.119,1.142-7.246,2.52c-2.126,1.378-2.638,1.969-3.464,3.15 c-0.828,1.181-1.143,2.008-0.946,4.095c0.197,2.087,0.244,1.537,0.315,3.465c0.06,1.595-0.665,2.088-0.63,3.15 c0.052,1.587,0.648,1.916,0.63,2.52c-0.013,0.396-0.709,0.893-0.63,2.205c0.08,1.336,0.354,1.693,2.835,3.15 c1.61,0.945,3.504,1.299,3.465,1.89c-0.058,0.865-0.275,2.284-0.314,3.15c-0.039,0.866,0.354,0.945,1.259,1.26 c0.907,0.315,3.032,0.984,5.356,0.945c2.323-0.04,3.308-0.512,4.41-0.945c1.102-0.433,1.26-0.827,1.26-1.575 c0-0.748-0.63-2.283-0.63-2.835c0-0.551,1.89-1.142,4.095-2.205c2.206-1.063,2.18-2.125,2.206-2.835 c0.047-1.338-0.631-1.653-0.631-2.205C27.499,18.168,28.431,17.984,28.443,16.724z M9.858,19.874 c-1.103,0.04-3.465,0.04-3.465-3.15c0-4.419,2.362-4.922,4.095-5.04c1.733-0.118,1.969-0.315,2.836,0.315 c1.556,1.132,1.456,3.137,0.944,4.725c-0.375,1.163-0.788,1.614-1.575,2.205S10.961,19.834,9.858,19.874z M17.104,24.914 l-0.434-1.608L16,23.313l-0.472,1.602c-1.812-0.492-2.54-1.22-2.52-2.205c0.02-0.984,0.571-2.008,1.574-2.835 c1.005-0.827,1.167-0.955,1.891-0.945c0.691,0.01,0.752,0.144,1.26,0.63c1.097,1.051,1.807,1.751,1.891,3.15 C19.706,24.086,18.107,24.855,17.104,24.914z M22.773,19.874c-1.103-0.04-2.047-0.354-2.835-0.945 c-0.787-0.591-1.252-1.027-1.575-2.205c-0.407-1.483-0.61-3.593,0.946-4.725c0.866-0.63,1.102-0.433,2.835-0.315 c1.731,0.118,4.095,0.621,4.095,5.04C26.239,19.914,23.876,19.914,22.773,19.874z"/></g></svg>'))

recentkillcheck:SetDescription("Shows if an enemy killed recently.")
recentkilltime:SetDescription("How long the icon stays up.")
iconcolor:SetPosY(1197)
iconcolor:SetPosX(-10)

local function round(n, d)
    local p = 10^d
    return math.floor(n*p)/p
end

local function death_event(event)
	lPlayer = entities.GetLocalPlayer()
	if lPlayer == nil then return end
	lPlayerTeam = lPlayer:GetTeamNumber()
	
	if event:GetName() == "player_death" then 
		local attacker = event:GetInt("attacker") 
		local victim = event:GetInt("userid")
		local attackerIndex = client.GetPlayerIndexByUserID(attacker)
		local victimIndex = client.GetPlayerIndexByUserID(victim)
		local attackerEntID = entities.GetByUserID(attacker)
		local victimEntID = entities.GetByUserID(victim)
		local attackerTeam = attackerEntID:GetTeamNumber()
		local victimTeam = victimEntID:GetTeamNumber()
		local attackerPlayerInfo = client.GetPlayerInfo(attackerIndex)
		local victimPlayerInfo = client.GetPlayerInfo(victimIndex)
		local attackerSteamID = attackerPlayerInfo["SteamID"]
		local victimSteamID = victimPlayerInfo["SteamID"]
		local CurTime = globals.CurTime()

		if attackerTeam ~= lPlayerTeam and attackerTeam ~= victimTeam then
			if killArray[attackerSteamID] == nil then
				killArray[attackerSteamID] = {CurTime, attackerSteamID}
			else
				killArray[attackerSteamID][1] = CurTime
			end
		end
	end
	if event:GetName() == "cs_win_panel_match" then
		killArray = {}
	end
end
callbacks.Register("FireGameEvent", "death_event", death_event)
client.AllowListener("player_death")
client.AllowListener("cs_win_panel_match")

local function killDraw(builder)
	local CurTime = globals.CurTime()

	local entID = builder:GetEntity()
	if entID == nil then return end
	builder:Color(iconcolor:GetValue())

	if entID:GetClass() == "CCSPlayer" and recentkillcheck:GetValue() == true then
		local entIndex = entID:GetIndex()
		local entPlayerInfo = client.GetPlayerInfo(entIndex)
		local entSteamID = entPlayerInfo["SteamID"]
		for i, v in pairs(killArray) do
			if v[2] == entSteamID then
				local lastKillTime =  round(CurTime - v[1], 3)
				if lastKillTime <= recentkilltime:GetValue() then
					builder:AddIconTop(killTexture)
				end
			end
		end
	end
end
callbacks.Register("DrawESP", "killDraw", killDraw)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")