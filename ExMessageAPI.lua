local notifyText = {};
local notifyTime = 8;

local fontName = "Comic Sans MS";
local fontSize = 14;
local fontweight = 550;

local xOffset = 10;
local yOffset = 8;

local function clamp(var, lo, hi)
    if var > hi then
        return hi;
    elseif var < lo then
        return lo;
    end

    return var;
end

local function DrawTextShadow(x, y, string, r, g, b, a)
    draw.Color(0, 0, 0, a);
    draw.Text(x+1, y+1, string); 
    draw.Color(r, g, b, a);
    draw.Text(x, y, string);
end

-- I dont really need a function for this tbh but its here
function AddToNotify(clr, msg, console)
    table.insert(notifyText, {clr = clr, text = msg, liferemaining = notifyTime});

    if console == true then
        client.Command("echo \""..msg.."\"", true);
    end
end

-- updates lifetime for the notifications
function UpdateNotify()
	for i = #notifyText, 1, -1 do
		
		local notify = notifyText[i];

		notify.liferemaining = notify.liferemaining - globals.FrameTime();

		if notify.liferemaining <= 0.0 then
			table.remove(notifyText, i);
        end
			
	end
end

-- Drawing animation magic ripped straight from leaked source code :)
function DrawNotify()
    local drawFont = draw.CreateFont(fontName, fontSize, fontWeight);
    draw.SetFont(drawFont);

    -- Log base offsets
    local x = xOffset;
	local y = yOffset;
    
    -- Get font height
    local fontTall = fontSize;
    for i = 1, #notifyText do
        local notify = notifyText[i];

		local timeleft = notify.liferemaining;
        
		clr = notify.clr;

        -- only fade when about to expire
		if timeleft < 0.5 then
			local alphaFactor = clamp(timeleft, 0.0, 0.5) / 0.5;

			clr.a = alphaFactor * 255;

            -- Only move towards end of fade
			if i == 1 and alphaFactor < 0.2 then
				y = y - fontTall * (1.0 - alphaFactor / 0.2);
            end
		else
			clr.a = 255;
        end

        DrawTextShadow( x, y, notify.text, clr.r, clr.g, clr.b, clr.a)
        
		y = y + fontTall;
	end
end












--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

