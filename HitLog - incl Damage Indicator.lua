--
-- GUI Variables
--

local window = gui.Tab(gui.Reference("Settings"), 'window_hud', "Onion's HUD")
local groupbox_1 = gui.Groupbox(window, 'Settings', 15, 15)
local huds_enabled = gui.Checkbox(groupbox_1, 'huds_enabled', 'HUDs', true)
local groupbox_2 = gui.Groupbox(groupbox_1, 'Enabled HUDs', 0, 35)
local huds_damagelog = gui.Checkbox(groupbox_2, 'huds_damagelog', 'Damage Logs', true)
local huds_damagelog_max = gui.Slider(groupbox_2, 'huds_damagelog_max', 'HUD Log Max', 5, 1, 20, 1)
local huds_damagelog_string_max = gui.Slider(groupbox_2, 'huds_damagelog_string_max', 'Max String Length', 20, 1, 100, 1)
local style = gui.Combobox(groupbox_2, 'drawposition_styles', 'Drawposition Style', 'Default | No Style', 'Centered w and h', 'Centered on h only')
--
-- Some rando vars
--

local barFont = draw.CreateFont( "Tahoma", 18 )
local textFont = draw.CreateFont( "Tahoma", 16 )

local scrW, scrH = 0, 0
local localPlayer, playerResources
local initialize = false
local hitboxIDTable = { "0", "1", "2", "3", "4", "5", "6", "7", "10" }
local hitboxNameTable = { "Body", "Head", "Chest", "Stummy", "Arms", "Arms", "Legs", "Legs", "Body" }
local recentHits = {  }

local mouseState = "none"
local mouseX, mouseY = 0, 0
local mouseDownPosX, mouseDownPosY = 0, 0
local mouseDown = "none"

local damageLogX, damageLogY = 0, 0

--
-- dumb drawing functions for lazy people
--

function drawFilledRect(r, g, b, a, x, y, width, height)
    draw.Color(r, g, b, a)
    draw.FilledRect(x, y, x + width, y + height)
end

function drawText(r, g, b, a, x, y, font, str, style)
    draw.Color(r, g, b, a)
    draw.SetFont(font)

    local textW, textH = draw.GetTextSize(str)

    -- Style 1 is Centered on Width and Height // Style 2 is Centered on Height // Style 0 or no style is default
    if (style == 1) then
        draw.Text(x - (textW / 2), y - (textH / 2), str)
    elseif (style == 2) then
        draw.Text(x, y - (textH / 2), str)
    else
        draw.Text(x, y, str)
    end
   
    return { textW, textH }
end

--
-- Reeree functions
--

function whereTFDidIHit(hitBox)
    for i = 1, #hitboxIDTable do
        if (hitboxIDTable[i] == tostring(hitBox)) then
            return hitboxNameTable[i]
        end
    end
    -- Remember hitting stummy is for pros
end

function addToTable(id, name, damage, hitBox, tableMax)
    table.insert(recentHits, { tostring(id), tostring(name), tostring(damage), tostring(hitBox) })

    if (#recentHits > tableMax) then
        local removals = #recentHits - tableMax

        for i = 1, removals do
            table.remove(recentHits, 1)
        end
    end
    -- pretty code is a no go anymore so smd :clown:
end

function returnCharTable(string)
    local charList = {}

    for char in string:gmatch(".") do
        table.insert(charList, char)
    end

    return charList
end

function capStringLength(string, max)
    local finishedStr = ""
    local charList = returnCharTable(string)

    if (#charList > max) then
        for i = 1, max do
            finishedStr = finishedStr .. charList[i]
        end
    else
        finishedStr = string
    end

    return finishedStr
end

function returnTextSize(string, font)
    draw.SetFont(font)
    local textW, textH = draw.GetTextSize(string)

    return { textW, textH }
end

--
-- Some callback functions
--

function gatherVariables()
    if (initialize == false) then
        initialize = true
        scrW, scrH = draw.GetScreenSize()
    end
   
    mouseX, mouseY = input.GetMousePos()
    localPlayer = entities.GetLocalPlayer()
    playerResources = entities.GetPlayerResources()

    if (localPlayer == nil) then
        recentHits = {}
    end

    if (input.IsButtonDown("Mouse1")) then
        mouseState = "down"
        if (mouseDownPosX == 0 and mouseDownPosY == 0) then
            mouseDownPosX, mouseDownPosY = mousePosX, mousePosY
        end
    elseif (input.IsButtonReleased("Mouse1")) then
        mouseState = "released"
        mouseDownPosX, mouseDownPosY = 0, 0
        mouseDown = false
    else
        mouseState = "none"
        mouseDownPosX, mouseDownPosY = 0, 0
        mouseDown = false
    end
end

function drawHUDs()
    if (huds_enabled:GetValue()) then
        if (huds_damagelog:GetValue()) then
            local width, height = 0, 0
            local tableElements = { "ID", "Name", "Damage", "Hitbox" }
            local tableElementsSize = {}
            local paddingW, paddingH = 5, 4
            local textDistance = 4

            draw.SetFont(barFont)

            for i = 1, #tableElements do
                local textW, textH = draw.GetTextSize(tableElements[i])

                if (textH > height) then
                    height = textH
                end

                table.insert(tableElementsSize, textW)
            end

            draw.SetFont(textFont)

            if (#recentHits ~= 0) then
                for i = 1, #recentHits do
                    for f = 1, #recentHits[i] do
                        local textW, textH = draw.GetTextSize(capStringLength(recentHits[i][f], huds_damagelog_string_max:GetValue()))

                        if (textW > tableElementsSize[f]) then
                            tableElementsSize[f] = textW
                        end
                    end
                end
            else
                for i = 1, #tableElementsSize do

                end
            end

            for i = 1, #tableElementsSize do
                width = width + textDistance + tableElementsSize[i]
            end

            drawFilledRect(66, 135, 245, 180, damageLogX, damageLogY, width + (paddingW * 2), height + (paddingH * 2))
            local usedW = 0
            local usedH = height + (paddingH * 2)

            for i = 1, #tableElements do
                if (i == 1) then
                    drawText(255, 255, 255, 255, damageLogX + paddingW, damageLogY + paddingH + (height / 2), barFont, tableElements[i], 3)
                else
                    drawText(255, 255, 255, 255, damageLogX + paddingW + usedW + textDistance + (tableElementsSize[i - 1]), damageLogY + paddingH + (height / 2), barFont, tableElements[i], 3)
                    usedW = usedW + textDistance + tableElementsSize[i - 1]
                end
            end

            if (#recentHits ~= 0) then
                for i = 1, #recentHits do
                    drawFilledRect(20, 20, 20, 180, damageLogX, damageLogY + usedH + 6, width + (paddingW * 2), height + (paddingH * 2))
                    local usedWHitLog = 0

                    for f = 1, #recentHits[i] do
                        local returnedSize = {}

                        if (f == 1) then
                            returnedSize = drawText(255, 255, 255, 255, damageLogX + paddingW, damageLogY + usedH + paddingH + 6, textFont, capStringLength(recentHits[i][f], huds_damagelog_string_max:GetValue()), 1)
                        else
                            returnedSize = drawText(255, 255, 255, 255, damageLogX + paddingW + usedWHitLog, damageLogY + usedH + paddingH + 6, textFont, capStringLength(recentHits[i][f], huds_damagelog_string_max:GetValue()), 1)
                        end

                        if (returnedSize[1] > tableElementsSize[f]) then
                            usedWHitLog = usedWHitLog + returnedSize[1] + paddingW
                        else
                            usedWHitLog = usedWHitLog + tableElementsSize[f] + paddingW
                        end
                    end

                    usedH = usedH + height + (paddingH * 2) + 6
                end
            end

            if (mouseState == "down") then
                if (mouseDown == "none") then
                    if (mouseX >= damageLogX and mouseX <= (damageLogX + width) and mouseY >= damageLogY and mouseY <= (damageLogY + usedH)) then
                        mouseDown = "first"
                        mouseDownPosX, mouseDownPosY = mouseX - damageLogX, mouseY - damageLogY
                    end
                end
            else
                mouseDown = "none"
            end
       
            if (mouseDown == "first") then
                damageLogX, damageLogY = mouseX - mouseDownPosX, mouseY - mouseDownPosY
            end
        end
       

    end
end

callbacks.Register( 'FireGameEvent', function(penis)
    local entity = penis:GetName()

    if (entity ~= 'player_hurt' or localPlayer == nil) then
        return
    end

    local entityID = entities.GetByUserID(penis:GetInt('userid'))

    if (entityID == nil) then
        return
    end

    local attacker = entities.GetByUserID(penis:GetInt('attacker'))
    local damage = penis:GetInt('dmg_health')

    if (attacker == nil or localPlayer:GetIndex() ~= attacker:GetIndex()) then
        return
    end

    addToTable(entityID:GetIndex(), entityID:GetName(), damage, whereTFDidIHit(penis:GetInt('hitgroup')), huds_damagelog_max:GetValue())
    print("You hit " ..  entityID:GetName() .. " or ID " .. entityID:GetIndex() .. " for " .. damage .. "hp in the " .. whereTFDidIHit(penis:GetInt('hitgroup')) .. ".")
end);

-- the callbacks :clown:
callbacks.Register('Draw', gatherVariables);
callbacks.Register('Draw', drawHUDs)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

