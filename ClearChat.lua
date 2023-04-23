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


-------------- Chat Spammer
local G_M1 = gui.Tab(gui.Reference("Misc"), "extra.settings", "Extra")
local CC_Show = gui.Checkbox(G_M1, "msc_chat_spams", "Start/Stop ChatSpammer", false)
local CC_W = gui.Window("CC_W", "Chat Spam", 200,200,200,380)
local CC_G1 = gui.Groupbox(CC_W, "Chat Spams", 15, 15, 170, 224)
local CC_Spams = gui.Combobox(CC_G1, "CC_Spam", "Spams", "Off", "Spam 1", "Spam 2", "Clear Chat")
local CC_Spam_spd = gui.Slider(CC_G1, "CC_Spam_Speed", "Spam Speed", 67.5, 10, 250)
local chatspam1txt = gui.Text(CC_G1, "Spam 1") local ChatSpam1 = gui.Editbox(CC_G1, "CC_Spam1", "Custom Chat Spam 1")
local chatspam2txt = gui.Text(CC_G1, "Spam 2") local ChatSpam2 = gui.Editbox(CC_G1, "CC_Spam2", "Custom Chat Spam 2")

local c_spammedlast = globals.RealTime() + CC_Spam_spd:GetValue()/100
local function custom_chat()
CC_W:SetActive(gui.Reference("Menu"):IsActive())

if CC_Show:GetValue() ~= true then return end

 if CC_Spams:GetValue() == 0 then return
elseif CC_Spams:GetValue() == 1 and globals.RealTime() >= c_spammedlast then client.ChatSay(ChatSpam1:GetValue()) c_spammedlast = globals.RealTime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 2 and globals.RealTime() >= c_spammedlast then client.ChatSay(ChatSpam2:GetValue()) c_spammedlast = globals.RealTime() + CC_Spam_spd:GetValue()/100
elseif CC_Spams:GetValue() == 3 and globals.RealTime() >= c_spammedlast then client.ChatSay("﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽\n") c_spammedlast = globals.RealTime() + CC_Spam_spd:GetValue()/100 end 
end
callbacks.Register("Draw", custom_chat)



