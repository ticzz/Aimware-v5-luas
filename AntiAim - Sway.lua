callbacks.Register("Draw", function()

gui.SetValue("rbot.antiaim.base.rotation", math.cos((globals.RealTime() * 2)) * 58)
gui.SetValue("rbot.antiaim.base.lby", -math.cos((globals.RealTime() * 2)) * 160)

end)
