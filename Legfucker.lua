--[[
Working on aimware leg shaking
Source code from https://aimware.net/forum/thread/144904
Recoding qi
]]

--gui
local legshaking = gui.Checkbox(gui.Reference("Misc","Movement","Other"),"legfucker","legshaking", false)
local legshakingtime = gui.Slider(gui.Reference("Misc","Movement","Other"), "legshaking.time", "legshaking Interval time", 0.01, 0.01, 0.2, 0.01)

--var
local time = globals.CurTime()
local state = true
local lp = entities.GetLocalPlayer()

--function

local function Onlegshaking()
    if globals.CurTime() > time then
        state = not state
        time = globals.CurTime() + legshakingtime:GetValue()
        entities.GetLocalPlayer():SetPropInt(0, "m_flPoseParameter")
    end
    gui.SetValue("misc.slidewalk", state)
end

--callbacks
callbacks.Register("Draw", function()

    if entities.GetLocalPlayer() and legshaking:GetValue() then 
        entities.GetLocalPlayer():SetPropInt(1, "m_flPoseParameter")
        Onlegshaking()
    end
end)
--end






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

