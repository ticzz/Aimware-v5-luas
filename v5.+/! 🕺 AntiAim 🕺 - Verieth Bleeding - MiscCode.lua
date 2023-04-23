--region AUTO_UPDATER
local CURRENT_VERSION = "2.0"
local LAST_VERSION = http.Get("https://raw.githubusercontent.com/MN1R/TheBleeding/main/MiscVersion")

--writing file with our version to remove tonumber, string.gsub for random format
local latest_version_file_name = "bleeding_last_version.txt"
file.Write(latest_version_file_name,  tostring(LAST_VERSION))

--getting data from file, its 100% string
local file_open = file.Open(latest_version_file_name, 'r')
local file_data = file_open:Read()
file_open:Close()

--getting full vesrion without any memes
LAST_VERSION = string.sub(file_data, 0, string.len(CURRENT_VERSION));

--deleting file
file.Delete(latest_version_file_name)

--if lua is outdated
if LAST_VERSION ~= CURRENT_VERSION then

    print("Lua is outdated.")

    --getting latest data
    local LAST_LUA_DATA = http.Get("https://raw.githubusercontent.com/MN1R/TheBleeding/main/MiscCode")

    --starting update
    local script_name = GetScriptName()

    --deleting current lua
    file.Delete(script_name)

    --writing new file with latest data
    file.Write(GetScriptName(), LAST_LUA_DATA)
    print("Script succesfully updated. Load it again.")
    return
end

--if lua is updated
print("Successfully loaded " .. CURRENT_VERSION .. " version.")





--region GUI
--------------------MISC----------------------
local misc_tab = gui.Tab(gui.Reference("Misc"), "misc_tab", "Misc Tab");

--_______________useful________________--
local misc_useful = gui.Groupbox(misc_tab, "Useful", 5, 10, 325, 450);

local misc_useful_ui =
{
    adaptive_autoscope = gui.Checkbox(misc_useful, "adaptive_autoscope", "Enable Adaptive Autoscope", false),
    static_arms = gui.Checkbox(misc_useful, "static_arms", "Enable Static Arms", false),
    viewmodel_in_scope = gui.Checkbox(misc_useful, "viewmodel_in_scope", "Enable Viewmodel In Scope", false),
    sniper_crosshair = gui.Checkbox(misc_useful, "sniper_crosshair", "Enable Crosshair on Snipers", false),
    disable_foot_shadows = gui.Checkbox(misc_useful, "disable_foot_shadows", "Disable Foot Shadows", false),
    console_filter = gui.Checkbox(misc_useful, "console_filter", "Enable Console Filter", false)
}

--_____________________________________--


--_______________events________________--
local misc_events = gui.Groupbox(misc_tab, "Events", 340, 10, 290, 350);

local misc_events_ui = 
{
    buy_bot = gui.Checkbox(misc_events, "buy_bot", "Enable Buy Bot", false),
    buy_bot_primary = gui.Combobox(misc_events, "buy_bot_primary", "Buy Bot Primary", "Nothing", "Autosniper", "AWP", "Scout"),
    buy_bot_secondary = gui.Combobox(misc_events, "buy_bot_secondary", "Buy Bot Secondary", "Nothing", "Heavy Pistol", "Elite", "Fast Pistol", "P250"),
    buy_bot_extra = gui.Multibox(misc_events, "Buy Bot Extra")
}

local buy_bot_extra_ui =
{
    buy_bot_extra_nades = gui.Checkbox(misc_events_ui.buy_bot_extra, "buy_bot_extra_nades", "Nades", false),
    buy_bot_extra_defuser = gui.Checkbox(misc_events_ui.buy_bot_extra, "buy_bot_extra_defuser", "Defuser", false),
    buy_bot_extra_taser = gui.Checkbox(misc_events_ui.buy_bot_extra, "buy_bot_extra_taser", "Taser", false),
    buy_bot_extra_helmet = gui.Checkbox(misc_events_ui.buy_bot_extra, "buy_bot_extra_helmet", "Helmet", false),
    buy_bot_extra_kevlar = gui.Checkbox(misc_events_ui.buy_bot_extra, "buy_bot_extra_kevlar", "Kevlar", false)
}
--_____________________________________--
----------------------------------------------
--endregion





--region HANDLERS
local constants = {}

local patterns =
{
    "%s+";
    "auto";
    "lightmachinegun";
    "submachinegun";
    "heavypistol";
}

local replacements =
{
    "";
    "a";
    "lmg";
    "smg";
    "hpistol";
}
local current_weapon_group = "shared"

local screen_width, screen_height, local_entity;

--handling often-using variables
local function handleVariables()

    --local data
    local_entity = entities.GetLocalPlayer()

    current_weapon_group = string.lower(string.gsub(gui.GetValue("rbot.hitscan.accuracy"), '"', ""))
    for i = 1, #patterns do
        current_weapon_group = string.gsub(current_weapon_group, patterns[i], replacements[i])
    end

    --screen data
    screen_width, screen_height = draw.GetScreenSize()
end
--endregion






--region USEFUL
--getting closest target
local function getClosestToCrosshair()

    local nearest_distance = math.huge                              --giant number
    local nearest_entity;

    --iterating over all player
    for _, entity in pairs(entities.FindByClass("CCSPlayer")) do

        --check entity for valid
        if entity:GetTeamNumber() ~= local_entity:GetTeamNumber() and entity ~= local_entity and entity:IsPlayer() and entity:IsAlive() then

            --getting their on screen distances
            local entity_on_screen = {client.WorldToScreen(entity:GetAbsOrigin())}
            local distance_to_entity = {vector.Distance(screen_width / 2, screen_height / 2, 0, entity_on_screen[1], entity_on_screen[2], 0)}

            --finding closest
            if distance_to_entity[1] < nearest_distance then
                nearest_distance = distance_to_entity[1]
                nearest_entity = entity
            end
        end
    end

    return nearest_entity
end


--autoscope, which basing on distance to closest to crosshair
constants.MAX_NOSCOPE_DISTANCE = 250

local function adaptiveAutoscope()

    --if distance to closest target < 250, disabling asniper autostop
    if misc_useful_ui.adaptive_autoscope:GetValue() and getClosestToCrosshair() and current_weapon_group == "asniper" then

        --target and local abs
        local local_abs = local_entity:GetAbsOrigin()
        local entity_abs = getClosestToCrosshair():GetAbsOrigin()
        
        local distance = vector.Distance(local_abs.x, local_abs.y, local_abs.z, entity_abs.x, entity_abs.y, entity_abs.z)

        gui.SetValue("rbot.accuracy.auto.shared.scopeopts.scope", distance > constants.MAX_NOSCOPE_DISTANCE)
        gui.SetValue("rbot.accuracy.auto.asniper.scopeopts.scope", distance > constants.MAX_NOSCOPE_DISTANCE)
    end
end


--installing convars for usefull features
--save convars installing
local convar_array = {}

local function setConvar(name, value)
    
    --checking for convar value is new
    if value ~= nil and (value ~= convar_array[name] or not convar_array[name]) then

        client.SetConVar(name, value, true)
        convar_array[name] = value

        --printDebugMessage(name .. " convar installed to the value: " .. value)
   end
end


local function miscUsefull()

    --viewmodel in scope
    setConvar("fov_cs_debug", misc_useful_ui.viewmodel_in_scope:GetValue() and 90 or 0)

    --sniper crosshair
    setConvar("weapon_debug_spread_show", misc_useful_ui.sniper_crosshair:GetValue() and 3 or 0)

    --disable foot shadows
    setConvar("cl_foot_contact_shadows", misc_useful_ui.disable_foot_shadows:GetValue() and 0 or 1)

    --static arms
    local static_arms_enabled = misc_useful_ui.static_arms:GetValue()

    setConvar("cl_bob_lower_amt", static_arms_enabled and 5 or 21)
    setConvar("cl_bobamt_vert", static_arms_enabled and 0.1000 or 0)
    setConvar("cl_bobamt_lat", static_arms_enabled and 0.1000 or 0)
    setConvar("cl_bobcycle", static_arms_enabled and 0.98 or 0)
    setConvar("cl_viewmodel_shift_right_amt", static_arms_enabled and 0.25000 or 0)
    setConvar("cl_viewmodel_shift_left_amt", static_arms_enabled and 0.5000 or 1)

    --console filter
    setConvar("con_filter_enable", misc_useful_ui.console_filter:GetValue() and 1 or 0)
    setConvar("con_filter_text", "Missed")

    --reseting convar array on server switch
    if not local_entity then

        convar_array = {};
    end
end
--endregion





--region EVENTS
--getting, what will bought like extra 
constants.BUY_BOT_EXTRA_COMMANDS = {"buy vesthelm", "buy vest", "buy taser", "buy defuser", "buy hegrenade", "buy molotov; buy incgrenade", "buy smokegrenade"}

local function getBuyBotExtra()
    local buy_bot_extra_array = {}

    local buy_bot_extra_states = 
    {
        buy_bot_extra_ui.buy_bot_extra_helmet:GetValue(), buy_bot_extra_ui.buy_bot_extra_kevlar:GetValue(),
        buy_bot_extra_ui.buy_bot_extra_taser:GetValue(), buy_bot_extra_ui.buy_bot_extra_defuser:GetValue(), 
        buy_bot_extra_ui.buy_bot_extra_nades:GetValue(), buy_bot_extra_ui.buy_bot_extra_nades:GetValue(), 
        buy_bot_extra_ui.buy_bot_extra_nades:GetValue()
    }

    --getting all active checkboxes and commands, which shows items to buy
    for i = 1, #buy_bot_extra_states, 1 do
        if buy_bot_extra_states[i] then
            buy_bot_extra_array[#buy_bot_extra_array + 1] = constants.BUY_BOT_EXTRA_COMMANDS[i]
        end
    end

    --returning a command of buy
    return table.concat(buy_bot_extra_array, "; ")
end


constants.BUY_BOT_PRIMARY = {"scar20; buy g3sg1", "awp", "ssg08"}
constants.BUY_BOT_SECONDARY = {"deagle; buy revolver", "elite", "tec9; buy fiveseven; buy cz75a", "p250"}

--buying selected weapons on round prestart
local function buyBot(event)

    --checking for event valid and checkbox active
    if not event or not misc_events_ui.buy_bot:GetValue() then
        return 
    end

    --buying all weapons on round prestart
    if event:GetName() == "round_prestart" then

        --primary
        if misc_events_ui.buy_bot_primary:GetValue() ~= 0 then
            client.Command("buy " .. constants.BUY_BOT_PRIMARY[misc_events_ui.buy_bot_primary:GetValue()], true)
        end

        --secondary
        if misc_events_ui.buy_bot_secondary:GetValue() ~= 0 then
            client.Command("buy " .. constants.BUY_BOT_SECONDARY[misc_events_ui.buy_bot_secondary:GetValue()], true)
        end

        --extra
        client.Command(getBuyBotExtra(), true)

        --printDebugMessage("buy bot bought all weapons")
    end
end
--endregion





--region GUI_EDIT
local function editGui()
    
    misc_events_ui.buy_bot_primary:SetDisabled(not misc_events_ui.buy_bot:GetValue())
    misc_events_ui.buy_bot_secondary:SetDisabled(not misc_events_ui.buy_bot:GetValue())
    misc_events_ui.buy_bot_extra:SetDisabled(not misc_events_ui.buy_bot:GetValue())
end

--region CALLBACKS
callbacks.Register("Draw", function()  

    --handlers
    handleVariables()

    --misc usefull
    miscUsefull()

    --edit gui
    editGui()
end)


callbacks.Register("PostMove", function()

    --misc usefull
    adaptiveAutoscope()
end)


callbacks.Register("FireGameEvent", function(event)

    --buybot
    buyBot(event)
end)


callbacks.Register("Unload", function()

    --returning caches on unload
    setConvar("fov_cs_debug", 0)
    setConvar("weapon_debug_spread_show", 0)
    setConvar("cl_foot_contact_shadows", 1)

    setConvar("cl_bob_lower_amt", 21)
    setConvar("cl_bobamt_vert", 0)
    setConvar("cl_bobamt_lat", 0)
    setConvar("cl_bobcycle", 0)
    setConvar("cl_viewmodel_shift_right_amt", 0)
    setConvar("cl_viewmodel_shift_left_amt", 1)
    setConvar("con_filter_enable", 0)
    setConvar("con_filter_text", "Missed")
end)
--endregion






--@region ALLOW_LISTENERS
client.AllowListener("round_prestart")
--@endregion
