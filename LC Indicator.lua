--- GUI Stuff
local ENABLED = gui.Checkbox(gui.Tab(gui.Reference("Visuals"), "localtab", "Helper"), "esp.local.lagcompindicator", "Lagcompensation Indicator", false)

--- API Localization
setFont = draw.SetFont
createFont = draw.CreateFont
getScreenSize = draw.GetScreenSize
getLocal = entities.GetLocalPlayer
color = draw.Color
text = draw.TextShadow

--- Variables
local originRecords = {}
local font = createFont("Verdana", 20, 1000)

local function ReCheckEvent(Event)

if Event:GetName() ~= "round_start" then return end

end

local function drawHook()

    setFont(font)

    if ENABLED:GetValue() then
        local screenX, screenY = getScreenSize()
        if getLocal() then
            if getLocal():IsAlive() then
                if originRecords[1] ~= nil and originRecords[2] ~= nil then
                    local delta = Vector3(originRecords[2].x - originRecords[1].x, originRecords[2].y - originRecords[1].y, originRecords[2].z - originRecords[1].z)
                    delta = delta:Length2D()^2
                    if delta > 4096 then
                        color(255, 25, 25, 255)
                    else
                        color(124, 176, 34)
                    end
                    text(16, screenY-45, "LC")
                    if originRecords[3] ~= nil then
                        table.remove(originRecords, 1)
                    end
                end
            end
        end
    end
end

local function createMoveHook(cmd)
    if ENABLED:GetValue() then
        if getLocal() then
            if getLocal():IsAlive() then
                if cmd.sendpacket then
                    table.insert(originRecords, entities.GetLocalPlayer():GetAbsOrigin())
                end
            end
        end
    end
end

client.AllowListener("round_start")
callbacks.Register("Draw", drawHook)
callbacks.Register("CreateMove", createMoveHook)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

