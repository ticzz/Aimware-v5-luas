local killsays = {
	[1] = "SUCH A BADDIE",
	[2] = "_name_ YOU'RE PRETTY BAD",
	[3] = "HOW DO YOU HACK AND LOSE YOU NIGGER",
	[4] = "WHAT A BADDIE",
	[5] = "BAD",
	[6] = "2bad",
	[7] = "SO BAD",
	[8] = "NOPE",
	[9] = "YOU CAN'T EVEN KILL ME",
	[10] = "Owned.",
	[11] = "HAD FUN GETTING ROLLED?",
	[12] = "_name_, get rolled, K?",
	[13] = "Wow, he cheats and calls me pathetic.",
	[14] = "_name_, you seriously think you can run from me?",
	[15] = ":)",
	[16] = "Scrub.",
	[17] = "Missed again.",
	[18] = "You can't even hit me with normal aimbot.",
	[19] = "So mad.",
	[20] = "You so bad.",
	[21] = "Bad.",
	[22] = "Can't beat me?",
	[23] = "Those are some bad hacks you got there.",
	[24] = "That hack sucks.",
	[25] = "Thems some bad hacks buddy.",
	[26] = "You = bad.",
	[27] = "Yeah, I think I won.",
	[28] = "What a baddie.",
	[29] = "Wow more bad please.",
	[30] = "Wow, didn't even hit me.",
	[31] = "How bad are you?",
	[32] = "WOOOOOOOW",
	[33] = "HAHAHAHAHAHA",
	[34] = "How do you hack and lose?",
	[35] = "Uninstall your hacks.",
	[36] = "More bad please.",
	[37] = "Sorry try again.",
	[38] = "You can't even hit me.",
	[39] = "You're complete garbage.",
	[40] = "You lose.",
	[41] = "Super bad.",
	[42] = "HAH",
	[43] = "WHAT A BADDIE!",
	[44] = "C'mon baddie.",
	[45] = "Get rolled again.",
	[46] = "Can't even hit me.",
	[47] = "You lose again.",
	[48] = "MORE BAD PLEASE",
	[49] = "He's not even hitting me once.",
	[50] = "Fucking nub.",
	[51] = "Sucks for you.",
	[52] = "Nah, you're just bad.",
	[53] = "OH YOU DIED AGAIN",
	[54] = "WOW",
	[55] = "Man, you're getting shitted on.",
	[56] = "NOPE",
	[57] = "2fast4u",
	[58] = "Dead.",
	[59] = "Suck my dick.",
	[60] = "You wanna 1v1 me?",
	[61] = "LOL YOU LOSE KID",
	[62] = "HOW DO YOU HACK AND LOSE?!?!?!?",
	[63] = "LMAO",
	[64] = "XDDDDDDD",
	[65] = "ENJOY YOUR LOSS KID",
	[66] = "EZ",
	[67] = "What is this, nigger day?",
	[68] = "Why so many blacks?!",
	[69] = "Fucking nigger black horse.",
	[70] = "How do you hack and die?",
	[71] = "Nah you suck.",
	[72] = "Died again?!",
	[73] = "WHAT THE FUCK!!!!!!!",
	[74] = "I killed the hacker though.",
	[75] = "Blacks committed 52% of violent crimes between 1980 and 2008, despite being 13% of the population. ~JusticeBureau",
	[76] = "Blacks are Bad Fact #666: Average white IQ: 104 Average black IQ: 85. ~American SAT IQ Scores in 2015",
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