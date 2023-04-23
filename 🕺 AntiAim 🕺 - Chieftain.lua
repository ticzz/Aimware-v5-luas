--[[--------------------------------------Credits---------------------------------------------------

                                Chieftain made by GLadiator                                       

  Also, a special big thanks to all the people below, without them many functions would not exist:
            Chicken4676 and John.k for visible check and velocity prediction for this             
                  2878713023 for Drag, pos.save, GradientRectV and GradientRectH                  
                      Sestain for making it clear how to do the "idealtick"                         
                                  filka_nv for freestanding fix                                     
                                   daerisgay for aspect ratio                                       
                                    Clipper for LC indicator                                        

------------------------------------------Credits-----------------------------------------------]]--

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local math_floor, math_random, math_sqrt, string_lower, string_format
=
      math.floor, math.random, math.sqrt, string.lower, string.format
;

local draw_SetFont, draw_GetScreenSize, draw_GetTextSize, draw_Color, draw_Text, draw_TextShadow, draw_Line, draw_CreateTexture, draw_SetTexture, draw_FilledRect, common_RasterizeSVG
= 
      draw.SetFont, draw.GetScreenSize, draw.GetTextSize, draw.Color, draw.Text, draw.TextShadow, draw.Line, draw.CreateTexture, draw.SetTexture, draw.FilledRect, common.RasterizeSVG
; 

local entities_GetLocalPlayer, entities_FindByClass, entities_GetPlayerResources, client_GetConVar, client_WorldToScreen, globals_CurTime, globals_RealTime, vector_Multiply, vector_Subtract, vector_Add
=
      entities.GetLocalPlayer, entities.FindByClass, entities.GetPlayerResources, client.GetConVar, client.WorldToScreen, globals.CurTime, globals.RealTime, vector.Multiply, vector.Subtract, vector.Add
;

local engine_TraceLine, engine_GetServerIP
=
      engine.TraceLine, engine.GetServerIP
;

local input_IsButtonDown, input_IsButtonPressed, input_IsButtonReleased, input_GetMousePos
=
      input.IsButtonDown, input.IsButtonPressed, input.IsButtonReleased, input.GetMousePos
;

local gui_GetValue, gui_SetValue, gui_Reference, client_GetConVar, client_SetConVar, client_Command
=
      gui.GetValue, gui.SetValue, gui.Reference, client.GetConVar, client.SetConVar, client.Command
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Per Group Elements API made by GLadiator with help from "lennonc1atwit - Per Weapon Gui API" --
local WEAPONID_PISTOLS          = { 2, 3, 4, 30, 32, 36, 61, 63 }
local WEAPONID_HEAVYPISTOLS     = { 1, 64 }
local WEAPONID_SUBMACHINEGUNS   = { 17, 19, 23, 24, 26, 33, 34 }
local WEAPONID_RIFLES           = { 7, 8, 10, 13, 16, 39, 60 }
local WEAPONID_SHOTGUNS         = { 25, 27, 29, 35 }
local WEAPONID_SCOUT            = { 40 }
local WEAPONID_AUTOSNIPERS      = { 11, 38 }
local WEAPONID_SNIPER           = { 9 }
local WEAPONID_LIGHTMACHINEGUNS = { 14, 28 }
local WEAPONID_KNIFES           = { 41, 42, 59, 69, 74, 75, 76, 78, 500, 503, 505, 506, 507, 508, 509, 512, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 525 }
local WEAPONID_ALLWEAPONS       = { WEAPONID_PISTOLS, WEAPONID_HEAVYPISTOLS, WEAPONID_SUBMACHINEGUNS, WEAPONID_RIFLES, WEAPONID_SHOTGUNS, WEAPONID_SCOUT, WEAPONID_AUTOSNIPERS, WEAPONID_SNIPER, WEAPONID_LIGHTMACHINEGUNS, WEAPONID_KNIFES }
local WEAPON_GROUPS_NAME        = { 'PISTOL', 'HPISTOL', 'SMG', 'RIFLE', 'SHOTGUN', 'SCOUT', 'ASNIPER', 'SNIPER', 'LMG', 'KNIFE' }
local WEAPON_CURRENT_GROUP      = 'GLOBAL'
local PERGROUP_ELEMENTS         = {}

local function lp_weapon_id(WEAPONID)
    for k, v in pairs(WEAPONID) do
        if entities_GetLocalPlayer():GetWeaponID() == WEAPONID[k] then
            return true
        end
    end
end

local function gui_Checkbox(PARENT, VARNAME, NAME, DESCRIPTION, VALUE)
    local ID = #PERGROUP_ELEMENTS + 1
    PERGROUP_ELEMENTS[ID] = {}

    for k, v in pairs(WEAPON_GROUPS_NAME) do
        local WEAPON = string_lower(WEAPON_GROUPS_NAME[k])
        local temp

        if type(PARENT) == 'userdata' then
            temp = gui.Checkbox(PARENT, WEAPON..'.'..VARNAME, NAME, VALUE)
            PERGROUP_ELEMENTS[ID][WEAPON_GROUPS_NAME[k]] = {temp, PARENT}
        else
            temp = gui.Checkbox(PARENT[WEAPON_GROUPS_NAME[k]][1], WEAPON..'.'..VARNAME, NAME, VALUE)
            PERGROUP_ELEMENTS[ID][WEAPON_GROUPS_NAME[k]] = {temp, PARENT[WEAPON_GROUPS_NAME[k]][2]}
        end

        temp:SetDescription(DESCRIPTION)
    end
    return PERGROUP_ELEMENTS[ID]
end
local function gui_Slider(PARENT, VARNAME, NAME, DESCRIPTION, VALUE, MIN, MAX, STEP)
    local ID = #PERGROUP_ELEMENTS + 1
    PERGROUP_ELEMENTS[ID] = {}

    for k, v in pairs(WEAPON_GROUPS_NAME) do
        local WEAPON = string_lower(WEAPON_GROUPS_NAME[k])

        local temp = gui.Slider(PARENT, WEAPON..'.'..VARNAME, NAME, VALUE, MIN, MAX, STEP)
        PERGROUP_ELEMENTS[ID][WEAPON_GROUPS_NAME[k]] = {temp, PARENT}

        temp:SetDescription(DESCRIPTION)
    end
    return PERGROUP_ELEMENTS[ID]
end
local function gui_Combobox(PARENT, VARNAME, NAME, DESCRIPTION, ...)
    local ID = #PERGROUP_ELEMENTS + 1
    PERGROUP_ELEMENTS[ID] = {}

    for k, v in pairs(WEAPON_GROUPS_NAME) do
        local WEAPON = string_lower(WEAPON_GROUPS_NAME[k])

        local temp = gui.Combobox(PARENT, WEAPON..'.'..VARNAME, NAME, ...)
        PERGROUP_ELEMENTS[ID][WEAPON_GROUPS_NAME[k]] = {temp, PARENT}

        temp:SetDescription(DESCRIPTION)
    end
    return PERGROUP_ELEMENTS[ID]
end
local function gui_Multibox(PARENT, NAME, DESCRIPTION)
    local ID = #PERGROUP_ELEMENTS + 1
    PERGROUP_ELEMENTS[ID] = {}

    for k, v in pairs(WEAPON_GROUPS_NAME) do
        local WEAPON = string_lower(WEAPON_GROUPS_NAME[k])

        local temp = gui.Multibox(PARENT, NAME)
        PERGROUP_ELEMENTS[ID][WEAPON_GROUPS_NAME[k]] = {temp, PARENT}

        temp:SetDescription(DESCRIPTION)
    end
    return PERGROUP_ELEMENTS[ID]
end
-- Per Group Elements API made by GLadiator with help from "lennonc1atwit - Per Weapon Gui API" --

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CHIEFTAIN_TAB                                     = gui.Tab(gui_Reference('Ragebot'), 'chieftain', '☭ Chieftain ➤')

local CHIEFTAIN_SUBTAB_WEAPONSELECTION                  = gui.Groupbox(CHIEFTAIN_TAB, 'Selected group', 16, 16, 296, 1)
local CHIEFTAIN_CURRENT_WEAPON                          = gui.Text(CHIEFTAIN_SUBTAB_WEAPONSELECTION, 'Current weapon group: global')
local CHIEFTAIN_NOT_SUPPORT_GROUP                       = gui.Text(CHIEFTAIN_TAB, 'This weapon group is not supported!')
CHIEFTAIN_NOT_SUPPORT_GROUP:SetPosX(382)
CHIEFTAIN_NOT_SUPPORT_GROUP:SetPosY(50)

local CHIEFTAIN_SUBTAB_MISC                             = gui.Groupbox(CHIEFTAIN_TAB, 'Fakelags & Fakeduck', 16, 109, 296, 1)
local CHIEFTAIN_MISC_FAKELAGS_TYPE                      = gui.Combobox(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelags.type', 'Fakelags type', 'Normal', 'Adaptive', 'Custom')
local CHIEFTAIN_MISC_FAKELAGS_JITTER                    = gui.Slider(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelags.jitter', 'Jitter factor', 0, 0, 3)
local CHIEFTAIN_MISC_FAKELAGS_CUSTOM_TYPE               = gui.Combobox(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelags.custom.type', 'Fakelags pattern', 'Normal', 'Adaptive', 'Switch')
local CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MIN         = gui.Slider(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelags.custom.factor.min', 'Factor minimum', 16, 3, 61)
local CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MAX         = gui.Slider(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelags.custom.factor.max', 'Factor maximum', 16, 3, 61)
local CHIEFTAIN_MISC_FAKEDUCK_SPEED                     = gui.Combobox(CHIEFTAIN_SUBTAB_MISC, 'misc.fakeduck.speed', 'Fakeduck factor', 'Automatic', 'Max Process Ticks - 2', 'Max Process Ticks - 1', 'Max Process Ticks', 'Max Process Ticks + 1', 'Custom')
local CHIEFTAIN_MISC_FAKEDUCK_SPEED_ADJUSTER            = gui.Slider(CHIEFTAIN_SUBTAB_MISC, 'misc.fakeduck.speed.adjuster', 'Fakeduck factor adjuster', 16, 3, 61)
local CHIEFTAIN_MISC_FAKELATENCY                        = gui.Combobox(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelatency', 'Fakelatency', 'Off', 'Low', 'Medium', 'High', 'Maximum', 'Custom')
local CHIEFTAIN_MISC_FAKELATENCY_ADJUSTER               = gui.Slider(CHIEFTAIN_SUBTAB_MISC, 'misc.fakelatency.adjuster', 'Fakelatency adjuster', 200, 0, 1000, 5)

local CHIEFTAIN_SUBTAB_VISUALS                          = gui.Groupbox(CHIEFTAIN_TAB, 'Visuals', 16, 550, 296, 1)
local CHIEFTAIN_VISUALS_WPNINFO                         = gui.Multibox(CHIEFTAIN_SUBTAB_VISUALS, 'Weapon info')
local CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON             = gui.Checkbox(CHIEFTAIN_VISUALS_WPNINFO, 'visuals.wpninfo.firstperson', 'First person', false)
local CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON             = gui.Checkbox(CHIEFTAIN_VISUALS_WPNINFO, 'visuals.wpninfo.thirdperson', 'Third person', false)
local CHIEFTAIN_VISUALS_WPNINFO_RAINBOW                 = gui.Checkbox(CHIEFTAIN_VISUALS_WPNINFO, 'visuals.wpninfo.rainbow', 'LGBTQ+ Mode', false)
local CHIEFTAIN_VISUALS_WPNINFO_BACKGROUND_CLR          = gui.ColorPicker(CHIEFTAIN_VISUALS_WPNINFO_RAINBOW, 'visuals.wpninfo.backgroundclr', 'Background firstperson color', 0, 0, 0, 70)
local CHIEFTAIN_VISUALS_WPNINFO_GENERAL_CLR             = gui.ColorPicker(CHIEFTAIN_VISUALS_WPNINFO_RAINBOW, 'visuals.wpninfo.generalclr', 'General firstperson color', 255, 255, 255, 255)
local CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR        = gui.ColorPicker(CHIEFTAIN_VISUALS_WPNINFO_RAINBOW, 'visuals.wpninfo.warninggreenclr', 'Warning green firstperson color', 0, 255, 0, 255)
local CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR          = gui.ColorPicker(CHIEFTAIN_VISUALS_WPNINFO_RAINBOW, 'visuals.wpninfo.warningredclr', 'Warning red firstperson color', 255, 0, 0, 255)
local CHIEFTAIN_VISUALS_WPNINFO_WARNINGYELLOW_CLR       = gui.ColorPicker(CHIEFTAIN_VISUALS_WPNINFO_RAINBOW, 'visuals.wpninfo.warningyellowclr', 'Warning yellow thirdperson color', 255, 255, 0, 255)
local CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS         = gui.Combobox(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.wpninfo.thirdperson.pos', 'Third person position', 'Weapon', 'Body')
local CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_X           = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.wpninfo.firsperson.x', 'x', 500, 0, 10000, 1)
local CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_Y           = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.wpninfo.firsperson.y', 'y', 300, 0, 10000, 1)
CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_X:SetInvisible(true)
CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_Y:SetInvisible(true)
local CHIEFTAIN_VISUALS_FPSBOOST                        = gui.Multibox(CHIEFTAIN_SUBTAB_VISUALS, 'Graphic options')
local CHIEFTAIN_VISUALS_FPSBOOST_SHADOWS                = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.disshadows', 'Disable shadows', false)
local CHIEFTAIN_VISUALS_FPSBOOST_3DSKY                  = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.dis3dsky', 'Disable 3D sky', false)
local CHIEFTAIN_VISUALS_FPSBOOST_FOG                    = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.diswaterskyfog', 'Disable water and sky fog', false)
local CHIEFTAIN_VISUALS_FPSBOOST_BLOOM                  = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.disbloom', 'Disable bloom', false)
local CHIEFTAIN_VISUALS_FPSBOOST_BLUR                   = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.disblur', 'Disable panorama blur and shadow', false)
local CHIEFTAIN_VISUALS_FPSBOOST_OTHER                  = gui.Checkbox(CHIEFTAIN_VISUALS_FPSBOOST, 'visuals.fpsboost.disother', 'Disable other shit', false)
local CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE               = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.aspectratio', 'Aspect ratio', 100, 70, 130, 5)
local CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE             = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.worldexposure', 'World exposure', 0, 0, 100, 5)
local CHIEFTAIN_VISUALS_BLOOM_VALUE                     = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.bloom', 'Bloom', 0, 0, 100, 5)
local CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE          = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.modelsambient', 'Models ambient light', 0, 0, 100, 5)
local CHIEFTAIN_VISUALS_WORLDAMBIENT_VALUE              = gui.ColorPicker(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.ambient', 'World ambient light', 0, 0, 0)
local CHIEFTAIN_VISUALS_FOG_MODULATION                  = gui.Checkbox(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.fogmodul', 'Fog modulation', false)
local CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR            = gui.ColorPicker(CHIEFTAIN_VISUALS_FOG_MODULATION, 'visuals.fogmodul.color', 'Fog modulation color', 255, 255, 255, 255)
local CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY          = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.fogmodul.density', 'Fog density', 50, 0, 100, 1)
local CHIEFTAIN_VISUALS_FOG_MODULATION_START            = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.fogmodul.startdis', 'Fog start distance', 1000, 0, 5000, 50)
local CHIEFTAIN_VISUALS_FOG_MODULATION_END              = gui.Slider(CHIEFTAIN_SUBTAB_VISUALS, 'visuals.fogmodul.enddis', 'Fog end distance', 5000, 0, 5000, 50)

local CHIEFTAIN_SUBTAB_DOUBLEFIRE                       = gui.Groupbox(CHIEFTAIN_TAB, 'Double fire', 328, 16, 296, 1)
local CHIEFTAIN_DOUBLEFIRE_ENABLE                       = gui.Checkbox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.enable', 'Enable', false)
local CHIEFTAIN_DOUBLEFIRE_MODE                         = gui_Combobox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.mode', 'Mode', 'Select the desired double fire mode.', 'None', 'Defensive (more efficient)', 'Offensive')
local CHIEFTAIN_DOUBLEFIRE_PERF                         = gui_Multibox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'Performance options', 'Using performance options increase double fire efficiency.')
local CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY                  = gui_Checkbox(CHIEFTAIN_DOUBLEFIRE_PERF, 'doublefire.perf.dislby', 'Disable LBY', 'Disabling LBY greatly improves double fire efficiency.', false)
local CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM              = gui.Combobox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.chargingtype', 'Gradual charging system', 'Off', 'On')
local CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY        = gui.Slider(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.charging.delay', 'Delay before the control charge', 500, 100, 3000, 50)
local CHIEFTAIN_DOUBLEFIRE_TICKBASE                     = gui_Combobox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.tickbase', 'Tickbase shifting', 'Select how much to shifting tickbase, or leave automatic.', 'Depending on the ping', 'Max Process Ticks - 2', 'Max Process Ticks - 1', 'Max Process Ticks', 'Max Process Ticks + 1', 'Custom')
local CHIEFTAIN_DOUBLEFIRE_TICKBASE_ADJUSTER            = gui_Slider(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.tickbase.adjuster', 'Tickbase adjuster', 'Shifting bigger than Max Process Ticks can be unstable. ', 16, 3, 24, 1)
local CHIEFTAIN_DOUBLEFIRE_FAKELATENCY                  = gui_Combobox(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.fakelatency', 'Fakelatency', 'Using fakelatency makes the backtrack of enemies longer.', 'Off', 'Low', 'Medium', 'High', 'Maximum', 'Custom')
local CHIEFTAIN_DOUBLEFIRE_FAKELATENCY_ADJUSTER         = gui_Slider(CHIEFTAIN_SUBTAB_DOUBLEFIRE, 'doublefire.fakelatency.adjuster', 'Fakelatency adjuster', 'By default, servers only support up to 200ms.', 200, 0, 1000, 5)

local CHIEFTAIN_SUBTAB_AUTOPEEK                         = gui.Groupbox(CHIEFTAIN_TAB, 'Autopeek settings', 328, 850, 296, 1)
local CHIEFTAIN_AUTOPEEK_SETTINGS_ENABLE                = gui.Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.enable', 'Enable', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE            = gui_Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.doublefire', 'Double fire', 'Always uses double fire when autopeek is active.', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE_ADAPTIVE   = gui_Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.doublefire.adaptive', 'Automatic tickbase shifting', 'Shifting optimal double fire tickbase during autopeek.', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING          = gui_Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.freestanding', 'Freestanding', 'Freestanding for a safer peek with autopeek.', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING_FIX      = gui_Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.freestanding.fixer', 'Freestanding correсtion', 'Disables if you completely peek the enemy.', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE        = gui_Checkbox(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.mindamage', 'Damage override', 'Sets your damage value when autopeek is active.', false)
local CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE  = gui_Slider(CHIEFTAIN_SUBTAB_AUTOPEEK, 'autopeek.mindamage.value', 'Damage value', 'Minimum damage required after wall penetration.', 50, 1, 100, 1)

local CHIEFTAIN_SUBTAB_NOSCOPEHC                        = gui.Groupbox(CHIEFTAIN_TAB, 'Noscope/Scope Hitchance', 328, 600, 296, 1)
local CHIEFTAIN_NOSCOPEHC_ENABLE                        = gui_Checkbox(CHIEFTAIN_SUBTAB_NOSCOPEHC, 'noscopehc.enable', 'Enable', 'Use if you want to shoot without scoping.', false)
local CHIEFTAIN_NOSCOPEHC_REGULAR_SCOPE                 = gui_Slider(CHIEFTAIN_SUBTAB_NOSCOPEHC, 'noscopehc.regularhc.scoped', 'Scope hit chance', 'Minimum chance to hit while scoping.', 50, 1, 100, 1)
local CHIEFTAIN_NOSCOPEHC_DF_SCOPE                      = gui_Slider(CHIEFTAIN_SUBTAB_NOSCOPEHC, 'noscopehc.dfhc.scoped', 'Scope double fire hit chance', 'Minimum double fire chance to hit while scoping.', 50, 1, 100, 1)
local CHIEFTAIN_NOSCOPEHC_REGULAR_NOSCOPE               = gui_Slider(CHIEFTAIN_SUBTAB_NOSCOPEHC, 'noscopehc.regularhc.noscoped', 'Noscope hit chance', 'Minimum chance to hit whitout scoping.', 50, 1, 100, 1)
local CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE                    = gui_Slider(CHIEFTAIN_SUBTAB_NOSCOPEHC, 'noscopehc.dfhc.noscoped', 'Noscope double fire hit chance', 'Minimum double fire chance to hit whithout scoping.', 50, 1, 100, 1)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CHIEFTAIN_MISC_FAKELAGS_TYPE:SetDescription('Factor of fakelags is automatic, except for custom mode.')
CHIEFTAIN_MISC_FAKELAGS_JITTER:SetDescription('You can add jitter to the fakelags as desired.')
CHIEFTAIN_MISC_FAKELAGS_CUSTOM_TYPE:SetDescription('Choose your preferred fakelag type.')
CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MIN:SetDescription('How many minimum fakelags ticks will be choked.')
CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MAX:SetDescription('How many maximum fakelags ticks will be choked.')
CHIEFTAIN_MISC_FAKELATENCY:SetDescription('Using fakelatency makes the backtrack of enemies longer.')
CHIEFTAIN_MISC_FAKELATENCY_ADJUSTER:SetDescription('By default, servers only support up to 200ms.')
CHIEFTAIN_MISC_FAKEDUCK_SPEED:SetDescription('Affects height, speed, and shooting accuracy.')
CHIEFTAIN_MISC_FAKEDUCK_SPEED_ADJUSTER:SetDescription('How many fakeduck ticks will be choked.')
CHIEFTAIN_VISUALS_WPNINFO:SetDescription('Displays information about weapon and anti-aims.')
CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON:SetDescription('Displays weapon info in first person view.')
CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON:SetDescription('Displays weapon info in third person view.')
CHIEFTAIN_VISUALS_WPNINFO_RAINBOW:SetDescription('Turns on the fagot colors mode.')
CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS:SetDescription('Select the position where the weapon info will be located.')
CHIEFTAIN_VISUALS_FPSBOOST:SetDescription('Disabling some graphical elements increases FPS.')
CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE:SetDescription('Expanding or narrowing the play space.')
CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:SetDescription('Exposure, or simply the most correct night mode.')
CHIEFTAIN_VISUALS_BLOOM_VALUE:SetDescription('Increases and blurs the lighting. Requires post-processing.')
CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE:SetDescription('Increases the brightness of the player models.')
CHIEFTAIN_VISUALS_FOG_MODULATION:SetDescription('Simple fog customization. Requires to disable "No Fog".')
CHIEFTAIN_DOUBLEFIRE_ENABLE:SetDescription('Bind this to turn double fire on and off by key.')
CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:SetDescription('This is not a fast charge, but it makes it more measured.')
CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY:SetDescription('The delay before the main charge (in milliseconds).')
CHIEFTAIN_AUTOPEEK_SETTINGS_ENABLE:SetDescription('Use if you want to use fewer binds with autopeek.')

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Per Group Elements API made by GLadiator with help from "lennonc1atwit - Per Weapon Gui API" --
callbacks.Register("Draw", 'guiEndSetup', function(guiEndSetup)
    --Set to 0 if you don't want to display the current weapon group. 
    local PARENT = CHIEFTAIN_CURRENT_WEAPON
    local TEXT = 'Current weapon group: '

    --If we are not on the server or not alive, then we cannot access the local player, therefore, it remains only to hide all the elements until we have gained access to the local player.
    if entities_GetLocalPlayer() then
        if not entities_GetLocalPlayer():IsAlive() then
            for ID, group in pairs(PERGROUP_ELEMENTS) do
                for key, element in pairs(group) do
                    element[1]:SetInvisible(true)
                    if PARENT ~= 0 then 
                        PARENT:SetText(TEXT .. 'global')
                    end
                end
            end
            return
        end
    else
        for ID, group in pairs(PERGROUP_ELEMENTS) do
            for key, element in pairs(group) do
                element[1]:SetInvisible(true)
                if PARENT ~= 0 then 
                    PARENT:SetText(TEXT .. 'global')
                end
            end
        end
        return
    end

    --Iterate through all weapon groups.
    for k, v in pairs(WEAPON_GROUPS_NAME) do
        --If the ID of the current weapon is not equal to one of the ID table, then set the 'global' group in the menu.
        if not lp_weapon_id(WEAPONID_ALLWEAPONS) then
            WEAPON_CURRENT_GROUP = 'GLOBAL'
            if PARENT ~= 0 then 
                PARENT:SetText(TEXT .. 'global')
            end
        end
        --Iterate through all weapons id
        for k, v in pairs(WEAPONID_ALLWEAPONS) do
            --If the current weapon ID matches the key from all weapon IDs, then save the current weapon group from the key of all group names.
            if lp_weapon_id(WEAPONID_ALLWEAPONS[k]) then
                WEAPON_CURRENT_GROUP = WEAPON_GROUPS_NAME[k]
                if PARENT ~= 0 and TEXT ~= 0 then 
                    PARENT:SetText(TEXT .. string_lower(WEAPON_GROUPS_NAME[k]))
                end
            end
        end
    end
    
    if gui_Reference("Menu"):IsActive() then
        --Iterate through groups of installed elements.
        for ID, group in pairs(PERGROUP_ELEMENTS) do
            --Iterate through the element group table.
            for key, element in pairs(group) do
                --If the key(name of the weapon element) matches the current group of weapons, then set the display of the element, otherwise invisible.
                if key == WEAPON_CURRENT_GROUP then
                    element[1]:SetInvisible(false)
                else 
                    element[1]:SetInvisible(true)
                end
            end
        end
    end
end)
        
callbacks.Register("Unload", function(guiEndScene)
    for ID, group in pairs(PERGROUP_ELEMENTS) do 
        for key, element in pairs(group) do
           element[1]:Remove()
        end
    end
end)
-- Per Group Elements API made by GLadiator with help from "lennonc1atwit - Per Weapon Gui API" --

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local OLD_CURTIME = globals_CurTime()

local DT_ENABLED = nil
local FD_ENABLED = nil
local DT_TICKS = 0
local DT_SPEED = '0'
local SHIFTED_TICKS = 0

local originRecords = {}

local SV_MAXUSRCMDPROCESSTICKS = gui_Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks')

local function to_int(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

local function is_inside(vec_x, vec_y, x, y, w, h)
    return vec_x >= x and vec_x <= w and vec_y >= y and vec_y <= h
end

local weaponinfo_pos_x, weaponinfo_pos_y, weaponinfo_offset_x, weaponinfo_offset_y, weaponinfo_drag
local function drag_indicator(x, y, w, h)
    if not gui_Reference('Menu'):IsActive() then
        return weaponinfo_pos_x, weaponinfo_pos_y
    end
    local mouse_down = input_IsButtonDown(1)
    if mouse_down then
        local mouse_x, mouse_y = input_GetMousePos()
        if not weaponinfo_drag then
            local w, h = x + w, y + h
            if is_inside(mouse_x, mouse_y, x, y, w, h) then
                weaponinfo_offset_x = mouse_x - x
                weaponinfo_offset_y = mouse_y - y
                weaponinfo_drag = true
            end
        else
            weaponinfo_pos_x = mouse_x - weaponinfo_offset_x
            weaponinfo_pos_y = mouse_y - weaponinfo_offset_y
            CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_X:SetValue(weaponinfo_pos_x)
            CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_Y:SetValue(weaponinfo_pos_y)
        end
    else
        weaponinfo_drag = false
    end
    return weaponinfo_pos_x, weaponinfo_pos_y
end

local function position_save()
    if weaponinfo_pos_x ~= CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_X:GetValue() or weaponinfo_pos_y ~= CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_Y:GetValue() then
        weaponinfo_pos_x = CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_X:GetValue()
        weaponinfo_pos_y = CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON_Y:GetValue()
    end
end

local function HSVtoRGB(h, s, v, a)
    local r, g, b
  
    local i = math_floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
  
    i = i % 6
  
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
  
    return r * 255, g * 255, b * 255, a * 255
end

local function draw_TextOutlined(x, y, text, color, font)
    draw_SetFont(font)
    draw_Color(0, 0, 0, 255)

    draw_Text(x - 1, y - 1, text)
    draw_Text(x - 1, y, text)

    draw_Text(x - 1, y + 1, text)
    draw_Text(x, y + 1, text)

    draw_Text(x, y - 1, text)
    draw_Text(x + 1, y - 1, text)

    draw_Text(x + 1, y, text)
    draw_Text(x + 1, y + 1, text)

    draw_Color(color[1], color[2], color[3], color[4])

    draw_Text(x, y, text)
end

local gradient_texture_b = draw_CreateTexture(common_RasterizeSVG([[<defs><linearGradient id="c" x1="0%" y1="100%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#c)" /></svg>]]))
local function draw_GradientRectV(x1, y1, x2, y2, color1, color2)
    local r, g, b, a = color2[1], color2[2], color2[3], color2[4]
    local r2, g2, b2, a2 = color1[1], color1[2], color1[3], color1[4]

    local t = (a ~= 255 or a2 ~= 255)
    draw_Color(r, g, b, a)
    draw_SetTexture(t and gradient_texture_b or nil)
    draw_FilledRect(x1, y1, x2, y2)

    draw_Color(r2, g2, b2, a2)
    local set_texture = not t and draw_SetTexture(draw_CreateTexture(gradient_texture_b))
    draw_FilledRect(x1, y1, x2, y2)
    draw_SetTexture(nil)
end

local function draw_GradientRectH(x, y, w, h, clr, clr1)
    local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
    local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]

    if a and a1 == nil then
        a, a1 = 255, 255
    end

    if clr[4] ~= 0 then
        if a1 and a ~= 255 then
            for i = 0, w do
                local a2 = i / w * a1
                draw_Color(r1, g1, b1, a2)
                draw_FilledRect(x + w - i, y, x + w - i + 1, y + h)
            end
        else
            draw_Color(r1, g1, b1, a1)
            draw_FilledRect(x, y, x + w, y + h)
        end
    end
    if a2 ~= 0 then
        for i = 0, w do
            local a2 = i / w * a
            draw_Color(r, g, b, a2)
            draw_FilledRect(x + i, y, x + i + 1, y + h)
        end
    end
    a, a1 = nil, nil
end

local function dt_setup(N)
    if N ~= 0 then
        gui_SetValue('rbot.hitscan.accuracy.shared.doublefire', 0)
        gui_SetValue('rbot.hitscan.accuracy.pistol.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['PISTOL'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.hpistol.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['HPISTOL'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.smg.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['SMG'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.rifle.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['RIFLE'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.shotgun.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['SHOTGUN'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.scout.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['SCOUT'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.asniper.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['ASNIPER'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.sniper.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['SNIPER'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.lmg.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['LMG'][1]:GetValue())
        gui_SetValue('rbot.hitscan.accuracy.knife.doublefire', CHIEFTAIN_DOUBLEFIRE_MODE['KNIFE'][1]:GetValue())
    else
        gui_SetValue('rbot.hitscan.accuracy.shared.doublefire', 0)
        gui_SetValue('rbot.hitscan.accuracy.pistol.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.hpistol.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.smg.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.rifle.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.shotgun.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.scout.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.asniper.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.sniper.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.lmg.doublefire', N)
        gui_SetValue('rbot.hitscan.accuracy.knife.doublefire', N)
    end
end

local function dtfl_setup(N)
    gui_SetValue('rbot.hitscan.accuracy.shared.doublefirefl', 0)
	gui_SetValue('rbot.hitscan.accuracy.pistol.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.hpistol.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.smg.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.rifle.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.shotgun.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.scout.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.asniper.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.sniper.doublefirefl', N)
	gui_SetValue('rbot.hitscan.accuracy.lmg.doublefirefl', N)
    gui_SetValue('rbot.hitscan.accuracy.knife.doublefirefl', N)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function menuсontroler()
    --STATIC ELEMENTS
    if CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 then
        CHIEFTAIN_MISC_FAKELAGS_JITTER:SetInvisible(true)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_TYPE:SetInvisible(false)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MIN:SetInvisible(false)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MAX:SetInvisible(false)
    else
        CHIEFTAIN_MISC_FAKELAGS_JITTER:SetInvisible(false)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_TYPE:SetInvisible(true)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MIN:SetInvisible(true)
        CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MAX:SetInvisible(true)
    end

    if CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 5 then
        CHIEFTAIN_MISC_FAKEDUCK_SPEED_ADJUSTER:SetInvisible(false)
    else
        CHIEFTAIN_MISC_FAKEDUCK_SPEED_ADJUSTER:SetInvisible(true)
    end

    if CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 5 then
        CHIEFTAIN_MISC_FAKELATENCY_ADJUSTER:SetInvisible(false)
    else
        CHIEFTAIN_MISC_FAKELATENCY_ADJUSTER:SetInvisible(true)
    end

    if CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 and CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 5 and CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 5 then
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(701)
    elseif CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 and CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 5 or CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 and CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 5 then
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(639)
    elseif CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 5 and CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 5 then
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(569)
    elseif CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 then
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(577)
    elseif CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 5 or CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 5 then
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(507)
    else
        CHIEFTAIN_SUBTAB_VISUALS:SetPosY(445)
    end

    if CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON:GetValue() then
        CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS:SetInvisible(false)
    else
        CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS:SetInvisible(true)
    end

    if CHIEFTAIN_VISUALS_FOG_MODULATION:GetValue() then
        CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:SetInvisible(false)
        CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:SetInvisible(false)
        CHIEFTAIN_VISUALS_FOG_MODULATION_START:SetInvisible(false)
        CHIEFTAIN_VISUALS_FOG_MODULATION_END:SetInvisible(false)
    else
        CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:SetInvisible(true)
        CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:SetInvisible(true)
        CHIEFTAIN_VISUALS_FOG_MODULATION_START:SetInvisible(true)
        CHIEFTAIN_VISUALS_FOG_MODULATION_END:SetInvisible(true)
    end

    --DYNAMIC ELEMENTS
    --If we are not on the server or not alive, then we cannot access the elements, therefore we need "return" in this block until access appears.
    if entities_GetLocalPlayer() then
        if not entities_GetLocalPlayer():IsAlive() then
            CHIEFTAIN_NOT_SUPPORT_GROUP:SetInvisible(false)
            CHIEFTAIN_SUBTAB_DOUBLEFIRE:SetInvisible(true)
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(true)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(true)
            return
        end
    else
        CHIEFTAIN_NOT_SUPPORT_GROUP:SetInvisible(false)
        CHIEFTAIN_SUBTAB_DOUBLEFIRE:SetInvisible(true)
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(true)
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(true)
        return
    end

    --We cannot access the elements, therefore we stop the function.
    if WEAPON_CURRENT_GROUP == 'GLOBAL' then
        CHIEFTAIN_NOT_SUPPORT_GROUP:SetInvisible(false)
        CHIEFTAIN_SUBTAB_DOUBLEFIRE:SetInvisible(true)
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(true)
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(true)
        return
    else
        CHIEFTAIN_NOT_SUPPORT_GROUP:SetInvisible(true)
        CHIEFTAIN_SUBTAB_DOUBLEFIRE:SetInvisible(false)
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(false)
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(false)
    end

    if CHIEFTAIN_DOUBLEFIRE_ENABLE:GetValue() and CHIEFTAIN_DOUBLEFIRE_MODE[WEAPON_CURRENT_GROUP][1]:GetValue() ~= 0 then
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(414)
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(864)

        CHIEFTAIN_DOUBLEFIRE_MODE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        CHIEFTAIN_DOUBLEFIRE_PERF[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
        CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:SetInvisible(false)
        CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)

        if not CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY[WEAPON_CURRENT_GROUP][1]:GetValue() and gui_GetValue('rbot.antiaim.advanced.antialign') == 1 then
            CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
            CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY[WEAPON_CURRENT_GROUP][1]:SetValue(false)
        else
            CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        end

        if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 then
            CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY:SetInvisible(false)
        else
            CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY:SetInvisible(true)
        end

        if CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_DOUBLEFIRE_TICKBASE_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
        else
            CHIEFTAIN_DOUBLEFIRE_TICKBASE_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        end

        if CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_DOUBLEFIRE_FAKELATENCY_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
        else
            CHIEFTAIN_DOUBLEFIRE_FAKELATENCY_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        end

        if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 and CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 and CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(670)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(1120)
        elseif CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 and CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 or CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 and CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(608)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(1058)
        elseif CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 and CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(608)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(1058)
        elseif CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 or CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 or CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 5 then
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(546)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(996)
        else
            CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(484)
            CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(934)
        end
    else
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetPosY(204)
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetPosY(654)
        
        if CHIEFTAIN_DOUBLEFIRE_MODE[WEAPON_CURRENT_GROUP][1]:GetValue() ~= 0 then
            CHIEFTAIN_DOUBLEFIRE_MODE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
        else
            CHIEFTAIN_DOUBLEFIRE_MODE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        end

        CHIEFTAIN_DOUBLEFIRE_PERF[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_TICKBASE_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
        CHIEFTAIN_DOUBLEFIRE_FAKELATENCY_ADJUSTER[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
    end

    if WEAPON_CURRENT_GROUP == 'KNIFE' then
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(true)
    else
        CHIEFTAIN_SUBTAB_AUTOPEEK:SetInvisible(false)
        
        if CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE_ADAPTIVE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        else
            CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE_ADAPTIVE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING_FIX[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        else
            CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING_FIX[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
        else
            CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
        end
    end

    if lp_weapon_id(WEAPONID_SCOUT) or lp_weapon_id(WEAPONID_AUTOSNIPERS) or lp_weapon_id(WEAPONID_SNIPER) then
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(false)
        if CHIEFTAIN_NOSCOPEHC_ENABLE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_NOSCOPEHC_REGULAR_SCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
            
            if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
            else
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
            end

            CHIEFTAIN_NOSCOPEHC_REGULAR_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)

            if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(false)
            else
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
            end
        else
            CHIEFTAIN_NOSCOPEHC_REGULAR_SCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)

            if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
            else
                CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
            end

            CHIEFTAIN_NOSCOPEHC_REGULAR_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)

            if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(false)
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetDisabled(true)
            else
                CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:SetInvisible(true)
            end
        end
    else
        CHIEFTAIN_SUBTAB_NOSCOPEHC:SetInvisible(true)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fakelags(getmaxprocessticks)
    if DT_ENABLED then
        return
    end

    local FL_TYPE = { 0, 1, 3 }

	gui_SetValue('misc.fakelag.enable', 1)
    if CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() <= 1 then
		gui_SetValue('misc.fakelag.type', FL_TYPE[CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() + 1])
		gui_SetValue('misc.fakelag.factor', math_random(getmaxprocessticks - CHIEFTAIN_MISC_FAKELAGS_JITTER:GetValue(), getmaxprocessticks))
	elseif CHIEFTAIN_MISC_FAKELAGS_TYPE:GetValue() == 2 then
		gui_SetValue('misc.fakelag.type', FL_TYPE[CHIEFTAIN_MISC_FAKELAGS_CUSTOM_TYPE:GetValue() + 1])
		gui_SetValue('misc.fakelag.factor', math_random(CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MIN:GetValue(), CHIEFTAIN_MISC_FAKELAGS_CUSTOM_FACTOR_MAX:GetValue()))
    end
    SV_MAXUSRCMDPROCESSTICKS:SetValue(client_GetConVar('sv_maxusrcmdprocessticks'))
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fakeduck(getmaxprocessticks)
    if gui_GetValue('rbot.antiaim.extra.fakecrouchkey') == 0 then
		return
	end
    local FD_SPEED = { getmaxprocessticks - 2, getmaxprocessticks - 1, getmaxprocessticks, getmaxprocessticks + 1, CHIEFTAIN_MISC_FAKEDUCK_SPEED_ADJUSTER:GetValue() }

    if input_IsButtonDown(gui_Reference('Ragebot', 'Anti-Aim', 'Extra', 'Fake Duck'):GetValue()) then 
        if CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue() == 0 then
            if getmaxprocessticks == '6' or getmaxprocessticks == '8' then
                SV_MAXUSRCMDPROCESSTICKS:SetValue(7)
            else
                SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks)
            end

            FD_ENABLED = 1
        else
            SV_MAXUSRCMDPROCESSTICKS:SetValue(FD_SPEED[CHIEFTAIN_MISC_FAKEDUCK_SPEED:GetValue()])
        end
    else
        FD_ENABLED = nil
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function fakelatency()
    FL_AMOUNT = { 80, 120, 160, 200, CHIEFTAIN_MISC_FAKELATENCY_ADJUSTER:GetValue() }
    FL_DT_AMOUNT = { 80, 120, 160, 200, CHIEFTAIN_DOUBLEFIRE_FAKELATENCY_ADJUSTER[WEAPON_CURRENT_GROUP][1]:GetValue() }

    if CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() ~= 0 then
        if DT_ENABLED then
            gui_SetValue('misc.fakelatency.enable', 1)
            gui_SetValue('misc.fakelatency.key', 'None')
            gui_SetValue('misc.fakelatency.amount', FL_DT_AMOUNT[CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue()])
        else
            if CHIEFTAIN_MISC_FAKELATENCY:GetValue() == 0 then
                gui_SetValue('misc.fakelatency.enable', 0)
            end
        end
    else
        if DT_ENABLED then
            gui_SetValue('misc.fakelatency.enable', 0)
        end
    end
    
    if CHIEFTAIN_MISC_FAKELATENCY:GetValue() ~= 0 then
        if not DT_ENABLED then
            gui_SetValue('misc.fakelatency.enable', 1)
            gui_SetValue('misc.fakelatency.key', 'None')
            gui_SetValue('misc.fakelatency.amount', FL_AMOUNT[CHIEFTAIN_MISC_FAKELATENCY:GetValue()])
        else
            if CHIEFTAIN_DOUBLEFIRE_FAKELATENCY[WEAPON_CURRENT_GROUP][1]:GetValue() == 0 then
                gui_SetValue('misc.fakelatency.enable', 0)
            end
        end
    else
        if not DT_ENABLED then
            gui_SetValue('misc.fakelatency.enable', 0)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function doublefire_bind()
    if CHIEFTAIN_DOUBLEFIRE_ENABLE:GetValue() then
        DT_ENABLED = true
    else
        DT_ENABLED = false
        dt_setup(0)
    end
end

local function doublefire(getmaxprocessticks)
    local lp_ping = entities_GetPlayerResources():GetPropInt("m_iPing", entities_GetLocalPlayer():GetIndex())
	local DT_SPEED_ARR = {getmaxprocessticks - 2, getmaxprocessticks - 1, getmaxprocessticks, getmaxprocessticks + 1, CHIEFTAIN_DOUBLEFIRE_TICKBASE_ADJUSTER[WEAPON_CURRENT_GROUP][1]:GetValue()}

    if DT_ENABLED and not FD_ENABLED then
        if CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue() == 0 then
            if gui_GetValue('misc.fakelatency.enable') then
                if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 0 then
                    SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks)
                else
                    DT_SPEED = getmaxprocessticks
                end
            else
                if lp_ping <= 40 then
                    if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 0 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks)
                    else
                        DT_SPEED = getmaxprocessticks
                    end
                elseif lp_ping <= 80 then
                    if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 0 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks - 1)
                    else
                        DT_SPEED = getmaxprocessticks - 1
                    end
                elseif lp_ping > 80 then
                    if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 0 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks - 2)
                    else
                        DT_SPEED = getmaxprocessticks - 2
                    end
                end	
            end
        else
            if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 0 then
                SV_MAXUSRCMDPROCESSTICKS:SetValue(DT_SPEED_ARR[CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue()])
            else
                DT_SPEED = DT_SPEED_ARR[CHIEFTAIN_DOUBLEFIRE_TICKBASE[WEAPON_CURRENT_GROUP][1]:GetValue()]
            end
        end
    end

    if CHIEFTAIN_DOUBLEFIRE_PERF_DISLBY[WEAPON_CURRENT_GROUP][1]:GetValue() then
        if DT_ENABLED then
            gui_SetValue('rbot.antiaim.advanced.antialign', 1)
        else
            gui_SetValue('rbot.antiaim.advanced.antialign', 0)
        end
    end

    if DT_SPEED == '0' then
        DT_SPEED = getmaxprocessticks
    end

    if DT_ENABLED and not FD_ENABLED then
        if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 then
            SV_MAXUSRCMDPROCESSTICKS:SetValue(DT_TICKS)
        end

        dt_setup()

        if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() ~= 0 then
            if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 1 then
                if DT_TICKS == DT_SPEED - 7 then
                    if globals_CurTime() > OLD_CURTIME then
                        DT_TICKS = DT_TICKS + 1
                        OLD_CURTIME = globals_CurTime() + 0.15
                    end
                elseif DT_TICKS == DT_SPEED - 6 then
                    if globals_CurTime() > OLD_CURTIME then
                        DT_TICKS = DT_TICKS + 1
                        OLD_CURTIME = globals_CurTime() + 0.15
                    end
                elseif DT_TICKS == DT_SPEED - 5 then
                    if globals_CurTime() > OLD_CURTIME then
                        DT_TICKS = DT_TICKS + 1
                        OLD_CURTIME = globals_CurTime() + CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM_DELAY:GetValue() * 0.001
                    end
                elseif DT_TICKS == DT_SPEED - 4 then
                    local entity = entities_FindByClass("CCSPlayer")
                    local valid

                    for i = 2, #entity do
                        if entity[i] and not entity[i]:IsDormant() and entity[i]:GetTeamNumber() ~= entities_GetLocalPlayer():GetTeamNumber() then
                            valid = true
                        end
                    end

                    if valid then
                        if globals_CurTime() > OLD_CURTIME then
                            DT_TICKS = DT_TICKS + 4
                        end
                    end
                end
            end
        end
    else
        dt_setup(0)

        if CHIEFTAIN_DOUBLEFIRE_CHARGING_SYSTEM:GetValue() == 1 then
            DT_TICKS = DT_SPEED - 7
            OLD_CURTIME = globals_CurTime() + 0.35
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

do
    local CACHE_DOUBLEFIRE      = CHIEFTAIN_DOUBLEFIRE_ENABLE:GetValue()
    local CACHE_AUTODIR_EDGE    = gui_GetValue('rbot.antiaim.advanced.autodir.edges')
    local CACHE_AUTODIR_TARGET  = gui_GetValue('rbot.antiaim.advanced.autodir.targets')
    local CACHE_EDGE_LEFT       = gui_GetValue('rbot.antiaim.left')
    local CACHE_EDGE_RIGHT      = gui_GetValue('rbot.antiaim.right')
    local CACHE_WPNDMG_PISTOL   = gui_GetValue('rbot.hitscan.accuracy.pistol.mindamage')
    local CACHE_WPNDMG_HPISTOL  = gui_GetValue('rbot.hitscan.accuracy.hpistol.mindamage')
    local CACHE_WPNDMG_SMG      = gui_GetValue('rbot.hitscan.accuracy.smg.mindamage')
    local CACHE_WPNDMG_RIFLE    = gui_GetValue('rbot.hitscan.accuracy.rifle.mindamage')
    local CACHE_WPNDMG_SHOTGUN  = gui_GetValue('rbot.hitscan.accuracy.shotgun.mindamage')
    local CACHE_WPNDMG_SCOUT    = gui_GetValue('rbot.hitscan.accuracy.scout.mindamage')
    local CACHE_WPNDMG_ASNIPER  = gui_GetValue('rbot.hitscan.accuracy.asniper.mindamage')
    local CACHE_WPNDMG_SNIPER   = gui_GetValue('rbot.hitscan.accuracy.sniper.mindamage')
    local CACHE_WPNDMG_LMG      = gui_GetValue('rbot.hitscan.accuracy.lmg.mindamage')
end

local function autopeek_cache()
    CACHE_DOUBLEFIRE        = CHIEFTAIN_DOUBLEFIRE_ENABLE:GetValue()

    CACHE_AUTODIR_EDGE 	   = gui_GetValue('rbot.antiaim.advanced.autodir.edges')
    CACHE_AUTODIR_TARGET    = gui_GetValue('rbot.antiaim.advanced.autodir.targets')
    
    CACHE_EDGE_LEFT         = gui_GetValue('rbot.antiaim.left')
    CACHE_EDGE_RIGHT        = gui_GetValue('rbot.antiaim.right')

    CACHE_WPNDMG_PISTOL     = gui_GetValue('rbot.hitscan.accuracy.pistol.mindamage')
    CACHE_WPNDMG_HPISTOL    = gui_GetValue('rbot.hitscan.accuracy.hpistol.mindamage')
    CACHE_WPNDMG_SMG        = gui_GetValue('rbot.hitscan.accuracy.smg.mindamage')
    CACHE_WPNDMG_RIFLE      = gui_GetValue('rbot.hitscan.accuracy.rifle.mindamage')
    CACHE_WPNDMG_SHOTGUN    = gui_GetValue('rbot.hitscan.accuracy.shotgun.mindamage')
    CACHE_WPNDMG_SCOUT      = gui_GetValue('rbot.hitscan.accuracy.scout.mindamage')
    CACHE_WPNDMG_ASNIPER    = gui_GetValue('rbot.hitscan.accuracy.asniper.mindamage')
    CACHE_WPNDMG_SNIPER     = gui_GetValue('rbot.hitscan.accuracy.sniper.mindamage')
    CACHE_WPNDMG_LMG        = gui_GetValue('rbot.hitscan.accuracy.lmg.mindamage')
end

local autopeek_is_active = false
local autopeek_state = false
local should_autodir = false

local function autopeek_settings(getmaxprocessticks)
    if not CHIEFTAIN_AUTOPEEK_SETTINGS_ENABLE:GetValue() or not gui_GetValue('rbot.accuracy.movement.autopeek') or gui_GetValue('rbot.accuracy.movement.autopeekkey') == 0 then
		return
	end

    if gui_GetValue('rbot.accuracy.movement.autopeektype') == 0 then
        if input_IsButtonDown(gui_Reference('Ragebot', 'Accuracy', 'Movement', 'Auto Peek Key'):GetValue()) then
            autopeek_is_active = true
        elseif input_IsButtonReleased(gui_Reference('Ragebot', 'Accuracy', 'Movement', 'Auto Peek Key'):GetValue()) then
            autopeek_is_active = false
        end
    else
        if input_IsButtonPressed(gui_Reference('Ragebot', 'Accuracy', 'Movement', 'Auto Peek Key'):GetValue()) then
            if autopeek_is_active == false or autopeek_is_active == 666 then
                autopeek_is_active = true
            else
                autopeek_is_active = false
            end
        end
    end

    if autopeek_is_active == true then
        if WEAPON_CURRENT_GROUP == 'GLOBAL' or WEAPON_CURRENT_GROUP == 'KNIFE' then
            gui_SetValue('rbot.antiaim.advanced.autodir.edges', CACHE_AUTODIR_EDGE)
            gui_SetValue('rbot.antiaim.advanced.autodir.targets', CACHE_AUTODIR_TARGET)

            gui_SetValue('rbot.antiaim.left', CACHE_EDGE_LEFT)
            gui_SetValue('rbot.antiaim.right', CACHE_EDGE_RIGHT)

            gui_SetValue('rbot.hitscan.accuracy.pistol.mindamage', CACHE_WPNDMG_PISTOL)
            gui_SetValue('rbot.hitscan.accuracy.hpistol.mindamage', CACHE_WPNDMG_HPISTOL)
            gui_SetValue('rbot.hitscan.accuracy.smg.mindamage', CACHE_WPNDMG_SMG)
            gui_SetValue('rbot.hitscan.accuracy.rifle.mindamage', CACHE_WPNDMG_RIFLE)
            gui_SetValue('rbot.hitscan.accuracy.shotgun.mindamage', CACHE_WPNDMG_SHOTGUN)
            gui_SetValue('rbot.hitscan.accuracy.scout.mindamage', CACHE_WPNDMG_SCOUT)
            gui_SetValue('rbot.hitscan.accuracy.asniper.mindamage', CACHE_WPNDMG_ASNIPER)
            gui_SetValue('rbot.hitscan.accuracy.sniper.mindamage', CACHE_WPNDMG_SNIPER)
            gui_SetValue('rbot.hitscan.accuracy.lmg.mindamage', CACHE_WPNDMG_LMG)

            return
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_DOUBLEFIRE_ENABLE:SetValue(1)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE_ADAPTIVE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            SV_MAXUSRCMDPROCESSTICKS:SetValue(getmaxprocessticks)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING[WEAPON_CURRENT_GROUP][1]:GetValue() then
            if not CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING_FIX[WEAPON_CURRENT_GROUP][1]:GetValue() then
                gui_SetValue('rbot.antiaim.advanced.autodir.edges', 1)
                gui_SetValue('rbot.antiaim.advanced.autodir.targets', 0)
            else
                if (bit.band(entities_GetLocalPlayer():GetPropInt("m_fFlags"), 1) == 0) or cheat.IsFakeDucking() then
                    gui_SetValue("rbot.antiaim.advanced.autodir.targets", 1);
                    gui_SetValue("rbot.antiaim.advanced.autodir.edges", 0);
                else
                    for i, player in pairs(entities_FindByClass("CCSPlayer")) do
                        if player:GetTeamNumber() ~= entities_GetLocalPlayer():GetTeamNumber() and player:IsPlayer() and player:IsAlive() then
                            local trace = engine_TraceLine(entities_GetLocalPlayer():GetHitboxPosition(1), player:GetHitboxPosition(1), 0x46004003)
                            if trace ~= nil then
                                if trace.fraction > 0.1 then 
                                    should_autodir = false;
                                else
                                    should_autodir = true;
                                end
                            end

                            gui.SetValue("rbot.antiaim.advanced.autodir.targets", not should_autodir)
                            gui.SetValue("rbot.antiaim.advanced.autodir.edges", should_autodir)
                        end
                    end
                end
            end

            gui_SetValue('rbot.antiaim.left', 100)
            gui_SetValue('rbot.antiaim.right', -100)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            gui_SetValue('rbot.hitscan.accuracy.pistol.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.hpistol.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.smg.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.rifle.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.shotgun.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.scout.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.asniper.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.sniper.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
            gui_SetValue('rbot.hitscan.accuracy.lmg.mindamage', CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[WEAPON_CURRENT_GROUP][1]:GetValue())
        end

        autopeek_state = true
    elseif autopeek_is_active == false then
        if WEAPON_CURRENT_GROUP == 'GLOBAL' or WEAPON_CURRENT_GROUP == 'KNIFE' then
            gui_SetValue('rbot.antiaim.advanced.autodir.edges', CACHE_AUTODIR_EDGE)
            gui_SetValue('rbot.antiaim.advanced.autodir.targets', CACHE_AUTODIR_TARGET)

            gui_SetValue('rbot.antiaim.left', CACHE_EDGE_LEFT)
            gui_SetValue('rbot.antiaim.right', CACHE_EDGE_RIGHT)

            gui_SetValue('rbot.hitscan.accuracy.pistol.mindamage', CACHE_WPNDMG_PISTOL)
            gui_SetValue('rbot.hitscan.accuracy.hpistol.mindamage', CACHE_WPNDMG_HPISTOL)
            gui_SetValue('rbot.hitscan.accuracy.smg.mindamage', CACHE_WPNDMG_SMG)
            gui_SetValue('rbot.hitscan.accuracy.rifle.mindamage', CACHE_WPNDMG_RIFLE)
            gui_SetValue('rbot.hitscan.accuracy.shotgun.mindamage', CACHE_WPNDMG_SHOTGUN)
            gui_SetValue('rbot.hitscan.accuracy.scout.mindamage', CACHE_WPNDMG_SCOUT)
            gui_SetValue('rbot.hitscan.accuracy.asniper.mindamage', CACHE_WPNDMG_ASNIPER)
            gui_SetValue('rbot.hitscan.accuracy.sniper.mindamage', CACHE_WPNDMG_SNIPER)
            gui_SetValue('rbot.hitscan.accuracy.lmg.mindamage', CACHE_WPNDMG_LMG)

            return
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_DOUBLEFIRE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            CHIEFTAIN_DOUBLEFIRE_ENABLE:SetValue(CACHE_DOUBLEFIRE)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_FREESTANDING[WEAPON_CURRENT_GROUP][1]:GetValue() then
            gui_SetValue('rbot.antiaim.advanced.autodir.edges', CACHE_AUTODIR_EDGE)
            gui_SetValue('rbot.antiaim.advanced.autodir.targets', CACHE_AUTODIR_TARGET)

            gui_SetValue('rbot.antiaim.left', CACHE_EDGE_LEFT)
            gui_SetValue('rbot.antiaim.right', CACHE_EDGE_RIGHT)
        end

        if CHIEFTAIN_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[WEAPON_CURRENT_GROUP][1]:GetValue() then
            gui_SetValue('rbot.hitscan.accuracy.pistol.mindamage', CACHE_WPNDMG_PISTOL)
            gui_SetValue('rbot.hitscan.accuracy.hpistol.mindamage', CACHE_WPNDMG_HPISTOL)
            gui_SetValue('rbot.hitscan.accuracy.smg.mindamage', CACHE_WPNDMG_SMG)
            gui_SetValue('rbot.hitscan.accuracy.rifle.mindamage', CACHE_WPNDMG_RIFLE)
            gui_SetValue('rbot.hitscan.accuracy.shotgun.mindamage', CACHE_WPNDMG_SHOTGUN)
            gui_SetValue('rbot.hitscan.accuracy.scout.mindamage', CACHE_WPNDMG_SCOUT)
            gui_SetValue('rbot.hitscan.accuracy.asniper.mindamage', CACHE_WPNDMG_ASNIPER)
            gui_SetValue('rbot.hitscan.accuracy.sniper.mindamage', CACHE_WPNDMG_SNIPER)
            gui_SetValue('rbot.hitscan.accuracy.lmg.mindamage', CACHE_WPNDMG_LMG)
        end

        autopeek_state = false

        autopeek_is_active = 666
    end

    if not autopeek_state then
        autopeek_cache()
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function no_scope_hc()
    if not CHIEFTAIN_NOSCOPEHC_ENABLE[WEAPON_CURRENT_GROUP][1]:GetValue() then
        return
    end

    Scoped = entities_GetLocalPlayer():GetPropBool("m_bIsScoped");
	
    gui_SetValue('rbot.aim.automation.scope', 0)
    if Scoped then
        gui_SetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.hitchance', CHIEFTAIN_NOSCOPEHC_REGULAR_SCOPE[WEAPON_CURRENT_GROUP][1]:GetValue())
        if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
            gui_SetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirehc', CHIEFTAIN_NOSCOPEHC_DF_SCOPE[WEAPON_CURRENT_GROUP][1]:GetValue())
        end
	else
        gui_SetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.hitchance', CHIEFTAIN_NOSCOPEHC_REGULAR_NOSCOPE[WEAPON_CURRENT_GROUP][1]:GetValue())
        if lp_weapon_id(WEAPONID_AUTOSNIPERS) then
            gui_SetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirehc', CHIEFTAIN_NOSCOPEHC_DF_NOSCOPE[WEAPON_CURRENT_GROUP][1]:GetValue())
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function lc_status_and_shitftedticks(UserCmd)
    if UserCmd.sendpacket then
        table.insert(originRecords, entities_GetLocalPlayer():GetAbsOrigin())
    end

    if gui_GetValue('rbot.antiaim.advanced.antialign') == 0 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') > 1 then
            SHIFTED_TICKS = (SV_MAXUSRCMDPROCESSTICKS:GetValue() - (gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') - 1) - 2)
        else
            SHIFTED_TICKS = (SV_MAXUSRCMDPROCESSTICKS:GetValue() - 2)
        end
    else
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') > 1 then
            SHIFTED_TICKS = (SV_MAXUSRCMDPROCESSTICKS:GetValue() - (gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') - 1) - 1)
        else
            SHIFTED_TICKS = (SV_MAXUSRCMDPROCESSTICKS:GetValue() - 1)
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local font = draw.CreateFont("Mini 7 Condensed", 10, 400)
local function weaponinfo_draw(x, y, r, g, b, a)
    local pos_x_start, pos_y_start = to_int(x), to_int(y)

    if CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON:GetValue() and gui_GetValue('esp.local.thirdperson') then
        if CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS:GetValue() == 0 then
            pos_x_start = to_int(x - 200)
        else
            pos_x_start = to_int(x - 250)
        end

        --LINE
        draw_Color(CHIEFTAIN_VISUALS_WPNINFO_BACKGROUND_CLR:GetValue())
        draw_Line(pos_x_start + 150, pos_y_start + 33, x, y)
    end

    draw_SetFont(font)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --BACKGROUND
    draw_Color(CHIEFTAIN_VISUALS_WPNINFO_BACKGROUND_CLR:GetValue())
    draw_FilledRect(pos_x_start, pos_y_start, pos_x_start + 150, pos_y_start + 67)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --WEAPON INFO TEXT
    draw_TextOutlined(pos_x_start + 2, pos_y_start + 2, "WEAPON INFO: " .. string_lower(WEAPON_CURRENT_GROUP), { r, g, b, a }, font)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --NICKNAME
    if draw_GetTextSize(cheat.GetUserName()) < 50 then
        draw_TextOutlined(pos_x_start + 148 - draw_GetTextSize(cheat.GetUserName()), pos_y_start + 2, cheat.GetUserName(), { r, g, b, a }, font)
    else
        draw_TextOutlined(pos_x_start + 148 - draw_GetTextSize('UID :' .. cheat.GetUserID()), pos_y_start + 2, 'UID: ' .. cheat.GetUserID(), { r, g, b, a }, font)
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --GACHI LINES
    draw_GradientRectH(pos_x_start, pos_y_start + 11, 75, 1, { r, g, b, 50 }, { r, g, b, a })
    draw_GradientRectH(pos_x_start + 76, pos_y_start + 11, 73, 1, { r, g, b, a }, { r, g, b, 50 })

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    pos_x1 = pos_x_start + 6
    pos_y1 = pos_y_start + 19
    pos_x2 = pos_x_start + 144
    pos_y2 = pos_y_start + 18

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --HC
    local hitchance = gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.hitchance')
    draw_TextOutlined(pos_x1, pos_y1, "HC: " .. hitchance, { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DMG
    local mindamage = gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.mindamage')
    draw_TextOutlined(pos_x1, pos_y1, "DMG: " .. mindamage, { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --SPREAD
    local spread = entities_GetLocalPlayer():GetWeaponInaccuracy()
    draw_TextOutlined(pos_x1, pos_y1, "SPREAD: " .. string_format("%0.3f", spread), { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --VELOCITY
    local m_vecVelocity0 = entities_GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[0]")
    local m_vecVelocity1 = entities_GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[1]")
    local velocity = math_sqrt(m_vecVelocity0 * m_vecVelocity0 + m_vecVelocity1 * m_vecVelocity1)
    draw_TextOutlined(pos_x1, pos_y1, "VELOCITY: " .. string_format("%0.0f", velocity), { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DESYNC ANGLE
    local desync_rotation = gui_GetValue('rbot.antiaim.base.rotation')
    if desync_rotation > -1 then
        draw_TextOutlined(pos_x1, pos_y1, "DESYNC ANGLE: +" .. string_format("%0.0f", desync_rotation) .. "°", { r, g, b, a }, font)
    else
        draw_TextOutlined(pos_x1, pos_y1, "DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°", { r, g, b, a }, font)
    end

    local color_angle = {}
    if desync_rotation > -1 then
        color_angle = { 170 + (154 - 186) * desync_rotation / 58, 0 + (255 - 0) * desync_rotation / 58, 16 + (0 - 16) * desync_rotation / 58 , 255 }
    else
        color_angle = { 170 + (154 - 186) * desync_rotation / -58, 0 + (255 - 0) * desync_rotation / -58, 16 + (0 - 16) * desync_rotation / -58 , 255 }
    end

    local dec = { color_angle[1] - (color_angle[1] / 100 * 50), color_angle[2] - (color_angle[2] / 100 * 50), color_angle[3] - (color_angle[3] / 100 * 50) }

    desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°") + 3
    if desync_rotation > -1 then
        desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: +" .. string_format("%0.0f", desync_rotation) .. "°") + 3
    else
        desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°") + 3
    end
    desync_angle_pos_x2 = desync_angle_pos_x1 + 2
    desync_angle_pos_y1 = pos_y1 + 4
    draw_GradientRectV(desync_angle_pos_x1, desync_angle_pos_y1, desync_angle_pos_x2, desync_angle_pos_y1 - 5, { color_angle[1], color_angle[2], color_angle[3], 255 }, { dec[1], dec[2], dec[3], 100 })
    draw_GradientRectV(desync_angle_pos_x1, desync_angle_pos_y1, desync_angle_pos_x2, desync_angle_pos_y1 + 4, { dec[1], dec[2], dec[3], 100 }, { color_angle[1], color_angle[2], color_angle[3], 255 })
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DT
    local primaryattack = entities_GetLocalPlayer():GetPropEntity('m_hActiveWeapon'):GetPropFloat('LocalActiveWeaponData', 'm_flNextPrimaryAttack')
    local doublefire = 'OFF'

    if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') == 1 then
        doublefire = ' DEFENSIVE'
    elseif gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') == 2 then
        doublefire = ' OFFENSIVE'
    end

    if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
        if primaryattack > globals_CurTime() or input_IsButtonDown(gui_Reference('Ragebot', 'Anti-Aim', 'Extra', 'Fake Duck'):GetValue()) then
            draw_TextOutlined(pos_x2 - draw_GetTextSize(doublefire .. ' DT'), pos_y2, doublefire .. ' DT', { CHIEFTAIN_VISUALS_WPNINFO_WARNINGYELLOW_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize(SHIFTED_TICKS .. doublefire .. ' DT'), pos_y2, SHIFTED_TICKS .. doublefire .. ' DT', { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize(' OFF DT'), pos_y2, ' OFF DT', { CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR:GetValue() }, font)
    end

    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --LC
    if originRecords[1] ~= nil and originRecords[2] ~= nil then
        local delta = Vector3(originRecords[2].x - originRecords[1].x, originRecords[2].y - originRecords[1].y, originRecords[2].z - originRecords[1].z)
        delta = delta:Length2D()^2
        if delta > 4096 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LAGCOMP"), pos_y2, "LAGCOMP", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LAGCOMP"), pos_y2, "LAGCOMP", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
        if originRecords[3] ~= nil then
            table.remove(originRecords, 1)
        end
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --HS
    local hideshots = gui_GetValue('rbot.antiaim.condition.shiftonshot')
    if hideshots then
        draw_TextOutlined(pos_x2 - draw_GetTextSize("HIDESHOTS"), pos_y2, "HIDESHOTS", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize("HIDESHOTS"), pos_y2, "HIDESHOTS", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR:GetValue() }, font)
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --FD
    local fakeduck = gui_GetValue('rbot.antiaim.extra.fakecrouchkey')
    if input_IsButtonDown(fakeduck) then
        draw_TextOutlined(pos_x2 - draw_GetTextSize("FAKEDUCK"), pos_y2, "FAKEDUCK", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize("FAKEDUCK"), pos_y2, "FAKEDUCK", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR:GetValue() }, font)
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --LBY
    local aa_type = gui_GetValue('rbot.antiaim.advanced.antialign')
    if aa_type == 0 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("! LBY"), pos_y2, "! LBY", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGRED_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LBY"), pos_y2, "LBY", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
    elseif aa_type == 1 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("MM"), pos_y2, "MM", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGGREEN_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("MM"), pos_y2, "MM", { CHIEFTAIN_VISUALS_WPNINFO_WARNINGYELLOW_CLR:GetValue() }, font)
        end
    end
end

local function weapon_info()
    local r, g, b, a

    if CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON:GetValue() or CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON:GetValue() then
        if CHIEFTAIN_VISUALS_WPNINFO_RAINBOW:GetValue() then
            r, g, b = HSVtoRGB(globals_RealTime() * 0.1, 1, 1, 255)
            a = 255
        else
            r, g, b, a = CHIEFTAIN_VISUALS_WPNINFO_GENERAL_CLR:GetValue()
        end
    end

    if CHIEFTAIN_VISUALS_WPNINFO_FIRSTPERSON:GetValue() and not gui_GetValue('esp.local.thirdperson') then
        position_save()
        local screen_x, screen_y = drag_indicator(weaponinfo_pos_x, weaponinfo_pos_y, 150, 67)

        weaponinfo_draw(screen_x, screen_y, r, g, b, a)
    elseif CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON:GetValue() and gui_GetValue('esp.local.thirdperson') then
        local bone_pos = entities_GetLocalPlayer():GetBonePosition(54)
        if CHIEFTAIN_VISUALS_WPNINFO_THIRDPERSON_POS:GetValue() == 0 then
            bone_pos = entities_GetLocalPlayer():GetBonePosition(54)
        else
            bone_pos = entities_GetLocalPlayer():GetBonePosition(5)
        end

        local bone_pos_x, bone_pos_y = client_WorldToScreen(bone_pos)

        if not bone_pos_x or not bone_pos_y then
            return
        end

        weaponinfo_draw(bone_pos_x, bone_pos_y, r, g, b, a)
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

do
    local can_change_shadows = true
    local can_change_3dsky = true
    local can_change_fog = true
    local can_change_bloom = true
    local can_change_blur = true
    local can_change_other = true
end

local function fps_boost()
    if CHIEFTAIN_VISUALS_FPSBOOST_SHADOWS:GetValue() then
        if can_change_shadows then
            client_SetConVar('cl_foot_contact_shadows', 0, true)
            client_SetConVar('cl_csm_shadows', 0, true)
            client_SetConVar('cl_csm_rope_shadows', 0, true)
            client_SetConVar('cl_csm_world_shadows', 0, true)
            client_SetConVar('cl_csm_world_shadows_in_viewmodelcascade', 0, true)
            client_SetConVar('cl_csm_static_prop_shadows', 0, true)
            client_SetConVar('cl_csm_sprite_shadows', 0, true)
            client_SetConVar('cl_csm_translucent_shadows', 0, true)
            client_SetConVar('cl_csm_viewmodel_shadows', 0, true)
            client_SetConVar('cl_minimal_rtt_shadows', 0, true)
            client_SetConVar('cl_csm_entity_shadows', 0, true)
            client_SetConVar('r_shadows', 0, true)
            can_change_shadows = false
        end
    else
        if not can_change_shadows then
            client_SetConVar('cl_csm_enabled', 1, true)
            client_SetConVar('cl_foot_contact_shadows', 1, true)
            client_SetConVar('cl_csm_shadows', 1, true)
            client_SetConVar('cl_csm_rope_shadows', 1, true)
            client_SetConVar('cl_csm_world_shadows', 1, true)
            client_SetConVar('cl_csm_world_shadows_in_viewmodelcascade', 1, true)
            client_SetConVar('cl_csm_static_prop_shadows', 1, true)
            client_SetConVar('cl_csm_sprite_shadows', 1, true)
            client_SetConVar('cl_csm_translucent_shadows', 1, true)
            client_SetConVar('cl_csm_viewmodel_shadows', 1, true)
            client_SetConVar('cl_minimal_rtt_shadows', 0, true)
            client_SetConVar('cl_csm_entity_shadows', 1, true)
            client_SetConVar('r_shadows', 1, true)
            can_change_shadows = true
        end
    end

    if CHIEFTAIN_VISUALS_FPSBOOST_3DSKY:GetValue() then
        if can_change_3dsky then
            client_SetConVar('r_3dsky', 0, true)
            can_change_3dsky = false
        end
    else
        if not can_change_3dsky then
            client_SetConVar('r_3dsky', 1, true)
            can_change_3dsky = true
        end
    end

    if CHIEFTAIN_VISUALS_FPSBOOST_FOG:GetValue() then
        if can_change_fog then
            client_SetConVar('fog_enable_water_fog', 0, true)
            client_SetConVar('fog_enableskybox', 0, true)
            can_change_fog = false
        end
    else
        if not can_change_fog then
            client_SetConVar('fog_enable_water_fog', 1, true)
            client_SetConVar('fog_enableskybox', 1, true)
            can_change_fog = true
        end
    end

    if CHIEFTAIN_VISUALS_FPSBOOST_BLOOM:GetValue() then
        if can_change_bloom then
            client_SetConVar('mat_disable_bloom', 1, true)
            can_change_bloom = false
        end
    else
        if not can_change_bloom then
            client_SetConVar('mat_disable_bloom', 0, true)
            can_change_bloom = true
        end
    end

    if CHIEFTAIN_VISUALS_FPSBOOST_BLUR:GetValue() then
        if can_change_blur then
            client_SetConVar('@panorama_disable_blur', 1, true)
            client_SetConVar('@panorama_disable_box_shadow', 1, true)
            can_change_blur = false
        end
    else
        if not can_change_blur then
            client_SetConVar('@panorama_disable_blur', 0, true)
            client_SetConVar('@panorama_disable_box_shadow', 0, true)
            can_change_blur = true
        end
    end

    if CHIEFTAIN_VISUALS_FPSBOOST_OTHER:GetValue() then
        if can_change_other then
            client_SetConVar('cl_autohelp', 0, true)
            client_SetConVar('cl_disablefreezecam', 1, true)
            client_SetConVar('cl_disablehtmlmotd', 1, true)
            client_SetConVar('cl_showhelp', 0, true)
            client_SetConVar('cl_freezecameffects_showholiday', 0, true)
            client_SetConVar('gameinstructor_enable', 0, true)
            client_SetConVar('mat_queue_mode', -1, true)
            client_SetConVar('r_drawtracers_firstperson', 0, true)
            client_SetConVar('r_dynamic', 0, true)
            can_change_other = false
        end
    else
        if not can_change_other then
            client_SetConVar('cl_autohelp', 1, true)
            client_SetConVar('cl_disablefreezecam', 0, true)
            client_SetConVar('cl_disablehtmlmotd', 0, true)
            client_SetConVar('cl_showhelp', 1, true)
            client_SetConVar('cl_freezecameffects_showholiday',1, true)
            client_SetConVar('gameinstructor_enable', 1, true)
            client_SetConVar('mat_queue_mode', -1, true)
            client_SetConVar('r_drawtracers_firstperson', 1, true)
            client_SetConVar('r_dynamic', 1, true)
            can_change_other = true
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CACHE_ASPECTRATIO = CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE:GetValue()
local aspect_ratio_table = {};

local function gcd(a, b)
    while a ~= 0 do
        a, b = math.fmod(b, a), a
    end   
    return b
end

local function set_aspect_ratio(aspect_ratio_multiplier)
    local screen_width, screen_height = draw_GetScreenSize()
    local aspectratio_value = (screen_width * aspect_ratio_multiplier) / screen_height
    client_SetConVar('r_aspectratio', tonumber(aspectratio_value), true)
end

local function aspect_ratio()
    if CACHE_ASPECTRATIO ~= CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE:GetValue() then
        local screen_width, screen_height = draw_GetScreenSize()

        for i = 1, 200 do
            local i2 = 2 - i * 0.01
            local divisor = gcd(screen_width * i2, screen_height)
            if screen_width * i2 / divisor < 100 or i2 == 1 then
                aspect_ratio_table[i] = screen_width * i2 / divisor .. ":" .. screen_height / divisor
            end
        end

        set_aspect_ratio(2 - CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE:GetValue() * 0.01)

        CACHE_ASPECTRATIO = CHIEFTAIN_VISUALS_ASPECTRATIO_VALUE:GetValue()
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

do
    local can_change_fog = true

    local CACHE_WORLDEXPOSURE      = CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:GetValue()

    local CACHE_BLOOM              = CHIEFTAIN_VISUALS_BLOOM_VALUE:GetValue()

    local CACHE_WORLDAMBIENT       = CHIEFTAIN_VISUALS_WORLDAMBIENT_VALUE:GetValue()

    local CACHE_VIEWMODELAMBIENT   = CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE:GetValue()

    local CACHE_FOGCOLOR           = CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:GetValue()
    local CACHE_FOGDENSITY         = CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:GetValue()
    local CACHE_FOGSTART           = CHIEFTAIN_VISUALS_FOG_MODULATION_START:GetValue()
    local CACHE_FOGEND             = CHIEFTAIN_VISUALS_FOG_MODULATION_END:GetValue()
end

local function world_modulation_cache()
    CACHE_WORLDEXPOSURE      = CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:GetValue()

    CACHE_BLOOM              = CHIEFTAIN_VISUALS_BLOOM_VALUE:GetValue()

    CACHE_WORLDAMBIENT       = CHIEFTAIN_VISUALS_WORLDAMBIENT_VALUE:GetValue()

    CACHE_VIEWMODELAMBIENT   = CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE:GetValue()

    CACHE_FOGCOLOR           = CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:GetValue()
    CACHE_FOGDENSITY         = CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:GetValue()
    CACHE_FOGSTART           = CHIEFTAIN_VISUALS_FOG_MODULATION_START:GetValue()
    CACHE_FOGEND             = CHIEFTAIN_VISUALS_FOG_MODULATION_END:GetValue()
end

local function world_modulation()
    local controller = entities_FindByClass('CEnvTonemapController')[1];
    if(controller) then
        controller:SetProp('m_bUseCustomBloomScale', 1)

        if CACHE_WORLDEXPOSURE ~= CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:GetValue() then
            controller:SetProp('m_bUseCustomAutoExposureMin', 1)
            controller:SetProp('m_bUseCustomAutoExposureMax', 1)
            controller:SetProp('m_flCustomAutoExposureMin', 1.01 - (CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:GetValue() * 0.01))
            controller:SetProp('m_flCustomAutoExposureMax', 1.01 - (CHIEFTAIN_VISUALS_WORLDEXPOSURE_VALUE:GetValue() * 0.01))
        end

        if CACHE_BLOOM ~= CHIEFTAIN_VISUALS_BLOOM_VALUE:GetValue() then
            controller:SetProp('m_bUseCustomBloomScale', 1)
            controller:SetProp('m_flCustomBloomScaleMinimum', CHIEFTAIN_VISUALS_BLOOM_VALUE:GetValue() * 0.05)
            controller:SetProp('m_flCustomBloomScale', CHIEFTAIN_VISUALS_BLOOM_VALUE:GetValue() * 0.05)
        end

        if CACHE_VIEWMODELAMBIENT ~= CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE:GetValue() then
            client_SetConVar('r_modelAmbientMin', CHIEFTAIN_VISUALS_VIEWMODELAMBIENT_VALUE:GetValue() * 0.10, true)
        end

        local ambient_r, ambient_g, ambient_b = CHIEFTAIN_VISUALS_WORLDAMBIENT_VALUE:GetValue()
        if CACHE_WORLDAMBIENT ~= CHIEFTAIN_VISUALS_WORLDAMBIENT_VALUE:GetValue() then
            client_SetConVar('mat_ambient_light_r', ambient_r / 255, true)
            client_SetConVar('mat_ambient_light_g', ambient_g / 255, true)
            client_SetConVar('mat_ambient_light_b', ambient_b / 255, true)
        end


        if CHIEFTAIN_VISUALS_FOG_MODULATION:GetValue() then
            if CACHE_FOGCOLOR ~= CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:GetValue() or CACHE_FOGDENSITY ~= CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:GetValue() * 0.01 or 
               CACHE_FOGSTART ~= CHIEFTAIN_VISUALS_FOG_MODULATION_START:GetValue() or CACHE_FOGEND ~= CHIEFTAIN_VISUALS_FOG_MODULATION_END:GetValue() then
                client_SetConVar('fog_override', 1, true)

                local r, g, b = CHIEFTAIN_VISUALS_FOG_MODULATION_COLOR:GetValue()
                client_SetConVar('fog_color', r .. " " .. g .. " " .. b, true)
                client_SetConVar('fog_maxdensity', CHIEFTAIN_VISUALS_FOG_MODULATION_DENSITY:GetValue() * 0.01, true)
                client_SetConVar('fog_start', CHIEFTAIN_VISUALS_FOG_MODULATION_START:GetValue(), true)
                client_SetConVar('fog_end', CHIEFTAIN_VISUALS_FOG_MODULATION_END:GetValue(), true)

                can_change_fog = true
            end
        else
            if can_change_fog then
                client_SetConVar('fog_override', 0, true)
                can_change_fog = false
            end
        end

        world_modulation_cache()
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

callbacks.Register('Draw', 'ChieftainDrawMain', function()
    menuсontroler()
    
    if entities_GetLocalPlayer() then
        if not entities_GetLocalPlayer():IsAlive() then
            return
        end
    else
        return
    end

    panorama.RunScript([[ LoadoutAPI.IsLoadoutAllowed = () => { return true; }; ]])
    local getmaxprocessticks = client_GetConVar('sv_maxusrcmdprocessticks')

    fakelags(getmaxprocessticks)
    fakeduck(getmaxprocessticks)
    doublefire_bind()
    autopeek_settings(getmaxprocessticks)
    fps_boost()
    aspect_ratio()
    world_modulation()

    if WEAPON_CURRENT_GROUP == 'GLOBAL' then
        return
    end

    fakelatency()
    doublefire(getmaxprocessticks)
    no_scope_hc()

    if WEAPON_CURRENT_GROUP == 'KNIFE' then
        return
    end
    
    weapon_info()
end) 

callbacks.Register('CreateMove', 'ChieftainCreateMoveMain', function(UserCmd)
    if entities_GetLocalPlayer() then
        if not entities_GetLocalPlayer():IsAlive() then
            return
        end
    else
        return
    end

    if WEAPON_CURRENT_GROUP == 'GLOBAL' or WEAPON_CURRENT_GROUP == 'KNIFE' then
        return
    end

    lc_status_and_shitftedticks(UserCmd)
end)
