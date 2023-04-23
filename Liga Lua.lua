local GUIREF = gui.Reference("Ragebot", "Hitscan", "Maxprocessingtime")
local AIMGROUP = gui.Groupbox(GUIREF, "Aimbot")
local BetterResolver = gui.Checkbox(AIMGROUP, "betterresolver", "Auto Max ScanTime", true)
BetterResolver:SetDescription("Auto adjust the maxprossesingtime and trying to counter FPS drops a bit (if u got drops)")
local function AutoMaxScanTime()
    if(entities.GetLocalPlayer() == nil) then return end

    if(BetterResolver:GetValue()) then
        local CurrentFPS = 1000 / globals.AbsoluteFrameTime()

        if(CurrentFPS < 60 * 1000 and gui.GetValue("rbot.hitscan.maxprocessingtime")) then
            gui.SetValue("rbot.hitscan.maxprocessingtime", gui.GetValue("rbot.hitscan.maxprocessingtime") - 5)
        elseif(CurrentFPS > 60 * 1000 and gui.GetValue("rbot.hitscan.maxprocessingtime")) then
            gui.SetValue("rbot.hitscan.maxprocessingtime", gui.GetValue("rbot.hitscan.maxprocessingtime") + 5)
        end
    end
end

callbacks.Register("Draw", AutoMaxScanTime)







--***********************************************-

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

