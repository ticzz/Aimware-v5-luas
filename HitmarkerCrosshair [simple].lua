local alpha = 0
local linesize = 6.6

local hurt_time = 0

local function hitmarker() 
-- first get the full screensize
local screencenterX, screencenterY = draw.GetScreenSize() 
-- then dividing the screensize by 2 will draw perfectly in the mid, on all resolutions
screencenterX = screencenterX / 2;  
screencenterY = screencenterY / 2;  

--Alpha/Colors:
local step = 255 / 0.3 * globals.FrameTime()
local r,b,g = gui.GetValue( "esp.other.crosshair.clr" )
if hurt_time + 0.4 > globals.RealTime() then
alpha = 255
else
alpha = alpha - step
end

if(alpha > 0) then

draw.Color( r,g,b, alpha)
draw.Line( screenCenterX - linesize * 2, screenCenterY - linesize * 2, screenCenterX - ( linesize ), screenCenterY - ( linesize ))
draw.Line( screenCenterX - linesize * 2, screenCenterY + linesize * 2, screenCenterX - ( linesize ), screenCenterY + ( linesize ))
draw.Line( screenCenterX + linesize * 2, screenCenterY + linesize * 2, screenCenterX + ( linesize ), screenCenterY + ( linesize ))
draw.Line( screenCenterX + linesize * 2, screenCenterY - linesize * 2, screenCenterX + ( linesize ), screenCenterY - ( linesize ))
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
print ("OnCrosshairHitmarker loaded")
callbacks.Register( "FireGameEvent", enemyhit)
callbacks.Register( "Draw", hitmarker)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

