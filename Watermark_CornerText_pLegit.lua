local function draw_watermark()
	
	local font = draw.CreateFont("Trebuchet MS", 20)
	draw.SetFont( font )
	
	local WatermarkText = "pLegit Config™"
	
	draw.Color(0, 0, 185, 255)
	draw.TextShadow(8, 8, WatermarkText)
	
	draw.Color(255, 0, 0, 255)
	draw.Text(7, 7, WatermarkText)
	
	local font = draw.CreateFont("Trebuchet MS", 20)
	draw.SetFont(font)
end

callbacks.Register('Draw', 'Draw Watermark', draw_watermark)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

