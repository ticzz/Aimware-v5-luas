local firstShot = false
local firstTick = 0
local secondTick = 0
local firstMS = 0
local secondMS = 0

local function dtSpeed(event)
    local LocalPlayer = entities.GetLocalPlayer();
	if LocalPlayer:IsAlive() then
        if gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire") == 2 or gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire") == 2 or gui.GetValue("rbot.hitscan.accuracy.scout.doublefire") == 2 or gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire") == 2 or gui.GetValue("rbot.hitscan.accuracy.sniper.doublefire") == 2 or gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire") == 2 then
            if event:GetName() == "weapon_fire" and firstShot == false then
                firstTick = globals.TickCount()
                firstMS = globals.CurTime()
                firstShot = true
            elseif event:GetName() == "weapon_fire" and firstShot == true then
                secondTick = globals.TickCount()
                secondMS = globals.CurTime()
                firstShot = false
            end
        end
    end
end


callbacks.Register("Draw", function()
    draw.TextShadow(5, 45, "Ticks: " .. secondTick - firstTick)
    draw.TextShadow(5, 65, "MS: " .. secondMS - firstMS)
end)

callbacks.Register("FireGameEvent", dtSpeed)