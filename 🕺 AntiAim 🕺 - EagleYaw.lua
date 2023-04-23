local slidewalk = "misc.slidewalk"
local rotateb = "rbot.antiaim.base.rotation"
local rotatel = "rbot.antiaim.left.rotation"
local rotater = "rbot.antiaim.right.rotation"
local lbybase = "rbot.antiaim.base.lby"
local lbyleft = "rbot.antiaim.left.lby"
local lbyright = "rbot.antiaim.right.lby"
local static_legs = "rbot.antiaim.extra.staticlegs"
local ar = "rbot.antiaim.advanced.antiresolver"
local aat = "rbot.antiaim.advanced.antialign"
local shift = "rbot.antiaim.condition.shiftonshot"
local base = "rbot.antiaim.base"
local left = "rbot.antiaim.left"
local right = "rbot.antiaim.right"
local ade = "rbot.antiaim.advanced.autodir.edges"
local aaa = "rbot.antiaim.advanced.autodir.targets"
local fakelag = "misc.fakelag.factor"
local last = 0
local state = true

local function Draw()
    local w, h = draw.GetTextSize("EagleYaw");
    local weight_padding, heightPadding = -10, 15;
    local watermark_width = weight_padding + w;
    local start_x, start_y = draw.GetScreenSize();
    start_x, start_y = start_x - watermark_width - 1200, start_y * 0.0125;
	draw.Color(0, 0, 0, 100);
    draw.FilledRect(start_x-25, start_y, start_x + watermark_width , start_y + h + heightPadding);
    draw.Color(255,255,255,255);
    draw.Text(start_x + weight_padding / 2-12, start_y + heightPadding / 2 + 1, "EagleYaw")
	draw.Color(200, 40, 40, 255);
	draw.FilledRect(start_x-25, start_y, start_x + watermark_width , start_y +2);
end
-- watermark style from thekorol


function CreateMove(cmd)
    local hLocalPlayer = entities.GetLocalPlayer()
    local velocity = math.sqrt(hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" ) ^ 2 + hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" ) ^ 2)
    -- ^ thx stacky for velocity shit

    if eagleyaw:GetValue() == 1 then
        if globals.CurTime() > last then
            state = not state
            last = globals.CurTime() + 0.01
            gui.SetValue(slidewalk, state and true or false)
        end

        if velocity <= 3 and velocity < 69 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 0)
            gui.SetValue(lbyright, 0)
            gui.SetValue(fakelag, 3)
        elseif velocity >= 70 and velocity < 129 then
            gui.SetValue(rotateb, 23)
            gui.SetValue(rotatel, -23)
            gui.SetValue(rotater, 23)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 8)
        elseif velocity >= 130 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 14)
        end

        gui.SetValue(static_legs, true)
        gui.SetValue(ar, false)
        gui.SetValue(aat, 1)
        gui.SetValue(shift, false)
        gui.SetValue(base, 180)
        gui.SetValue(left, 180)
        gui.SetValue(right, 180)
        gui.SetValue(ade, true)
        gui.SetValue(aaa, true)
    end

    if eagleyaw:GetValue() == 2 then
        if globals.CurTime() > last then
            state = not state
            last = globals.CurTime() + 0.01
            gui.SetValue(slidewalk, state and true or false)
        end

        if velocity <= 3 and velocity < 69 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 0)
            gui.SetValue(lbyright, 0)
            gui.SetValue(fakelag, 3)
        elseif velocity >= 70 and velocity < 129 then
            gui.SetValue(rotateb, 23)
            gui.SetValue(rotatel, -23)
            gui.SetValue(rotater, 23)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 8)
        elseif velocity >= 130 then
            gui.SetValue(rotateb, 33)
            gui.SetValue(rotatel, -33)
            gui.SetValue(rotater, 33)
            gui.SetValue(lbybase, 0)
            gui.SetValue(lbyleft, 167)
            gui.SetValue(lbyright, -167)
            gui.SetValue(fakelag, 14)
            end

        gui.SetValue(static_legs, true)
        gui.SetValue(ar, false)
        gui.SetValue(aat, 1)
        gui.SetValue(shift, false)
        gui.SetValue(base, state and -165 or 165)
        gui.SetValue(left, state and -165 or 165)
        gui.SetValue(right, state and -165 or 165)
        gui.SetValue(ade, false)
        gui.SetValue(aaa, true)
    end
end

function UI()
    eagleyaw = gui.Combobox(gui.Reference("Ragebot","Anti-Aim","Extra"),"eagleyaw","Eagle Yaw", "Off", "Static", "Jitter");
end
UI();

callbacks.Register( "CreateMove", "Eagleyaw", CreateMove );
callbacks.Register( "Draw", "Watermark", Draw ); --watermark VERY VERY poorly obfuscated on purpose

-- lua by https://aimware.net/forum/user/63613









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

