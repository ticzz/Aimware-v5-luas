-- CREDITS:
-- Chat Automation by ShadyRetard
-- Onetap improvement by Sultao

local CHAT_SAVE_FILE_NAME = "chat_data.dat";
local ref = gui.Reference("MISC")
local tabz = gui.Tab(ref, "chat_automation_tab", "Chat Automations")
local CHAT_CB = gui.Checkbox(tabz, "chat_automations_chkbox", "Chat Automation", false);
local show, pressed = false, true
local hits = {};

local last_message = globals.TickCount();
local spammer_enable, spammer_speed = false, 22;
local messages = {
    ["spam"] = {},
    ["kill"] = {},
    ["death"] = {},
    ["onetap"] = {}
};

local kill_enable = false;
local onetap_enable = false;
local death_enable = false;
local should_load_data = true;

-- Just open up the file in append mode, should create the file if it doesn't exist and won't override anything if it does
local my_file = file.Open(CHAT_SAVE_FILE_NAME, "a");
my_file:Close();

local function drawMenu()
    if (should_load_data) then
        loadData();
        should_load_data = false;
    end

    if (show and pressed) then
        mgui.max_component(10, 100);
        mgui.menu(300, 340, 340, 690, "Chat Automation", 1);

        mgui.panel(350, 15, 120, 330, "Message addition", 1, 1);
        local message_add_edit = mgui.edit(360, 25, 300, "Your custom message", "", 2, 1);
        local message_add_index, message_add_text = mgui.itembox(360, 65, 300, "Message type", { "Chat Spammer", "Kill Say", "Death Say", "Onetap say" }, 1, 3, 1);
        local message_add_btn = mgui.button(365, 110, 20, 290, "Add", 4, 1);

        if message_add_btn then
            local message_table = messages["spam"];

            if (message_add_index == 2) then
                message_table = messages["kill"];
            elseif (message_add_index == 3) then
                message_table = messages["death"];
            elseif (message_add_index == 4) then
                message_table = messages["onetap"];
            end

            table.insert(message_table, message_add_edit);
            saveData();
        end

        if (messages ~= nil and messages["spam"] ~= nil and #messages["spam"] > 0) then
            mgui.panel(10, 15, 120, 330, "Chat Spammer", 5, 1);
            local spammer_cb = mgui.checkbox(25, 25, 300, "Activate chat spammer", false, 6, 1);
            local spammer_speed = mgui.slider(25, 45, 300, 100, "Chat speed (ms)", "ms", 22, 7, 1);
            local spammer_messages_index, spammer_messages_text = mgui.itembox(25, 87, 250, "Messages", messages["spam"], 1, 8, 1);
            local spammer_message_delete_btn = mgui.button(280, 110, 15, 40, "Delete", 9, 1);
            if spammer_message_delete_btn then table.remove(messages["spam"], spammer_messages_index); end
            if (spammer_cb == true) then spammer_enable = true; elseif (spammer_cb == false) then spammer_enable = false; end
        end

        if (messages ~= nil and messages["kill"] ~= nil and #messages["kill"] > 0) then
            mgui.panel(10, 150, 80, 330, "Kill Say", 10, 1);
            local kill_cb = mgui.checkbox(25, 160, 300, "Activate kill say", false, 11, 1);
            local kill_messages_index, kill_messages_text = mgui.itembox(25, 180, 250, "Messages", messages["kill"], 1, 12, 1);
            local kill_message_delete_btn = mgui.button(280, 202, 15, 40, "Delete", 13, 1);
            if kill_message_delete_btn then table.remove(messages["kill"], kill_messages_index); end
            if (kill_cb == true) then kill_enable = true; elseif (kill_cb == false) then kill_enable = false; end
        end

        if (messages ~= nil and messages["onetap"] ~= nil and #messages["onetap"] > 0) then
            mgui.panel(350, 150, 80, 330, "Onetap Say", 17, 1);
            local onetap_cb = mgui.checkbox(360, 160, 300, "Activate onetap messages", false, 18, 1);
            local onetap_messages_index, onetap_messages_text = mgui.itembox(360, 180, 250, "Messages", messages["onetap"], 1, 19, 1);
            local onetap_message_delete_btn = mgui.button(615, 202, 15, 40, "Delete", 20, 1);
            if (onetap_cb == true) then onetap_enable = true; elseif (onetap_cb == false) then onetap_enable = false; end
            if onetap_message_delete_btn then table.remove(messages["onetap"], onetap_messages_index); end
        end

        if (messages ~= nil and messages["death"] ~= nil and #messages["death"] > 0) then
            mgui.panel(10, 245, 80, 330, "Death Say", 9, 1);
            local death_cb = mgui.checkbox(25, 255, 300, "Activate death say", false, 14, 1);
            local death_messages_index, death_messages_text = mgui.itembox(25, 275, 250, "Messages", messages["death"], 1, 15, 1);
            local death_message_delete_btn = mgui.button(280, 297, 15, 40, "Delete", 16, 1);
            if (death_cb == true) then death_enable = true; elseif (death_cb == false) then death_enable = false; end
            if death_message_delete_btn then table.remove(messages["death"], death_messages_index); end
        end

        if (spammer_message_delete_btn or kill_message_delete_btn or onetap_message_delete_btn or death_message_delete_btn) then
            saveData();
        end

        mgui.menu_mouse(1);
        mgui.item_show();
    end
end

local function press()
    show = CHAT_CB:GetValue();

    if input.IsButtonPressed(gui.GetValue("adv.menukey")) then
        pressed = not pressed;
    end
end

function loadData()
    local data_file = file.Open(CHAT_SAVE_FILE_NAME, "r");
    if (data_file == nil) then
        return;
    end

    local chat_data = data_file:Read();
    data_file:Close();
    if (chat_data ~= nil and chat_data ~= "") then
        messages = parseStringifiedTable(chat_data);
    end

    local types = {"spam", "kill", "death", "onetap"};
    for i=1, #types do
        if (messages[types[i]] == nil) then
            messages[types[i]] = {};
        end
    end
end

function saveData()
    local value = convertTableToDataString(messages);
    local data_file = file.Open(CHAT_SAVE_FILE_NAME, "w");
    if (data_file ~= nil) then
        data_file:Write(value);
        data_file:Close();
    end
end

function parseStringifiedTable(stringified_table)
    local new_messages = {};
    for i in string.gmatch(stringified_table, "([^\n]*)\n") do

        local type, message = string.match(i, "(.*)%=(.*)");
        if new_messages[type] == nil then
            new_messages[type] = {};
        end

        table.insert(new_messages[type], message);
    end
    return new_messages
end

function convertTableToDataString(object)
    local converted = "";
    for type, messages in pairs(object) do
        for i, message in ipairs(messages) do
            if (message ~= nil) then
                converted = converted .. type .. '=' .. message .. '\n'
            end
        end
    end

    return converted;
end

-- Normal spamming function
local function normalSpam()
    if (globals.TickCount() - last_message < 0) then
        last_message = 0;
    end;

    if spammer_enable == true and globals.TickCount() - last_message > (math.max(22, spammer_speed)) then
        sendMessage(getRandomMessage(messages["spam"]));
        last_message = globals.TickCount();
    end
end

-- Spamming based on a death event
local function eventHandler(event)
    local self_pid = client.GetLocalPlayerIndex();

    -- Let's clear the hits table after each round
    if (event:GetName() == "round_start") then
        hits = {};
    end

    if (event:GetName() == "player_hurt") then
        local victim_id = event:GetInt('userid');
        local victim_name = client.GetPlayerNameByUserID(victim_id);
        local victim_pid = client.GetPlayerIndexByUserID(victim_id);

        local attacker_id = event:GetInt('attacker');
        local attacker_name = client.GetPlayerNameByUserID(attacker_id);
        local attacker_pid = client.GetPlayerIndexByUserID(attacker_id);

        -- Don't do anything when we damage ourselves
        if (self_pid == attacker_pid and self_pid == victim_pid) or self_pid == victim_id then
            return;
        end

        -- Add a new record for this victim
        if (hits[victim_pid] == nil) then
            hits[victim_pid] = 0;
        end

        -- We did damage to an enemy, add it as a 'hit'
        hits[victim_pid] = hits[victim_pid] + 1;
    end

    if (event:GetName() == 'player_death') then
        local victim_id = event:GetInt('userid');
        local victim_name = client.GetPlayerNameByUserID(victim_id);
        local victim_pid = client.GetPlayerIndexByUserID(victim_id);

        local attacker_id = event:GetInt('attacker');
        local attacker_name = client.GetPlayerNameByUserID(attacker_id);
        local attacker_pid = client.GetPlayerIndexByUserID(attacker_id);

        -- If we're both the attacker and the victim (suicide), we shouldn't be doing anything
        -- Nor when we're neither
        if ((self_pid == attacker_pid and self_pid == victim_pid) or (not self_pid == attacked_pid and not self_pid == victim_pid)) then
            return;
        end

        local headshot = event:GetInt('headshot');
        local used_awp = event:GetString('weapon') == "awp";
        local is_attacker = attacker_pid == self_pid;

        -- Death message
        if (death_enable and not is_attacker and victim_pid == self_pid) then
            sendMessage(getRandomMessage(messages["death"]), attacker_name);
            return;
        end

        -- We've already checked the death scenario, we don't have to check this again
        if (not is_attacker) then
            return;
        end

        -- We onetapped someone when we fired a single shot and either got a headshot or a kill with an awp.
        local is_onetap = (used_awp or headshot == 1) and hits[victim_pid] == 1;

        -- Onetap message
        if (onetap_enable and is_onetap) then
            sendMessage(getRandomMessage(messages["onetap"]), victim_name);
            -- Normal kill message
        elseif (kill_enable) then
            sendMessage(getRandomMessage(messages["kill"]), victim_name);
        end

        hits[victim_pid] = 0;
    end
end

function getRandomMessage(messages)
    if next(messages) == nil then return; end
    return messages[math.random(#messages)]
end

function sendMessage(message, opponent_name)
    if (message == nil) then return; end

    local self = entities.GetLocalPlayer();
    if (self == nil) then
        return;
    end

    -- Substitute "$me" for the local player's name
    message = message:gsub("$me", self:GetName())
    if (opponent_name) then
        -- If there's an opponent in the event, substitude $opponent for their name
        message = message:gsub("$opponent", opponent_name);
    end
    client.ChatSay(message);
end

RunScript("mgui.lua")

-- Overriding n_height due to a bug in the edit block
n_height = 18;

-- Overriding the input_to_text function in mgui to support special characters.
-- There are some fuckups with special characters, but I can't be arsed to fix them at 3 AM.
mgui.input_to_text = function()
    local logic_shift_up = {
        [96] = "~",
        [49] = "!",
        [50] = "@",
        [51] = "#",
        [52] = "$",
        [53] = "%",
        [54] = "^",
        [55] = "&",
        [56] = "*",
        [57] = "(",
        [48] = ")",
        [57] = "(",
        [48] = ")",
        [45] = "_",
        [61] = "+",
        [91] = "{",
        [93] = "}",
        [92] = "|",
        [59] = " =",
        [39] = "\"",
        [44] = "<",
        [46] = ">",
        [47] = "?"
    }

    local special_characters = {
        [189] = "-",
        [187] = "=",
        [186] = ";",
        [219] = "[",
        [221] = "]",
        [222] = "'",
        [220] = "\\",
        [191] = "/",
        [188] = ",",
        [190] = "."
    }

    local special_characters_shift_up = {
        [189] = "_",
        [187] = "+",
        [186] = ";",
        [219] = "{",
        [221] = "}",
        [222] = '"',
        [220] = "|",
        [191] = "?",
        [188] = "<",
        [190] = ">"
    }

    local result = ""
    for i = 48, 90 do
        if (input.IsButtonPressed(i)) then
            if (not input.IsButtonDown(16) and i >= 65 and i <= 90) then
                result = string.char(i + 32);
            elseif input.IsButtonDown(16) and logic_shift_up[i] then
                result = logic_shift_up[i]
            else
                result = string.char(i)
            end
        end
    end

    for i = 187, 222 do
        if (input.IsButtonPressed(i)) then
            if not input.IsButtonDown(16) and special_characters[i] ~= nil then
                result = special_characters[i];
            elseif input.IsButtonDown(16) and special_characters_shift_up[i] ~= nil then
                result = special_characters_shift_up[i];
            else
                result = string.char(i);
            end
        end
    end

    if input.IsButtonPressed(32) then
        result = " "
    end

    return result
end

client.AllowListener('player_death');
callbacks.Register("Draw", "pressed", press);
callbacks.Register("Draw", "Chat Normal Spammer", normalSpam);
callbacks.Register("FireGameEvent", "Chat FireGameEvent", eventHandler);
callbacks.Register("Draw", "Draw Menu", drawMenu);








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

