local group = gui.Groupbox(gui.Reference('Misc', 'General'), "Rapid Switch", 16, 134, 296, 125)
local checkBox = gui.Checkbox(group, "lua_rapidswitch_enable", "Enable", false)
local rapidSwitchKey = gui.Keybox(group, 'lua_rapidswitch_key', 'Key', 0);
local _time = gui.Slider(group, "lua_rapidswitch_time", "Time", 1, 1, 100)

local function isButtonDown(key)
    return key > 0 and input.IsButtonDown(key);
end

local function time2tick(t)
    return math.ceil( 0.5 + (t / globals.TickInterval()) )
end

local function rapidSwitch(cmd)
    if (checkBox:GetValue() and isButtonDown(rapidSwitchKey:GetValue())) then
        engine.AddOutSeqNr( time2tick(_time:GetValue()) )
    end
end

callbacks.Register('CreateMove', rapidSwitch)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

