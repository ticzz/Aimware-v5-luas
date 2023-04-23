local ref = gui.Reference("Misc", "Enhancement")

-- BOXES
local main_box = gui.Groupbox(ref, " JitterFakelag Settings",328, 321, 296, 400);


--sliders
local limit = gui.Slider(main_box, "limit", "Limit", 0, 0, 8);
local freq = gui.Slider(main_box, "frequency", "Frequency", 0, 1, 100);
local center = gui.Slider(main_box, "center", "Center", 0, 2, 17);


--vars

local function jitter_fakelag()
	maths = (gui.GetValue("misc.limit") * math.cos((globals.RealTime()) / (gui.GetValue("misc.frequency")*(0.01)))+ gui.GetValue("misc.center"));
	gui.SetValue("misc.fakelag.factor", maths)
end


callbacks.Register("Draw", jitter_fakelag)





;







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

