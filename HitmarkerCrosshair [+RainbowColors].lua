local alpha = 0
local linesize = 7
local speed = 4
local ref = gui.Reference('VISUALS', 'Other', 'Extra')
local rainbowxhairhitmarker_color = gui.ColorPicker(ref, "rainbowxhairhitmarker_color", "RainbowXhair Hitmarker Color", 0, 0, 0, 0)


local function hitmarker() 
if not entities.GetLocalPlayer() then return end;

local screencenterX, screencenterY = draw.GetScreenSize() --getting the full screensize
screencenterX = screencenterX / 2; screencenterY = screencenterY / 2 --dividing the screensize by 2 will place it perfectly in the center no matter what resolution
draw.Color(rainbowxhairhitmarker_color:GetValue())
 
 local r = math.floor(math.sin(globals.RealTime() * speed) * 127 + 128)
 local g = math.floor(math.sin(globals.RealTime() * speed + 2) * 127 + 128)
 local b = math.floor(math.sin(globals.RealTime() * speed + 4) * 127 + 128)
 local a = 0
    
    for k,v in pairs({"esp.other.rainbowxhairhitmarker_color"}) do
                        
        gui.SetValue(v, r,g,b,a)
        
    end
draw.Line(screencenterX - linesize, screencenterY + linesize, screencenterX, screencenterY)
draw.Line(screencenterX - linesize, screencenterY - linesize, screencenterX, screencenterY)
draw.Line(screencenterX + linesize, screencenterY + linesize, screencenterX, screencenterY)
draw.Line(screencenterX + linesize, screencenterY - linesize, screencenterX, screencenterY)
if(alpha > 0) then
    alpha = alpha - 2.5
    end
end

local function enemyhit(event)
    if(event:GetName() == "player_hurt") then --if the game event "player_hurt" gets called then
        local attacker = event:GetInt("attacker") --getting the attacker 
        local attackerindex = client.GetPlayerIndexByUserID(attacker) --retrieves the attackers entity index by using the GetPlayerIndexByUserID function aimwares api provides us
        if(attackerindex == client.GetLocalPlayerIndex()) then --if the attackers index for the player who got hurt matches the localplayer index, it means we're the attacker
        alpha = 255
        end
    end
end



client.AllowListener("player_hurt");

callbacks.Register( "FireGameEvent", "enemyhit", enemyhit)
callbacks.Register( "Draw", "hitmarker", hitmarker)
--callbacks.Register( "Draw", "rainbowxhairhitmarker", rainbowxhairhitmarker);