--[[--------------------------------------Credits---------------------------------------------------
                         Chieftain Mk.3 made in Ukraine by GLadiator   

  Also, a special big thanks to all the people below, without them some functions would not exist:          
                    Sestain for making it clear how to do the "idealtick"                         
                               filka_nv for freestanding fix     
                                daerisgay for aspect ratio                                   
------------------------------------------Credits-----------------------------------------------]]--

----------[BETA] Per Group Elements LIB made by GLadiator | credits: lennonc1atwit("Per Weapon Gui API")----------
--Current GUI features: 
--pge_Checkbox for create gui.Checkbox for all weapon groups;
--pge_Slider for create gui.Slider for all weapon groups;
--pge_Combobox for create gui.Combobox for all weapon groups;
--pge_Multibox for create gui.Multibox for all weapon groups;

---↓!Below non-user region!↓---

----------Current Weapon Group LIB made by GLadiator & m0nsterJ----------
--Current features:
--Variable WEAPON_CURRENT_GROUP for get current group(config format);
--Variable WEAPON_CURRENT_GROUP_MENU for get current group(menu format);
--Variable WEAPON_CURRENT_ID for get current id;
--Table WEAPON_GROUPS_NAMES includes all groups names(menu format);
--Table WEAPON_GROUPS_NAMES_CONFIG includes all groups name(config format);

---↓!Below non-user region!↓---

local WEAPON_CURRENT_GROUP      = 'shared';
local WEAPON_CURRENT_GROUP_MENU = 'Shared';
local WEAPON_CURRENT_ID         = 0;

local WEAPON_GROUPS_NAMES        = { 'Zeus', 'Pistol', 'Heavy Pistol', 'Submachine Gun', 'Rifle', 'Shotgun', 'Scout', 'Auto Sniper', 'Sniper', 'Light Machine Gun', 'Knife' };
local WEAPON_GROUPS_NAMES_MENU   = { '\"Zeus\"', '\"Pistol\"', '\"Heavy Pistol\"', '\"Submachine Gun\"', '\"Rifle\"', '\"Shotgun\"', '\"Scout\"', '\"Auto Sniper\"', '\"Sniper\"', '\"Light Machine Gun\"', '\"Knife\"' };
local WEAPON_GROUPS_NAMES_CONFIG = { 'zeus', 'pistol', 'hpistol', 'smg', 'rifle', 'shotgun', 'scout', 'asniper', 'sniper', 'lmg', 'knife' };

local entities_GetLocalPlayer, gui_GetValue = entities.GetLocalPlayer, gui.GetValue;
local CWP_WEAPON_IDS_SHARED = { 20, 39, 43, 44, 45, 46, 47, 48, 49, 57, 68 };

callbacks.Register( 'CreateMove', function( )
    if not entities_GetLocalPlayer( ):IsAlive( ) then
        WEAPON_CURRENT_GROUP      = 'shared';
        WEAPON_CURRENT_GROUP_MENU = 'Shared';
        WEAPON_CURRENT_ID     = 0;
        return;
    end

    if WEAPON_CURRENT_ID == entities_GetLocalPlayer( ):GetWeaponID( ) then return; end

    for Key, Value in pairs( CWP_WEAPON_IDS_SHARED ) do
        if entities_GetLocalPlayer( ):GetWeaponID( ) == Value then
            WEAPON_CURRENT_GROUP      = 'shared';
            WEAPON_CURRENT_GROUP_MENU = 'Shared';
            WEAPON_CURRENT_ID     = entities_GetLocalPlayer( ):GetWeaponID( );
            return;
        end
    end

    MenuWeapon = gui_GetValue( 'rbot.accuracy.attack' );
    for Key, Value in pairs( WEAPON_GROUPS_NAMES_MENU ) do
        if Value == MenuWeapon then
            WEAPON_CURRENT_GROUP      = WEAPON_GROUPS_NAMES_CONFIG[ Key ];
            WEAPON_CURRENT_GROUP_MENU = WEAPON_GROUPS_NAMES[ Key ];
            WEAPON_CURRENT_ID     = entities_GetLocalPlayer( ):GetWeaponID( );
        end
    end
end );
----------Current Weapon Group LIB made by GLadiator & m0nsterJ----------

local gui_Reference               = gui.Reference;
local PER_GROUP_ELEMENTS          = { };
local PER_GROUP_ELEMENTS_INTERNAL = { };
local PGE_CUR_WPN_ID              = 0;

-- Elements
function pge_Checkbox( PARENT, VARNAME, NAME, DESCRIPTION, VALUE )
    local ID = #PER_GROUP_ELEMENTS + 1
    PER_GROUP_ELEMENTS[ ID ] = { }

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local WEAPON = WEAPON_GROUPS_NAMES_CONFIG[ k ];
        local temp;

        if type( PARENT ) == 'userdata' then
            temp = gui.Checkbox( PARENT, WEAPON..'.'..VARNAME, NAME, VALUE );
            PER_GROUP_ELEMENTS[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, PARENT };
        else
            temp = gui.Checkbox( PARENT[ WEAPON_GROUPS_NAMES_CONFIG[ k ]][ 1 ], WEAPON..'.'..VARNAME, NAME, VALUE );
            PER_GROUP_ELEMENTS[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, PARENT[ WEAPON_GROUPS_NAMES_CONFIG[ k ] ][ 2 ] };
        end

        temp:SetDescription( DESCRIPTION );
    end
    return PER_GROUP_ELEMENTS[ ID ];
end

function pge_Checkbox_Internal( PARENT, VARNAME, NAME, DESCRIPTION, VALUE )
    local ID = #PER_GROUP_ELEMENTS_INTERNAL + 1;
    PER_GROUP_ELEMENTS_INTERNAL[ ID ] = { };

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local WEAPON = WEAPON_GROUPS_NAMES_CONFIG[ k ];
        local temp;

        if type( gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] ) ) == 'userdata' then
            temp = gui.Checkbox( gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] ), VARNAME, NAME, VALUE );
            PER_GROUP_ELEMENTS_INTERNAL[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] ) };
        else
            temp = gui.Checkbox( gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] )[ WEAPON_GROUPS_NAMES_CONFIG[ k ]][ 1 ], VARNAME, NAME, VALUE );
            PER_GROUP_ELEMENTS_INTERNAL[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] )[ WEAPON_GROUPS_NAMES_CONFIG[ k ]][ 1 ] };
        end

        temp:SetDescription( DESCRIPTION );
    end

    return PER_GROUP_ELEMENTS_INTERNAL[ ID ];
end

function pge_Slider( PARENT, VARNAME, NAME, DESCRIPTION, VALUE, MIN, MAX, STEP )
    local ID = #PER_GROUP_ELEMENTS + 1;
    PER_GROUP_ELEMENTS[ ID ] = { };

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local WEAPON = WEAPON_GROUPS_NAMES_CONFIG[ k ];

        local temp = gui.Slider( PARENT, WEAPON..'.'..VARNAME, NAME, VALUE, MIN, MAX, STEP );
        PER_GROUP_ELEMENTS[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, PARENT };

        temp:SetDescription( DESCRIPTION );
    end

    return PER_GROUP_ELEMENTS[ ID ];
end

function pge_Combobox( PARENT, VARNAME, NAME, DESCRIPTION, ... )
    local ID = #PER_GROUP_ELEMENTS + 1;
    PER_GROUP_ELEMENTS[ ID ] = { };

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local WEAPON = WEAPON_GROUPS_NAMES_CONFIG[ k ];

        local temp = gui.Combobox( PARENT, WEAPON..'.'..VARNAME, NAME, ... );
        PER_GROUP_ELEMENTS[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, PARENT };

        temp:SetDescription( DESCRIPTION );
    end

    return PER_GROUP_ELEMENTS[ ID ];
end

function pge_Combobox_Internal( PARENT, VARNAME, NAME, DESCRIPTION, ... )
    local ID = #PER_GROUP_ELEMENTS_INTERNAL + 1;
    PER_GROUP_ELEMENTS_INTERNAL[ ID ] = { };

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local WEAPON = WEAPON_GROUPS_NAMES_CONFIG[ k ];

        local temp = gui.Combobox( gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] ), VARNAME, NAME, ... );
        PER_GROUP_ELEMENTS_INTERNAL[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, gui_Reference( PARENT[ 1 ], PARENT[ 2 ], PARENT[ 3 ], WEAPON_GROUPS_NAMES[ k ] ) };

        temp:SetDescription( DESCRIPTION );
    end

    return PER_GROUP_ELEMENTS_INTERNAL[ ID ];
end

function pge_Multibox( PARENT, NAME, DESCRIPTION )
    local ID = #PER_GROUP_ELEMENTS + 1;
    PER_GROUP_ELEMENTS[ ID ] = { };

    for k, v in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        local temp = gui.Multibox( PARENT, NAME );
        PER_GROUP_ELEMENTS[ ID ][ WEAPON_GROUPS_NAMES_CONFIG[ k ] ] = { temp, PARENT };

        temp:SetDescription( DESCRIPTION );
    end

    return PER_GROUP_ELEMENTS[ ID ];
end
-- Elements

callbacks.Register( 'CreateMove', function( )
    --If we are not alive, then we cannot access the local player, therefore, it remains only to hide all the elements until we have gained access to the local player.
    if not entities_GetLocalPlayer( ):IsAlive( ) then
        for ID, Group in pairs( PER_GROUP_ELEMENTS ) do
            for Key, Element in pairs( Group ) do
                Element[ 1 ]:SetInvisible( true );
            end
        end
        return;
    end

    --If local alive, but local weapon ID matches last saved weapon ID then leave
    if PGE_CUR_WPN_ID == entities_GetLocalPlayer( ):GetWeaponID( ) then return; end
    
    if gui_Reference( 'Menu' ):IsActive( ) then
        --Iterate through groups of installed elements.
        for ID, Group in pairs( PER_GROUP_ELEMENTS ) do
            --Iterate through the element group table.
            for Key, Element in pairs( Group ) do
                --If the key(name of the weapon element) matches the current group of weapons, then set the display of the element, otherwise invisible.
                if Key == WEAPON_CURRENT_GROUP then
                    Element[ 1 ]:SetInvisible( false );
                else
                    Element[ 1 ]:SetInvisible( true );
                end
            end
        end
    end

    PGE_CUR_WPN_ID = entities_GetLocalPlayer( ):GetWeaponID( );
end );

callbacks.Register( 'Unload', function( )
    --Iterate through groups of installed elements.
    for ID, Group in pairs( PER_GROUP_ELEMENTS ) do 
        --Iterate through the element group table.
        for Key, Element in pairs( Group ) do
            --Remove all created elements by PGE.
           Element[ 1 ]:Remove( );
        end
    end
end );
----------[BETA] Per Group Elements LIB made by GLadiator | credits: lennonc1atwit("Per Weapon Gui API")----------

----------Smart Cache LIB made by GLadiator & Verieth----------
local client_SetConVar, gui_GetValue, gui_SetValue = client.SetConVar, gui.GetValue, gui.SetValue;
local SMART_CACHE = { };

local function SetConVar( ConVar, Value )
    if Value ~= SMART_CACHE[ ConVar ] then
        client_SetConVar( ConVar, Value, true );
        SMART_CACHE[ ConVar ] = Value;
    end;
end;

local function SetProp( Entity, Prop, Value )
    if Value ~= SMART_CACHE[ Prop ] then
        Entity:SetProp( Prop, Value )
        SMART_CACHE[ Prop ] = Value;
    end;
end;

local function SaveValueInCache( VarName )
    SMART_CACHE[ VarName ] = gui_GetValue( VarName );
end;

local function SetValueFromCache( VarName )
    gui_SetValue( VarName, SMART_CACHE[ VarName ] );
end;
----------Smart Cache LIB made by GLadiator & Verieth----------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local math_random, math_abs, draw_GetScreenSize, entities_FindByClass, entities_GetPlayerResources, bit_band, globals_RealTime, globals_TickCount, input_IsButtonDown, input_IsButtonReleased
=
      math.random, math.abs, draw.GetScreenSize, entities.FindByClass, entities.GetPlayerResources, bit.band, globals.RealTime, globals.TickCount, input.IsButtonDown, input.IsButtonReleased
;
local engine_TraceLine, client_GetConVar, input_IsButtonDown, input_IsButtonPressed, input_IsButtonReleased, draw_Color, draw_Triangle, gui_Reference
=
      engine.TraceLine, client.GetConVar, input.IsButtonDown, input.IsButtonPressed, input.IsButtonReleased, draw.Color, draw.Triangle, gui.Reference
;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local CHIEFTAIN_RAGE_ACCURACY_ATTACK_TICKBASE               = pge_Combobox_Internal( { 'Ragebot', 'Accuracy', 'Attack' }, 'tickbase', 'Tickbase Shifting', 'Select how much to shifting tickbase, or leave automatic.', 'Depending on the ping', 'Max Process Ticks', 'Max Process Ticks - 1', 'Max Process Ticks - 2' );
local CHIEFTAIN_RAGE_ACCURACY_ATTACK_KNIFE_PRIMARY_FIRE     = gui.Checkbox( gui_Reference( 'Ragebot', 'Accuracy', 'Attack', 'Knife' ), 'chieftain.primaryfire', 'Fire Mode From Previuos Weapon', false );

local CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS               = gui.Groupbox( gui_Reference( 'Ragebot', 'Accuracy' ), 'Auto Peek Settings', 328, 444, 296, 1 );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE               = gui.Checkbox( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.enable', 'Enable', false );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FIRE                 = pge_Checkbox( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.fire', 'Defensive Warp Fire', 'Always use defensive warp fire when auto peek is active.', false );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_OPTIMAL_TICKBASE     = pge_Checkbox( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.fire.adaptive', 'Optimal Tickbase Shifting', 'Optimal tickbase shifting with fire mode during auto peek.', false );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FREESTANDING         = pge_Checkbox( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.freestanding', 'Auto Direction', 'Auto direction for a safer peek with auto peek.', false );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE       = pge_Checkbox( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.mindamage', 'Damage Override', 'Sets your damage value when auto peek is active.', false );
local CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE = pge_Slider( CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS, 'chieftain.autopeek.mindamage.value', 'Damage Value', 'Minimum damage required for aimbot to shoot.', 50, 1, 100, 1 );

local CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC                       = gui.Groupbox( gui_Reference( 'Ragebot', 'Hitscan' ), 'Hit Chance While/Without Scoping', 328, 322, 296, 1 );
local CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE                       = pge_Checkbox( CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC, 'chieftain.noscopehc.enable', 'Enable', 'Use if you want to shoot without scoping.', false );
local CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_SCOPE                = pge_Slider( CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC, 'chieftain.noscopehc.regularhc.scoped', 'Hit Chance While Scoping', 'Counter missing due to weapon inaccuracy while scope.', 50, 1, 100, 1 );
local CHIEFTAIN_RAGE_NOSCOPEHC_WARP_SCOPE                   = pge_Slider( CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC, 'chieftain.noscopehc.warphc.scoped', 'Hit Chance Burst While Scoping', 'Hit chance for next shots in warp fire mode while scope.', 50, 1, 100, 1 );
local CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_NOSCOPE              = pge_Slider( CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC, 'chieftain.noscopehc.regularhc.noscoped', 'Hit Chance Without Scoping', 'Counter missing due to weapon inaccuracy without scope.', 50, 1, 100, 1 );
local CHIEFTAIN_RAGE_NOSCOPEHC_WARP_NOSCOPE                 = pge_Slider( CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC, 'chieftain.noscopehc.warphc.noscoped', 'Hit Chance Burst Without Scoping', 'Hit chance for next shots in warp fire mode without scope.', 50, 1, 100, 1 );

local CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MIN         = gui.Slider( gui_Reference( 'Misc', 'Enhancement', 'Fakelag' ), 'chieftain.factor.min', 'Factor Minimum', 16, 3, 61 );
local CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MAX         = gui.Slider( gui_Reference( 'Misc', 'Enhancement', 'Fakelag' ), 'chieftain.factor.max', 'Factor Maximum', 16, 3, 61 );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CHIEFTAIN_RAGE_ACCURACY_ATTACK_KNIFE_PRIMARY_FIRE:SetDescription( 'Sets the fire mode as the previous weapon.' )

CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:SetDescription( 'Use if you want to use fewer binds with auto peek.' );

CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MIN:SetDescription( 'How many minimum fakelags ticks will be choked.' );
CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MAX:SetDescription( 'How many maximum fakelags ticks will be choked.' );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local CHIEFTAIN_ANTIAIM_TAB       = gui_Reference( 'Ragebot', 'Anti-Aim' );

local CHIEFTAIN_ANTIAIM_SUBTAB    = gui.Groupbox( CHIEFTAIN_ANTIAIM_TAB, 'Anti-Aim', 16, 16, 296, 1 );
local CHIEFTAIN_ANTIAIM_CONDITION = gui.Combobox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.condition', 'Condition', 'Standing', 'Slow Walking', 'Running', 'In Air' )

local CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB                = gui.Groupbox( CHIEFTAIN_ANTIAIM_TAB, 'Extra', 328, 16, 296, 1 );
local CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK              = gui.Keybox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.fakeduck', 'Fake Duck', 0 );
local CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR       = gui.Combobox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.fakeduck.factor', 'Fake Duck Factor', 'Max Process Ticks', 'Max Process Ticks - 1', 'Max Process Ticks - 2', 'Custom' );
local CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR_ADJST = gui.Slider( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.fakeduck.factor.adjuster', 'Fake Duck Factor Adjuster', 16, 3, 61 );
local CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS            = gui.Multibox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'Disable Conditions' );
local CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONUSE      = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS, 'chieftain.extra.conditions.onuse', 'On Use', false );
local CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONKNIFE    = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS, 'chieftain.extra.conditions.onknife', 'On Knife', false );
local CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONGRENADE  = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS, 'chieftain.extra.conditions.ongrenade', 'On Grenade', false );
local CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_FREEZETIME = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS, 'chieftain.extra.conditions.freezetime', 'During Freeze Time', false );
local CHIEFTAIN_ANTIAIM_EXTRA_ROLL_ANGLE            = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.roll', 'Roll Angle', false );
local CHIEFTAIN_ANTIAIM_EXTRA_REVERSE_SLIDE_WALK    = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.rsw', 'Reverse Slide Walk', false );
local CHIEFTAIN_ANTIAIM_EXTRA_PREVENT_BACKSTAB      = gui.Checkbox( CHIEFTAIN_ANTIAIM_EXTRA_SUBTAB, 'chieftain.extra.preventbackstab', 'Prevent Knife Backstab', false );

local CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB            = gui.Groupbox( CHIEFTAIN_ANTIAIM_TAB, 'Manual Yaw', 328, 485, 296, 1 );
local CHIEFTAIN_ANTIAIM_MANUALYAW_LEFT              = gui.Keybox( CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB, 'chieftain.manualyaw.left', 'Left', 0 );
local CHIEFTAIN_ANTIAIM_MANUALYAW_RIGHT             = gui.Keybox( CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB, 'chieftain.manualyaw.right', 'Right', 0 );
local CHIEFTAIN_ANTIAIM_MANUALYAW_FORWARD           = gui.Keybox( CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB, 'chieftain.manualyaw.forward', 'Forward', 0 );
local CHIEFTAIN_ANTIAIM_MANUALYAW_BACKWARD          = gui.Keybox( CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB, 'chieftain.manualyaw.backward', 'Backward', 0 );
local CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS         = gui.Checkbox( CHIEFTAIN_ANTIAIM_MANUALYAW_SUBTAB, 'chieftain.manualyaw.attargets', 'At Targets', false )
local CHIEFTAIN_ANTIAIM_MANUALYAW_BACKWARD_COLOR    = gui.ColorPicker(CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS, 'chieftain.manualyaw.backward.color', 255, 255, 255, 255);
local CHIEFTAIN_ANTIAIM_MANUALYAW_FORWARD_COLOR     = gui.ColorPicker(CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS, 'chieftain.manualyaw.forward.color', 255, 255, 255, 255);
local CHIEFTAIN_ANTIAIM_MANUALYAW_RIGHT_COLOR       = gui.ColorPicker(CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS, 'chieftain.manualyaw.right.color', 255, 255, 255, 255);
local CHIEFTAIN_ANTIAIM_MANUALYAW_LEFT_COLOR        = gui.ColorPicker(CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS, 'chieftain.manualyaw.left.color', 255, 255, 255, 255);

local CHIEFTAIN_ANTIAIM_ADVANCED_SUBTAB             = gui.Groupbox( CHIEFTAIN_ANTIAIM_TAB, 'Advanced', 328, 703, 296, 1 );
local CHIEFTAIN_ANTIAIM_ADVANCED_ANGLES_SET_TYPE    = gui.Combobox( CHIEFTAIN_ANTIAIM_ADVANCED_SUBTAB, 'chieftain.advanced.anglessetttype', 'Angles Set', 'Pre Move', 'Post Move' );

local ANTIAIM_ELEMENTS           = { };

local ANTIAIM_CONDITIONS         = { }; ANTIAIM_CONDITIONS.Standing = 1; ANTIAIM_CONDITIONS.SlowWalking = 2; ANTIAIM_CONDITIONS.Running = 3; ANTIAIM_CONDITIONS.InAir = 4;
local ANTIAIM_CONDITIONS_CONFIG  = { 'standing', 'slowwalking', 'running', 'air' };
local ANTIAIM_CURRRENT_CONDITION = 1;
local ANTIAIM_MANUAL_YAW         = 0;

local BIT_FLAGS                  = { }; BIT_FLAGS.FL_ONGROUND = bit.lshift( 1, 0 ); BIT_FLAGS.FL_DUCKING = bit.lshift( 1, 1 );
local GOLDEN_RATIO_VALUE         = 1.61803398874989;

local function AntiAimElementsPerCondition( )
    for Condition = 1, #ANTIAIM_CONDITIONS_CONFIG do
        local ConditionVarName = ANTIAIM_CONDITIONS_CONFIG[ Condition ];

        if not ANTIAIM_ELEMENTS[ Condition ] then
            ANTIAIM_ELEMENTS[ Condition ] = { };
        end
        
        ANTIAIM_ELEMENTS[ Condition ].Pitch             = gui.Combobox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.pitch', 'Pitch Angle', 'Down', '180° (Untrusted)' );
        ANTIAIM_ELEMENTS[ Condition ].RealYaw           = gui.Combobox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw', 'Real Yaw', 'Default' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawOffset     = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.offset', 'Real Yaw Offset', 0, -180, 180 );
        ANTIAIM_ELEMENTS[ Condition ].RealYawMods       = gui.Multibox( CHIEFTAIN_ANTIAIM_SUBTAB, 'Real Yaw Modifers' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitch = gui.Checkbox( ANTIAIM_ELEMENTS[ Condition ].RealYawMods, 'chieftain.'..ConditionVarName..'realyaw.mods.switch', 'Switch', false );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitchDouble = gui.Checkbox( ANTIAIM_ELEMENTS[ Condition ].RealYawMods, 'chieftain.'..ConditionVarName..'realyaw.mods.switch.double', 'Double Switch', false );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsJitter = gui.Checkbox( ANTIAIM_ELEMENTS[ Condition ].RealYawMods, 'chieftain.'..ConditionVarName..'realyaw.mods.jitter', 'Jitter', false );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSpin   = gui.Checkbox( ANTIAIM_ELEMENTS[ Condition ].RealYawMods, 'chieftain.'..ConditionVarName..'realyaw.mods.spin', 'Spin', false );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSwitch     = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.mods.switch.range', 'Real Yaw Switch Range', 0, -180, 180 );
        ANTIAIM_ELEMENTS[ Condition ].RealYawJitter     = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.mods.jitter.range', 'Real Yaw Jitter Range', 1, 1, 180 );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinRange  = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.mods.spin.range', 'Real Yaw Spin Range', 1, 1, 180 );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinSpeed  = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.mods.spin.speed', 'Real Yaw Spin Speed', 1, 1, 100 );
        ANTIAIM_ELEMENTS[ Condition ].FakeYaw           = gui.Combobox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.fakeyaw', 'Fake Yaw', 'Static', 'Switch' );
        ANTIAIM_ELEMENTS[ Condition ].FakeYawValue      = gui.Slider( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.fakeyaw.value', 'Fake Yaw Offset', 0, -58, 58, 2 );
        ANTIAIM_ELEMENTS[ Condition ].FakeYawAutoDir    = gui.Combobox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.fakeyaw.autodir.mode', 'Fake Yaw Auto Direction', 'Off', 'Peek Real', 'Peek Fake' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawAutoDir    = gui.Checkbox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.realyaw.autodir', 'Auto Direction', false );
        ANTIAIM_ELEMENTS[ Condition ].AtTargets         = gui.Checkbox( CHIEFTAIN_ANTIAIM_SUBTAB, 'chieftain.'..ConditionVarName..'.attargets', 'At Targets', false );

        ANTIAIM_ELEMENTS[ Condition ].Pitch:SetDescription( 'Head angle to make it harder to hit.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYaw:SetDescription( 'Real yaw type.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawOffset:SetDescription( 'Changing the position of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawMods:SetDescription( 'Various modifications to real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitch:SetDescription( 'Changes the position of real yaw every tick.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitchDouble:SetDescription( 'Double changes the position of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsJitter:SetDescription( 'Adds a random jitter to real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSpin:SetDescription( 'Adds spin to real yaw every tick.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSwitch:SetDescription( 'Switch range of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawJitter:SetDescription( 'Jitter range of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinRange:SetDescription( 'Spin range of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinSpeed:SetDescription( 'Spin speed of real yaw.' );
        ANTIAIM_ELEMENTS[ Condition ].FakeYaw:SetDescription( 'Fake yaw type.' );
        ANTIAIM_ELEMENTS[ Condition ].FakeYawValue:SetDescription( 'Fake yaw offset.' );
        ANTIAIM_ELEMENTS[ Condition ].FakeYawAutoDir:SetDescription( 'Automatically invert a fake yaw on peek.' );
        ANTIAIM_ELEMENTS[ Condition ].RealYawAutoDir:SetDescription( 'Rotate character towards the wall for a safer peek.' );
        ANTIAIM_ELEMENTS[ Condition ].AtTargets:SetDescription( 'Rotate towards enemies to make character harder to hit.' );
    end
end AntiAimElementsPerCondition( );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CHIEFTAIN_ANTIAIM_CONDITION:SetDescription( 'Select a condition for configuring anti-aims.' )

CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK:SetDescription( 'Higher shoot position on crouch.' );
CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR:SetDescription( 'Affects height, speed, and shooting accuracy.' );
CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR_ADJST:SetDescription( 'How many fakeduck ticks will be choked.' );
CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS:SetDescription( 'Conditions under which antiaim will be disabled.' );
CHIEFTAIN_ANTIAIM_EXTRA_ROLL_ANGLE:SetDescription( 'Extend desync range by set the Z angle.' );
CHIEFTAIN_ANTIAIM_EXTRA_REVERSE_SLIDE_WALK:SetDescription( 'Makes the legs take a better position with the slide walk.' );
CHIEFTAIN_ANTIAIM_EXTRA_PREVENT_BACKSTAB:SetDescription( 'Prevents a backstab from an enemy knife.' );

CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS:SetDescription( 'Rotate towards enemies to make character harder to hit.' );

CHIEFTAIN_ANTIAIM_ADVANCED_ANGLES_SET_TYPE:SetDescription( 'Affects how anti-aim will be work.' );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO              = gui.Slider( gui_Reference( 'Visuals', 'World', 'Camera' ), 'aspectratio', 'Aspect Ratio', 100, 70, 130, 5 );

local CHIEFTAIN_VISUALS_WORLD_WORLDEXPOSURE            = gui.Slider( gui_Reference( 'Visuals', 'World', 'Materials' ), 'worldexposure', 'World Exposure', 0, 0, 100, 5 );
local CHIEFTAIN_VISUALS_WORLD_VIEWMODELAMBIENT         = gui.Slider( gui_Reference( 'Visuals', 'World', 'Materials' ), 'modelsambient', 'Models Ambient Light', 0, 0, 100, 5 );
local CHIEFTAIN_VISUALS_WORLD_WORLDAMBIENT             = gui.ColorPicker( gui_Reference( 'Visuals', 'World', 'Materials' ), 'ambient', 'World Ambient Light', 0, 0, 0, 0 );

local CHIEFTAIN_VISUALS_EFFECTS_BLOOM                  = gui.Slider( gui_Reference( 'Visuals', 'Other', 'Effects' ), 'bloom', 'Bloom', 0, 0, 100, 5 );
local CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION         = gui.Checkbox( gui_Reference( 'Visuals', 'Other', 'Effects' ), 'fog', 'Fog Modulation', false );
local CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_COLOR   = gui.ColorPicker( CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION, 'fog.color', 'Fog Modulation Color', 255, 255, 255, 255 );
local CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_DENSITY = gui.Slider( gui_Reference( 'Visuals', 'Other', 'Effects' ), 'fog.density', 'Fog Density', 50, 0, 100, 1 );
local CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_START   = gui.Slider( gui_Reference( 'Visuals', 'Other', 'Effects' ), 'fog.startdis', 'Fog Start Distance', 1000, 0, 5000, 50 );
local CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_END     = gui.Slider( gui_Reference( 'Visuals', 'Other', 'Effects' ), 'fog.enddis', 'Fog End Distance', 5000, 0, 5000, 50 );

local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE              = gui_Reference( 'Visuals', 'Other', 'Performance', 'Performance Options' );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_SHADOWS      = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.shadows', 'Shadow Optimization', false );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_3DSKY        = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.3dsky', 'Disable 3D sky', false );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_FOG          = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.waterskyfog', 'Disable Water And Sky Fog', false );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_BLOOM        = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.bloom', 'Disable Bloom', false );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_BLUR         = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.blur', 'Disable Panorama Blur And Shadow', false );
local CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_OTHER        = gui.Checkbox( CHIEFTAIN_VISUALS_OTHER_PERFORMANCE, 'performance.other', 'Disable Other Shit', false );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO:SetDescription( 'Expanding or narrowing the play space.' );

CHIEFTAIN_VISUALS_WORLD_WORLDEXPOSURE:SetDescription( 'Exposure, or simply the most correct night mode.' );
CHIEFTAIN_VISUALS_WORLD_VIEWMODELAMBIENT:SetDescription( 'Increases the brightness of the player models.' );

CHIEFTAIN_VISUALS_EFFECTS_BLOOM:SetDescription( 'Increases and blurs the lighting. Requires post-processing.' );
CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:SetDescription( 'Simple fog customization. Requires to disable "No Fog".' );

CHIEFTAIN_VISUALS_OTHER_PERFORMANCE:SetDescription( 'Disabling some graphical elements increases FPS.' );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
gui_Reference( 'Misc', 'Enhancement', 'Fakelag', 'Factor' ):SetInvisible( true );

gui_Reference( 'Ragebot', 'Anti-Aim', 'Base Direction' ):SetInvisible( true );
gui_Reference( 'Ragebot', 'Anti-Aim', 'Left Direction' ):SetInvisible( true );
gui_Reference( 'Ragebot', 'Anti-Aim', 'Right Direction' ):SetInvisible( true );
gui_Reference( 'Ragebot', 'Anti-Aim', 'Extra' ):SetInvisible( true );
gui_Reference( 'Ragebot', 'Anti-Aim', 'Advanced' ):SetInvisible( true );
gui_Reference( 'Ragebot', 'Anti-Aim', 'Condition' ):SetInvisible( true );
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local data = http.Get("https://upload.wikimedia.org/wikipedia/commons/4/49/Flag_of_Ukraine.svg");
local img_rgba, img_width, img_height = common.RasterizeSVG(data);
local texture = draw.CreateTexture(img_rgba, img_width, img_height);

panorama.RunScript( [[ 
    LoadoutAPI.IsLoadoutAllowed = () => { return true; }; 
]] );

local OLD_REALTIME  = globals_RealTime( );

local DT_ENABLED    = nil;

local REAL_SWITCH_STATE = 0;
local FAKE_SHOULD_SWITCH = false;

local SV_MAXUSRCMDPROCESSTICKS = gui_Reference( 'Misc', 'Enhancement', 'Server (Advanced)', 'sv_maxusrcmdprocessticks' );

local function ClampYaw( Angle )
    while Angle > 180 do Angle = Angle - 360; end
    while Angle < -180 do Angle = Angle + 360; end
    return Angle;
end;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AntiAimElementsController( )
    for Condition in pairs( ANTIAIM_CONDITIONS_CONFIG ) do
        for Key, Element in pairs( ANTIAIM_ELEMENTS[ Condition ] ) do
            if CHIEFTAIN_ANTIAIM_CONDITION:GetValue( ) + 1 then
                Element:SetInvisible( CHIEFTAIN_ANTIAIM_CONDITION:GetValue( ) + 1 ~= Condition );
            end
        end
        
        ANTIAIM_ELEMENTS[ Condition ].RealYawSwitch:SetDisabled( not ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitch:GetValue( ) );
        ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitchDouble:SetDisabled( not ANTIAIM_ELEMENTS[ Condition ].RealYawModsSwitch:GetValue( ) );
        ANTIAIM_ELEMENTS[ Condition ].RealYawJitter:SetDisabled( not ANTIAIM_ELEMENTS[ Condition ].RealYawModsJitter:GetValue( ) );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinRange:SetDisabled( not ANTIAIM_ELEMENTS[ Condition ].RealYawModsSpin:GetValue( ) );
        ANTIAIM_ELEMENTS[ Condition ].RealYawSpinSpeed:SetDisabled( not ANTIAIM_ELEMENTS[ Condition ].RealYawModsSpin:GetValue( ) );
    end

    CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR_ADJST:SetDisabled( CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR:GetValue( ) ~= 3 );
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function RageMenuController( )
    --STATIC ELEMENTS
    CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_COLOR:SetDisabled( not CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:GetValue( ) );
    CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_DENSITY:SetDisabled( not CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:GetValue( ) );
    CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_START:SetDisabled( not CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:GetValue( ) );
    CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_END:SetDisabled( not CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:GetValue( ) );

    --DYNAMIC ELEMENTS
    --We cannot access the elements, therefore we stop the function.
    if WEAPON_CURRENT_GROUP == 'shared' or WEAPON_CURRENT_GROUP == 'knife' then
        CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetInvisible( true );
        CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC:SetInvisible( true );
        return;
    end

    if gui_GetValue( 'rbot.accuracy.walkbot.peek' ) then
        CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetInvisible( false );

        if WEAPON_CURRENT_GROUP == 'scout' or WEAPON_CURRENT_GROUP == 'sniper' then
            CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetPosY( gui_GetValue( 'rbot.accuracy.walkbot.peektype' ) == 1 and 465 or 519 );
        elseif WEAPON_CURRENT_GROUP == 'asniper' or WEAPON_CURRENT_GROUP == 'pistol' or WEAPON_CURRENT_GROUP == 'hpistol' then
            CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetPosY( gui_GetValue( 'rbot.accuracy.walkbot.peektype' ) == 1 and 409 or 463 );
        else
            CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetPosY( gui_GetValue( 'rbot.accuracy.walkbot.peektype' ) == 1 and 353 or 407 );
        end

        CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FIRE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) );
        CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_OPTIMAL_TICKBASE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) );
        CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FREESTANDING[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) );
        CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) );

        CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[ WEAPON_CURRENT_GROUP][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) or not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
    else
        CHIEFTAIN_SUBTAB_RAGE_AUTOPEEK_SETTINGS:SetInvisible( true );
    end

    if WEAPON_CURRENT_GROUP == 'scout' or WEAPON_CURRENT_GROUP == 'asniper' or WEAPON_CURRENT_GROUP == 'sniper' then
        CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC:SetInvisible( false );

        gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', WEAPON_CURRENT_GROUP_MENU, 'Hit Chance' ):SetDisabled( CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', WEAPON_CURRENT_GROUP_MENU, 'Hit Chance Burst' ):SetDisabled( CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );

        CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_SCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        CHIEFTAIN_RAGE_NOSCOPEHC_WARP_SCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_NOSCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        CHIEFTAIN_RAGE_NOSCOPEHC_WARP_NOSCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:SetDisabled( not CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
    else
        CHIEFTAIN_SUBTAB_RAGE_NOSCOPEHC:SetInvisible( true );
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function Fakelags( )
    if DT_ENABLED or cheat.IsFakeDucking( ) then return; end

    gui_SetValue( 'misc.fakelag.factor', math_random( CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MIN:GetValue( ), CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MAX:GetValue( ) ) );
    SV_MAXUSRCMDPROCESSTICKS:SetValue( CHIEFTAIN_MISC_ENHANCEMENT_FAKELAG_FACTOR_MAX:GetValue( ) );
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function Fire( MaxProcessTicks )
    if WEAPON_CURRENT_GROUP == 'shared' then return; end

    if WEAPON_CURRENT_GROUP == 'knife' and CHIEFTAIN_RAGE_ACCURACY_ATTACK_KNIFE_PRIMARY_FIRE:GetValue( ) then
        gui_SetValue( 'rbot.accuracy.attack.knife.fire', FM_MODE );
        return;
    end

    FM_MODE = gui_GetValue( 'rbot.accuracy.attack.'..WEAPON_CURRENT_GROUP..'.fire' );

    if gui_GetValue( 'rbot.accuracy.attack.'..WEAPON_CURRENT_GROUP..'.fire' ) ~= '\"Off\"' then
        FM_MODE = gui_GetValue( 'rbot.accuracy.attack.'..WEAPON_CURRENT_GROUP..'.fire' );

        if gui_GetValue( 'rbot.accuracy.attack.'..WEAPON_CURRENT_GROUP..'.fire' ) == '\"Defensive Warp Fire\"' then
            if CHIEFTAIN_RAGE_ACCURACY_ATTACK_TICKBASE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) == 0 then
                if gui_GetValue( 'misc.fakelatency.enable' ) then
                    SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks );
                else
                    local LocalPing = entities_GetPlayerResources( ):GetPropInt( 'm_iPing', entities_GetLocalPlayer( ):GetIndex( ) );

                    if LocalPing <= 40 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks );
                    elseif LocalPing > 40 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks - 1 );
                    elseif LocalPing > 80 then
                        SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks - 2 );
                    end
                end
            else
                SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks - CHIEFTAIN_RAGE_ACCURACY_ATTACK_TICKBASE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) + 1 );
            end
        else
            SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks );
        end

        DT_ENABLED = true;
    else
        DT_ENABLED = false;
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local AutopeekState  = false;

local function SetAutopeekValuesFromCache( )
    for ID, WeaponGroup in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        SetValueFromCache( 'rbot.accuracy.attack.'..WeaponGroup..'.fire' );
    end

    for Condition, ConditionName in pairs( ANTIAIM_CONDITIONS_CONFIG ) do
        SetValueFromCache( 'rbot.antiaim.chieftain.'..ConditionName..'.realyaw.autodir' );
    end

    for ID, WeaponGroup in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
        if WeaponGroup ~= 'knife' then
            SetValueFromCache( 'rbot.hitscan.accuracy.'..WeaponGroup..'.mindamage' );
        end
    end

    SV_MAXUSRCMDPROCESSTICKS:SetValue( SMART_CACHE[ 'misc.sv_maxusrcmdprocessticks' ] );
end;

local function AutopeekSettings( GetMaxProcessTicks )
    if CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) then
        if WEAPON_CURRENT_GROUP == 'shared' or WEAPON_CURRENT_GROUP == 'knife' then
            SetAutopeekValuesFromCache( )
            return;
        end

        if not gui_GetValue( 'rbot.accuracy.walkbot.peek' ) or gui_GetValue( 'rbot.accuracy.walkbot.peekkey' ) == 0 then return; end

        gui_SetValue( 'rbot.accuracy.walkbot.peektype', 0 );

        if input_IsButtonDown( gui_GetValue( 'rbot.accuracy.walkbot.peekkey' ) ) and not AutopeekState then
            if CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FIRE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) then
                if WEAPON_CURRENT_GROUP ~= 'knife' then
                    gui_SetValue( 'rbot.accuracy.attack.'..WEAPON_CURRENT_GROUP..'.fire', '\"Defensive Warp Fire\"' );
                end
            end

            if CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_OPTIMAL_TICKBASE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) then
                SV_MAXUSRCMDPROCESSTICKS:SetValue( GetMaxProcessTicks );
            end

            if CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_FREESTANDING[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) then
                for Condition in pairs( ANTIAIM_CONDITIONS_CONFIG ) do
                    ANTIAIM_ELEMENTS[ Condition ].RealYawAutoDir:SetValue( true );
                end
            end

            if CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) then
                for ID, WeaponGroup in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
                    if WeaponGroup ~= 'knife' then
                        gui_SetValue( 'rbot.hitscan.accuracy.'..WeaponGroup..'.mindamage', CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_MINIMUM_DAMAGE_VALUE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
                    end
                end
            end

            AutopeekState = true;
        elseif input_IsButtonReleased( gui_GetValue( 'rbot.accuracy.walkbot.peekkey' ) ) and AutopeekState then
            SetAutopeekValuesFromCache( );

            AutopeekState = false;
        end
    end

    if not AutopeekState or not CHIEFTAIN_RAGE_AUTOPEEK_SETTINGS_ENABLE:GetValue( ) then
        for ID, WeaponGroup in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
            if WeaponGroup ~= 'knife' then
                SaveValueInCache( 'rbot.accuracy.attack.'..WeaponGroup..'.fire' );
            end
        end

        for Condition, ConditionName in pairs( ANTIAIM_CONDITIONS_CONFIG ) do
            SaveValueInCache( 'rbot.antiaim.chieftain.'..ConditionName..'.realyaw.autodir' );
        end

        for ID, WeaponGroup in pairs( WEAPON_GROUPS_NAMES_CONFIG ) do
            if WeaponGroup ~= 'knife' then
                SaveValueInCache( 'rbot.hitscan.accuracy.'..WeaponGroup..'.mindamage' );
            end
        end

        SMART_CACHE[ 'misc.sv_maxusrcmdprocessticks' ] = SV_MAXUSRCMDPROCESSTICKS:GetValue( );
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function NoScopeHc( )
    if WEAPON_CURRENT_GROUP == 'asniper' or WEAPON_CURRENT_GROUP == 'scout' or WEAPON_CURRENT_GROUP == 'sniper' then
        if not CHIEFTAIN_RAGE_NOSCOPEHC_ENABLE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) then return; end;

        gui_SetValue( 'rbot.accuracy.auto.' .. WEAPON_CURRENT_GROUP .. '.scopeopts.scope', 0 );
        Scoped = entities_GetLocalPlayer( ):GetPropBool( 'm_bIsScoped' );

        if Scoped then
            gui_SetValue( 'rbot.hitscan.accuracy.'..WEAPON_CURRENT_GROUP..'.hitchance', CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_SCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
            gui_SetValue( 'rbot.hitscan.accuracy.'..WEAPON_CURRENT_GROUP..'.hitchanceburst', CHIEFTAIN_RAGE_NOSCOPEHC_WARP_SCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        else
            gui_SetValue( 'rbot.hitscan.accuracy.'..WEAPON_CURRENT_GROUP..'.hitchance', CHIEFTAIN_RAGE_NOSCOPEHC_REGULAR_NOSCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
            gui_SetValue( 'rbot.hitscan.accuracy.'..WEAPON_CURRENT_GROUP..'.hitchanceburst', CHIEFTAIN_RAGE_NOSCOPEHC_WARP_NOSCOPE[ WEAPON_CURRENT_GROUP ][ 1 ]:GetValue( ) );
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AntiAimConditionSet( )
    if not entities_GetLocalPlayer( ) or not entities_GetLocalPlayer( ):IsAlive( ) then
        ANTIAIM_CURRRENT_CONDITION = ANTIAIM_CONDITIONS.Standing;
        return;
    end

    local Velocity = entities_GetLocalPlayer( ):GetPropVector( 'localdata', 'm_vecVelocity[0]' ):Length( );
    local Flags    = entities_GetLocalPlayer( ):GetProp( 'm_fFlags' );
    local AirFlag  = bit_band( Flags, BIT_FLAGS.FL_ONGROUND ) == 0;

    if Velocity < 1.1 and not AirFlag then
        ANTIAIM_CURRRENT_CONDITION = ANTIAIM_CONDITIONS.Standing;
    elseif gui_GetValue( 'rbot.accuracy.movement.slowkey' ) ~= 0 and input_IsButtonDown( gui_GetValue( 'rbot.accuracy.movement.slowkey' ) ) and not AirFlag then
        ANTIAIM_CURRRENT_CONDITION = ANTIAIM_CONDITIONS.SlowWalking;
    elseif Velocity > 1.1 and not AirFlag then
        ANTIAIM_CURRRENT_CONDITION = ANTIAIM_CONDITIONS.Running;
    elseif Velocity > 1.1 and AirFlag then
        ANTIAIM_CURRRENT_CONDITION = ANTIAIM_CONDITIONS.InAir;
    end
end

local function AntiAimPitch( )
    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].Pitch:GetValue( ) == 0 then
        gui_SetValue( "rbot.antiaim.advanced.pitch", 1 );
    elseif ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].Pitch:GetValue( ) == 1 then
        gui_SetValue( "rbot.antiaim.advanced.pitch", 3 );
    end
end

gui_SetValue( 'rbot.antiaim.base', '\"' .. ClampYaw( -180 - 45 + math.fmod( globals.CurTime( ) * ( 5 * 20 ), 90 ) ) .. ' Desync\"' );

local function AntiAimYaw( UserCmd )
    -- REAL YAW
    local RealYawBase  = -180;
    local RealYawLeft  = -180;
    local RealYawRight = -180;

    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYaw:GetValue( ) == 0 then
        RealYawBase = -180 + ( ANTIAIM_MANUAL_YAW ~= 0 and ANTIAIM_MANUAL_YAW or ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawOffset:GetValue( ) );
        if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) then
            RealYawLeft  = 90;
            RealYawRight = -90;
        end
    end

    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawModsSwitch:GetValue( ) then
        if REAL_SWITCH_STATE == 0 then
            RealYawBase = RealYawBase + ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
            if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) then
                RealYawLeft  = RealYawLeft + ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
                RealYawRight = RealYawRight + ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
            end
        elseif REAL_SWITCH_STATE == 1 then
            RealYawBase = RealYawBase - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
            if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) then
                RealYawLeft  = RealYawLeft - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
                RealYawRight = RealYawRight - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSwitch:GetValue( );
            end
        end
    end

    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawModsJitter:GetValue( ) then
        RealYawBase = RealYawBase + math_random( -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ) );
        if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) then
            RealYawLeft  = RealYawLeft + math_random( -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ) );
            RealYawRight = RealYawRight + math_random( -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawJitter:GetValue( ) );
        end
    end

    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawModsSpin:GetValue( ) then
        RealYawBase = RealYawBase - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) + math.fmod( globals_RealTime( ) * ( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 / GOLDEN_RATIO_VALUE * ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinSpeed:GetValue( ) / 2 ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 );
        if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) then
            RealYawLeft  = RealYawLeft - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) + math.fmod( globals_RealTime( ) * ( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 / GOLDEN_RATIO_VALUE * ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinSpeed:GetValue( ) / 2 ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 );
            RealYawRight = RealYawRight - ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) + math.fmod( globals_RealTime( ) * ( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 / GOLDEN_RATIO_VALUE * ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinSpeed:GetValue( ) / 2 ), ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawSpinRange:GetValue( ) * 2 );
        end
    end

    -- SETUP REAL YAW
    gui_SetValue( 'rbot.antiaim.base', '\"'..ClampYaw( RealYawBase )..' Desync\"' );
    gui_SetValue( 'rbot.antiaim.left', '\"'..ClampYaw( RealYawLeft )..' Desync\"' );
    gui_SetValue( 'rbot.antiaim.right', '\"'..ClampYaw( RealYawRight )..' Desync\"' );
    
    -- SETUP FAKE YAW
    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYaw:GetValue( ) == 0 then
        gui_SetValue( 'rbot.antiaim.base.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
        if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) and ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) == 0 then
            gui_SetValue( 'rbot.antiaim.left.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
            gui_SetValue( 'rbot.antiaim.right.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
        end
    elseif ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYaw:GetValue( ) == 1 then
        if FAKE_SHOULD_SWITCH then
            gui_SetValue( 'rbot.antiaim.base.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
            if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) and ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) == 0 then
                gui_SetValue( 'rbot.antiaim.left.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
                gui_SetValue( 'rbot.antiaim.right.rotation', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
            end
        else
            gui_SetValue( 'rbot.antiaim.base.rotation', -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
            if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) and ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) == 0 then
                gui_SetValue( 'rbot.antiaim.left.rotation', -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
                gui_SetValue( 'rbot.antiaim.right.rotation', -ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) );
            end
        end
    end

    -- SETUP FAKE YAW AUTO DIR
    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) == 1 then
        gui_SetValue( 'rbot.antiaim.left.rotation', math_abs( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) ) );
        gui_SetValue( 'rbot.antiaim.right.rotation', -math_abs( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) ) );
    elseif ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) == 2 then
        gui_SetValue( 'rbot.antiaim.left.rotation', -math_abs( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) ) );
        gui_SetValue( 'rbot.antiaim.right.rotation', math_abs( ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawValue:GetValue( ) ) );
    end
end

local function AntiAimAutoDirCorrection( )
    if ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawAutoDir:GetValue( ) or ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].FakeYawAutoDir:GetValue( ) ~= 0 then
        if ( bit_band( entities_GetLocalPlayer( ):GetPropInt( 'm_fFlags' ), 1 ) == 0 ) or cheat.IsFakeDucking( ) then
            gui_SetValue( 'rbot.antiaim.condition.autodir.edges', 0 );
        else
            for i, Player in pairs( entities_FindByClass( 'CCSPlayer' ) ) do
                if Player:GetTeamNumber( ) ~= entities_GetLocalPlayer( ):GetTeamNumber( ) and Player:IsPlayer( ) and Player:IsAlive( ) then
                    local Trace = engine_TraceLine( entities_GetLocalPlayer( ):GetHitboxPosition( 0 ), Player:GetHitboxPosition( 1 ), 0x46004003 )
                    if Trace == nil or Trace.entity == nil then return; end

                    gui_SetValue( 'rbot.antiaim.condition.autodir.edges', not Trace.entity:IsPlayer( ) );
                end
            end
        end
    else
        gui_SetValue( 'rbot.antiaim.condition.autodir.edges', false );
    end
end

local function AntiAimAtTargets( )
    gui_SetValue( 'rbot.antiaim.condition.autodir.targets', ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].AtTargets:GetValue( ) and ANTIAIM_MANUAL_YAW == 0 or CHIEFTAIN_ANTIAIM_MANUALYAW_ATTARGETS:GetValue( ) and ANTIAIM_MANUAL_YAW ~= 0 );
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AntiAimFakeduckAndConditionsAndRoll( )
    gui_SetValue( 'rbot.antiaim.extra.fakecrouchkey', CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK:GetValue( ) );
    gui_SetValue( 'rbot.antiaim.condition.use', CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONUSE:GetValue( ) );
    gui_SetValue( 'rbot.antiaim.condition.knife', CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONKNIFE:GetValue( ) );
    gui_SetValue( 'rbot.antiaim.condition.grenade', CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_ONGRENADE:GetValue( ) );
    gui_SetValue( 'rbot.antiaim.condition.freezetime', CHIEFTAIN_ANTIAIM_EXTRA_CONDITIONS_FREEZETIME:GetValue( ) );
    gui_SetValue( 'rbot.antiaim.advanced.roll', CHIEFTAIN_ANTIAIM_EXTRA_ROLL_ANGLE:GetValue( ) );
end

local function AntiAimReverseSlideWalk( UserCmd )
    gui_Reference( 'Misc', 'Movement', 'Other', 'Slide Walk' ):SetInvisible( CHIEFTAIN_ANTIAIM_EXTRA_REVERSE_SLIDE_WALK:GetValue( ) );
    if CHIEFTAIN_ANTIAIM_EXTRA_REVERSE_SLIDE_WALK:GetValue( ) then
        gui_SetValue( 'misc.slidewalk', not UserCmd.sendpacket );
    end
end

local function AntiAimFakeduckFactor( MaxProcessTicks )
    if cheat.IsFakeDucking( ) then
        if CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR:GetValue( ) == 0 then
            SV_MAXUSRCMDPROCESSTICKS:SetValue( MaxProcessTicks );
        else
            local FD_FACTOR = { MaxProcessTicks - 1, MaxProcessTicks - 2, CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR_ADJST:GetValue( ) };
            SV_MAXUSRCMDPROCESSTICKS:SetValue( FD_FACTOR[ CHIEFTAIN_ANTIAIM_EXTRA_FAKEDUCK_FACTOR:GetValue( ) ] );
        end
    end
end

local function AntiBackstab( )
    if CHIEFTAIN_ANTIAIM_EXTRA_PREVENT_BACKSTAB:GetValue( ) then
        if entities_GetLocalPlayer() ~= nil and entities_GetLocalPlayer():IsAlive() then
            for i, Player in pairs( entities_FindByClass( 'CCSPlayer' ) ) do
                if Player ~= nil and Player:IsPlayer( ) and Player:IsAlive( ) and Player:GetTeamNumber( ) ~= entities_GetLocalPlayer( ):GetTeamNumber( ) then
                    local EnemyOrigin = Player:GetAbsOrigin( );
                    local LocalOrigin = entities_GetLocalPlayer( ):GetAbsOrigin( );
                    local Distance = vector.Distance( { EnemyOrigin.x, EnemyOrigin.y, EnemyOrigin.z }, { LocalOrigin.x, LocalOrigin.y, LocalOrigin.z } );

                    if Player:GetWeaponType( ) == 0 and Distance < 256 then
                        gui_SetValue( 'rbot.antiaim.base', '\"0 Desync\"' );
                        gui_SetValue( 'rbot.antiaim.left', '\"0 Desync\"' );
                        gui_SetValue( 'rbot.antiaim.right', '\"0 Desync\"' );
                    end
                end
            end
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AntiAimManualYaw( )
    if CHIEFTAIN_ANTIAIM_MANUALYAW_LEFT:GetValue( ) ~= 0 and input_IsButtonPressed( CHIEFTAIN_ANTIAIM_MANUALYAW_LEFT:GetValue( ) ) then
        if ANTIAIM_MANUAL_YAW == -90 then
            ANTIAIM_MANUAL_YAW = 0;
        else
            ANTIAIM_MANUAL_YAW = -90;
        end
    elseif CHIEFTAIN_ANTIAIM_MANUALYAW_RIGHT:GetValue( ) ~= 0 and input_IsButtonPressed( CHIEFTAIN_ANTIAIM_MANUALYAW_RIGHT:GetValue( ) ) then
        if ANTIAIM_MANUAL_YAW == 90 then
            ANTIAIM_MANUAL_YAW = 0;
        else
            ANTIAIM_MANUAL_YAW = 90;
        end
    elseif CHIEFTAIN_ANTIAIM_MANUALYAW_FORWARD:GetValue( ) ~= 0 and input_IsButtonPressed( CHIEFTAIN_ANTIAIM_MANUALYAW_FORWARD:GetValue( ) ) then
        if ANTIAIM_MANUAL_YAW == 180 then
            ANTIAIM_MANUAL_YAW = 0;
        else
            ANTIAIM_MANUAL_YAW = 180;
        end
    elseif CHIEFTAIN_ANTIAIM_MANUALYAW_BACKWARD:GetValue( ) ~= 0 and input_IsButtonPressed( CHIEFTAIN_ANTIAIM_MANUALYAW_BACKWARD:GetValue( ) ) then
        if ANTIAIM_MANUAL_YAW == 0.1 then
            ANTIAIM_MANUAL_YAW = 0;
        else
            ANTIAIM_MANUAL_YAW = 0.1;
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AntiAimPerFrame()
    AntiAimManualYaw( );
end

local function AntiAimPer100ms( MaxProcessTicks )
    AntiAimPitch( );
    AntiAimAtTargets( );
    AntiAimFakeduckAndConditionsAndRoll( );
    AntiAimFakeduckFactor( MaxProcessTicks );
end

local function AntiAimCmd( UserCmd )
    AntiAimConditionSet( );

    AntiAimAutoDirCorrection( );

    AntiAimReverseSlideWalk( UserCmd );
    AntiBackstab( );

    if not UserCmd.sendpacket then
        AntiAimYaw( UserCmd );

        FAKE_SHOULD_SWITCH = not FAKE_SHOULD_SWITCH;

        if not ANTIAIM_ELEMENTS[ ANTIAIM_CURRRENT_CONDITION ].RealYawModsSwitchDouble:GetValue( ) then
            REAL_SWITCH_STATE = REAL_SWITCH_STATE == 0 and 1 or 0;
        else
            REAL_SWITCH_STATE = REAL_SWITCH_STATE == 2 and 0 or REAL_SWITCH_STATE + 1;
        end
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function FpsBoost( )
    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_SHADOWS:GetValue( ) then
        SetConVar( 'cl_foot_contact_shadows', 0 );
        SetConVar( 'cl_csm_shadows', 0 );
        SetConVar( 'cl_csm_rope_shadows', 0 );
        SetConVar( 'cl_csm_world_shadows', 0 );
        SetConVar( 'cl_csm_world_shadows_in_viewmodelcascade', 0 );
        SetConVar( 'cl_csm_static_prop_shadows', 0 );
        SetConVar( 'cl_csm_sprite_shadows', 0 );
        SetConVar( 'cl_csm_translucent_shadows', 0 );
        SetConVar( 'cl_csm_viewmodel_shadows', 0 );
        SetConVar( 'cl_minimal_rtt_shadows', 0 );
        SetConVar( 'cl_csm_entity_shadows', 0 );
        SetConVar( 'r_shadows', 0 );
    else
        SetConVar( 'cl_csm_enabled', 1 );
        SetConVar( 'cl_foot_contact_shadows', 1 );
        SetConVar( 'cl_csm_shadows', 1 );
        SetConVar( 'cl_csm_rope_shadows', 1 );
        SetConVar( 'cl_csm_world_shadows', 1 );
        SetConVar( 'cl_csm_world_shadows_in_viewmodelcascade', 1 );
        SetConVar( 'cl_csm_static_prop_shadows', 1 );
        SetConVar( 'cl_csm_sprite_shadows', 1 );
        SetConVar( 'cl_csm_translucent_shadows', 1 );
        SetConVar( 'cl_csm_viewmodel_shadows', 1 );
        SetConVar( 'cl_minimal_rtt_shadows', 0 );
        SetConVar( 'cl_csm_entity_shadows', 1 );
        SetConVar( 'r_shadows', 1 );
    end;

    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_3DSKY:GetValue( ) then
        SetConVar( 'r_3dsky', 0 );
    else
        SetConVar( 'r_3dsky', 1 );
    end;

    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_FOG:GetValue( ) then
        SetConVar( 'fog_enable_water_fog', 0 );
        SetConVar( 'fog_enableskybox', 0 );
    else
        SetConVar( 'fog_enable_water_fog', 1 );
        SetConVar( 'fog_enableskybox', 1 );
    end;

    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_BLOOM:GetValue( ) then
        SetConVar( 'mat_disable_bloom', 1 );
    else
        SetConVar( 'mat_disable_bloom', 0 );
    end;

    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_BLUR:GetValue( ) then
        SetConVar( '@panorama_disable_blur', 1 );
        SetConVar( '@panorama_disable_box_shadow', 1 );
    else
        SetConVar( '@panorama_disable_blur', 0 );
        SetConVar( '@panorama_disable_box_shadow', 0 );
    end

    if CHIEFTAIN_VISUALS_OTHER_PERFORMANCE_OTHER:GetValue( ) then
        SetConVar( 'cl_autohelp', 0 );
        SetConVar( 'cl_disablefreezecam', 1 );
        SetConVar( 'cl_disablehtmlmotd', 1 );
        SetConVar( 'cl_showhelp', 0 );
        SetConVar( 'cl_freezecameffects_showholiday', 0 );
        SetConVar( 'gameinstructor_enable', 0 );
        SetConVar( 'mat_queue_mode', -1 );
        SetConVar( 'r_drawtracers_firstperson', 0 );
        SetConVar( 'r_dynamic', 0 );
    else
        SetConVar( 'cl_autohelp', 1 );
        SetConVar( 'cl_disablefreezecam', 0 );
        SetConVar( 'cl_disablehtmlmotd', 0 );
        SetConVar( 'cl_showhelp', 1 );
        SetConVar( 'cl_freezecameffects_showholiday', 1 );
        SetConVar( 'gameinstructor_enable', 1 );
        SetConVar( 'mat_queue_mode', -1 );
        SetConVar( 'r_drawtracers_firstperson', 1 );
        SetConVar( 'r_dynamic', 1 );
    end;
end;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CACHE_ASPECTRATIO = CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO:GetValue( );

local function SetAspectRatio( AspectRatioMultiplier )
    local ScreenWidth, ScreenHeight = draw_GetScreenSize( );
    local AspectRatioValue = ( ScreenWidth * AspectRatioMultiplier ) / ScreenHeight;
    SetConVar( 'r_aspectratio', tonumber( AspectRatioValue ) );
end;

local function AspectRatio( )
    if CACHE_ASPECTRATIO ~= CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO:GetValue( ) then
        SetAspectRatio( 2 - CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO:GetValue( ) * 0.01 );

        CACHE_ASPECTRATIO = CHIEFTAIN_VISUALS_WORLD_ASPECTRATIO:GetValue( );
    end;
end;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function WorldModulation( )
    local Controller = entities_FindByClass( 'CEnvTonemapController' )[ 1 ];
    if Controller then
        if CHIEFTAIN_VISUALS_WORLD_WORLDEXPOSURE:GetValue( ) then
            SetProp( Controller, 'm_bUseCustomAutoExposureMin', 1 );
            SetProp( Controller, 'm_bUseCustomAutoExposureMax', 1 );
            SetProp( Controller, 'm_flCustomAutoExposureMin', 1.01 - ( CHIEFTAIN_VISUALS_WORLD_WORLDEXPOSURE:GetValue( ) * 0.01 ) );
            SetProp( Controller, 'm_flCustomAutoExposureMax', 1.01 - ( CHIEFTAIN_VISUALS_WORLD_WORLDEXPOSURE:GetValue( ) * 0.01 ) );
        else
            SetProp( Controller, 'm_bUseCustomAutoExposureMin', 0 );
            SetProp( Controller, 'm_bUseCustomAutoExposureMax', 0 );
            SetProp( Controller, 'm_flCustomAutoExposureMin', 2.0 );
            SetProp( Controller, 'm_flCustomAutoExposureMax', 3.0 );
        end

        SetProp( Controller, 'm_bUseCustomBloomScale', 1 );
        SetProp( Controller, 'm_flCustomBloomScaleMinimum', CHIEFTAIN_VISUALS_EFFECTS_BLOOM:GetValue( ) * 0.05 );
        SetProp( Controller, 'm_flCustomBloomScale', CHIEFTAIN_VISUALS_EFFECTS_BLOOM:GetValue( ) * 0.05 );

        SetConVar( 'r_modelAmbientMin', CHIEFTAIN_VISUALS_WORLD_VIEWMODELAMBIENT:GetValue( ) * 0.10 );

        local AmbientR, AmbientG, AmbientB = CHIEFTAIN_VISUALS_WORLD_WORLDAMBIENT:GetValue( );
        SetConVar( 'mat_ambient_light_r', AmbientR / 255 );
        SetConVar( 'mat_ambient_light_g', AmbientG / 255 );
        SetConVar( 'mat_ambient_light_b', AmbientB / 255 );

        if CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION:GetValue( ) then
            SetConVar( 'fog_override', 1 );

            local FogR, FogG, FogB = CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_COLOR:GetValue( );
            SetConVar( 'fog_color', FogR .. ' ' .. FogG .. ' ' .. FogB );
            SetConVar( 'fog_maxdensity', CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_DENSITY:GetValue( ) * 0.01 );
            SetConVar( 'fog_start', CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_START:GetValue( ) );
            SetConVar( 'fog_end', CHIEFTAIN_VISUALS_EFFECTS_FOG_MODULATION_END:GetValue( ) );
        else
            SetConVar( 'fog_override', 0 );
        end;
    end;
end;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
print('============================================================');
print('-----------------Chieftain Mk.3 initialized-----------------');
print('----------------Made in Ukraine by GLadiator----------------');
print('============================================================');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

callbacks.Register( 'Draw', 'ChieftainDrawRage', function( )
    --Controllers
    RageMenuController( );
    AntiAimElementsController( );

    --For working on menu
    FpsBoost( );

    if not entities_GetLocalPlayer( ) or not entities_GetLocalPlayer( ):IsAlive( ) then return; end

    local sv_maxusrcmdprocessticks = client_GetConVar( 'sv_maxusrcmdprocessticks' );

    --Rage
    Fakelags( );
    Fire( sv_maxusrcmdprocessticks );
    AutopeekSettings( sv_maxusrcmdprocessticks );
    AspectRatio( );
    WorldModulation( );

    --Per frame
    AntiAimPerFrame( );

    --Per 100ms (optimization)
    if globals_RealTime( ) > OLD_REALTIME then
        AntiAimPer100ms( sv_maxusrcmdprocessticks );

        OLD_REALTIME = globals_RealTime( ) + 0.100;
    end

    if WEAPON_CURRENT_GROUP == 'shared' or WEAPON_CURRENT_GROUP == 'knife' then return; end

    NoScopeHc( );
end );

callbacks.Register( 'Draw', 'ChieftainDrawVisuals', function()
    gui_Reference('MENU'):SetIcon(texture, 0.7);

    local w, h = draw.GetScreenSize();
    local x1 = w / 2 - 5;
    local x2 = w / 2 + 5;
    local y1 = h / 2 + 20;

    if ANTIAIM_MANUAL_YAW == -90 then
        draw_Color(CHIEFTAIN_ANTIAIM_MANUALYAW_LEFT_COLOR:GetValue());
        draw_Triangle(x1, y1, x1 + 10, y1 + 5, x1 + 10, y1 - 5);
    elseif ANTIAIM_MANUAL_YAW == 90 then
        draw_Color(CHIEFTAIN_ANTIAIM_MANUALYAW_RIGHT_COLOR:GetValue());
        draw_Triangle(x2, y1, x2 - 10, y1 + 5, x2 - 10, y1 - 5);
    elseif ANTIAIM_MANUAL_YAW == 180 then
        draw_Color(CHIEFTAIN_ANTIAIM_MANUALYAW_FORWARD_COLOR:GetValue());
        draw_Triangle(x1, y1 - 5, x1 + 10, y1 - 5, x1 + 5, y1 + 5);
    elseif ANTIAIM_MANUAL_YAW == 0.1 then
        draw_Color(CHIEFTAIN_ANTIAIM_MANUALYAW_BACKWARD_COLOR:GetValue());
        draw_Triangle(x1, y1 + 5, x1 + 10, y1 + 5, x1 + 5, y1 + 5 - 10);
    end
end);

callbacks.Register( 'PreMove', 'ChieftainPreMove', function( UserCmd )
    if CHIEFTAIN_ANTIAIM_ADVANCED_ANGLES_SET_TYPE:GetValue( ) == 0 then
        AntiAimCmd( UserCmd );
    end
end );

callbacks.Register( 'CreateMove', 'ChieftainCreateMove', function( UserCmd )
    if CHIEFTAIN_ANTIAIM_ADVANCED_ANGLES_SET_TYPE:GetValue( ) == 1 then
        AntiAimCmd( UserCmd );
    end
end );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

callbacks.Register( 'Unload', 'ChieftainUnload', function( ) 
    gui_Reference( 'Misc', 'Enhancement', 'Fakelag', 'Factor' ):SetInvisible( false );
    gui_Reference( 'Misc', 'Movement', 'Other', 'Slide Walk' ):SetInvisible( false );

    gui_Reference( 'Ragebot', 'Anti-Aim', 'Base Direction' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Anti-Aim', 'Left Direction' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Anti-Aim', 'Right Direction' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Anti-Aim', 'Extra' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Anti-Aim', 'Advanced' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Anti-Aim', 'Condition' ):SetInvisible( false );

    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Scout', 'Hit Chance' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Scout', 'Hit Chance Burst' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Sniper', 'Hit Chance' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Sniper', 'Hit Chance Burst' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Auto-Sniper', 'Hit Chance' ):SetInvisible( false );
    gui_Reference( 'Ragebot', 'Hitscan', 'Accuracy', 'Auto-Sniper', 'Hit Chance Burst' ):SetInvisible( false );
end );
