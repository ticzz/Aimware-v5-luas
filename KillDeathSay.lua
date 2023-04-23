local Killsays = {
[1] = "_name_vic_ nice brain monkey";
[2] = "uninstall cs please _name_vic_"
[3] = "1 shot per dog";
[4] = "_name_vic_ got a 1tap on Head";
[5] = "1tap$ HAHAHAHAHHAHA";
[6] = "paste doesnt work?";
[7] = "refund cheat _name_vic_";
[8] = "Hooker 1tap";
[9] = "Is your config also on sell(y.gg), _name_vic_ nn gaylord?";
[10] = "_name_vic_ it seems like you got braindamaged HAHAHAHAHAH";
[11] = "nice resolver..";
[12] = "nice aa..";
[13] = "who.ru?";
[14] = "Innit? 1tap";
[15] = "Remember who you are dog";
[16] = "_name_vic_ u suck hard so sit dog";
[17] = "why so ez bitchboy?";
[18] = "the stupid dog died quickly";
[19] = "_name_vic_ u haven´t the brain to do something g_g 1tap";
[20] = "you lucky you died from a h v h - legend";
[21] = "Oops _name_vic_ is a bot!?!";
[22] = "Hey there _name_vic_!!";
[23] = "Stop being a noob! Get good with RedBull Energie";
[24] = "Im not using Cheats or Scripts or Mods, you are simply bad in CS";
[25] = "you just got pwned by csGOD, the #1 in raping CS:GO cheaterz";
[26] = "If I was cheating. Id never use www.EZfrags.co.uk";
[27] = "u still believe you could do better? Not with your shitty hack";
[28] = "Ouuu _name_vic_ got [x]rekt  [ ]not_rekt !!";
[29] = "Im not trash talking, Im talking to trash";
[30] = "Stephen Hawking has better hand-eye coordination than you.";
[31] = "_name_vic_ better leave game bra";
[32] = "lmao _name_vic_, nice config.. u sell?";
[33] = "you are the reason abortion was legalized";
[34] = "u got rekt NoBrainer";
[35] = "shut up _name_vic_ nn";
[36] = "nn dogs still got 1tap$";
[37] = "_name_vic_ u r ez";
[38] = "_name_vic_ just ez free frag dog";
[39] = "too ez nn _name_vic_";
[40] = "ez dog sit down";
[41] = "u got rekt nn";
[42] = "ez 1tap$ on head$";
[43] = "god i wish i had moneybot";
[44] = "go rq already nn";
[45] = "_name_vic_ got owned";
[46] = "1";
[47] = "1tap$ HAHAHAHAHHAHA";
[48] = "thats a ONE on my screen";
[49] = "Nice _name_vic_, you just bought a $4750 decoy.";
[50] = "its a 1.. 1.. 1.. eeeez 1";
[51] = "u suck hard so sit down dog";
[52] = "sit down nn dog";
[53] = "_name_vic YOU'RE PRETTY BAD";
[54] = "Missed again.";
[55] = "scrub";
[56] = "HAD FUN GETTING ROLLED?",
[57] = "_name_, get rolled, K?",
[58] = "Sorry _name_vic_, try again.";
[59] = "_name_vic_ can't even hit me";
[60] = "2fast4u";
[61] = "What is this today, it´s nigger day?";
[62] = "oof 1";
[63] = "got pOwned";
[64] = "get ur team and come 5v5 p*ssy";
[65] = "_name_vic_*Dead* ..but still talking";
[66] = "come 5v5 p*ssy";
[67] = "b1g EzFrags user";
[68] = "_name_vic_ nn fgt";
[69] = "sit down _name_vic_ u spastic homo";
[70] = "why r u even here _name_vic_?";
[71] = "still rape ur dog corpse";
[72] = "_name_vic_ refund $$$PRIVATE$$$ ayyware faggot";
[73] = "imagine getting killed by a MAC hvher";
[74] = "uff ya nice dead";
[75] = "_name_vic_ is a nice gay k/d-bitchass";
[76] = "im literally using aimtux wtf";
[77] = "..and you lose again _name_vic_.";
[78] = "_name_vic_, you seriously think you can run from me?";
[79] = "Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
[80] = "Stop being a noob! Get good with www.EZfrags.co.uk",
[81] = "I'm not using www.EZfrags.co.uk, you're just bad",
[82] = "You just got pwned by EZfrags, the #1 CS:GO cheat",
[83] = "If I was cheating, I'd use www.EZfrags.co.uk",
[84] = "Think you could do better? Not without www.EZfrags.co.uk",
[85] = "Destroyed by x22cheats.omg haha"




}		
	   
	   
local Deathsays = {
[1] = "yi bench your moms weight everyday shits tuffou just a lucker";
[2] = "i get dunked on sweaty n3rd fall seven times and stand up eight";
[3] = "_name_att_ when you write 1 in chat, all i see is a little whiny doggo who proofs that stupid fools are always lucky";
[4] = "kk.. killed me 1 time but I rape your whole life";
[5] = "as usual a dull dog only got kills with bodyshots";
[6] = "your brain not enough to put hitbox on the head? nn bot";
[7] = "oof";
[8] = "haha dumb dog. first time killed me for a year";
[9] = "_name_att_ you are right. fools are lucky. you are the proof";
[10] = "a normal day of a dog who needs baimkills to stay in scoreboard.";
[11] = "oh shit.. my aa turned off somehow -.-";
[12] = "oh shit.. i forgot to inject";
[13] = "ns dog.. but it was only lucky timing";
[14] = "kys";
[15] = "_name_att_ u fuckin lucker.. go hang yourself";
[16] = "nice 1way loser";
[17] = "baim is gay but its fits your style the most";
[18] = "nice gay fucking retard";
[19] = "as usual a dull dog can only kill when using baim.";
[20] = "ty _name_att_, for proof that stupid fools are always lucky";
[21] = "cya _name_att_";
[22] = "oh noooo";
[23] = ";((" ;
[24] = "rip _name_att_";
[25] = "*dab*";
[26] = ":dab:";
[27] = "uhh";
[28] = "*ded*";
[29] = "saddd";
[30] = "stupid dog teammates";
[31] = "awful teamm8s never backup"

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

    hitPlayerName = NAME_Victim;

   
   if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

       --random = math.random (1, 19)
       --client.ChatSay( ' ' .. tostring( Kill_String[random]));
	local response = tostring(killsays[math.random(#killsays)]);
    response = response:gsub("_name_vic_", NAME_Victim);
	client.ChatSay( ' ' .. response );

   elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

       --random = math.random (1, 10)
       --client.ChatSay( ' ' .. tostring( Death_String[random]));
	local response = tostring(deathsays[math.random(#deathsays)]);
    response = response:gsub("_name_att_", NAME_Attacker);
    client.ChatSay( ' ' .. response );

   end

end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );