local reference = gui.Tab(gui.Reference("Visuals"), "localtab", "Helper")
local filtertext = gui.Editbox(reference, "filtertext", "Text to filter and show")
local console_filter = gui.Checkbox(reference, "console_filter", "Enable Console Filter", false)

local con_filter = 0
local con_filter_cache = 0

local function filter()
    con_filter = console_filter:GetValue() and 1 or 0

	if not filtertext:GetValue() then return end
    if con_filter ~= con_filter_cache then
        client.Command("Clear", true)
        client.SetConVar("con_filter_enable", con_filter, true)
        client.SetConVar("con_filter_text", filtertext:GetValue(), true)
        con_filter_cache = con_filter
    end
end

callbacks.Register("CreateMove", filter)

callbacks.Register("Unload", function()

    client.SetConVar("con_filter_enable", 0, true)
    client.SetConVar("con_filter_text", '', true)

end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")