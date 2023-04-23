--[[local Chat_Breaker_Spam = {
    "﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽",
};
local ref = gui.Tab(gui.Reference("Misc"), "extra.settings", "Extra")
local Chat_Breaker_Group = gui.Groupbox(ref, "Spam Message", 16, 20, 297);
local Chat_Breaker_Act = gui.Combobox( Chat_Breaker_Group, "lua_combobox", "Enable", "off", "ChatBreaker", "custom" );
local Chat_Breaker_Edit = gui.Editbox( Chat_Breaker_Group, "lua_editbox", "custom message:");
local Chat_Breaker_Speed = gui.Slider( Chat_Breaker_Group, "lua_slider","Delay in Seconds" , 10,0.1,60)
local last_message = globals.TickCount();
function ChatSpam()
    if ( globals.TickCount() - last_message < 0 ) then
        last_message = 0;
    end;
    local spammer_speed = Chat_Breaker_Speed:GetValue() *60;
    if ( Chat_Breaker_Act:GetValue()==1 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay( ' ' .. tostring( Chat_Breaker_Spam[math.random(1,table.getn(Chat_Breaker_Spam))] ));
        last_message = globals.TickCount();
    elseif ( Chat_Breaker_Act:GetValue()==2 and globals.TickCount() - last_message > (math.max(22, spammer_speed)) ) then
        client.ChatSay(Chat_Breaker_Edit:GetValue());
        last_message = globals.TickCount();
    end
end
callbacks.Register( "Draw", "ChatSpam", ChatSpam );
]]


-------------- 


local G_M1 = gui.Tab(gui.Reference("Misc"), "extra.settings", "Extra")
local CC_Show = gui.Checkbox(G_M1, "msc.chat.spams", "Start/Stop ChatSpammer", false)
local Killsay = gui.Checkbox(G_M1, "msc.chat.killsay", "Enable/Disable Killsay", false)
local MissedShotsChatSay = gui.Checkbox(G_M1, "msc.chat.missedshotchatsay", "Enable/Disable MissedShotChat", false)


local CC_W = gui.Window("CC_W", "Chat Spam", 200,200,200,380)
local CC_G1 = gui.Groupbox(CC_W, "Chat Spams", 15, 15, 170, 224)
local CC_Spams = gui.Combobox(CC_G1, "CC.Spam", "Spams", "Off", "Spam 1", "Spam 2", "Clear Chat")
local CC_Spam_dly = gui.Slider(CC_G1, "CC.Spam_Delay", "Spam Delay", 67.5, 10, 250)
local chatspam1txt = gui.Text(CC_G1, "Spam 1") local ChatSpam1 = gui.Editbox(CC_G1, "CC_Spam1", "Custom Chat Spam 1")
local chatspam2txt = gui.Text(CC_G1, "Spam 2") local ChatSpam2 = gui.Editbox(CC_G1, "CC_Spam2", "Custom Chat Spam 2")

 c_spammedlast = globals.RealTime() + CC_Spam_dly:GetValue()/100
local function custom_chat()
CC_W:SetActive(gui.Reference("Menu"):IsActive())

if CC_Show:GetValue() ~= true then return end

 if CC_Spams:GetValue() == 0 then return
elseif CC_Spams:GetValue() == 1 and globals.RealTime() >= c_spammedlast then client.ChatSay(ChatSpam1:GetValue()) c_spammedlast = globals.RealTime() + CC_Spam_dly:GetValue()/100
elseif CC_Spams:GetValue() == 2 and globals.RealTime() >= c_spammedlast then client.ChatSay(ChatSpam2:GetValue()) c_spammedlast = globals.RealTime() + CC_Spam_dly:GetValue()/100
elseif CC_Spams:GetValue() == 3 and globals.RealTime() >= c_spammedlast then client.ChatSay("﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽\n") c_spammedlast = globals.RealTime() + CC_Spam_dly:GetValue()/100 end 
end
callbacks.Register("Draw", custom_chat)

--------------------------------------------------------------------------------------------

local killsays =
{

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

local function CHAT_KillSay( Event )
   
   if Killsay:GetValue() ~= true then return end;
   
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

----------------------------------------------------------

local gun_fired = false

local ern_other_weapons =
{
    "knife",
    "knife_t",
    "hegrenade",
    "smokegrenade",
    "molotov",
    "incgrenade",
    "flashbang",
    "decoy",
    "taser"
}

local ern_shots =
{
    fired = 0,
    hit = 0,
    missed = 0,
    hit_chance = 0,
    miss_chance = 0
}

local function reset_shots()

    for index, shot in pairs(ern_shots) do

        ern_shots[index] = 0

    end

end

local function is_gun(weapon_name)

    for index, weapon in ipairs(ern_other_weapons) do
       
        if(weapon_name == "weapon_"..weapon) then

            return false

        end

    end

    return true

end

local function update_shots(event)

    if( entities.GetLocalPlayer() == nil or not MissedShotsChatSay:GetValue() ) then

        reset_shots()

        return -1

    end

    local event_name = event:GetName()
   
    local local_player_index = client.GetLocalPlayerIndex()
    local local_player_info = client.GetPlayerInfo(local_player_index)


    

    if(event_name == "player_hurt") then

        local attacker_id = event:GetInt("attacker")
        local attacker_weapon = event:GetString("weapon")

        if( local_player_info["UserID"] == attacker_id and is_gun(attacker_weapon) and gun_fired) then

            ern_shots.hit = ern_shots.hit + 1
            gun_fired = false

        end
		
	elseif(event_name == "weapon_fire") then

        local player_id = event:GetInt("userid")
        local player_weapon = event:GetString("weapon")

        if(local_player_info["UserID"] == player_id and is_gun(player_weapon)) then

            ern_shots.fired = ern_shots.fired + 1
            gun_fired = true

        end
    elseif( event_name == "round_prestart") then

        reset_shots()

    end
end

local function main()
w, h = draw.GetScreenSize()

    if( entities.GetLocalPlayer() == nil or not MissedShotsChatSay:GetValue() ) then

        return -1

    end


    if(ern_shots.hit > 0) then

draw.TextShadow(50, 50, "[x22cheats.com] Hits the shot")
print("Aimware: Hits bitchniggas ass")

    if(ern_shots.hit == 1 or ern_shots.missed == 1) then

ern_shots.hit = ern_shots.hit - 1

ern_shots.missed = ern_shots.fired - ern_shots.hit

if (ern_shots.missed > 0 or ern_shots.missed == 1) then

draw.TextShadow(50, 50, "[x22cheats.com] Missed shot due to spread")
print("Aimware: Failed on teabagged bitch")
  
ern_shots.fired = ern_shots.fired - 1
ern_shots.missed = ern_shots.missed - 1


                    end
              end
         end
end




client.AllowListener("weapon_fire")
client.AllowListener("player_hurt")
client.AllowListener("round_prestart")

callbacks.Register("FireGameEvent", update_shots)
callbacks.Register("Draw",  main)