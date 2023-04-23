---------- MENU ----------

local GuiReference = gui.Reference("Settings")
local KillsayTab = gui.Tab(GuiReference, "Customkillsaytab", "Custom KIllsay");
local KillsayGroupBox = gui.Groupbox(KillsayTab,"Killsay Groupbox");
local KillsayCheckBox = gui.Checkbox(KillsayGroupBox,"KillsayCheckBox","Enable Kill Say",false);
local KillsayText = gui.Editbox(KillsayGroupBox,"KillsayTextBox","Killsay Text");
local DeathsayText = gui.Editbox(KillsayGroupBox,"DeathsayTextBox","Deathsay Text");


---------- KIllsay ----------

local Kill_String = " ";
local function CHAT_KillSay(Event)

	if not KillsayCheckBox:GetValue() then return end
	
	if (Event:GetName() == "player_death") then
       local ME = client.GetLocalPlayerIndex();
       local INT_ATTACKER = Event:GetInt("attacker");
       local NAME_Victim = client.GetPlayerNameByUserID(INT_UID);
       local INDEX_Attacker = client.GetPlayerIndexByUserID(INT_ATTACKER);
    
	if (INDEX_Attacker == ME and INDEX_Victim ~= ME) then
			client.ChatSay(KillsayText:GetValue().. ' ' .. NAME_Victim);
	
	elseif (INDEX_Victim == ME and INDEX_Attacker ~= ME) then
			client.ChatSay(DeathsayText:GetValue().. ' ' .. NAME_Attacker );

       end
	end
end
client.AllowListener("player_death");
callbacks.Register("FireGameEvent","AWKS",CHAT_KillSay);














--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

