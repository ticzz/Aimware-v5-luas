-- Thank you for using my script. If you like it recommend me. Special Thanks to superyu'#7167 who helped me with the auto updates. Also some of the Spams are copied but I can't find the source.

-- Hit me up on discord to request new features and maybe I add them.

-- If you want to add your own Spams just add them in a new line below, but make sure you have a "," above.

local author = "DaveLTC";
local discord = "https://discord.gg/6FWJDDm";

local Kill_BM_Spams = {
    "so ez",
    "get clapped",
    "did that hurt?",
    "do you want me to blow on that?",
    "btw you are supposed to shoot me.",
    "sry I didn't know you were retarded",
    "Is your screen even on?",
    "CSGO->Game->Game->TurnOnInstructorMessages that might help you",
    "better luck next time",
    "bro how did you hit the accept button with that aim???",
    "ff?",
    "I can teach you if you want.",
    "xD my cat killed you",
    "better do you homework",
    "Which controller are you using???",
    "Did you ever think about suicide? It would make things quicker.",
    "is that a decoy, or are you trying to shoot somebody?",
    "If this guy was the shooter harambe would still be alive",
    "CS:GO is too hard for you m8 maybe consider a game that requires less skill, like idk.... solitaire"
};
local Death_BM_Spams = {
    "nice luck",
    "sry my brother was playing",
    "doesn't count my mom came in",
    "ok now I start playing",
    "I think you should be in bed already",
    "welcome to the scoreboard",
    "Theres more silver here than in the cutlery drawer",
    "I'm not trash talking, I'm talking to trash.",
    "We may have loose the game, but at the end of the day we, unlike you, are not russians.",
    "Dude you're so fat you run out of breath rushing B",
    "Rest in spaghetti never forgetti",
    "LISTEN HERE YOU LITTLE FUCKER, WHEN I WAS YOUR AGE, PLUTO WAS A PLANET!"
};
local General_BM_Spams = {
    "I smell your drunk mom from here.",
    "I'm the reason your dad's gay",
    "If you were a CSGO match, your mother would have a 7day cooldown all the time, because she kept abandoning you.",
    "If I were to commit suicide, I would jump from your ego to your elo.",
    "You sound like your parents beat each other in front of you",
    "My knife is well-worn, just like your mother",
    "You're the human equivalent of a participation award.",
    "Did you grow up near by Tschernobyl or why are you so toxic?"
};



-- Better Spam Tab
local ref = gui.Tab(gui.Reference("Misc"), "better_spam.settings", "Better Spam")

--Kill BM Spam
local Kill_BM_Group = gui.Groupbox(ref, "Kill Message", 15, 15, 294);
local Kill_BM_Act = gui.Combobox( Kill_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local Kill_BM_Edit = gui.Editbox( Kill_BM_Group, "lua_editbox", "custom message:");
local Kill_BM_STAN_NAME = gui.Checkbox( Kill_BM_Group,"lua_checkbox" , "activate @player name", false);

--Death BM Spam
local Death_BM_Group = gui.Groupbox(ref, "Death Message", 327, 15, 294);
local Death_BM_Act = gui.Combobox( Death_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local Death_BM_Edit = gui.Editbox( Death_BM_Group, "lua_editbox", "custom message:");
local Death_BM_STAN_NAME = gui.Checkbox( Death_BM_Group,"lua_checkbox" , "activate @player name", false);

--General BM Spam
local General_BM_Group = gui.Groupbox(ref, "Spam Message", 15, 230, 607);
local General_BM_Act = gui.Combobox( General_BM_Group, "lua_combobox", "Enable", "off", "standard", "custom" );
local General_BM_Edit = gui.Editbox( General_BM_Group, "lua_editbox", "custom message:");
local General_BM_Speed = gui.Slider( General_BM_Group, "lua_slider","Delay in Seconds" , 10,1,60)

--General Spam Timer
local last_message = globals.TickCount();
function GeneralSpam()
    if ( globals.TickCount() - last_message < 0 ) then
        last_message = 0;
    end;

    local spammer_speed = General_BM_Speed:GetValue() *60;
    if ( General_BM_Act:GetValue()==1 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay( ' ' .. tostring( General_BM_Spams[math.random(1,table.getn(General_BM_Spams))] ));
        last_message = globals.TickCount();
    elseif ( General_BM_Act:GetValue()==2 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay(General_BM_Edit:GetValue());
        last_message = globals.TickCount();
    end
end



--Kill/Death Trigger
local function CHAT_KillSay( Event )

   if ( Event:GetName() == 'player_death' ) then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME) then
            if (Kill_BM_Act:GetValue()==1) then
                if(Kill_BM_STAN_NAME:GetValue()==true) then
                    client.ChatSay( ' ' .. tostring( Kill_BM_Spams[math.random(1,table.getn(Kill_BM_Spams))] ) .. ' @' .. NAME_Victim );
                else
                    client.ChatSay( ' ' .. tostring( Kill_BM_Spams[math.random(1,table.getn(Kill_BM_Spams))] ));
                end

            elseif (Kill_BM_Act:GetValue()==2) then
                if(Kill_BM_STAN_NAME:GetValue()==true) then
                    client.ChatSay(Kill_BM_Edit:GetValue() .. ' @' .. NAME_Victim );
                else
                    client.ChatSay(Kill_BM_Edit:GetValue());
                end
            end
        elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME and Death_BM_Act:GetValue()==1) then
            if (Death_BM_Act:GetValue()==1) then
                if(Death_BM_STAN_NAME:GetValue()==true) then
                    client.ChatSay( ' ' .. tostring( Death_BM_Spams[math.random(1,table.getn(Death_BM_Spams))] ) .. ' @' .. NAME_Victim );
                else
                    client.ChatSay( ' ' .. tostring( Death_BM_Spams[math.random(1,table.getn(Death_BM_Spams))] ));
                end

            elseif (Death_BM_Act:GetValue()==2) then
                if(Death_BM_STAN_NAME:GetValue()==true) then
                    client.ChatSay(Death_BM_Edit:GetValue() .. ' @' .. NAME_Victim );
                else
                    client.ChatSay(Death_BM_Edit:GetValue());
                end
            end

        end

    end

end

callbacks.Register( "Draw", GeneralSpam );

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', CHAT_KillSay )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

