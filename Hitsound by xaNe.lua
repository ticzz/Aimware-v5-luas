local Hitsound_tab = gui.Groupbox(gui.Reference( "Visuals", "World","Extra"), "HitSound")
local AWHitsoundchkbx = gui.Checkbox(Hitsound_tab, "lua_hitsound_active", "Enable Hitsounds[xaNe]", true)
--local mhvolume = gui.Slider( Hitsound_tab, "mhvolume", "Volume", 100, 0, 100)


local function HitGroup( INT_HITGROUP )
   if INT_HITGROUP == 0 then
       return "body";
   elseif INT_HITGROUP == 1 then
       return "head";
   elseif INT_HITGROUP == 2 then
       return "chest";
   elseif INT_HITGROUP == 3 then
       return "stomach";
   elseif INT_HITGROUP == 4 then 
       return "left arm";
   elseif INT_HITGROUP == 5 then 
       return "right arm";
   elseif INT_HITGROUP == 6 then 
       return "left leg";
   elseif INT_HITGROUP == 7 then 
       return "right leg";
   elseif INT_HITGROUP == 8 then 
       return "hitbox 8";
   elseif INT_HITGROUP == 9 then 
      return "hitbox 9";
   elseif INT_HITGROUP == 10 then 
       return "body";
   end
end

local function on_player_hurt_or_death(Event)
			

	if not AWHitsoundchkbx:GetValue() then return end

					
		local LOCAL_PLAYER = client.GetLocalPlayerIndex();
		local ID_VICTIM, ID_ATTACKER, HITGROUP = Event:GetInt("userid"), Event:GetInt("attacker"), Event:GetInt("hitgroup");
		local INDEX_VICTIM, INDEX_ATTACKER = client.GetPlayerIndexByUserID(ID_VICTIM), client.GetPlayerIndexByUserID(ID_ATTACKER);

if (Event:GetName() == "player_hurt") then

	if (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER and HITGROUP == 1) then
		--volume = gui.GetValue("mhvolume");
		client.Command("play */f12 Killsounds/voice_input_iizi.wav", true);		-- */rust_hs.wav (headshot sound)
		end
	
	if (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER and HITGROUP ~= 1) then
		--volume = gui.GetValue("mhvolume");
		client.Command("play */awcustom/oooff.wav", true);  --  sound\\misc\\m1.wav (bodyhit sound)
		end
	
	
if (Event:GetName() == "player_death") then
	
	if (INDEX_ATTACKER == LOCAL_PLAYER and INDEX_VICTIM ~= LOCAL_PLAYER) then
		--volume = gui.GetValue("mhvolume");
		client.Command("play */awcustom/mlg.wav", true);
		end
end
end
end

client.AllowListener( "player_death" )
client.AllowListener( "player_hurt" )
callbacks.Register( "FireGameEvent",  on_player_hurt_or_death)


--*/awcustom/csgo_chainsaw_laugh.wav

callbacks.Register('Draw',function()
	if(AWHitsoundchkbx:GetValue()) then
		gui.SetValue("esp.world.hiteffects.sound", "Off");
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")