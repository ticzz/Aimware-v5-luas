--[[
CPU AUTO By Miniminter
--]]
local SetValue = gui.SetValue;
local FCPU = 25.0;
local function CPUCHECK( Event )  
            if ( Event:GetName() ~= "item_equip" ) then
                return;
            end
            local ME = client.GetLocalPlayerIndex();
            local INT_UID = Event:GetInt( "userid" );
            local PlayerIndex = client.GetPlayerIndexByUserID( INT_UID );
            local WepType = Event:GetInt( "weptype" );
            local Item = Event:GetString( "item" );
            if ( ME == PlayerIndex ) then
                if ( Item == "ssg08" ) then
                  FCPU = 75.0
                elseif ( Item == "g3sg1" ) then
              FCPU = 25.0
             elseif ( Item == "scar20" ) then
      		 FCPU = 25.0
                else
                  FCPU = 60.0
	            end
	    gui.SetValue("rbot.hitscan.maxprocessingtime",FCPU );
            end
end

client.AllowListener( "item_equip" )
callbacks.Register( "FireGameEvent", "CPUCHECK", CPUCHECK)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

