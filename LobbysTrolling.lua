local errorMessagePrefix = "#SFUI_QMM_ERROR_"

local Lobby = {
    DefaultChatMessage = "hi",
    TrustFactorData = {
        [0] = "-",
        [1] = "-",
        [2] = "-",
        [3] = "-",
        [4] = "-"
    },
    BadTypes = {
        "Ear Rape [1]",
        "Ear Rape [2]",
        "Mass Popup"
    },
	MessageTypes = {
		"Chat",
		"Error",
		"Invite",
		"Start/Stop Queue",
		"Popup Window",
		"Ear Rape [1]",
		"Ear Rape [2]",
		"Mass Popup"
	},
	MessageColours = {
		"Red",
		"Green",
		"Yellow"
	},
	AutoStopMessages = {
		"X_VacBanned",
		"X_PenaltySeconds",
		"X_InsecureBlocked",
		"SkillGroupLargeDelta"
	},
    ErrorMessages = {
        "1_FailPingServer",
        "1_FailReadyUp",
        "1_FailReadyUp_Title",
        "1_FailVerifyClan",
        "1_FailVerifyClan_Title",
        "1_InsufficientLevel",
        "1_InsufficientLevel02",
        "1_InsufficientLevel03",
        "1_InsufficientLevel04",
        "1_InsufficientLevel05",
        "1_NotLoggedIn",
        "1_NotVacVerified",
        "1_OngoingMatch",
        "1_PenaltySeconds",
        "1_PenaltySecondsGreen",
        "1_VacBanned",
        "1_VacBanned_Title",
        "ClientBetaVersionMismatch",
        "ClientUpdateRequired",
        "FailedToPingServers",
        "FailedToReadyUp",
        "FailedToSetupSearchData",
        "FailedToVerifyClan",
        "InvalidGameMode",
        "NoOngoingMatch",
        "NotLoggedIn",
        "NotVacVerified",
        "OperationPassInvalid",
        "OperationQuestIdInactive",
        "PartyRequired1",
        "PartyRequired2",
        "PartyRequired3",
        "PartyRequired4",
        "PartyRequired5",
        "PartyTooLarge",
        "SkillGroupLargeDelta",
        "SkillGroupMissing",
        "TournamentMatchInvalidEvent",
        "TournamentMatchNoEvent",
        "TournamentMatchRequired",
        "TournamentMatchSetupNoTeam",
        "TournamentMatchSetupSameTeam",
        "TournamentMatchSetupYourTeam",
        "TournamentTeamAccounts",
        "TournamentTeamSize",
        "UnavailMapSelect",
        "VacBanned",
        "X_AccountWarningNonPrime",
        "X_AccountWarningTrustMajor",
        "X_AccountWarningTrustMajor_Summary",
        "X_AccountWarningTrustMinor",
        "X_FailPingServer",
        "X_FailReadyUp",
        "X_FailVerifyClan",
        "X_InsecureBlocked",
        "X_InsufficientLevel",
        "X_InsufficientLevel02",
        "X_InsufficientLevel03",
        "X_InsufficientLevel04",
        "X_InsufficientLevel05",
        "X_NotLoggedIn",
        "X_NotVacVerified",
        "X_OngoingMatch",
        "X_PenaltySeconds",
        "X_PenaltySecondsGreen",
        "X_PerfectWorldDenied",
        "X_PerfectWorldRequired",
        "X_VacBanned"
    }
}

panorama.RunScript([[
    function call_x_times(times, callback) {
        for (var i = 1; i <= times; i++){
            callback();
        }
    }

    if (!LobbyAPI.IsSessionActive()) { 
        LobbyAPI.CreateSession(); 
    }

    function stopCustomEvents() {
        if (waitForSearchingEventHandler) {
            $.UnregisterForUnhandledEvent( 'PanoramaComponent_Lobby_MatchmakingSessionUpdate', waitForSearchingEventHandler);
        }
    }
]])

local MainRef = gui.Reference("Settings")
local LFTab = gui.Tab(MainRef, "LF.tab", "Lobby Troll")
local LFGroupbox1 = gui.Groupbox(LFTab, "Queue Manipulation", 16, 16, 296)
local LFGroupbox2 = gui.Groupbox(LFTab, "Lobby Chat", 328, 16, 296)

local targetSlider = gui.Slider(LFGroupbox1, "LF.targetSlider", "Select Target", 1, 1, 5)

local trustMessageOnSearch = gui.Checkbox(LFGroupbox1, "LF.trustMessageOnSearch", "Trust Message on Search", false);
local trustNotification = gui.Combobox(LFGroupbox1, "LF.trustNotification", "Trust Message", "-", "Yellow", "Red")

local autoStopQueue = gui.Checkbox(LFGroupbox1, "LF.autoStopQueue", "Auto Stop Queue", false)
local autoStopQueueSilent = gui.Checkbox(LFGroupbox1, "LF.autoStopQueueSilent", "Silent", false)
local autoStopQueueMessage = gui.Combobox(LFGroupbox1, "LF.autoStopQueueMessage", "Queue Error", unpack(Lobby.AutoStopMessages))

local loopMessages = gui.Checkbox(LFGroupbox2, "LF.loopMessages", "Loop Messages", false)
local loopMsgDelay = gui.Slider(LFGroupbox2, "LF.loopMsgDelay", "Spam Delay", 250, 1, 1000)
local loopMsgAmt = gui.Slider(LFGroupbox2, "LF.loopMsgAmt", "Spam Per Loop", 1, 1, 200)

local messageType = gui.Combobox(LFGroupbox2, "LF.messageType", "Message Type", unpack(Lobby.MessageTypes))
local errorList = gui.Listbox(LFGroupbox2, "LF.errorList", 200, unpack(Lobby.ErrorMessages))
local messageText = gui.Editbox(LFGroupbox2, "LF.messageText", "Message Text")
local messageColour = gui.Combobox(LFGroupbox2, "LF.messageColour", "Message Colour", unpack(Lobby.MessageColours))

local randomError = gui.Checkbox(LFGroupbox2, "LF.randomError", "Random Error Message", false)

-- hi :^)
local function trustFactorArrayToString()
    local str = "["
    for _, v in pairs(Lobby.TrustFactorData) do
        str = str .. "'" .. v .. "',"
    end
    return str .. "];"
end

-- ik this is horrible practise but I can't think of any other way to do it
local function buildJSFuncs()
    panorama.RunScript([[
        stopCustomEvents();

        var doSearchMessages = function(msg) {
            if (LobbyAPI.GetMatchmakingStatusString() == "#SFUI_QMM_State_find_searching") {
                if (]] .. tostring(trustMessageOnSearch:GetValue()) .. [[ == true) {
                    let trustFactorData = ]] .. trustFactorArrayToString() .. [[
                    let sendTrustMsg = false;
                    $.Msg("Searching called for trust msg")
        
                    for (let i = 0; i < trustFactorData.length; i++) {
                        let trustOption = trustFactorData[i];
        
                        if (trustOption != "-") {
                            let userXUID = PartyListAPI.GetXuidByIndex(i);
                            
                            if (trustOption == "Red") {sendTrustMsg = true;}
            
                            let msgType = (trustOption == "Red") ? "ChatReportError" : "ChatReportYellow";
                            let msgCol = (trustOption == "Red") ? "error" : "yellow";
                            let trustMessage = (trustOption == "Red") ? "X_AccountWarningTrustMajor" : "X_AccountWarningTrustMinor";
            
                            PartyListAPI.SessionCommand(`Game::${msgType}`, `run all xuid ${userXUID} ${msgCol} ]] .. errorMessagePrefix .. [[${trustMessage}`);
                        }
                    }
            
                    if (sendTrustMsg) {
                        PartyListAPI.SessionCommand('Game::ChatReportError', `run all xuid ${MyPersonaAPI.GetXuid()} error ]] .. errorMessagePrefix .. [[X_AccountWarningTrustMajor_Summary `);
                    }
                }

                if (]] .. tostring(autoStopQueue:GetValue()) .. [[ == true) {
                    let target = (LobbyAPI.BIsHost()) ? PartyListAPI.GetXuidByIndex(]] .. (targetSlider:GetValue() - 1) .. [[) : MyPersonaAPI.GetXuid();

                    if (]] .. tostring(autoStopQueueSilent:GetValue()) .. [[ == false) {
                        PartyListAPI.SessionCommand('Game::ChatReportError', `run all xuid ${target} error ]] .. errorMessagePrefix .. Lobby.AutoStopMessages[autoStopQueueMessage:GetValue()+1] .. [[`);
                    }

                    LobbyAPI.StopMatchmaking();
                }
            }
        }

        var waitForSearchingEventHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_Lobby_MatchmakingSessionUpdate', doSearchMessages);
    ]])
end

errorList:SetInvisible(true)
messageColour:SetInvisible(true)
randomError:SetInvisible(true)

loopMsgAmt:SetInvisible(true)
loopMsgDelay:SetInvisible(true)
trustNotification:SetInvisible(true)

messageText:SetValue(Lobby.DefaultChatMessage)

autoStopQueueSilent:SetValue(true)
autoStopQueueSilent:SetInvisible(true)
autoStopQueueMessage:SetInvisible(true)

local originalValue = {}
originalValue[autoStopQueueMessage] = autoStopQueueMessage:GetValue()
originalValue[autoStopQueueSilent] = autoStopQueueSilent:GetValue()
originalValue[autoStopQueue] = autoStopQueue:GetValue()
originalValue[targetSlider] = targetSlider:GetValue()
originalValue[trustMessageOnSearch] = trustMessageOnSearch:GetValue()
originalValue[trustNotification] = trustNotification:GetValue()
originalValue[loopMessages] = loopMessages:GetValue()
originalValue[randomError] = randomError:GetValue()
originalValue[messageType] = messageType:GetValue()
callbacks.Register("Draw", "LF.Draw", function()
    if ( autoStopQueueMessage:GetValue() ~= ( originalValue[autoStopQueueMessage] == nil and '' or originalValue[autoStopQueueMessage] ) ) then 
		buildJSFuncs()
		originalValue[autoStopQueueMessage] = autoStopQueueMessage:GetValue()
	end
	
    if ( autoStopQueueSilent:GetValue() ~= ( (originalValue[autoStopQueueSilent] == nil and '' or originalValue[autoStopQueueSilent]) ) ) then -- True to false
		autoStopQueueMessage:SetInvisible(autoStopQueueSilent:GetValue()) -- false (Visible)
		buildJSFuncs()
		originalValue[autoStopQueueSilent] = autoStopQueueSilent:GetValue()
	end
	
    if ( autoStopQueue:GetValue() ~= ( originalValue[autoStopQueue] == nil and '' or originalValue[autoStopQueue] ) ) then
		autoStopQueueSilent:SetInvisible(not autoStopQueue:GetValue())
		autoStopQueueMessage:SetInvisible(not (autoStopQueue:GetValue() and not autoStopQueueSilent:GetValue()))
		buildJSFuncs()
		originalValue[autoStopQueue] = autoStopQueue:GetValue()
	end
	
    if ( targetSlider:GetValue() ~= ( originalValue[targetSlider] == nil and '' or originalValue[targetSlider] ) ) then
		trustNotification:SetValue(Lobby.TrustFactorData[targetSlider:GetValue() - 1])
		buildJSFuncs()
		originalValue[targetSlider] = targetSlider:GetValue()
	end
	
    if ( trustMessageOnSearch:GetValue() ~= ( originalValue[trustMessageOnSearch] == nil and '' or originalValue[trustMessageOnSearch] ) ) then
		trustNotification:SetInvisible(not trustMessageOnSearch:GetValue())
		
		buildJSFuncs()
		originalValue[trustMessageOnSearch] = trustMessageOnSearch:GetValue()
	end
	
    if ( trustNotification:GetValue() ~= ( originalValue[trustNotification] == nil and '' or originalValue[trustNotification] ) ) then
		if (Lobby.TrustFactorData[targetSlider:GetValue() - 1] ~= trustNotification:GetValue()) then
			Lobby.TrustFactorData[targetSlider:GetValue() - 1] = trustNotification:GetValue()
			buildJSFuncs()
		end
		
		originalValue[trustNotification] = trustNotification:GetValue()
	end
	
    if ( loopMessages:GetValue() ~= ( originalValue[loopMessages] == nil and '' or originalValue[loopMessages] ) ) then
		local bool = not loopMessages:GetValue()
		loopMsgDelay:SetInvisible(bool)
		loopMsgAmt:SetInvisible(bool)
		originalValue[loopMessages] = loopMessages:GetValue()
	end
	
    if ( randomError:GetValue() ~= ( originalValue[randomError] == nil and '' or originalValue[randomError] ) ) then
		errorList:SetInvisible(randomError:GetValue())
		originalValue[randomError] = randomError:GetValue()
	end
	
    if ( messageType:GetValue() ~= ( originalValue[messageType] == nil and '' or originalValue[messageType] ) ) then
		local MessageValue = Lobby.MessageTypes[messageType:GetValue()+1]
		local showErrorStuff = (MessageValue ~= 'Error')
		
		messageColour:SetInvisible(showErrorStuff)
		randomError:SetInvisible(showErrorStuff)
		
		messageText:SetInvisible(MessageValue ~= 'Chat')
		
		if (randomError:GetValue()) then
			errorList:SetInvisible(randomError:GetValue())
		else
			errorList:SetInvisible(showErrorStuff)
		end
		
		originalValue[messageType] = messageType:GetValue()
	end
end)


local function randomErrorMessage()
    return Lobby.ErrorMessages[ math.random(1, #Lobby.ErrorMessages) ]
end

local function getMessageToSend()
    local messageType, col = Lobby.MessageTypes[messageType:GetValue()+1], Lobby.MessageColours[messageColour:GetValue()+1]
    local message = "PartyListAPI.SessionCommand('Game::"
    local target = '(LobbyAPI.BIsHost()) ? PartyListAPI.GetXuidByIndex(' .. (targetSlider:GetValue() - 1) .. ') : MyPersonaAPI.GetXuid()'
    local extraMessage = ""

    if (messageType == "Chat") then
        message = message .."Chat"
        extraMessage = string.gsub(messageText:GetValue(), " ", " ") -- if we dont replace regular space with invisible character we cant have spaces in msg :^(
        col = "chat"
    elseif (messageType == "Error") then
        if (col == "Red") then
            message = message .. "ChatReportError"
            col = "error"
        elseif (col == "Green") then
            message = message .. "ChatReportGreen"
        else -- must be yellow
            message = message .. "ChatReportYellow"
        end

        if (randomError:GetValue()) then
            extraMessage = errorMessagePrefix .. randomErrorMessage()
        else
            extraMessage = errorMessagePrefix .. Lobby.ErrorMessages[errorList:GetValue() + 1]
        end
    elseif (messageType == "Invite") then
        message = message .. "ChatInviteMessage"
        target = "MyPersonaAPI.GetXuid()"
        col = "friend"
        extraMessage = "${FriendsListAPI.GetXuidByIndex((Math.random() * (FriendsListAPI.GetCount() - 1) + 1))}"
    elseif (messageType == "Start/Stop Queue") then
        return "LobbyAPI.StartMatchmaking( '', '', '', '' );LobbyAPI.StopMatchmaking();", messageType
    elseif (messageType == "Popup Window") then
        message = message .. "HostEndGamePlayAgain"
        col = "error"
    elseif (messageType == "Ear Rape [1]") then
        return 'call_x_times(' .. loopMsgAmt:GetValue() .. ', ()=>{ LobbyAPI.StartMatchmaking( "", "", "", "" );LobbyAPI.StopMatchmaking(); });', messageType
    elseif (messageType == "Ear Rape [2]") then
        return 'call_x_times(' .. loopMsgAmt:GetValue() .. ', ()=>{ PartyListAPI.SessionCommand("Game::Chat", `run all xuid ${MyPersonaAPI.GetXuid()} name ${MyPersonaAPI.GetName()} chat `); });', messageType
    else -- must be Mass Popup
		timerCreate("CloseAllVisiblePopups", 0.5, 1, function() panorama.RunScript([[UiToolkitAPI.CloseAllVisiblePopups();]]) end)
        return 'call_x_times(' .. loopMsgAmt:GetValue() .. ', ()=>{ PartyListAPI.SessionCommand("Game::HostEndGamePlayAgain", `run all xuid ${MyPersonaAPI.GetXuid()}`); });', messageType
    end

    message = message .. "', `run all xuid ${" .. target.. "} " .. col .. " " .. extraMessage .. "`);"

    return message, messageType
end


local timers = {}
local function timerCreate(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

local function timerRemove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

local function timerTick()
    for k,v in pairs(timers or {}) do
        if (v["times"] <= 0) then table.remove(timers, k) end
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then 
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]() 
        end
    end
end

callbacks.Register( "Draw", "timerTick", timerTick);

local function isGoodType(type)
    for _, v in ipairs(Lobby.BadTypes) do
        if (v == type) then
            return false
        end
    end

    return true
end

function sendJSMessage()
    local msg, type = getMessageToSend()
	
    if (loopMessages:GetValue() and isGoodType(type)) then
        panorama.RunScript([[
            call_x_times(]] .. loopMsgAmt:GetValue() .. [[, ()=>{
                ]] .. msg .. [[
            });
        ]])
		
		print('pre-timer')
		timerCreate("loopMsgDelay", loopMsgDelay:GetValue() / 1000, 1, sendJSMessage)
    else
        panorama.RunScript([[
            ]] .. msg .. [[
        ]])
    end

    if (type == "Popup Window") then
        panorama.RunScript([[UiToolkitAPI.CloseAllVisiblePopups();]])
    end
end

buildJSFuncs()

gui.Button(LFGroupbox2, 'Force Clear Popups', function()
    panorama.RunScript([[UiToolkitAPI.CloseAllVisiblePopups();]])
end)

gui.Button(LFGroupbox2, 'Execute Message', function()
	sendJSMessage() -- Tried to do this inline, but didnt work, so wrapping it.
end)