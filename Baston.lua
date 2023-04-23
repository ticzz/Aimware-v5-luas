---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: undefined-global


local function getusername()
    return string.lower(cheat.GetUserName())
end

local ref = gui.Reference("SETTINGS")
local tab = gui.Tab(ref, "bastonlua", "Baston Lua")

local aagroupbox     = gui.Groupbox(tab, "Anti Aim", 16, 16, 287.5, 50);
local aimbotgroupbox = gui.Groupbox(tab, "Aimbot", 16.5, 260, 287.5, 100);
local othergroupbox  = gui.Groupbox(tab, "Other", 16.5, 485, 287.5, 100);
local visualbox      = gui.Groupbox(tab, "Visuals", 319.5, 16, 287.5, 100);
local fogbox         = gui.Groupbox(tab, "Fog", 319.5, 290, 287.5, 100);
local thanksbox      = gui.Groupbox(tab, "Baston Lua", 319.5, 480, 287.5, 100);

local antiaimref      = gui.Checkbox(aagroupbox, "legitaa", "Legit AA", false)
local jitterref       = gui.Checkbox(aagroupbox, "jitterslowwalk", "Jitter on Slowwalking", false)
local freestandingref = gui.Checkbox(aagroupbox, "freestanding", "Freestanding", false)
local inverter        = gui.Checkbox(aagroupbox, "inverter", "Inverter", false)
local rollref         = gui.Checkbox(aagroupbox, "roll", "Roll AA (VAC)", false)

local legfuckerref       = gui.Checkbox(visualbox, "legfucker", "Leg Fucker", false)
local snipercrosshairref = gui.Checkbox(visualbox, "snipercrosshair", "Sniper Crosshair", false)
local viewmodelxref      = gui.Slider(visualbox, "viewmodelx", "Viewmodel Changer X", 0, -40, 40, 0.1)
local viewmodelyref      = gui.Slider(visualbox, "viewmodely", "Viewmodel Changer Y", 0, -40, 40, 0.1)
local viewmodelzref      = gui.Slider(visualbox, "viewmodelz", "Viewmodel Changer Z", 0, -40, 40, 0.1)

local fogcolorref    = gui.ColorPicker(fogbox, "fogcolor", "Fog Color", 255, 255, 255, 255)
local fogdistanceref = gui.Slider(fogbox, "fogdistance", "Fog Distance", 0, 0, 9999)
local fogdensityref  = gui.Slider(fogbox, "fogdensity", "Fog Density", 0, 0, 100)

local autodisconectref = gui.Checkbox(othergroupbox, "autodisconect", "Auto Disconect", false)
local indicatorsref    = gui.Checkbox(othergroupbox, "indicators", "Indicators", false)
local aspectratioref   = gui.Slider(othergroupbox, "aspectratio", "Aspect Ratio", 0, 0, 60)

local autowallref      = gui.Checkbox(aimbotgroupbox, "autowall", "Auto Wall Global", false)
local dynamicfovref    = gui.Checkbox(aimbotgroupbox, "dynamicfov", "Dynamic Fov", false)
local dynamicfovminref = gui.Slider(aimbotgroupbox, "dynamicfovmin", "Dynamic Fov Min", 0, 0, 180)
local dynamicfovmaxref = gui.Slider(aimbotgroupbox, "dynamicfovmax", "Dynamic Fov Max", 0, 0, 180)

gui.Text(thanksbox, "hi " .. getusername())
gui.Text(thanksbox, "you are using the version 1.0 of baston.lua")
gui.Text(thanksbox, "youtube.com/c/bastontheking")
gui.Text(thanksbox, "https://discord.gg/GDdfvgHwHn")


gui.Button(othergroupbox, "Menu Dark Theme", function()
    gui.SetValue("theme.footer.bg", 30, 30, 30, 255)
    gui.SetValue("theme.footer.text", 255, 255, 255, 255)
    gui.SetValue("theme.header.bg", 42, 42, 42, 255)
    gui.SetValue("theme.header.line", 30, 30, 30, 255)
    gui.SetValue("theme.header.text", 255, 255, 255, 255)
    gui.SetValue("theme.nav.active", 30, 30, 30, 255)
    gui.SetValue("theme.nav.bg", 64, 64, 64, 255)
    gui.SetValue("theme.nav.shadow", 0, 0, 0, 127)
    gui.SetValue("theme.nav.text", 255, 255, 255, 255)
    gui.SetValue("theme.tablist.shadow", 0, 0, 0, 127)
    gui.SetValue("theme.tablist.tabactivebg", 50, 50, 50, 255)
    gui.SetValue("theme.tablist.tabdecorator", 255, 255, 255, 255)
    gui.SetValue("theme.tablist.text", 255, 255, 255, 255)
    gui.SetValue("theme.tablist.textactive", 255, 255, 255, 255)
    gui.SetValue("theme.ui.bg1", 20, 20, 20, 220)
    gui.SetValue("theme.ui.bg2", 255, 255, 255, 100)
    gui.SetValue("theme.ui.border", 255, 255, 255, 50)
end)

-- AA
local function antiaim(UserCmd)
    -- Legit AA
    if antiaimref:GetValue() then
        if rollref:GetValue() then
            gui.SetValue("misc.antiuntrusted", 0)
            if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then
                return
            end
            local lp = entities.GetLocalPlayer()
            local velocity = lp:GetPropVector("localdata", "m_vecVelocity[0]"):Length()
            local localFlags = lp:GetPropInt("m_fFlags")
            local inAir = (localFlags == 256)
            if velocity < 5 and not inAir then
                if gui.GetValue('rbot.antiaim.base.rotation') < 0 then
                    UserCmd.viewangles = EulerAngles(UserCmd.viewangles.x, UserCmd.viewangles.y, (-90))
                elseif gui.GetValue('rbot.antiaim.base.rotation') >= 0 then
                    UserCmd.viewangles = EulerAngles(UserCmd.viewangles.x, UserCmd.viewangles.y, (90))
                end
            end
            if gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 then
                if input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) and velocity > 72 then
                    if gui.GetValue('rbot.antiaim.base.rotation') < 0 then
                        UserCmd.viewangles = EulerAngles(UserCmd.viewangles.x, UserCmd.viewangles.y, (-50))
                    elseif gui.GetValue('rbot.antiaim.base.rotation') >= 0 then
                        UserCmd.viewangles = EulerAngles(UserCmd.viewangles.x, UserCmd.viewangles.y, (50))
                    end
                end
            end
        else
            gui.SetValue("misc.antiuntrusted", 1)
        end

        if jitterref:GetValue() then
            local slowwalkKey = gui.GetValue("rbot.accuracy.movement.slowkey")
            local isSlowwalking = slowwalkKey > 0 and input.IsButtonDown(slowwalkKey)
            if isSlowwalking then
                if globals.TickCount() % 8 == 0 then
                    if inverter:GetValue() then
                        inverter:SetValue(false)
                    else
                        inverter:SetValue(true)
                    end
                end
            end
        end
        if inverter:GetValue() then
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 45)
            gui.SetValue("rbot.antiaim.base.lby", -100)
            gui.SetValue("rbot.antiaim.advanced.pitch", "0")
        else
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.rotation", -45)
            gui.SetValue("rbot.antiaim.base.lby", 100)
            gui.SetValue("rbot.antiaim.advanced.pitch", "0")
        end
        if freestandingref:GetValue() then
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", true)
            gui.SetValue("rbot.antiaim.left", 100)
            gui.SetValue("rbot.antiaim.left.rotation", 45)
            gui.SetValue("rbot.antiaim.left.lby", -100)
            gui.SetValue("rbot.antiaim.right", -100)
            gui.SetValue("rbot.antiaim.right.rotation", 45)
            gui.SetValue("rbot.antiaim.right.lby", -100)
        else
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", false)
        end
    end
end

-- AA

-- LEG FUCKER
local function legfucker(UserCmd)
    if legfuckerref:GetValue() then
        local lp = entities.GetLocalPlayer()
        lp:SetPropInt(1, "m_flPoseParameter")
        if globals.TickCount() % 2 == 0 then
            gui.SetValue("misc.slidewalk", false)
        end
        if globals.TickCount() % 4 == 0 then
            gui.SetValue("misc.slidewalk", true)
        end
    end
end

-- LEG FUCKER

-- VIEWMODEL
local function viewmodel(UserCmd)
    if viewmodel_x_cache ~= viewmodelxref:GetValue() then
        client.SetConVar("viewmodel_offset_x", viewmodelxref:GetValue(), true)
    end
    if viewmodel_y_cache ~= viewmodelyref:GetValue() then
        client.SetConVar("viewmodel_offset_y", viewmodelyref:GetValue(), true)
    end
    if viewmodel_z_cache ~= viewmodelzref:GetValue() then
        client.SetConVar("viewmodel_offset_z", viewmodelzref:GetValue(), true)
    end
end

-- VIEWMODEL

-- AW
local function autowall(UserCmd)
    if autowallref:GetValue() then
        gui.SetValue("rbot.hitscan.mode.zeus.autowall", true)
        gui.SetValue("rbot.hitscan.mode.sniper.autowall", true)
        gui.SetValue("rbot.hitscan.mode.smg.autowall", true)
        gui.SetValue("rbot.hitscan.mode.shotgun.autowall", true)
        gui.SetValue("rbot.hitscan.mode.scout.autowall", true)
        gui.SetValue("rbot.hitscan.mode.rifle.autowall", true)
        gui.SetValue("rbot.hitscan.mode.pistol.autowall", true)
        gui.SetValue("rbot.hitscan.mode.lmg.autowall", true)
        gui.SetValue("rbot.hitscan.mode.hpistol.autowall", true)
        gui.SetValue("rbot.hitscan.mode.asniper.autowall", true)
    else
        gui.SetValue("rbot.hitscan.mode.zeus.autowall", false)
        gui.SetValue("rbot.hitscan.mode.sniper.autowall", false)
        gui.SetValue("rbot.hitscan.mode.smg.autowall", false)
        gui.SetValue("rbot.hitscan.mode.shotgun.autowall", false)
        gui.SetValue("rbot.hitscan.mode.scout.autowall", false)
        gui.SetValue("rbot.hitscan.mode.rifle.autowall", false)
        gui.SetValue("rbot.hitscan.mode.pistol.autowall", false)
        gui.SetValue("rbot.hitscan.mode.lmg.autowall", false)
        gui.SetValue("rbot.hitscan.mode.hpistol.autowall", false)
        gui.SetValue("rbot.hitscan.mode.asniper.autowall", false)
    end
end

-- AW

-- INDICATORS
local weapon_list = {
    [1] = "hpistol",
    [2] = "pistol",
    [3] = "pistol",
    [4] = "pistol",
    [7] = "rifle",
    [8] = "rifle",
    [9] = "sniper",
    [10] = "rifle",
    [11] = "asniper",
    [13] = "rifle",
    [14] = "lmg",
    [16] = "rifle",
    [17] = "smg",
    [19] = "smg",
    [23] = "smg",
    [24] = "smg",
    [25] = "shotgun",
    [26] = "smg",
    [27] = "shotgun",
    [28] = "lmg",
    [29] = "shotgun",
    [30] = "pistol",
    [32] = "pistol",
    [33] = "smg",
    [34] = "smg",
    [35] = "shotgun",
    [36] = "pistol",
    [38] = "asniper",
    [39] = "rifle",
    [40] = "scout",
    [60] = "rifle",
    [61] = "pistol",
    [63] = "pistol",
    [64] = "hpistol"
}

local function isWeapon()
    local lp = entities.GetLocalPlayer()
    if lp:GetWeaponType() == 0 then
        return false
    elseif lp:GetWeaponType() == 9 then
        return false
    elseif lp:GetWeaponType() == 7 then
        return false
    elseif lp:GetWeaponType() == 11 then
        return false
    elseif lp:GetWeaponType() == nil then
        return false
    else
        return true
    end
end

local font = draw.CreateFont("Calibri Bold", 18)
local function indicators()
    draw.SetFont(font)
    local w, h = draw.GetScreenSize()
    local mindmg
    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
        local lp_gwid = lp:GetWeaponID()
        if isWeapon() then
            mindmg = gui.GetValue("rbot.hitscan.accuracy." .. weapon_list[lp_gwid] .. ".mindamage")
        end
    end

    local fakeduckkey = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")

    if indicatorsref:GetValue() then
        if lp ~= nil then
            if lp:IsAlive() then
                local dist = 20
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(w / 2 - draw.GetTextSize("baston　　") / 2, h / 2 + dist,
                    "baston　　")
                if globals.TickCount() % 20 <= 10 then
                    draw.Color(176, 245, 66, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("baston　　") / 2, h / 2 + dist,
                        "baston　　")
                    draw.Color(255, 255, 255, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("　　　　　lua") / 2, h / 2 + dist,
                        "　　　　　lua")
                    dist = dist + 20
                else
                    draw.Color(255, 255, 255, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("baston　　") / 2, h / 2 + dist,
                        "baston　　")
                    draw.Color(176, 245, 66, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("　　　　　lua") / 2, h / 2 + dist,
                        "　　　　　lua")
                    dist = dist + 20
                end
                if isWeapon() then
                    draw.Color(176, 245, 66, 255)
                    if mindmg > 100 then
                        draw.TextShadow(w / 2 - draw.GetTextSize("damage: +" .. (mindmg - 100)) / 2, h / 2 + dist,
                            "damage: +" .. (mindmg - 100))
                    else
                        draw.TextShadow(w / 2 - draw.GetTextSize("damage: " .. mindmg) / 2, h / 2 + dist,
                            "damage: " .. mindmg)
                    end


                    dist = dist + 16
                end
                draw.Color(176, 245, 66, 255)
                local fov = gui.GetValue("rbot.aim.target.fov")
                draw.TextShadow(w / 2 - draw.GetTextSize("fov: " .. fov .. "°") / 2, h / 2 + dist, "fov: " .. fov .. "°")
                dist = dist + 16
                if autowallref:GetValue() then
                    draw.Color(176, 245, 66, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("autowall") / 2, h / 2 + dist, "autowall")
                    dist = dist + 16
                end

                if freestandingref:GetValue() then
                    draw.Color(176, 245, 66, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("freestanding") / 2, h / 2 + dist, "freestanding")
                    dist = dist + 16
                end
                if input.IsButtonDown(fakeduckkey) then
                    draw.Color(176, 245, 66, 255)
                    draw.TextShadow(w / 2 - draw.GetTextSize("fakeduck") / 2, h / 2 + dist, "fakeduck")
                    dist = dist + 16
                end
            end

        end
    end
end

-- INDICATORS

-- FOG
local function fog()
    local lp = entities.GetLocalPlayer()
    if (lp ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local r, g, b = fogcolorref:GetValue();
        local fixed = r .. " " .. g .. " " .. b
        gui.SetValue("esp.other.nofog", false)
        if (client.GetConVar("fog_override") ~= 1) then
            client.SetConVar("fog_override", 1, true)
        end

        if (client.GetConVar("fog_color") ~= fixed) then
            client.SetConVar("fog_color", fixed, true);
        end

        if (client.GetConVar("fog_end") ~= fogdistanceref:GetValue()) then
            client.SetConVar("fog_start", 0, true)
            client.SetConVar("fog_end", fogdistanceref:GetValue(), true)
        end

        if (client.GetConVar("fog_maxdensity") ~= fogdensityref:GetValue()) then
            client.SetConVar("fog_maxdensity", fogdensityref:GetValue(), true)
        end
    end
end

-- FOG

-- EVENTS
function IsValid(entity)
    ---@diagnostic disable-next-line: discard-returns
    return pcall(function() tostring(entity:GetAbsOrigin()) end)
end

local function events(event)
    local lp = entities.GetLocalPlayer()
    if not naofoi then
        if access then
            if autodisconectref:GetValue() then
                if event:GetName() == "cs_win_panel_match" then
                    client.Command("disconnect", true);
                end
            end
        end
    end
end

-- EVENTS

-- SNIPERCROSSHAIR
local function snipercrosshair()
    if snipercrosshairref:GetValue() then
        local lp = entities.GetLocalPlayer();
        if lp == nil then
            client.SetConVar("weapon_debug_spread_show", 0, true)
            return;
        end
        if lp:IsAlive() then
            local scoped = lp:GetProp("m_bIsScoped")
            if scoped == 1 then
                client.SetConVar("weapon_debug_spread_show", 0, true)
            end
            if scoped == 257 then
                client.SetConVar("weapon_debug_spread_show", 0, true)
            end

            if scoped == 65536 then
                client.SetConVar("weapon_debug_spread_show", 1, true)
                client.SetConVar("weapon_debug_spread_gap", 5, true)
            end
            if scoped == 65792 then
                client.SetConVar("weapon_debug_spread_show", 1, true)
                client.SetConVar("weapon_debug_spread_gap", 5, true)
            end

            if scoped == 256 then
                client.SetConVar("weapon_debug_spread_show", 1, true)
                client.SetConVar("weapon_debug_spread_gap", 5, true)
            end
            if scoped == 0 then
                client.SetConVar("weapon_debug_spread_show", 1, true)
                client.SetConVar("weapon_debug_spread_gap", 5, true)
            end
        else
            client.SetConVar("weapon_debug_spread_show", 0, true)
        end
    end
end

-- SNIPERCROSSHAIR

-- DINAMIC FOV
local function BestPlayer()

    local lp = entities.GetLocalPlayer()

    if not lp or not lp:IsAlive() then
        return
    end

    local flMinimumDistance = 4000.0
    local players = entities.FindByClass("CCSPlayer")
    local flaLocalHead = lp:GetHitboxPosition(0)

    for i = 1, #players do
        local player = players[i]
        if player:IsAlive() then
            if player:GetTeamNumber() ~= lp:GetTeamNumber() then
                local flaEnemyHead = player:GetHitboxPosition(0)
                local flDist = math.sqrt(math.pow(flaEnemyHead.x - flaLocalHead.x, 2) +
                    math.pow(flaEnemyHead.y - flaLocalHead.y, 2) +
                    math.pow(flaEnemyHead.z - flaLocalHead.z, 2))

                if flDist < flMinimumDistance then
                    flMinimumDistance = flDist
                end
            end
        end
    end

    return flMinimumDistance
end

local function distance_to_dynamic_fov(min, max, dist)
    if dist == nil then
        return
    end

    if dist >= 1500.0 then
        return min
    elseif dist <= 100.0 then
        return max
    end
    return math.min(max, math.max(min, 5000.0 / dist))
end

local function dynamicfov()
    if dynamicfovref:GetValue() then
        local min_fov = dynamicfovminref:GetValue()
        local max_fov = dynamicfovmaxref:GetValue()
        gui.SetValue("rbot.aim.target.fov", math.floor(distance_to_dynamic_fov(min_fov, max_fov, BestPlayer())))
    end
end

-- DINAMIC FOV

-- ASPECT RATIO
local function aspectratio(UserCmd)
    if aspectratioref:GetValue() == 0 then
        client.SetConVar("r_aspectratio", (35 * 0.1) / 2)
    else
        client.SetConVar("r_aspectratio", (aspectratioref:GetValue() * 0.1) / 2)
    end
end

-- ASPECT RATIO


callbacks.Register("CreateMove", function(UserCmd)
    antiaim(UserCmd)
    legfucker(UserCmd)
    viewmodel(UserCmd)
    autowall(UserCmd)
    aspectratio(UserCmd)
end)

callbacks.Register("Draw", function()
    indicators()
    fog()
    snipercrosshair()
    dynamicfov()
end)

client.AllowListener("cs_win_panel_match")
callbacks.Register("FireGameEvent", events)
