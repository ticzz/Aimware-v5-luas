--[Onyx] Chat Hit Log.lua by OurmineOGTv#6846
--Unofficial AIMWARE Discord Server: https://discord.com/invite/5eH69PF

local OnyxRef = gui.Reference("Misc", "General", "Logs")
draw.Color(255,0,0,255)
local OnyxMasterTitle = gui.Text(OnyxRef, "# Options for Custom Hitlogs")
local OnyxMasterSwitch = gui.Checkbox(OnyxRef, "master.switch", "Hit Log Master Switch", false)
local OnyxActivateConsoleLog = gui.Checkbox(OnyxRef, "console.log", "Console Log", false)
local OnyxActivateGlobalSay = gui.Checkbox(OnyxRef, "global.say", "Global Say", false)
local OnyxTags = gui.Combobox(OnyxRef, "selected.tag", "Select Tag", "AIMWARE V5", "AIMWARE.net", "Gamesense", "Fatality.win", "Onetap.com", "x22cheats.com")

--Descriptions
OnyxMasterSwitch:SetDescription("Enable hit log lua.")
OnyxActivateConsoleLog:SetDescription("Enable aimware console log.")
OnyxActivateGlobalSay:SetDescription("Enable global chat say.")
OnyxTags:SetDescription("Select tag. (Default is AIMWARE V5)")

--start
local tags = {
	"𝗔𝗜𝗠𝗪𝗔𝗥𝗘 𝗩𝟱",
	"𝗔𝗜𝗠𝗪𝗔𝗥𝗘.𝗻𝗲𝘁",
	"𝗚𝗮𝗺𝗲𝘀𝗲𝗻𝘀𝗲",
	"𝗙𝗮𝘁𝗮𝗹𝗶𝘁𝘆.𝘄𝗶𝗻",
	"𝗢𝗻𝗲𝘁𝗮𝗽.𝗰𝗼𝗺",
	"x22cheats.com"
}

local bPart = {
	"𝗛𝗲𝗮𝗱",
	"𝗖𝗵𝗲𝘀𝘁",
	"𝗦𝘁𝗼𝗺𝗮𝗰𝗵",
	"Pelvis",
	"𝗟𝗲𝗳𝘁 𝗮𝗿𝗺",
	"𝗥𝗶𝗴𝗵𝘁 𝗮𝗿𝗺",
	"𝗟𝗲𝗳𝘁 𝗹𝗲𝗴",
	"𝗥𝗶𝗴𝗵𝘁 𝗹𝗲𝗴"
}

local TAG = "";

local function consoleMessage(attacker, part, DMG)
	local iTag = OnyxTags:GetValue();
	iTag = iTag + 1;
	TAG = tags[iTag];
	print("[" .. TAG .. "] " .. attacker .. " hit you in: " .. bPart[part] .. " for: " .. DMG .. " damage.")
end

local function globalMessage(attacker, part, DMG)
	local iTag = OnyxTags:GetValue();
	iTag = iTag + 1;
	TAG = tags[iTag];
	client.ChatSay('[' .. TAG .. '] ' .. attacker .. ' hit you in: ' .. bPart[part] .. ' for: ' .. DMG .. ' damage.')
end

local function checkWhoHit(event)
	local attacker = ""
	if ( event:GetName() == 'player_hurt' ) then
		local mUser = client.GetLocalPlayerIndex();

		local intID = event:GetInt('userid');
		local intAttacker = event:GetInt('attacker');
		local DMG = event:GetInt('dmg_health');
		local part = event:GetInt('hitgroup');

		local nVictim = client.GetPlayerNameByUserID( intID );
		local iVictim = client.GetPlayerIndexByUserID( intID );

		local nAttacker = client.GetPlayerNameByUserID( intAttacker );
		local iAttacker = client.GetPlayerIndexByUserID( intAttacker );

		if (iVictim == mUser and iAttacker ~= mUser) then
			attacker = nAttacker
		end
		if part == 0 then elseif part == 1 or part == 2 or part == 3 or part == 4 or part == 5 or part == 6 or part == 7 or part == 8 then 
			if OnyxMasterSwitch:GetValue() then
				if OnyxActivateConsoleLog:GetValue() then
					consoleMessage(attacker, part, DMG);
				end
				if OnyxActivateGlobalSay:GetValue() then
					globalMessage(attacker, part, DMG);
				end
			end
		else end
	end
end
client.AllowListener('player_hurt');
callbacks.Register('FireGameEvent', 'checkWhoHit', checkWhoHit);
