--
-- Discord
-- https://discord.gg/8UQ2qQ5
--

--
-- Variables
--

-- Window
local onion_window = gui.Tab(gui.Reference("Settings"), 'onion_window_hud', "Onion's HUD")

-- Groupboxes
local onion_window_groupbox_1 = gui.Groupbox(onion_window, 'Gradient Settings', 15, 15)
local onion_window_groupbox_2 = gui.Groupbox(onion_window, 'HUD Settings', 15, 295)
local onion_window_groupbox_3 = gui.Groupbox(onion_window, 'Side HUD Settings', 15, 1010)

-- Checkboxes
local onion_gradient_enabled = gui.Checkbox(onion_window_groupbox_1, 'onion_gradient_enabled', 'Enabled', true)
local onion_gradient_vertical = gui.Checkbox(onion_window_groupbox_1, 'onion_gradient_vertical', 'Vertical Gradient (Clowns Only)', false)
local onion_hud_enabled = gui.Checkbox(onion_window_groupbox_2, 'onion_hud_enabled', 'Enabled', true)
local onion_hud_position_dynamic = gui.Checkbox(onion_window_groupbox_2, 'onion_hud_position_dynamic', 'Dynamic HUD Position', true)
local onion_hud_enabled_ingame = gui.Checkbox(onion_window_groupbox_2, 'onion_hud_enabled_ingame', 'Ingame Check', true)
local onion_hud_side_enabled = gui.Checkbox(onion_window_groupbox_3, 'onion_hud_side_enabled', 'Enabled', true)
local onion_hud_side_enabled_ingame = gui.Checkbox(onion_window_groupbox_3, 'onion_hud_side_enabled_ingame', 'Ingame Check', true)
local onion_hud_side_position_draggable = gui.Checkbox(onion_window_groupbox_3, 'onion_hud_side_position_draggable', 'Draggable', true)

-- Sliders
local onion_gradient_height = gui.Slider(onion_window_groupbox_1, 'onion_gradient_height', 'Gradient Height', 5, 1, 20)
local onion_hud_position_x = gui.Slider(onion_window_groupbox_2, 'onion_hud_position_x', 'X Offset', 15, 0, 75)
local onion_hud_position_y = gui.Slider(onion_window_groupbox_2, 'onion_hud_position_y', 'Y Offset', 15, 0, 75)
local onion_hud_side_position_y = gui.Slider(onion_window_groupbox_3, 'onion_hud_side_position_y', 'Y Offset', 0, -200, 200)
local onion_hud_side_position_x = gui.Slider(onion_window_groupbox_3, 'onion_hud_side_position_x', 'X Offset', 15, 0, 75)
local onion_hud_side_distance_y = gui.Slider(onion_window_groupbox_3, 'onion_hud_side_distance_y', 'Vertical Distance', 10, 0, 50)


-- Comboboxs
local onion_hud_position = gui.Combobox(onion_window_groupbox_2, 'onion_hud_position', 'HUD Position', "Draggable", "Top Right", "Top Left", "Bottom Right", "Bottom Left")
local onion_hud_style = gui.Combobox(onion_window_groupbox_2, 'onion_hud_style', 'HUD Style', "Sypher", "Skeet", "Onetap")
local onion_hud_side_style = gui.Combobox(onion_window_groupbox_3, 'onion_hud_side_style', 'Side HUD Style', "Sypher", "Skeet", "Onetap")


-- Color Pickers
local onion_gradient_col_1 = gui.ColorPicker(onion_window_groupbox_1, 'onion_gradient_col_1', 'Gradient Color 1', 59, 175, 222, 255)
local onion_gradient_col_2 = gui.ColorPicker(onion_window_groupbox_1, 'onion_gradient_col_2', 'Gradient Color 2', 202, 70, 205, 255)
local onion_gradient_col_3 = gui.ColorPicker(onion_window_groupbox_1, 'onion_gradient_col_3', 'Gradient Color 3', 201, 227, 58, 255)
local onion_hud_color_bordercolor = gui.ColorPicker(onion_window_groupbox_2, 'onion_hud_color_bordercolor', 'HUD Border Color', 0, 183, 255, 255)
local onion_hud_color_bordercolor2 = gui.ColorPicker(onion_window_groupbox_2, 'onion_hud_color_bordercolor2', 'HUD Border Color 2', 0, 137, 191, 255)
local onion_hud_color_text = gui.ColorPicker(onion_window_groupbox_2, 'onion_hud_color_text', 'HUD Text Color', 255, 255, 255, 255)
local onion_hud_side_color_bordercolor = gui.ColorPicker(onion_window_groupbox_3, 'onion_hud_side_color_bordercolor', 'HUD Border Color', 0, 183, 255, 255)
local onion_hud_side_color_bordercolor2 = gui.ColorPicker(onion_window_groupbox_3, 'onion_hud_side_color_bordercolor2', 'HUD Border Color 2', 0, 137, 191, 255)
local onion_hud_side_color_text = gui.ColorPicker(onion_window_groupbox_3, 'onion_hud_side_color_text', 'HUD Text Color', 255, 255, 255, 255)


-- HUD Options
local onion_window_groupbox_2_groupbox_1 = gui.Groupbox(onion_window_groupbox_2, 'HUD Options', 0, 415)
local onion_hud_options_username = gui.Checkbox(onion_window_groupbox_2_groupbox_1, 'onion_hud_options_username', 'Username', true)
local onion_hud_options_ping = gui.Checkbox(onion_window_groupbox_2_groupbox_1, 'onion_hud_options_ping', 'Ping', true)
local onion_hud_options_server = gui.Checkbox(onion_window_groupbox_2_groupbox_1, 'onion_hud_options_server', 'Server', true)
local onion_hud_options_velocity = gui.Checkbox(onion_window_groupbox_2_groupbox_1, 'onion_hud_options_velocity', 'Velocity', true)
local onion_hud_options_tickrate = gui.Checkbox(onion_window_groupbox_2_groupbox_1, 'onion_hud_options_tickrate', 'Tickrate', true)

-- Side HUD Options
local onion_window_groupbox_3_groupbox_1 = gui.Groupbox(onion_window_groupbox_3, 'Side HUD Components', 0, 400)
local onion_hud_side_options_information = gui.Checkbox(onion_window_groupbox_3_groupbox_1, 'onion_hud_side_options_information', 'Information', true)
local onion_hud_side_options_velocity = gui.Checkbox(onion_window_groupbox_3_groupbox_1, 'onion_hud_side_options_velocity', 'Velocity', true)
local onion_hud_side_options_server = gui.Checkbox(onion_window_groupbox_3_groupbox_1, 'onion_hud_side_options_server', 'Server', true)


-- Fonts
local textFont = draw.CreateFont( "Tahoma", 16 )
local sideTextFont = draw.CreateFont( "Tahoma", 15 )

-- Misc Variables
local scrW, scrH = 0, 0
local initialize = false
local mouseX, mouseY = 0, 0
local localplayer
local username = ""
local ping = ""
local server = ""
local maxVelocity = {}
local curVelocity = {}
local playerResources
local curTime = ""
local map
local tick
local mouseState = "none"
local mouseDownPosX, mouseDownPosY = 0, 0
local mouseDown = "none"
local waterX, waterY = 20, 20

--
-- Misc Functions
--

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function getPropFloat(lp, wat)
    return lp:GetPropFloat("localdata", wat)
end

local function getPropInt(lp, wat)
    return lp:GetPropInt("localdata", wat)
end

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
-- HUD Drawing Functions
--

function drawTopHUD()
	if (onion_hud_enabled_ingame:GetValue() == true and localPlayer == nil) then
		return
	end

	local hudPosition = onion_hud_position:GetValue()
	local hudStyle = onion_hud_style:GetValue()
	local r, g, b, a = onion_hud_color_text:GetValue()
	local borderR, borderG, borderB, borderA = onion_hud_color_bordercolor:GetValue()
	local border2R, border2G, border2B, border2A = onion_hud_color_bordercolor2:GetValue()
	local hudString = "aimware | "
	local hudText = " | "
	
	--if (onion_hud_options_time:GetValue() == true) then
		
	--end
	
	if (onion_hud_options_username:GetValue() == true) then
		if (username ~= "") then hudString = hudString .. username .. hudText end
	end
	
	if (onion_hud_options_ping:GetValue() == true) then
		if (ping ~= "") then hudString = hudString .. ping .. hudText end
	end
	
	if (onion_hud_options_server:GetValue() == true) then
		if (server ~= "") then hudString = hudString .. server .. hudText end
	end
	
	if (onion_hud_options_velocity:GetValue() == true) then
		if (curVelocity ~= 0 and curVelocity ~= nil) then hudString = hudString .. curVelocity .. " m/s" .. hudText end
	end
	
	if (onion_hud_options_tickrate:GetValue() == true) then
		if (tick ~= "") then hudString = hudString .. tick
		--.. hudText 
		end
	end
	
	-- hudString = hudString .. curTime
	
	draw.Color(r, g, b, a)
	draw.SetFont(textFont)
	local textW, textH = draw.GetTextSize(hudString)
	local hudW, hudH = 0, 0
	
	if (hudStyle == 0) then
		hudW, hudH = textW + 20, textH + 10
	elseif (hudStyle == 1) then
		hudW, hudH = textW + 20, textH + 18
	else
		hudW, hudH = textW + 14, textH + 8
	end
	
	-- Set HUD Position
	if (hudPosition == 0) then
		if (mouseState == "down") then
			if (mouseDown == "none") then
				if (mouseX >= waterX and mouseX <= (waterX + hudW) and mouseY >= waterY and mouseY <= (waterY + hudH)) then
					mouseDown = "first"
					mouseDownPosX, mouseDownPosY = mouseX - waterX, mouseY - waterY
				end
			end
		else
			mouseDown = "none"
		end
	
		if (mouseDown == "first") then
			waterX, waterY = mouseX - mouseDownPosX, mouseY - mouseDownPosY
		end
	elseif (hudPosition == 1) then
		if (onion_hud_position_dynamic:GetValue() == true) then
			if (onion_gradient_enabled:GetValue() == true) then
				waterY = onion_gradient_height:GetValue()
			end
		end
		
		waterY = waterY + onion_hud_position_y:GetValue()
		waterX = scrW - (onion_hud_position_x:GetValue() + hudW)
	elseif (hudPosition == 2) then
		if (onion_hud_position_dynamic:GetValue() == true) then
			if (onion_gradient_enabled:GetValue() == true) then
				waterY = onion_gradient_height:GetValue()
			end
		end	
		
		waterY = waterY + onion_hud_position_y:GetValue()
		waterX = onion_hud_position_x:GetValue()
	elseif (hudPosition == 4) then
		waterY = ((scrH - hudH) - onion_hud_position_y:GetValue())
		waterX = onion_hud_position_x:GetValue()
	else
		waterY = ((scrH - hudH) - onion_hud_position_y:GetValue())
		waterX = scrW - (onion_hud_position_x:GetValue() + hudW)
	end
	
	
	-- Draw the HUD
	if (hudStyle == 0) then
		drawFilledRect(borderR, borderG, borderB, borderA, waterX, waterY, hudW, 2)
		drawFilledRect(50, 50, 50, 185, waterX, waterY + 2, hudW, hudH - 2)
		drawCenteredText(r, g, b, a, waterX + (hudW / 2), (waterY + 1) + ((hudH - 2) / 2), textFont, hudString)
	elseif (hudStyle == 1) then
		drawFilledRect(10, 10, 10, 255, waterX, waterY, hudW, hudH)
		drawFilledRect(60, 60, 60, 255, waterX + 1, waterY + 1, hudW - 2, hudH - 2)
		drawFilledRect(40, 40, 40, 255, waterX + 2, waterY + 2, hudW - 4, hudH - 4)
		drawFilledRect(10, 10, 10, 255, waterX + 5, waterY + 5, hudW - 10, hudH - 10)
		drawFilledRect(17, 17, 17, 255, waterX + 6, waterY + 6, hudW - 12, hudH - 12)
		drawCenteredText(r, g, b, a, waterX + (hudW / 2), (waterY + (hudH / 2)) - 1, textFont, hudString)
	else
		drawGradient({border2R, border2G, border2B, border2A}, {borderR, borderG, borderB, borderA}, waterX, waterY, hudW / 2, 2)
		drawGradient({borderR, borderG, borderB, borderA}, {border2R, border2G, border2B, border2A}, waterX + (hudW / 2), waterY, hudW / 2, 2)
		drawFilledRect(10, 10, 10, 125, waterX, waterY + 2, hudW, hudH - 2)
		drawCenteredText(r, g, b, a, waterX + (hudW / 2), (waterY + 1) + ((hudH - 2) / 2), textFont, hudString)
	end
end

function drawSideHUD()
	if (onion_hud_side_enabled_ingame:GetValue() == true and localPlayer == nil) then
		return
	end
	
	local r, g, b, a = onion_hud_side_color_text:GetValue()
	local borderR, borderG, borderB, borderA = onion_hud_side_color_bordercolor:GetValue()
	local border2R, border2G, border2B, border2A = onion_hud_side_color_bordercolor2:GetValue()
	local hudStyle = onion_hud_side_style:GetValue()
	local x, y = onion_hud_side_position_x:GetValue(), (scrH / 2) + onion_hud_side_position_y:GetValue()
	local usedY = 0
	local addAmount = onion_hud_side_distance_y:GetValue()
	
	if (onion_hud_side_options_information:GetValue() == true) then
		draw.Color(r, g, b, a)
		draw.SetFont(sideTextFont)
		local text = "Name: " .. username
		local textW, textH = draw.GetTextSize(text)
		
		if (hudStyle == 0) then -- Sypher
			drawFilledRect(borderR, borderG, borderB, borderA, x, y, textW + 20, 2)
			drawFilledRect(50, 50, 50, 185, x, y + 2, textW + 20, ((textH + 10) - 2) - 2)
			drawCenteredText(r, g, b, a, x + ((textW + 20) / 2), (y + 1) + (((textH + 10) - 2) / 2), sideTextFont, text)
			usedY = usedY + addAmount + ((textH + 10) - 2)
		elseif (hudStyle == 1) then -- Skeet
			drawFilledRect(10, 10, 10, 255, x, y, textW + 20, textH + 20)
			drawFilledRect(60, 60, 60, 255, x + 1, y + 1, textW + 18, textH + 18)
			drawFilledRect(40, 40, 40, 255, x + 2, y + 2, textW + 16, textH + 16)
			drawFilledRect(10, 10, 10, 255, x + 5, y + 5, textW + 10, textH + 10)
			drawFilledRect(17, 17, 17, 255, x + 6, y + 6, textW + 8, textH + 8)
			drawCenteredText(r, g, b, a, x + ((textW + 20) / 2), y + ((textH + 20) / 2), sideTextFont, text)
			usedY = usedY + addAmount + (textH + 20)	
		else -- Onetap
			drawGradient({border2R, border2G, border2B, border2A}, {borderR, borderG, borderB, borderA}, x, y, (textW + 14) / 2, 2)
			drawGradient({borderR, borderG, borderB, borderA}, {border2R, border2G, border2B, border2A}, x + ((textW + 14) / 2), y, (textW + 14) / 2, 2)
			drawFilledRect(10, 10, 10, 125, x, y + 2, (textW + 14), (textH + 8) - 2)
			drawCenteredText(r, g, b, a, x + ((textW + 14) / 2), (y + 1) + (((textH + 8) - 2) / 2), sideTextFont, text)
			usedY = usedY + addAmount + (textH + 8)
		end
	end
	
	if (onion_hud_side_options_velocity:GetValue() == true) then
		local text = curVelocity .. " m/s"
		local textW, textH = draw.GetTextSize(text)
		
		if (hudStyle == 0) then -- Sypher
			drawFilledRect(borderR, borderG, borderB, borderA, x, usedY + y, (scrW / 10) + 20, 2)
			drawFilledRect(50, 50, 50, 185, x, usedY + y + 2, (scrW / 10) + 20, (((textH + 10) - 2) - 2) * 2)
			drawCenteredText(r, g, b, a, x + (((scrW / 10) + 20) / 2), usedY + (y + 1) + (((textH + 10) - 2) / 2), sideTextFont, text)
			drawFilledRect(60, 60, 60, 255, x + 12, usedY + (y + 15) + textH, ((scrW / 10) + 8) - 12, 2)
			drawFilledRect(borderR, borderG, borderB, borderA, x + 12, usedY + (y + 15) + textH, (((scrW / 10) + 8) - 12) * (curVelocity / maxVelocity), 2)
			usedY = usedY + addAmount + ((((textH + 10) - 2) - 2) * 2) + 2
		elseif (hudStyle == 1) then -- Skeet
			drawFilledRect(10, 10, 10, 255, x, usedY + y, (scrW / 10) + 20, textH + 26)
			drawFilledRect(60, 60, 60, 255, x + 1, usedY + y + 1, (scrW / 10) + 18, textH + 24)
			drawFilledRect(40, 40, 40, 255, x + 2, usedY + y + 2, (scrW / 10) + 16, textH + 22)
			drawFilledRect(10, 10, 10, 255, x + 5, usedY + y + 5, (scrW / 10) + 10, textH + 16)
			drawFilledRect(17, 17, 17, 255, x + 6, usedY + y + 6, (scrW / 10) + 8, textH + 14)
			drawCenteredText(r, g, b, a, x + (((scrW / 10) + 20) / 2), usedY + y + ((textH + 20) / 2), sideTextFont, text)
			drawFilledRect(60, 60, 60, 255, x + 12, usedY + (y + 15) + textH, ((scrW / 10) + 8) - 12, 2)
			drawFilledRect(borderR, borderG, borderB, borderA, x + 12, usedY + (y + 15) + textH, (((scrW / 10) + 8) - 12) * (curVelocity / maxVelocity), 2)
			usedY = usedY + addAmount + (textH + 26)
		else -- Onetap
			drawGradient({border2R, border2G, border2B, border2A}, {borderR, borderG, borderB, borderA}, x, usedY + y, ((scrW / 10) + 20) / 2, 2)
			drawGradient({borderR, borderG, borderB, borderA}, {border2R, border2G, border2B, border2A}, x + (((scrW / 10) + 20) / 2), usedY + y, ((scrW / 10) + 20) / 2, 2)
			drawFilledRect(10, 10, 10, 125, x, usedY + y + 2, (scrW / 10) + 20, (((textH + 10) - 2) - 2) * 2)
			drawCenteredText(r, g, b, a, x + (((scrW / 10) + 20) / 2), usedY + (y + 1) + (((textH + 10) - 2) / 2), sideTextFont, text)
			drawFilledRect(60, 60, 60, 255, x + 12, usedY + (y + 15) + textH, ((scrW / 10) + 8) - 12, 2)
			drawFilledRect(borderR, borderG, borderB, borderA, x + 12, usedY + (y + 15) + textH, (((scrW / 10) + 8) - 12) * (curVelocity / maxVelocity), 2)
			usedY = usedY + addAmount + ((((textH + 10) - 2) - 2) * 2) + 2
		end
	end
	
	if (onion_hud_side_options_server:GetValue() == true) then
		local textW, textH = draw.GetTextSize(server)
		local textW2, textH2 = draw.GetTextSize(ping)
		
		if (textW2 > textW) then
			textW = textW2
		end
		
		if (textH2 > textH) then
			textH = textH2
		end
		
		if (hudStyle == 0) then -- Sypher
			drawFilledRect(borderR, borderG, borderB, borderA, x, usedY + y, textW + 10, 2)
			drawFilledRect(50, 50, 50, 185, x, usedY + y + 2, textW + 10, ((textH + 8) * 2) - 2)
			drawCenteredText(r, g, b, a, x + ((textW + 10) / 2), usedY + y + 2 + ((textH + 8) / 2), sideTextFont, server)
			drawCenteredText(r, g, b, a, x + ((textW + 10) / 2), usedY + y + 2 + ((textH + 8) / 2) + (textH + 6), sideTextFont, ping)
		elseif (hudStyle == 1) then -- Skeet
			drawFilledRect(10, 10, 10, 255, x, usedY + y, textW + 20, ((textH + 8) * 2) + 12)
			drawFilledRect(60, 60, 60, 255, x + 1, usedY + y + 1, textW + 18, ((textH + 8) * 2) + 10)
			drawFilledRect(40, 40, 40, 255, x + 2, usedY + y + 2, textW + 16, ((textH + 8) * 2) + 8)
			drawFilledRect(10, 10, 10, 255, x + 5, usedY + y + 5, textW + 10, ((textH + 8) * 2) + 2)
			drawFilledRect(17, 17, 17, 255, x + 6, usedY + y + 6, textW + 8, (textH + 8) * 2)
			drawCenteredText(r, g, b, a, x + ((textW + 20) / 2), usedY + y + ((textH + 20) / 2), sideTextFont, server)
			drawCenteredText(r, g, b, a, x + ((textW + 20) / 2), usedY + y + ((textH + 20) / 2) + (textH + 8), sideTextFont, ping)
			usedY = usedY + addAmount + (((textH + 8) * 2) + 12)
		else -- Onetap
			drawGradient({border2R, border2G, border2B, border2A}, {borderR, borderG, borderB, borderA}, x, usedY + y, (textW + 10) / 2, 2)
			drawGradient({borderR, borderG, borderB, borderA}, {border2R, border2G, border2B, border2A}, x + ((textW + 10) / 2), usedY + y, (textW + 10) / 2, 2)
			drawFilledRect(10, 10, 10, 125, x, usedY + y + 2, textW + 10, ((textH + 8) * 2) - 2)
			drawCenteredText(r, g, b, a, x + ((textW + 10) / 2), usedY + y + 2 + ((textH + 8) / 2), sideTextFont, server)
			drawCenteredText(r, g, b, a, x + ((textW + 10) / 2), usedY + y + 2 + ((textH + 8) / 2) + (textH + 6), sideTextFont, ping)
		end
	end
end


--
-- Callback Functions
--

function gatherVariables()
	if (initialize == false) then
		initialize = true
		scrW, scrH = draw.GetScreenSize()
	end
	
	mouseX, mouseY = input.GetMousePos()
	localPlayer = entities.GetLocalPlayer()
	playerResources = entities.GetPlayerResources()
	-- curTime = os.clock()

    if (input.IsButtonDown("Mouse1")) then
        mouseState = "down"
        if (mouseDownPosX == 0 and mouseDownPosY == 0) then
            mouseDownPosX, mouseDownPosY = mousePosX, mousePosY
        end
    elseif (input.IsButtonReleased("Mouse1")) then
        mouseState = "released"
        mouseDownPosX, mouseDownPosY = 0, 0
        mouseDown = false
    else
        mouseState = "none"
        mouseDownPosX, mouseDownPosY = 0, 0
        mouseDown = false
    end
	
	if (onion_hud_enabled:GetValue() == true) then
		if (localPlayer ~= nil) then
			local vX, vY = 0, 0
		
		    ping = playerResources:GetPropInt("m_iPing", localPlayer:GetIndex()) .. ' ms'
            tick = client.GetConVar("sv_maxcmdrate") .. ' tick'
			username = client.GetPlayerNameByIndex(client.GetLocalPlayerIndex())
			maxVelocity = client.GetConVar("sv_maxvelocity")
			vX, vY = getPropFloat(localPlayer, 'm_vecVelocity[0]'), getPropFloat(localPlayer, 'm_vecVelocity[1]')
			curVelocity = math.floor(math.min(10000, math.sqrt(vX * vX + vY * vY) + 0.5))
			
			map = engine.GetMapName()
			if (engine.GetServerIP() == "loopback") then
				server = "localhost"
			elseif string.find(engine.GetServerIP(), "A") then
				server = "valve"
			else
				server = engine.GetServerIP()
			end
		else
			maxVelocity = 1
			curVelocity = 0
			username = ""
			tick = ""
			ping = ""
			server = ""
			map = ""
		end
	end
end

function drawHUD()
	if (onion_gradient_enabled:GetValue() == true) then
		local a, b, c, d = onion_gradient_col_1:GetValue()
		local e, f, g, h = onion_gradient_col_2:GetValue()
		local i, j, k, l = onion_gradient_col_3:GetValue()
	
		drawGradient( { a, b, c, d }, { e, f, g, h }, 0, 0, draw.GetScreenSize() / 2, onion_gradient_height:GetValue(), onion_gradient_vertical:GetValue() );
		drawGradient( { e, f, g, h }, { i, j, k, l }, draw.GetScreenSize() / 2,  0 , draw.GetScreenSize() / 2 , onion_gradient_height:GetValue(), onion_gradient_vertical:GetValue());
	end
	
	if (onion_hud_enabled:GetValue() == true) then
		drawTopHUD()
		drawSideHUD()
	
	end
end

--
-- Callbacks
--

callbacks.Register('Draw', gatherVariables);
callbacks.Register('Draw', drawHUD);
callbacks.Register( 'DispatchUserMessage', updateChatTable );