function on_knife_righthand(Event)    
     if (Event:GetName() ~= 'item_equip') then
        return;
     end

    if (client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(Event:GetInt('userid'))) then
        if Event:GetString('item') == "knife" then
            client.Command( "cl_righthand 0", true );
        else
            client.Command( "cl_righthand 1", true );
        end
    end
end

client.AllowListener('item_equip');
callbacks.Register("FireGameEvent", "on_knife_righthand", on_knife_righthand)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

