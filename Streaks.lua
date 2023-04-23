local ButtonPosition = gui.Reference("Misc", "General", "Extra");
local TIME_BETWEEN_KILLS = gui.Slider(ButtonPosition, "streaks_time", "[STREAKS] Max Time between kills (s)", 2, 0, 90);
local STREAKS_CHAT = gui.Checkbox( ButtonPosition, "streaks_chat", "[STREAKS] Print to chat", 0 );
local STREAKS_AUDIO = gui.Checkbox( ButtonPosition, "streaks_audio", "[STREAKS] Play audio", 1 );
local STREAKS_AUDIO_HS = gui.Checkbox( ButtonPosition, "streaks_audio)hs", "[STREAKS] Enable Headshout audio", 1 );


local lastKillTick = -1000;
local serverInterval = globals.RealTime();
local sumKills = 0;
local killsSinceLastDeath = 0;

local messagesLoaded = false;
local messages = {};

function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))      
    else
      print(formatting .. v)
    end
  end
end
local function loadMessages()
	msg5 = {};
	msg5.amount = 3;
	msg5.title = "Killing Spree";
	msg5.audio = "killingspree.wav";

	msg7 = {};
	msg7.amount = 5;
	msg7.title = "Rampage!";
	msg7.audio = "rampage.wav";
	
	msg9 = {};
	msg9.amount = 7;
	msg9.title = "Maniac!";
	msg9.audio = "maniac.wav";
	
	msg11 = {};
	msg11.amount = 11;
	msg11.title = "Massacre!";
	msg11.audio = "massacre.wav";
	
	
	msg13 = {};
	msg13.amount = 13;
	msg13.title = "Juggernaut!";
	msg13.audio = "juggernaut.wav";
	
	msg14 = {};
	msg14.amount = 15;
	msg14.title = "Killing Machine!";
	msg14.audio = "killingmachine.wav";
	
	msg15 = {};
	msg15.amount = 20;
	msg15.title = "Godlike!";
	msg15.audio = "godlike.wav";
	
	table.insert(messages, msg5);
	table.insert(messages, msg7);
	table.insert(messages, msg9);
	table.insert(messages, msg11);
	table.insert(messages, msg13);
	table.insert(messages, msg14);
	table.insert(messages, msg15);
end

local function getTimeSinceLastKill()
	return (globals.RealTime() - lastKillTick);		
end

local function streaks_gameEvent(Event)
	if ( Event:GetName() == 'player_death' ) then
	
       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );
       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
	   
	   local INT_BOOM = Event:GetInt( 'headshot' );

		if (ME == INT_UID) then
			killsSinceLastDeath = 0;
		end

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
			if(INT_BOOM > 0) then
				if(STREAKS_AUDIO_HS:GetValue()) then
					client.Command("play headshot.wav", true);
				end
			end
	   
			-- I killed someone
			if getTimeSinceLastKill() < TIME_BETWEEN_KILLS:GetValue() then
					sumKills = sumKills + 1;
			else
				sumKills = 1;
			end
			lastKillTick = globals.RealTime();	
			killsSinceLastDeath = killsSinceLastDeath + 1;
			
			-- Process SPREES	
			for i = 1, #messages do
				if killsSinceLastDeath == messages[i].amount then
					if(STREAKS_CHAT:GetValue()) then
						client.ChatSay(messages[i].title);
					end
					if(STREAKS_AUDIO:GetValue()) then
						client.Command("play " .. messages[i].audio, true);
					end
				end
			end
       end
	elseif(Event:GetName() == "game_start") then
      killsSinceLastDeath = 0;		
	elseif (Event:GetName() == 'round_start') then
		printStreak();	
    end
end


local function printStreak()
	if getTimeSinceLastKill() >= TIME_BETWEEN_KILLS:GetValue() then
		if sumKills > 1 then
			if sumKills == 2 then
				if(STREAKS_CHAT:GetValue()) then
					client.ChatSay("It's DOUBLE KILL");
				end
				if(STREAKS_AUDIO:GetValue()) then
					client.Command("play doublekill.wav", true);
				end
			elseif sumKills == 3 then
				if(STREAKS_CHAT:GetValue()) then
					client.ChatSay("It's TRICKY");
				end
				if(STREAKS_AUDIO:GetValue()) then
					client.Command("play hattrick.wav", true);
				end
			elseif sumKills == 4 then
				if(STREAKS_CHAT:GetValue()) then
					client.ChatSay("It's QUADRA");
				end
				if(STREAKS_AUDIO:GetValue()) then
					client.Command("play multikill.wav", true);
				end
			elseif sumKills == 5 then
				if(STREAKS_CHAT:GetValue()) then
					client.ChatSay("It's PENTA KILL!");
				end
				if(STREAKS_AUDIO:GetValue()) then
					client.Command("play megakill.wav", true);
				end
			end
		end
		sumKills = 0;
	end
end

local function streaks_onMove(cmd)
	if not messagesLoaded then
		loadMessages();
		messagesLoaded = true;
	end

	printStreak();
end

client.AllowListener("round_start");
client.AllowListener("game_start");
client.AllowListener( 'player_death' );
callbacks.Register( 'FireGameEvent', 'streaks_gameEvent', streaks_gameEvent );
callbacks.Register("CreateMove", "streaks_onMove", streaks_onMove);