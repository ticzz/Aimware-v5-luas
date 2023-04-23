local bool_inGame = false

function gradient(x1, y1, x2, y2, left)
    local w = x2 - x1
    local h = y2 - y1

    for i = 0, w do
        local a = (i / w) * 200

        draw.Color(0, 0, 0, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end

--stolen from other thread
--credits: senator
local frame_rate = 0.0
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end


local kills = 0
local deaths = 0

--the gay method from some guy i think you can get the stats
--thru local player but im just too lazy
function events(event)
if not bool_inGame then
return
end;

    if event:GetName() == "player_death" then
        local local_player = client.GetLocalPlayerIndex()
        local attacker = client.GetPlayerIndexByUserID(event:GetInt("attacker"))
        local victim = client.GetPlayerIndexByUserID(event:GetInt("userid"))

        if attacker == local_player then
            killz = killz + 1
        end
        if (victim == local_player) then
            deaths = deaths + 1
        end
	elseif event:GetName() == "round_announce_match_start" then
		killz = {}
		deaths = {}
		
    end
end

function paint_traverse()
    local x, y = draw.GetScreenSize()
    local centerX = x / 2

    --the bar idk lol

    --left
    gradient(centerX - 200, y - 20, centerX - 51, y, 0, true)
    gradient(centerX - 200, y - 20, centerX - 51, y - 19, true)
    
    --middle
    draw.Color(0, 0, 0, 200)
    draw.FilledRect(centerX - 50, y - 20, centerX + 50, y)

    draw.Color(0, 0, 0, 255)
    draw.FilledRect(centerX - 50, y - 20, centerX + 50, y - 19)

    --right
    gradient(centerX + 50, y - 20, centerX + 200, y, false)
    gradient(centerX + 50, y - 20, centerX + 200, y - 19, false)

    --fps
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX - 10, y - 15, get_abs_fps())

    draw.Color(200, 255, 0, 255)
    draw.Text(centerX + 15, y - 15, "fps")

    --kills
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX - 80, y - 15, killz)

    draw.Color(255, 100, 0, 255)
    draw.Text(centerX - 65, y - 15, "kills")

    --deaths
    draw.Color(255, 255, 255, 255)
    draw.Text(centerX + 60, y - 15, deaths)

    draw.Color(255, 50, 50, 255)
    draw.Text(centerX + 75, y - 15, "deaths")
end

callbacks.Register("Draw", paint_traverse)
callbacks.Register("FireGameEvent", events)
client.AllowListener("player_death")
client.AllowListener("round_announce_match_start")







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

