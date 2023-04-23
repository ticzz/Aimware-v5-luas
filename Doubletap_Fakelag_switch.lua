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

AutoUpdate("https://raw.githubusercontent.com/Aimware0/aimware_scripts/main/Force_Fakelag.lua",
	"Force Fakelag up to date",
	"Force Fakelag has been updated, reload the lua")


local fakelag_tab = gui.Tab(gui.Reference("Misc"), "Chicken.fakelag_stuff.tab", "Chicken's fakelag")

local force_fakelag_enable = gui.Checkbox(fakelag_tab, "Chicken.fakelag_stuff.force_fakelag", "Force Fakelag", false)
force_fakelag_enable:SetDescription("Captures current DT settings, Turns off DT, then when disable, restores DT settings.")

-- local force_fakelag_on_scout = gui.Checkbox(fakelag_tab, "Chicken.fakelag_stuff.auto_force_fakelag_on_scout", "Auto force Fakelag on scout", false)
-- local disabe_fakelag_on_grenade = gui.Checkbox(fakelag_tab, "Chicken.fakelag_stuff.force_fakelag", "Disable Fakelag on grenade", false)

local draw_fakelag_indicator = gui.Checkbox(fakelag_tab, "Chicken.fakelag_stuff.draw_fakelag_indicator", "Draw Fakelag indicator", false)

local s_x, s_h = draw.GetScreenSize()

local indicator_x = gui.Slider(fakelag_tab, "Chicken.fakelag_stuff.fakelag_x_indicator", "Fakelag indicator X pos", 100, 1, s_x)
local indicator_y = gui.Slider(fakelag_tab, "Chicken.fakelag_stuff.fakelag_y_indicator", "Fakelag indicator Y pos", 100, 1, s_h)


local weapon_types = { 'shared', 'pistol', 'hpistol', 'smg', 'rifle', 'shotgun', 'asniper', 'lmg' }
local function get_doubletaps_and_disable()
	local doubletaps = {}
	for k, v in pairs(weapon_types) do
		doubletaps[v] = gui.GetValue("rbot.hitscan.accuracy." .. v .. ".doublefire")
		gui.SetValue("rbot.hitscan.accuracy." .. v .. ".doublefire", false)
	end
	return doubletaps
end


local cached_dt_methods = {}
local is_fakelag_forced = false
local dt_restored = false


local font = draw.CreateFont("Bahnschrift", 25)
callbacks.Register("Draw", function()
	if force_fakelag_enable:GetValue() and not is_fakelag_forced then
		gui.SetValue("misc.fakelag.enable", true)
		cached_dt_methods = get_doubletaps_and_disable()		
		is_fakelag_forced = true
		dt_restored = false
	elseif not force_fakelag_enable:GetValue() and not dt_restored then
		
		if cached_dt_methods["asniper"] then -- Check i
			print(1)
			for k, v in pairs(cached_dt_methods) do
				gui.SetValue("rbot.hitscan.accuracy." .. k .. ".doublefire", v)
			end
			dt_restored = true
			is_fakelag_forced = false
		end
	end
	
	
	if draw_fakelag_indicator:GetValue() then
		draw.SetFont(font)
		local is_any_dt_enabled = false
		for k, v in pairs(weapon_types) do
			if gui.GetValue("rbot.hitscan.accuracy." .. v .. ".doublefire") ~= 0 then
				is_any_dt_enabled = true
				break
			end
		end
		if is_any_dt_enabled or not gui.GetValue("misc.fakelag.enable") then
			draw.Color(255,0,0)
		else
			draw.Color(0,255,0)
		end
		draw.Text(indicator_x:GetValue(), indicator_y:GetValue(), "Fakelag")	
	end
end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

