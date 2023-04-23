function on_nade(Event)
    if (Event:GetName() ~= 'grenade_thrown' or entities.GetLocalPlayer() == nil) then
        return
    end

    local weapon = Event:GetString('weapon')

    if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
        if (weapon == "hegrenade") then
            client.ChatSay("Catch retard!")
        elseif (weapon == "flashbang") then
            client.ChatSay("Look a bird!");
        elseif (weapon == "molotov") then
            client.ChatSay("BURN BABY BURN!!!");
        elseif (weapon == "smokegrenade") then
            client.ChatSay("I am a ninja");
        elseif(weapon == "incgrenade") then
            client.ChatSay("BURN BABY BURN!!!");
        end
    end     
end

client.AllowListener('grenade_thrown');
callbacks.Register("FireGameEvent", "nadesay", on_nade);
