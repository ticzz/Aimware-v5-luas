-- Rainbow Hud by stacky

local REF = gui.Reference( "Visuals", "Other", "Extra" )
local CHECKBOX = gui.Checkbox( REF, "rainbowhud.enable", "Rainbow Hud", false )
local SLIDER = gui.Slider( REF, "rainbowhud.interval", "Rainbow Hud Interval", 1, 0, 5, 0.05 )

local color = 1
local time = globals.CurTime()
local orig = client.GetConVar( "cl_hud_color" )

callbacks.Register( "Draw", function()
    if CHECKBOX:GetValue() then
        client.Command( "cl_hud_color " .. color, true )
        if globals.CurTime() - SLIDER:GetValue() >= time then
            color = color + 1
            time = globals.CurTime()
        end
        if color > 9 then color = 1 end
    end
end )

callbacks.Register( "Unload", function()
    client.Command( "cl_hud_color " .. orig, true )
end )