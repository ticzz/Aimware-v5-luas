--OFFICIAL LUA by Verieth 
--load selected scripts with selected cfg

--gui
local lua_ref = gui.Reference("Settings")
local lua_tab = gui.Tab(lua_ref, "tab", ("Auto CFG"))
local lua_script_group = gui.Groupbox(lua_tab, "Select scripts for CFG", 10, 10, 615, 450)

local lua_scritps_multi_1 = gui.Multibox(lua_script_group, "Scripts 1")
local lua_scritps_multi_2 = gui.Multibox(lua_script_group, "Scripts 2")
local lua_scritps_multi_3 = gui.Multibox(lua_script_group, "Scripts 3")
local lua_scritps_multi_4 = gui.Multibox(lua_script_group, "Scripts 4")
local lua_scritps_multi_5 = gui.Multibox(lua_script_group, "Scripts 5")

local lua_file_list = {};

local lua_name = GetScriptName()

--adding this lua to autorun
local autorun_file = 'autorun.lua'

file.Delete(autorun_file)

file.Write(autorun_file, "LoadScript('" .. lua_name .. "')")
----------------------------

--get all lua file
local function enumerateFiles()
	file.Enumerate(function(file)
		if lua_name ~= file and file ~= 'autorun.lua' and string.find(file, '.lua') then

			--checkbox; file_name; isLoaded
			lua_file_list[#lua_file_list + 1] = {nil, file, nil}
		end
	end)
end

--make gui for all luas
local function createGui()
	local multiboxes_array = {lua_scritps_multi_1, lua_scritps_multi_2, lua_scritps_multi_3, lua_scritps_multi_4, lua_scritps_multi_5}

	for scripts = 1, #lua_file_list do
		--limit multibox value
		local multi_box_max_number = math.floor(#lua_file_list / 20) + 2
		local current_box_number = math.floor(scripts / 20) + 1

		--fuck don't use more than 100 scripts HAHAHAHAH
		if multi_box_max_number > 5 then
			multi_box_max_number = 5
		end

		--setinvisible not used multiboxes
		for multiboxes = multi_box_max_number, #multiboxes_array, 1 do
			multiboxes_array[multiboxes]:SetInvisible(true)
		end

		--create gui
		local script = lua_file_list[scripts]
		local parent = tostring(scripts)

		script[1] = gui.Checkbox(multiboxes_array[current_box_number], parent, script[2], false)
	end
end

--creating gui and script list then load scripts
local function getScriptsList()
	if not lua_file_list[1] then
		enumerateFiles()
		createGui()
	end
end

--loading selected scripts and unloading if not selected
local function loadSelectedScripts()
	for scripts = 1, #lua_file_list do
		local script = lua_file_list[scripts]

		if script[1]:GetValue() then
			if (script[3] == nil or script[3] == false) then
				LoadScript(script[2])
				script[3] = true
			end
		elseif (script[3] == true or script[3] == nil) and not script[1]:GetValue() then
			UnloadScript(script[2])
			script[3] = false
		end
	end
end

--unload all scripts on current script unload
local function unloadAll()
	for scripts = 1, #lua_file_list do
		local script = lua_file_list[scripts]

		UnloadScript(script[2])
	end
end

--callbacks 
callbacks.Register('Draw', function()
	getScriptsList()
	loadSelectedScripts()
end)

callbacks.Register('Unload', function()
	unloadAll()
end)