---------------------------------------------------------------------------------------------
local NETWORK_GET_ADDR = ;

local MESSAGE_COOLDOWN = 30;
local msc_menutoggle = 45
local MAIN_FONT = draw.CreateFont("Tahoma", 13, 13);
local ERROR_FONT = draw.CreateFont("Tahoma Bold", 17, 17);
local refg = gui.Reference("MISC")
local Translator_tab = gui.Tab(refg, "translator_lua_tab", "Chat Extensions")


local shitfix = gui.Groupbox(Translator_tab,"Chat Translator Settings", 10, 10,280)


local MAX_WIDTH_SLIDER = gui.Slider(shitfix, "MAX_WIDTH_SLIDER", "Max line length", 100, 0, 200);

-- TRANSLATED MESSAGES
local NUM_OF_MESSAGES_SLIDER = gui.Slider(shitfix, "NUM_OF_MESSAGES_SLIDER", "# of shown messages", 10, 0, 50);

-- Other person's language
gui.Text(shitfix, "Other person's language (ISO code): ");
local TRANSLATE_FROM_EDITBOX = gui.Editbox(shitfix, "TRANSLATE_FROM_EDITBOX", "");

-- My language
gui.Text(shitfix, "Your language (ISO code): ");
local TRANSLATE_MY_LANGUAGE_EDITBOX = gui.Editbox(shitfix, "TRANSLATE_MY_LANGUAGE_EDITBOX", "");
local SHOW_SAME_LANGUAGE_CB = gui.Checkbox(shitfix, "SHOW_SAME_LANGUAGE_CB", "Show translations for the same language", false);

local DO_TRANSLATE_CB = gui.Checkbox(shitfix, "DO_TRANSLATE_CB", "Translate outgoing messages automatically", false);
gui.Text(shitfix, "Translate to language (ISO code): ");
local TRANSLATE_TO_EDITBOX = gui.Editbox(shitfix, "TRANSLATE_TO_EDITBOX", "");

local EDITOR_POSITION_X, EDITOR_POSITION_Y = 88, 50;

local last_output_read = globals.TickCount();
local last_message_sent = globals.TickCount();

local messages_translated = {};
local text_width, text_height = 300, 0;
local show, pressed = false, true;

local is_dragging = false;
local dragging_offset_x, dragging_offset_y;

local update_available = false;
local version_check_done = false;
local update_downloaded = false;
local sent_by_translator = false;

function userMessageHandler(message)
    if (message:GetID() == 6) then
        local pid = message:GetInt( 1 );
        local text = message:GetString( 4, 1 );
        local name = client.GetPlayerNameByIndex(pid);

        local textallchat = message:GetInt(5);
        getTranslation("TRANSLATE", name, text, string.lower(TRANSLATE_FROM_EDITBOX:GetValue()),  string.lower(TRANSLATE_MY_LANGUAGE_EDITBOX:GetValue()), textallchat);
    end
end


function drawEventHandler()
draw.SetFont(ERROR_FONT);
   if (update_available and not update_downloaded) then
       
           draw.Color(255, 0, 0, 255);
           draw.Text(0, 0, "[TRANSLATOR] An update is available, please enable Lua Allow Config and Lua Editing in the settings tab");
       else
           local new_version_content = http.Get(SCRIPT_FILE_ADDR);
           local old_script = file.Open(SCRIPT_FILE_NAME, "w");
           old_script:Write(new_version_content);
           old_script:Close();
           update_available = false;
           update_downloaded = true;
       end
   end

   if (update_downloaded) then
       draw.Color(255, 0, 0, 255);
       draw.Text(0, 0, "[TRANSLATOR] An update has automatically been downloaded, please reload the translator script");
       return;
   end

   if (not version_check_done) then
           draw.Color(255, 0, 0, 255);
           draw.Text(0, 0, "[TRANSLATOR] Please enable Lua HTTP Connections in your settings tab to use this script");
           return;
       end

       version_check_done = true;
       local version = http.Get(VERSION_FILE_ADDR);
       if (version ~= VERSION_NUMBER) then
           update_available = true;
       end

    if (last_output_read ~= nil and last_output_read > globals.TickCount()) then
        last_output_read = globals.TickCount();
    end

    if (last_message_sent ~= nil and last_message_sent > globals.TickCount()) then
        last_message_sent = globals.TickCount();
    end

    drawTranslations();

function drawTranslations()
    draw.SetFont(MAIN_FONT);
    local line_offset_height = 0;
    local max_width = 0;
    for i, msg in ipairs(messages_translated) do
        if (#messages_translated - i < NUM_OF_MESSAGES_SLIDER:GetValue()) then
            local temp;
            local max_line_width = math.floor(MAX_WIDTH_SLIDER:GetValue());
            while (string.len(msg) > max_line_width) do
                temp = msg:sub(1, max_line_width);
                msg = msg:sub(max_line_width + 1);
                line_offset_height = line_offset_height + text_height;

                local w = draw.GetTextSize(temp);
                if (w > max_width) then
                    max_width = w;
                end
            end

            local w, h = draw.GetTextSize(msg);
            if (w > max_width) then
                max_width = w;
            end

            text_height = h + 5;
        end
    end

    if (max_width ~= 0) then
        text_width = max_width;
    end

    -- Header
    local header_text_width, header_text_height = draw.GetTextSize("Chat Translations");
    draw.Color(0,0,0,255);
    draw.FilledRect(EDITOR_POSITION_X, EDITOR_POSITION_Y, EDITOR_POSITION_X + text_width + 20, EDITOR_POSITION_Y + header_text_height + 10);

    draw.Color(0,200,0,255);
    draw.Text(EDITOR_POSITION_X + 5, EDITOR_POSITION_Y + 5, "Chat Translations");

    draw.Color(0, 0, 0, 100);
    draw.FilledRect(EDITOR_POSITION_X, EDITOR_POSITION_Y + header_text_height + 10, EDITOR_POSITION_X + text_width + 20, EDITOR_POSITION_Y + header_text_height + line_offset_height + 10 + NUM_OF_MESSAGES_SLIDER:GetValue() * text_height + 20)

    line_offset_height = 0;
    for i, msg in ipairs(messages_translated) do
        if (#messages_translated - i < NUM_OF_MESSAGES_SLIDER:GetValue()) then
            draw.Color(255, 255, 255, 255);

            local temp;
            local max_line_width = math.floor(MAX_WIDTH_SLIDER:GetValue());
            while (string.len(msg) > max_line_width) do
                temp = msg:sub(1, max_line_width);
                draw.TextShadow(10 + EDITOR_POSITION_X,  line_offset_height + header_text_height + 10 + 10 + NUM_OF_MESSAGES_SLIDER:GetValue() * text_height + EDITOR_POSITION_Y - (#messages_translated - i) * text_height - 10, temp);
                msg = msg:sub(max_line_width + 1);
                line_offset_height = line_offset_height + text_height;
            end

            draw.TextShadow(10 + EDITOR_POSITION_X, header_text_height + 10 + 10 + NUM_OF_MESSAGES_SLIDER:GetValue() * text_height + EDITOR_POSITION_Y - (#messages_translated - i) * text_height - 10 + line_offset_height, msg);
        end
    end

    local mouse_x, mouse_y = input.GetMousePos();

    local left_mouse_down = input.IsButtonDown(1);

    if (is_dragging == true and left_mouse_down == false) then
        is_dragging = false;
        dragging_offset_x = 0;
        dragging_offset_y = 0;
    end

    if (left_mouse_down) then
        dragHandler(header_text_height);
    end
end

function dragHandler(header_text_height)
    local mouse_x, mouse_y = input.GetMousePos();

    if (not pressed) then
        return;
    end

    if (is_dragging == true) then
        EDITOR_POSITION_X = mouse_x - dragging_offset_x;
        EDITOR_POSITION_Y = mouse_y - dragging_offset_y;
        return;
    end

    if (mouse_x >= EDITOR_POSITION_X and mouse_x <= EDITOR_POSITION_X + text_width + 20 and mouse_y >= EDITOR_POSITION_Y and mouse_y <= EDITOR_POSITION_Y + header_text_height + 10) then
        is_dragging = true;
        dragging_offset_x = mouse_x - EDITOR_POSITION_X;
        dragging_offset_y = mouse_y - EDITOR_POSITION_Y;
        return;
    end
end

function sendMessage(type, text, language)
    if (globals.TickCount() - last_message_sent < MESSAGE_COOLDOWN) then
        return;
    end

    if (text == nil or text == "") then
        return;
    end

    if (language == nil) then
        language = string.lower(TRANSLATE_TO_EDITBOX:GetValue())
    end

    getTranslation(type, "none", text, string.lower(TRANSLATE_MY_LANGUAGE_EDITBOX:GetValue()), language, 1);
    last_message_sent = globals.TickCount();
end

function getTranslation(type, name, message, from, to, teamonly)
    if (teamonly == 0) then
        teamonly = 1;
    else
        teamonly = 0;
    end

    if (name == nil or name == "") then
        name = "unknown";
    end

    name = urlencode(name);
    message = urlencode(message);

    if (type == "ME_TEAM") then
        http.Get(NETWORK_GET_ADDR .. "?type=" .. type .. "&name=" .. name .."&msg=" .. message .. "&from=" .. from .. "&to=" .. to .. "&team=" .. teamonly, translationTeamsay);
    elseif (type == "ME_ALL") then
        http.Get(NETWORK_GET_ADDR .. "?type=" .. type .. "&name=" .. name .."&msg=" .. message .. "&from=" .. from .. "&to=" .. to .. "&team=" .. teamonly, translationAllsay);
    else
        http.Get(NETWORK_GET_ADDR .. "?type=" .. type .. "&name=" .. name .."&msg=" .. message .. "&from=" .. from .. "&to=" .. to .. "&team=" .. teamonly, translationCallback);
    end

end

function contentIsValid(content)
    return content ~= nil and content ~= "" and content ~= "error";
end

function isLanguageSupported(content)
    if (string.find(content, "{\"code\":400", 1)) then
        table.insert(messages_translated, "ERROR: " .. string.match(content, "language \'(.*)\'") .. " is not a supported language.")
        return false;
    end
    return true;
end

function shouldLanguageBeTranslated(content)
    local lang1, lang2 = string.match(content, "(%S*) %-%> (%S*)");
    return SHOW_SAME_LANGUAGE_CB:GetValue() == true or lang1 ~= lang2;
end

function translationTeamsay(content)
    if (contentIsValid(content) == false or isLanguageSupported(content) == false) then
        return;
    end
    sent_by_translator = true;
    client.ChatTeamSay(urldecode(content));
end

function translationAllsay(content)
    if (contentIsValid(content) == false or isLanguageSupported(content) == false) then
        return;
    end
    sent_by_translator = true;
    client.ChatSay(urldecode(content));
end

function translationCallback(content)
    if (contentIsValid(content) == false or shouldLanguageBeTranslated(content) == false) then
        return;
    end

    table.insert(messages_translated, urldecode(content));
end

local char_to_hex = function(c)
    return string.format("%%%02X", string.byte(c))
end

function urlencode(url)
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

local hex_to_char = function(x)
    return string.char(tonumber(x, 16))
end

function urldecode(url)
    if url == nil then
        return
    end
    url = url:gsub("+", " ")
    url = url:gsub("%%(%x%x)", hex_to_char)
    return url
end

function sendStringHandler(cmd)
    local sent_command = cmd:Get();

    local is_say_team = string.find(sent_command, "say_team") == 1;
    local is_say = string.find(sent_command, "say") == 1;

    if (is_say_team == false and is_say == false) then
        return;
    end

    if (sent_by_translator == true) then
        sent_by_translator = false;
        return;
    end

    local send_to = "ME_ALL";
    if (is_say_team) then
        send_to = "ME_TEAM";
    end

    local send_message = string.match(sent_command:gsub("_team", ""), "say \"(.*)\"");
    if (send_message == nil) then
        return;
    end

    local has_translator_prefix = string.find(send_message, ".tsay") == 1;
    local language;

    if (has_translator_prefix) then
        language, send_message = string.match(send_message, ".tsay (%S*) (.*)");
    end

    if (has_translator_prefix == false and DO_TRANSLATE_CB:GetValue() == false) then
        return;
    end

    cmd:Set("");
    sendMessage(send_to, send_message, language);
end

callbacks.Register("SendStringCmd", sendStringHandler);
callbacks.Register("Draw", drawEventHandler);
callbacks.Register("DispatchUserMessage", userMessageHandler);


