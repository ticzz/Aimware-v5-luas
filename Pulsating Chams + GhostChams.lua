local cb1 = gui.Checkbox( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.pulsating", "Pulsating GlowChams", 0)

-- Change this to your liking, it's how fast it pulses.
-- min, max = opacity/alpha minimum and maximum
local speed = 1;
local min, max = 25, 220;

-- PUT YOUR GUI ELEMENTS HERE --
v = vector --(so shit like cham colors where R, G, B and A are all in one var)
s = single --(stuff that takes a single value - e.g. vis_viewfov)
sf = singlefloat --(like glow alpha (0.000 - 1.000))
local guiElements = {
	["esp.chams.enemy.glow.clr"] = "v",
    ["esp.chams.enemy.visible.clr"] = "v",
    ["esp.chams.enemy.occluded.clr"] = "v",
    ["esp.chams.friendly.visible.clr"] = "v",
    ["esp.chams.friendly.occluded.clr"] = "v",
    ["esp.chams.local.visible.clr"] = "v",
};


-- Don't edit anything down here.
local setValue = gui.SetValue;
local getValue = gui.GetValue;

-- cs = current step/value
-- cd = current direction (0-up/1-down)
local cs, cd = min, 0;
local function updateAlpha()
    for k, v in pairs(guiElements) do
        if (v == "v") then
            local r, g, b, a = getValue(k);
            setValue(k, r, g, b, cs);
        elseif (v == "s") then
            setValue(k, cs);
        elseif (v == "sf") then
            local p = cs / 255;
            setValue(k, p);
        end
    end
end

callbacks.Register("Draw", "DrawPulsating", function()
    if not cb1:GetValue() then return end
	
	if (cs >= max) then
        cd = 1;
    elseif (cs <= min+speed) then
        cd = 0;
    end
    
    if (cd == 0) then
        cs = cs + speed;
    elseif (cd == 1) then
        cs = cs - speed;
    end

    updateAlpha();
end);


--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#


local cb = gui.Checkbox( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.local.ghost.pulsating", "Pulsating GhostChams", 0)

callbacks.Register( "Draw", function()

if not cb:GetValue() then return end

local r1, g1, b1 = gui.GetValue("esp.chams.ghost.glow.clr")
local r2, g2, b2 = gui.GetValue("esp.chams.ghost.occluded.clr")
local r3, g3, b3 = gui.GetValue("esp.chams.ghost.overlay.clr")
local r4, g4, b4 = gui.GetValue("esp.chams.ghost.visible.clr")

local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40

gui.SetValue("esp.chams.ghost.glow.clr", r1, g1, b1, o)
gui.SetValue("esp.chams.ghost.occluded.clr", r2, g2, b2, o)
gui.SetValue("esp.chams.ghost.overlay.clr", r3, g3, b3, o)
gui.SetValue("esp.chams.ghost.visible.clr", r4, g4, b4, o)

end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

