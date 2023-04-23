-- GUI
local TabPosition = gui.Reference("VISUALS");
local TAB = gui.Tab(TabPosition, "himwari_prefire_helper", "Prefire Helper");
local MULTIBOX = gui.Groupbox(TAB, "General Settings", 15, 15, 295, 400);
local EDIT_ENABLED = gui.Checkbox(MULTIBOX, "phelper_edit_enabled", "Edit Enabled", 0 );
local ESP_COLOR = gui.ColorPicker(MULTIBOX, "phelper_esp_color", "ESP Color", 0, 183, 235, 255);
local LOAD_KEY = gui.Keybox(MULTIBOX, "phelper_load_key", "Load Key", 0);


local EDITBOX = gui.Groupbox(TAB, "Edit Settings", 325, 15, 295, 400);
local PLACE_ZONE_KEY = gui.Keybox(EDITBOX, "phelper_zone_place", "Place Zone", 48); 
local PLACE_LINE_KEY = gui.Keybox(EDITBOX, "phelper_line_place", "Place/Modify Line", 9);
local NEXT_LINE_KEY = gui.Keybox(EDITBOX, "phelper_next_line", "Next Line", 39);
local PREV_LINE_KEY = gui.Keybox(EDITBOX, "phelper_prev_line", "Previous Line", 37);
local NEXT_ZONE_KEY = gui.Keybox(EDITBOX, "phelper_next_zone", "Next Zone", 38);
local PREV_ZONE_KEY = gui.Keybox(EDITBOX, "phelper_prev_zone", "Previous Zone", 40);
local SELECTED_LINE = gui.ColorPicker(MULTIBOX, "phelper_esp_selected_line_color", "Selected Line Color", 0, 255, 0, 255);
local SELECTED_ZONE = gui.ColorPicker(MULTIBOX, "phelper_esp_selected_zone_color", "Selected Zone Color", 255, 255, 255, 255);
local SAVE_KEY = gui.Keybox(EDITBOX, "phelper_save_key", "Save Key", 0);


-- Variables
local switchVar = false; 
local zoneSwitchVar = false;
local zones = {};
local currentZone = {};
local currentLine = {};
local lIndex = 1;
local zIndex = 1;

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function drawBox(start, finish)
   
  
    local p1x,p1y = client.WorldToScreen(start);
    local p2x,p2y = client.WorldToScreen(finish);

    local p3x,p3y = client.WorldToScreen(Vector3(start.x, finish.y, finish.z));
    local p4x,p4y = client.WorldToScreen(Vector3(start.x, start.y, finish.z));
    local p5x,p5y = client.WorldToScreen(Vector3(start.x, finish.y, start.z));
    local p6x,p6y = client.WorldToScreen(Vector3(finish.x, start.y, finish.z));
    local p7x,p7y = client.WorldToScreen(Vector3(finish.x, start.y, start.z));
    local p8x,p8y = client.WorldToScreen(Vector3(finish.x, finish.y, start.z));
    
    if(p1x ~= nil and p1y ~= nil) then
      if(p7x ~= nil and p7y ~= nil) then
        draw.Line(p1x, p1y, p7x, p7y);
      end
      if(p4x ~= nil and p4y ~= nil) then
        draw.Line(p1x, p1y, p4x, p4y);
      end
      if(p5x ~= nil and p5y ~= nil) then
        draw.Line(p1x, p1y, p5x, p5y);
      end
    end
    
    if(p3x ~= nil and p3y ~= nil) then
      if(p4x ~= nil and p4y ~= nil) then
        draw.Line(p3x, p3y, p4x, p4y);
      end
      if(p5x ~= nil and p5y ~= nil) then
        draw.Line(p3x, p3y, p5x, p5y);
      end
      if(p2x ~= nil and p2y ~= nil) then
        draw.Line(p3x, p3y, p2x, p2y);
      end
    end
    if(p8x ~= nil and p8y ~= nil) then
      if(p7x ~= nil and p7y ~= nil) then
        draw.Line(p8x, p8y, p7x, p7y);
      end
      if(p2x ~= nil and p2y ~= nil) then
        draw.Line(p8x, p8y, p2x, p2y);
      end
      if(p5x ~= nil and p5y ~= nil) then
        draw.Line(p8x, p8y, p5x, p5y);
      end
    end
    if(p6x ~= nil and p6y ~= nil) then
      if(p2x ~= nil and p2y ~= nil) then
        draw.Line(p6x, p6y, p2x, p2y);
      end
      if(p7x ~= nil and p7y ~= nil) then
        draw.Line(p6x, p6y, p7x, p7y);
      end
      if(p4x ~= nil and p4y ~= nil) then
        draw.Line(p6x, p6y, p4x, p4y);
      end
    end
    
end

local function playerPosition()
  local player = entities.GetLocalPlayer();
if not player then return 
	else
	return player:GetAbsOrigin() + player:GetPropVector( "localdata", "m_vecViewOffset[0]" );
end
end

local function onLineChanged()
  currentLine = currentZone.lines[lIndex];
	if(currentLine == nil) then
		currentLine = {};
	end
end

local function onZoneChanged()
  currentZone = zones[zIndex];  
  
    if(currentZone) == nil then
      currentZone = {};
    end
    
    if(currentZone.lines == nil) then
      currentZone.lines = {};
      currentLine = {};
    else
      lIndex = 1;
      currentLine = currentZone.lines[1];
      if(currentLine == nil) then
        currentLine = {};
      end
    end
end

local function saveData()
  local data = "";
  
  local map = engine.GetMapName();
  print("prefire_helper_for_" .. map .. ".txt");
  
  -- For all zones
  for z_num, zone in pairs(zones) do
    if(zone ~= nil) then
      if(zone.start ~= nil and zone.finish ~= nil) then
        if(z_num > 0) then
          data = data .. "\r\n"; -- Append newline
        end
        data = data .. "zone;" .. zone.start.x .. ";" .. zone.start.y .. ";" .. zone.start.z .. ";" .. 
          zone.finish.x .. ";" .. zone.finish.y .. ";" .. zone.finish.z;
        
        -- And all lines
        for l_num, line in pairs(zone.lines) do
          if(line ~= nil) then
            if(line.vec1 ~= nil and line.vec2 ~= nil) then
              data = data .. "\r\n"; -- Append newline
              
              data = data .. "line;" .. line.vec1.x .. ";" .. line.vec1.y .. ";" .. line.vec1.z .. ";" ..
                line.vec2.x .. ";" .. line.vec2.y .. ";" .. line.vec2.z;
            end
          end
        end
      end
    end
  end
  

  local f = file.Open( "prefire_helper_for_" .. map .. ".txt", "w" );

  f:Write(data);
  f:Close();
end

local function loadData()
  local map = engine.GetMapName();
  
  local f = file.Open("prefire_helper_for_" .. map .. ".txt", "r");
  local data = f:Read();
  f:Close();
  
  local textLines = {};

  -- Read lines
  for s in data:gmatch("[^\r\n]+") do
    table.insert(textLines, s);
  end
  
  zIndex = 0;
  lIndex = 0;
  -- For all lines
  for k, v in pairs(textLines) do
    local lData = {};
    for s in v:gmatch("([^;]+)") do
      table.insert(lData, s);
    end
    
    if(lData[1] == "zone") then
      
      if(zIndex >= 1) then
        zones[zIndex] = currentZone; -- Set zone
      end
      
      -- Modify counters
      zIndex = zIndex + 1;
      lIndex = 0;      
      
      -- Create zone
      currentZone = {};
      currentZone.lines = {};
      currentZone.start = Vector3(tonumber(lData[2]), tonumber(lData[3]), tonumber(lData[4]));
      currentZone.finish = Vector3(tonumber(lData[5]), tonumber(lData[6]), tonumber(lData[7]));
    elseif lData[1] == "line" then
      if(lIndex >= 1) then
          currentZone.lines[lIndex] = currentLine;
      end
      lIndex = lIndex + 1;
      currentLine = {};
      
      currentLine.vec1 = Vector3(tonumber(lData[2]), tonumber(lData[3]), tonumber(lData[4]));
      currentLine.vec2 = Vector3(tonumber(lData[5]), tonumber(lData[6]), tonumber(lData[7]));
      
      currentZone.lines[lIndex] = currentLine;
    end  
  end
  
  
  zones[zIndex] = currentZone;
  
  --client.ChatSay("Loaded: " .. tablelength(zones));
end

local function drawLines(lineObj, ignoreColors)

  	for k, v in pairs(lineObj) do
    if(v.vec1 ~= nil and v.vec2 ~= nil) then
      local x1, y1 = client.WorldToScreen(v.vec1);	
      local x2, y2 = client.WorldToScreen(v.vec2);
      
      if(k == lIndex and not ignoreColors) then
        draw.Color(SELECTED_LINE:GetValue());
      else
        draw.Color(ESP_COLOR:GetValue());
      end

      if (x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil) then
        draw.Line(x1, y1, x2, y2);	
      end
    end
	end
end

local en_map = "";

local function onDraw()
  -- Check data
  local eMap = engine:GetMapName();
  if(en_map ~= eMap) then
    loadData();
    en_map = eMap;
  end
  
  -- Player position
  if not entities.GetLocalPlayer() then return end;

	local src = playerPosition();
  
  -- EDIT KEYBINDS
	if(EDIT_ENABLED:GetValue()) then
    
    -- Utility variables - hit positions
    local dst = src + engine.GetViewAngles():Forward() * 1000;
    local tr = engine.TraceLine( src, dst, 0xFFFFFFFF ); 
    local vec = (dst - src) * tr.fraction + src;
      
    if(input.IsButtonPressed(PLACE_LINE_KEY:GetValue())) then -- TAB
      if(switchVar) then
        currentLine.vec1 = vec;
        switchVar = false;
      else
        currentLine.vec2 = vec;
        switchVar = true;
      end
      currentZone.lines[lIndex] = currentLine;
    end
    if(input.IsButtonPressed(PREV_LINE_KEY:GetValue())) then -- <-
      if(lIndex > 1) then
        lIndex = lIndex - 1;
        onLineChanged();
      end	
    end
    if(input.IsButtonPressed(NEXT_LINE_KEY:GetValue())) then -- ->
      lIndex = lIndex + 1;
      onLineChanged();
    end
    if(input.IsButtonPressed(NEXT_ZONE_KEY:GetValue())) then -- ^
      zIndex = zIndex + 1;
      onZoneChanged();
    end
    if(input.IsButtonPressed(PREV_ZONE_KEY:GetValue())) then -- V
      if(zIndex > 1) then
        zIndex = zIndex - 1;
        onZoneChanged();
      end
    end
    if SAVE_KEY:GetValue() ~= 0 or nil then
	 if(input.IsButtonPressed(SAVE_KEY:GetValue())) then
		loadData();
	 end
    end
    if(input.IsButtonPressed(PLACE_ZONE_KEY:GetValue())) then
      if(zoneSwitchVar == false) then
        currentZone.start = vec;
        zoneSwitchVar = true;
        client.ChatSay("Please Select End Point");
      else
        zoneSwitchVar = false;
        currentZone.finish = vec;
        local s = currentZone.start;
        local f = currentZone.finish;
        local sV = Vector3(0,0,0);
        local eV = Vector3(0,0,0);
        if(s.x < f.x) then
          sV.x = s.x;
          eV.x = f.x;
        else
          sV.x = f.x;
          eV.x = s.x;
        end
        if(s.y < f.y) then
          sV.y = s.y;
          eV.y = f.y;
        else
          sV.y = f.y;
          eV.y = s.y;
        end
        if(s.z < f.z) then
          sV.z = s.z;
          eV.z = f.z;
        else
          sV.z = f.z;
          eV.z = s.z;
        end
        currentZone.start = sV;
        currentZone.finish = eV;
        
        client.ChatSay("Zone Created!");
        zones[zIndex] = currentZone;
      end
    end
  end
  
  -- Draw ESP
  -- Draw zones only in edit mode
  if(EDIT_ENABLED:GetValue()) then
    for k, v in pairs(zones) do
      
      -- If selected
      if(zIndex == k) then
        
        -- Draw zone
        if(v ~= nil) then
          draw.Color(SELECTED_ZONE:GetValue());
          drawBox(v.start, v.finish);
        end      
      
        drawLines(zones[zIndex].lines, false);
      end
    end    
  else
    -- Game mode
    if LOAD_KEY:GetValue() ~= 0 or nil then
	if(input.IsButtonPressed(LOAD_KEY:GetValue())) then
      loadData();
    end
    end
	
    for k, v in pairs(zones) do
      if(v ~= nil) then
        if(src.x > v.start.x and src.y > v.start.y and src.z > v.start.z
          and src.x < v.finish.x and src.y < v.finish.y and src.z < v.finish.z) then
          drawLines(v.lines, true);
        end
      end
    end
  end
  
  -- Draw lines if player is inside zone
  

	
end


callbacks.Register("Draw", "himawari_prefire_helper_draw", onDraw);






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

