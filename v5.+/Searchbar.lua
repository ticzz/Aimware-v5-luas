local info = {
	dir = "zerlib\\search\\",
	bl_dir = "blacklist.lua",
}

local blacklist = {}

local function GetBlacklist()
	local data = LoadScript(info.dir .. info.bl_dir)
	blacklist = data ~= nil and data or {}
end
GetBlacklist()

local function BuildBlacklist()
	local f_str = "local blacklist = {\n"
	for i, blacklisted in pairs(blacklist) do
		f_str = blacklisted:match(".*/$") ~= nil and f_str .. string.format('\t"%s",\n', blacklisted)
			or f_str .. string.format('\t"%s/",\n', blacklisted)
	end
	f_str = f_str .. "};\nreturn blacklist;"
	file.Write(info.dir .. info.bl_dir, f_str)
end

local ui_lua = gui.Reference("Settings", "Lua Scripts", "Browse", "")
ui_lua:SetPosY(56)
ui_lua:SetHeight(376)

local ui_search_lua =
	gui.Editbox(gui.Reference("Settings", "Lua Scripts", "Browse"), "search", "Search scripts")
ui_search_lua:SetPosY(0)
ui_search_lua:SetWidth(280)

local files, temp, folder = { lua = {} }, {}, "../.."

local function GetFiles(f)
	for i, blacklisted in pairs(blacklist) do
		if f:match(string.format("^%s.*", blacklisted)) ~= nil then
			return
		end
	end
	if f then 
	if f:match(".*lua$") ~= nil or f:match("../.*lua$") ~= nil then
		table.insert(files.lua, f)
	end
	end
end

local function Refresh()
	files = { lua = {} }
	file.Enumerate(GetFiles)
	GetBlacklist()
end
Refresh()

gui.Reference("Settings", "Lua Scripts", "Other", "Refresh List"):SetInvisible(true)
local ui_refresh_lua = gui.Button(gui.Reference("Settings", "Lua Scripts", "Other"), "Refresh List", Refresh)
ui_refresh_lua:SetPosY(42)
ui_refresh_lua:SetWidth(123)
ui_refresh_lua:SetPosX(0)
ui_refresh_lua:SetHeight(26)

local function ApplyLuaSearch()
	temp = {lua = {}}
	for i, lua in pairs(files.lua) do
		if lua:lower():match(ui_search_lua:GetValue():lower() .. string.format(".*lua$")) ~= nil then
			table.insert(temp.lua, lua)
		end
	end
	ui_lua:SetOptions(unpack(temp.lua))
end
local lua_search = gui.Custom(gui.Reference("Settings", "Lua Scripts"), "lua.search", 0, 0, 0, 0, ApplyLuaSearch)

local s_ref = gui.Groupbox(gui.Reference("Settings", "Advanced"), "Blacklisted Lua/Config Folder", 328, 16, 296)
local ui_blacklist_add_name = gui.Editbox(s_ref, "blacklist", "Add Folder Name to Blacklist (Case Sensitive)")
ui_blacklist_add_name:SetPosY(48)
local ui_blacklist_delete_name = gui.Combobox(s_ref, "blacklisted", "Delete from Blacklist", "")

local ui_blacklist_add = gui.Button(s_ref, "Add", function()
	local t_str = ui_blacklist_add_name:GetValue()
	table.insert(blacklist, t_str:match(".*/$") ~= nil and t_str or t_str .. "/")
	BuildBlacklist()
	Refresh()
end)
ui_blacklist_add:SetPosY(0)
ui_blacklist_add:SetWidth(124)

local ui_blacklist_delete = gui.Button(s_ref, "Delete", function()
	blacklist[ui_blacklist_delete_name:GetValue() + 1] = nil
	ui_blacklist_delete_name:SetValue(ui_blacklist_delete_name:GetValue() - 1)
	BuildBlacklist()
	Refresh()
end)
ui_blacklist_delete:SetPosY(0)
ui_blacklist_delete:SetPosX(140)
ui_blacklist_delete:SetWidth(124)

local function UIBlacklist()
	ui_blacklist_delete_name:SetDisabled(unpack(blacklist) == nil)
	ui_blacklist_delete:SetDisabled(unpack(blacklist) == nil)
	ui_blacklist_delete_name:SetOptions(unpack(blacklist))
end
local ui_blacklist = gui.Custom(s_ref, "blacklist", 0, 0, 0, 0, UIBlacklist)

callbacks.Register("Unload", function()
	ui_lua:SetPosY(0)
	ui_lua:SetHeight(432)
	gui.Reference("Settings", "Lua Scripts", "Other", "Refresh List"):SetInvisible(false)
end)

--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
