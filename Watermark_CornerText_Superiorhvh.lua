function draw_watermark()
	
	local font = draw.CreateFont("Trebuchet MS", 20)
	draw.SetFont( font )
	
	local WatermarkText = "Superior pHvH Config™"
	
	draw.Color(255, 0, 0, 255)
	draw.Text(6, 6, WatermarkText)

	draw.Color(0, 255, 0, 255)
	draw.Text(5, 5, WatermarkText)

	
	local font = draw.CreateFont("Trebuchet MS", 20)
	draw.SetFont(font)
end

callbacks.Register('Draw', 'Draw Watermark', draw_watermark)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

