-- by Ozaron#5101
-- Without autosize


	local IN_SCOREBOARD = false


	callbacks.Register("CreateMove", function(cmd)
		local IN_SCORE = bit.lshift(1, 16)
		IN_SCOREBOARD = bit.band(cmd.buttons, IN_SCORE) == IN_SCORE
	end)

	local mouseX, mouseY, x, y, dx, dy, w, h = 0, 0, 25, 660, 0, 0, 300, 60;
	local shouldDrag = false;
	local font = draw.CreateFont("Courier New", 15, 15);
	local topbarSize = 20;
	local svgData = http.Get( "http://eaassets-a.akamaihd.net/battlelog/prod/emblem/325/83/320/2955057809976353965.png" );
	local imgRGBA, imgWidth, imgHeight = common.DecodePNG( svgData );
	local texture = draw.CreateTexture( imgRGBA, imgWidth, imgHeight );
	local render = {};

	render.outline = function( x, y, w, h, col )
		draw.Color( col[1], col[2], col[3], col[4] );
		draw.OutlinedRect( x, y, x + w, y + h );
	end
	render.rect = function( x, y, w, h, col )
		draw.Color( col[1], col[2], col[3], col[4] );
		--draw.FilledRect( x, y, x + w, y + h );
	end
	render.rect2 = function( x, y, w, h )
		draw.FilledRect( x, y, x + w, y + h );
	end
	render.gradient = function( x, y, w, h, col1, col2, is_vertical )
		render.rect( x, y, w, h, col1 );
		local r, g, b = col2[1], col2[2], col2[3];
		if is_vertical then
			for i = 1, h do
				local a = i / h * 255;
				render.rect( x, y + i, w, 1, { r, g, b, a } );
			end
		else
			for i = 1, w do
				local a = i / w * 255;
				render.rect( x + i, y, 1, h, { r, g, b, a } );
			end
		end
	end

	local function getlobbysti()
		local lobbysti = {};
		local lp = entities.GetLocalPlayer();
		if lp ~= nil then
		  local players = entities.FindByClass("CCSPlayer");    
			for i = 1, #players do
				local players = players[i];
					local name = players:GetName();
						local playerindex = players:GetIndex();
						if name ~= "GOTV" then
							local target = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", i);
								if target then
											table.insert(lobbysti, players)
					end
				end
			end
		end 
		return lobbysti;
	end
	local ranks = {
	"None",
	"Wood I",
	"Wood II",
	"Wood III",
	"Wood IV",
	"Wood Elite",
	"Wood Elite Master",
	"GN I",
	"GN II",
	"GN III",
	"GN Master",
	"Guardian I",
	"Guardian II",
	"Guardian Elite",
	"DMG",
	"LE",
	"LEM",
	"Supreme",
	"Global"
	}
	local function drawlobbysti(lobbysti)
		local temp = false;
		for index, players in pairs(lobbysti) do
			
			if (temp) then
				render.gradient( x+9, (y + topbarSize + 5) + (index * 15), 198, 1, { 13, 14, 15, 255 }, {40, 30, 30, 255 }, false );
				
			end
			temp=true;
			local text = players:GetName().." | WINS: "..entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
			draw.SetFont(font);
			draw.Color(255, 255, 255, 255);
			if players == entities.GetLocalPlayer() then
				draw.Color(161, 64, 64)
			else
				draw.Color(255,255,255,255)
			end
			draw.Text(x + 15, (y + topbarSize + 9) + (index * 15), text)
		  
		end
	end

	local function drawRectFill(r, g, b, a, x, y, w, h, texture)
		if (texture ~= nil) then
			draw.SetTexture(texture);
		else
			draw.SetTexture(texture);
		end
		draw.Color(r, g, b, a);
		draw.FilledRect(x, y, x + w, y + h);
	end

	local function drawGradientRectFill(col1, col2, x, y, w, h)
		drawRectFill(col1[1], col1[2], col1[3], col1[4], x, y, w, h);
		local r, g, b = col2[1], col2[2], col2[3];
		for i = 1, h do
			local a = i / h * col2[4];
			drawRectFill(r, g, b, a, x + 2, y + i, w - 2, 1);
		end
	end

	local function dragFeature()
		if input.IsButtonDown(1) then
			mouseX, mouseY = input.GetMousePos();
			if shouldDrag then
				x = mouseX - dx;
				y = mouseY - dy;
			end
			if mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + 40 then
				shouldDrag = true;
				dx = mouseX - x;
				dy = mouseY - y;
			end
		else
			shouldDrag = false;
		end
	end

	local function drawOutline(r, g, b, a, x, y, w, h, howMany)
		for i = 1, howMany do
			draw.Color(r, g, b, a);
			draw.OutlinedRect(x - i, y - i, x + w + i, y + h + i);
		end
	end

	local function drawWindow(Keybinds)
	
		local tW, _ = draw.GetTextSize(keytext);
		local h2 = 5 + (Keybinds * 15);
		local h = h + (Keybinds * 15);
		
		drawRectFill(13, 14, 15, 250, x + 7, y + 20, 242, 20);

		draw.Color(255, 255, 255);
		draw.SetFont(font);
		local keytext = 'Lobby Info';
		
		draw.Text(x + ((55 - tW) / 2), y + 25, keytext)
		
		drawRectFill(25, 28, 31, 250, x + 7, y + 40, 242, h2);
		drawOutline(40, 30, 30, 255, x + 9, y + 40, 238, h2, 2);
		
		draw.Color(255, 255, 255);
		draw.SetTexture( texture );
		draw.FilledRect( x+10, y+22, x+25, y+37 );
		draw.SetTexture( texture );
		
	end

	callbacks.Register("Draw", function()
		
		if not gui.Reference("menu"):IsActive() and not IN_SCOREBOARD then return end

		if lobbylist:GetValue() == false then return end
		if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

		draw.SetTexture( texture );
		local lobbysti = getlobbysti();
		drawWindow(#lobbysti);

		drawlobbysti(lobbysti	);
		dragFeature();
	end)
	lobbylist = gui.Checkbox(gui.Reference("Misc","General","Extra"),"lobbylist","Show Lobby List",0);
	lobbylist:SetDescription("Shows a players info.")





; 








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

