-- Add your own sound files and names here to use in lua the directory
-- "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\sound\hitsounds"
-- Create a folder hitsounds to keep everything neat, you can change folder name but be sure to change folder name variable too so sounds play correctly.
-- I Provided a few sample hit sounds that i feel alot of people will use but please add your own and share them with others too!
local soundFolderName = "hitsounds";
local soundFiles =  {"8bit1","8bit2","bameware_hitsound","bass","bf4","Bowhit","bruh","bubble","cod","Cookie","doublekill","fatality","Fuck u bitch motha fucka_Segment_0","gachi","godlike","Hardimpact","hattrick","Hitsound_new","Hitsound_retro","juggernaut","killingmachine","killingspree","kovaakded","kovaakhit","maniac","massacre","mchit","Mediumimpact","megakill","metro2033","mhit1","minecraft","multikill","Oooff","rampage","rifk","roblox","rust","Rust_hs","test","toy","uagay","vitas","voice_input","voice_input_1_sit_nn_dog","voice_input_iizi","voice_input-beamlaser","voice_input-camera","voice_input-carhorn","voice_input-dominating","voice_input-errorwin","voice_input-fart","voice_input-fatality","voice_input-kuack","voice_input-pew","voice_input-poing","voice_input-print","voice_input-punch","voice_input-sniper","voice_input-toy"};
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------DO NOT CAHNGE STUFF PAST HERE UNLESS YOU KNOW WHAT YOU'RE DOING---------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- gui vars
local guiTab = gui.Tab(gui.Reference("Visuals"), "hiteffects", "Hit Effects");
local guiRef = gui.Reference("Visuals", "Hit Effects");
-- Settings GroupBox
local groupboxSettings = gui.Groupbox(guiRef, "Settings", 16, 16, 296, 0);
local guiSettingsMultiBox = gui.Multibox(groupboxSettings, "Active Effects");
local guiSettingsDrawMode = gui.Combobox(groupboxSettings, "settings.filter", "Draw Mode", "Off", "All", "Latest");
local guiSettingsSolidTime = gui.Slider(groupboxSettings, "settings.solidtime", "Solid Time", 2, 0, 10, 0.1);
local guiSettingsFadeTime = gui.Slider(groupboxSettings, "settings.fadetime", "Fade Time", 2, 0, 10, 0.1);
local guiSettingsHPShotTime = gui.Slider(groupboxSettings, "settings.hpshottime", "Health Shot Duration", 2, 0, 10, 0.1);
-- Effect MultiBox
local guiEffectSkeleton = gui.Checkbox(guiSettingsMultiBox, "settings.effect.skeleton", "Skeleton", false);
local guiEffectDammageNum = gui.Checkbox(guiSettingsMultiBox, "settings.effect.damage", "Damage", false);
local guiEffectHitGroup = gui.Checkbox(guiSettingsMultiBox, "settings.effect.hitgroup", "Hit Group", false);
local guiEffectMarker = gui.Checkbox(guiSettingsMultiBox, "settings.effect.marker", "Marker", false);
local guiEffectHealthShot = gui.Checkbox(guiSettingsMultiBox, "settings.effect.hpshot", "Health Shot", false);
-- HitMarker GroupBox
local groupboxHitMarker = gui.Groupbox(guiRef, "Hitmarker", 16, 406, 296, 0);
local guiHitMarkerStyle = gui.Combobox(groupboxHitMarker, "hitmarker.style", "Style", "Cube", "X-Cross");
local guiHitMarkerSize = gui.Slider(groupboxHitMarker, "hitmakrer.size", "Size", 2 , 0.1, 10, 0.1);
local guiHitMarkerColor = gui.ColorPicker(guiHitMarkerStyle, "hitmarker.color", "Color", 255, 255, 255, 255);
-- Text groupBox
local groupboxText = gui.Groupbox(guiRef, "Text", 328, 16, 296, 0);
local guiTextFont = gui.Editbox(groupboxText, "text.font", "Font Name");
local guiTextSize = gui.Slider(groupboxText, "text.size", "Font Size", 14, 14, 20);
local guiTextFontWeight = gui.Slider(groupboxText, "text.weight", "Font Weight", 1, 0, 1);
local guiTextExample = gui.Checkbox(groupboxText, "text.example", "Example text", true);
local guiTextVelocity = gui.Slider(groupboxText, "text.velocity", "Velocity", 10, 0, 100);
local guiTextColor = gui.ColorPicker(guiTextExample, "text.color", "", 255, 0, 0, 255);
-- HitSound GroupBox
local groupboxSound = gui.Groupbox(guiRef, "Hit Sounds", 328, 390, 296, 0);
local guiSoundHit = gui.Combobox(groupboxSound, "sound.hit", "Hit", "Off", unpack(soundFiles));
local guiSoundHead = gui.Combobox(groupboxSound, "sound.head", "HeadShot", "Off", unpack(soundFiles));
local guiSoundKill = gui.Combobox(groupboxSound, "sound.kill", "Kill", "Off", unpack(soundFiles));
local guiSoundLocalHit = gui.Combobox(groupboxSound, "sound.hityou", "Local Hit", "Off", unpack(soundFiles));
local guiSoundResetButton = gui.Button(groupboxSound, "Reset Sound (Needs sv_cheats Bypass)", function() client.Command("snd_restart", true); end);
-- Gui descriptions and tweaks
guiSettingsMultiBox:SetDescription("Choose hit effects");
guiSettingsDrawMode:SetDescription("Filter drawn hits");
guiSettingsSolidTime:SetDescription("Time before fading");
guiSettingsFadeTime:SetDescription("Time to fade completely");
guiSettingsHPShotTime:SetDescription("Duration of Health Shot effect");
guiHitMarkerStyle:SetDescription("Choose hitmarker style");
guiHitMarkerSize:SetDescription("Customize hitmarker size");
guiTextFontWeight:SetDescription("Customize font thickness");
guiTextFont:SetDescription("Set the custom font for effects");
guiTextSize:SetDescription("Customize text size");
guiTextExample:SetDescription("Display an example of current text settings");
guiTextVelocity:SetDescription("Customize the speed of damage text");
guiSoundHit:SetValue(0);
guiSoundHead:SetValue(0);
guiSoundKill:SetValue(0);
guiSoundLocalHit:SetValue(0);
guiSoundResetButton:SetWidth(264);
-- Important Static Globals
local globalHitGroupDisplay = {"Generic", "Head", "Chest", "Stomach", "Left arm", "Right arm", "Left leg", "Right leg", "Neck"};
local globalHitGroupNames = {"HITGROUP_GENERIC", "HITGROUP_HEAD", "HITGROUP_CHEST", "HITGROUP_STOMACH", "HITGROUP_LEFTARM", "HITGROUP_RIGHTARM", "HITGROUP_LEFTLEG", "HITGROUP_RIGHTLEG", "HITGROUP_GEAR"};
local globalHitGroupToHitBox = {2, 0, 4, 2, 13, 14, 7, 8, 1};
local globalCubeOutlineConnections = {{1, 2}, {1, 3}, {1, 5}, {8, 7}, {8, 6}, {8, 4}, {6, 3}, {4, 3}, {4, 2}, {2, 7}, {7, 5}, {6, 5}};
local globalCubeFillConnections = {{1, 2, 3}, {1, 2 ,5}, {1, 3 ,5}, {8, 7, 6}, {8, 7, 4}, {8, 6, 4}, {3, 6, 5}, {3, 4, 6}, {2, 4, 7}, {2, 7, 5}, {3, 4, 2}, {6, 5, 7}};
local globalHitBoxConnections = {{1, 2}, {2,7}, {7, 6}, {6, 5}, {5, 4}, {4, 3}, {3, 9}, {3, 8}, {9, 11}, {8, 10}, {11, 13}, {10, 12}, {7, 18}, {18, 19}, {19, 15}, {7, 16}, {16, 17}, {17, 14}};
-- Very Important Tables That Hold Everything The Lua Does That Could Probably Be Structured Better But This Is Lua And Im Too Lazy
local tablePlayerHistorys = {};
local tableActiveHits = {};
local tableImpacts = {};
-- Less Important but still usefull stuff
local localPlayer = entities.GetLocalPlayer();
local lastSounds = {["hit"] = 0, ["head"] = 0, ["kill"] = 0, ["local"] = 0};

-- Hit Class
local Hit = {
    damage = 0,
    pos = {},
    skeletonvecs = {},
    textpos = {},
    textvel = {},
    liferemaining = 0,
    stacked = 1
}

function Hit:Create(damage, hitGroup, hitPos, skeletonVecs, textVel)
    local newHit = {};
    setmetatable(newHit, {__index = Hit});
    newHit.damage = damage;
    newHit.hitgroup = hitGroup;
	newHit.pos = hitPos;
    newHit.skeletonvecs = skeletonVecs;
    newHit.textpos = hitPos;
    newHit.textvel = textVel;
    newHit.liferemaining = guiSettingsSolidTime:GetValue() + guiSettingsFadeTime:GetValue();
    newHit.stacked = 1;
    return newHit;
end

-- Helpers that save me alot of hair pulling and desk slamming when refactoring
local function Vector2(x , y)
    return {x = x, y = y};
end

-- Generates a random vector + and - ang from up with a magnitude of len
local function randomVector(ang)
    local rand = math.rad(math.random(270 + ang/2, 270 - ang/2));
    local vec = Vector2(math.cos(rand), math.sin(rand));
    vec.x = vec.x;
    vec.y = vec.y;
    return vec;
end

-- This does all the fade stuff 
local function map(src, srcMax, srcMin, retMax, retMin)
	return (src - srcMin) / (srcMax - srcMin) * (retMax - retMin) + retMin;
end

-- Gets impact for player_hurt event
local function getClosestImpact(vec3)
	local bestImpact;
	local bestDistance = math.huge;
	
	for i = 1, #tableImpacts do 
		if tableImpacts[i] then
			local delta = tableImpacts[i] - vec3;
			local distance = delta:Length();
			
			if distance < bestDistance then
				bestDistance = distance;
				bestImpact = tableImpacts[i];
			end
		end
	end

	return bestImpact;
end

-- Gets backtracked player skeleton
local function getClosestBackTrack(point, index, hitbox)
	local bestIndex
	local bestDistance = math.huge;
	
    for i = 1, #tablePlayerHistorys[index] do
        if tablePlayerHistorys[index][i] then
			local vecs = tablePlayerHistorys[index][i].skeleton;
            local pos = vecs[hitbox+1];
            
            if pos then 
				local delta = pos - point;
				local distance = delta:Length();
                
                if distance <= bestDistance then
                    
					bestDistance = distance;
					bestIndex = i;
				end
			end
		end
    end

	return tablePlayerHistorys[index][bestIndex].skeleton;
end

-- Fix for draw.TextShadow fading
local function drawTextShadow(x, y, string, r, g, b, a)
    draw.Color(0, 0, 0, a);
    draw.Text(x+1, y+1, string); 
    draw.Color(r, g, b, a);
    draw.Text(x, y, string);
end

-- For cross marker outline, works pretty well feel free to use it for other crap
local function drawOutlinedLine(x1, y1, x2, y2, r, g, b, alphaOutline, alphaLine)
    draw.Color(0, 0, 0, alphaOutline);

    -- Outline in black
    draw.Line( x1, y1 + 1, x2, y2 + 1);
    draw.Line( x1, y1 - 1, x2, y2 + 1);
    draw.Line( x1 - 1, y1, x2 - 1, y2);
    draw.Line( x1 + 1, y1, x2 + 1, y2);

    -- Real line drawn ontop looks better
    draw.Color(r, g, b, alphaLine);
    draw.Line( x1, y1, x2, y2 );
end

-- The 8 points thing annoys me but there isnt another way
local function drawCubeAtPoint(size, vec, r, g, b, alphaOutline, alphaFill)
	local points = {};
	
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x - size, vec.y - size, vec.z - size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x - size, vec.y + size, vec.z - size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x + size, vec.y - size, vec.z - size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x + size, vec.y + size, vec.z - size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x - size, vec.y - size, vec.z + size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x + size, vec.y - size, vec.z + size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x - size, vec.y + size, vec.z + size))));
	table.insert(points, Vector2(client.WorldToScreen(Vector3(vec.x + size, vec.y + size, vec.z + size))));
    
	draw.Color(r, g, b, alphaOutline);
	for i = 1, #globalCubeOutlineConnections do
		local p1 = points[globalCubeOutlineConnections[i][1]];
		local p2 = points[globalCubeOutlineConnections[i][2]];
		
		if p1.x and p1.y and p2.x and p2.y then
			draw.Line(p1.x, p1.y, p2.x, p2.y);
		end
	end	
    
    -- No fill is just 0 alpha
	draw.Color(r, g, b, alphaFill);
	for i = 1, #globalCubeFillConnections do
		local p1 = points[globalCubeFillConnections[i][1]];
		local p2 = points[globalCubeFillConnections[i][2]];
		local p3 = points[globalCubeFillConnections[i][3]];
		
		if p1.x and p1.y and p2.x and p2.y and p3.x and p3.y then
			draw.Triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
		end
		
	end
end

-- Cross hitmarker stuff
local function drawCrossAtPoint(size, vec, r, g, b, alpha)
    local gap = size * 0.75;
    local x, y = client.WorldToScreen(vec);
    
    if x and y then
        draw.Color(r, g, b, alphaLine);
        drawOutlinedLine(x + gap, y + gap, x + (size + gap), y + (size + gap), r, g, b, alpha, alpha);
        drawOutlinedLine(x - gap, y - gap, x - (size + gap), y - (size + gap), r, g, b, alpha, alpha);
        drawOutlinedLine(x + gap, y - gap, x + (size + gap), y - (size + gap), r, g, b, alpha, alpha);
        drawOutlinedLine(x - gap, y + gap, x - (size + gap), y + (size + gap), r, g, b, alpha, alpha);
    end

end

-- Main code stuff
local function hDraw()
    local drawFont = draw.CreateFont(guiTextFont:GetValue(), guiTextSize:GetValue(), guiTextFontWeight:GetValue() + 550);
    draw.SetFont(drawFont);

    -- Reduces function calls alot and besides a insignificant amount of time passes within a frame
    local currentTime = globals.CurTime();

    -- Nice quality of life feature to preview sounds, always find it annoying when i have to wait to hear sound.
    if lastSounds["hit"] ~= guiSoundHit:GetValue() then
        lastSounds["hit"] = guiSoundHit:GetValue();
        client.Command("Play "..soundFolderName.."/"..soundFiles[guiSoundHit:GetValue()], true);
    elseif lastSounds["head"] ~= guiSoundHead:GetValue() then
        lastSounds["head"] = guiSoundHead:GetValue();
        client.Command("Play "..soundFolderName.."/"..soundFiles[guiSoundHead:GetValue()], true);
    elseif lastSounds["kill"] ~= guiSoundKill:GetValue() then
        lastSounds["kill"] = guiSoundKill:GetValue();
        client.Command("Play "..soundFolderName.."/"..soundFiles[guiSoundKill:GetValue()], true);
    elseif lastSounds["local"] ~= guiSoundLocalHit:GetValue() then
        lastSounds["local"] = guiSoundLocalHit:GetValue();
        client.Command("Play "..soundFolderName.."/"..soundFiles[guiSoundLocalHit:GetValue()], true);
    end

    -- Another quality of life feature to preview damage text.
    if guiTextExample:GetValue() then
        local r, g, b, a = guiTextColor:GetValue();
        draw.Color(r, g, b, a);
        draw.TextShadow(100, 25, "Example Text");
    end

    -- each frame we check the draw mode
    local drawMode = 1;
    if guiSettingsDrawMode:GetValue() == 2 then
        drawMode = 2;
    elseif guiSettingsDrawMode:GetValue() == 0 then
        goto EndFrame;
    end

    -- Main draw loop that does most of the work, could probably be refactored yet again but havent noticed a big fps drop ive done alot of refactoring to speed it up
    -- Sadly because of 'latest' draw mode option i have to loop through players each frame which sucks
    localPlayer = entities.GetLocalPlayer();
    if localPlayer then

        local players = entities.FindByClass("CCSPlayer");
        for i = 1, #players do
            -- I didnt want to draw the latest hit mutiple times per frame so i keep track of if i drew it already to save fps
            local drawnlatestHit = false;
            local player = players[i];
            if tableActiveHits[player:GetIndex()] then

                -- Updates and removes latest hit
                if tableActiveHits[player:GetIndex()]["latest"] then
                    local latest = tableActiveHits[player:GetIndex()]["latest"]
                    latest.liferemaining = latest.liferemaining - globals.FrameTime();
                    if latest.liferemaining <= 0.0 then
                        latest.liferemaining = 0;
                        tableActiveHits[player:GetIndex()]["latest"] = nil;
                    end
		        end
                
                -- Loops through each hit for each player
                for j = 1, #tableActiveHits[player:GetIndex()] do
                    if not drawnlatestHit then
                        local currentHit = tableActiveHits[player:GetIndex()][j];

                        -- Removes old hits and updates life remaining
                        if currentHit then
                            currentHit.liferemaining = currentHit.liferemaining - globals.FrameTime();
                            if currentHit.liferemaining <= 0.0 then
                                currentHit.liferemaining = 0;
                                table.remove(tableActiveHits[player:GetIndex()], j);
                            end
		                else goto EndHit end

                        -- All the draw mode logic that has to happen here
                        if drawMode == 2 and tableActiveHits[player:GetIndex()]["latest"] then -- latest
                            currentHit = tableActiveHits[player:GetIndex()]["latest"];
                        elseif drawMode == 2 then goto EndHit end

                        -- global alpha scale mapping
                        local alpha = 255;
                        local r, g, b, skeletonAlpha = gui.GetValue("esp.overlay.enemy.skeleton.clr");
                        local r, g, b, hitMarkerAplha = guiHitMarkerColor:GetValue();
                        if guiSettingsFadeTime:GetValue() ~= 0 and currentHit.liferemaining <= guiSettingsFadeTime:GetValue() then
                            alpha = math.floor(map(currentHit.liferemaining, guiSettingsFadeTime:GetValue(), 0, 255, 0));
                            skeletonAlpha = math.floor(map(currentHit.liferemaining, guiSettingsFadeTime:GetValue(), 0, skeletonAlpha, 0));
                            hitMarkerAplha = math.floor(map(currentHit.liferemaining, guiSettingsFadeTime:GetValue(), 0, hitMarkerAplha, 0));
                        end

                        -- Hopefully debug overlay soon so i can draw hitboxes!!!!????
                        if guiEffectSkeleton:GetValue() then 

                            -- Uses color and alpha from esp skeleton color
                            local r, g, b, a = gui.GetValue("esp.overlay.enemy.skeleton.clr");
                            draw.Color(r, g, b, skeletonAlpha);
                            
                            for i = 1, #globalHitBoxConnections do
                                -- Loops over connections of hitbox positions and draws a "skeleton" from 
                                local hitBoxConnection = globalHitBoxConnections[i];

                                local x1, y1 = client.WorldToScreen(currentHit.skeletonvecs[hitBoxConnection[1]]);
                                local x2, y2 = client.WorldToScreen(currentHit.skeletonvecs[hitBoxConnection[2]]);
                            
                                if x1 and y1 and x2 and y2 then
                                    draw.Line(x1, y1, x2, y2);
                                end
                            end
                        end

                        -- Floating Damage stuff, looks alot cooler in this version than last
                        if guiEffectDammageNum:GetValue() or guiEffectHitGroup:GetValue() then

                            -- Drawing the damamge and animating it
                            local drawPos = Vector2(client.WorldToScreen(currentHit.textpos));
                            if drawPos.x then
                                local totalTime = guiSettingsSolidTime:GetValue() + guiSettingsFadeTime:GetValue();
                                drawPos.x = drawPos.x + (currentHit.textvel.x * guiTextVelocity:GetValue()) * (totalTime - currentHit.liferemaining);
                                drawPos.y = drawPos.y + (currentHit.textvel.y * guiTextVelocity:GetValue()) * (totalTime - currentHit.liferemaining);

                                local text = " ";

                                -- Damage number
                                if guiEffectDammageNum:GetValue() then
                                    text = "-"..math.abs(currentHit.damage).." ";
                                end
                                -- Hitgroup
                                if guiEffectHitGroup:GetValue() then
                                    text = text..globalHitGroupDisplay[currentHit.hitgroup];
                                end
                                -- Stacked amount dammage indicator
                                if drawMode == 2 and currentHit.stacked > 1 then
                                    text =  text.." x"..currentHit.stacked
                                end

                                local r, g, b, a = guiTextColor:GetValue();
                                drawTextShadow(drawPos.x, drawPos.y, text, r, g, b, alpha);
                            end
                        end

                        -- Hitmarker stuff, literally no one used dot so i cut it and simplified options cause it was needlesly complex
                        if guiEffectMarker:GetValue() then

                            local r, g, b, a = guiHitMarkerColor:GetValue();

                            -- You can easily add more styles just make a function that takes a point and draws a marker, ez pz
                            local hitMarkerSize = guiHitMarkerSize:GetValue()
                            if guiHitMarkerStyle:GetValue() == 0 then
                                drawCubeAtPoint(hitMarkerSize, currentHit.pos, r, g, b, alpha, hitMarkerAplha);
                            elseif guiHitMarkerStyle:GetValue() == 1 then
                                drawCrossAtPoint(hitMarkerSize, currentHit.pos, r, g, b, hitMarkerAplha);
                            end
                        end

                        if drawMode == 2 then -- latest mode
                            drawnlatestHit = true;
                        else
                            drawnlatestHit = false;
                        end

                        ::EndHit::
                    end
                end

            end
        end 
        tableImpacts = {};   
    end
    ::EndFrame::
end

-- Hit logging magic happens here 
local function hFireGameEvent(gameEvent)
    local eventName = gameEvent:GetName();

    if eventName == "player_hurt" then
        local attacker = entities.GetByUserID(gameEvent:GetInt("attacker"));
        local victim = entities.GetByUserID(gameEvent:GetInt("userid"));
        local eventDamage = gameEvent:GetInt("dmg_health");
        local eventHealth = gameEvent:GetInt("health");
        local eventHitGroup = gameEvent:GetInt("hitgroup") + 1;

        if attacker and victim and attacker:GetIndex() == localPlayer:GetIndex() and attacker:GetIndex() ~= victim:GetIndex() then
            local attackerIndex = attacker:GetIndex();
            local victimIndex = victim:GetIndex();
            local eventHitBoxPos = victim:GetHitboxPosition(globalHitGroupToHitBox[eventHitGroup]);
            local textVelocity = randomVector(30);
            local eventImpactPos;

            -- Fix for knife and nade damage
            if eventHitGroup == 1 then
                eventImpactPos = victim:GetHitboxPosition("Stomach");
            else
                eventImpactPos = getClosestImpact(eventHitBoxPos);
            end

            -- If backtracking then get backtracked position else get current
            local skeleton = {};
		    if eventHitGroup ~= 1  and (gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.posadj.backtrack")) or (gui.GetValue("lbot.master") and gui.GetValue("lbot.extra.backtrack") ~= 0) then
                skeleton = getClosestBackTrack(eventImpactPos, victimIndex, globalHitGroupToHitBox[eventHitGroup]);
		    else
			    skeleton = tablePlayerHistorys[victimIndex][#tablePlayerHistorys[victimIndex]].skeleton
            end
            
            local eventHit = Hit:Create(eventDamage, eventHitGroup, eventImpactPos, skeleton, textVelocity);

            -- Adding the new hit to the table and checking if there is a table made or not for the player
            if not tableActiveHits[victimIndex] then
                tableActiveHits[victimIndex] = {};
            end
            table.insert(tableActiveHits[victimIndex], eventHit);

            -- Manipulating latest hit here saves alot of trouble later on in draw
            if guiSettingsDrawMode:GetValue() == 2 then
                -- Create a latest hit if we dont have one
                if not tableActiveHits[victimIndex]["latest"] then
                    tableActiveHits[victimIndex]["latest"] = eventHit;
                -- if we already have one just add damage and stack counter and update it
                else
                    local latestStacked = tableActiveHits[victimIndex]["latest"].stacked + 1;

                    tableActiveHits[victimIndex]["latest"] = Hit:Create(tableActiveHits[victimIndex]["latest"].damage + eventDamage, eventHitGroup, eventImpactPos, skeleton, textVelocity);
                    tableActiveHits[victimIndex]["latest"].stacked = latestStacked;
                end
            end

            -- Health Shot Effect
            if guiEffectHealthShot:GetValue() then
                localPlayer:SetProp('m_flHealthShotBoostExpirationTime', globals.CurTime() + guiSettingsHPShotTime:GetValue());
            end

            -- Hit Sounds stuff
            local eventSound = "";
             -- Hit that isnt fatal or no kill sound
            if eventHealth > 0 or guiSoundKill:GetValue() == 0 then
                if eventHitGroup == 2 then -- Headshot
                    eventSound = guiSoundHead:GetValue();
                else -- Normal hit
                    eventSound = guiSoundHit:GetValue();
                end
            -- Fatal hit
            else
                eventSound = guiSoundKill:GetValue();
            end

            -- Play the sound if there is one
            if eventSound ~= 0 then client.Command("Play "..soundFolderName.."/"..soundFiles[eventSound], true) end

        end

        -- Local attack victim
        if attacker and victim and victim:GetIndex() == localPlayer:GetIndex() then
            -- local hitsound
            if guiSoundLocalHit:GetValue() ~= 0 then
                client.Command("Play "..soundFolderName.."/"..soundFiles[guiSoundLocalHit:GetValue()], true);
            end
        end
    -- This keeps track of all impacts from localPlayer, its used to determine where player was hit because player_hurt doesnt contain that info for some reason???
    elseif eventName == "bullet_impact" then
        local attacker = entities.GetByUserID(gameEvent:GetInt("userid"));
        local impactPos = Vector3(gameEvent:GetFloat("x"), gameEvent:GetFloat("y"), gameEvent:GetFloat("z"));
        
        if attacker and attacker:GetIndex() == localPlayer:GetIndex() then
			table.insert(tableImpacts, impactPos);
        end
        
    elseif eventName == "round_prestart" then
        -- Keeps everything running smoothly
        tablePlayerHistorys = {};
        tableActiveHits = {};
        tableImpacts = {};
    end
end

-- This hunk of junk is supposed to fix backtracking but is really bad and is a guess at best
local function hCreateMove(pCmd)
    local localPlayer = entities.GetLocalPlayer();
	local players = entities.FindByClass("CBasePlayer");
    
    for i = 1, #players do
        local player = players[i];
        local playerIndex = player:GetIndex();
            
        if player:GetTeamNumber() ~= localPlayer:GetTeamNumber() and player:IsAlive() then
                
            -- Save skeleton points
            local hitBoxes = {};
            for index = 0, 19 do
                local vec = player:GetHitboxPosition(index);
                table.insert(hitBoxes, vec);
            end
                    
            -- Create a table if there isnt an existing one
            if not tablePlayerHistorys[playerIndex] then
                tablePlayerHistorys[playerIndex] = {};
            end
                    
            -- insert new ticks
            table.insert(tablePlayerHistorys[playerIndex], {skeleton = hitBoxes, expires = globals.CurTime() + 0.3});
                    
            -- Remove invaild ticks
            for index = 1, #tablePlayerHistorys[playerIndex] do
                if tablePlayerHistorys[playerIndex][index] then
                    local expires = tablePlayerHistorys[playerIndex][index].expires;
                        
                    if expires <= globals.CurTime() then
                        table.remove(tablePlayerHistorys[playerIndex], index);
                    end
                end
            end
        end
    end
end

client.AllowListener("player_hurt");
client.AllowListener("bullet_impact");
client.AllowListener("round_prestart");

callbacks.Register("CreateMove", hCreateMove);
callbacks.Register("FireGameEvent", hFireGameEvent);
callbacks.Register("Draw", hDraw);
