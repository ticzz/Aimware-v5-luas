local killsays = {
	[1] = "Wow more bad please, _name_.",
	[2] = "Wow, didn't even hit me, _name_.",
	[3] = "How bad are you, _name_?",
	[4] = "Get a refund, _name_.",
	[5] = "WOOOOOOOOOOW",
	[6] = "HAHAHAHAHAHA",
	[7] = "More bad please.",
	[8] = "How do you hack and lose, _name_?",
	[9] = "Uninstall your hacks, _name_.",
	[10] = "Get on my level, _name_.",
	[11] = "And that ladies and gentlemen is how you win at HvH.",
	[12] = "You missed.",
	[13] = "Scrub.",
	[14] = "You can't even hit me, _name_.",
	[15] = "You're bad, _name_.",
	[16] = "So mad.",
	[17] = "_name_ sucks.",
	[18] = "_name_ is so fucking bad.",
	[19] = "I hope you didn't pay for those, _name_.",
	[20] = "You think you can run from me, _name_?!",
	[21] = "Wow, _name_ cheats and calls me pathetic.",
	[22] = "You seriously think you can run from me?",
	[23] = "You're complete garbage, _name_.",
	[24] = "Why can't you defeat me, _name_?",
	[25] = "WHAT A BADDIE!",
	[26] = "Just uninstall and don't come back, _name_.",
	[27] = "How did you pay money for items and still suck at this game, _name_?",
	[28] = "Why are you so bad, _name_?",
	[29] = "OH YOU DIED AGAIN! HAHAHAAHAH!",
	[30] = "Fucking uninstall this game you're so trash, _name_.",
	[31] = "This is my game. You are bad, and I do not allow you to play this game.",
	[32] = "I don't think you can get any more mad right now, _name_.",
	[33] = "I fucking really wanna know how you're so bad at this game, _name_.",
	[34] = "You're fucking trash, _name_.",
	[35] = "You wanna 1v1 me?",
	[36] = "2bad4me",
	[37] = "Uninstall.",
	[38] = "You're not very good, _name_.",
}

function CHAT_KillSay( Event )
	
	if ( Event:GetName() == 'player_death' ) then
		
		local ME = client.GetLocalPlayerIndex();
		
		local INT_UID = Event:GetInt( 'userid' );
		local INT_ATTACKER = Event:GetInt( 'attacker' );
		
		local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
		local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
		
		local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
		local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
		
		if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
        
                local response = tostring(killsays[math.random(#killsays)]);
                response = response:gsub("_name_", NAME_Victim);
                client.ChatSay( ' ' .. response );
        
        end
	
	end
	
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

