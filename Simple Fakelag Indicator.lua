--Compile to aimware
--By Qi
--

--gui
local X, Y = draw.GetScreenSize()
local fakelag_indicator_Reference = gui.Reference("Misc", "Enhancement", "Fakelag")
local fakelag_indicator_Enable = gui.Checkbox(fakelag_indicator_Reference, "indicator", "Indicator", 0)
local fakelag_indicator_Clr = gui.ColorPicker(fakelag_indicator_Enable, "clr", "clr", 255, 255, 255, 255)
local fakelag_indicator_Clr2 = gui.ColorPicker(fakelag_indicator_Enable, "clr2", "clr2", 88, 197, 255, 255)
local fakelag_indicator_Clr3 = gui.ColorPicker(fakelag_indicator_Enable, "clr3", "clr3", 163, 118, 255, 255)
local fakelag_indicator_X = gui.Slider(fakelag_indicator_Enable, "x", "X", 25, 0, X)
local fakelag_indicator_Y = gui.Slider(fakelag_indicator_Enable, "y", "Y", 530, 0, Y)

fakelag_indicator_Enable:SetDescription("Simple gradient draw indicator.")
fakelag_indicator_X:SetInvisible(true)
fakelag_indicator_Y:SetInvisible(true)

--var
local font = draw.CreateFont("Verdana", 12)
local MENU = gui.Reference("MENU")


--function

--Mouse drag
local function is_inside(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end
local function drag_menu(x, y, w, h)
    if not MENU:IsActive() then
        return tX, tY
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not _drag then
            local w, h = x + w, y + h
            if is_inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                _drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            fakelag_indicator_X:SetValue(tX)
            fakelag_indicator_Y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end
--Let drag position save
local function PositionSave()
    if tX ~= fakelag_indicator_X:GetValue() or tY ~= fakelag_indicator_Y:GetValue() then
        tX, tY = fakelag_indicator_X:GetValue(), fakelag_indicator_Y:GetValue()
    end
end

--Gradient rectangle 
local function drawFilledRect(r, g, b, a, x, y, width, height)
    draw.Color(r, g, b, a)
    draw.FilledRect(x, y, x + width, y + height)
end
local function drawGradient(color1, color2, x, y, w, h, vertical)
    local r2, g2, b2 = color1[1], color1[2], color1[3]
    local r, g, b = color2[1], color2[2], color2[3]
    drawFilledRect(r2, g2, b2, 255, x, y, w, h)
    if vertical then
        for i = 1, h do
            local a = i / h * 255
            drawFilledRect(r, g, b, a, x, y + i, w, 1)
        end
    else
        for i = 1, w do
            local a = i / w * 255
            drawFilledRect(r, g, b, a, x + i, y, 1, h)
        end
    end
end

--Calculate false lag
local function time_to_ticks(a)
    return 
    math.floor(1 + a / globals.TickInterval())
end

--On draw
local function Ondraw()

    local x, y = drag_menu(tX, tY, 100, 41)
    local y = y + 15
    if entities.GetLocalPlayer():IsAlive() then

        local r, g, b, a = fakelag_indicator_Clr:GetValue()
        local r2, g2, b2, a2 = fakelag_indicator_Clr2:GetValue()
        local r3, g3, b3, a3 = fakelag_indicator_Clr3:GetValue()
        local FakeLag = time_to_ticks(globals.CurTime() - entities.GetLocalPlayer():GetPropFloat( "m_flSimulationTime")) + 2

        draw.Color(4, 4, 4, 150)
        draw.FilledRect(x, y, x + 103, y + 26)
        drawGradient({r2, g2, b2, a2}, {r3, g3, b3, a3}, x + 3, y + 3,  FakeLag * 5.883,  20)
        draw.SetFont(font)
        draw.Color(r, g, b, a)
        draw.TextShadow(x + 33, y - 15, "fake lag")
        
    end

end

callbacks.Register("Draw", function()
    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
        if gui.GetValue("misc.master") and gui.GetValue("misc.fakelag.enable") and fakelag_indicator_Enable:GetValue() then
            PositionSave()
            Ondraw() 
        end
    end
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

