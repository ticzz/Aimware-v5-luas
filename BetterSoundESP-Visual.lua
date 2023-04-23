local timedTable = {};

-- GUI
local TabPosition = gui.Reference("VISUALS");
local TAB = gui.Tab(TabPosition, "himwari_sound_esp", "Better Sound ESP");
local MULTIBOX = gui.Groupbox(TAB, "General Settings", 15, 15, 295, 400);
local WEAPONBOX = gui.Groupbox(TAB, "Weapon Settings", 325, 15, 295, 400);
local PLAYERBOX = gui.Groupbox(TAB, "Player Settings", 325, 475+15, 295, 400);
local ITEMBOX = gui.Groupbox(TAB, "Item Settings", 15, 620, 295, 400);
local OTHERBOX = gui.Groupbox(TAB, "Other Settings", 15, 930, 295, 400);
local GRENADEBOX = gui.Groupbox(TAB, "Grenade Settings", 325, 800, 295, 400);

gui.Text(MULTIBOX, "Box Settings");
local BOX_SIZE = gui.Slider(MULTIBOX, "bsesp_box_size", "Box Size", 5, 0, 100);
gui.Text(MULTIBOX, "Circle Settings");
local CIRCLE_SIZE = gui.Slider(MULTIBOX, "bsesp_circle_size", "Circle Size", 5, 0, 100);
local START_CIRCLE_SIZE = gui.Slider(MULTIBOX, "bsesp_circle_ssize", "Circle Start Size", 1, 0, 100);

local MAX_DISTANCE = gui.Slider(MULTIBOX, "bsesp_hearability_distance", "Max Distance", 1000, 0, 10000);

local METHOD = gui.Combobox(MULTIBOX, "bsesp_circles", "Method", "Box", "Circles", "Scaling Circles");

local TEAM_ENABLED = gui.Checkbox( MULTIBOX, "bsesp_team_enabled", "Team Sounds", 0 );
local SELF_ENABLED = gui.Checkbox( MULTIBOX, "bsesp_self_enabled", "My Sounds", 0 );

local TYPE_TEXT = gui.Checkbox( MULTIBOX, "bsesp_text_type_enabled", "Sound Type Text", 1 );
local TEXT_Y_TYPE = gui.Slider(MULTIBOX, "bsesp_text_type_y", "Type Text Y", 2, 0, 100);
local PLAYERNAME_TEXT = gui.Checkbox( MULTIBOX, "bsesp_text_name_enabled", "Player Name Text", 1 );
local TEXT_Y_PLAYERNAME = gui.Slider(MULTIBOX, "bsesp_text_playername_y", "Name Text Y", 4, 0, 100);
local TEXT_COLOR_TYPE =  gui.ColorPicker(TYPE_TEXT, "besp_type_text_color", "Type Text Color", 255, 255, 255, 255);
local TEXT_COLOR_NAME =  gui.ColorPicker(PLAYERNAME_TEXT, "besp_name_text_color", "Name Text Color", 255, 255, 255, 255);

-- Weapon setings
local weapon_fire_enabled = gui.Checkbox( WEAPONBOX, "bsesp_weapon_fire_enabled", "Weapon Fire Enabled", 1 );
local weapon_fire_time = gui.Slider(WEAPONBOX, "bsesp_time_weapon_fire", "Weapon Fire Duration (s)", 3, 0, 100);
local weapon_fire_color = gui.ColorPicker(weapon_fire_enabled, "besp_weapon_fire_color", "Weapon Fire Color", 255, 0, 0, 255);
 
local weapon_fire_on_empty_enabled = gui.Checkbox( WEAPONBOX, "bsesp_weapon_fire_on_empty_enabled", "Weapon Fire (Empty) Enabled", 1 );
local weapon_fire_on_empty_time = gui.Slider(WEAPONBOX, "bsesp_time_weapon_fire_on_empty", "Weapon Fire (Empty) Duration (s)", 3, 0, 100);
local weapon_fire_on_empty_color = gui.ColorPicker(weapon_fire_on_empty_enabled, "besp_weapon_fire_on_empty_color", "Weapon Fire (Empty) Color", 255, 0, 0, 255);

local weapon_reload_enabled = gui.Checkbox( WEAPONBOX, "bsesp_weapon_reload_enabled", "Weapon Reload Enabled", 1 );
local weapon_reload_time = gui.Slider(WEAPONBOX, "bsesp_time_weapon_reload", "Weapon Reload Duration (s)", 3, 0, 100);
local weapon_reload_color = gui.ColorPicker(weapon_reload_enabled, "besp_weapon_reload_color", "Weapon Reload Color", 255, 0, 0, 255);

local weapon_zoom_enabled = gui.Checkbox( WEAPONBOX, "bsesp_weapon_zoom_enabled", "Weapon Zoom Enabled", 1 );
local weapon_zoom_time = gui.Slider(WEAPONBOX, "bsesp_time_weapon_zoom", "Weapon Zoom Duration (s)", 3, 0, 100);
local weapon_zoom_color = gui.ColorPicker(weapon_zoom_enabled, "besp_weapon_zoom_color", "Weapon Zoom Color", 255, 0, 0, 255);

local grenade_thrown_enabled = gui.Checkbox( WEAPONBOX, "bsesp_grenade_thrown_enabled", "Grenade Thrown Enabled", 1 );
local grenade_thrown_time = gui.Slider(WEAPONBOX, "bsesp_time_grenade_thrown", "Grenade Thrown Duration (s)", 3, 0, 100);
local grenade_thrown_color = gui.ColorPicker(grenade_thrown_enabled, "besp_grenade_thrown_color", "Grenade Thrown Color", 255, 0, 0, 255);


-- Player settings
local player_hurt_enabled = gui.Checkbox( PLAYERBOX, "bsesp_player_hurt_enabled", "Player Hurt Enabled", 1 );
local player_hurt_time = gui.Slider(PLAYERBOX, "bsesp_time_player_hurt", "Player Hurt Duration (s)", 3, 0, 100);
local player_hurt_color = gui.ColorPicker(player_hurt_enabled, "besp_player_hurt_color", "Player Hurt Color", 255, 0, 0, 255);

local player_jump_enabled = gui.Checkbox( PLAYERBOX, "bsespplayer_jump_enabled", "Player Jump Enabled", 1 );
local player_jump_time = gui.Slider(PLAYERBOX, "bsesp_time_player_jump", "Player Jump Duration (s)", 3, 0, 100);
local player_jump_color = gui.ColorPicker(player_jump_enabled, "besp_player_jump_color", "Player Jump Color", 255, 0, 0, 255);

local player_footstep_enabled = gui.Checkbox( PLAYERBOX, "bsesp_player_footstep_enabled", "Footsteps Enabled", 1 );
local player_footstep_time = gui.Slider(PLAYERBOX, "bsesp_player_footstep_remove", "Footstepse Duration (s)", 3, 0, 100);
local player_footstep_color = gui.ColorPicker(player_footstep_enabled, "besp_player_footstep_color", "Footsteps Color", 255, 0, 0, 255);

-- Item settings


local item_pickup_enabled = gui.Checkbox( ITEMBOX, "bsesp_item_pickup_enabled", "Item Pickup Enabled", 1 );
local item_pickup_time = gui.Slider(ITEMBOX, "bsesp_time_item_pickup", "Item Pickup Duration (s)", 3, 0, 100);
local item_pickup_color = gui.ColorPicker(item_pickup_enabled, "besp_item_pickup_color", "Item Pickup Color", 255, 0, 0, 255);

local item_remove_enabled = gui.Checkbox( ITEMBOX, "bsesp_item_remove_enabled", "Item Remove Enabled", 1 );
local item_remove_time = gui.Slider(ITEMBOX, "bsesp_time_item_remove", "Item Remove Duration (s)", 3, 0, 100);
local item_remove_color = gui.ColorPicker(item_remove_enabled, "besp_item_remove_color", "Item Remove Color", 255, 0, 0, 255);

local item_equip_enabled = gui.Checkbox( ITEMBOX, "bsesp_item_equip_enabled", "Item Equip Enabled", 1 );
local item_equip_time = gui.Slider(ITEMBOX, "bsesp_item_equip_remove", "Item Equip Duration (s)", 3, 0, 100);
local item_equip_color = gui.ColorPicker(item_equip_enabled, "besp_item_equip_color", "Item Equip Color", 255, 0, 0, 255);

-- Bomb settings

local bomb_beginplant_enabled = gui.Checkbox( OTHERBOX, "bsesp_bomb_beginplant_enabled", "Bomb Plant Enabled", 1 );
local bomb_beginplant_time = gui.Slider(OTHERBOX, "bsesp_bomb_beginplant_remove", "Bomb Plant Duration (s)", 3, 0, 100);
local bomb_beginplant_color = gui.ColorPicker(bomb_beginplant_enabled, "besp_bomb_beginplant_color", "Bomb Plant Color", 255, 0, 0, 255);

local bomb_begindefuse_enabled = gui.Checkbox( OTHERBOX, "bsesp_bomb_begindefuse_enabled", "Bomb Defuse Enabled", 1 );
local bomb_begindefuse_time = gui.Slider(OTHERBOX, "bsesp_bomb_begindefuse_remove", "Bomb Defuse Duration (s)", 3, 0, 100);
local bomb_begindefuse_color = gui.ColorPicker(bomb_begindefuse_enabled, "besp_bomb_begindefuse_color", "Bomb Defuse Color", 255, 0, 0, 255);

-- Grenade settings

local hegrenade_detonate_enabled = gui.Checkbox( GRENADEBOX, "bsesp_hegrenade_detonate_enabled", "HE Grenade Explosion Enabled", 1 );
local hegrenade_detonate_time = gui.Slider(GRENADEBOX, "bsesp_hegrenade_detonate_time", "HE Grenade Explosion Duration (s)", 3, 0, 100);
local hegrenade_detonate_color = gui.ColorPicker(hegrenade_detonate_enabled, "besp_hegrenade_detonate_color", "HE Grenade Explosion Color", 255, 0, 0, 255);

local flashbang_detonate_enabled = gui.Checkbox( GRENADEBOX, "bsesp_flashbang_detonate_enabled", "FLASH Grenade Explosion Enabled", 1 );
local flashbang_detonate_time = gui.Slider(GRENADEBOX, "bsesp_flashbang_detonate_time", "FLASH Grenade Explosion Duration (s)", 3, 0, 100);
local flashbang_detonate_color = gui.ColorPicker(flashbang_detonate_enabled, "besp_flashbang_detonate_color", "FLASH Grenade Explosion Color", 255, 0, 0, 255);

local smokegrenade_detonate_enabled = gui.Checkbox( GRENADEBOX, "bsesp_smokegrenade_detonate_enabled", "SMOKE Grenade Explosion Enabled", 1 );
local smokegrenade_detonate_time = gui.Slider(GRENADEBOX, "bsesp_smokegrenade_detonate_time", "SMOKE Grenade Explosion Duration (s)", 3, 0, 100);
local smokegrenade_detonate_color = gui.ColorPicker(smokegrenade_detonate_enabled, "besp_smokegrenade_detonate_color", "SMOKE Grenade Explosion Color", 255, 0, 0, 255);

local decoy_detonate_enabled = gui.Checkbox( GRENADEBOX, "bsesp_decoy_detonate_enabled", "DECOY Grenade Explosion Enabled", 1 );
local decoy_detonate_time = gui.Slider(GRENADEBOX, "bsesp_decoy_detonate_time", "DECOY Grenade Explosion Duration (s)", 3, 0, 100);
local decoy_detonate_color = gui.ColorPicker(decoy_detonate_enabled, "besp_decoy_detonate_color", "DECOY Grenade Explosion Color", 255, 0, 0, 255);

local molotov_detonate_enabled = gui.Checkbox( GRENADEBOX, "bsesp_molotov_detonate_enabled", "MOLOTOV Grenade Explosion Enabled", 1 );
local molotov_detonate_time = gui.Slider(GRENADEBOX, "bsesp_molotov_detonate_time", "MOLOTOV Grenade Explosion Duration (s)", 3, 0, 100);
local molotov_detonate_color = gui.ColorPicker(molotov_detonate_enabled, "besp_molotov_detonate_color", "MOLOTOV Grenade Explosion Color", 255, 0, 0, 255);

local decoy_firing_enabled = gui.Checkbox( GRENADEBOX, "bsesp_decoy_firing_enabled", "DECOY Firing Enabled", 1 );
local decoy_firing_time = gui.Slider(GRENADEBOX, "bsesp_decoy_firing_time", "DECOY Firing Duration (s)", 3, 0, 100);
local decoy_firing_color = gui.ColorPicker(decoy_firing_enabled, "besp_decoy_firing_color", "DECOY Firing Color", 255, 0, 0, 255);


-- Utility
local function drawCircle(wx, wy, wz, text, name, size)
	-- Draw the circle
	local sx, sy, sz;
	sx = wx + math.sin(0) * size;
	sy = wy + math.cos(0) * size;
	for i = 0, 360, 45 do
		local q = i * math.pi / 180;
		local qx = wx + math.sin(q) * size;
		local qy = wy + math.cos(q) * size;
		local vs = Vector3(sx, sy, wz);
		local ve = Vector3(qx, qy, wz);
		
		local x1, y1 = client.WorldToScreen(vs);
		local x2, y2 = client.WorldToScreen(ve);
		
		if(x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil) then
			draw.Line(x1, y1, x2, y2);
		end
		sx = qx;
		sy = qy;
	end
	
	local tx, ty = client.WorldToScreen(Vector3(wx, wy, wz + TEXT_Y_TYPE:GetValue()));
	local tnx, tny = client.WorldToScreen(Vector3(wx, wy, wz + TEXT_Y_PLAYERNAME:GetValue()));
	if(tx ~= nil and ty ~= nil) then		
		if(TYPE_TEXT:GetValue()) then
			draw.Color(TEXT_COLOR_TYPE:GetValue());
			draw.Text(tx, ty, text);
		end
	end
	if(tnx ~= nil and tny ~= nil) then
		if(PLAYERNAME_TEXT:GetValue()) then
			draw.Color(TEXT_COLOR_NAME:GetValue());
			draw.Text(tnx, tny, name);
		end
	end
end

local function newSound(sid, wx, wy, wz, duration, text, playerName)
	sound = {
		id = sid;
		x = wx;
		y = wy;
		z = wz;
		d = duration;
		st = globals.RealTime();
		title = text;
		name = playerName;
	};
	table.insert(timedTable, sound);
end

local function drawBox(wx, wy, wz, text, name)
	local s = BOX_SIZE:GetValue();
	local lfb = Vector3(wx - s, wy - s, wz - s);
	local lft = Vector3(wx - s, wy + s, wz - s);
	local lbb = Vector3(wx - s, wy - s, wz + s);
	local lbt = Vector3(wx - s, wy + s, wz + s);
	local rfb = Vector3(wx + s, wy - s, wz - s);
	local rft = Vector3(wx + s, wy + s, wz - s);
	local rbb = Vector3(wx + s, wy - s, wz + s);
	local rbt = Vector3(wx + s, wy + s, wz + s);
	
	local lfbx, lfby = client.WorldToScreen(lfb);
	local lftx, lfty = client.WorldToScreen(lft);
	local lbbx, lbby = client.WorldToScreen(lbb);
	local lbtx, lbty = client.WorldToScreen(lbt);
	local rfbx, rfby = client.WorldToScreen(rfb);
	local rftx, rfty = client.WorldToScreen(rft);
	local rbbx, rbby = client.WorldToScreen(rbb);
	local rbtx, rbty = client.WorldToScreen(rbt);

	local tx, ty = client.WorldToScreen(Vector3(wx, wy, wz + TEXT_Y_TYPE:GetValue()));
	local tnx, tny = client.WorldToScreen(Vector3(wx, wy, wz + TEXT_Y_PLAYERNAME:GetValue()));

	if(lfbx ~= nil and lfby ~= nil and
	lftx ~= nil and lfty ~= nil and
	lbbx ~= nil and lbby ~= nil and
	lbtx ~= nil and lbty ~= nil and
	rfbx ~= nil and rfby ~= nil and
	rftx ~= nil and rfty ~= nil and
	rbbx ~= nil and rbby ~= nil and
	rbtx ~= nil and rbty ~= nil) then

		draw.Line(lbtx, lbty, rbtx, rbty);
		draw.Line(lbtx, lbty, lbbx, lbby);
		draw.Line(lbtx, lbty, lftx, lfty);
		draw.Line(rbtx, rbty, rftx, rfty);
		
		draw.Line(rbtx, rbty, rbbx, rbby);
		draw.Line(rbbx, rbby, rfbx, rfby);
		draw.Line(rfbx, rfby, rftx, rfty);
		draw.Line(rfbx, rfby, lfbx, lfby);
		
		draw.Line(rbbx, rbby, lbbx, lbby);
		draw.Line(lbbx, lbby, lfbx, lfby);
		draw.Line(lftx, lfty, lfbx, lfby);
		draw.Line(lftx, lfty, rftx, rfty);
		
		if(tx ~= nil and ty ~= nil) then		
			if(TYPE_TEXT:GetValue()) then
				draw.Color(TEXT_COLOR_TYPE:GetValue());
				draw.Text(tx, ty, text);
			end
		end
		if(tnx ~= nil and tny ~= nil) then
			if(PLAYERNAME_TEXT:GetValue()) then
				draw.Color(TEXT_COLOR_NAME:GetValue());
				draw.Text(tnx, tny, name);
			end
		end
	end
	
end

local function currentTeam()	
	local localPlayerEntity = entities.GetLocalPlayer();
	local teamId = localPlayerEntity:GetTeamNumber();
	return teamId;
end

local function getDistance(my_x, my_y, my_z, t_x, t_y, t_z)
    local dx = my_x - t_x;
    local dy = my_y - t_y;
    local dz = my_z - t_z;
    return math.sqrt(dx*dx + dy*dy + dz*dz);
end


-- Just events
local function decoy_firing(Event)
	if decoy_firing_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		
		newSound("decoy_firing",x, y, z, decoy_firing_time:GetValue(), "Decoy Firing", "DECOY");
	end
end

local function hegrenade_detonate(Event)
	if hegrenade_detonate_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		
		newSound("hegrenade_detonate",x, y, z, hegrenade_detonate_time:GetValue(), "HE Explosion", "HE");
	end
end

local function flashbang_detonate(Event)
	if flashbang_detonate_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		newSound("flashbang_detonate",x, y, z, flashbang_detonate_time:GetValue(), "FLASH Explosion", "FLASH");
	end
end


local function smokegrenade_detonate(Event)
	if smokegrenade_detonate_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		newSound("smokegrenade_detonate",x, y, z, smokegrenade_detonate_time:GetValue(), "SMOKE Explosion", "SMOKE");
	end
end

local function decoy_detonate(Event)
	if decoy_detonate_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		newSound("decoy_detonate",x, y, z, decoy_detonate_time:GetValue(), "DECOY Explosion", "DECOY");
	end
end


local function molotov_detonate(Event)
	if molotov_detonate_enabled:GetValue() then
		local x = Event:GetInt('x');
		local y = Event:GetInt('y');
		local z = Event:GetInt('z');
		newSound("molotov_detonate",x, y, z, molotov_detonate_time:GetValue(), "MOLOTOV Explosion", "MOLOTOV");
	end
end


local function item_equip(Event)
	if item_equip_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		
		local position = entity:GetAbsOrigin();
		newSound("item_equip", position.x, position.y, position.z, item_equip_time:GetValue(), "Item Equip", entity:GetName());
	end
end

local function player_hurt(Event)
	if player_hurt_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("player_hurt", position.x, position.y, position.z, player_hurt_time:GetValue(), "Player Hurt", entity:GetName());
	end
end

local function bomb_beginplant(Event)
	if bomb_beginplant_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("bomb_beginplant", position.x, position.y, position.z, bomb_beginplant_time:GetValue(), "Bomb Plant", entity:GetName());
	end
end

local function bomb_begindefuse(Event)
	if bomb_begindefuse_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("bomb_begindefuse", position.x, position.y, position.z, bomb_begindefuse_time:GetValue(), "Bomb Defuse", entity:GetName());
	end
end


local function player_jump(Event)
	if player_jump_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("player_jump", position.x, position.y, position.z, player_jump_time:GetValue(), "Player Jump", entity:GetName());
	end
end

local function player_footstep(Event)
	if player_footstep_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("player_footstep", position.x, position.y, position.z, player_footstep_time:GetValue(), "Footsteps", entity:GetName());
	end
end

local function item_pickup(Event)
	if item_pickup_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("item_pickup", position.x, position.y, position.z, item_pickup_time:GetValue(), "Item Pickup", entity:GetName());
	end
end

local function item_remove(Event)
	if item_remove_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("item_remove", position.x, position.y, position.z, item_remove_time:GetValue(), "Item Remove", entity:GetName());
	end
end

local function grenade_thrown(Event)
	if grenade_thrown_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("grenade_thrown", position.x, position.y, position.z, grenade_thrown_time:GetValue(), "Grenade Thrown", entity:GetName());
	end
end

local function weapon_reload(Event)
	if weapon_reload_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("weapon_reload", position.x, position.y, position.z, weapon_reload_time:GetValue(), "Weapon Reload", entity:GetName());
	end
end

local function weapon_zoom(Event)
	if weapon_zoom_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("weapon_zoom", position.x, position.y, position.z, weapon_zoom_time:GetValue(), "Weapon Zoom", entity:GetName());
	end
end

local function weapon_fire(Event)
	if weapon_fire_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("weapon_fire", position.x, position.y, position.z, weapon_fire_time:GetValue(), "Weapon Fire", entity:GetName());
	end
end

local function weapon_fire_on_empty(Event)
	if weapon_fire_on_empty_enabled:GetValue() then
		local entity = entities.GetByUserID(Event:GetInt('userid'));
		if entity:GetIndex() == client:GetLocalPlayerIndex() and not SELF_ENABLED:GetValue() then
			return;
		end		
		if entity:GetTeamNumber() == currentTeam() and not TEAM_ENABLED:GetValue() then
			return;
		end;
		local position = entity:GetAbsOrigin();
		newSound("weapon_fire_on_empty", position.x, position.y, position.z, weapon_fire_on_empty_time:GetValue(), "Weapon Fire (Empty)", entity:GetName());
	end
end

-- On round end we need to clear our table :)
local function round_end(Event)
	-- Clear table
	timedTable = {};
end

local function bomb_planted(Event)
	local cancelTable = {};
	for i = 1, #timedTable do
		if(timedTable[i].id == "bomb_beginplant") then
			table.insert(cancelTable, i);
		end
	end
	for i = 1, #cancelTable do
		table.remove(timedTable, cancelTable[i]);
	end
end

local function bomb_abortplant(Event)
	local cancelTable = {};
	for i = 1, #timedTable do
		if(timedTable[i].id == "bomb_beginplant") then
			table.insert(cancelTable, i);
		end
	end
	for i = 1, #cancelTable do
		table.remove(timedTable, cancelTable[i]);
	end
end


local function bomb_abortdefuse(Event)
	local cancelTable = {};
	for i = 1, #timedTable do
		if(timedTable[i].id == "bomb_begindefuse") then
			table.insert(cancelTable, i);
		end
	end
	for i = 1, #cancelTable do
		table.remove(timedTable, cancelTable[i]);
	end
end

local function bomb_defused(Event)
	local cancelTable = {};
	for i = 1, #timedTable do
		if(timedTable[i].id == "bomb_begindefuse") then
			table.insert(cancelTable, i);
		end
	end
	for i = 1, #cancelTable do
		table.remove(timedTable, cancelTable[i]);
	end
end



-- Events
local function onGameEvent(Event)
	name = Event:GetName();
	if(name == "player_hurt") then
		player_hurt(Event);
	elseif name == "weapon_fire" then
		weapon_fire(Event);
	elseif name == "weapon_fire_on_empty" then
		weapon_fire_on_empty(Event);
	elseif name == "grenade_thrown" then
		grenade_thrown(Event);
	elseif name == "weapon_reload" then
		weapon_reload(Event);
	elseif name == "weapon_zoom" then
		weapon_zoom(Event);
	elseif name == "item_pickup" then
		item_pickup(Event);
	elseif name == "item_remove" then
		item_remove(Event);
	elseif name == "player_jump" then
		player_jump(Event);
	elseif name == "player_footstep" then
		player_footstep(Event);
	elseif name == "bomb_beginplant" then
		bomb_beginplant(Event);
	elseif name == "bomb_planted" then
		bomb_planted(Event);
	elseif name == "bomb_abortplant" then
		bomb_abortplant(Event);		
	elseif name == "bomb_begindefuse" then
		bomb_begindefuse(Event);
	elseif name == "bomb_abortdefuse" then
		bomb_abortdefuse(Event);
	elseif name == "bomb_defused" then
		bomb_defused(Event);
	elseif name == "item_equip" then
		item_equip(Event);
	elseif name == "round_end" then
		round_end(Event);
	elseif name == "hegrenade_detonate" then
		hegrenade_detonate(Event);
	elseif name == "flashbang_detonate" then
		flashbang_detonate(Event);
	elseif name == "molotov_detonate" then
		molotov_detonate(Event);
	elseif name == "decoy_detonate" then
		decoy_detonate(Event);
	elseif name == "decoy_firing" then
		decoy_firing(Event);
	elseif name == "smokegrenade_detonate" then

		smokegrenade_detonate(Event);
	end

end


local function onDraw()
	currentTime = globals.RealTime();
	for i = 1, #timedTable do
		local data = timedTable[i];
		local zOffset = 50;
		if data.st + data.d >= currentTime then
			if data.id == "weapon_fire" then
				draw.Color(weapon_fire_color:GetValue());
			elseif data.id == "player_hurt" then
				draw.Color(player_hurt_color:GetValue());
			elseif data.id == "weapon_fire_on_empty" then
				draw.Color(weapon_fire_on_empty_color:GetValue());
			elseif data.id == "grenade_thrown" then
				draw.Color(grenade_thrown_color:GetValue());
			elseif data.id == "weapon_reload" then
				draw.Color(weapon_reload_color:GetValue());
			elseif data.id == "weapon_zoom" then
				draw.Color(weapon_zoom_color:GetValue());
			elseif data.id == "item_pickup" then
				draw.Color(item_pickup_color:GetValue());
			elseif data.id == "item_remove" then
				draw.Color(item_remove_color:GetValue());
			elseif data.id == "player_jump" then
				draw.Color(player_jump_color:GetValue());
				zOffset = 0;
			elseif data.id == "hegrenade_detonate" then
				draw.Color(hegrenade_detonate_color:GetValue());
				zOffset = 0;
			elseif data.id == "flashbang_detonate" then
				draw.Color(flashbang_detonate_color:GetValue());
				zOffset = 0;
			elseif data.id == "smokegrenade_detonate" then
				draw.Color(smokegrenade_detonate_color:GetValue());
				zOffset = 0;
			elseif data.id == "decoy_detonate" then
				draw.Color(decoy_detonate_color:GetValue());
				zOffset = 0;
			elseif data.id == "molotov_detonate" then
				draw.Color(molotov_detonate_color:GetValue());
				zOffset = 0;
			elseif data.id == "player_footstep" then
				draw.Color(player_footstep_color:GetValue());
				zOffset = 0;
			elseif data.id == "decoy_firing" then
				draw.Color(decoy_firing_color:GetValue());
				zOffset = 0;
			elseif data.id == "bomb_beginplant" then
				draw.Color(bomb_beginplant_color:GetValue());
				zOffset = 25;
			elseif data.id == "bomb_begindefuse" then
				draw.Color(bomb_begindefuse_color:GetValue());
				zOffset = 25;
			end
			local maxDistance = MAX_DISTANCE:GetValue();
			local me = entities:GetLocalPlayer();
			if me ~= nil then
				local myPos = me:GetAbsOrigin();				
				if(getDistance(myPos.x, myPos.y, myPos.z, data.x, data.y, data.z) <= maxDistance) then
					if(METHOD:GetValue() == 0) then
						drawBox(data.x, data.y, data.z + zOffset, data.title, data.name);
					elseif(METHOD:GetValue() == 1) then
						drawCircle(data.x, data.y, data.z, data.title, data.name, CIRCLE_SIZE:GetValue());
					elseif(METHOD:GetValue() == 2) then
						local minSize = START_CIRCLE_SIZE:GetValue();
						local maxSize = CIRCLE_SIZE:GetValue();
						local totalTime = globals.RealTime() - data.st;
						local value = minSize + (maxSize - minSize) * (totalTime/data.d);
						drawCircle(data.x, data.y, data.z, data.title, data.name, value);
					end
				end
			end
		end
	end

end

-- Sounds esp section
client.AllowListener("player_hurt");
client.AllowListener("weapon_fire");
client.AllowListener("weapon_fire_on_empty");
client.AllowListener("grenade_thrown");
client.AllowListener("weapon_reload");
client.AllowListener("weapon_zoom");
client.AllowListener("item_pickup");
client.AllowListener("item_remove");
client.AllowListener("player_jump");
client.AllowListener("player_footstep");

-- Bomb section
client.AllowListener("bomb_beginplant");
client.AllowListener("bomb_planted");
client.AllowListener("bomb_abortplant");

client.AllowListener("bomb_begindefuse");
client.AllowListener("bomb_abortdefuse");
client.AllowListener("bomb_defused");

-- Grenades section
client.AllowListener("hegrenade_detonate");
client.AllowListener("flashbang_detonate");
client.AllowListener("smokegrenade_detonate");
client.AllowListener("molotov_detonate");
client.AllowListener("decoy_detonate");
client.AllowListener("decoy_firing");

-- Utility
client.AllowListener("round_end");

-- Callbacks section
callbacks.Register("Draw", "himawari_sound_esp_draw", onDraw);
callbacks.Register( 'FireGameEvent', 'himawari_sound_esp_gameevent', onGameEvent )





;








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

