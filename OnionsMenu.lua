--
-- Discord
-- https://discord.gg/8UQ2qQ5
--

--
-- Variables
--

-- Misc Vars
local mouseDown = false
local mousePosX, mousePosY = 0, 0
local mouseState = "none"
local initiated = false
local scrW, scrH = 0, 0
local textFont = draw.CreateFont( "Tahoma", 24 )

--
-- Drawing Functions
--

function drawFilledRect(r, g, b, a, x, y, width, height)
	draw.Color(r, g, b, a)
	draw.FilledRect(x, y, x + width, y + height)
end

function drawOutlineRect(r, g, b, a, x, y, width, height)
	draw.Color(r, g, b, a)
	draw.OutlinedRect(x, y, x + width, y + height)
end

function drawRoundedFilledRect(r, g, b, a, x, y, width, height, radius)
	draw.Color(r, g, b, a)
	draw.RoundedRectFill(x, y, x + width, y + height, radius)
end

function drawRoundedOutlineRect(r, g, b, a, x, y, width, height, radius)
	draw.Color(r, g, b, a)
	draw.RoundedRect(x, y, x + width, y + height, radius)
end

function drawFilledCircle(r, g, b, a, x, y, r)
	draw.Color(r, g, b, a)
	draw.FilledCircle(x, y, r)
end

function drawOutlinedCircle(r, g, b, a, x, y, r)
	draw.Color(r, g, b, a)
	draw.OutlinedCircle(x, y, r)
end

function drawText(r, g, b, a, x, y, font, str)
	draw.Color(r, g, b, a)
	draw.SetFont(font)
	draw.Text(x, y, str)
end

function drawCenteredText(r, g, b, a, x, y, font, str)
	draw.Color(r, g, b, a)
	draw.SetFont(font)
	local textW, textH = draw.GetTextSize(str)
	draw.Text(x - (textW / 2), y - (textH / 2), str)
end

function drawGradient( color1, color2, x, y, w, h, vertical )
	local r2, g2, b2 = color1[1], color1[2], color1[3]
	local r, g, b = color2[1], color2[2], color2[3]
	
    drawFilledRect( r2, g2, b2, 255, x, y, w, h )

    if vertical then
        for i = 1, h do
            local a = i / h * 255
            drawFilledRect( r, g, b, a, x, y + i, w, 1)
        end
    else
        for i = 1, w do
            local a = i / w * 255
            drawFilledRect( r, g, b, a, x + i, y, 1, h)
        end
    end
end

function drawOutlineGradient( outlineColor, color1, color2, x, y, w, h, vertical, thickness )
	local r, g, b, a = outlineColor[1], outlineColor[2], outlineColor[3], outlineColor[4]

	drawFilledRect(r, g, b, a, x, y, w, h)
	drawGradient( color1, color2, x + thickness, y + thickness, w - (thickness * 2), h - (thickness * 2), vertical )
end

--
-- Misc Functions
--

function returnColor(colors, x, y, w, h)
    checkFor = "none"

    if (mousePosX >= x and mousePosY >= y and mousePosX <= x + w and mousePosY <= y + h) then
        if (mouseState == "none") then
            checkFor = "hoverColor"
        else
            checkFor = "downColor"
        end
    else
        checkFor = "defaultColor"
    end

    if (colors ~= nil) then
        for i, name in ipairs(colors) do
            if (colors[i] == checkFor) then return colors[i + 1], colors[i + 2], colors[i + 3], colors[i + 4] end
        end
    end

    return nil, nil, nil, nil
end

--
-- Controls
--

function onionSampleControl(color, font, text, pos, size, styles, enabled)
    if (enabled) then
        local r, g, b, a = color[1], color[2], color[3], color[4]
        local x, y = pos[1], pos[2]
        local w, h = size[1], size[2]
        local hR, hG, hB, hA = color[1], color[2], color[3], color[4]
        local bR, bG, bB, bA = color[1], color[2], color[3], color[4]
        local dR, dG, dB, dA = color[1], color[2], color[3], color[4]
        local cR, cG, cB, cA = color[1], color[2], color[3], color[4]
        local tR, tG, tB, tA = 255, 255, 255, 255
        local bW, bH = nil, nil
        draw.SetFont(font)
        local textW, textH = draw.GetTextSize(text)

        -- Take care of custom styles.
        if (styles ~= nil) then
            for i, name in ipairs(styles) do
                if (styles[i] == "hoverColor") then hR, hG, hB, hA = styles[i + 1], styles[i + 2], styles[i + 3], styles[i + 4] end
                if (styles[i] == "downColor") then dR, dG, dB, dA = styles[i + 1], styles[i + 2], styles[i + 3], styles[i + 4] end
                if (styles[i] == "borderColor") then bR, bG, bB, bA = styles[i + 1], styles[i + 2], styles[i + 3], styles[i + 4] end
                if (styles[i] == "borderSize") then bW, bH = styles[i + 1], styles[i + 2] end
                if (styles[i] == "autoSize") then w, h = nil, nil end
                if (styles[i] == "textColor") then tR, tG, tB, tA = styles[i + 1], styles[i + 2], styles[i + 3], styles[i + 4] end
            end
        end

        -- If it autosizes then autosize.
        if (w == nil or h == nil) then
            w, h = textW + 20, textH + 16
        end

        -- Colors based on mouse state h = hover color, d = down color, c = default color.
        r, g, b, a = returnColor({ "defaultColor", cR, cG, cB, cA, "hoverColor", hR, hG, hB, hA, "downColor", dR, dG, dB, dA }, x, y, w, h)

        -- Draw the border
        drawFilledRect(bR, bG, bB, bA, x, y, w, h)

        -- Take care of the added border size.
        if (bW ~= nil or bH ~= nil) then
            w, x = w - (bW * 2), x + bW
            h, y = h - (bH * 2), y + bH
        end

        -- Draw the rest of it
        drawFilledRect(r, g, b, a, x, y, w, h)
        drawCenteredText(tR, tG, tB, tA, x + (w / 2), y + (h / 2), font, text)

        -- If the left click was released on the control then return true for it being clicked.
        if (mouseState ~= "released") then
            return false
        else
            return true
        end
    else
        return false
    end
end

--
-- Callback Functions
--

-- Variable Updates
function gatherVariables()
    if (initiated == false) then
        initiated = true

        scrW, scrH = draw.GetScreenSize()
    end

    mousePosX, mousePosY = input.GetMousePos()

    if (input.IsButtonDown("Mouse1")) then
        mouseState = "down"
    elseif (input.IsButtonReleased("Mouse1")) then
        mouseState = "released"
    else
        mouseState = "none"
    end
end

-- Menu Sample
function drawMenu()
    onionSampleControl({100, 100, 100, 255}, textFont, "test", { 100, 100 }, { 100, 100 }, { "textColor", 255, 255, 255, 255, "downColor", 0, 0, 0, 255, "hoverColor", 50, 50, 50, 255 }, true)
end

--
-- Callbacks
--

callbacks.Register('Draw', gatherVariables);
callbacks.Register('Draw', drawMenu);
