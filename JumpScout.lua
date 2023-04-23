local rbot_bettersync_misc_grp = gui.Reference("Ragebot", "Accuracy", "Movement")

local jumpscoutFix = gui.Checkbox(rbot_bettersync_misc_grp, "rbot_bettersync_fixes_jumpscout", "Fix Jumpscout", 0)

local pLocal;

local del = globals.CurTime() + 0.100


local function handleVelocity()

    if not pLocal then
        return
    end

    local vel = math.sqrt(pLocal:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + pLocal:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)

    if jumpscoutFix:GetValue() then
        if vel > 5 then
            gui.SetValue("misc.strafe.enable", 1)
			gui.SetValue("misc.strafe.air", 1)
		else
            gui.SetValue("misc.strafe.enable", 0)
			gui.SetValue("misc.strafe.air", 0)
        end
    end
	gui.SetValue("misc.strafe.enable", 1)
	gui.SetValue("misc.strafe.air", 1)
end

local function drawHook()
    pLocal = entities.GetLocalPlayer()
	if not pLocal then return end
    handleVelocity()
   end
   
callbacks.Register( "Draw", drawHook);










--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

