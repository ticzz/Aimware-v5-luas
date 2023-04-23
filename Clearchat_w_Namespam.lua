local client_set_clan_tag, client_set_event_callback, client_system_time, entity_get_local_player, entity_get_player_resource, entity_get_prop, entity_is_alive, globals_curtime, math_floor, string_format, string_rep, table_insert, table_sort, ui_get, ui_new_checkbox, ui_new_combobox, ui_new_slider, ui_new_textbox, ui_set_callback, ui_set_visible, pairs = client.set_clan_tag, client.set_event_callback, client.system_time, entity.get_local_player, entity.get_player_resource, entity.get_prop, entity.is_alive, globals.curtime, math.floor, string.format, string.rep, table.insert, table.sort, ui.get, ui.new_checkbox, ui.new_combobox, ui.new_slider, ui.new_textbox, ui.set_callback, ui.set_visible, pairs
local ui_set, ui_reference = ui.set, ui.reference
--------------------------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------------------------
local function collect_keys(tbl, custom)
    local keys = {}
    for k in pairs(tbl) do
        keys[#keys + 1] = k
    end
    table_sort(keys)
    if custom then
        table_insert(keys, 1, "Disabled")
        table_insert(keys, "Custom")
    end
    return keys
end

----------------------------------------------------------------------------------------

local names = {
    ["AimWare"] = "AIMWARE.net",
    ["Nixware"] = "nixware.cc",
    ["Johnny"] = "Johnny.systems",
    ["Onetap"] = "onetap.su",
    ["Gamesense"] = "gamesense.pub",
    ["Skeet"] = "skeet.cc",
    ["Break chat"] = "‫‬‭‫‬‭‮﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽﷽"
}

---------------------------------------------------------------------------------------

local menu = {
    enabled = ui_new_checkbox("Misc", "Miscellaneous", "Name Spam"),
    unnamed  = ui_new_checkbox("Misc", "Miscellaneous", "Unnamed exploit"),
    names    = ui_new_combobox("Misc", "Miscellaneous", "Names", collect_keys(names, true)),
    custom   = ui_new_textbox("Misc", "Miscellaneous", "Custom")
}

local nameSteal = ui_reference("Misc", "Miscellaneous", "Steal player name")
local sbreak = "\133"--""

local cl = {
    get_cvar = client.get_cvar,
    set_cvar = client.set_cvar
}

local stealnamee = ui_reference("MISC", "Miscellaneous", "Steal player name")

local function stealname() 
    ui_set(stealnamee, true)
end

local function SetMyName(name)
    cl.set_cvar("name", name)
end

local lol = false
local function setName(name, times)
    if times <= 0 then return end
    if not name then return end
    client.delay_call(.1, function()
        SetMyName((ui_get(menu.unnamed) and sbreak or "") .. name .. (lol and "" or " "))
        lol = not lol
        setName(name, times - 1)
    end)
end


local button =  ui.new_button("Misc", "Miscellaneous", "Name Spam", function()
    if not ui_get(menu.enabled) then return end
    stealname()
    local tempName = names[ui_get(menu.names)]
    if ui_get(menu.names) == "Custom" then 
        tempName = ui_get(menu.custom) 
    end
    setName(tempName, 5)
end)

local function handleMenu()
    local state = ui_get(menu.enabled)
        ui.set_visible(menu.names, state)
        ui.set_visible(menu.unnamed, state)
        ui.set_visible(button, state)
        ui.set_visible(menu.custom, ui_get(menu.names) == "Custom")
end

local function handleMenu2()
    if not ui_get(menu.enabled) then return end
    if ui_get(menu.names) == "Custom" then 
        ui.set_visible(menu.custom, true)
    else 
        ui.set_visible(menu.custom, false)
    end
end
handleMenu() 
handleMenu2()
ui.set_callback(menu.enabled, handleMenu)
ui.set_callback(menu.names, handleMenu2)