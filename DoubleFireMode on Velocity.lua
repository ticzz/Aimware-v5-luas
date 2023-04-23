local ref = gui.Reference( "Ragebot", "Accuracy", "Weapon")
local enable = gui.Checkbox(ref, "doublefiregroup.enable.chkbox", "Activate Doublefire per Weapon", 0)
local tui = gui.Groupbox(ref, "Moving and Standing DoubletabMode")
local dt_moving = gui.Combobox( tui, "dt_moving", "DT Mode moving", "Off", "Shift" , "Rapid")
local dt_standing = gui.Combobox( tui, "dt_standing", "DT Mode standing", "Off", "Shift" , "Rapid")
local maxStandVelocity = gui.Slider(tui, "maxStandVelocity", "Max StandVelocity", 80, 0, 250, 5)

local weapon_list = {
    [1] = "hpistol",[2] = "pistol",[3] = "pistol",[4] = "pistol",[7] = "rifle",[8] = "rifle",[10] = "rifle",
	[11] = "asniper",[13] = "rifle",
[14] = "lmg",[16] = "rifle",[17] = "smg",[19] = "smg",[23] = "smg",[24] = "smg",
	[25] = "shotgun",[26] = "smg",[28] = "lmg",[30] = "pistol",
[32] = "pistol",[33] = "smg",[34] = "smg",[36] = "pistol",
	[38] = "asniper",[39] = "rifle",[60] = "rifle",
[61] = "pistol",[63] = "pistol",[64] = "hpistol"
};

--local weapon_list = {
--"asniper", "sniper", "scout", "hpistol", "pistol", "rifle"
--};

local adaptive_weapons = {
    -- see line 219
	["asniper"] = { 11, 38 },
    ["rifle"] = { 7, 8, 10, 13, 16, 39, 60 },
    ["hpistol"] = { 64, 1 },
    ["pistol"] = { 2, 3, 4, 30, 32, 36, 61, 63 }
};

local function get_current_weaponID()

	local weapons = gui.GetValue("rbot.accuracy.weapon"):lower():gsub('%W','')
		if weapons == "heavypistol" then
		weapons = "hpistol"
	elseif weapons == "pistol" then
		weapons = "pistol"
	elseif weapons =="submachinegun" then
		weapons = "smg"
	elseif weapons =="shared" then
		weapons = "shared"
	elseif weapons =="autosniper" then
		weapons = "asniper"
	elseif weapons =="ssg" then
		weapons = "scout"
	elseif weapons =="awp" then
		weapons = "awp"
	elseif weapons =="lightmachinegun" then
		weapons = "lmg"
	end
for i = 1, #weapon_list do
		if  weapon_list[i] == weapons then
			adaptive_weapons[i]:SetInvisible(false)
		else
			return
		end
	end
end

local function movstanddoubletabmode()
	if enable:GetValue() then


if lp == nil or  not lp:IsAlive() then return end

local lp = entities.GetLocalPlayer()
local lp_gwid = lp:GetWeaponID()
local velocity = math.sqrt(lp:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + lp:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
	


		if velocity > maxstandVelo then -- Moving 	(when Velocity is higher than veloslider Value)
			gui.SetValue("rbot.hitscan.accuracy." .. weapon_list[lp_gwid] .. ".doublefire", dt_move)
		elseif velocity < maxstandVelo then	-- Standing (when Velocity is lower than veloslider Value)
			gui.SetValue("rbot.hitscan.accuracy." .. weapon_list[lp_gwid] .. ".doublefire", dt_stand)
		end
	end
end

local function setdoubletabmode()
dt_move = dt_moving:GetValue()
dt_stand = dt_standing:GetValue()
maxstandVelo = maxStandVelocity:GetValue()

end

local function localcheck()
    localPlayer = entities.GetLocalPlayer()
    if localPlayer then
        setdoubletabmode()
        movstanddoubletabmode()
    end
end

local function activationCheck()
    if not enable:GetValue() then
            tui:SetInvisible(true);
			tui:SetDisabled(true);
        else
            tui:SetInvisible(false);
			tui:SetDisabled(false)
    end
end



callbacks.Register( "Draw",  "localcheck", localcheck )
callbacks.Register("Draw", "activationCheck", activationCheck )
callbacks.Register("Draw", "setdoubletabmode", setdoubletabmode )
callbacks.Register("Draw", "movstanddoubletabmode", movstanddoubletabmode )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

