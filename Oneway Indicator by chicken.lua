local json_lib_installed = false
file.Enumerate(function(filename)
	if filename == "libraries/json.lua" then
		json_lib_installed = true
	end
end)

if not json_lib_installed then
	local body = http.Get("https://raw.githubusercontent.com/Aimware0/aimware_scripts/main/libraries/json.lua")
	file.Write("libraries/json.lua", body)
end

RunScript("libraries/json.lua")


local notify_lib_installed = false

file.Enumerate(function(filename)
	if filename == "libraries/chickens_notfication.lua" then
		notify_lib_installed = true
	end
end)

if not notify_lib_installed then
	local body = http.Get("https://raw.githubusercontent.com/Aimware0/aimware_scripts/main/libraries/chickens_notfication.lua")
	file.Write("libraries/chickens_notfication.lua", body)
end

RunScript("libraries/chickens_notfication.lua")




function file.Exists(file_name)
  local exists = false
  file.Enumerate(function(_name)
    if file_name == _name then
      exists = true
    end
  end)
  return exists
end

function file.Contents(file_name)
  local f = file.Open(file_name, "r")
  local contents = f:Read()
  f:Close()
  return contents
end


local font = draw.CreateFont("Bahnschrift", 30)

notify:SetFont(font)
--notify:SetPrefix("[1way]")
--notify:SetPrefixColor({255, 165,0})
--notify:Add("Loaded", 5, true)

-- gui
local oneway_indicator_tab = gui.Tab(gui.Reference("Ragebot"), "Chicken.oneway_indicator", "Oneway indicator")
local oneway_indicator_group = gui.Groupbox(oneway_indicator_tab, "Keybinds", 15, 15, 605, 0 )
local oneway_indicator_enabled = gui.Checkbox(oneway_indicator_group, "oneway_enable", "Enable oneway indicator", true)

local oneway_indicator_add_oneway_key = gui.Keybox(oneway_indicator_group, "add_oneway", "Add oneway", 33)
local oneway_indicator_remove_oneway_key = gui.Keybox(oneway_indicator_group, "remove_oneway", "Remove closest oneway", 34)
local oneway_indicator_autowalk_key = gui.Keybox(oneway_indicator_group, "autowalk_oneway", "Autowalk to closest oneway", 70)

local oneway_indicator_circle_size = gui.Slider( oneway_indicator_group, "circle_size", "Circle size", 3, 1, 500)
local oneway_indicator_circle_distance = gui.Slider( oneway_indicator_group, "circle_draw_distance", "Draw circle distance", 1200, 1, 4000)

function map(n, start1, stop1, start2, stop2)
  return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end


local function move_to_pos(pos, cmd) -- not mine I think shadyretards?
	local LocalPlayer = entities.GetLocalPlayer()
	local angle_to_target = (pos - entities.GetLocalPlayer():GetAbsOrigin()):Angles()
	local my_pos = LocalPlayer:GetAbsOrigin()
	
	local speed = 255
	local dist = vector.Distance({my_pos.x, my_pos.y, my_pos.z}, {pos.x, pos.y, pos.z})

	if dist < 40 then
		speed = map(dist, 0, 40, 0, 255)
	end
	
	cmd.forwardmove = math.cos(math.rad((engine:GetViewAngles() - angle_to_target).y)) * speed
	cmd.sidemove = math.sin(math.rad((engine:GetViewAngles() - angle_to_target).y)) * speed
end

local function get_enemies()
    local players = entities.FindByClass("CCSPlayer")
    local enemies = {}
    local lp = entities.GetLocalPlayer()
    for k,v in pairs(players) do
        if v ~= lp and v:GetTeamNumber() ~= lp:GetTeamNumber() then
            table.insert(enemies, v)
        end
    end
    return enemies
end


local function IsValid(entity)
	return entity and entity:GetIndex()
end



local function update_file(content)
	local oneway_file = file.Open("oneway_coords.txt", "w")
	oneway_file:Write(json.encode(content))
	oneway_file:Close()

	oneways = json.decode(file.Contents("oneway_coords.txt"))
end



if not file.Exists("oneway_coords.txt") then
	local f = file.Open("oneway_coords.txt", "a")
	f:Write([[{
    "de_me": []
}]])
	f:Close()
end

local oneways = json.decode(file.Contents("oneway_coords.txt"))



local function get_nearest_oneway()
	local localplayer = entities.GetLocalPlayer()
	if not IsValid(localplayer) then return end

	local lowest_dist = math.huge
	local closest_oneway = nil
	local index = 0

	for i, oneway in ipairs(oneways[engine.GetMapName()]) do
		local my_pos = localplayer:GetAbsOrigin()
		local dist = vector.Distance({my_pos.x, my_pos.y, my_pos.z}, {oneway[1],oneway[2],oneway[3]})
		if dist < lowest_dist then
			lowest_dist = dist
			closest_oneway = oneway
			index = i
		end
	end
	return closest_oneway, index, lowest_dist
end


local function add_oneway(pos)
	oneways = json.decode(file.Contents("oneway_coords.txt"))
	table.insert(oneways[engine.GetMapName()], pos)
	update_file(oneways)
end


local killer_pos = {}
local save_killer_pos_btn = gui.Button(oneway_indicator_group, "Save the position of the person who killed you, when they killed you.", function()
	if #killer_pos == 0 then
		notify:Add("No killer position found", 3, true)
	else
		add_oneway(killer_pos)
		notify:Add("Added 1way from your killer", 5, true)
		killer_pos = {}
	end
end)

save_killer_pos_btn:SetWidth(565)

local function remove_oneway()
	oneways = json.decode(file.Contents("oneway_coords.txt"))
	local _, index, dist = get_nearest_oneway()
	if dist < 600 then
		table.remove(oneways[engine.GetMapName()], index)
		update_file(oneways)
		notify:Add("Removed 1way", 5, true)
	end
end


local function draw_oneways()
	if not oneway_indicator_enabled:GetValue() then return end
	if oneways[engine.GetMapName()] == nil then return end

	for k, oneway in pairs(oneways[engine.GetMapName()]) do
		local circle_dist = vector.Distance({entities.GetLocalPlayer():GetAbsOrigin().x,entities.GetLocalPlayer():GetAbsOrigin().y,entities.GetLocalPlayer():GetAbsOrigin().z}, {oneway[1],oneway[2],oneway[3]} )
		if circle_dist < oneway_indicator_circle_distance:GetValue() then
			local players = entities.FindByClass("CCSPlayer")
			for i, player in ipairs(players) do
				local isEnemy = entities.GetLocalPlayer():GetTeamNumber() ~= player:GetTeamNumber()
				local dist = vector.Distance({player:GetAbsOrigin().x,player:GetAbsOrigin().y,player:GetAbsOrigin().z}, {oneway[1],oneway[2],oneway[3]} )
				local x, y = client.WorldToScreen(Vector3(oneway[1], oneway[2], oneway[3]))
				if x and y then
				
					if dist < 100 and isEnemy and player:IsAlive() then 
						draw.Color(255, 0, 0)
						draw.FilledCircle(x, y, oneway_indicator_circle_size:GetValue() + 3)
					elseif dist < 1 and entities.GetLocalPlayer():GetIndex() == player:GetIndex() then
						draw.Color(255, 165, 0)
						draw.FilledCircle(x, y, oneway_indicator_circle_size:GetValue() + 3)

					elseif dist < 100 and not IsEnemy and player:IsAlive() and entities.GetLocalPlayer():GetIndex() ~= player:GetIndex() then
						draw.Color(0, 255, 0)
						draw.FilledCircle(x, y, oneway_indicator_circle_size:GetValue() + 3)
					else
						draw.FilledCircle(x, y, oneway_indicator_circle_size:GetValue())
					end
				end
			end
		end
		draw.Color(255, 255, 255)
	end
end

callbacks.Register("FireGameEvent", function(e)
	if e and e:GetName() == "player_death" then
		local local_index = client.GetLocalPlayerIndex()
		local victim_index = client.GetPlayerIndexByUserID(e:GetInt( "userid" ))
		local attacker_index = client.GetPlayerIndexByUserID(e:GetInt( "attacker" ))
		
		if local_index == victim_index then
			local attacker = entities.GetByUserID(e:GetInt("attacker"))
			killer_pos = {attacker:GetAbsOrigin().x, attacker:GetAbsOrigin().y, attacker:GetAbsOrigin().z}
		end
	
	end
end)
client.AllowListener("player_death")

callbacks.Register("Draw", function()
	if not oneway_indicator_enabled:GetValue() then return end

	local localplayer = entities.GetLocalPlayer()
	if not IsValid(localplayer) then return end
	
	draw_oneways()
	
	if oneway_indicator_add_oneway_key:GetValue() ~= 0 and input.IsButtonReleased(oneway_indicator_add_oneway_key:GetValue()) then
		if localplayer:IsAlive() then
			notify:Add("Added 1way", 5, true)
			local my_pos = localplayer:GetAbsOrigin()
			add_oneway({my_pos.x, my_pos.y, my_pos.z})
		else
			if localplayer:GetProp("m_iObserverMode") ~= 6 then -- 6 = free cam
				local observing = localplayer:GetPropEntity("m_hObserverTarget")
				local observing_pos = observing:GetAbsOrigin()
				notify:Add("Added 1way by spectating " .. observing:GetName(), 5, true)
				print("Added 1way by spectating " .. observing:GetName())
				add_oneway({observing_pos.x,observing_pos.y,observing_pos.z})
			end
		end
	end

	if oneway_indicator_remove_oneway_key:GetValue() ~= 0 and input.IsButtonReleased(oneway_indicator_remove_oneway_key:GetValue()) then
		remove_oneway()
	end
	if oneway_indicator_autowalk_key:GetValue() ~= 0 and input.IsButtonDown(oneway_indicator_autowalk_key:GetValue()) then
		local _, index, dist = get_nearest_oneway()
		local oneway = oneways[engine.GetMapName()][index]
		local x1, y1 = client.WorldToScreen(entities.GetLocalPlayer():GetAbsOrigin())
		local x2, y2 = client.WorldToScreen(Vector3(oneway[1], oneway[2], oneway[3]))
		if x1 and y1 and x2 and y2 then
			draw.Line(x1, y1, x2, y2)
		end
	end
end)



callbacks.Register("CreateMove", function(cmd)
	if not oneway_indicator_enabled:GetValue() then return end

	local localplayer = entities.GetLocalPlayer()
	if not IsValid(localplayer) then return end

	if oneway_indicator_autowalk_key:GetValue() ~= 0 and input.IsButtonDown(oneway_indicator_autowalk_key:GetValue()) then
		local cached_auto_dt = gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire")
		local oneway, _, dist = get_nearest_oneway()
		if dist > 0.1 then
			move_to_pos(Vector3(oneway[1], oneway[2], oneway[3]), cmd)
		end
	end
  
end)


function check_if_map_exists()
	if oneways[engine.GetMapName()] == nil then
		oneways[engine.GetMapName()] = {}
		update_file(oneways)
	end
end

callbacks.Register("Draw", check_if_map_exists)

local function update_ui()
	if oneway_indicator_enabled:GetValue() then
		oneway_indicator_add_oneway_key:SetDisabled(false)
		oneway_indicator_remove_oneway_key:SetDisabled(false)
		oneway_indicator_autowalk_key:SetDisabled(false)
		oneway_indicator_circle_size:SetDisabled(false)
	oneway_indicator_circle_distance:SetDisabled(false)
	else
		oneway_indicator_add_oneway_key:SetDisabled(true)
		oneway_indicator_remove_oneway_key:SetDisabled(true)
		oneway_indicator_autowalk_key:SetDisabled(true)
		oneway_indicator_circle_size:SetDisabled(true)
		oneway_indicator_circle_distance:SetDisabled(true)
	end
end

callbacks.Register("Draw", update_ui)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

