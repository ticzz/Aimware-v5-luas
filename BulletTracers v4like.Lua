-- Local tracer Lua by Scape

-- Thanks to Clipper for help fixing the flcikering
--			 Bean07 for discovering a bug with localPlayer
--			 Chicken4676 for a w2s ductTape fix

-- TODO: Real m_vecViewOffset calculation
--		 Fix tracer height during fakeduck
-- 		 Either wait for w2s offScreen bug fix or create my own w2s function
--		 Fix Color Settings window as it looks absolutely terrible


-------------------------------------GUI setup-------------------------------------
local ref = gui.Reference("Visuals", "World");
local tracerSettings = gui.Groupbox(ref, "Tracer Settings", 328, 216, 296, 400); -- This looks lines up properly idk why values are so disgusting
local tracerColors = gui.Groupbox(ref, "Tracer Colors", 16, 390, 296, 400);

local refSettings = gui.Reference("Visuals", "World", "Tracer Settings");
local refColor = gui.Reference("Visuals", "World", "tracer Colors");

local enableCheckbox = gui.Checkbox(refSettings, "lua_tracer", "Enable Tracers", true);
enableCheckbox:SetDescription("Enable tracers globaly");

local tracerTeams = gui.Multibox(refSettings, "Team Select");
local teamTracers = gui.Checkbox(tracerTeams, "lua_team_tracers", "team", false);
local enemyTracers = gui.Checkbox(tracerTeams, "lua_enemy_tracers", "enemy", false);
local localTracers = gui.Checkbox(tracerTeams, "lua_local_tracers", "local", true);

-- Color selectors
local test = gui.Text(tracerColors, "			Local Tracer Colors");
local boxesColorLocal = gui.ColorPicker(tracerColors, "lua_boxes_color_local",   "", 255, 0  , 0  , 255);
local tracerColorLocal = gui.ColorPicker(tracerColors, "lua_tracer_color_local", "", 255, 255, 0  , 255);

local test = gui.Text(tracerColors, "			Enemy Tracer Colors");
local boxesColorEnemy = gui.ColorPicker(tracerColors, "lua_boxes_color_enemy",   "", 0  , 255, 0  , 255);
local tracerColorEnemy = gui.ColorPicker(tracerColors, "lua_tracer_color_enemy", "", 255, 255, 0  , 255);

local test = gui.Text(tracerColors, "			Team Tracer Colors");
local boxesColorTeam = gui.ColorPicker(tracerColors, "lua_boxes_color_team",   "", 0  , 0  , 255, 255);
local tracerColorTeam = gui.ColorPicker(tracerColors, "lua_tracer_color_team", "", 255, 255, 0  , 255);

-- Settings that do something
local tracerDuration = gui.Slider(refSettings, "lua_tracer_duration", "Tracer Life Span", 1, 1, 10);
tracerDuration:SetDescription("How long tracers last before expiring.");

local tracerFadeDuration = gui.Slider(refSettings, "lua_tracer_fade_duration", "Tracer Fade Time", 1, 1, 10);
tracerFadeDuration:SetDescription("How long it takes for traces to fade once they expire.");

local experimental = gui.Checkbox(refSettings, "lua_experiment", "Only render 'Relevent' tracers (Experemental)", false);
experimental:SetDescription("Only show enemy tracers close to you.");

local experimentalDistance = gui.Slider(refSettings, "lua_experiment_distance", "Maximum distance", 50, 0, 1000);
experimentalDistance:SetDescription("Maximum distance a tracer can be for it to render.");

-------------------------------------Var setup-------------------------------------
--change this to liking doesn't matter enough to get a slider--
local cubeSize = 2; -- bullet impact size

local hitCount = 0;
local tempHitCount = 0;
local minViewOffset, maxViewOffset = 46, 64;
local localPlayer;

hitData = {};
hitData.hitPos = {};
hitData.eyePos = {};
hitData.hitTime = {};
hitData.lifeSpan = {};
hitData.entity = {};

local function removeEntry(index)
	table.remove(hitData.hitPos,   index);
	table.remove(hitData.eyePos,   index);
	table.remove(hitData.hitTime,  index);
	table.remove(hitData.lifeSpan, index);
	table.remove(hitData.entity,   index);
	
	tempHitCount = tempHitCount - 1;
end

local function addEntry(hitPos, eyePos, entity)
	table.insert(hitData.hitPos,  hitPos);
	table.insert(hitData.eyePos,  eyePos);
	table.insert(hitData.hitTime, globals.CurTime());
	table.insert(hitData.entity,  entity);
	
	hitCount = hitCount + 1;
end

local function drawCubeFromCenter(size, center, r, g, b, a)
	local point1x, point1y = client.WorldToScreen(Vector3(center.x - size, center.y - size, center.z - size));
	local point2x, point2y = client.WorldToScreen(Vector3(center.x - size, center.y + size, center.z - size));
	local point3x, point3y = client.WorldToScreen(Vector3(center.x + size, center.y - size, center.z - size));
	local point4x, point4y = client.WorldToScreen(Vector3(center.x + size, center.y + size, center.z - size));
	local point5x, point5y = client.WorldToScreen(Vector3(center.x - size, center.y - size, center.z + size));
	local point6x, point6y = client.WorldToScreen(Vector3(center.x + size, center.y - size, center.z + size));
	local point7x, point7y = client.WorldToScreen(Vector3(center.x - size, center.y + size, center.z + size));
	local point8x, point8y = client.WorldToScreen(Vector3(center.x + size, center.y + size, center.z + size));
	
	draw.Color(r, g, b, a);
	draw.Line(point1x, point1y, point2x, point2y);
	draw.Line(point1x, point1y, point3x, point3y);
	draw.Line(point1x, point1y, point5x, point5y);
	
	draw.Line(point8x, point8y, point7x, point7y);
	draw.Line(point8x, point8y, point6x, point6y);
	draw.Line(point8x, point8y, point4x, point4y);
	
	draw.Line(point6x, point6y, point3x, point3y);
	draw.Line(point4x, point4y, point3x, point3y);
	draw.Line(point4x, point4y, point2x, point2y);
	draw.Line(point2x, point2y, point7x, point7y);
	draw.Line(point7x, point7y, point5x, point5y);
	draw.Line(point6x, point6y, point5x, point5y);
end

local function pointDistFromLine(x1, x2, p)
	local sub1 = Vector3(p.x - x1.x, p.y - x1.y, p.z - x1.z);
	local sub2 = Vector3(p.x - x2.x, p.y - x2.y, p.z - x2.z);

	local den = Vector3(x2.x - x1.x, x2.y - x1.y, x2.z - x1.z);
	
	return sub1:Cross(sub2):Length() / den:Length();
end

local function map(src, srcMax, srcMin, retMax, retMin)
	return (src - srcMin) / (srcMax - srcMin) * (retMax - retMin) + retMin;
end

local function getPlayerHeightEstimator(entity)
	local m_flDuckAmount = entity:GetPropFloat("m_flDuckAmount");
	local eyeOffset = map(m_flDuckAmount, 0, 1, maxViewOffset, minViewOffset);
	
	return eyeOffset;
end

local function getEyePos(entity)
	local m_vecOrigin = entity:GetAbsOrigin();
	local m_vecViewOffset = getPlayerHeightEstimator(entity);
	
	-- local m_vecViewOffset = localPlayer:GetPropVector("m_vecViewOffset"); ideal correct way to get Offset but not working currently
	-- local eyePos = Vector3(m_vecOrigin.x, m_vecOrigin.y, (m_vecOrigin.z + m_vecViewOffset.z));
	
	return Vector3(m_vecOrigin.x, m_vecOrigin.y, (m_vecOrigin.z + m_vecViewOffset));
end

local function eventHandler(event)
	localPlayer = entities.GetLocalPlayer()
    if (event:GetName() == "bullet_impact") then
        local ent = entities.GetByUserID(event:GetInt("userid"));
		
        if ent ~= nil then
            local hitPos = Vector3(event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z"));
            local m_vecOrigin = ent:GetAbsOrigin();
			local m_vecViewOffset = getPlayerHeightEstimator(ent);
			
			-- local m_vecViewOffset = localPlayer:GetPropVector("m_vecViewOffset"); ideal correct way to get Offset but not working currently
			-- local eyePos = Vector3(m_vecOrigin.x, m_vecOrigin.y, (m_vecOrigin.z + m_vecViewOffset.z));
			
			local eyePos = Vector3(m_vecOrigin.x, m_vecOrigin.y, (m_vecOrigin.z + m_vecViewOffset));
			addEntry(hitPos, eyePos, ent);
		end
    end
	
	
end

local function hDraw()
    if (enableCheckbox:GetValue() and localPlayer ~= nil) then
	
		-- this code is redundant but necessary, 
		-- we dont want to change the for loop counter mid loop as we would lose the last index each loop
		-- so we just store the next hitCount in a temp var
        tempHitCount = hitCount;
		
        for index = 0, hitCount, 1 do
            if (hitData.hitTime[index] ~= nil and hitData.hitPos[index] ~= nil) then
			
                local lifeSpan = globals.CurTime() - hitData.hitTime[index];
				
                if (lifeSpan > tracerDuration:GetValue() + tracerFadeDuration:GetValue()) then
					removeEntry(index);
                end
				
                if hitData.hitPos[index] ~= nil then
				
                    local fadeAlpha = 255;
					
                    if (lifeSpan > tracerDuration:GetValue()) then
						local currLifeSpan = lifeSpan - hitData.lifeSpan[index]
						fadeAlpha =  math.floor(map(currLifeSpan, tracerFadeDuration:GetValue(), 0, 0, 255));
						
						if fadeAlpha < 0 then
							fadeAlpha = 0
						end
                    else
                        table.insert(hitData.lifeSpan, index, lifeSpan)
                    end
					
					if enableCheckbox:GetValue() then
						local rt, gt, bt, ab, rb, gb, bb, ab;
						
						if hitData.entity[index]:GetTeamNumber() ~= localPlayer:GetTeamNumber() and enemyTracers:GetValue() then
							if experimental:GetValue() then
								local distance = pointDistFromLine(hitData.hitPos[index], hitData.eyePos[index], localPlayer:GetAbsOrigin());

								if distance > experimentalDistance:GetValue() then
									removeEntry(index);
									goto continue;
								end
							end
							
							rt, gt, bt, at = tracerColorEnemy:GetValue();
							rb, gb, bb, ab = boxesColorEnemy:GetValue();
						elseif hitData.entity[index]:GetIndex() == localPlayer:GetIndex() and localTracers:GetValue() then
							rt, gt, bt, at = tracerColorLocal:GetValue();
							rb, gb, bb, ab = boxesColorLocal:GetValue();
						elseif hitData.entity[index]:GetTeamNumber() == localPlayer:GetTeamNumber() and teamTracers:GetValue() and hitData.entity[index]:GetIndex() ~= localPlayer:GetIndex() then
							rt, gt, bt, at = tracerColorTeam:GetValue();
							rb, gb, bb, ab = boxesColorTeam:GetValue();
						else
							removeEntry(index);
							goto continue;
						end
						
						drawCubeFromCenter(cubeSize, hitData.hitPos[index], rb, gb, bb, fadeAlpha);
					
						local xHit, yHit = client.WorldToScreen(hitData.hitPos[index]);
						local xHead, yHead = client.WorldToScreen(hitData.eyePos[index]);
						
						-- Ghetto w2s fix that really just ignores the problem entirely instead of solving it
						-- Matrix math is above my pay grade currently, maybey ill adapt some code from UC who knows
						if xHit and yHit and xHead and yHead then
							draw.Color(rt, gt, bt, fadeAlpha);
							draw.Line(xHit, yHit, xHead, yHead);
						end
					end
					::continue::
                end
            end
        end
		
        hitCount = tempHitCount;
    end
end

client.AllowListener("bullet_impact");
callbacks.Register("FireGameEvent", eventHandler);
callbacks.Register("Draw", hDraw);








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

