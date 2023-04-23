--AW AutoUpdate
--version 1.0

local function split(s)
    local t = {}
    for chunk in string.gmatch(s, "[^\n\r]+") do
        t[#t+1] = chunk
    end
    return t
end

local should_unload = false

local function AutoUpdate(link, already_updated_text, downloading_update_text)
	local web_content = http.Get(link)
	local web_content_split = split(web_content)
	local has_autoupdate_sig = web_content_split[1] == "--AW AutoUpdate"
	
	if has_autoupdate_sig then
		local file_content_split = split(file.Read(GetScriptName()))
		if file_content_split[2] == web_content_split[2] then
			print(already_updated_text)
		else
			print(downloading_update_text)
			file.Write(GetScriptName(), web_content)
			should_unload = true -- UnloadScript only works within callbacks
		end
	else
		error("Didn't find 'AW AutoUpdate' signature in '" .. link .. "'")
	end
end

	
callbacks.Register("Draw", function()
	if should_unload then
		UnloadScript(GetScriptName()) -- UnloadScript only works within callbacks, and can't unregister callbacks from within a callback
	end
end)

AutoUpdate("https://raw.githubusercontent.com/Aimware0/aimware_scripts/main/Speedburst%20enable%20delay.lua",
	"♥♥♥ Speed Burst enable delay is fully up to date and loaded without Errors ♥♥♥",
	"Speed Burst enable delay has been updated, reload the lua.")
	


local weapon_types = { 'shared', 'pistol', 'hpistol', 'smg', 'rifle', 'shotgun', 'asniper', 'lmg' }

local function get_doubletaps_and_disable()
	local doubletaps = {}
	for k, v in pairs(weapon_types) do
		doubletaps[v] = gui.GetValue("rbot.hitscan.accuracy." .. v .. ".doublefire")
		gui.SetValue("rbot.hitscan.accuracy." .. v .. ".doublefire", false)
	end
	return doubletaps
end

local disabled_time = 0
local should_restore = false
local cached_dt_methods = {}

local ref = gui.Reference("Misc", "Movement", "Speed Burst")
local enable_delay = gui.Slider(ref, "Chicken.speedburst.dt_enable_delay", "Doubletap & Speed Burst enable delay", 0, 0, 10, 0.1)

local speedburst_attempt_fix = gui.Keybox(ref, "Chicken.speedburst.attempt_fix", "Attempt to fix speedburst when not working", 0)
speedburst_attempt_fix:SetDescription("I don't know if this is good.")
local max_ticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks")

local cached_max_ticks = max_ticks:GetValue()
local fix_count = 0
local fix_delay = 0
local attempt_fix = false

callbacks.Register("Draw", function()
	if gui.GetValue("misc.speedburst.enable") and not should_restore and gui.GetValue("misc.speedburst.key") and input.IsButtonPressed(gui.GetValue("misc.speedburst.key")) then
		cached_dt_methods = get_doubletaps_and_disable()
		gui.SetValue("misc.speedburst.enable", 0)
		
		should_restore = true
		disabled_time = globals.CurTime()
	end
	
	if should_restore and globals.CurTime() > disabled_time + enable_delay:GetValue() then
		for k, v in pairs(cached_dt_methods) do
			gui.SetValue("rbot.hitscan.accuracy." .. k .. ".doublefire", v)
		end
		gui.SetValue("misc.speedburst.enable", 1)
		should_restore = false
	end
	
	if speedburst_attempt_fix:GetValue() ~= 0 and input.IsButtonPressed(speedburst_attempt_fix:GetValue()) then
		attempt_fix = true
	end
	
	if attempt_fix and globals.CurTime() > fix_delay then
		max_ticks:SetValue(cached_max_ticks + fix_count)
		if fix_count == 4 then
			max_ticks:SetValue(cached_max_ticks)
			attempt_fix = false
			fix_count = 0
		end
		fix_count = fix_count + 1

		fix_delay = globals.CurTime() + 0.2
	end
	
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

