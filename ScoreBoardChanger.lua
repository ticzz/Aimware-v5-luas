-- Scoreboard Changer by stacky

local tPlayerList = {}
local iLastTick = 0

local function setItem(value, propname, index)
    if value ~= "" then entities.GetPlayerResources():SetPropInt(tonumber(value), propname, index) end
end

local function editGUI(guiObject, x, y, width)
    guiObject:SetWidth(width)
    guiObject:SetPosX(x)
    guiObject:SetPosY(y)
end

local function clearGUI(guiObjects)
    for i = 1, #guiObjects do guiObjects[i]:SetValue("") end
end

local guiWINDOW = gui.Window( "scoreboard", "Scoreboard Changer", 300, 300, 360, 370 )
local guiGBOX = gui.Groupbox( guiWINDOW, "Selection", 10, 10, 340, 0 )
local guiPLAYER = gui.Combobox( guiGBOX, "player", "Player", "" )
guiPLAYER:SetWidth(140)
local guiITEM = gui.Combobox( guiGBOX, "item", "Item", "Score", "Other" )
editGUI(guiITEM, 170, 0, 140)

local guiSCORE = gui.Groupbox( guiWINDOW, "Score Changer", 10, 120, 340, 0 )
local guiSCOREKILLS = gui.Editbox( guiSCORE, "kills", "Kills" )
editGUI(guiSCOREKILLS, 0, 0, 90)
local guiSCOREDEATHS = gui.Editbox( guiSCORE, "deaths", "Deaths" )
editGUI(guiSCOREDEATHS, 110, 0, 90)
local guiSCOREASSISTS = gui.Editbox( guiSCORE, "assists", "Assists" )
editGUI(guiSCOREASSISTS, 220, 0, 90)
local guiSCOREMVP = gui.Editbox( guiSCORE, "mvp", "MVP" )
editGUI(guiSCOREMVP, 0, 60, 140)
local guiSCORESCORE = gui.Editbox( guiSCORE, "score", "Score" )
editGUI(guiSCORESCORE, 170, 60, 140)
local guiSCOREAPPLY = gui.Button( guiSCORE, "Apply", function()
    local iPlayerIndex = tPlayerList[guiPLAYER:GetValue() + 1]:GetIndex()
    setItem(guiSCOREKILLS:GetValue(), "m_iKills", iPlayerIndex)
    setItem(guiSCOREDEATHS:GetValue(), "m_iDeaths", iPlayerIndex)
    setItem(guiSCOREASSISTS:GetValue(), "m_iAssists", iPlayerIndex)
    setItem(guiSCOREMVP:GetValue(), "m_iMVPs", iPlayerIndex)
    setItem(guiSCORESCORE:GetValue(), "m_iScore", iPlayerIndex)
    clearGUI({guiSCOREKILLS, guiSCOREDEATHS, guiSCOREASSISTS, guiSCOREMVP, guiSCORESCORE})
end )
guiSCOREAPPLY:SetPosX(90)

local guiOTHER = gui.Groupbox( guiWINDOW, "Other", 10, 120, 340, 0 )
local guiOTHERRANK = gui.Combobox( guiOTHER, "rank", "Rank", unpack({"None","Silver I","Silver 2","Silver III","Silver IV","Silver Elite","Silver Elite Master","Gold Nova I","Gold Nova II","Gold Nova III","Gold Nova Master","Master Guardian I","Master Guardian II","Master Guardian Elite","DMG","Legendary Eagle","Legendary Eagle Master","Supreme Master","Global Elite"}) )
editGUI(guiOTHERRANK, 0, 0, 145)
local guiOTHERPRIVATE = gui.Combobox( guiOTHER, "rank", "Rank", unpack({"None","Private Rank 1","Private Rank 2","Private Rank 3","Private Rank 4","Corporal Rank 5","Corporal Rank 6","Corporal Rank 7","Corporal Rank 8","Sergeant Rank 9","Sergeant Rank 10","Sergeant Rank 11","Sergeant Rank 12","Master Sergeant Rank 13","Master Sergeant Rank 14","Master Sergeant Rank 15","Master Sergeant Rank 16","Sergeant Major Rank 17","Sergeant Major Rank 18","Sergeant Major Rank 19","Sergeant Major Rank 20","Lieutenant Rank 21","Lieutenant Rank 22","Lieutenant Rank 23","Lieutenant Rank 24","Captain Rank 25","Captain Rank 26","Captain Rank 27","Captain Rank 28","Major Rank 29","Major Rank 30","Major Rank 31","Major Rank 32","Colonel Rank 33","Colonel Rank 34","Colonel Rank 35","Brigadier General Rank 36","Major General Rank 37","Lieutenant General Rank 38","General Rank 39","Global General Rank 40"}) )
editGUI(guiOTHERPRIVATE, 165, 0, 145)
local guiOTHERMEDAL = gui.Editbox( guiOTHER, "medal", "Medal" )
editGUI(guiOTHERMEDAL, 0, 60, 145)
local guiOTHERMUSIC = gui.Editbox( guiOTHER, "music", "Music Kit" )
editGUI(guiOTHERMUSIC, 165, 60, 145)
local guiOTHERAPPLY = gui.Button( guiOTHER, "Apply", function()
    local iPlayerIndex = tPlayerList[guiPLAYER:GetValue() + 1]:GetIndex()
    setItem(guiOTHERRANK:GetValue(), "m_iCompetitiveRanking", iPlayerIndex)
    setItem(guiOTHERPRIVATE:GetValue(), "m_nPersonaDataPublicLevel", iPlayerIndex)
    setItem(guiOTHERMEDAL:GetValue(), "m_nActiveCoinRank", iPlayerIndex)
    setItem(guiOTHERMUSIC:GetValue(), "m_nMusicID", iPlayerIndex)
    clearGUI({guiOTHERMEDAL, guiOTHERMUSIC})
end )
guiOTHERAPPLY:SetPosX(90)

callbacks.Register( "Draw", function()
    guiWINDOW:SetActive( gui.Reference("Menu"):IsActive() )

    if guiITEM:GetValue() == 0 then
        guiSCORE:SetInvisible(false)
        guiOTHER:SetInvisible(true)
    else
        guiSCORE:SetInvisible(true)
        guiOTHER:SetInvisible(false)
    end

    if globals.TickCount() > iLastTick then
        tPlayerList = entities.FindByClass( "CCSPlayer" )
        local tPlayerNames = {}
        for i = 1, #tPlayerList do table.insert(tPlayerNames, tPlayerList[i]:GetName()) end
        guiPLAYER:SetOptions(unpack(tPlayerNames))
    end

    iLastTick = globals.TickCount()
end )













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

