local killsays = {
   [1] = "Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
   [2] = "Stop being a noob! Get good with www.EZfrags.co.uk",
   [3] = "I'm not using www.EZfrags.co.uk, you're just bad",
   [4] = "You just got pwned by EZfrags, the #1 CS:GO cheat",
   [5] = "If I was cheating, I'd use www.EZfrags.co.uk",
   [6] = "Think you could do better? Not without www.EZfrags.co.uk",

}

local function CHAT_KillSay( Event )
   
	if ( Event:GetName() == 'player_death' ) then
       
			local ME = client.GetLocalPlayerIndex();
			
			local INT_UID = Event:GetInt( 'userid' );
			local INT_ATTACKER = Event:GetInt( 'attacker' );
			
			local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
			local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
			
			local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
			local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
       
		if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then

			client.ChatSay(' ' .. tostring(killsays[math.random(#killsays)]) .."");  -- ' ' .. NAME_Victim

--		elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME ) then

--          client.ChatSay( ' ' .. tostring(deathsays[math.random(#deathsays)]).. );  -- ' ' .. NAME_Attacker
		   
		end
   
	end
   
end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

