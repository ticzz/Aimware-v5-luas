local cb = gui.Checkbox( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.ghost.pulsating", "Pulsating Chams", 0)
callbacks.Register( 'Draw', function()
if not cb:GetValue() then return end
local r, g, b = gui.GetValue("esp.chams.ghost.occluded.clr")
local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
gui.SetValue("esp.chams.ghost.occluded.clr", r, g, b, o)
end)