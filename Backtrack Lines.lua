-- Backtrack Lines by Nyanpasu!

-- Configuration --
local RainbowTrail = true; -- If this is set to false, "clr_chams_historyticks" will be used instead 
local ExpiredTick_Color = {100, 100, 100, 255}; -- The color of the ticks that aren't valid anymore
local Legitbot_ThroughWalls = false; -- By default the line isn't visible through walls when using the Legitbot backtrack
local DrawDots = 0; -- Using a value greater than 0 will draw boxes instead of lines
-------------------

local Players = {};
local lastPos = {nil, nil};

RunScript("EssentialsNP.lua");

local function EventCallback(GameEvent)
	if GameEvent:GetName() == "round_start" or GameEvent:GetName() == "round_prestart" then
		Players = {};
	end
end

local function DrawingCallback()

	LocalPlayer = entities.GetLocalPlayer();

	for index, Player in pairs(entities.FindByClass("CCSPlayer")) do			
		
		-- Don't mess with these unless you know what you're doing
		local Backtrack = false;
		local FriendlyFire = false;
		local FakeLatency = 0;
		local Legitbot = false;
		
		if gui.GetValue("rbot.accuracy.posadj.backtrack") and gui.GetValue("rbot.aim.enable") then
			Backtrack = true;
		elseif gui.GetValue("lbot.posadj.backtrack") and gui.GetValue("lbot.aim.enable") then
			Backtrack = true;
			Legitbot = true;
		end
		
		if Backtrack then
		
			if gui.GetValue("misc.master") and gui.GetValue("misc.fakelag.enable") then
				FakeLatency = gui.GetValue("misc.fakelag.factor");
			end

			if Player:GetIndex() ~= LocalPlayer:GetIndex() and (LocalPlayer:GetTeamNumber() ~= Player:GetTeamNumber()) and Player:IsAlive() then
				
				lastTick = {nil, nil};			
				
				if Players[Player:GetIndex()] == nil then
					Players[Player:GetIndex()] = {};
				end
						
				table.insert(Players[Player:GetIndex()], {{Player:GetHitboxPosition("HITGROUP_HEAD")}, globals.RealTime()});
				
				for indexHistory, valueHistory in pairs(Players[Player:GetIndex()]) do	
					
					if valueHistory[2] + 0.2 + FakeLatency < globals.RealTime() then
						table.remove(Players[Player:GetIndex()], indexHistory);
					else
						
						local VisibilityBlock = false;
						local TickX, TickY = client.WorldToScreen(valueHistory[1][1], valueHistory[1][2], valueHistory[1][3]);
						
						local LocalPlayerHead = {LocalPlayer:GetHitboxPosition("HITGROUP_HEAD")};
						
						if Legitbot and Legitbot_ThroughWalls == false then	
							if engine.TraceLine( valueHistory[1][1], valueHistory[1][2], valueHistory[1][3], 
							LocalPlayerHead[1], LocalPlayerHead[2], LocalPlayerHead[3], 1) == 1 then
								VisibilityBlock = true;		
							end
						end
						
						if TickX ~= nil and TickY ~= nil and not VisibilityBlock then
							local TickColor = {};
							if valueHistory[2] - 0.2 <= globals.RealTime() - FakeLatency then
								if RainbowTrail then
									TickColor = EssentialsNP.Drawing.Hue(valueHistory[2]);
									TickColor[4] = 255;
								else		
									TickColor = {gui.GetValue("esp.chams.backtrack.visible.clr")};
								end
							else
								TickColor = ExpiredTick_Color;
							end
								
							draw.Color(TickColor[1], TickColor[2], TickColor[3], TickColor[4]);
							
							if DrawDots >= 1 then
								draw.FilledRect(TickX - DrawDots, TickY - DrawDots, TickX + DrawDots,  TickY + DrawDots);
							else		
								if lastTick[1] ~= nil and lastTick[2] ~= nil then
									draw.Line(TickX, TickY, lastTick[1], lastTick[2]);
								end		
								
								lastTick = {TickX, TickY};
							end
						end				
					end
				end
			end
		end
	end
end

-- Backtrack Lines by Nyanpasu!

client.AllowListener("round_start");
client.AllowListener("round_prestart");
callbacks.Register("Draw", "backtrackable_line_draw", DrawingCallback);
callbacks.Register("FireGameEvent", "backtrackable_line_event", EventCallback)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

