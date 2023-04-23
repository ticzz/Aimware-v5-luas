local ref = gui.Reference("Misc", "Enhancement", "Fakelag")
local dt_setting1 = gui.Combobox( ref, "dt.switch1", "DT Base Setting", "Off", "Shift" , "Rapid")
local dt_setting2 = gui.Combobox( ref, "dt.switch2", "DT Key Setting", "Off", "Shift" , "Rapid")
local dt_keybox = gui.Keybox( ref, "dt.key", "Doubletap Switch Key", 0)
local dt_keya = gui.GetValue("misc.fakelag.dt.key")

local function dt_key_switch()
    local dt_keya = gui.GetValue("misc.fakelag.dt.key")
    local dt_set1 = gui.GetValue("misc.fakelag.dt.switch1")
    local dt_set2 = gui.GetValue("misc.fakelag.dt.switch2")
    if input.IsButtonDown(dt_keya) then
        gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", dt_set2)
    else
        gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", dt_set1)
    end
end
callbacks.Register( "Draw", dt_key_switch)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

