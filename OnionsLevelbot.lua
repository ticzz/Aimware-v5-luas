--
-- Discord
-- https://discord.gg/8UQ2qQ5
--

--
-- Variables
--

-- Window
local onion_level_window = gui.Tab(gui.Reference("Settings"), 'onion_level_window', "Onion's Level Bot")

-- Bot Settings
local onion_window_groupbox_1 = gui.Groupbox(onion_level_window, 'Bot Settings', 15, 15)
local onion_level_enabled = gui.Checkbox(onion_window_groupbox_1, 'onion_level_enabled', 'Enabled', true)
local onion_level_autospectate_enabled = gui.Checkbox(onion_window_groupbox_1, 'onion_level_autospectate_enabled', 'Auto Spectate', true)
local onion_level_autospectate_score = gui.Slider(onion_window_groupbox_1, 'onion_level_autospectate_score', 'Spectate Score (300 Max XP)', 300, 0, 1000, 10)
local onion_level_antiafk_enabled = gui.Checkbox(onion_window_groupbox_1, 'onion_level_antiafk_enabled', 'Anti-AFK', true)
local onion_level_antiafk_style = gui.Combobox(onion_window_groupbox_1, 'onion_level_antiafk_style', 'Anti-AFK Style', "Text Refresh")
local onion_level_antiafk_timer = gui.Slider(onion_window_groupbox_1, 'onion_level_antiafk_timer', 'Anti-AFK (Seconds)', 2, 2, 270, 2)
local onion_level_walkbot = gui.Checkbox(onion_window_groupbox_1, 'onion_level_walkbot', 'Walkbot (Out of Order)', false)
local onion_level_namechanger = gui.Checkbox(onion_window_groupbox_1, 'onion_level_namechanger', 'Name Changer', true)
local onion_level_namechanger_timer = gui.Slider(onion_window_groupbox_1, 'onion_level_namechanger_timer', 'Name Change (Seconds)', 2, 1, 24)
local onion_level_autocfg = gui.Button(onion_window_groupbox_1, 'Auto-Config', setConfig)

-- HUD Settings
local onion_window_groupbox_2 = gui.Groupbox(onion_level_window, 'HUD Settings', 15, 505)
local onion_level_hud_enabled = gui.Checkbox(onion_window_groupbox_2, 'onion_level_hud_enabled', 'Enabled', true)
local onion_level_hud_enabled_ingame = gui.Checkbox(onion_window_groupbox_2, 'onion_level_hud_enabled_ingame', 'In-Game Check', false)
local onion_level_hud_position_y = gui.Slider(onion_window_groupbox_2, 'onion_level_hud_position_y', 'Y Offset', 15, 0, 200, 5)
local onion_level_hud_position = gui.Combobox(onion_window_groupbox_2, 'onion_level_hud_position', 'HUD Position', "Bottom", "Top")

-- Variables
local playerResources
local localplayer
local username = ""
local ping = 0
local tick = 64
local score = 0
local kills = 0
local deaths = 0
local isSpectating = false
local initial = true
local scrW, scrH = 0, 0
local savedTick = 0
local currentTick = 0
local disabled = false
local currentAfkWait = 0
local currentTeam = 1
local nameChangeTimer = 0
local invisibleName = false
local textFont = draw.CreateFont( "Verdana", 13 )

--
-- Misc Functions
--

function setConfig()

end

--
-- Drawing Functions
--

function drawFilledRect(color, x, y, width, height, radius)
    local r, g, b, a = color[1], color[2], color[3], color[4]
    draw.Color(r, g, b, a)
    
    if (radius > 0) then
        draw.RoundedRectFill(x, y, x + width, y + height, radius)
    else
        draw.FilledRect(x, y, x + width, y + height)   
    end
end

function drawOutlinedRect(color, x, y, width, height, radius)
    local r, g, b, a = color[1], color[2], color[3], color[4]
    draw.Color(r, g, b, a)
    
    if (radius > 0) then
        draw.RoundedRect(x, y, x + width, y + height, radius)
    else
        draw.OutlinedRect(x, y, x + width, y + height)   
    end
end

function drawText(color, x, y, font, str)
    local r, g, b, a = color[1], color[2], color[3], color[4]
	draw.Color(r, g, b, a)
	draw.SetFont(font)
	draw.Text(x, y, str)
end

function renderHud(yOffset, style, str)
    local colorTransparent = { 40, 40, 40, 150 }
    local colorFull = { 40, 40, 40, 255 }
    local colorText = { 255, 255, 255, 255 }

    draw.SetFont(textFont)
    local textW, textH = draw.GetTextSize(str)

    if (style == 0) then
        drawFilledRect(colorTransparent, 0, scrH - (textH + 9 + yOffset), scrW, textH + 8, 0)
        drawFilledRect(colorFull, 0, scrH - ((2 + (textH + 8)) + yOffset), scrW, 1, 0)
        drawFilledRect(colorFull, 0, scrH - (1 + yOffset), scrW, 1, 0)
        drawText(colorText, (scrW / 2) - (textW / 2), scrH - (textH + 6 + yOffset), textFont, str)
    else
        drawFilledRect(colorTransparent, 0, yOffset + 1, scrW, textH + 8, 0)
        drawFilledRect(colorFull, 0, yOffset, scrW, 1, 0)
        drawFilledRect(colorFull, 0, yOffset + (textH + 9), scrW, 1, 0)
        drawText(colorText, (scrW / 2) - (textW / 2), yOffset + 4, textFont, str)
    end
end

--
-- Callback Functions
--

function gatherVariables()
    if (initial) then
        initial = false
        disabled = false
        scrW, scrH = draw.GetScreenSize()
        savedTick = globals.TickCount()
    end

    localPlayer = entities.GetLocalPlayer()
    playerResources = entities.GetPlayerResources()
    currentTick = globals.TickCount()   
    
    if (localPlayer ~= nil) then
        currentTeam = localPlayer:GetPropInt("m_iTeamNum")
        ping = playerResources:GetPropInt("m_iPing", localPlayer:GetIndex())
        tick = client.GetConVar("sv_maxcmdrate")
        username = client.GetPlayerNameByIndex(client.GetLocalPlayerIndex())
        score = playerResources:GetPropInt("m_iScore", localPlayer:GetIndex())
        kills = playerResources:GetPropInt("m_iKills", localPlayer:GetIndex())
        deaths = playerResources:GetPropInt("m_iDeaths", localPlayer:GetIndex())

        if (currentTeam == 1) then
            isSpectating = true
        else
            isSpectating = false
        end
    else
        currentTeam = 0
        isSpectating = false
        score = 0
        tick = 0
        ping = 0
        kills = 0
        deaths = 0
        currentAfkWait = 0
        disabled = false
        username = ""
        savedTick = currentTick
        invisibleName = false
    end
end

function useTheDamnVariables()
    if (onion_level_hud_enabled:GetValue()) then
        if (onion_level_hud_enabled_ingame:GetValue()) then
            if (localPlayer == nil) then
                return
            end
        end

        local yOffset = onion_level_hud_position_y:GetValue()
        local hudPos = onion_level_hud_position:GetValue()
        local hudText = "Not Ingame"

        if (localPlayer ~= nil) then
            hudText = "Ping: " .. ping .. "ms | Tickrate: " .. tick .. " | Username: " .. username .. " | Score: " .. score .. " | Kills: " .. kills .. " | Deaths: " .. deaths

            if (isSpectating) then
                hudText = hudText .. " | Anti-AFK Time: " .. math.floor(currentAfkWait) .. " Seconds"
            end
        end

        if (hudPos == 0) then
            renderHud(yOffset, 0, hudText)
        else
            renderHud(yOffset, 1, hudText)
        end
    end

    if (onion_level_namechanger:GetValue()) then
        if (localPlayer ~= nil) then
            if (invisibleName == false) then
                if (currentTick - savedTick > tick / 2) then
                    invisibleName = true
                    client.SetConVar("name", "\n\xAD\xAD\xAD")
                    savedTick = currentTick
                end
            else
                if (isSpectating == false) then
                    if (currentTick - nameChangeTimer > tick * onion_level_namechanger_timer:GetValue()) then
                        local teamNames = { }

                        for i = globals.MaxClients(), 1, -1 do
                            if (i ~= client.GetLocalPlayerIndex()) then
                                local team = playerResources:GetPropInt("m_iTeam", i)
                                if (localPlayer:GetTeamNumber() == team) then
                                    local name = client.GetPlayerNameByIndex(i)
                                    table.insert(teamNames, name)
                                end
                            end
                        end

                        if (teamNames ~= nil) then
                            client.SetConVar("name", teamNames[math.random(#teamNames)] .. " ")
                        end

                        nameChangeTimer = currentTick
                        return
                    end
                end
            end
        end
    end

    if (onion_level_enabled:GetValue()) then
        if (onion_level_autospectate_enabled:GetValue()) then
            if (isSpectating ~= true and disabled ~= true) then
                if (localPlayer ~= nil) then
                    if (score >= onion_level_autospectate_score:GetValue()) then
                        if (currentTick - savedTick > (tick / 2)) then
                            client.Command( "jointeam 1" )
                            savedTick = currentTick
                        end
                    end
                end
            end
        end
    
        local fuckVariableNaming = onion_level_antiafk_timer:GetValue()

        if (onion_level_antiafk_enabled:GetValue()) then
            if (isSpectating) then
                if (currentTick - savedTick > tick * fuckVariableNaming) then
                    client.ChatSay("Onion's Level Bot - discord.gg/8UQ2qQ5")
                    savedTick = currentTick
                    disabled = false
                else
                    currentAfkWait = (((tick * fuckVariableNaming) - (currentTick - savedTick)) / 60)
                end
            end
        end
    end
end

--
-- Callbacks
--

callbacks.Register('Draw', gatherVariables);
callbacks.Register('Draw', useTheDamnVariables)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

