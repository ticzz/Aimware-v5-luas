local ref = gui.Reference('Misc', 'Enhancement', 'Appearance')
local on = gui.Checkbox(ref, "killsay.enable", "Enable Killsay", false)

local killsays = {    
[1] = "_name_ better uninstall your hacks.",    
[2] = "How do you hack and lose, _name_?",    
[3] = "More bad like _name_ please.",    
[4] = "HAHAHAHAHAHA _name_",    
[5] = "WOOOOOOOOOOW",    
[6] = " _name_, get a refund, if u can...",    
[7] = "How bad are you, _name_?",    
[8] = "Wow, didn't even hit me once, _name_.",    
[9] = "Wow more bad please, _name_.",    
[10] = "Get on my level, _name_.",    
[11] = "And that is how you win a HvH ladies and gentlemen.",    
[12] = "You missed... again",    
[13] = "You re a Scrub _name_",    
[14] = "#cantresolveaimware.@_name_",    
[15] = "You're bad, _name_",    
[16] = "So mad.",    
[17] = "_name_ sucks.",    
[18] = "_name_ is so fucking bad.",    
[19] = "I hope you didn't pay for those crap, _name_.",    
[20] = "You think you can run from me, _name_?!",    
[21] = "Wow, _name_ cheats and calls me pathetic.",    
[22] = "You seriously think you can run from me?",    
[23] = "You're complete garbage, _name_.",    
[24] = "Why can't you defeat me, _name_?",    
[25] = "WHAT A BABY!",    
[26] = "Just uninstall and don't come back, _name_.",    
[27] = "How did you pay money for items and still suck at this game, _name_?",    
[28] = "Why are you so bad, _name_?",    
[29] = "OH YOU DIED AGAIN! HAHAHAAHAH!",    
[30] = "Fucking uninstall this game you're so trash, _name_.",    
[31] = "F IN CHAT.",    
[32] = "I don't think you can get any more mad right now, _name_.",    
[33] = "I fucking really wanna know how you're so bad at this game, _name_.",    
[34] = "You're fucking trash, _name_.",    
[35] = "You wanna 1v1 me?",    
[36] = "2bad4me",    
[37] = "Uninstall.",    
[38] = "Go Fuck Yourself With A Spoon, _name_.",
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
[77] = "SUCH A BADDIE",
[78] = "_name_ YOU'RE PRETTY BAD",
[79] = "HOW DO YOU HACK AND LOSE YOU NIGGER",
[80] = "WHAT A BADDIE",
[81] = "BAD",
[82] = "2bad",
[83] = "SO BAD",
[84] = "NOPE",
[85] = "YOU CAN'T EVEN KILL ME",
[86] = "Owned.",
[87] = "HAD FUN GETTING ROLLED?",
[88] = "_name_, get rolled, K?",
[89] = "Wow, he cheats and calls me pathetic.",
[90] = "_name_, you seriously think you can run from me?",
[91] = ":)",
[92] = "Scrub.",
[93] = "Missed again.",
[94] = "You can't even hit me with normal aimbot.",
[95] = "So mad.",
[96] = "You so bad.",
[97] = "Bad.",
[98] = "Can't beat me?",
[99] = "Those are some bad hacks you got there.",
[100] = "Sorry try again."
}

local function CHAT_KillSay( Event )        

	if not on:GetValue() == true then return else
 
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
	
		end end       
	end    
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay )


--***********************************************--

local on_kds_ks = gui.Checkbox(ref, "killdeathsorry.say.enable", "Enable KillDeathSorry Say", false)
local sorrytbl = {"am sorry that","am feeling sad after","am distressed because","am upset with myself because","have been diagnosed with depression because","am broken hearted that","apologize that","would like to apologize because","am quite remorseful because","am ashamed of myself because"};
local killtbl = {"killed","destroyed","put an end to","ended","assassinated","terminated","eliminated","executed","slaughtered","butchered","shot and killed"};
local regrettbl = {":(","Please forgive me","I didn't mean to.","I'm a failure","I will go easy on you next time.","That was my fault","Please excuse my behaviour"};

local function KillDeathSorrySay( Event )


	if not on_kds_ks:GetValue() == true then return else
   if ( Event:GetName() == 'player_death' ) then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

           client.ChatSay(NAME_Victim  .. ", I " .. sorrytbl[math.random( #sorrytbl )] .. " I " .. killtbl[math.random( #killtbl )] .. " you. " .. regrettbl[math.random( #regrettbl )]);

       end
	end
   end
end


client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKDSS', KillDeathSorrySay );


--***********************************************--

--different name spammer by lntranets

local text_box = gui.Editbox(ref, 't_box', 'Name')

local switch = false
local switch2 = false

-- buttons
local ui_button = gui.Button(ref, 'Set Name', function()
 switch = true
end)

local ui_button2 = gui.Button(ref, 'Set Long Name', function()
 switch2 = true
end)
--------------------------

-- handle button press
callbacks.Register('Draw', function()
 if switch then
 local get_t = gui.GetValue('misc.t_box')
 client.SetConVar('name', get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ' .. get_t .. ' ', 1)
 end
end)

callbacks.Register('Draw', function()
 if switch2 then
 local get_t = gui.GetValue('misc.t_box')
 client.SetConVar('name', get_t .. '                                                                                            ', 1)
 end
end)
--------------------------









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

