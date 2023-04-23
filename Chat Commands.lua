-- Chat Commands (!roll !8ball !cf) by RetardAlert https://aimware.net/forum/user/419881/reputation/add
-- Credits for the timer go to RadicalMario, imacookie, and yu0r for sending it to me :)
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Chat%20Commands.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Chat%20Commands%20Version.txt";
local VERSION_NUMBER = "1.1";
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local up_to_date = false;
local updaterfont1 = draw.CreateFont("Bahnschrift", 18);
local updaterfont2 = draw.CreateFont("Bahnschrift", 14);
local updateframes = 0;
local fadeout = 0;
local spacing = 0;
local fadein = 0;

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime();
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510);
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500;
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout;
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha);
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30);
			draw.Color(0, 180, 255,alpha);
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31);
		end
		draw.SetFont(updaterfont1);
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 - 650 + fadein, 7, "Chat Commands:");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("Chat Commands: ") - 650 + fadein, 7, "RetardAlert");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("Chat Commands: RetardAlert  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("Chat Commands: RetardAlert  \\  ");
		draw.SetFont(updaterfont2);
		draw.Color(225,225,225,255 - fadeout);
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.");
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.");
    end

    if (not version_check_done) then
        version_check_done = true;
		local version = http.Get(VERSION_FILE_ADDR);
		version = string.gsub(version, "\n", "");
		if (version ~= VERSION_NUMBER) then
            update_available = true;
		else 
			up_to_date = true;
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER);
	end
end)

local ref = gui.Reference("Misc", "Enhancement", "Appearance")
local enable_roll = gui.Checkbox(ref, "enable.roll", "!roll", true)
local enable_8ball = gui.Checkbox(ref, "enable.8ball", "!8ball", true)
local enable_cf = gui.Checkbox(ref, "enable.cf", "!cf", true)
local enable_gaydar = gui.Checkbox(ref, "enable.gaydar", "!gay", true)
local info = gui.Text(enable_roll, "Chat Commands by RetardAlert")

enable_roll:SetDescription("Use: Type !roll in chat.")
enable_8ball:SetDescription("Use: Type !8ball followed by a question in chat.")
enable_cf:SetDescription("Use: Type !cf or !flip followed by a bet in chat (Optional).")
enable_gaydar:SetDescription("Use: Type !gay in chat.")

local numbers = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
}

local responses = {
    "Yes - definitely.",
    "It is decidedly so.",
    "Without a doubt.",
    "Reply hazy, try again.",
    "Ask again later.",
    "Better not tell you now.",
    "My sources say no.",
    "Outlook not so good.",
    "Very doubtful.",
}

local results = {
    "won the coinflip!",
    "lost the coinflip!",
}

local gaydar = {
    "is gay!",
    "is not gay!",
}

local timer = timer or {}
local timers = {}

function timer.Create(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

function timer.Remove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

callbacks.Register("DispatchUserMessage", function(msg)
    if msg:GetID() == 6 then
        local index = msg:GetInt(1)
        local message = msg:GetString(4,1):lower()
        local m = string.match

        local player_name = client.GetPlayerNameByIndex(index)
        local number = numbers[math.random(#numbers)]
        local response = responses[math.random(#responses)]
        local result = results[math.random(#results)]
        local thingy = gaydar[math.random(#gaydar)]

        if m(message, "!roll") and enable_roll:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s rolled a %s'):format(player_name, number)
                client.ChatSay(msg)
            end)
        end

        if m(message, "!8ball") and enable_8ball:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                client.ChatSay("❽: " .. response)
            end)
        end

        if m(message, "!cf") or m(message, "!flip") or m(message, "!coin flip") or m(message, "!coinflip") and enable_cf:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, result)
                client.ChatSay(msg)
            end)
        end

        if m(message, "!gay") and enable_roll:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, thingy)
                client.ChatSay(msg)
            end)
        end
    end
end)

callbacks.Register("Draw", function()
    for k,v in pairs(timers or {}) do
  
        if (v["times"] <= 0) then table.remove(timers, k) end
      
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]()
        end  
    end
end)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")