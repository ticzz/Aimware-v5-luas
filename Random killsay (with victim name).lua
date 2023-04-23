-- Scraped by chicken
-- Author: epicanimecheater
-- Title [Release] Random killsay from list (with victim name)
-- Forum link https://aimware.net/forum/thread/86031

local killsays = {
 [1] = "Wow more bad please",
 [2] = "Wow, didn't even hit me",
 [3] = "How bad are you",
 [4] = "Get a refund",
 [5] = "WOOOOOOOOOOW",
 [6] = "HAHAHAHAHAHA",
 [7] = "More bad please.",
 [8] = "How do you hack and lose?",
 [9] = "Uninstall your hacks",
 [10] = "Get on my level",
 [11] = "And that ladies and gentlemen is how you win at HvH.",
 [12] = "You missed.",
 [13] = "Scrub.",
 [14] = "You can't even hit me",
 [15] = "You're bad",
 [16] = "So mad.",
 [17] = "sucks.",
 [18] = "is so fucking bad.",
 [19] = "I hope you didn't pay for those.",
 [20] = "You think you can run from me, _name_?!",
 [21] = "Wow, cheats and calls me pathetic.",
 [22] = "You seriously think you can run from me?",
 [23] = "You're complete garbage",
 [24] = "Why can't you defeat me?",
 [25] = "WHAT A BADDIE!",
 [26] = "Just uninstall and don't come back",
 [27] = "How did you pay money for items and still suck at this game?",
 [28] = "Why are you so bad?",
 [29] = "OH YOU DIED AGAIN! HAHAHAAHAH!",
 [30] = "Fucking uninstall this game you're so trash",
 [31] = "This is my game. You are bad, and I do not allow you to play this game.",
 [32] = "I don't think you can get any more mad right now",
 [33] = "I fucking really wanna know how you're so bad at this game",
 [34] = "You're fucking trash",
 [35] = "You wanna 1v1 me?",
 [36] = "2bad4me",
 [37] = "Uninstall.",
 [38] = "You're not very good",
}

local enable = gui.Checkbox(gui.Reference("Misc", "Enhancement", "Appearance"), "killsayenemynames", "Killsay with Enemy Names", false);

function CHAT_KillSay( Event )
 if not enable or entities.GetLocalPlayer() then return end;

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
        client.ChatSay( ' ' .. "response" );
   
    end
 
 end
 
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', CHAT_KillSay );










--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

