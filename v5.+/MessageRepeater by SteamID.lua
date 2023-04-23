local ref = gui.Reference('Misc', 'General', 'Extra')
local parrot = gui.Checkbox(ref, 'parrotmsgbysteamid', 'Enable Chat parrot', false)
local SteamIDhere = gui.Editbox(ref, 'repeatsteamid', 'SteamID of Player whos msg you want parrot')
SteamIDhere:SetInvisible(not parrot:GetValue())
local function UserMessageCallback(msg)
if not parrot:GetValue() then return end
    if msg:GetID() == 6 then
        local index = msg:GetInt(1);
        local message = msg:GetString(4, 1);
        local sender = client.GetPlayerInfo(index);
        if SteamIDhere:GetValue() then
            if sender.SteamID == SteamIDhere:GetValue() then
                if message:byte(1) == 32 then
                        client.ChatSay(message);
                end
            end
        else
            if message:byte(1) == 32 then
                client.ChatSay(message);
            end
        end
    end
end
callbacks.Register("DispatchUserMessage", "UserMessageExample", UserMessageCallback)

--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")