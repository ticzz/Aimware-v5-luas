---
--- Title: BetterSync™
--- Author: superyu'#7167, special thanks to april#0001, gowork88#1556 and Shady#0001
--- Description: BetterSync is a lua Extention for Aimware, it's purpose is to add more configuration to the Anti-Aimbot, it heavily focuses on the desync part.
---


------------------------- groupbox hide/show shit

local GO_panels_info = {}

local oldGroupBox = gui.Groupbox
function gui.Groupbox( parent, name, x, y, w, h )
    local groupbox = oldGroupBox(parent, name, x, y, w, h)
    table.insert(GO_panels_info, {
                                panel = groupbox,
                                hide = false,
                                x = x,
                                y = y,
                                w = w,
                                h = h,
                                name = name
                                })
    return groupbox
end

function _get_panel_index(panel)
    for i=1 , #GO_panels_info do
        if GO_panels_info[i].panel == panel then
            return i, panel
        end
    end
end

function hide(GO_panel)
    local index, panel = _get_panel_index(GO_panel)
    if panel then
        GO_panels_info[index].hide = true
    end
end

function show(GO_panel)
    local index, panel = _get_panel_index(GO_panel)
    if panel then
        GO_panels_info[index].hide = false
    end
end



callbacks.Register("Draw", function()
    for k, GO_panel in pairs(GO_panels_info) do
        if GO_panel.hide then
            GO_panel.panel:SetPosY(-99999)
        else
            GO_panel.panel:SetPosX(GO_panel.x)
            GO_panel.panel:SetPosY(GO_panel.y)
            GO_panel.panel:SetWidth(GO_panel.w)
            GO_panel.panel:SetHeight(GO_panel.h)
        end
    end
end)




-------------------




--- Auto updater Variables
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/BetterSync.lua";
local BETA_SCIPT_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/BetterSyncBeta.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/version.txt"; --- in case of update i need to update this. (Note by superyu'#7167 "so i don't forget it.")#
local VERSION_NUMBER = "1337"; --- This too
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local betaUpdateDownloaded = false;
local isBeta = false;

local function betaUpdate()

    if isBeta then
        return;
    end

    if betaUpdateDownloaded then
        return;
    end

    local beta_version_content = http.Get(BETA_SCIPT_FILE_ADDR);
    -- local old_script = file.Open(SCRIPT_FILE_NAME, "w");
    -- old_script:Write(beta_version_content);
    -- old_script:Close();
    betaUpdateDownloaded = true;
    BETTERSYNC_UPDATER_TEXT:SetText("Downloaded the Beta Client! Please reload the script.")
end

--- Auto Updater GUI Stuff
local BETTERSYNC_SHOW = gui.Checkbox(gui.Reference("Ragebot", "Anti-Aim", "Advanced"), "rbot.bettersync.showmenu", "BetterSync", 1)


local BETTERSYNC_UPDATER_TAB = gui.Tab(gui.Reference("Settings"), "bettersync.updater.tab", "BetterSync™ Autoupdater")
local BETTERSYNC_UPDATER_GROUP = gui.Groupbox(BETTERSYNC_UPDATER_TAB, "Auto Updater for BetterSync™ | v" .. VERSION_NUMBER, 15, 15, 600, 600)
local BETTERSYNC_UPDATER_TEXT = gui.Text(BETTERSYNC_UPDATER_GROUP, "")
local BETTERSYNC_UPDATER_BETABUTTON = gui.Button(BETTERSYNC_UPDATER_GROUP, "Download Beta Client", betaUpdate)

--- BetterSync WINDOW
local BETTERSYNC_WINDOW = gui.Window("rbot.bettersync.window", "BetterSync " .. VERSION_NUMBER, 200, 200, 650,800)
local BETTERSYNC_DESYNC_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "Desync", 15, 15, 255, 325);
local BETTERSYNC_MISC_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "Misc", 15, 30+(325/2)+15+70, 255, 100)
local BETTERSYNC_SWAY_ROTATION_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "Rotation Sway", 255+25, 15, 350, 500);
local BETTERSYNC_SWAY_LBY_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "LBY Sway", 255+25, 15+250, 350, 500);

--------------BASE DIRECTION SHIT
local BETTERSYNC_BASE_DIRECTION_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "Jitter Base Direction", 255+25, 15+500, 350, 500);
local BETTERSYNC_BASE_DIRECTION_BASE_YAW = gui.Slider(BETTERSYNC_BASE_DIRECTION_GROUP, "rbot.bettersync.sway.base_direction.base_yaw", "Base yaw", 180, -180, 180);
local BETTERSYNC_BASE_DIRECTION_SPEED = gui.Slider(BETTERSYNC_BASE_DIRECTION_GROUP, "rbot.bettersync.sway.base_direction.tick", "Tick speed", 3, 1, 50);
local BETTERSYNC_BASE_DIRECTION_RANGE1 = gui.Slider(BETTERSYNC_BASE_DIRECTION_GROUP, "rbot.bettersync.sway.base_direction.rangestart", "Range Start", 0, 0, 58);
local BETTERSYNC_BASE_DIRECTION_RANGE2 = gui.Slider(BETTERSYNC_BASE_DIRECTION_GROUP, "rbot.bettersync.sway.base_direction.rangeend", "Range End", 0, -58, 0);

local lastTick = 0
local switch = false
callbacks.Register("Draw", function()
    if globals.TickCount() > lastTick + gui.GetValue("rbot.bettersync.window.rbot.bettersync.sway.base_direction.tick") then
        if switch then
            local x,y,z = vector.AngleNormalize({0, BETTERSYNC_BASE_DIRECTION_BASE_YAW:GetValue() + BETTERSYNC_BASE_DIRECTION_RANGE1:GetValue(),0})
            gui.SetValue("rbot.antiaim.base", y)
        else
            local x,y,z = vector.AngleNormalize({0, BETTERSYNC_BASE_DIRECTION_BASE_YAW:GetValue() + BETTERSYNC_BASE_DIRECTION_RANGE2:GetValue() ,0})
            gui.SetValue("rbot.antiaim.base", y)
        end
        switch = not switch
        lastTick = globals.TickCount()
    end
end)





----------CONFIG SHIT

file.Open("bettersync_config.txt", "a"):Write("")


function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    
    return t
end


function get_config_names()
    local config_names = {}
    local config_file_contents = file.Open("bettersync_config.txt", "r"):Read()
    for k, line in pairs(split(config_file_contents, "\n")) do
        table.insert(config_names, split(line, " ")[1])
    end
    return config_names
end


local hide_settings = gui.Checkbox(BETTERSYNC_WINDOW, "rbot.bettersync.L.hide", "Hide settings", 0)
hide_settings:SetPosX(0)
hide_settings:SetPosY(-50)


-- Save configs

local BETTERSYNC_CONFIG_GROUP = gui.Groupbox(BETTERSYNC_WINDOW, "Config", 15, 15+480, 250, 500);---------------------------
local BETTERSYNC_CONFG_SAVEDCONFIGS = gui.Combobox(BETTERSYNC_CONFIG_GROUP, "rbot.bettersync.lby.mode", "Saved configs", "")----------

---- Import configs

local BETTERSYNC_CONFIG_IMPORT_GROUPBOX = gui.Groupbox(BETTERSYNC_WINDOW, "Import", 15, 225, 615, 325);
local BETTERSYNC_CONFIG_IMPORT_ENTRY = gui.Editbox( BETTERSYNC_CONFIG_IMPORT_GROUPBOX, "rbot.bettersync.config.import", "Config" )


local BETTERSYNC_CONFIG_IMPORT_BUTTON = gui.Button( BETTERSYNC_CONFIG_IMPORT_GROUPBOX, "Import", function()
    local input = BETTERSYNC_CONFIG_IMPORT_ENTRY:GetValue()
    local config_file = file.Open("bettersync_config.txt", "a")
    if string.match(input, "|") then -- a little verfication better then none
        config_file:Write(input .. "\n")
    end
    config_file:Close()
    reload_comboboxes()
end)
BETTERSYNC_CONFIG_IMPORT_BUTTON:SetWidth(585)


-- Export configs

local BETTERSYNC_CONFIG_EXPORT_GROUPBOX = gui.Groupbox(BETTERSYNC_WINDOW, "Export", 15, 385, 615, 325);
local BETTERSYNC_CONFG_EXPORT_CONFIGS = gui.Combobox(BETTERSYNC_CONFIG_EXPORT_GROUPBOX, "rbot.bettersync.config.export.savedcfgs", "Saved configs", "")----------
local BETTERSYNC_CONFIG_EXPORT_ENTRY = gui.Editbox( BETTERSYNC_CONFIG_EXPORT_GROUPBOX, "rbot.bettersync.config.import", "Output config" )------------------

local BETTERSYNC_CONFIG_EXPORT_BUTTON = gui.Button( BETTERSYNC_CONFIG_EXPORT_GROUPBOX, "Export", function()
    local config_names = get_config_names()
    BETTERSYNC_CONFG_EXPORT_CONFIGS:SetOptions(unpack(config_names))
    
    local config_file_contents = split(file.Open("bettersync_config.txt", "r"):Read(), "\n" )
    local config = config_file_contents[BETTERSYNC_CONFG_EXPORT_CONFIGS:GetValue() + 1]
    
    BETTERSYNC_CONFIG_EXPORT_ENTRY:SetValue(config)
    reload_comboboxes()
end)
BETTERSYNC_CONFIG_EXPORT_BUTTON:SetWidth(585)



function reload_comboboxes(custom)
    if not custom then
        local config_names = get_config_names()
        BETTERSYNC_CONFG_SAVEDCONFIGS:SetOptions(unpack(config_names))
        BETTERSYNC_CONFG_EXPORT_CONFIGS:SetOptions(unpack(config_names))
    else
        local config_names = get_config_names()
        BETTERSYNC_CONFG_SAVEDCONFIGS:SetOptions(unpack(custom))
        BETTERSYNC_CONFG_EXPORT_CONFIGS:SetOptions(unpack(config_names))
    end
end

reload_comboboxes()

local BETTERSYNC_CONFIG_EDITBOX = gui.Editbox( BETTERSYNC_CONFIG_GROUP, "rbot.bettersync.config.entry", "Config name" )------------------
local BETTERSYNC_CONFIG_LOAD = gui.Button( BETTERSYNC_CONFIG_GROUP, "Load", function()
    local config_names = get_config_names()    
    load_config(input)
end)

local BETTERSYNC_CONFIG_SAVE = gui.Button( BETTERSYNC_CONFIG_GROUP, "Save", function()
    save_current_settings()
end)

local bettersync_settings = {
        "rbot.bettersync.window.rbot.bettersync.sway.rotation.speed",
        "rbot.bettersync.window.rbot.bettersync.sway.rotation.rangestart",
        "rbot.bettersync.window.rbot.bettersync.sway.rotation.rangeend",
        "rbot.bettersync.window.rbot.bettersync.sway.rotation.deadzone",
        
        "rbot.bettersync.window.rbot.bettersync.sway.lby.speed",
        "rbot.bettersync.window.rbot.bettersync.sway.lby.rangestart",
        "rbot.bettersync.window.rbot.bettersync.sway.lby.rangeend",
        "rbot.bettersync.window.rbot.bettersync.sway.lby.deadzone",
        
        "rbot.bettersync.window.rbot.bettersync.sway.base_direction.base_yaw",
        "rbot.bettersync.window.rbot.bettersync.sway.base_direction.tick",
        "rbot.bettersync.window.rbot.bettersync.sway.base_direction.rangestart",
        "rbot.bettersync.window.rbot.bettersync.sway.base_direction.rangeend",
        
        "rbot.bettersync.window.rbot.bettersync.lby.mode",
        "rbot.bettersync.window.rbot.bettersync.antilby"

}

function save_current_settings()
    local function is_unqie(config_name)
        local config_file_contents = split(file.Open("bettersync_config.txt", "r"):Read(), "\n" )
        for k, line in pairs(config_file_contents) do
            local _config_name = split(line, " ")[1]
            if _config_name == config_file then
                return false
            end
        end
        return true
    end


    local input = BETTERSYNC_CONFIG_EDITBOX:GetValue()

    if input ~= "" and input ~= " " and is_unqie(input) then
        local config_file = file.Open("bettersync_config.txt", "a")
        local settings_string = BETTERSYNC_CONFIG_EDITBOX:GetValue() .. " "
        for k,v in pairs(bettersync_settings) do
            settings_string = settings_string .. tostring(gui.GetValue(v)) .. "|"
        end
        config_file:Write(settings_string .. "\n")
        config_file:Close()
        reload_comboboxes()
    end
    
end


function load_config(config)
    local config_file_contents = split(file.Open("bettersync_config.txt", "r"):Read(), "\n" )
    local config = split(config_file_contents[BETTERSYNC_CONFG_SAVEDCONFIGS:GetValue() + 1], " ")[2]
    local config_settings = split(config, "|")
    for i=1, #config_settings do
        gui.SetValue(bettersync_settings[i], config_settings[i])
    end
end

function should_show(b)
    if b then
        show(BETTERSYNC_DESYNC_GROUP)
        show(BETTERSYNC_MISC_GROUP)
        show(BETTERSYNC_SWAY_ROTATION_GROUP)
        show(BETTERSYNC_SWAY_LBY_GROUP)
        show(BETTERSYNC_BASE_DIRECTION_GROUP)
        
        hide(BETTERSYNC_CONFIG_IMPORT_GROUPBOX)
        hide(BETTERSYNC_CONFIG_EXPORT_GROUPBOX)

    else
        hide(BETTERSYNC_DESYNC_GROUP)
        hide(BETTERSYNC_MISC_GROUP)
        hide(BETTERSYNC_SWAY_ROTATION_GROUP)
        hide(BETTERSYNC_SWAY_LBY_GROUP)
        hide(BETTERSYNC_BASE_DIRECTION_GROUP)
        
        show(BETTERSYNC_CONFIG_IMPORT_GROUPBOX)
        show(BETTERSYNC_CONFIG_EXPORT_GROUPBOX)
        
    end
end


callbacks.Register("Draw", function()
    if hide_settings:GetValue() then
        should_show(false)
        BETTERSYNC_CONFIG_GROUP:SetPosX(15)
        BETTERSYNC_CONFIG_GROUP:SetPosY(15)
        BETTERSYNC_CONFIG_GROUP:SetWidth(620)
        
        BETTERSYNC_CONFG_SAVEDCONFIGS:SetWidth(585)
        BETTERSYNC_CONFIG_EDITBOX:SetWidth(585)
        
        local w = 285
        BETTERSYNC_CONFIG_LOAD:SetWidth(w)
        
        BETTERSYNC_CONFIG_LOAD:SetPosY(105)
        BETTERSYNC_CONFIG_LOAD:SetPosX(0)
        
        BETTERSYNC_CONFIG_SAVE:SetPosY(105)
        BETTERSYNC_CONFIG_SAVE:SetPosX(w+15)
        BETTERSYNC_CONFIG_SAVE:SetWidth(w)
        
        BETTERSYNC_CONFIG_GROUP:SetPosY(15)
    else
        should_show(true)
        BETTERSYNC_CONFIG_GROUP:SetPosX(15)
        BETTERSYNC_CONFIG_GROUP:SetWidth(250)
        
        BETTERSYNC_CONFG_SAVEDCONFIGS:SetWidth(200)
        BETTERSYNC_CONFIG_EDITBOX:SetWidth(200)
        
        local w = 100
        BETTERSYNC_CONFIG_LOAD:SetWidth(w)
        
        BETTERSYNC_CONFIG_LOAD:SetPosY(130)
        BETTERSYNC_CONFIG_LOAD:SetPosX(0)
        
        BETTERSYNC_CONFIG_SAVE:SetPosY(130)
        BETTERSYNC_CONFIG_SAVE:SetPosX(w+15)
        BETTERSYNC_CONFIG_SAVE:SetWidth(w)

    end
end)

---------------------------






--- Desync GUI Stuff
local BETTERSYNC_ENABLE = gui.Checkbox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.enabled", "Enabled", false)
local BETTERSYNC_LBY_MODE = gui.Combobox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.lby.mode", "LBY Mode", "Off", "Match", "Invert", "180", "Sway")
local BETTERSYNC_LBY_FACTOR = gui.Slider(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.lby.factor", "LBY Factor", 1, 1, 3)
local BETTERSYNC_LBY_FACTOR_TEXT = gui.Text(BETTERSYNC_DESYNC_GROUP, "")
local BETTERSYNC_ANTILBY  = gui.Checkbox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.antilby", "Anti-LBY", 0);

--- Misc GUI Stuff
local BETTERSYNC_JUMPSCOUT = gui.Checkbox(BETTERSYNC_MISC_GROUP, "rbot.bettersync.misc.jumpscout", "Fix Jumpscout", 0)
local BETTERSYNC_PULSEFAKE = gui.Checkbox(BETTERSYNC_MISC_GROUP, "rbot.bettersync.misc.pulsefake", "Pulsating Fake Chams", 0);
local BETTERSYNC_CREDITS = gui.Text(BETTERSYNC_MISC_GROUP, "Made witth love by superyu'#7167.")
local BETTERSYNC_CREDITS2 = gui.Text(BETTERSYNC_MISC_GROUP, "Thanks to everyone that supports me!")
local BETTERSYNC_CREDITS3 = gui.Text(BETTERSYNC_MISC_GROUP, "Shoutouts to Shady and Cheeseot!")

---Sway GUI Stuff
local BETTERSYNC_SWAY_ROTATION_SPEED = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.speed", "Speed", 3, 1, 150);
local BETTERSYNC_SWAY_ROTATION_RANGE1 = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.rangestart", "Range Start", -58, -58, 58);
local BETTERSYNC_SWAY_ROTATION_RANGE2 = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.rangeend", "Range End", 58, -58, 58);
local BETTERSYNC_SWAY_ROTATION_DEADZONE = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.deadzone", "Deadzone", 30, 0, 58);

---Sway GUI Stuff
local BETTERSYNC_SWAY_LBY_SPEED = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.speed", "Speed", 3, 1, 150);
local BETTERSYNC_SWAY_LBY_RANGE1 = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.rangestart", "Range Start", -180, -180, 180);
local BETTERSYNC_SWAY_LBY_RANGE2 = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.rangeend", "Range End", 180, -180, 180);
local BETTERSYNC_SWAY_LBY_DEADZONE = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.deadzone", "Deadzone", 90, 0, 180);

--- BetterSync Variables
local pLocal;
local max, min = 0, 0;
local cs, cd = 0, 0;
local cs2, cd2, s = 0, 0, 2;
local max3, min3 = 0, 0;
local cs3, cd3 = 0, 0;
local del = globals.CurTime() + 0.100
local inFreezeTime = false;
local switch = false;
local dx, dy, rx, ry = 0, 0, 0, 0
local lastTick = 0;
local lastTickPulse = 0

--- Listeners
client.AllowListener("round_freeze_end")
client.AllowListener("round_start")
--- Helpers
local function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function handlePulse()

    if (BETTERSYNC_PULSEFAKE:GetValue()) then

        if globals.TickCount() > lastTickPulse then

            if (cs2 >= 125) then
                cd2 = 1;
            elseif (cs2 <= 0 + s) then
                cd2 = 0;
            end

            if (cd2 == 0) then
                cs2 = cs2 + s;
            elseif (cd2 == 1) then
                cs2 = cs2 - s;
            end

            if cs2 < 0 then cs2 = 0 end
            local r, g, b, a = gui.GetValue("esp.chams.ghost.visible.clr");
            gui.SetValue("esp.chams.ghost.visible.clr", r, g, b, cs2);
            lastTickPulse = globals.TickCount()
        end
    end
end


local function GetDesync()
    local VelocityX = entities.GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[0]")
    local VelocityY = entities.GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[1]")
    local VelocityZ = entities.GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[2]")
    local fl_speed = math.sqrt(VelocityX ^ 2 + VelocityY ^ 2)
    local maxdesync = (59 - 58 * fl_speed / 580)
    return maxdesync
end


local function handleDesync()

    local val = gui.GetValue("rbot.antiaim.base.rotation");
    
    
    
    if globals.TickCount() > lastTick then

        if BETTERSYNC_ENABLE:GetValue() then
            local speed = BETTERSYNC_SWAY_ROTATION_SPEED:GetValue() / 3

            if BETTERSYNC_SWAY_ROTATION_RANGE1:GetValue() < BETTERSYNC_SWAY_ROTATION_RANGE2:GetValue() then
                min = BETTERSYNC_SWAY_ROTATION_RANGE1:GetValue()
                max = BETTERSYNC_SWAY_ROTATION_RANGE2:GetValue()
            else
                min = BETTERSYNC_SWAY_ROTATION_RANGE2:GetValue()
                max = BETTERSYNC_SWAY_ROTATION_RANGE1:GetValue()
            end
            
        

            if (cs >= max) then
                cd = 1;
            elseif (cs <= min + speed) then
                cd = 0;
            end
        
            if (cd == 0) then
                cs = cs + speed;
            elseif (cd == 1) then
                cs = cs - speed;
            end

            local deadzoneP = BETTERSYNC_SWAY_ROTATION_DEADZONE:GetValue()
            local deadzoneN = deadzoneP * -1

            if cs > 0 then
                if cs < deadzoneP then
                    cs = deadzoneN
                end
            end

            if cs < 0 then
                if cs > deadzoneN then
                    cs = deadzoneP
                end
            end
            val = cs;
        end


        if BETTERSYNC_LBY_MODE:GetValue() == 4 then
            local speed2 = BETTERSYNC_SWAY_LBY_SPEED:GetValue() / 3

            if BETTERSYNC_SWAY_LBY_RANGE1:GetValue() < BETTERSYNC_SWAY_LBY_RANGE2:GetValue() then
                min3 = BETTERSYNC_SWAY_LBY_RANGE1:GetValue()
                max3 = BETTERSYNC_SWAY_LBY_RANGE2:GetValue()
            else
                min3 = BETTERSYNC_SWAY_LBY_RANGE2:GetValue()
                max3 = BETTERSYNC_SWAY_LBY_RANGE1:GetValue()
            end

            if (cs3 >= max3) then
                cd3 = 1;
            elseif (cs3 <= min3 + speed2) then
                cd3 = 0;
            end
        
            if (cd3 == 0) then
                cs3 = cs3 + speed2;
            elseif (cd3 == 1) then
                cs3 = cs3 - speed2;
            end

            local deadzoneP = BETTERSYNC_SWAY_LBY_DEADZONE:GetValue()
            local deadzoneN = deadzoneP * -1

            if cs3 > 0 then
                if cs3 < deadzoneP then
                    cs3 = deadzoneN
                end
            end

            if cs3 < 0 then
                if cs3 > deadzoneN then
                    cs3 = deadzoneP
                end
            end

            gui.SetValue("rbot.antiaim.base.lby", cs3)
            gui.SetValue("rbot.antiaim.left.lby", cs3)
            gui.SetValue("rbot.antiaim.right.lby", cs3)
        end

        local lby = 0

        if BETTERSYNC_LBY_MODE:GetValue() > 0 and BETTERSYNC_LBY_MODE:GetValue() ~= 4 then

            if BETTERSYNC_LBY_MODE:GetValue() == 1 then

                if BETTERSYNC_LBY_FACTOR:GetValue() == 1 then
                    lby = val;
                elseif BETTERSYNC_LBY_FACTOR:GetValue() == 2 then
                    if val > 0 then
                        lby = 58;
                    else
                        lby = -58
                    end
                else
                    if val > 0 then
                        lby = 120;
                    else
                        lby = -120;
                    end
                end

            elseif BETTERSYNC_LBY_MODE:GetValue() == 2 then

                if BETTERSYNC_LBY_FACTOR:GetValue() == 1 then
                    lby = val * -1;
                elseif BETTERSYNC_LBY_FACTOR:GetValue() == 2 then
                    if val > 0 then
                        lby = -58;
                    else
                        lby = 58
                    end
                else
                    if val > 0 then
                        lby = -120;
                    else
                        lby = 120;
                    end
                end

            else
                lby = 180
            end

            gui.SetValue("rbot.antiaim.base.lby", lby)
            gui.SetValue("rbot.antiaim.left.lby", lby)
            gui.SetValue("rbot.antiaim.right.lby", lby)
        end

        if not inFreezeTime and BETTERSYNC_ENABLE:GetValue() then -- not SUYUCORE:GetValue() throws error, guessing it's another lua, but the SUYUCORE is a local variable
            gui.SetValue("rbot.antiaim.base.rotation", val)
            gui.SetValue("rbot.antiaim.left.rotation", val)
            gui.SetValue("rbot.antiaim.right.rotation", val)
        end

        lastTick = globals.TickCount()
    end
end

local function handleVelocity()

    if not pLocal then
        return
    end

    local vel = math.sqrt(pLocal:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + pLocal:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)

    if BETTERSYNC_JUMPSCOUT:GetValue() then
        if vel > 5 then
            gui.SetValue("misc.strafe.enable", 1)
        else
            gui.SetValue("misc.strafe.enable", 0)
        end
    end

    if del < globals.CurTime() then
        switch = not switch
        del = globals.CurTime() + 0.050
    end

    if vel > 3 then
        del = globals.CurTime() + 0.050
    end

end

local function handleText()
    if BETTERSYNC_LBY_FACTOR:GetValue() == 1 then
        BETTERSYNC_LBY_FACTOR_TEXT:SetText("Current Factor: Default")
    elseif BETTERSYNC_LBY_FACTOR:GetValue() == 2 then
        BETTERSYNC_LBY_FACTOR_TEXT:SetText("Current Factor: Strong")
    else BETTERSYNC_LBY_FACTOR:GetValue()
        BETTERSYNC_LBY_FACTOR_TEXT:SetText("Current Factor: Stronger")
    end
end

--- Hooks
local menuPressed = 1
local function drawHook()
    pLocal = entities.GetLocalPlayer()
    
    handleText()
    handlePulse()
    handleVelocity()
    handleDesync()
        
    if engine.GetMapName() == "" then
        lastTickPulse = 0;
        lastTick = 0;
    end
    if input.IsButtonPressed(45) then
        menuPressed = menuPressed == 0 and 1 or 0;
    end
    -- print(menuPressed)
    if BETTERSYNC_SHOW:GetValue() and menuPressed == 1 then -- Have to check for value == 1 ??
        BETTERSYNC_WINDOW:SetActive(1)
    else
        BETTERSYNC_WINDOW:SetActive(0)
    end
end

local function CreateMoveHook(pCmd)
    
    if not pLocal then
        return
    end

    local vel = math.sqrt(pLocal:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + pLocal:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)

    if vel > 3 then
        return
    end

    if BETTERSYNC_ANTILBY:GetValue() then
        if switch then
            pCmd.sidemove = 2
        else
            pCmd.sidemove = -2
        end
    end
end

local function EventHook(event)
    if event:GetName() == "round_freeze_end" then
        inFreezeTime = false;
    end

    if event:GetName() == "round_start" then
        inFreezeTime = true;
    end
end

--- Callbacks
callbacks.Register( "Draw", drawHook);
callbacks.Register( "CreateMove", CreateMoveHook)
callbacks.Register("FireGameEvent", EventHook)

--- Auto updater by ShadyRetard/Shady#0001
local function handleUpdates()

    if (update_available and not update_downloaded) then
        BETTERSYNC_UPDATER_TEXT:SetText("Update is getting downloaded.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        -- local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        -- old_script:Write(new_version_content);
        -- old_script:Close();
        update_available = false;
        update_downloaded = true;
    end

    if (update_downloaded) then
        BETTERSYNC_UPDATER_TEXT:SetText("Update available, please reload the script.")
        return;
    end

    if (not version_check_done) then
        version_check_done = true;
        local version = http.Get(VERSION_FILE_ADDR);
        if (version ~= VERSION_NUMBER) then
            update_available = true;
        end
        if not betaUpdateDownloaded then
            if isBeta then
                BETTERSYNC_UPDATER_TEXT:SetText("You are using the newest Beta client. Current Version: v" .. VERSION_NUMBER .. " Beta Build")
            else
                BETTERSYNC_UPDATER_TEXT:SetText("Your client is up to date. Current Version: v" .. VERSION_NUMBER)
            end
        end
    end
end

callbacks.Register("Draw", handleUpdates)