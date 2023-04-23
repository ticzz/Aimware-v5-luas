--[[
    ABSINTHE FOR AIMWARE
    BY OLEXON

    you can +rep me if you somehow enjoy using this garbage lol

    if you want something that works and is not coded by a retard use this:
    https://aimware.net/forum/thread/158191
]]

local rb_ref = gui.Reference("RAGEBOT")
local tab = gui.Tab(rb_ref, "absinthe", "Absinthe")

local welcum_gb = gui.Groupbox(tab, "Welcome " .. cheat.GetUserName() .. "!", 10, 10, 200, 200)
gui.Text(welcum_gb, "You are currently using Absinthe")
gui.Text(welcum_gb, "Version 0.6")

-- rage group
local rage_gb = gui.Groupbox(tab, "Rage", 10, 125, 200, 200)
local rage_sw = gui.Checkbox(rage_gb, "rage_sw", "Master Switch", false)
local roll_res_ok = gui.Keybox(rage_gb, "roll_res_ok", "Roll resolver (hold)", 0)

local dt_toggle = gui.Checkbox(rage_gb, "dt_toggle", "Global DT toggle", false)
local hs_toggle = gui.Checkbox(rage_gb, "hs_toggle", "Global HS toggle", false)

-- dmg group
local dmg_settings_wnd = gui.Window("dmg_settings_wnd", "Minimum Damage Settings", 100, 100, 235, 150)
dmg_settings_wnd:SetActive(false)

local dmg_or_gb = gui.Groupbox(tab, "Minimum-Damage", 10, 317, 200, 200)
local dmg_or = gui.Checkbox(dmg_or_gb, "dmg_or", "Damage Override", false)
local wep_selector = gui.Multibox(dmg_settings_wnd, "")
wep_selector:SetPosX(16.5); wep_selector:SetPosY(65)

local dmg_selector = gui.Combobox(dmg_settings_wnd, "dmg_selector", "", unpack({"Shared", "Zeus", "AWP", "SMG", "Shotgun", "Scout", "Rifle", "Pistol", "LMG", "Heavy Pistol", "Autosniper"}))
dmg_selector:SetPosX(16.5); dmg_selector:SetPosY(65)
dmg_selector:SetInvisible(true)

local active_tab = 0

local dmg_wnd_tab1 = gui.Button(dmg_settings_wnd, "Weapon Select", function() wep_selector:SetInvisible(false); dmg_selector:SetInvisible(true); active_tab = 0; dmg_settings_wnd:SetHeight(150) end)
dmg_wnd_tab1:SetPosX(5); dmg_wnd_tab1:SetPosY(5)
dmg_wnd_tab1:SetWidth(225)

local dmg_wnd_tab2 = gui.Button(dmg_settings_wnd, "Damage Settings", function() wep_selector:SetInvisible(true); dmg_selector:SetInvisible(false); active_tab = 1; dmg_settings_wnd:SetHeight(180) end)
dmg_wnd_tab2:SetPosX(5); dmg_wnd_tab2:SetPosY(40)
dmg_wnd_tab2:SetWidth(225)

local function dmg_wnd_toggle()
    if dmg_settings_wnd:IsActive() then
        dmg_settings_wnd:SetActive(false)
    else
        dmg_settings_wnd:SetActive(true)
    end
end

local dmg_settings = gui.Button(dmg_or_gb, "Settings", dmg_wnd_toggle)

dmg_settings:SetWidth(168)

local shared_check = gui.Checkbox(wep_selector, "shared_check", "Shared", false)
local zeus_check = gui.Checkbox(wep_selector, "zeus_check", "Zeus", false)
local sniper_check = gui.Checkbox(wep_selector, "sniper_check", "AWP", false)
local smg_check = gui.Checkbox(wep_selector, "smg_check", "SMG", false)
local shotgun_check = gui.Checkbox(wep_selector, "shotgun_check", "Shotgun", false)
local scout_check = gui.Checkbox(wep_selector, "scout_check", "Scout", false)
local rifle_check = gui.Checkbox(wep_selector, "rifle_check", "Rifle", false)
local pistol_check = gui.Checkbox(wep_selector, "pistol_check", "Pistol", false)
local lmg_check = gui.Checkbox(wep_selector, "lmg_check", "LMG", false)
local hpistol_check = gui.Checkbox(wep_selector, "hpistol_check", "Heavy Pistol", false)
local asniper_check = gui.Checkbox(wep_selector, "asniper_check", "Auto Sniper", false)

local shared_or = gui.Slider(dmg_settings_wnd, "shared_or", "", 1, 1, 100); shared_or:SetPosX(16.5); shared_or:SetPosY(105)
local zeus_or = gui.Slider(dmg_settings_wnd, "zeus_or", "", 1, 1, 100); zeus_or:SetPosX(16.5); zeus_or:SetPosY(105)
local sniper_or = gui.Slider(dmg_settings_wnd, "sniper_or", "", 1, 1, 100); sniper_or:SetPosX(16.5); sniper_or:SetPosY(105)
local smg_or = gui.Slider(dmg_settings_wnd, "smg_or", "", 1, 1, 100); smg_or:SetPosX(16.5); smg_or:SetPosY(105)
local shotgun_or = gui.Slider(dmg_settings_wnd, "shotgun_or", "", 1, 1, 100); shotgun_or:SetPosX(16.5); shotgun_or:SetPosY(105)
local scout_or = gui.Slider(dmg_settings_wnd, "scout_or", "", 1, 1, 100); scout_or:SetPosX(16.5); scout_or:SetPosY(105)
local rifle_or = gui.Slider(dmg_settings_wnd, "rifle_or", "", 1, 1, 100); rifle_or:SetPosX(16.5); rifle_or:SetPosY(105)
local pistol_or = gui.Slider(dmg_settings_wnd, "pistol_or", "", 1, 1, 100); pistol_or:SetPosX(16.5); pistol_or:SetPosY(105)
local lmg_or = gui.Slider(dmg_settings_wnd, "lmg_or", "", 1, 1, 100); lmg_or:SetPosX(16.5); lmg_or:SetPosY(105)
local hpistol_or = gui.Slider(dmg_settings_wnd, "hpistol_or", "", 1, 1, 100); hpistol_or:SetPosX(16.5); hpistol_or:SetPosY(105)
local asniper_or = gui.Slider(dmg_settings_wnd, "asniper_or", "", 1, 1, 100); asniper_or:SetPosX(16.5); asniper_or:SetPosY(105)

local function or_check()
    if active_tab == 1 then
        if dmg_selector:GetValue() == 0 then

            shared_or:SetInvisible(false)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true) 

        elseif dmg_selector:GetValue() == 1 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(false)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 2 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(false)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 3 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(false)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 4 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(false)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 5 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(false)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 6 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(false)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 7 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(false)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 8 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(false)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 9 then

            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(false)
            asniper_or:SetInvisible(true)

        elseif dmg_selector:GetValue() == 10 then
        
            shared_or:SetInvisible(true)
            zeus_or:SetInvisible(true)
            sniper_or:SetInvisible(true)
            smg_or:SetInvisible(true)
            shotgun_or:SetInvisible(true)
            scout_or:SetInvisible(true)
            rifle_or:SetInvisible(true)
            pistol_or:SetInvisible(true)
            lmg_or:SetInvisible(true)
            hpistol_or:SetInvisible(true)
            asniper_or:SetInvisible(false)

        end
    else
        shared_or:SetInvisible(true)
        zeus_or:SetInvisible(true)
        sniper_or:SetInvisible(true)
        smg_or:SetInvisible(true)
        shotgun_or:SetInvisible(true)
        scout_or:SetInvisible(true)
        rifle_or:SetInvisible(true)
        pistol_or:SetInvisible(true)
        lmg_or:SetInvisible(true)
        hpistol_or:SetInvisible(true)
        asniper_or:SetInvisible(true)
    end
end

-- rage aa
local rage_aa_gb = gui.Groupbox(tab, "Anti-Aim", 225, 125, 397, 200)
local inverter_kb = gui.Keybox(rage_aa_gb, "inverter_kb", "Inverter (press)", 0)
local freestand_kb = gui.Keybox(rage_aa_gb, "freestand_kb", "Freestanding (hold)", 0)
local legitaa_kb = gui.Keybox(rage_aa_gb, "legitaa_kb", "Legit Anti-Aim (hold)", 0)
local desync_cb = gui.Combobox(rage_aa_gb, "desync_cb", "Desync", unpack({"Static", "Jitter"}))

local lby_flick_sw = gui.Checkbox(rage_aa_gb, "lby_flick_sw", "LBY Flick", false)
local lby_flick_angle = gui.Slider(rage_aa_gb, "lby_flick_angle", "Flick Angle", 1, 1, 180)
local lby_flick_freq = gui.Slider(rage_aa_gb, "lby_flick_freq", "Flick Frequency (ticks)", 3, 3, 45)

local pitch_flick_sw = gui.Checkbox(rage_aa_gb, "pitch_flick_sw", "Pitch Flick", 0); pitch_flick_sw:SetDescription("Untrusted")
local pitch_flick_freq = gui.Slider(rage_aa_gb, "pitch_flick_freq", "Flick Frequency (ticks)", 2, 2, 35)

local enable_conditions_sw = gui.Checkbox(rage_aa_gb, "enable_conditions_sw", "Enable Conditional Anti-Aim", false)
local cond_cb = gui.Combobox(rage_aa_gb, "rage_aa_conds", "Conditions", unpack({"Standing", "Moving", "Slowwalking", "In Air"}))

local base_yaw_stand = gui.Slider(rage_aa_gb, "base_yaw_stand", "Base Yaw", 180, -180, 180)
local base_yaw_walking = gui.Slider(rage_aa_gb, "base_yaw_walking", "Base Yaw", 180, -180, 180)
local base_yaw_slowwalking = gui.Slider(rage_aa_gb, "base_yaw_slowwalking", "Base Yaw", 180, -180, 180)
local base_yaw_inair = gui.Slider(rage_aa_gb, "base_yaw_inair", "Base Yaw", 180, -180, 180)

local aa_mode_select_stand = gui.Combobox(rage_aa_gb, "aa_mode_select_stand", "Mode", unpack({"Static", "Center", "Offset", "Random", "Jitter", "Rotation"}))
local aa_mode_select_walk = gui.Combobox(rage_aa_gb, "aa_mode_select_walk", "Mode", unpack({"Static", "Center", "Offset", "Random", "Jitter", "Rotation"}))
local aa_mode_select_slowwalk = gui.Combobox(rage_aa_gb, "aa_mode_select_slowwalk", "Mode", unpack({"Static", "Center", "Offset", "Random", "Jitter", "Rotation"}))
local aa_mode_select_inair = gui.Combobox(rage_aa_gb, "aa_mode_select_inair", "Mode", unpack({"Static", "Center", "Offset", "Random", "Jitter", "Rotation"}))

local aa_mode_angle_stand = gui.Slider(rage_aa_gb, "aa_mode_angle_stand", "Angle", 1, 1, 90)
local aa_mode_angle_walk = gui.Slider(rage_aa_gb, "aa_mode_angle_walk", "Angle", 1, 1, 90)
local aa_mode_angle_slowwalk = gui.Slider(rage_aa_gb, "aa_mode_angle_slowwalk", "Angle", 1, 1, 90)
local aa_mode_angle_inair = gui.Slider(rage_aa_gb, "aa_mode_angle_inair", "Angle", 1, 1, 90)

local roll_on_stand = gui.Checkbox(rage_aa_gb, "roll_on_stand", "Roll Angle", 0)
local roll_on_walk = gui.Checkbox(rage_aa_gb, "roll_on_walk", "Roll Angle", 0)
local roll_on_slowwalk = gui.Checkbox(rage_aa_gb, "roll_on_slowwalk", "Roll Angle", 0)
local roll_in_air = gui.Checkbox(rage_aa_gb, "roll_in_air", "Roll Angle", 0)

local antibrute_gb = gui.Groupbox(tab, "Anti-Bruteforce", 10, 460, 200, 200)
local antibrute_mode = gui.Combobox(antibrute_gb, "antibrute_mode", "Mode", unpack({"Off", "Standard", "Stages"}))
local antibrute_stage1 = gui.Slider(antibrute_gb, "antibrute_stage1", "Stage 1", 0, -58, 58)
local antibrute_stage2 = gui.Slider(antibrute_gb, "antibrute_stage2", "Stage 2", 0, -58, 58)
local antibrute_stage3 = gui.Slider(antibrute_gb, "antibrute_stage3", "Stage 3", 0, -58, 58)
local antibrute_stage4 = gui.Slider(antibrute_gb, "antibrute_stage4", "Stage 4", 0, -58, 58)
local antibrute_stage5 = gui.Slider(antibrute_gb, "antibrute_stage5", "Stage 5", 0, -58, 58)

local function cond_ui()
    if enable_conditions_sw:GetValue() then
        if cond_cb:GetValue() == 0 then
            base_yaw_stand:SetInvisible(false)
            base_yaw_walking:SetInvisible(true)
            base_yaw_slowwalking:SetInvisible(true)
            base_yaw_inair:SetInvisible(true)

            aa_mode_select_stand:SetInvisible(false)
            aa_mode_select_walk:SetInvisible(true)
            aa_mode_select_slowwalk:SetInvisible(true)
            aa_mode_select_inair:SetInvisible(true)

            aa_mode_angle_stand:SetInvisible(false)
            aa_mode_angle_walk:SetInvisible(true)
            aa_mode_angle_slowwalk:SetInvisible(true)
            aa_mode_angle_inair:SetInvisible(true)

            roll_on_stand:SetInvisible(false)
            roll_on_walk:SetInvisible(true)
            roll_on_slowwalk:SetInvisible(true)
            roll_in_air:SetInvisible(true)

            if aa_mode_select_stand:GetValue() == 0 or aa_mode_select_stand:GetValue() == 4 then
                aa_mode_angle_stand:SetInvisible(true)
                aa_mode_angle_walk:SetInvisible(true)
                aa_mode_angle_slowwalk:SetInvisible(true)
                aa_mode_angle_inair:SetInvisible(true)
            end
        elseif cond_cb:GetValue() == 1 then
            base_yaw_stand:SetInvisible(true)
            base_yaw_walking:SetInvisible(false)
            base_yaw_slowwalking:SetInvisible(true)
            base_yaw_inair:SetInvisible(true)
            
            aa_mode_select_stand:SetInvisible(true)
            aa_mode_select_walk:SetInvisible(false)
            aa_mode_select_slowwalk:SetInvisible(true)
            aa_mode_select_inair:SetInvisible(true)

            aa_mode_angle_stand:SetInvisible(true)
            aa_mode_angle_walk:SetInvisible(false)
            aa_mode_angle_slowwalk:SetInvisible(true)
            aa_mode_angle_inair:SetInvisible(true)

            roll_on_stand:SetInvisible(true)
            roll_on_walk:SetInvisible(false)
            roll_on_slowwalk:SetInvisible(true)
            roll_in_air:SetInvisible(true)

            if aa_mode_select_walk:GetValue() == 0 or aa_mode_select_walk:GetValue() == 4 then
                aa_mode_angle_stand:SetInvisible(true)
                aa_mode_angle_walk:SetInvisible(true)
                aa_mode_angle_slowwalk:SetInvisible(true)
                aa_mode_angle_inair:SetInvisible(true)
            end
        elseif cond_cb:GetValue() == 2 then
            base_yaw_stand:SetInvisible(true)
            base_yaw_walking:SetInvisible(true)
            base_yaw_slowwalking:SetInvisible(false)
            base_yaw_inair:SetInvisible(true)
            
            aa_mode_select_stand:SetInvisible(true)
            aa_mode_select_walk:SetInvisible(true)
            aa_mode_select_slowwalk:SetInvisible(false)
            aa_mode_select_inair:SetInvisible(true)

            aa_mode_angle_stand:SetInvisible(true)
            aa_mode_angle_walk:SetInvisible(true)
            aa_mode_angle_slowwalk:SetInvisible(false)
            aa_mode_angle_inair:SetInvisible(true)

            roll_on_stand:SetInvisible(true)
            roll_on_walk:SetInvisible(true)
            roll_on_slowwalk:SetInvisible(false)
            roll_in_air:SetInvisible(true)

            if aa_mode_select_slowwalk:GetValue() == 0 or aa_mode_select_slowwalk:GetValue() == 4 then
                aa_mode_angle_stand:SetInvisible(true)
                aa_mode_angle_walk:SetInvisible(true)
                aa_mode_angle_slowwalk:SetInvisible(true)
                aa_mode_angle_inair:SetInvisible(true)
            end
        elseif cond_cb:GetValue() == 3 then
            base_yaw_stand:SetInvisible(true)
            base_yaw_walking:SetInvisible(true)
            base_yaw_slowwalking:SetInvisible(true)
            base_yaw_inair:SetInvisible(false)
            
            aa_mode_select_stand:SetInvisible(true)
            aa_mode_select_walk:SetInvisible(true)
            aa_mode_select_slowwalk:SetInvisible(true)
            aa_mode_select_inair:SetInvisible(false)

            aa_mode_angle_stand:SetInvisible(true)
            aa_mode_angle_walk:SetInvisible(true)
            aa_mode_angle_slowwalk:SetInvisible(true)
            aa_mode_angle_inair:SetInvisible(false)

            roll_on_stand:SetInvisible(true)
            roll_on_walk:SetInvisible(true)
            roll_on_slowwalk:SetInvisible(true)
            roll_in_air:SetInvisible(false)

            if aa_mode_select_inair:GetValue() == 0 or aa_mode_select_inair:GetValue() == 4 then
                aa_mode_angle_stand:SetInvisible(true)
                aa_mode_angle_walk:SetInvisible(true)
                aa_mode_angle_slowwalk:SetInvisible(true)
                aa_mode_angle_inair:SetInvisible(true)
            end
        end
    else
        base_yaw_stand:SetInvisible(false)
        base_yaw_walking:SetInvisible(true)
        base_yaw_slowwalking:SetInvisible(true)
        base_yaw_inair:SetInvisible(true)

        aa_mode_select_stand:SetInvisible(false)
        aa_mode_select_walk:SetInvisible(true)
        aa_mode_select_slowwalk:SetInvisible(true)
        aa_mode_select_inair:SetInvisible(true)

        aa_mode_angle_stand:SetInvisible(false)
        aa_mode_angle_walk:SetInvisible(true)
        aa_mode_angle_slowwalk:SetInvisible(true)
        aa_mode_angle_inair:SetInvisible(true)

        roll_on_stand:SetInvisible(false)
        roll_on_walk:SetInvisible(true)
        roll_on_slowwalk:SetInvisible(true)
        roll_in_air:SetInvisible(true)

        if aa_mode_select_stand:GetValue() == 0 or aa_mode_select_stand:GetValue() == 4 then
            aa_mode_angle_stand:SetInvisible(true)
            aa_mode_angle_walk:SetInvisible(true)
            aa_mode_angle_slowwalk:SetInvisible(true)
            aa_mode_angle_inair:SetInvisible(true)
        end
    end

    -- this lua is one big sphagetti already so i will put it there
    if antibrute_mode:GetValue() ~= 2 then
        antibrute_stage1:SetInvisible(true)
        antibrute_stage2:SetInvisible(true)
        antibrute_stage3:SetInvisible(true)
        antibrute_stage4:SetInvisible(true)
        antibrute_stage5:SetInvisible(true)
    else
        antibrute_stage1:SetInvisible(false)
        antibrute_stage2:SetInvisible(false)
        antibrute_stage3:SetInvisible(false)
        antibrute_stage4:SetInvisible(false)
        antibrute_stage5:SetInvisible(false)
    end
end

-- semirage
local semirage_gb = gui.Groupbox(tab, "Semi-Rage", 10, 125, 200, 200)
local semirage_sw = gui.Checkbox(semirage_gb, "semirage_sw", "Master Switch", false)
local unsafe_sw = gui.Checkbox(semirage_gb, "unsafe_sw", "Allow Unsafe Features", false)
local unsafe_txt = gui.Text(semirage_gb, "Allows user to use features\n\nthat may cause untrusted bans")

local dynamicfov_sw = gui.Checkbox(semirage_gb, "dynamicfov_sw", "Dynamic FOV", false)
local dynamicfov_min = gui.Slider(semirage_gb, "dynamicfov_min", "Dynamic FOV Minimum", 1, 1, 30)
local dynamicfov_max = gui.Slider(semirage_gb, "dynamicfov_max", "Dynamic FOV Maximum", 1, 1, 30)

local dmg_semi_or = gui.Checkbox(semirage_gb, "dmg_semi_or", "Damage Override", false)
local dmg_settings_semi = gui.Button(semirage_gb, "Settings", dmg_wnd_toggle)
dmg_settings_semi:SetWidth(168)

local legit_aa_gb = gui.Groupbox(tab, "Legit-Anti-Aim", 225, 342, 397, 200)
local legit_inverter_kb = gui.Keybox(legit_aa_gb, "legit_inverter_kb", "Inverter (press)", 0)
local semi_freestand_kb = gui.Keybox(legit_aa_gb, "semi_freestand_kb", "Freestanding (hold)", 0)
local antibrute_semi_btn = gui.Button(legit_aa_gb, "Anti-Bruteforce (soon)", function() end) --lol
antibrute_semi_btn:SetWidth(366)

local desync_mod_gb = gui.Groupbox(tab, "Desync", 225, 125, 397, 200)
local desync_left_slider = gui.Slider(desync_mod_gb, "desync_left_slider", "Left side", 0, 0, 58)
local desync_right_slider = gui.Slider(desync_mod_gb, "desync_right_slider", "Right side", 0, 0, 58)
local desync_roll_slider = gui.Slider(desync_mod_gb, "desync_roll_slider", "Roll Angle", 0, 0, 50); desync_r

--misc
local misc_gb = gui.Groupbox(tab, "Misc", 10, 125, 200, 200)
local r8_fix = gui.Checkbox(misc_gb, "r8_fix", "Revolver dump fix", false)
gui.Text(misc_gb, "NOTE: High ping and exploits\n\nmay also cause R8 to dump!")
local aspectratio_slider = gui.Slider(misc_gb, "aspectratio_slider", "Aspect Ratio", 0, 0, 10, 0.1)

local rq_btn = gui.Button(misc_gb, "Rage Quit!", function() client.Command("quit", true) end); rq_btn:SetWidth(168) -- very useful feature

local misc_vis_gb = gui.Groupbox(tab, "Visuals", 225, 125, 397, 200)

-- colors
local fake_arrow_col = gui.ColorPicker(misc_vis_gb, "fake_arrow_col", "Fake Arrow", 71, 143, 86, 255)
local real_arrow_col = gui.ColorPicker(misc_vis_gb, "real_arrow_col", "Real Arrow", 0, 0, 0, 130)
local indicator_col = gui.ColorPicker(misc_vis_gb, "indicator_col", "Main", 71, 143, 86, 255)
local items_col = gui.ColorPicker(misc_vis_gb, "items_col", "Items", 118, 181, 131, 255)

-- mess
local desync_arrows_cb = gui.Checkbox(misc_vis_gb, "desync_arrows_cb", "Desync Arrows", false)
local target_snap_cb = gui.Checkbox(misc_vis_gb, "target_snap_cb", "Target Snapline", false)
local misc_vis_indicators = gui.Combobox(misc_vis_gb, "misc_vis_indicators", "Indicators Style", unpack({"Off", "Under Crosshair"}))
local misc_vis_indicators_selector = gui.Multibox(misc_vis_gb, "Select Indicators")
local abfov_ind = gui.Checkbox(misc_vis_indicators_selector, "abfov_ind", "Aim FOV", false)
local dside_ind = gui.Checkbox(misc_vis_indicators_selector, "dside_ind", "Desync Side", false)
local autowall_ind = gui.Checkbox(misc_vis_indicators_selector, "autowall_ind", "Autowall", false)
local dmg_ind = gui.Checkbox(misc_vis_indicators_selector, "dmg_ind", "Minimum Damage", false)
local dt_ind = gui.Checkbox(misc_vis_indicators_selector, "dt_ind", "Double Tap", false)
local hs_ind = gui.Checkbox(misc_vis_indicators_selector, "hs_ind", "Hide Shots", false)
local fd_ind = gui.Checkbox(misc_vis_indicators_selector, "fd_ind", "Fakeduck", false)

local misc_autobuy_gb = gui.Groupbox(tab, "Autobuy", 10, 360, 200, 200)
local autobuy_sw = gui.Checkbox(misc_autobuy_gb, "autobuy_sw", "Master Switch", false)

local autobuy_wnd = gui.Window("autobuy_wnd", "Autobuy", 350, 100, 235, 280)
autobuy_wnd:SetActive(false)

-- primary
local primary_wep = gui.Combobox(autobuy_wnd, "primary_wep", "Primary Weapon", unpack({"None", "Awp", "Ssg08", "Scar20/G3SG1"})); primary_wep:SetPosX(16.5); primary_wep:SetPosY(85)

-- secondary
local secondary_wep = gui.Combobox(autobuy_wnd, "secondary_wep", "Secondary Weapon", unpack({"None", "Deagle/Revolver", "Five-Seven/Tec-9", "Dual Berettas"})); secondary_wep:SetPosX(16.5); secondary_wep:SetPosY(140)

-- misc
local misc_wep = gui.Multibox(autobuy_wnd, "Other Equipment"); misc_wep:SetPosX(16.5); misc_wep:SetPosY(195)
local kev_wep = gui.Checkbox(misc_wep, "kev_wep", "Kevlar and Helment", false)
local nade_wep = gui.Checkbox(misc_wep, "nade_wep", "Grenades", false)
local def_wep = gui.Checkbox(misc_wep, "def_wep", "Defuse/Rescue Kit", false)
local taser_wep = gui.Checkbox(misc_wep, "taser_wep", "Taser", false)

-- Autobuy Override
local autobuy_override_cb = gui.Checkbox(autobuy_wnd, "override_cb", "Override Autobuy", false); autobuy_override_cb:SetPosX(16.5); autobuy_override_cb:SetPosY(85)

-- primary
local primary_wep_or = gui.Combobox(autobuy_wnd, "primary_wep_or", "Primary Weapon", unpack({"None", "Awp", "Ssg08", "Scar20/G3SG1"})); primary_wep_or:SetPosX(16.5); primary_wep_or:SetPosY(120)

-- secondary
local secondary_wep_or = gui.Combobox(autobuy_wnd, "secondary_wep_or", "Secondary Weapon", unpack({"None", "Deagle/Revolver", "Five-Seven/Tec-9", "Dual Berettas"})); secondary_wep_or:SetPosX(16.5); secondary_wep_or:SetPosY(175)

-- misc
local misc_wep_or = gui.Multibox(autobuy_wnd, "Other Equipment"); misc_wep_or:SetPosX(16.5); misc_wep_or:SetPosY(230)
local kev_wep_or = gui.Checkbox(misc_wep_or, "kev_wep_or", "Kevlar and Helment", false)
local nade_wep_or = gui.Checkbox(misc_wep_or, "nade_wep_or", "Grenades", false)
local def_wep_or = gui.Checkbox(misc_wep_or, "def_wep_or", "Defuse/Rescue Kit", false)
local taser_wep_or = gui.Checkbox(misc_wep_or, "taser_wep_or", "Taser", false)

primary_wep_or:SetInvisible(true) 
secondary_wep_or:SetInvisible(true) 
misc_wep_or:SetInvisible(true)
autobuy_override_cb:SetInvisible(true)

local autobuy_wnd_tab1 = gui.Button(autobuy_wnd, "Regular", function() 
    primary_wep:SetInvisible(false) 
    secondary_wep:SetInvisible(false) 
    misc_wep:SetInvisible(false)

    primary_wep_or:SetInvisible(true) 
    secondary_wep_or:SetInvisible(true) 
    misc_wep_or:SetInvisible(true)
    autobuy_override_cb:SetInvisible(true)

    autobuy_wnd:SetHeight(280)
end)
autobuy_wnd_tab1:SetPosX(5); autobuy_wnd_tab1:SetPosY(5)
autobuy_wnd_tab1:SetWidth(225)

local autobuy_wnd_tab2 = gui.Button(autobuy_wnd, "Override", function() 
    primary_wep:SetInvisible(true) 
    secondary_wep:SetInvisible(true) 
    misc_wep:SetInvisible(true)

    primary_wep_or:SetInvisible(false) 
    secondary_wep_or:SetInvisible(false) 
    misc_wep_or:SetInvisible(false)
    autobuy_override_cb:SetInvisible(false)

    autobuy_wnd:SetHeight(315)
end)
autobuy_wnd_tab2:SetPosX(5); autobuy_wnd_tab2:SetPosY(40)
autobuy_wnd_tab2:SetWidth(225)

local autobuy_wnd_toggle = gui.Button(misc_autobuy_gb, "Settings", function()
    if autobuy_wnd:IsActive() then
        autobuy_wnd:SetActive(false)
    else
        autobuy_wnd:SetActive(true)
    end
end)

autobuy_wnd_toggle:SetWidth(168)

-- set those to invisible ootb
semirage_gb:SetInvisible(true)
legit_aa_gb:SetInvisible(true)
desync_mod_gb:SetInvisible(true)

misc_gb:SetInvisible(true)
misc_vis_gb:SetInvisible(true)
misc_autobuy_gb:SetInvisible(true)

local rage_subtab = gui.Button(tab, "RAGE", function()
    rage_gb:SetInvisible(false)
    rage_aa_gb:SetInvisible(false)
    antibrute_gb:SetInvisible(false)
    dmg_or_gb:SetInvisible(false)

    semirage_gb:SetInvisible(true)
    legit_aa_gb:SetInvisible(true)
    desync_mod_gb:SetInvisible(true)

    misc_gb:SetInvisible(true)
    misc_vis_gb:SetInvisible(true)
    misc_autobuy_gb:SetInvisible(true)
 end)
rage_subtab:SetPosY(17.5)
rage_subtab:SetPosX(225)
rage_subtab:SetHeight(80)

local semirage_subtab = gui.Button(tab, "SEMI-RAGE", function()
    rage_gb:SetInvisible(true)
    rage_aa_gb:SetInvisible(true)
    antibrute_gb:SetInvisible(true)
    dmg_or_gb:SetInvisible(true)

    semirage_gb:SetInvisible(false)
    legit_aa_gb:SetInvisible(false)
    desync_mod_gb:SetInvisible(false)

    misc_gb:SetInvisible(true)
    misc_vis_gb:SetInvisible(true)
    misc_autobuy_gb:SetInvisible(true)
end)
semirage_subtab:SetPosY(17.5)
semirage_subtab:SetPosX(360)
semirage_subtab:SetHeight(80)

local misc_subtab = gui.Button(tab, "MISC", function()
    rage_gb:SetInvisible(true)
    rage_aa_gb:SetInvisible(true)
    antibrute_gb:SetInvisible(true)
    dmg_or_gb:SetInvisible(true)

    semirage_gb:SetInvisible(true)
    legit_aa_gb:SetInvisible(true)
    desync_mod_gb:SetInvisible(true)

    misc_gb:SetInvisible(false)
    misc_vis_gb:SetInvisible(false)
    misc_autobuy_gb:SetInvisible(false)
end)
misc_subtab:SetPosY(17.5)
misc_subtab:SetPosX(495)
misc_subtab:SetHeight(80)

local weapons_list = {
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
    [41] = "knife",
    [42] = "knife",
    [59] = "knife",
    [60] = "rifle",
    [61] = "pistol",
    [63] = "pistol",
    [64] = "hpistol",
    [500] = "knife",
    [503] = "knife",
    [505] = "kinife",
    [506] = "knife",
    [507] = "knife",
    [508] = "knife",
    [509] = "knife",
    [512] = "knife",
    [514] = "knife",
    [515] = "knife",
    [516] = "knife",
    [517] = "knife",
    [518] = "knife",
    [519] = "knife",
    [520] = "knife",
    [521] = "knife",
    [522] = "knife",
    [523] = "knife",
    [525] = "knife",
}

-- RAGE
local mindmg_backup_state = 0
local mindmg_original_backup = {
    shared = nil,
    zeus = nil,
    sniper = nil,
    smg = nil,
    shotgun = nil,
    scout = nil,
    rifle = nil,
    pistol = nil,
    lmg = nil,
    hpistol = nil,
    asniper = nil
}

local function dmg_override() -- pee pee poo poo retarb function for loops hurt
    if not rage_sw:GetValue() and not semirage_sw:GetValue() then return end

    if dmg_or:GetValue() or dmg_semi_or:GetValue() then
        if mindmg_backup_state ~= 1 then
            mindmg_original_backup.shared = gui.GetValue("rbot.hitscan.accuracy.shared.mindamage")
            mindmg_original_backup.zeus = gui.GetValue("rbot.hitscan.accuracy.zeus.mindamage")
            mindmg_original_backup.sniper = gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
            mindmg_original_backup.smg = gui.GetValue("rbot.hitscan.accuracy.smg.mindamage")
            mindmg_original_backup.shotgun = gui.GetValue("rbot.hitscan.accuracy.shotgun.mindamage")
            mindmg_original_backup.scout = gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
            mindmg_original_backup.rifle = gui.GetValue("rbot.hitscan.accuracy.rifle.mindamage")
            mindmg_original_backup.pistol = gui.GetValue("rbot.hitscan.accuracy.pistol.mindamage")
            mindmg_original_backup.lmg = gui.GetValue("rbot.hitscan.accuracy.lmg.mindamage")
            mindmg_original_backup.hpistol = gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
            mindmg_original_backup.asniper = gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")

            mindmg_backup_state = 1
        end

        if shared_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.shared.mindamage", shared_or:GetValue())
        end
        if zeus_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.zeus.mindamage", zeus_or:GetValue())
        end
        if sniper_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", sniper_or:GetValue())
        end
        if smg_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", smg_or:GetValue())
        end
        if shotgun_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", shotgun_or:GetValue())
        end
        if scout_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", scout_or:GetValue())
        end
        if rifle_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", rifle_or:GetValue())
        end
        if pistol_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", pistol_or:GetValue())
        end
        if lmg_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", lmg_or:GetValue())
        end
        if hpistol_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", hpistol_or:GetValue())
        end
        if asniper_check:GetValue() then
            gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", asniper_or:GetValue())
        end
    elseif not dmg_or:GetValue() and not dmg_semi_or:GetValue() then
        if mindmg_backup_state == 1 then
            mindmg_original_backup.shared = gui.SetValue("rbot.hitscan.accuracy.shared.mindamage", mindmg_original_backup.shared)
            mindmg_original_backup.zeus = gui.SetValue("rbot.hitscan.accuracy.zeus.mindamage", mindmg_original_backup.zeus)
            mindmg_original_backup.sniper = gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", mindmg_original_backup.sniper)
            mindmg_original_backup.smg = gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", mindmg_original_backup.smg)
            mindmg_original_backup.shotgun = gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", mindmg_original_backup.shotgun)
            mindmg_original_backup.scout = gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", mindmg_original_backup.scout)
            mindmg_original_backup.rifle = gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", mindmg_original_backup.rifle)
            mindmg_original_backup.pistol = gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", mindmg_original_backup.pistol)
            mindmg_original_backup.lmg = gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", mindmg_original_backup.lmg)
            mindmg_original_backup.hpistol = gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", mindmg_original_backup.hpistol)
            mindmg_original_backup.asniper = gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", mindmg_original_backup.asniper)

            mindmg_backup_state = 0
        end
    end
    --print(gui.GetValue( "rbot.hitscan.accuracy.scout.mindamage" ))
end

local function resolver_override()
    if rage_sw:GetValue() then
        if roll_res_ok:GetValue() ~= 0 and input.IsButtonDown(roll_res_ok:GetValue()) then
            gui.SetValue("rbot.aim.posadj.resolver", 1)
        end
        if roll_res_ok:GetValue() ~= 0 and not input.IsButtonDown(roll_res_ok:GetValue()) then
            gui.SetValue("rbot.aim.posadj.resolver", 2)
        end
    end
end

-- RAGE AA
local function center_jitter(base_yaw, condition_value, tick_multiplier) 
    if base_yaw > 0 then    
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw-condition_value))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", (-base_yaw+condition_value))
        end  
    else
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw+condition_value))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", (-base_yaw-condition_value))
        end  
    end
end

local function offset_jitter(base_yaw, condition_value, tick_multiplier) 
    if base_yaw > 0 then    
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw-condition_value))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", base_yaw)
        end  
    else
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw+condition_value))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", base_yaw)
        end  
    end
end

local function random_jitter(base_yaw, condition_value, tick_multiplier) 
    if base_yaw > 0 then    
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw-math.random(1, condition_value)))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", (-base_yaw+math.random(1, condition_value)))
        end  
    else
        if globals.TickCount()%2 == 0 then
            gui.SetValue("rbot.antiaim.base", (base_yaw+math.random(1, condition_value)))
        end

        if globals.TickCount()%(2*tick_multiplier) == 0 then
            gui.SetValue("rbot.antiaim.base", (-base_yaw-math.random(1, condition_value)))
        end  
    end
end

local spin_angle = 0
local function spinbot(yaw, condition_value)
    spin_angle = spin_angle + 4

    if spin_angle > condition_value then 
        spin_angle = spin_angle * -1
    end

    if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
        if spin_angle > 0 then
            yaw = yaw + spin_angle
        else
            yaw = yaw - spin_angle
        end
    else
        if spin_angle > 0 then
            yaw = yaw - spin_angle
        else
            yaw = yaw + spin_angle
        end
    end

    if yaw > 180 then
        yaw = yaw - 360
    elseif yaw < -180 then
        yaw = yaw + 360
    end

    gui.SetValue("rbot.antiaim.base", yaw)
end


local function rage_aa()
    if rage_sw:GetValue() then

        local tick_multiplier = 2

        if enable_conditions_sw:GetValue() then
            -- conditions
            slowwalkkey = gui.GetValue("rbot.accuracy.movement.slowkey")

            local localplayer = entities:GetLocalPlayer()
            local localplayer_velocity = localplayer:GetPropVector("localdata", "m_vecVelocity[0]"):Length()
            local localplayer_flags = localplayer:GetPropBool("m_hGroundEntity")

            if slowwalkkey == nil or not input.IsButtonDown(slowwalkkey) and localplayer_velocity > 3 and localplayer_flags == false then --walking

                if aa_mode_select_walk:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base", base_yaw_walking:GetValue())
                elseif aa_mode_select_walk:GetValue() == 1 then

                    center_jitter(base_yaw_walking:GetValue(), aa_mode_angle_walk:GetValue(), tick_multiplier)

                elseif aa_mode_select_walk:GetValue() == 2 then

                    offset_jitter(base_yaw_walking:GetValue(), aa_mode_angle_walk:GetValue(), tick_multiplier)

                elseif aa_mode_select_walk:GetValue() == 3 then

                    random_jitter(base_yaw_walking:GetValue(), aa_mode_angle_walk:GetValue(), tick_multiplier)

                elseif aa_mode_select_walk:GetValue() == 4 then
                    if globals.TickCount()%2 == 0 then
                        gui.SetValue("rbot.antiaim.base", 0)
                    end

                    if globals.TickCount()%(2*tick_multiplier) == 0 then
                        gui.SetValue("rbot.antiaim.base", 180)
                    end
                elseif aa_mode_select_walk:GetValue() == 5 then
                    
                    spinbot(base_yaw_walking:GetValue(), aa_mode_angle_walk:GetValue())

                end 

                if roll_on_walk:GetValue() then
                    gui.SetValue("rbot.antiaim.advanced.roll", true)
                else
                    gui.SetValue("rbot.antiaim.advanced.roll", false)
                end
            elseif slowwalkkey ~= nil and input.IsButtonDown(slowwalkkey) and localplayer_velocity > 3 and localplayer_flags == false then --slowwalking

                if aa_mode_select_slowwalk:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base", base_yaw_slowwalking:GetValue())
                elseif aa_mode_select_slowwalk:GetValue() == 1 then

                    center_jitter(base_yaw_slowwalking:GetValue(), aa_mode_angle_slowwalk:GetValue(), tick_multiplier)

                elseif aa_mode_select_slowwalk:GetValue() == 2 then

                    offset_jitter(base_yaw_slowwalking:GetValue(), aa_mode_angle_slowwalk:GetValue(), tick_multiplier)

                elseif aa_mode_select_slowwalk:GetValue() == 3 then

                    random_jitter(base_yaw_slowwalking:GetValue(), aa_mode_angle_slowwalk:GetValue(), tick_multiplier)
                
                elseif aa_mode_select_slowwalk:GetValue() == 4 then
                    if globals.TickCount()%2 == 0 then
                        gui.SetValue("rbot.antiaim.base", 0)
                    end

                    if globals.TickCount()%(2*tick_multiplier) == 0 then
                        gui.SetValue("rbot.antiaim.base", 180)
                    end
                elseif aa_mode_select_slowwalk:GetValue() == 5 then
                    
                    spinbot(base_yaw_slowwalking:GetValue(), aa_mode_angle_slowwalk:GetValue())

                end

                if roll_on_slowwalk:GetValue() then
                    gui.SetValue("rbot.antiaim.advanced.roll", true)
                else
                    gui.SetValue("rbot.antiaim.advanced.roll", false)
                end
            elseif slowwalkkey == nil or not input.IsButtonDown(slowwalkkey) and localplayer_velocity > 3 and localplayer_flags == true then --inair
                
                if aa_mode_select_inair:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base", base_yaw_inair:GetValue())
                elseif aa_mode_select_inair:GetValue() == 1 then

                    center_jitter(base_yaw_inair:GetValue(), aa_mode_angle_inair:GetValue(), tick_multiplier)

                elseif aa_mode_select_inair:GetValue() == 2 then

                    offset_jitter(base_yaw_inair:GetValue(), aa_mode_angle_inair:GetValue(), tick_multiplier)

                elseif aa_mode_select_inair:GetValue() == 3 then
                    
                    random_jitter(base_yaw_inair:GetValue(), aa_mode_angle_inair:GetValue(), tick_multiplier)
                
                elseif aa_mode_select_inair:GetValue() == 4 then
                    if globals.TickCount()%2 == 0 then
                        gui.SetValue("rbot.antiaim.base", 0)
                    end

                    if globals.TickCount()%(2*tick_multiplier) == 0 then
                        gui.SetValue("rbot.antiaim.base", 180)
                    end
                elseif aa_mode_select_inair:GetValue() == 5 then
                    
                    spinbot(base_yaw_inair:GetValue(), aa_mode_angle_inair:GetValue())

                end

                if roll_in_air:GetValue() then
                    gui.SetValue("rbot.antiaim.advanced.roll", true)
                else
                    gui.SetValue("rbot.antiaim.advanced.roll", false)
                end
            else --standing

                if aa_mode_select_stand:GetValue() == 0 then
                    gui.SetValue("rbot.antiaim.base", base_yaw_stand:GetValue())
                elseif aa_mode_select_stand:GetValue() == 1 then

                    center_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)

                elseif aa_mode_select_stand:GetValue() == 2 then

                    offset_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)

                elseif aa_mode_select_stand:GetValue() == 3 then
                    
                    random_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)
                
                elseif aa_mode_select_stand:GetValue() == 4 then
                    if globals.TickCount()%2 == 0 then
                        gui.SetValue("rbot.antiaim.base", 0)
                    end

                    if globals.TickCount()%(2*tick_multiplier) == 0 then
                        gui.SetValue("rbot.antiaim.base", 180)
                    end
                elseif aa_mode_select_stand:GetValue() == 5 then
                    
                    spinbot(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue())

                end

                if roll_on_stand:GetValue() then
                    gui.SetValue("rbot.antiaim.advanced.roll", true)
                else
                    gui.SetValue("rbot.antiaim.advanced.roll", false)
                end
            end
        else --general-
            if aa_mode_select_stand:GetValue() == 0 then
                gui.SetValue("rbot.antiaim.base", base_yaw_stand:GetValue())
            elseif aa_mode_select_stand:GetValue() == 1 then

                center_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)

            elseif aa_mode_select_stand:GetValue() == 2 then

                offset_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)

            elseif aa_mode_select_stand:GetValue() == 3 then
                
                random_jitter(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue(), tick_multiplier)
            
            elseif aa_mode_select_stand:GetValue() == 4 then
                if globals.TickCount()%2 == 0 then
                    gui.SetValue("rbot.antiaim.base", 0)
                end

                if globals.TickCount()%(2*tick_multiplier) == 0 then
                    gui.SetValue("rbot.antiaim.base", 180)
                end
            elseif aa_mode_select_stand:GetValue()== 5 then
                    
                spinbot(base_yaw_stand:GetValue(), aa_mode_angle_stand:GetValue())
                
            end

            if roll_on_stand:GetValue() then
                gui.SetValue("rbot.antiaim.advanced.roll", true)
            else
                gui.SetValue("rbot.antiaim.advanced.roll", false)
            end
        end
    end
end

local function lby_flick()
    if rage_sw:GetValue() then
        local localplayer = entities.GetLocalPlayer()

        if not localplayer or not localplayer:IsAlive() then 
            return
        end

        local yaw_value = base_yaw_stand:GetValue() -- will use stand's value till i stop being lazy mf

        local desync_side = gui.GetValue("rbot.antiaim.base.rotation")
        local flick_freq = lby_flick_freq:GetValue()

        -- yaw should return to its normal state after flick because its forced by other function
        if lby_flick_sw:GetValue() then
            if desync_side > 0 then
                if globals.TickCount()%flick_freq == 0 then
                    gui.SetValue("rbot.antiaim.base", yaw_value - lby_flick_angle:GetValue())
                end
            elseif desync_side < 0 then
                if globals.TickCount()%flick_freq == 0 then
                    gui.SetValue("rbot.antiaim.base", (yaw_value - lby_flick_angle:GetValue()) * -1)
                end
            end
        end
    end
end

local function pitch_flick(cmd)
    local lp = entities.GetLocalPlayer()

    if not lp or not lp:IsAlive() then return end

    if legitaa_kb:GetValue() ~= 0 then
        if input.IsButtonDown(legitaa_kb:GetValue()) then return end
    end

    if pitch_flick_sw:GetValue() and bit.band(cmd.buttons, bit.lshift(1, 0)) ~= 1 --[[ <-- to prevent shooting at the sky ]]  then
        if globals.TickCount()%pitch_flick_freq:GetValue() == 0 then
            cmd.viewangles = EulerAngles(-180, cmd.viewangles.y, cmd.viewangles.z)
        end

        if globals.TickCount()%(pitch_flick_freq:GetValue()*2) == 0 then
            cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
        end
    end
end -- shit fuck fuck balls cum aaAAAAaaaaaaaaaAAAAAAAAAA


local legitaa_backup_state = 0
local backup_legitaa = {
    pitch = nil,
    targets = nil
}

local function legit_aa_on_hold()
    if rage_sw:GetValue() then

        if legitaa_kb:GetValue() == 0 then return end

        if input.IsButtonDown(legitaa_kb:GetValue()) then
            if legitaa_backup_state ~= 1 then
                backup_legitaa.pitch = gui.GetValue("rbot.antiaim.advanced.pitch")
                backup_legitaa.targets = gui.GetValue("rbot.antiaim.condition.autodir.targets")
    
                legitaa_backup_state = 1
            end

            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.condition.autodir.targets", false)
            gui.SetValue("rbot.antiaim.condition.use", false)
        else
            if legitaa_backup_state == 1 then
                gui.SetValue("rbot.antiaim.advanced.pitch", backup_legitaa.pitch)
                gui.SetValue("rbot.antiaim.condition.autodir.targets", backup_legitaa.targets)
                gui.SetValue("rbot.antiaim.condition.use", backup_legitaa.disable_on_use)
                gui.SetValue("rbot.antiaim.condition.use", false)

                legitaa_backup_state = 0
            end
        end
    end
end

local stage = 0
local function anti_brute(event)
    if not rage_sw:GetValue() and not semirage_sw:GetValue() then return end
    local localplayer = entities.GetLocalPlayer()

    if not localplayer or not localplayer:IsAlive() then 
        if stage ~= 0 then
            stage = 0
        end

        return
    end

    if event then

        if event:GetName() == nil or client.GetLocalPlayerIndex() == client.GetPlayerIndexByUserID(event:GetInt("userid")) then return end
        local attacker_ent = entities.GetByIndex(client.GetPlayerIndexByUserID(event:GetInt("userid")))
        
        if entities.GetLocalPlayer():GetTeamNumber() == attacker_ent:GetTeamNumber() then return end

        if event:GetName() == "bullet_impact" then
            if antibrute_mode:GetValue() == 1 then
                gui.SetValue("rbot.antiaim.base.rotation", (gui.GetValue("rbot.antiaim.base.rotation")*-1))
            end

            if antibrute_mode:GetValue() == 2 then
                if stage == 0 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage1:GetValue())
                    stage = stage + 1
                elseif stage == 1 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage2:GetValue())
                    stage = stage + 1
                elseif stage == 2 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage3:GetValue())
                    stage = stage + 1
                elseif stage == 3 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage4:GetValue())
                    stage = stage + 1
                elseif stage == 4 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage5:GetValue())
                    stage = 0
                --[[elseif stage == 5 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage6:GetValue())
                    stage = stage + 1
                elseif stage == 6 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage7:GetValue())
                    stage = stage + 1
                elseif stage == 7 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage8:GetValue())
                    stage = stage + 1
                elseif stage == 8 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage9:GetValue())
                    stage = stage + 1
                elseif stage == 9 then
                    gui.SetValue("rbot.antiaim.base.rotation", antibrute_stage10:GetValue())
                    stage = 0]]
                end

                --print(stage)
            end
        end
    end
end

local semi_current_side = 0 -- 0 - left | 1 - right
local function desync_inverter()
    if rage_sw:GetValue() then
        if (inverter_kb:GetValue() ~= 0 and input.IsButtonPressed(inverter_kb:GetValue())) then
            gui.SetValue("rbot.antiaim.base.rotation", (gui.GetValue("rbot.antiaim.base.rotation")*-1))
        end
    elseif semirage_sw:GetValue() then
        if (legit_inverter_kb:GetValue() ~= 0 and input.IsButtonPressed(legit_inverter_kb:GetValue())) then
            if semi_current_side ~= 1 then
                semi_current_side = semi_current_side + 1
            else
                semi_current_side = 0
            end
        end
    end
end

local function desync_jitter()
    if rage_sw:GetValue() then
        if desync_cb:GetValue() == 1 then
            gui.SetValue("rbot.antiaim.base.rotation", (gui.GetValue("rbot.antiaim.base.rotation")*-1))
        end
    end
end

local function freestand()
    if rage_sw:GetValue() or semirage_sw:GetValue() and unsafe_sw:GetValue() then
        if freestand_kb:GetValue() ~= 0 and input.IsButtonDown(freestand_kb:GetValue()) or semi_freestand_kb:GetValue() ~= 0 and input.IsButtonDown(semi_freestand_kb:GetValue()) then
            gui.SetValue("rbot.antiaim.condition.autodir.edges", true)
            gui.SetValue("rbot.antiaim.right", -110)
            gui.SetValue("rbot.antiaim.left", 110)
        elseif freestand_kb:GetValue() == 0 or not input.IsButtonDown(freestand_kb:GetValue()) or semi_freestand_kb:GetValue() == 0 or not input.IsButtonDown(semi_freestand_kb:GetValue()) then
            gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
        end
    end
end

local function exploits_toggles()
    if rage_sw:GetValue() then
        if dt_toggle:GetValue() and hs_toggle:GetValue() then
            hs_toggle:SetValue(false)
            dt_toggle:SetValue(false)
        elseif dt_toggle:GetValue() and not hs_toggle:GetValue() then
            gui.SetValue("rbot.accuracy.attack.shared.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.zeus.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.pistol.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.hpistol.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.smg.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.rifle.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.shotgun.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.scout.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.asniper.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.sniper.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.lmg.fire", "Defensive Warp Fire")
            gui.SetValue("rbot.accuracy.attack.knife.fire", "Defensive Warp Fire")
        elseif not dt_toggle:GetValue() and hs_toggle:GetValue() then
            gui.SetValue("rbot.accuracy.attack.shared.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.zeus.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.pistol.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.hpistol.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.smg.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.rifle.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.shotgun.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.scout.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.asniper.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.sniper.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.lmg.fire", "Shift Fire")
            gui.SetValue("rbot.accuracy.attack.knife.fire", "Shift Fire")
        else
            gui.SetValue("rbot.accuracy.attack.shared.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.zeus.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.pistol.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.hpistol.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.smg.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.rifle.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.shotgun.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.scout.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.asniper.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.sniper.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.lmg.fire", "Off")
            gui.SetValue("rbot.accuracy.attack.knife.fire", "Off")
        end
    end
end

-- SEMI-RAGE
local function clamp() -- this won't allow user to set some things to minimize the chance of getting banned
    if semirage_sw:GetValue() then
        gui.SetValue("rbot.antiaim.base", 0)
        gui.SetValue("rbot.antiaim.condition.autodir.targets", 0)
        gui.SetValue("rbot.antiaim.advanced.pitch", 0)
        gui.SetValue("rbot.antiaim.advanced.antiresolver", 0)
        gui.SetValue("rbot.antiaim.extra.exposefake", 0)

        if not unsafe_sw:GetValue() then
            gui.SetValue("rbot.antiaim.condition.autodir.edges", 0)
            gui.SetValue("misc.antiuntrusted", 1)
            gui.SetValue("rbot.antiaim.advanced.roll", 0)
            desync_roll_slider:SetDisabled(true)
            semi_freestand_kb:SetDisabled(true)

            if gui.GetValue("rbot.aim.target.fov") > 30 then 
                gui.SetValue("rbot.aim.target.fov", 30)
            end
        else
            desync_roll_slider:SetDisabled(false)
            semi_freestand_kb:SetDisabled(false)
        end
    end
end

local function dynamicfov()
    if semirage_sw:GetValue() and dynamicfov_sw:GetValue() then
        if dynamicfov_min:GetValue() > dynamicfov_max:GetValue() then return end

        local localplayer = entities.GetLocalPlayer()

        if localplayer == nil or not localplayer:IsAlive() then return end

        local players = entities.FindByClass("CCSPlayer")
        local localplayer_head = localplayer:GetHitboxPosition(0)
        local distance_to_enemy = nil

        for i = 1, #players do
            local player = players[i]
            if player:IsAlive() then
                if player:GetTeamNumber() ~= localplayer:GetTeamNumber() then
                    local player_head = player:GetHitboxPosition(0)
                    distance_to_enemy = math.sqrt(math.pow((player_head.x - localplayer_head.x), 2) + 
                    math.pow((player_head.y - localplayer_head.y), 2) +
                    math.pow((player_head.z - localplayer_head.z), 2))
                end
            end
        end

        local fov = nil

        if distance_to_enemy == nil or distance_to_enemy > 1200 then 
            fov = dynamicfov_min:GetValue() 
        else
            fov = math.floor(math.min(dynamicfov_max:GetValue(), math.max(dynamicfov_min:GetValue(), 5000 / distance_to_enemy)))
        end

        gui.SetValue("rbot.aim.target.fov", fov)
    end
end

local function semi_aa(cmd)
    if semirage_sw:GetValue() then
        if semi_current_side ~= 1 then
            gui.SetValue("rbot.antiaim.base.rotation", (desync_left_slider:GetValue() * -1))
        else
            gui.SetValue("rbot.antiaim.base.rotation", desync_right_slider:GetValue())
        end

        if unsafe_sw:GetValue() then
            if desync_roll_slider:GetValue() > 0 then
                if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
                    cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, (desync_roll_slider:GetValue()*-1))
                elseif gui.GetValue("rbot.antiaim.base.rotation") < 0 then
                    cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, desync_roll_slider:GetValue())
                else
                    cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
                end
            else
                cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
            end
        end
    end
end

-- MISC/VISUALS
local screen_w, screen_h = draw.GetScreenSize()
local Font_undercross = draw.CreateFont("Verdana", 13, 700)
local font_undercross_items = draw.CreateFont("Verdana", 12, 700)

local function desync_arrows()
    local lp = entities.GetLocalPlayer()

    if lp == nil or not lp:IsAlive() then
        return
    end

    local fake_arrow_col_r, fake_arrow_col_g, fake_arrow_col_b, fake_arrow_col_a = fake_arrow_col:GetValue()
    local real_arrow_col_r, real_arrow_col_g, real_arrow_col_b, real_arrow_col_a = real_arrow_col:GetValue()

    if desync_arrows_cb:GetValue() then
        -- i dont know any better way to check that

        local str_table = {}
        for str in string.gmatch(gui.GetValue("rbot.antiaim.base"), "([^".."%s".."]+)") do 
            table.insert(str_table, str)
        end

        local base_yaw = str_table[1]:gsub("\"", "") -- doing anything yaw related in aimware is pain in the ass change my mind
        base_yaw = tonumber(base_yaw)

        --print(base_yaw)

        if base_yaw == 0 or legitaa_kb:GetValue() ~= 0 and input.IsButtonDown(legitaa_kb:GetValue()) then
            --left
            if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
                draw.Color(fake_arrow_col_r, fake_arrow_col_g, fake_arrow_col_b, fake_arrow_col_a)
                draw.Triangle(screen_w/2+140, screen_h/2, screen_w/2+120, screen_h/2+12, screen_w/2+120, screen_h/2-12)
                draw.Color(real_arrow_col_r, real_arrow_col_g, real_arrow_col_b, real_arrow_col_a)
                draw.Triangle(screen_w/2-140, screen_h/2, screen_w/2-120, screen_h/2-12, screen_w/2-120, screen_h/2+12)
            else --right
                draw.Color(fake_arrow_col_r, fake_arrow_col_g, fake_arrow_col_b, fake_arrow_col_a)
                draw.Triangle(screen_w/2-140, screen_h/2, screen_w/2-120, screen_h/2-12, screen_w/2-120, screen_h/2+12)
                draw.Color(real_arrow_col_r, real_arrow_col_g, real_arrow_col_b, real_arrow_col_a)
                draw.Triangle(screen_w/2+140, screen_h/2, screen_w/2+120, screen_h/2+12, screen_w/2+120, screen_h/2-12)
            end
        else
            --left
            if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
                draw.Color(fake_arrow_col_r, fake_arrow_col_g, fake_arrow_col_b, fake_arrow_col_a)
                draw.Triangle(screen_w/2-140, screen_h/2, screen_w/2-120, screen_h/2-12, screen_w/2-120, screen_h/2+12)
                draw.Color(real_arrow_col_r, real_arrow_col_g, real_arrow_col_b, real_arrow_col_a)
                draw.Triangle(screen_w/2+140, screen_h/2, screen_w/2+120, screen_h/2+12, screen_w/2+120, screen_h/2-12)
            else --right
                draw.Color(fake_arrow_col_r, fake_arrow_col_g, fake_arrow_col_b, fake_arrow_col_a)
                draw.Triangle(screen_w/2+140, screen_h/2, screen_w/2+120, screen_h/2+12, screen_w/2+120, screen_h/2-12)
                draw.Color(real_arrow_col_r, real_arrow_col_g, real_arrow_col_b, real_arrow_col_a)
                draw.Triangle(screen_w/2-140, screen_h/2, screen_w/2-120, screen_h/2-12, screen_w/2-120, screen_h/2+12)
            end
        end
    end
end

local function indicators()
    local localplayer = entities.GetLocalPlayer()

    if localplayer == nil or not localplayer:IsAlive() then
        return
    end

    localplayer_weaponid = localplayer:GetWeaponID()
    --print(localplayer:GetWeaponType())

    local isscoped = localplayer:GetPropBool("m_bIsScoped")
    local x_pos = 0

    if isscoped then
        x_pos = -38
    else
        x_pos = 0
    end


    local item_pos = {
        [1] = 35,
        [2] = 47,
        [3] = 59,
        [4] = 71,   
        [5] = 83,
        [6] = 95,
    }

    local item_idx = 0

    if misc_vis_indicators:GetValue() == 1 then
        draw.Color(indicator_col:GetValue())
        draw.SetFont(Font_undercross)

        draw.TextShadow(screen_w/2-26-x_pos,screen_h/2+23, "Absinthe")

        draw.Color(items_col:GetValue())
        draw.SetFont(font_undercross_items)

        if abfov_ind:GetValue() then
            item_idx = item_idx + 1
            local adjustment = nil

            local fov_text = "fov: " .. gui.GetValue("rbot.aim.target.fov")

            if fov_text:len() == 7 then
                adjustment = 4
            elseif fov_text:len() == 6 then
                adjustment = 6
            else
                adjustment = 0
            end

            draw.TextShadow((screen_w/2-26+fov_text:len()+adjustment)-x_pos,screen_h/2+item_pos[item_idx], fov_text)
        end
        
        if localplayer:GetWeaponType() ~= nil and localplayer:GetWeaponType() ~= 0 and localplayer:GetWeaponType() ~= 7 and localplayer:GetWeaponType() ~= 9 and localplayer:GetWeaponType() ~= 11 then
            if dmg_ind:GetValue() then
                item_idx = item_idx + 1
                local dmg_value = nil
                local dmg_text = nil

                dmg_value = gui.GetValue("rbot.hitscan.accuracy." .. weapons_list[localplayer_weaponid] .. ".mindamage")

                --[[if gui.GetValue("rbot.hitscan.accuracy." .. weapons_list[localplayer_weaponid] .. ".mindamagehp") == 0 then
                    dmg_text = "dmg: " .. dmg_value
                else
                    dmg_text = "dmg: " .. dmg_value .. "+" .. gui.GetValue("rbot.hitscan.accuracy." .. weapons_list[localplayer_weaponid] .. ".mindamagehp")
                end]]

                dmg_text = "dmg: " .. dmg_value

                local im_fucking_done = dmg_text:len()

                if dmg_text:len() > 8 then -- this is fucking retarded
                    im_fucking_done = -dmg_text:len() + 9
                elseif dmg_text:len() == 8 then
                    im_fucking_done = 4
                elseif dmg_text:len() == 7 then
                    im_fucking_done = 6
                elseif dmg_text:len() == 6 then
                    im_fucking_done = 10
                end
                
                draw.TextShadow((screen_w/2-26+im_fucking_done)-x_pos,screen_h/2+item_pos[item_idx], dmg_text)
            end

            if autowall_ind:GetValue() and gui.GetValue("rbot.hitscan.accuracy." .. weapons_list[localplayer_weaponid] .. ".autowall") then
                item_idx = item_idx + 1

                local aw_text = "autowall" -- i feel like its still a bit off
    
                draw.TextShadow((screen_w/2-26+aw_text:len()-2.5)-x_pos,screen_h/2+item_pos[item_idx], aw_text)
            end

            if dt_ind:GetValue() and string.match(gui.GetValue("rbot.accuracy.attack." .. weapons_list[localplayer_weaponid] .. ".fire"), "Defensive Warp Fire") then
                item_idx = item_idx + 1
                
                local dt_text = "doubletap"

                draw.TextShadow((screen_w/2-26+dt_text:len()-6)-x_pos,screen_h/2+item_pos[item_idx], dt_text)
            end
    
            if hs_ind:GetValue() and string.match(gui.GetValue("rbot.accuracy.attack." .. weapons_list[localplayer_weaponid] .. ".fire"), "Shift Fire") then
                item_idx = item_idx + 1

                local hs_text = "hideshots"
    
                draw.TextShadow((screen_w/2-26+hs_text:len()-5)-x_pos,screen_h/2+item_pos[item_idx], hs_text)
            end
        end
        
        if fd_ind:GetValue() and cheat.IsFakeDucking() then
            item_idx = item_idx + 1

            local fd_text = "fakeduck"

            draw.TextShadow((screen_w/2-26+fd_text:len()-2.5)-x_pos,screen_h/2+item_pos[item_idx], fd_text)
        end

        if dside_ind:GetValue() then
            item_idx = item_idx + 1

            local str_table = {}
            for str in string.gmatch(gui.GetValue("rbot.antiaim.base"), "([^".."%s".."]+)") do 
                table.insert(str_table, str)
            end
    
            local base_yaw = str_table[1]:gsub("\"", "") -- doing anything yaw related in aimware is pain in the ass change my mind
            base_yaw = tonumber(base_yaw)

            if base_yaw == 0 or legitaa_kb:GetValue() ~= 0 and input.IsButtonDown(legitaa_kb:GetValue()) then
                if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
                    draw.TextShadow((screen_w/2-26+17.5)-x_pos,screen_h/2+item_pos[item_idx], "Right")
                else
                    draw.TextShadow((screen_w/2-26+14.5)-x_pos,screen_h/2+item_pos[item_idx], "Left")
                end   
            else
                if gui.GetValue("rbot.antiaim.base.rotation") > 0 then
                    draw.TextShadow((screen_w/2-26+17.5)-x_pos,screen_h/2+item_pos[item_idx], "Left")
                else
                    draw.TextShadow((screen_w/2-26+14.5)-x_pos,screen_h/2+item_pos[item_idx], "Right")
                end   
            end
        end
        
    end
end

local function autobuy(event)
    if autobuy_sw:GetValue() then
        if event:GetName() == "round_prestart" then
            if autobuy_override_cb:GetValue() then
                -- primary override
                if primary_wep_or:GetValue() ~= 0 then
                    if primary_wep_or:GetValue() == 1 then
                        client.Command("buy awp", true)
                    elseif primary_wep_or:GetValue() == 2 then
                        client.Command("buy ssg08", true)
                    elseif primary_wep_or:GetValue() == 3 then -- this could be else but i made it elseif in case i would like to add more weapons to autobuy
                        client.Command("buy scar20", true)
                    end
                end
                -- secondary override
                if secondary_wep_or:GetValue() ~= 0 then
                    if secondary_wep_or:GetValue() == 1 then
                        client.Command("buy deagle", true)
                    elseif secondary_wep_or:GetValue() == 2 then
                        client.Command("buy fiveseven", true)
                    elseif secondary_wep_or:GetValue() == 3 then -- same here
                        client.Command("buy elite", true)
                    end
                end
                -- misc
                if kev_wep_or:GetValue() then
                    client.Command("buy vest; buy vesthelm", true)
                end

                if nade_wep_or:GetValue() then
                    client.Command("buy molotov; buy hegrenade; buy smokegrenade", true)
                end

                if def_wep_or:GetValue() then
                    client.Command("buy defuser", true)
                end

                if taser_wep_or:GetValue() then
                    client.Command("buy taser", true)
                end
            else
                -- primary
                if primary_wep:GetValue() ~= 0 then
                    if primary_wep:GetValue() == 1 then
                        client.Command("buy awp", true)
                    elseif primary_wep:GetValue() == 2 then
                        client.Command("buy ssg08", true)
                    elseif primary_wep:GetValue() == 3 then -- this could be else but i made it elseif in case i would like to add more weapons to autobuy
                        client.Command("buy scar20", true)
                    end
                end
                -- secondary
                if secondary_wep:GetValue() ~= 0 then
                    if secondary_wep:GetValue() == 1 then
                        client.Command("buy deagle", true)
                    elseif secondary_wep:GetValue() == 2 then
                        client.Command("buy fiveseven", true)
                    elseif secondary_wep:GetValue() == 3 then -- same here
                        client.Command("buy elite", true)
                    end
                end
                -- misc
                if kev_wep:GetValue() then
                    client.Command("buy vest; buy vesthelm", true)
                end

                if nade_wep:GetValue() then
                    client.Command("buy molotov; buy hegrenade; buy smokegrenade", true)
                end

                if def_wep:GetValue() then
                    client.Command("buy defuser", true)
                end

                if taser_wep:GetValue() then
                    client.Command("buy taser", true)
                end
            end
        end
    end
end

local last_target = nil
local head_pos_wts = { x = nil, y = nil }

local function target_snapline_get_target(target)
    if target:GetIndex() == nil then return end

    last_target = target:GetIndex()
end

local function target_snapline_draw() 
    if target_snap_cb:GetValue() then
        local localplayer = entities.GetLocalPlayer()
        if not localplayer or not localplayer:IsAlive() or last_target == nil then return end

        last_target_ent = entities.GetByIndex(last_target)

        if not last_target_ent:IsAlive() or last_target_ent:IsDormant() then --i like my bitches redbone, ass fat, jell-O
            last_target = nil
        end

        if not last_target_ent:IsAlive() then return end

        head_pos_wts.x, head_pos_wts.y = client.WorldToScreen(last_target_ent:GetHitboxPosition(0))
        
        if head_pos_wts.x == nil or head_pos_wts.y == nil then return end

        draw.Color(indicator_col:GetValue())
        draw.Line(screen_w/2, screen_h/2, math.floor(head_pos_wts.x), math.floor(head_pos_wts.y))
    end
end

local r8_backup_state = 0
local backup_r8 = {
    fakelag = nil,
    fakelatency = nil,
}

local function r8_dump_fix()
    local localplayer = entities.GetLocalPlayer()

    if localplayer == nil or not localplayer:IsAlive() then
        return
    end

    localplayer_weaponid = localplayer:GetWeaponID()


    if r8_fix:GetValue() then
        if localplayer_weaponid == 64 then
            if r8_backup_state ~= 1 then
                backup_r8.fakelag = gui.GetValue("misc.fakelag.enable")
                backup_r8.fakelatency = gui.GetValue("misc.fakelatency.enable")
    
                r8_backup_state = 1
            end

            gui.SetValue("misc.fakelag.enable", false)
            gui.SetValue("misc.fakelatency.enable", false)
            gui.SetValue("rbot.accuracy.attack.hpistol.fire", 0)
        else
            if backup_r8.fakelag == nil or backup_r8.fakelatency == nil then return end

            if r8_backup_state == 1 then
                gui.SetValue("misc.fakelag.enable", backup_r8.fakelag)
                gui.SetValue("misc.fakelatency.enable", backup_r8.fakelatency)

                r8_backup_state = 0
            end
        end
    end
end

local function aspecratio()
    if client.GetConVar("r_aspectratio") ~= aspectratio_slider:GetValue() then
        client.SetConVar("r_aspectratio", aspectratio_slider:GetValue())
    end
end

local function sw_checks()
    if rage_sw:GetValue() == true and semirage_sw:GetValue() == true then -- lol
        rage_sw:SetValue(false)
        semirage_sw:SetValue(false)
    end

    -- rage tab
    if rage_sw:GetValue() == true then
        cond_cb:SetDisabled(false)
        inverter_kb:SetDisabled(false)
        freestand_kb:SetDisabled(false)
        legitaa_kb:SetDisabled(false)
        desync_cb:SetDisabled(false)
        dt_toggle:SetDisabled(false)
        hs_toggle:SetDisabled(false)
        roll_res_ok:SetDisabled(false)
        base_yaw_stand:SetDisabled(false)
        base_yaw_walking:SetDisabled(false)
        base_yaw_slowwalking:SetDisabled(false)
        base_yaw_inair:SetDisabled(false)
        aa_mode_select_stand:SetDisabled(false)
        aa_mode_select_walk:SetDisabled(false)
        aa_mode_select_slowwalk:SetDisabled(false)
        aa_mode_select_inair:SetDisabled(false)
        aa_mode_angle_stand:SetDisabled(false)
        aa_mode_angle_walk:SetDisabled(false)
        aa_mode_angle_slowwalk:SetDisabled(false)
        aa_mode_angle_inair:SetDisabled(false)
        roll_on_stand:SetDisabled(false)
        roll_on_walk:SetDisabled(false)
        roll_on_slowwalk:SetDisabled(false)
        roll_in_air:SetDisabled(false)
        antibrute_mode:SetDisabled(false)
        antibrute_stage1:SetDisabled(false)
        antibrute_stage2:SetDisabled(false)
        antibrute_stage3:SetDisabled(false)
        antibrute_stage4:SetDisabled(false)
        antibrute_stage5:SetDisabled(false)
        lby_flick_sw:SetDisabled(false)
        lby_flick_angle:SetDisabled(false)
        lby_flick_freq:SetDisabled(false)
        enable_conditions_sw:SetDisabled(false)
        pitch_flick_sw:SetDisabled(false)
        pitch_flick_freq:SetDisabled(false)
        dmg_settings:SetDisabled(false)
        dmg_or:SetDisabled(false)
    else
        cond_cb:SetDisabled(true)
        inverter_kb:SetDisabled(true)
        freestand_kb:SetDisabled(true)
        legitaa_kb:SetDisabled(true)
        desync_cb:SetDisabled(true)
        dt_toggle:SetDisabled(true)
        hs_toggle:SetDisabled(true)
        roll_res_ok:SetDisabled(true)
        base_yaw_stand:SetDisabled(true)
        base_yaw_walking:SetDisabled(true)
        base_yaw_slowwalking:SetDisabled(true)
        base_yaw_inair:SetDisabled(true)
        aa_mode_select_stand:SetDisabled(true)
        aa_mode_select_walk:SetDisabled(true)
        aa_mode_select_slowwalk:SetDisabled(true)
        aa_mode_select_inair:SetDisabled(true)
        aa_mode_angle_stand:SetDisabled(true)
        aa_mode_angle_walk:SetDisabled(true)
        aa_mode_angle_slowwalk:SetDisabled(true)
        aa_mode_angle_inair:SetDisabled(true)
        roll_on_stand:SetDisabled(true)
        roll_on_walk:SetDisabled(true)
        roll_on_slowwalk:SetDisabled(true)
        roll_in_air:SetDisabled(true)
        antibrute_mode:SetDisabled(true)
        antibrute_stage1:SetDisabled(true)
        antibrute_stage2:SetDisabled(true)
        antibrute_stage3:SetDisabled(true)
        antibrute_stage4:SetDisabled(true)
        antibrute_stage5:SetDisabled(true)
        lby_flick_sw:SetDisabled(true)
        lby_flick_angle:SetDisabled(true)
        lby_flick_freq:SetDisabled(true)
        enable_conditions_sw:SetDisabled(true)
        pitch_flick_sw:SetDisabled(true)
        pitch_flick_freq:SetDisabled(true)
        dmg_settings:SetDisabled(true)
        dmg_or:SetDisabled(true)
    end

    if lby_flick_sw:GetValue() then
        lby_flick_angle:SetInvisible(false)
        lby_flick_freq:SetInvisible(false)
    else
        lby_flick_angle:SetInvisible(true)
        lby_flick_freq:SetInvisible(true)
    end

    if pitch_flick_sw:GetValue() then
        pitch_flick_freq:SetInvisible(false)
    else
        pitch_flick_freq:SetInvisible(true)
    end

    if enable_conditions_sw:GetValue() then
        cond_cb:SetInvisible(false)
    else
        cond_cb:SetInvisible(true)
    end

    -- semirage tab
    if semirage_sw:GetValue() == true then
        unsafe_sw:SetDisabled(false)
        unsafe_txt:SetDisabled(false)

        dynamicfov_sw:SetDisabled(false)
        dynamicfov_min:SetDisabled(false)
        dynamicfov_max:SetDisabled(false)

        dmg_semi_or:SetDisabled(false)
        dmg_settings_semi:SetDisabled(false)

        legit_inverter_kb:SetDisabled(false)
        desync_left_slider:SetDisabled(false)
        desync_right_slider:SetDisabled(false)
        desync_roll_slider:SetDisabled(false)
        semi_freestand_kb:SetDisabled(false)
        antibrute_semi_btn:SetDisabled(false)
    else
        unsafe_sw:SetDisabled(true)
        unsafe_txt:SetDisabled(true)

        dynamicfov_sw:SetDisabled(true)
        dynamicfov_min:SetDisabled(true)
        dynamicfov_max:SetDisabled(true)

        dmg_semi_or:SetDisabled(true)
        dmg_settings_semi:SetDisabled(true)

        legit_inverter_kb:SetDisabled(true)
        desync_left_slider:SetDisabled(true)
        desync_right_slider:SetDisabled(true)
        desync_roll_slider:SetDisabled(true)
        semi_freestand_kb:SetDisabled(true)
        antibrute_semi_btn:SetDisabled(true)
    end

    if dynamicfov_sw:GetValue() then
        dynamicfov_max:SetInvisible(false)
        dynamicfov_min:SetInvisible(false)
    else
        dynamicfov_max:SetInvisible(true)
        dynamicfov_min:SetInvisible(true)
    end

    --shared features
    if semirage_sw:GetValue() or rage_sw:GetValue() then
        --PASS
    else
        dmg_settings_wnd:SetActive(false)
    end

end

local function windows_handler()
    local cheat_menu = gui.Reference("Menu")
    if not cheat_menu:IsActive() then
        dmg_settings_wnd:SetActive(false)
        autobuy_wnd:SetActive(false)
    end
end

-- resets
--[[local backup_reset = gui.Button(misc_gb, "Reset backup states", function() 
    legitaa_kb:SetValue(0)
    r8_fix:SetValue(false)

    legitaa_backup_state = 0
    r8_backup_state = 0

    backup_legitaa.pitch = nil
    backup_legitaa.targets = nil

    backup_r8.fakelag = nil
    backup_r8.fakelatency = nil

    print("reset successful, you can now re-enable your functions or reload your config")
end) backup_reset:SetWidth(168)]]

client.AllowListener("bullet_impact")
callbacks.Register("FireGameEvent", anti_brute)

client.AllowListener("round_prestart")
callbacks.Register("FireGameEvent", autobuy)

callbacks.Register("AimbotTarget", target_snapline_get_target)

callbacks.Register("Draw", function() 
    -- ui elements and checks
    windows_handler()
    or_check()
    sw_checks()
    cond_ui()

    -- visuals
    target_snapline_draw() 
    desync_arrows()
    indicators() 

    -- misc functions
    r8_dump_fix()
    aspecratio()
    
    -- rage/semi-rage functions
    dmg_override()
    desync_inverter()
    freestand()
    exploits_toggles()
    resolver_override()
    legit_aa_on_hold()
    desync_jitter()
    dynamicfov()
    clamp()
end)

callbacks.Register("CreateMove", function(cmd) 
    --rage
    rage_aa()
    lby_flick()
    pitch_flick(cmd)

    --semi
    semi_aa(cmd)
end)


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")