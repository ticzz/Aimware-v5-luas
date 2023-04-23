local CHAT_CB = gui.Checkbox(gui.Reference("MISC", "ENHANCEMENT", "Appearance"), "CHAT_ENABLED", "Chat Automation", true);
local show, pressed = false, true
local hits = {};

local last_message = globals.TickCount();
local spammer_enable, spammer_speed = false, 22;
local spammer_messages = {
    "www.AIMWARE.net | Premium CSGO Cheat",
    "Get rekt by $me using Aimware.net",
    "Aimware.net is the superior solution.",
    "Can't play this game? Try Aimware.net!",
    "Aimware.net, your next premium cheat."
};

local kill_enable, onetap_enable = false, false;
local kill_messages = {
    "$me dabbed on $opponent",
    "$opponent got shit on by $me",
    "Get P'd by $me",
    "$opponent got rekt",
    "Try Aimware.net like $me, you need it $opponent"
}

local onetap_enable = false; 
local onetap_messages = {
   "1",
   "You just got onetapped",
   "That was an easy onetap",
   "Is your AA even on?",
   "$opponent AA got rekt"
}

local death_enable = false;
local death_messages = {
    "$opponent got lucky",
    "$me got shit on",
    "Oh shit $opponent is on that P train",
    "$opponent is on some shit bruh"
}

function drawMenu()
    if (show and pressed) then
        mgui.max_component(10, 100);
        mgui.menu(300, 340, 340, 690, "Chat Automation", 1);

        mgui.panel(350, 15, 120, 330, "Message addition", 1, 1);
        message_add_edit = mgui.edit(360, 25, 300, "Your custom message", "", 2, 1);
        message_add_index, message_add_text = mgui.itembox(360, 65, 300, "Message type", {"Chat Spammer", "Kill Say", "Death Say", "Onetap say"}, 1, 3, 1);
        message_add_btn = mgui.button(365, 110, 20, 290, "Add", 4, 1);
        
        if message_add_btn then
            local message_table = spammer_messages;
            
            if (message_add_index == 2) then
                message_table = kill_messages;
            elseif (message_add_index == 3) then
                message_table = death_messages;
            elseif (message_add_index == 4) then
                message_table = onetap_messages;
            end
            
            table.insert(message_table, message_add_edit);
        end
        
        mgui.panel(10, 15, 120, 330, "Chat Spammer", 5, 1);
        spammer_cb = mgui.checkbox(25, 25, 300, "Activate chat spammer", false, 6, 1);
        spammer_speed = mgui.slider(25, 45, 300, 100, "Chat speed (ms)", "ms", 22, 7, 1);
        spammer_messages_index, spammer_messages_text = mgui.itembox(25, 87, 250, "Messages", spammer_messages, 1, 8, 1);
        spammer_message_delete_btn = mgui.button(280, 110, 15, 40, "Delete", 9, 1);
        
        mgui.panel(10, 150, 80, 330, "Kill Say", 10, 1);
        kill_cb = mgui.checkbox(25, 160, 300, "Activate kill say", false, 11, 1);
        kill_messages_index, kill_messages_text = mgui.itembox(25, 180, 250, "Messages", kill_messages, 1, 12, 1);
        kill_message_delete_btn = mgui.button(280, 202, 15, 40, "Delete", 13, 1);
        
        mgui.panel(350, 150, 80, 330, "Onetap Say", 17, 1);
        onetap_cb = mgui.checkbox(360, 160, 300, "Activate onetap messages", false, 18, 1);
        onetap_messages_index, onetap_messages_text = mgui.itembox(360, 180, 250, "Messages", onetap_messages, 1, 19, 1);
        onetap_message_delete_btn = mgui.button(615, 202, 15, 40, "Delete", 20, 1);
        
        mgui.panel(10, 245, 80, 330, "Death Say", 9, 1);
        death_cb = mgui.checkbox(25, 255, 300, "Activate death say", false, 14, 1);
        death_messages_index, death_messages_text = mgui.itembox(25, 275, 250, "Messages", death_messages, 1, 15, 1);
        death_message_delete_btn = mgui.button(280, 297, 15, 40, "Delete", 16, 1);

        if (spammer_cb == true) then spammer_enable = true; elseif (spammer_cb == false) then spammer_enable = false; end
        if (kill_cb == true) then kill_enable = true; elseif (kill_cb == false) then kill_enable = false; end
        if (onetap_cb == true) then onetap_enable = true; elseif (onetap_cb == false) then onetap_enable = false; end
        if (death_cb == true) then death_enable = true; elseif (death_cb == false) then death_enable = false; end
        
        if spammer_message_delete_btn then table.remove(spammer_messages, spammer_messages_index); end
        if kill_message_delete_btn then table.remove(kill_messages, kill_messages_index); end
        if onetap_message_delete_btn then table.remove(onetap_messages, onetap_messages_index); end
        if death_message_delete_btn then table.remove(death_messages, death_messages_index); end
    
        mgui.menu_mouse(1);
        mgui.item_show();
    end
end

function press() 
    show = CHAT_CB:GetValue();

    if input.IsButtonPressed(gui.GetValue("adv.menukey")) then 
        pressed = not pressed;
    end
end

-- Normal spamming function
function normalSpam()
    if (globals.TickCount() - last_message < 0) then
        last_message = 0;
    end;
    
    if spammer_enable == true and globals.TickCount() - last_message > (math.max(22, spammer_speed)) then
        sendMessage(getRandomMessage(spammer_messages));
        last_message = globals.TickCount();
    end
end

-- Spamming based on a death event
function eventHandler(event)
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
            sendMessage(getRandomMessage(death_messages), attacker_name);
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
            sendMessage(getRandomMessage(onetap_messages), victim_name);
        -- Normal kill message
        elseif (kill_enable) then
            sendMessage(getRandomMessage(kill_messages), victim_name);
        end
        
        hits[victim_pid] = 0;
    end
end

function getRandomMessage(messages)
    if next(messages) == nil then return; end
    return messages[ math.random( #messages ) ]
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
    logic_shift_up = {
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
    
    special_characters = {
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
    
    special_characters_shift_up = {
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

    result = ""
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

client.AllowListener( 'player_death' );
callbacks.Register("Draw", "pressed", press);
callbacks.Register("Draw", "Chat Normal Spammer", normalSpam);
callbacks.Register("FireGameEvent", "Chat FireGameEvent", eventHandler);
callbacks.Register( "Draw", "Draw Menu", drawMenu )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

