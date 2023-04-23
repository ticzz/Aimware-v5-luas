local ref = gui.Reference("Visuals")
local tab = gui.Tab(ref, "box", "MOAR BOX")
local gbox = gui.Groupbox(tab, "Box Settings", 16, 16, 296, 1)
local team = gui.Checkbox(gbox, "team", "Show on Teammates", 0)
local edge = gui.Checkbox(gbox, "edge", "Box Edge", 1)
local outline = gui.Checkbox(gbox, "outline", "Outline", 1)
local edgeamt = gui.Slider(gbox, "edge.size", "Edge Size", 30, 1, 50)
local edgecol = gui.ColorPicker(edge, "edge.color", "Edge Color", 255, 255, 255, 255)

local fill = gui.Checkbox(gbox, "fill", "Box Fill", 0)
local fillcol = gui.ColorPicker(fill, "fill.color", "Fill Color", 255, 255, 255, 150)
local fillhp = gui.Checkbox(gbox, "fill.hp", "Fill With HP", 0)
local fillcolhp = gui.Checkbox(gbox, "fill.color.hp", "Color by HP", 0)

callbacks.Register("DrawESP", function(esp)
    if not esp:GetEntity():IsAlive() then return end
    if (esp:GetEntity():GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) and not team:GetValue() then return end
    local x, y, x2, y2 = esp:GetRect()

    if fill:GetValue() then
        if fillcolhp:GetValue() then
            local hp = esp:GetEntity():GetHealth()
            local fillcolor = { fillcol:GetValue() }
            draw.Color(255 - (hp * (255/100)), ( hp * (255/100)), 0, fillcolor[4])
        else
            local fillcolor = { fillcol:GetValue() }
            draw.Color(fillcolor[1], fillcolor[2], fillcolor[3], fillcolor[4])
        end

        if fillhp:GetValue() then
            local hp = esp:GetEntity():GetHealth()
            draw.FilledRect(x, y2 - (y2 - y) * (hp * 0.01), x2, y2)
        else
            draw.FilledRect(x, y, x2, y2)
        end
    end

    if outline:GetValue() then

        local size = 1 - edgeamt:GetValue() * 0.01

        draw.Color(0, 0, 0, 255)
        draw.ShadowRect((x) + (x2 - x) * size, y2, x2, y2, 7)
        draw.ShadowRect(x2, (y) + (y2 - y) * size, x2, y2, 7)


        draw.ShadowRect(x, (y) + (y2 - y) * size, x, y2, 7)
        draw.ShadowRect(x, y2, (x2) - (x2 - x) * size, y2, 7)


        draw.ShadowRect(x, (y2) - (y2 - y) * size, x, y, 7)
        draw.ShadowRect(x, y, (x2) - (x2 - x) * size, y, 7)


        draw.ShadowRect((x) + (x2 - x) * size, y, x2, y, 7)
        draw.ShadowRect(x2, (y2) - (y2 - y) * size, x2, y, 7)

    end

    if edge:GetValue() then

        local size = 1 - edgeamt:GetValue() * 0.01
        local edgecolor = {edgecol:GetValue() }
        draw.Color(edgecolor[1], edgecolor[2], edgecolor[3], edgecolor[4])
        draw.Line((x) + (x2 - x) * size, y2, x2, y2)
        draw.Line(x2 , (y) + (y2 - y) * size, x2, y2)

        draw.Line(x, (y) + (y2 - y) * size, x, y2)
        draw.Line(x, y2, (x2) - (x2 - x) * size, y2)

        draw.Line((x) + (x2 - x) * size, y, x2, y)
        draw.Line(x, (y2) - (y2 - y) * size, x, y)


        draw.Line(x, y, (x2) - (x2 - x) * size, y)
        draw.Line(x2, (y2) - (y2 - y) * size, x2, y)
    end


end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

