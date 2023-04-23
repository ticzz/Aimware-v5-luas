local meta = {
    version = 1.3,
    name = "Armada",
    git_source = "https://raw.githubusercontent.com/lamarr2817/aimware/master/armada.lua",
    git_version = "https://raw.githubusercontent.com/lamarr2817/aimware/master/armada_verison"
}

local anglecache = {
    camera,
    real,
    lby,
    desync
}
local gcache = {
    doubletapping = false,
    shot = false
}

local tab = gui.Tab(gui.Reference("Ragebot"), string.lower(meta.name) .. ".tab", meta.name)
local versiontext = gui.Text(tab, "Armada v" .. meta.version)
versiontext:SetPosY(500)
versiontext:SetPosX(570)
local gbox = gui.Groupbox(tab, "Anti-Aim", 16, 16, 296, 5)
local gbox_extra = gui.Groupbox(tab, "Extra", 328, 16, 296, 5)
local gui_enable = gui.Checkbox(gbox, "lua.armada.enable", "Enable Armada", 1)

local gui_armada_aa = gui.Checkbox(gbox, "lua.armada.lby", "Force Live LBY", 0)
gui_armada_aa:SetDescription("Updates your LBY more frequently.")
local gui_armada_aa_delay = gui.Slider(gbox, "lua.armada.lby.delay", "Force Live Delay", 9, 4, 12)
gui_armada_aa_delay:SetDescription("Delay between LBY updates.")

local gui_armada_aa_bridge = gui.Checkbox(gbox, "lua.armada.bridge", "LBY Bridge", 0)
gui_armada_aa_bridge:SetDescription("Changes your LBY before and after updating.")
local gui_armada_aa_bridge_type = gui.Combobox(gbox, "lua.armada.bridge.type", "LBY Bridge Modifier", "Mod", "Sway")
local gui_armada_aa_bridge_amount = gui.Slider(gbox, "lua.armada.bridge.amount", "LBY Bridge Amount", 0, -58, 58)
gui_armada_aa_bridge_amount:SetDescription("Also controls sway speed.")

local gui_armada_doubletap = gui.Checkbox(gbox_extra, "lua.armada.rbot.doubletap", "Double-Tap", 0)
gui_armada_doubletap:SetDescription("Increases double-tap speed and consistency.")

local gui_armada_shotswitch = gui.Checkbox(gbox_extra, "lua.armada.shotswitch", "Switch Desync Side On Shot", 0)
gui_armada_shotswitch:SetDescription("If a jitter desync is selected, it will switch jitter side.")
local gui_armada_aa_slowjitter = gui.Checkbox(gbox_extra, "lua.armada.slowwalk", "Jitter Slowwalk Speed", 0)
local gui_armada_aa_slowjitter_min = gui.Slider(gbox_extra, "lua.armada.slowwalk.min", "Minimum Slowwalk Speed", 15, 0, 100)
local gui_armada_aa_slowjitter_max = gui.Slider(gbox_extra, "lua.armada.slowwalk.max", "Max Slowwalk Speed", 65, 0, 100)

local function switch(var)
    if var == 1 then
        return 2
    elseif var == 2 then
        return 1
    elseif var == 3 then
        return 4
    elseif var == 4 then
        return 3
    end
end

local function update()
    if tonumber(http.Get(meta.git_version)) > meta.version then
        print("[ARMADA] New version found. Update started.")
        local current_script = file.Open(GetScriptName(), "w")
        current_script:Write(http.Get(meta.git_source))
        current_script:Close()
        LoadScript(GetScriptName())
        print("[ARMADA] Script is up-to-date.")
    end
end

update()

local function bridge()
    local type = gui_armada_aa_bridge_type:GetValue()
    local amount = gui_armada_aa_bridge_amount:GetValue()

    local cache_b = {
        [0] = amount,
        [1] = (math.sin((globals.RealTime() * amount / 10)) * 140)
    }

    return (anglecache.real + cache_b[type])
end

local function handleGui()
    gui_armada_aa_delay:SetInvisible(not gui_armada_aa:GetValue())
    gui_armada_aa_bridge:SetInvisible(not gui_armada_aa:GetValue())
    gui_armada_aa_bridge_type:SetInvisible(not gui_armada_aa_bridge:GetValue() or not gui_armada_aa:GetValue())
    gui_armada_aa_bridge_amount:SetInvisible(not gui_armada_aa_bridge:GetValue() or not gui_armada_aa:GetValue())
    gui_armada_aa_slowjitter_min:SetInvisible(not gui_armada_aa_slowjitter:GetValue())
    gui_armada_aa_slowjitter_max:SetInvisible(not gui_armada_aa_slowjitter:GetValue())
end

callbacks.Register("Draw", function()
    handleGui()
    if gcache.shot then
        gui.SetValue("rbot.antiaim.fakeyawstyle", switch(gui.GetValue("rbot.antiaim.fakeyawstyle")))
        gcache.shot = false
    end
    if gui_armada_aa_slowjitter:GetValue() then
        if input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) and (globals.TickCount() % 13 == 0) then
            gui.SetValue("rbot.accuracy.movement.slowspeed", math.random(gui_armada_aa_slowjitter_min:GetValue(), gui_armada_aa_slowjitter_max:GetValue()))
        end
    end
end)

callbacks.Register("CreateMove", function(cmd)
    local lp = entities.GetLocalPlayer()
    if not lp or not gui_enable:GetValue() then return end
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    anglecache.lby = lp:GetProp("m_flLowerBodyYawTarget")
    anglecache.real = lp:GetProp("m_angEyeAngles[1]")
    --///////////////////////////////////////////////////////////////////////////////////
    if gui_armada_aa:GetValue() then
        if (globals.TickCount() % gui_armada_aa_delay:GetValue() == 0) and not gcache.doubletapping then
            cmd.forwardmove = 1.01
        elseif gui_armada_aa_bridge:GetValue() and not gcache.doubletapping then
            lp:SetProp("m_flLowerBodyYawTarget", bridge())
        else
        end
    end
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    if gui_armada_doubletap:GetValue() then
        if gcache.doubletapping then
            cmd.sidemove = 0
            cmd.forwardmove = 0
            gcache.doubletapping = false
        end
    end
    --///////////////////////////////////////////////////////////////////////////////////
end )

callbacks.Register("FireGameEvent", function(event)

    if (event:GetName() == 'weapon_fire') then

        local lp = client.GetLocalPlayerIndex()
        local int_shooter = event:GetInt('userid')
        local index_shooter = client.GetPlayerIndexByUserID(int_shooter)

        if ( index_shooter == lp) then
            if gui_armada_doubletap:GetValue() then
                gcache.doubletapping = true
            end
            if gui_armada_shotswitch:GetValue() then
                gcache.shot = true
            end
        end
    end
end)

client.AllowListener('weapon_fire')








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

