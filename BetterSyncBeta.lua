---
--- Title: BetterSync™
--- Author: superyu'#7167, special thanks to april#0001, gowork88#1556 and Shady#0001
--- Description: BetterSync is a lua Extention for Aimware, it's purpose is to add more configuration to the Anti-Aimbot, it heavily focuses on the desync part.
---

--- Auto updater Variables
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/BetterSync.lua";
local BETA_SCIPT_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/BetterSyncBeta.lua"
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/superyor/BetterSync/master/version.txt"; --- in case of update i need to update this. (Note by superyu'#7167 "so i don't forget it.")#
local VERSION_NUMBER = "3.6.1"; --- This too
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local betaUpdateDownloaded = false;
local isBeta = true;

--- Auto Updater GUI Stuff
local BETTERSYNC_UPDATER_TAB = gui.Tab(gui.Reference("Settings"), "bettersync.updater.tab", "BetterSync™ Autoupdater")
local BETTERSYNC_UPDATER_GROUP = gui.Groupbox(BETTERSYNC_UPDATER_TAB, "Auto Updater for BetterSync™ | v" .. VERSION_NUMBER, 15, 15, 600, 600)
local BETTERSYNC_UPDATER_TEXT = gui.Text(BETTERSYNC_UPDATER_GROUP, "")

local function betaUpdate()

    if isBeta then
        return;
    end

    if betaUpdateDownloaded then
        return;
    end

    local beta_version_content = http.Get(BETA_SCIPT_FILE_ADDR);
    local old_script = file.Open(SCRIPT_FILE_NAME, "w");
    old_script:Write(beta_version_content);
    old_script:Close();
    betaUpdateDownloaded = true;
    BETTERSYNC_UPDATER_TEXT:SetText("Downloaded the Beta Client! Please reload the script.")
end

local BETTERSYNC_UPDATER_BETABUTTON = gui.Button(BETTERSYNC_UPDATER_GROUP, "Download Beta Client", betaUpdate)
local BETTERSYNC_CHANGELOG_CONTENT = http.Get("https://raw.githubusercontent.com/superyor/BetterSync/master/changelog.txt")
if BETTERSYNC_CHANGELOG_CONTENT ~= nil or BETTERSYNC_CHANGELOG_CONTENT ~= "" then
    local BETTERSYNC_CHANGELOG_TEXT = gui.Text(BETTERSYNC_UPDATER_GROUP, BETTERSYNC_CHANGELOG_CONTENT)
end

--- BetterSync Tab
local BETTERSYNC_TAB = gui.Tab(gui.Reference("Ragebot"), "bettersync.tab", "BetterSync")
local BETTERSYNC_DESYNC_GROUP = gui.Groupbox(gui.Reference("Ragebot", "BetterSync"), "Desync", 15, 15, 240, 325);
local BETTERSYNC_MISC_GROUP = gui.Groupbox(gui.Reference("Ragebot", "BetterSync"), "Misc", 15, 30+(325/1.5)+15+68+15, 240, 100)
local BETTERSYNC_SWAY_ROTATION_GROUP = gui.Groupbox(gui.Reference("Ragebot", "BetterSync"), "Rotation Sway", 255+15, 15, 350, 500);
local BETTERSYNC_SWAY_LBY_GROUP = gui.Groupbox(gui.Reference("Ragebot", "BetterSync"), "LBY Sway", 255+15, 15+310, 350, 500);

--- Desync GUI Stuff
local BETTERSYNC_ENABLE = gui.Checkbox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.enabled", "Enabled", false)
local BETTERSYNC_LBY_MODE = gui.Combobox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.lby.mode", "LBY Mode", "Off", "Match", "Invert", "180", "Sway")
local BETTERSYNC_LBY_FACTOR = gui.Slider(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.lby.factor", "LBY Factor", 1, 1, 3)
local BETTERSYNC_LBY_FACTOR_TEXT = gui.Text(BETTERSYNC_DESYNC_GROUP, "")
local BETTERSYNC_ANTILBY  = gui.Checkbox(BETTERSYNC_DESYNC_GROUP, "rbot.bettersync.antilby", "Anti-LBY", 0);

--- Misc GUI Stuff
local SUYUCORE = gui.Checkbox(BETTERSYNC_MISC_GROUP, "rbot.bettersync.betafeatures.suyucore", "Betafeature - Suyucore", false)
local BETTERSYNC_JUMPSCOUT = gui.Checkbox(BETTERSYNC_MISC_GROUP, "rbot.bettersync.misc.jumpscout", "Fix Jumpscout", 0)
local BETTERSYNC_PULSEFAKE = gui.Checkbox(BETTERSYNC_MISC_GROUP, "rbot.bettersync.misc.pulsefake", "Pulsating Fake Chams", 0);
local BETTERSYNC_CREDITS = gui.Text(BETTERSYNC_MISC_GROUP, "Made with love by superyu'#7167.         Thanks to everyone that supports me!    Shoutouts to Shady and Cheeseot!")

---Sway GUI Stuff
local BETTERSYNC_SWAY_ROTATION_SPEED = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.speed", "Speed", 3, 1, 15);
local BETTERSYNC_SWAY_ROTATION_RANGE1 = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.rangestart", "Range Start", -58, -58, 58);
local BETTERSYNC_SWAY_ROTATION_RANGE2 = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.rangeend", "Range End", 58, -58, 58);
local BETTERSYNC_SWAY_ROTATION_DEADZONE = gui.Slider(BETTERSYNC_SWAY_ROTATION_GROUP, "rbot.bettersync.sway.rotation.deadzone", "Deadzone", 30, 0, 58);

---Sway GUI Stuff
local BETTERSYNC_SWAY_LBY_SPEED = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.speed", "Speed", 3, 1, 15);
local BETTERSYNC_SWAY_LBY_RANGE1 = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.rangestart", "Range Start", -180, -180, 180);
local BETTERSYNC_SWAY_LBY_RANGE2 = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.rangeend", "Range End", 180, -180, 180);
local BETTERSYNC_SWAY_LBY_DEADZONE = gui.Slider(BETTERSYNC_SWAY_LBY_GROUP, "rbot.bettersync.sway.lby.deadzone", "Deadzone", 90, 0, 180);

--- Descriptions
BETTERSYNC_ENABLE:SetDescription("Enables BetterSync.")
BETTERSYNC_LBY_MODE:SetDescription("The kind of LBY you want to have.")
BETTERSYNC_LBY_FACTOR:SetDescription("The strength of the LBY.")
BETTERSYNC_ANTILBY:SetDescription("Tries to make your LBY update constantly.")
BETTERSYNC_JUMPSCOUT:SetDescription("Turns off autostrafer while standing.")
BETTERSYNC_PULSEFAKE:SetDescription("Makes your fake ghost pulsate.")
BETTERSYNC_SWAY_ROTATION_SPEED:SetDescription("Speed of the sway.")
BETTERSYNC_SWAY_ROTATION_RANGE1:SetDescription("Range start of the sway.")
BETTERSYNC_SWAY_ROTATION_RANGE2:SetDescription("Range end of the sway.")
BETTERSYNC_SWAY_ROTATION_DEADZONE:SetDescription("Deadzone of the sway.")
BETTERSYNC_SWAY_LBY_SPEED:SetDescription("Speed of the sway.")
BETTERSYNC_SWAY_LBY_RANGE1:SetDescription("Range start of the sway.")
BETTERSYNC_SWAY_LBY_RANGE2:SetDescription("Range end of the sway.")
BETTERSYNC_SWAY_LBY_DEADZONE:SetDescription("Deadzone of the sway.")
SUYUCORE:SetDescription("Enables Suyucore, an implementation of lagsync.")

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
local suyuSwitch = false;

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

local function handleDesync()

    local val = 0;
    local lby = 0;

    if globals.TickCount() > lastTick then

        suyuSwitch = not suyuSwitch;

        if BETTERSYNC_ENABLE:GetValue() and not SUYUCORE:GetValue() then
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


        if BETTERSYNC_LBY_MODE:GetValue() == 4 and not SUYUCORE:GetValue() then
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

        if BETTERSYNC_LBY_MODE:GetValue() > 0 and BETTERSYNC_LBY_MODE:GetValue() ~= 4 and not SUYUCORE:GetValue() then

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

        if not inFreezeTime and BETTERSYNC_ENABLE:GetValue() and not SUYUCORE:GetValue() then
            gui.SetValue("rbot.antiaim.base.rotation", val)
            gui.SetValue("rbot.antiaim.left.rotation", val)
            gui.SetValue("rbot.antiaim.right.rotation", val)
        end

        if SUYUCORE:GetValue() then

            local rotation = 0;
            local yaw = 180;

            if suyuSwitch then
                rotation = -58
                yaw = 170
            else
                rotation = -50
                yaw = -170
            end

            gui.SetValue("rbot.antiaim.base.rotation", rotation)
            gui.SetValue("rbot.antiaim.left.rotation", rotation)
            gui.SetValue("rbot.antiaim.right.rotation", rotation)
            gui.SetValue("rbot.antiaim.base", yaw)
            gui.SetValue("rbot.antiaim.left", yaw-45)
            gui.SetValue("rbot.antiaim.right", yaw+45)
            gui.SetValue("rbot.antiaim.base.lby", (rotation * -1) * 0.85)
            gui.SetValue("rbot.antiaim.left.lby", (rotation * -1) * 0.85)
            gui.SetValue("rbot.antiaim.right.lby", (rotation * -1) * 0.85)
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
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
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
                BETTERSYNC_UPDATER_TEXT:SetText("Your client is up to date. Current Version: v" .. VERSION_NUMBER .. " Stable Build")
            end
        end
    end
end

callbacks.Register("Draw", handleUpdates)