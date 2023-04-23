--Moving and Standing hitchance--

local kui = gui.Groupbox( gui.Reference( "Ragebot", "Accuracy", "Weapon"), "Moving and Standing Hitchance")
local hcslider1 = gui.Slider( kui, "asniper.hitchance.move", "Moving Hitchance", 0, 0, 100 )
local hcslider2 = gui.Slider( kui, "asniper.hitchance.stand", "Standing Hitchance", 0, 0, 100 )
local veloslider = gui.Slider( kui, "asniper.hitchance.velocity", "Max StandVelocity", 0, 0, 120, 0.5)

local function movstandhc()
    velocity = math.sqrt(localPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + localPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
    	if velocity > maxVelo then
        gui.SetValue( "rbot.accuracy.weapon.asniper.hitchance", minValue )	-- Moving 	(when Velocity is higher than veloslider Value)
    else
        gui.SetValue( "rbot.accuracy.weapon.asniper.hitchance", maxValue )	-- Standing (when Velocity is lower than veloslider Value)
    end
end

local function sethc()
    minValue = hcslider1:GetValue()
    maxValue = hcslider2:GetValue()
	maxVelo  = veloslider:GetValue()
end


local function localcheck()
    localPlayer = entities.GetLocalPlayer()
    if localPlayer then
        sethc()
        movstandhc()
    end
end

callbacks.Register( "Draw",  localcheck )