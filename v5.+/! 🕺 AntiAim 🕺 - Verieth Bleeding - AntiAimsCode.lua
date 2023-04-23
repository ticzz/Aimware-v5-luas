--region GUI
local anti_aim_settings_tab = gui.Tab(gui.Reference("Ragebot"), "anti_aim_settings_tab", "Anti-Aim Settings Tab");

--enable section
local anti_aim_enable_section = gui.Groupbox(anti_aim_settings_tab, "Enable Section", 5, 10, 325, 450);

local enable_script = gui.Checkbox(anti_aim_enable_section, "enable_script", "Enable Script", true);

--mode selector
local anti_aim_mode_selector = gui.Groupbox(anti_aim_settings_tab, "Mode", 5, 100, 325, 450);

local advanced_mode = gui.Checkbox(anti_aim_mode_selector, "advanced_mode", "Advanced Mode", false);


--condition selector
local anti_aim_condition_selector = gui.Groupbox(anti_aim_settings_tab, "Condition", 5, 190, 325, 450);

local condition_selector = gui.Combobox(anti_aim_condition_selector, "condition_selector", "Select Condition", "General", "Standing", "Ducking", "Slow Walking", "Moving", "In Air")


--advanced settings
local anti_aim_advanced_settings = gui.Groupbox(anti_aim_settings_tab, "Advanced Settings", 5, 300, 325, 350);

local anti_aim_names = {"general", "standing", "ducking", "slow_walking", "moving", "air"};
local anti_aim_elements = {};

--creating all elements by all conditions
local function createAntiAimGui()

    --iterating over anti-aim conditions and creating specify element for them
    for element = 1, #anti_aim_names, 1 do

        --names for gui objects
        local element_varname = anti_aim_names[element]

        local element_name = string.gsub((string.upper(string.sub(anti_aim_names[element], 1, 1)) .. string.sub(anti_aim_names[element], 2)), "%_", ' ')

        --creating condition array
        if not anti_aim_elements[element] then
            anti_aim_elements[element] = {}
        end

        local condition_array = anti_aim_elements[element]

        --override condition checkbox
        condition_array.override_condition = gui.Checkbox(anti_aim_advanced_settings, "override_condition_" .. element_varname, "Override " .. element_name, false)

        --desync modifiers
        condition_array.desync_type = gui.Combobox(anti_aim_advanced_settings, "desync_type_" .. element_varname, "Desync Type", "Default Desync", "Desync Jitter")

        condition_array.desync_modifier = gui.Combobox(anti_aim_advanced_settings, "desync_modifier_" .. element_varname, "Desync Modifier",
                                          "Static", "Jitter")

        condition_array.desync_range_right = gui.Slider(anti_aim_advanced_settings, "desync_range_right_" .. element_varname, "Desync Range Right", 0, 0, 58, 1)
        condition_array.desync_range_left = gui.Slider(anti_aim_advanced_settings, "desync_range_left_" .. element_varname, "Desync Range Left", 0, 0, 58, 1)

        --yaw modifiers
        condition_array.yaw_angle_right = gui.Slider(anti_aim_advanced_settings, "yaw_angle_right_" .. element_varname, "Yaw Angle Right", 0, -180, 180, 1)
        condition_array.yaw_angle_left = gui.Slider(anti_aim_advanced_settings, "yaw_angle_left_" .. element_varname, "Yaw Angle Left", 0, -180, 180, 1)

        condition_array.yaw_modifier = gui.Combobox(anti_aim_advanced_settings, "yaw_modifier_" .. element_varname, "Yaw Modifier",
                                       "Static", "Center Jitter", "Offset Jitter","Random Jitter", "Tank Jitter", "Random Tank Jitter", "Fake Flick")

        condition_array.yaw_modifier_range = gui.Slider(anti_aim_advanced_settings, "yaw_modifier_range_" .. element_varname, "Yaw Modifier Range", 0, 0, 180, 1)
        condition_array.yaw_modifier_speed = gui.Slider(anti_aim_advanced_settings, "yaw_modifier_speed_" .. element_varname, "Yaw Modifier Speed", 2, 1.5, 64, 0.5)
    end
end

--instantly call this function to create gui anti-aims on load
createAntiAimGui()


--simple settings
local anti_aim_simple_settings = gui.Groupbox(anti_aim_settings_tab, "Simple Settings", 5, 200, 325, 350);

local anti_aim_simple_settings_ui = 
{
    desync_type = gui.Combobox(anti_aim_simple_settings, "desync_type", "Desync Type", "Default Desync", "Desync Jitter"),
    desync_angle = gui.Combobox(anti_aim_simple_settings, "desync_angle", "Desync Angle", "Disabled", "Low", "Pred-Medium", "Medium", "Pred-High", "High", "Giant"),
    jitter_angle = gui.Combobox(anti_aim_simple_settings, "jitter_angle", "Jitter Angle", "Disabled", "Low", "Pred-Medium", "Medium", "Pred-High", "High", "Giant"),
    yaw_angle = gui.Slider(anti_aim_simple_settings, "yaw_angle", "Yaw Angle", 0, -180, 180, 1)
}


--binds for anti-aims
local anti_aim_binds = gui.Groupbox(anti_aim_settings_tab, "Binds", 340, 10, 290, 350);

local anti_aim_binds_ui = 
{
    --inverter
    desync_inverter = gui.Keybox(anti_aim_binds, "desync_inverter", "Desync Inverter", 70),

    --manuals
    manual_left = gui.Keybox(anti_aim_binds, "yaw_variables.manual_left", "Manual Left", 90),
    manual_back = gui.Keybox(anti_aim_binds, "yaw_variables.manual_back", "Manual Back", 88),
    manual_right = gui.Keybox(anti_aim_binds, "yaw_variables.manual_right", "Manual Right", 67),
    manual_forward = gui.Keybox(anti_aim_binds, "yaw_variables.manual_forward", "Manual Forward", 38)
};


--other settings
local anti_aim_other = gui.Groupbox(anti_aim_settings_tab, "Other", 340, 188, 290, 350);

local anti_aim_other_ui = 
{
    --autodirection
    at_targets = gui.Checkbox(anti_aim_other, "at_targets", "At Targets", false),
    at_edges = gui.Checkbox(anti_aim_other, "at_edges", "At Edges", false),
    anti_backstab = gui.Checkbox(anti_aim_other, "anti_backstab", "Anti-Backstab", false),
    auto_teleport = gui.Checkbox(anti_aim_other, "auto_teleport", "Auto Teleport in Air", false),

    --legit anti-aim
    legit_anti_aim = gui.Checkbox(anti_aim_other, "legit_anti_aim", "Legit Anti-Aim", false),
};


--indicators settings
local anti_aim_indicators = gui.Groupbox(anti_aim_settings_tab, "Indicators", 340, 425, 290, 350);

local anti_aim_indicators_ui = 
{
    --desync side indicators
    desync_side_indicator = gui.Checkbox(anti_aim_indicators, "desync_side_indicator", "Enable Desync Side Indicator", false),
    manuals_indicator = gui.Checkbox(anti_aim_indicators, "manuals_indicator", "Enable Manuals Indicators", false),
};

local desync_side_indicator_color_active = gui.ColorPicker(anti_aim_indicators_ui.desync_side_indicator, "desync_side_indicator_color_active", "", 40, 40, 40, 200)
local desync_side_indicator_color_inactive = gui.ColorPicker(anti_aim_indicators_ui.desync_side_indicator, "desync_side_indicator_color_inactive", "", 85, 125, 225, 200)
local manuals_indicator_color = gui.ColorPicker(anti_aim_indicators_ui.manuals_indicator, "manuals_indicator_color", "", 85, 125, 225, 200)


--rage settings
local anti_aim_rage = gui.Groupbox(anti_aim_settings_tab, "Rage", 340, 555, 290, 350);

local anti_aim_rage_ui = 
{
    --exploits
    double_fire = gui.Checkbox(anti_aim_rage, "double_fire", "Double Fire", false),
    hide_shots = gui.Checkbox(anti_aim_rage, "hide_shots", "Hide Shots", false)
};

--configs, button on the bottom of script
local anti_aim_configs_tab = gui.Tab(gui.Reference("Ragebot"), "anti_aim_configs_tab", "Anti-Aim Configs Tab");
--endregion





--region EDIT_GUI
--just a function which controlling gui visibility in some cases
local advanced_mode_enabled;

local function changeGui()

    --change anti-aims type
    anti_aim_advanced_settings:SetInvisible(not advanced_mode_enabled)
    anti_aim_condition_selector:SetInvisible(not advanced_mode_enabled)
    anti_aim_simple_settings:SetInvisible(advanced_mode_enabled)

    --make invisible not selected elements
    for condition = 1, #anti_aim_elements, 1 do

        --iterating over all elements in condition
        for _, element in pairs(anti_aim_elements[condition]) do

            if (condition_selector:GetValue() + 1) then

                element:SetInvisible((condition_selector:GetValue() + 1) ~= condition)
            end
        end
    end

    anti_aim_elements[1].override_condition:SetInvisible(true)

    --checking for script enable
    anti_aim_mode_selector:SetDisabled(not enable_script:GetValue())
    anti_aim_condition_selector:SetDisabled(not enable_script:GetValue())
    anti_aim_rage:SetDisabled(not enable_script:GetValue())
    anti_aim_indicators:SetDisabled(not enable_script:GetValue())
    anti_aim_other:SetDisabled(not enable_script:GetValue())
    anti_aim_binds:SetDisabled(not enable_script:GetValue())
    anti_aim_simple_settings:SetDisabled(not enable_script:GetValue())
    anti_aim_advanced_settings:SetDisabled(not enable_script:GetValue())
end
--endregion





--region HANDLING
--returning local player condition like moving, in air etc.
local local_entity;

local constants = {}
local anti_aim_conditions_types = {}
anti_aim_conditions_types.GENERAL = 1 
anti_aim_conditions_types.STANDING = 2
anti_aim_conditions_types.DUCKING = 3 
anti_aim_conditions_types.SLOW_WALKING = 4
anti_aim_conditions_types.MOVING = 5 
anti_aim_conditions_types.IN_AIR = 6 

constants.FL_ONGROUND = bit.lshift(1, 0)
constants.FL_DUCKING = bit.lshift(1, 1)
constants.STAND_VELOCITY_THRESHOLD = 10

local function getAntiAimCondition()

    --if local_entity is not valid then returning general
    if not local_entity or not local_entity:IsAlive() then 
        
        return anti_aim_conditions_types.GENERAL
    end

    --useful data of local_entity
    local m_flags = local_entity:GetProp("m_fFlags")
    local velocity = local_entity:GetPropVector("localdata", "m_vecVelocity[0]"):Length()
    local slow_walk_active = gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey"))

    --m_flags positions are basing on bitwise operator
    local in_air = ((bit.band(m_flags, constants.FL_ONGROUND)) == 0)
    local ducking = ((bit.band(m_flags, constants.FL_DUCKING)) == 2)

    --getting anti-aim conditios
    if (velocity <= constants.STAND_VELOCITY_THRESHOLD) and not ducking and not in_air 
            and anti_aim_elements[anti_aim_conditions_types.STANDING].override_condition:GetValue() then

        return anti_aim_conditions_types.STANDING

    elseif (ducking or cheat.IsFakeDucking()) and not in_air 
            and anti_aim_elements[anti_aim_conditions_types.DUCKING].override_condition:GetValue() then
        
        return anti_aim_conditions_types.DUCKING

    elseif (velocity > constants.STAND_VELOCITY_THRESHOLD) and slow_walk_active and not ducking and not in_air 
            and anti_aim_elements[anti_aim_conditions_types.SLOW_WALKING].override_condition:GetValue() then
        
        return anti_aim_conditions_types.SLOW_WALKING

    elseif (velocity > constants.STAND_VELOCITY_THRESHOLD) and not slow_walk_active and not ducking and not in_air 
            and anti_aim_elements[anti_aim_conditions_types.MOVING].override_condition:GetValue() then
        
        return anti_aim_conditions_types.MOVING

    elseif in_air 
            and anti_aim_elements[anti_aim_conditions_types.IN_AIR].override_condition:GetValue() then

        return anti_aim_conditions_types.IN_AIR
    end

    --returning general if other conditions is not matched
    return anti_aim_conditions_types.GENERAL
end


--function, that handling all often-used variables
local real_time, anti_aim_condition, side_switch_delay, should_switch, fake_lag_factor = globals.RealTime(), anti_aim_conditions_types.GENERAL, 2, false, 0;

local current_weapon_group = "shared"
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

local cmd_sendpacket = false
local last_switch_time = 0;

local function handleVariables()

    --local data
    local_entity = entities.GetLocalPlayer()

    --weapon group
    current_weapon_group = string.lower(string.gsub(gui.GetValue("rbot.hitscan.accuracy"), '"', ""))
    for i = 1, #patterns do
        current_weapon_group = string.gsub(current_weapon_group, patterns[i], replacements[i])
    end

    --anti-aims
    anti_aim_condition = getAntiAimCondition()
    advanced_mode_enabled = advanced_mode:GetValue()
    fake_lag_factor = gui.GetValue("misc.fakelag.enable") and gui.GetValue("misc.fakelag.factor") or anti_aim_elements[anti_aim_condition].yaw_modifier_speed:GetValue()

    --time
    real_time = globals.RealTime()

    --side switch delay
    side_switch_delay = ((gui.GetValue("rbot.accuracy.attack.shared.fire") == '"Defensive Warp Fire"' or gui.GetValue("rbot.accuracy.attack." .. current_weapon_group .. ".fire") == '"Defensive Warp Fire"')
                        or (gui.GetValue("rbot.accuracy.attack.shared.fire") == '"Shift Fire"' or gui.GetValue("rbot.accuracy.attack." .. current_weapon_group .. ".fire") == '"Shift Fire"'))
                        and anti_aim_elements[anti_aim_condition].yaw_modifier_speed:GetValue() or fake_lag_factor

    --if jitter speed is 1 then making no checks for delay
    should_switch = (real_time - last_switch_time >= (side_switch_delay * constants.TICK_TIME) and cmd_sendpacket)
end
--endregion





--region ANTI_AIM_BINDS_FUNCTIONS
--inverting desync 
local desync_inverted = false;

local function invertDesync()

    if anti_aim_binds_ui.desync_inverter:GetValue() ~= 0 and input.IsButtonPressed(anti_aim_binds_ui.desync_inverter:GetValue()) then

        --inverting
        desync_inverted = not desync_inverted
    end
end


--when i'm assigning nil to the manual yaw, that mean, that manuals are disabled
--manual anti-aims
local manual_yaw, manual_right, manual_back, manual_left, manual_forward = nil, false, false, false, false;

local function manualAntiAims()

    --this way is much simplier than 3 loops, therefore i prefer it
    if anti_aim_binds_ui.manual_left:GetValue() ~= 0 and input.IsButtonPressed(anti_aim_binds_ui.manual_left:GetValue()) then

        manual_left = not manual_left

        manual_right = false
        manual_back = false
        manual_forward = false

        manual_yaw = manual_left and -90 or nil
    end

    if anti_aim_binds_ui.manual_right:GetValue() ~= 0 and input.IsButtonPressed(anti_aim_binds_ui.manual_right:GetValue()) then

        manual_right = not manual_right

        manual_left = false
        manual_back = false
        manual_forward = false

        manual_yaw = manual_right and 90 or nil
    end

    if anti_aim_binds_ui.manual_back:GetValue() ~= 0 and input.IsButtonPressed(anti_aim_binds_ui.manual_back:GetValue()) then

        manual_back = not manual_back

        manual_right = false
        manual_left = false
        manual_forward = false

        manual_yaw = manual_back and 0 or nil
    end

    if anti_aim_binds_ui.manual_forward:GetValue() ~= 0 and input.IsButtonPressed(anti_aim_binds_ui.manual_forward:GetValue()) then

        manual_forward = not manual_forward

        manual_right = false
        manual_left = false
        manual_back = false

        manual_yaw = manual_forward and 180 or nil
    end
end


--when i'm assigning nil to the legit yaw, that mean, that legit anti-aims are disabled
--legit anti-aims
local legit_yaw = nil;

local function legitAntiAims()

    legit_yaw = anti_aim_other_ui.legit_anti_aim:GetValue() and 180 or nil
end


--controling pitch, at targets, at edjes, based on legit aa and manuals
local function controleAntiAimStates()
    
    local pitch_state;
    local at_targets_state;
    local at_edjes_state;

    --controling states by condtions matches
    if anti_aim_other_ui.legit_anti_aim:GetValue() then

        pitch_state = 0
        at_targets_state = false
        at_edjes_state = false
        gui.SetValue("rbot.antiaim.condition.use", false)

    elseif not anti_aim_other_ui.legit_anti_aim:GetValue() and manual_yaw then

        pitch_state = 1
        at_targets_state = false
        at_edjes_state = false

    elseif not anti_aim_other_ui.legit_anti_aim:GetValue() and not manual_yaw then

        pitch_state = 1
        at_targets_state = anti_aim_other_ui.at_targets:GetValue()
        at_edjes_state = anti_aim_other_ui.at_edges:GetValue()    
    end

    gui.SetValue("rbot.antiaim.advanced.pitch", pitch_state)
    gui.SetValue("rbot.antiaim.condition.autodir.targets", at_targets_state)
    gui.SetValue("rbot.antiaim.condition.autodir.edges", at_edjes_state)
end
--endregion





--region ANTI_AIM_MODIFIERS
constants.TICK_TIME = 1 / 64

local jitter_yaw = 0;
local side_switcher = 1;
local random_yaw = 0;


--all desync modifiers
local desync_angle = 0;

local function advancedDesyncModifier()

    --simply switch desync side by inverte value
    desync_angle = desync_inverted and -anti_aim_elements[anti_aim_condition].desync_range_right:GetValue() or anti_aim_elements[anti_aim_condition].desync_range_left:GetValue()

    --the same work style like yaw jitter 
    if anti_aim_elements[anti_aim_condition].desync_modifier:GetValue() == 1 then

        --if delta time >= switch delay then switching jitter side
        if should_switch then
            
            --switching side
            desync_inverted = not desync_inverted
        end
    end
end


--yaw modifier on simple mode
local function simpleDesync()
    
    desync_angle = desync_inverted and -constants.ANGLE_PER_POSITION * anti_aim_simple_settings_ui.desync_angle:GetValue() 
                                   or constants.ANGLE_PER_POSITION * anti_aim_simple_settings_ui.desync_angle:GetValue()
end


--all yaw modifiers
local function advancedYawModifier()

    --getting yaw for random tank jitter, which changing every 16 ticks
    if globals.TickCount() % 16 == 0 then

        random_yaw = math.random(0, anti_aim_elements[anti_aim_condition].yaw_modifier_range:GetValue()) / 2
    end

    --all yaws by jitter type
    local all_jitter_yaw_values = 
    {
        0,
        (anti_aim_elements[anti_aim_condition].yaw_modifier_range:GetValue() / 2) * side_switcher,
        (side_switcher > 0 and anti_aim_elements[anti_aim_condition].yaw_modifier_range:GetValue() or 0),
        (math.random(0, anti_aim_elements[anti_aim_condition].yaw_modifier_range:GetValue()) / 2) * side_switcher,
        ((anti_aim_elements[anti_aim_condition].yaw_modifier_range:GetValue() + math.random(-10, 10)) / 2) * side_switcher,
        (random_yaw + math.random(-10, 10)) * side_switcher,
    }

    --checking for fake flick
    if anti_aim_elements[anti_aim_condition].yaw_modifier:GetValue() == 6 then

        if real_time - last_switch_time >= ((side_switcher > 0 and 1 or side_switch_delay) * constants.TICK_TIME) and not cmd_sendpacket then

            jitter_yaw = (side_switcher > 0 and 0 or (desync_inverted and 100 or -100))

            side_switcher = -side_switcher
            last_switch_time = real_time
        end
    else

        --if delta time >= switch delay then switching jitter side
        if should_switch then

            jitter_yaw = all_jitter_yaw_values[anti_aim_elements[anti_aim_condition].yaw_modifier:GetValue() + 1]

            side_switcher = -side_switcher  
            last_switch_time = real_time
        end
    end
end


--yaw modifier on simple mode
constants.ANGLE_PER_POSITION = 10;

local function simpleJitter()
    
    --if delta time >= switch delay then switching jitter side
    if should_switch then

        --center jitter
        jitter_yaw = (constants.ANGLE_PER_POSITION * anti_aim_simple_settings_ui.jitter_angle:GetValue()) * side_switcher

        side_switcher = -side_switcher   
        last_switch_time = real_time
    end
end


--selecting current yaw modifier
local function callJitterFunctions()

    if advanced_mode_enabled then
        advancedDesyncModifier()
        advancedYawModifier()
    else
        simpleDesync()
        simpleJitter()
    end
end


--main yaw settings
local main_yaw = 0;

local function mainYaw()

    --checking for advanced mode
    if advanced_mode_enabled then

        main_yaw = desync_inverted and anti_aim_elements[anti_aim_condition].yaw_angle_right:GetValue() or anti_aim_elements[anti_aim_condition].yaw_angle_left:GetValue()
    else

        main_yaw = desync_inverted and anti_aim_simple_settings_ui.yaw_angle:GetValue() or -anti_aim_simple_settings_ui.yaw_angle:GetValue()
    end
end


--anti-backstab
local anti_backstab_yaw = 0;
constants.ANTI_BACKSTAB_DISTANCE = 125;

local function antiBackstab()

    --checking for enable
    if not anti_aim_other_ui.anti_backstab:GetValue() or not local_entity or not local_entity:IsAlive() then
        anti_backstab_yaw = 0
        return
    end

    --iterating over all entities
    for _, entity in pairs(entities.FindByClass("CCSPlayer")) do

        --check entity for valid target
        if entity:GetTeamNumber() ~= local_entity:GetTeamNumber() and entity ~= local_entity and entity:IsPlayer() and entity:IsAlive() then

            --getting distance to entity
            local entity_abs = entity:GetAbsOrigin()
            local local_abs = local_entity:GetAbsOrigin()
            local distance_to_entity = vector.Distance(entity_abs.x, entity_abs.y, entity_abs.z, local_abs.x, local_abs.y, local_abs.z)

            local enemy_weapon = tostring(entity:GetPropEntity("m_hActiveWeapon"))

            --finding entity, with knife and close to us
            if distance_to_entity <= constants.ANTI_BACKSTAB_DISTANCE and type(enemy_weapon) == "string" and string.find(enemy_weapon, "knife") then

                anti_backstab_yaw = 180;
            end
        else

            anti_backstab_yaw = 0;
        end
    end
end


--auto-teleport
--checking for visibility of enity
local function isVisible(entity)

    --checking local entity for valid
    local local_entity = entities.GetLocalPlayer()
    if not local_entity or not local_entity:IsAlive() then
        return  
    end

    --local_eye is our view offset
    local local_eye = local_entity:GetAbsOrigin() + Vector3(0, 0, local_entity:GetPropFloat("localdata", "m_vecViewOffset[2]"))

    --checking only for 4 main hitboxes, due to optimization
    local FIRST_HITBOX_NUMBER = 0;
    local LAST_HITBOX_NUMBER = 3;

    --iterating over all hitboxes to check them to visibility
    for current_hitbox = FIRST_HITBOX_NUMBER, LAST_HITBOX_NUMBER, 1 do

        local trace_to_hitbox = engine.TraceLine(Vector3(local_eye.x, local_eye.y, local_eye.z), entity:GetHitboxPosition(current_hitbox))

        --checking for contents to get trace hitting something or not
        if trace_to_hitbox.contents == 0 then
            return true
        end
    end

    return false
end


local last_teleport_time = 0;
local dt_cache, hs_cache, cache_installed = false, false, false;
constants.TELEPORT_DELAY_TIME = 2;
constants.TELEPORT_TIME = 0.15;

local function autoTeleport()

    --checking for local
    if not local_entity or not local_entity:IsAlive() or not anti_aim_other_ui.auto_teleport:GetValue() then return end 

    --iterating over all entities
    for _, entity in pairs(entities.FindByClass("CCSPlayer")) do

        --check entity for valid target
        if entity:GetTeamNumber() ~= local_entity:GetTeamNumber() and entity ~= local_entity and entity:IsPlayer() and entity:IsAlive() then

            --checking enemy visibility and teleport delay time and to we are in air
            if isVisible(entity) and getAntiAimCondition() == anti_aim_conditions_types.IN_AIR and real_time - last_teleport_time >= constants.TELEPORT_DELAY_TIME then

                --collecting cache
                hs_cache, dt_cache, cache_installed = anti_aim_rage_ui.hide_shots:GetValue(), anti_aim_rage_ui.double_fire:GetValue(), false;

                --disabling exploits and because script has bind for DT and HS it will be automatically enabled
                anti_aim_rage_ui.hide_shots:SetValue(false); 
                anti_aim_rage_ui.double_fire:SetValue(false);

                last_teleport_time = real_time;
            end

            --returning to the last cache and checking, that teleport worked for given time
            if not cache_installed and real_time - last_teleport_time >= constants.TELEPORT_TIME then

                anti_aim_rage_ui.hide_shots:SetValue(hs_cache); 
                anti_aim_rage_ui.double_fire:SetValue(dt_cache);

                cache_installed = true;
            end
        end
    end
end
--endregion





--region SET_ANTI_AIMS
--clamping yaw between -180 and 180
local function clampYaw(yaw)

    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end

    return math.floor(yaw)
end


--returning aw desync type
local function getDesyncType()

    return ((anti_aim_elements[anti_aim_condition].desync_type:GetValue() == 0 and advanced_mode_enabled) or (anti_aim_simple_settings_ui.desync_type:GetValue() == 0  and not advanced_mode_enabled)) 
           and " Desync" or " Desync Jitter"
end


--setting base and rotation
local function setAntiAims(cmd)

    cmd_sendpacket = cmd.sendpacket

    gui.SetValue("rbot.antiaim.base", tostring(clampYaw(180 + anti_backstab_yaw + jitter_yaw - main_yaw + (legit_yaw == nil and 0 or legit_yaw) + 
                                                        ((manual_yaw == nil or legit_yaw) and 0 or manual_yaw))) .. getDesyncType())

    gui.SetValue("rbot.antiaim.base.rotation", desync_angle)
end
--endregion





--region RAGE_PART
--separate binds for HS and DT
local function setExploits()

    local exploit_state;

    if anti_aim_rage_ui.double_fire:GetValue() then

        exploit_state = "Defensive Warp Fire"
    elseif anti_aim_rage_ui.hide_shots:GetValue() and not anti_aim_rage_ui.double_fire:GetValue() then

        exploit_state = "Shift Fire"
    else

        exploit_state = "Off" 
    end

    gui.SetValue("rbot.accuracy.attack.shared.fire", exploit_state)
    gui.SetValue("rbot.accuracy.attack." .. current_weapon_group .. ".fire", exploit_state)
end
--endregion





--region INDICATORS
constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER = 30;
constants.DESYNC_SIDE_INDICATOR_SIZE_X = 2;
constants.DESYNC_SIDE_INDICATOR_SIZE_Y = 20;

local function drawDesyncSideIndicator()
    
    --checking for enable
    if not anti_aim_indicators_ui.desync_side_indicator:GetValue() or not local_entity or not local_entity:IsAlive() then
        return 
    end
    
    --getting screen sizes
    local screen_width, screen_height = draw.GetScreenSize()

    --checking for desync side
    if not desync_inverted then

        --right
        draw.Color(desync_side_indicator_color_active:GetValue())
        draw.FilledRect(screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER, screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                        screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DESYNC_SIDE_INDICATOR_SIZE_X, 
                        screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)

        --left
        draw.Color(desync_side_indicator_color_inactive:GetValue())
        draw.FilledRect(screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DESYNC_SIDE_INDICATOR_SIZE_X, 
                        screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                        screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER, 
                        screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)
    else

        --right
        draw.Color(desync_side_indicator_color_inactive:GetValue())
        draw.FilledRect(screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER, screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                        screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DESYNC_SIDE_INDICATOR_SIZE_X, 
                        screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)

        --left
        draw.Color(desync_side_indicator_color_active:GetValue())
        draw.FilledRect(screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DESYNC_SIDE_INDICATOR_SIZE_X, 
                        screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                        screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER, 
                        screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)
    end

    --drawing outline rect for main rects
    draw.Color(10, 10, 10, 255)
    draw.OutlinedRect(screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - 1, screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                      screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DESYNC_SIDE_INDICATOR_SIZE_X + 1, 
                      screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)

    draw.OutlinedRect(screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DESYNC_SIDE_INDICATOR_SIZE_X - 1,
                      screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 + 1,
                      screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + 1, 
                      screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_SIZE_Y / 2 - 1)
end


constants.MANUALS_INDICATOR_SIZE_X = 22;
constants.MANUALS_INDICATOR_SIZE_Y = 22;
constants.DISTANCE_FROM_SIDE_INDICATORS = 5;

local function drawManualIndicators()

    if not anti_aim_indicators_ui.manuals_indicator:GetValue() or not local_entity or not local_entity:IsAlive() then
        return 
    end

    --getting screen sizes
    local screen_width, screen_height = draw.GetScreenSize()

    draw.Color(manuals_indicator_color:GetValue())
    
    --checking for manuals
    if manual_right then

        draw.Triangle(screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_height / 2 - constants.MANUALS_INDICATOR_SIZE_Y / 2,
                      screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS, 
                      screen_height / 2 + constants.MANUALS_INDICATOR_SIZE_Y / 2,
                      screen_width / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS + constants.MANUALS_INDICATOR_SIZE_Y,
                      screen_height / 2)
        
    elseif manual_left then  
        
        draw.Triangle(screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_height / 2 - constants.MANUALS_INDICATOR_SIZE_Y / 2,
                      screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS, 
                      screen_height / 2 + constants.MANUALS_INDICATOR_SIZE_Y / 2,
                      screen_width / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS - constants.MANUALS_INDICATOR_SIZE_Y,
                      screen_height / 2)

    elseif manual_back then
        
        draw.Triangle(screen_width / 2 - constants.MANUALS_INDICATOR_SIZE_X / 2,
                      screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_width / 2 + constants.MANUALS_INDICATOR_SIZE_X / 2,
                      screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_width / 2,
                      screen_height / 2 + constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER + constants.DISTANCE_FROM_SIDE_INDICATORS + constants.MANUALS_INDICATOR_SIZE_Y)

    elseif manual_forward then
        
        draw.Triangle(screen_width / 2 - constants.MANUALS_INDICATOR_SIZE_X / 2,
                      screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_width / 2 + constants.MANUALS_INDICATOR_SIZE_X / 2,
                      screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS,
                      screen_width / 2,
                      screen_height / 2 - constants.DESYNC_SIDE_INDICATOR_DISTANCE_FROM_CENTER - constants.DISTANCE_FROM_SIDE_INDICATORS - constants.MANUALS_INDICATOR_SIZE_Y)
    end
end
--endregion





--region CONFIGS
local configs_gui_array = {}

local configs_multibox = gui.Multibox(anti_aim_configs_tab, "Select Config")
configs_multibox:SetPosX(15)
configs_multibox:SetPosY(20)
configs_multibox:SetWidth(300)

--updating config list
local function updateConfigList()

    --removing all old configs from multibox and clearing the array
    for gui_element_index, gui_element in pairs(configs_gui_array) do

        gui_element:Remove()
    end
    configs_gui_array = {}

    --enumerating all files 
    file.Enumerate(function(file)

        --finding bleeding configs
        if string.find(file, "_bleeding_config.txt") then

            --removing _bleeding_config.txt from name
            local new_name = string.gsub(file, "_bleeding_config.txt", "")

            --adding them to array and multibox
            configs_gui_array[#configs_gui_array + 1] = gui.Checkbox(configs_multibox, new_name, new_name, false)
        end 
    end)
end
updateConfigList()


--returning current active config
local function getCurrentConfig()

    --iterating over all configs and find active
    for gui_element_index, gui_element in pairs(configs_gui_array) do

        if gui_element:GetValue() then

            return gui_element_index
        end
    end

    return 0
end


--disabling all configs, besides active
local function disableInactiveConfigs()

    --iterating over all configs and disable all, besides active
    for gui_element_index, gui_element in pairs(configs_gui_array) do

        gui_element:SetValue(gui_element_index == getCurrentConfig())
    end
end


--gui buttons
local config_name = gui.Editbox(anti_aim_configs_tab, "config_name", "Config Name")
config_name:SetPosX(325)
config_name:SetPosY(20)
config_name:SetWidth(300)


--setting settings of all anti-aim settings
local function setAntiAimSettings(config_data)

    --iterating over all advanced conditions
    for condition = 1, #config_data[1], 1 do

        --array from anti_aim_elements
        local data_array = anti_aim_elements[condition]
        local current_array = config_data[1][condition]

        --override condition checkbox
        data_array.override_condition:SetValue(current_array[1])
        data_array.desync_type:SetValue(current_array[2])
        data_array.desync_modifier:SetValue(current_array[3])
        data_array.desync_range_right:SetValue(current_array[4])
        data_array.desync_range_left:SetValue(current_array[5])
        data_array.yaw_angle_right:SetValue(current_array[6])
        data_array.yaw_angle_left:SetValue(current_array[7])
        data_array.yaw_modifier:SetValue(current_array[8])
        data_array.yaw_modifier_range:SetValue(current_array[9])
        data_array.yaw_modifier_speed:SetValue(current_array[10])
    end

    --filling simple settings settings
    anti_aim_simple_settings_ui.desync_type:SetValue(config_data[2][1])
    anti_aim_simple_settings_ui.desync_angle:SetValue(config_data[2][2])
    anti_aim_simple_settings_ui.jitter_angle:SetValue(config_data[2][3])
    anti_aim_simple_settings_ui.yaw_angle:SetValue(config_data[2][4])
end


--creating lua file, which will have global varialbe with settings, then loading it
local config_load = gui.Button(anti_aim_configs_tab, "Load", function()

    --checking for active config
    if not configs_gui_array[getCurrentConfig()] then

        print("Select config to load")
        return 
    end

    --getting script name
    local config_name = configs_gui_array[getCurrentConfig()]:GetName()

    --opening file and checking data
    local file_open = file.Open(config_name .. "_bleeding_config.txt", 'r')
    local file_data = file_open:Read()
    file_open:Close()

    --adding callback to it to catch global variable
    file_data = file_data .. "\n\ncallbacks.Register('Draw', function() \n\tlocal a = 5 \nend)"

    --writing new script and loading it
    file.Write(config_name .. "_bleeding_config.lua", file_data)
    LoadScript(config_name .. "_bleeding_config.lua")

    --changing anti-aims array to arrays from config
    --script_settings is a global variable from loaded script
    setAntiAimSettings(script_settings)
    
    --unloading loaded script and deleting it
    UnloadScript(config_name .. "_bleeding_config.lua")
    file.Delete(config_name .. "_bleeding_config.lua")
end)
config_load:SetPosX(15)
config_load:SetPosY(75)

--returning settings of all anti-aim settings
local function getAntiAimSettings()

    local advanced_settings_array = {};
    local simple_settings_array = {};

    --iterating over all advanced conditions
    for condition = 1, #anti_aim_elements, 1 do

        --creating new array in condition array
        if not advanced_settings_array[condition] then
            advanced_settings_array[condition] = {}
        end
        local current_array = advanced_settings_array[condition]

        --array from anti_aim_elements
        local data_array = anti_aim_elements[condition]

        --override condition checkbox
        current_array[1] = data_array.override_condition:GetValue() and 1 or 0
        current_array[2] = data_array.desync_type:GetValue()
        current_array[3] = data_array.desync_modifier:GetValue()
        current_array[4] = data_array.desync_range_right:GetValue()
        current_array[5] = data_array.desync_range_left:GetValue()
        current_array[6] = data_array.yaw_angle_right:GetValue()
        current_array[7] = data_array.yaw_angle_left:GetValue()
        current_array[8] = data_array.yaw_modifier:GetValue()
        current_array[9] = data_array.yaw_modifier_range:GetValue()
        current_array[10] = data_array.yaw_modifier_speed:GetValue()
    end

    --filling simple settings settings
    simple_settings_array[1] = anti_aim_simple_settings_ui.desync_type:GetValue()
    simple_settings_array[2] = anti_aim_simple_settings_ui.desync_angle:GetValue()
    simple_settings_array[3] = anti_aim_simple_settings_ui.jitter_angle:GetValue()
    simple_settings_array[4] = anti_aim_simple_settings_ui.yaw_angle:GetValue()

    local anti_aim_settings_text = "script_settings = {{";

    --iterating over all created settings data 
    for condition = 1, #advanced_settings_array, 1 do

        --adding setting for all conditions
        if condition ~= 1 then
            anti_aim_settings_text = anti_aim_settings_text .. ", {" .. table.concat(advanced_settings_array[condition], ", ") .. "}"
        else
            anti_aim_settings_text = anti_aim_settings_text .. "{" .. table.concat(advanced_settings_array[condition], ", ") .. "}"
        end
    end

    --adding simple settings and finishing {}
    anti_aim_settings_text = anti_aim_settings_text .. "}, {" .. table.concat(simple_settings_array, ", ") .. "}}"

    return anti_aim_settings_text
end


--deleting old and creating new file with updated data
local config_save = gui.Button(anti_aim_configs_tab, "Save", function()

    --checking for active config
    if not configs_gui_array[getCurrentConfig()] then

        print("Select config to save")
        return 
    end

    local config_name = configs_gui_array[getCurrentConfig()]:GetName() .. "_bleeding_config.txt"


    file.Delete(config_name)
    file.Write(config_name, getAntiAimSettings())
    updateConfigList()
end)
config_save:SetPosX(175)
config_save:SetPosY(75)


--creating new config file
local config_create = gui.Button(anti_aim_configs_tab, "Create", function()
    
    file.Write(config_name:GetValue() .. "_bleeding_config.txt", getAntiAimSettings())
    updateConfigList()
end)
config_create:SetPosX(335)
config_create:SetPosY(75)

--removing config file
local config_remove = gui.Button(anti_aim_configs_tab, "Remove", function()

    --checking for active config
    if not configs_gui_array[getCurrentConfig()] then

        print("Select config to remove")
        return 
    end

    file.Delete(configs_gui_array[getCurrentConfig()]:GetName() .. "_bleeding_config.txt")
    updateConfigList()
end)
config_remove:SetPosX(495)
config_remove:SetPosY(75)
--endregion





--region CALLBACKS
callbacks.Register("Draw", function()
    
    --gui
    changeGui()

    --checking for script enable
    if enable_script:GetValue() then

        --handlers
        handleVariables()

        --anti-aims
        invertDesync()
        manualAntiAims()

        --indicators
        drawDesyncSideIndicator()
        drawManualIndicators()
    end
end)


callbacks.Register("PostMove", function(cmd)
    
    --checking for script enable
    if enable_script:GetValue() then

        --anti-aims
        legitAntiAims()
        controleAntiAimStates()

        callJitterFunctions()
        mainYaw()
        setAntiAims(cmd)

        antiBackstab()

        autoTeleport()

        --rage
        setExploits()

        --configs
        disableInactiveConfigs()
    end
end)
--endregion





--region USERS_NOTIFY
gui.SetValue("misc.log.console", true)
print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
print("I made really cool and tank anti-aim config, add me to discrod: Henderson Hasselback#0693 to get it!")
print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
--endregion
