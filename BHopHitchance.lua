-- BHop Hitchance by stacky

local SLIDER = gui.Slider( gui.Reference( "Misc", "Movement", "Jump" ), "hitchance", "Hit Chance", 100, 0, 100 )
callbacks.Register( "CreateMove", function(cmd)
    if (gui.GetValue( "misc.autojump" ) ~= '"Off"' or bit.band(cmd.buttons, 2) == 0 or
        bit.band(entities.GetLocalPlayer():GetPropInt("m_fFlags"), 1) == 0 or math.random(1, 100) >= SLIDER:GetValue()) then return end
    cmd.buttons = cmd.buttons - 2
end )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

