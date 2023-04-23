local killsays = {
   [1] = " AHAHAHHAAH (◣_◢)",
   [2] = "THIS IS UNDERGROUND, BITCH╰_╯",
   [3] = "ahhahaha, suck noob (っ◔◡◔)っ .!.",
   [4] = "I'm cheater╰_╯ (◣_◢)",
   [5] = "YOU MOM DED (◣_◢)",
   [6] = "Я играю на лайфхакерском конфиге от Шока (◣_◢)",
   [7] = "beach off CHEAT ╰_╯",
   [8] = "DİABLO GİVE ME YOUR SPRİT HACK",
   [9] = "1000 BOMS PER 50 YEARS AND ALL BE HAPPY IN THE ALL WORLD",
   [10] = "THIS IS DRYTSQUAD, BITCH╰_╯",
   [11] = "i am horny on ur mom ╰_╯",
   [12] = "IZI GAME))",
   [13] = "LIFEEEEHAAAACK BITCH!!! (◣_◢)",
   [14] = "THIS IS OMLEEEEEEET (◣_◢)",
   [15] = "Теперь я - Stewie2k (◣_◢)",
   [16] = "DIABLO GO CFG ╰_╯",
   [17] = "-FUN(◣_◢)",
   [18] = "private cheats are sucki sucki ╰_╯",
   [19] = "Теперь я - Ютубер Омлет (◣◢)",
   [20] = "THIS IS DRYTSQUAD, BITCH╰_╯", 
   [21] = "ايري باحتك (◣_◢)",
   [22] = "guys me afk good luck your mother is dead",
   [23] = "getlight.glhf Activated ╰_╯",
   [24] = "Теперь я - Simple (◣◢)",
   [25] = "Желток в деле! Белок на пределе! (◣_◢)",
   [26] = "dracula.pw top rage soft ╰_╯",
   [27] = "ahaahha you cheats",
   [28] = "Я играю на вкуснейшем конфиге от Омлета ツ",
	
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