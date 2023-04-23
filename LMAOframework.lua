--[[

 /$$           /$$      /$$      /$$$$$$       /$$$$$$ 
| $$          | $$$    /$$$     /$$__  $$     /$$__  $$
| $$          | $$$$  /$$$$    | $$  \ $$    | $$  \ $$
| $$          | $$ $$/$$ $$    | $$$$$$$$    | $$  | $$
| $$          | $$  $$$| $$    | $$__  $$    | $$  | $$
| $$          | $$\  $ | $$    | $$  | $$    | $$  | $$
| $$$$$$$$ /$$| $$ \/  | $$ /$$| $$  | $$ /$$|  $$$$$$/
|________/|__/|__/     |__/|__/|__/  |__/|__/ \______/ 

Lamarr's Magnificent API Overhaul

]]--

lmao_loaded = true
local lmao = {

name = "LMAO",
register = "$~",
font = draw.CreateFont("Tahoma", 16),
version = 2,
git_source = "https://raw.githubusercontent.com/lamarr2817/lmao/master/base",
git_version = "https://raw.githubusercontent.com/lamarr2817/lmao/master/version"
}

--			|||||||||||||||||||||||||||||||||| Start of Rendering ||||||||||||||||||||||||||||||||||

function lmao.draw_gradient(x1, y1, x2, y2, color, dir) -- FUCK THIS MATH THIS TOOK ENTIRELY TOO LONG
local w = x2 - x1
local h = y2 - y1

	if dir < 3 then -- will change to "up" "down" "left" "right" when i figure out how to uhhh
		for i = 0, w do
			local a = (i / w) * 255
			draw.Color(color[1], color[2], color[3], a)
			if dir == 1 then
				draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
			elseif dir == 2 then
				draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
			end
		
		end
	elseif dir <= 4 then
		for i = 0, h do
			local a = (i / h) * 255
			draw.Color(color[1], color[2], color[3], a)
			if dir == 3 then
				draw.FilledRect(x1, y1 + h - i, x1 + w, y1 + h - i + 1)
			elseif dir == 4 then
				draw.FilledRect(x1, y1 + i, x1 + w, y1 + i + 1)
			end
			
		end
	else
	lmao.log("Invalid direction", "GRADIENT")
	end
end

function lmao.draw_rect(x1, y1, x2, y2, color, outline) -- proud of this, very simple big brain
    draw.Color(color[1], color[2], color[3], color[4])
	if outline then 
	    draw.OutlinedRect(x1, y1, x2, y2)
	else
		draw.FilledRect(x1, y1, x2, y2)
	end
end

function lmao.draw_text(x, y, color, text, font, shadow)
	draw.Color(color[1], color[2], color[3], color[4])
    if (font ~= nil) then
        draw.SetFont(font)
	else
		draw.SetFont(lmao.font)
	end
	if (shadow ~= nil) then
		draw.TextShadow(x, y, text)
	else
		draw.Text(x, y, text)
	end
end

--			|||||||||||||||||||||||||||||||||| End of Rendering ||||||||||||||||||||||||||||||||||

--			|||||||||||||||||||||||||||||||||| Start of Utility ||||||||||||||||||||||||||||||||||

function lmao.log(text, err)

    if not err then
        print(lmao.register .. " " .. text)
    else
        print(lmao.register .. " [ERROR] " .. text)
    end
end

function lmao.update()
	if tonumber(http.Get(lmao.git_version)) > lmao.version then
		lmao.log("Update Started")
		local current_script = file.Open(GetScriptName(), "w")
		current_script:Write(http.Get(lmao.git_source))
		current_script:Close()
		gui.Command("lua.run " .. GetScriptName())
	else
		lmao.log("Script is up-to-date")
	end
end

--			|||||||||||||||||||||||||||||||||| End of Utility ||||||||||||||||||||||||||||||||||
