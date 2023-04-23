------------------------------------------Credits-------------------------------------------
--                            Holo Panel v2 made by GLadiator                             --
--                                                                                        --
--             Getting muzzle position for nixware by elleqt(thanks so much)              --
--               Gettings muzzle position adapted for aimware by GLadiator                --
------------------------------------------Credits-------------------------------------------

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

local ffi, math_floor, math_abs, string_format, entities_GetLocalPlayer, engine_GetServerIP, globals_RealTime, globals_CurTime, input_IsButtonDown, gui_Reference, gui_GetValue
=
      ffi, math.floor, math.abs, string.format, entities.GetLocalPlayer, engine.GetServerIP, globals.RealTime, globals.CurTime, input.IsButtonDown, gui.Reference, gui.GetValue
;

local draw_Color, draw_Line, draw_FilledRect, draw_RoundedRect, draw_RoundedRectFill, draw_ShadowRect, draw_GetScreenSize, draw_GetTextSize, draw_Text, draw_SetFont, client_WorldToScreen
=
      draw.Color, draw.Line, draw.FilledRect, draw.RoundedRect, draw.RoundedRectFill, draw.ShadowRect, draw.GetScreenSize, draw.GetTextSize, draw.Text, draw.SetFont, client.WorldToScreen
; 

-- Get muzzle position part --
ffi.cdef[[
    void* GetProcAddress( void*, const char* );
    void* GetModuleHandleA( const char* );

    typedef void* ( *GetInterfaceFn )( );
    typedef struct {
        GetInterfaceFn Interface;
        char* InterfaceName;
        void* NextInterface;
    } CInterface;

    typedef struct {
        float x;
        float y;
        float z;
    } Vec3_struct;

    typedef void* ( __thiscall* EntityList_GetClientEntity_t )( void*, int );
    typedef void* ( __thiscall* EntityList_GetClientEntityFromHandle_t )( void*, uintptr_t );

    typedef bool  ( __thiscall* Entity_GetAttachment_t )( void*, int, Vec3_struct* );
    typedef int   ( __thiscall* Weapon_GetMuzzleAttachmentIndexFirstPerson_t )( void*, void* );
    typedef int   ( __thiscall* Weapon_GetMuzzleAttachmentIndexThirdPerson_t )( void* );
]]

mem.CreateInterface = function( module, interfaceName )
    local pCreateInterface = ffi.cast( "int", ffi.C.GetProcAddress( ffi.C.GetModuleHandleA( module ), "CreateInterface" ) )
    local interface = ffi.cast( "CInterface***", pCreateInterface + ffi.cast( "int*", pCreateInterface + 5 )[ 0 ] + 15 )[ 0 ] [0 ]

    while interface ~= ffi.NULL do
        if string.sub( ffi.string( interface.InterfaceName ), 0, -4 ) == interfaceName then
            return interface.Interface( )
        end

        interface = ffi.cast( "CInterface*", interface.NextInterface )
    end

    return 0
end

local muzzle = { };
local ffi_handler = { };

ffi_handler.BindArgument = function( fn, arg )
    return function( ... )
        return fn( arg, ... )
    end
end

ffi_handler.m_interface_type          = ffi.typeof( "uintptr_t**" )
ffi_handler.m_i_client_entity_list    = ffi.cast( ffi_handler.m_interface_type, mem.CreateInterface( "client.dll", "VClientEntityList" )  )
ffi_handler.GetClientEntity           = ffi_handler.BindArgument( ffi.cast( "EntityList_GetClientEntity_t", ffi_handler.m_i_client_entity_list[ 0 ][ 3 ] ), ffi_handler.m_i_client_entity_list )
ffi_handler.GetClientEntityFromHandle = ffi_handler.BindArgument( ffi.cast( "EntityList_GetClientEntityFromHandle_t", ffi_handler.m_i_client_entity_list[ 0 ] [ 4 ] ), ffi_handler.m_i_client_entity_list )

muzzle.m_attachment_index                     = 84
muzzle.m_muzzle_attachment_index_first_person = 468
muzzle.m_muzzle_attachment_index_third_person = 469
muzzle.m_pos                                  = Vector3( 0, 0, 0 )

muzzle.Get = function( )
    if not entities_GetLocalPlayer( ) then return end

    local localplayer       = entities_GetLocalPlayer( )
    if not localplayer:IsAlive( ) then return end

    local my_weapon         = localplayer:GetPropEntity( "m_hActiveWeapon" )
    if not my_weapon or not my_weapon:GetIndex( ) then return end

    local my_weapon_address = ffi_handler.GetClientEntity( my_weapon:GetIndex( ) )

    local viewmodel         = localplayer:GetProp( "m_hViewModel[0]" )
    local viewmodel_ent     = ffi_handler.GetClientEntityFromHandle( viewmodel )
    if not viewmodel_ent then return end

    -- local worldmodel        = my_weapon:GetProp( "m_hWeaponWorldModel" )
    -- local worldmodel_ent    = ffi_handler.GetClientEntityFromHandle( worldmodel )
    -- if not worldmodel_ent then return end

    local viewmodel_vtbl    = ffi.cast( ffi_handler.m_interface_type, viewmodel_ent )[ 0 ]
    local weapon_vtbl       = ffi.cast( ffi_handler.m_interface_type, my_weapon_address )[ 0 ]

    local GetAttachment_fn                       = ffi.cast( "Entity_GetAttachment_t", viewmodel_vtbl[ muzzle.m_attachment_index ] )
    local GetMuzzleAttachmentIndexFirstPerson_fn = ffi.cast( "Weapon_GetMuzzleAttachmentIndexFirstPerson_t", weapon_vtbl[ muzzle.m_muzzle_attachment_index_first_person ] )
    -- local GetMuzzleAttachmentIndexThirdPerson_fn = ffi.cast( "Weapon_GetMuzzleAttachmentIndexThirdPerson_t", weapon_vtbl[ muzzle.m_muzzle_attachment_index_third_person ] )

    local muzzle_attachment_first_person_index   = GetMuzzleAttachmentIndexFirstPerson_fn( my_weapon_address, viewmodel_ent )
    -- local muzzle_attachment_third_person_index   = GetMuzzleAttachmentIndexThirdPerson_fn( my_weapon_address )

    local ret   = ffi.new("Vec3_struct[1]") 
    local state = nil

    -- if not gui_GetValue( "esp.local.thirdperson" ) then
    --     state = GetAttachment_fn( viewmodel_ent, muzzle_attachment_first_person_index, ret )
    -- else
    --     state = GetAttachment_fn( worldmodel_ent, muzzle_attachment_third_person_index, ret )
    -- end
    state = GetAttachment_fn( viewmodel_ent, muzzle_attachment_first_person_index, ret )

    if state == nil then return end

    return { state = state, 
             m_pos = Vector3( ret[ 0 ].x, ret[ 0 ].y, ret[ 0 ].z ) }
end
-- Get muzzle position part --

local RAGEBOT_TAB                    = gui_Reference( "Ragebot", "Aimbot" )

local HOLO_PANEL_SUBTAB              = gui.Groupbox( RAGEBOT_TAB, "Visuals", 328, 510, 296, 1 )

local HOLO_PANEL_MULTIBOX            = gui.Multibox( HOLO_PANEL_SUBTAB, "Holo Panel" )
local HOLO_PANEL_FIRSTPERSON         = gui.Checkbox( HOLO_PANEL_MULTIBOX, "holopanel.firstperson", "First person", false )
local HOLO_PANEL_THIRDPERSON         = gui.Checkbox( HOLO_PANEL_MULTIBOX, "holopanel.thirdperson", "Third person", false )
local HOLO_PANEL_COLORS_MODE         = gui.Combobox( HOLO_PANEL_SUBTAB, "holopanel.colormode", "Colors", "Blue | White", "Red | White", "Black | White", "White | Black", "Rainbow | White", "Custom" );
local HOLO_PANEL_COLORS_MAIN         = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colormain", "Holo Panel Color Main", 65, 190, 255, 255 )
local HOLO_PANEL_COLORS_TEXT         = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colortext", "Holo Panel Color Text", 255, 255, 255, 255 )
local HOLO_PANEL_COLORS_TEXTSHADOW   = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colortextshadow", "Holo Panel Color Text Shadow", 10, 10, 10, 255 )
local HOLO_PANEL_COLORS_TEXTWARNING  = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colortextwarning", "Holo Panel Color Text Warning", 255, 255, 0, 255 )
local HOLO_PANEL_COLORS_TEXTOK       = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colortextok", "Holo Panel Color Text Ok", 100, 255, 100, 255 )
local HOLO_PANEL_COLORS_TEXTBAD      = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.colortextbad", "Holo Panel Color Text Bad", 255, 120, 120, 255 )
local HOLO_PANEL_COLORS_AA_GENERAL   = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.coloraageneral", "Holo Panel Color AA General", 65, 190, 255, 255 )
local HOLO_PANEL_COLORS_AA_BG        = gui.ColorPicker( HOLO_PANEL_COLORS_MODE, "holopanel.coloraabackground", "Holo Panel Color AA Background", 25, 25, 25, 100 )
local HOLO_PANEL_POSITION            = gui.Combobox( HOLO_PANEL_SUBTAB, "holopanel.position", "Position", "Over muzzle", "Under muzzle" );
local HOLO_PANEL_ANIMSPEED           = gui.Slider( HOLO_PANEL_SUBTAB, "holopanel.animspeed", "Animation speed", 50, 1, 100 );
HOLO_PANEL_MULTIBOX:SetDescription( "Holographic panel with weapon and antiaims information." )
HOLO_PANEL_FIRSTPERSON:SetDescription( "Displays holographic panel in first person view." )
HOLO_PANEL_THIRDPERSON:SetDescription( "Displays holographic panel in third person view." )
HOLO_PANEL_COLORS_MODE:SetDescription( "Holographic panel color scheme." )
HOLO_PANEL_ANIMSPEED:SetDescription( "The speed of movement of the panel from the muzzle." )

----------------------------------------------------------------------------------------------------------------------------------------------------
local third_person, first_person;
local ind_x, ind_y = draw_GetScreenSize( ); ind_x, ind_y = ind_x / 2, ind_y / 2;
local muzzle_pos_x, muzzle_pos_y;
local bone_pos_x, bone_pos_y;

local fakeduck, base_angle, left_angle, right_angle = 0;

local color_main          = { 0, 0, 0, 0 };
local color_text          = { 0, 0, 0, 0 };
local color_text_shadow   = { 0, 0, 0, 0 };
local color_text_warning  = { 0, 0, 0, 0 };
local color_text_ok       = { 0, 0, 0, 0 };
local color_text_bad      = { 0, 0, 0, 0 };
local color_aa_general    = { 0, 0, 0, 0 };
local color_aa_background = { 0, 0, 0, 0 };
----------------------------------------------------------------------------------------------------------------------------------------------------

g_font = draw.CreateFont( "Mini 7 Condensed", 10, 400 )

local function ToInt( n )
    local s = tostring( n )
    local i, j = s:find( "%." )
    if i then
        return tonumber( s:sub( 1, i-1 ) )
    else
        return n
    end
end

local function HSVToRGB( h, s, v )
    local r, g, b;
  
    local i = math_floor( h * 6 );
    local f = h * 6 - i;
    local p = v * ( 1 - s );
    local q = v * ( 1 - f * s );
    local t = v * ( 1 - ( 1 - f ) * s );
  
    i = i % 6;
  
    if i == 0 then r, g, b = v, t, p;
    elseif i == 1 then r, g, b = q, v, p;
    elseif i == 2 then r, g, b = p, v, t;
    elseif i == 3 then r, g, b = p, q, v;
    elseif i == 4 then r, g, b = t, p, v;
    elseif i == 5 then r, g, b = v, p, q;
    end;
  
    return r * 255, g * 255, b * 255;
end;

local function draw_ShadowText( x, y, text, text_color, shadow_color )
    draw_Color( shadow_color[ 1 ], shadow_color[ 2 ], shadow_color[ 3 ], shadow_color[ 4 ] );
    draw_Text( x + 1, y, text );
    draw_Text( x, y + 1, text );
    draw_Color( text_color[ 1 ], text_color[ 2 ], text_color[ 3 ], text_color[ 4 ] )
    draw_Text( x, y, text );
end;

local function MenuController( )
    if HOLO_PANEL_FIRSTPERSON:GetValue( ) or HOLO_PANEL_THIRDPERSON:GetValue( ) then
        HOLO_PANEL_COLORS_MODE:SetInvisible( false );
        HOLO_PANEL_ANIMSPEED:SetInvisible( false );

        if HOLO_PANEL_COLORS_MODE:GetValue( ) == 5 then
            HOLO_PANEL_COLORS_MAIN:SetInvisible( false );
            HOLO_PANEL_COLORS_TEXT:SetInvisible( false );
            HOLO_PANEL_COLORS_TEXTSHADOW:SetInvisible( false );
            HOLO_PANEL_COLORS_TEXTWARNING:SetInvisible( false );
            HOLO_PANEL_COLORS_TEXTOK:SetInvisible( false );
            HOLO_PANEL_COLORS_TEXTBAD:SetInvisible( false );
            HOLO_PANEL_COLORS_AA_GENERAL:SetInvisible( false );
            HOLO_PANEL_COLORS_AA_BG:SetInvisible( false );
        else
            HOLO_PANEL_COLORS_MAIN:SetInvisible( true );
            HOLO_PANEL_COLORS_TEXT:SetInvisible( true );
            HOLO_PANEL_COLORS_TEXTSHADOW:SetInvisible( true );
            HOLO_PANEL_COLORS_TEXTWARNING:SetInvisible( true );
            HOLO_PANEL_COLORS_TEXTOK:SetInvisible( true );
            HOLO_PANEL_COLORS_TEXTBAD:SetInvisible( true );
            HOLO_PANEL_COLORS_AA_GENERAL:SetInvisible( true );
            HOLO_PANEL_COLORS_AA_BG:SetInvisible( true );
        end;
    else
        HOLO_PANEL_ANIMSPEED:SetInvisible( true );
        HOLO_PANEL_COLORS_MODE:SetInvisible( true );
        HOLO_PANEL_COLORS_MAIN:SetInvisible( true );
        HOLO_PANEL_COLORS_TEXT:SetInvisible( true );
        HOLO_PANEL_COLORS_TEXTSHADOW:SetInvisible( true );
        HOLO_PANEL_COLORS_TEXTWARNING:SetInvisible( true );
        HOLO_PANEL_COLORS_TEXTOK:SetInvisible( true );
        HOLO_PANEL_COLORS_TEXTBAD:SetInvisible( true );
        HOLO_PANEL_COLORS_AA_GENERAL:SetInvisible( true );
        HOLO_PANEL_COLORS_AA_BG:SetInvisible( true );
    end;
end;

local function Drawholopanel( x1, y1, x2, y2, clr, sclr, tclr, frclr, fclr, sxclr, svclr, eclr )
    draw_SetFont( g_font );
    ----------------------------------------------------------------
    local start_x, start_y = x1, y1;
    local end_x, end_y = start_x + 150, start_y + 75;
    ----------------------------------------------------------------
    draw_Color( clr[ 1 ], clr[ 2 ], clr[ 3 ], clr[ 4 ] );
    draw_ShadowRect( start_x, start_y, end_x, end_y, 35 );
    draw_Color( clr[ 1 ], clr[ 2 ], clr[ 3 ], clr[ 4 ] / 4 );
    draw_Line( x2, y2, end_x - 4, end_y - 5 )
    draw_RoundedRectFill( start_x, start_y, end_x, end_y, 13, true, true, true, true );
    draw_RoundedRect( start_x, start_y, end_x, end_y, 13, true, true, true, true );
    ----------------------------------------------------------------
    draw_ShadowText( start_x + 75 - ToInt( draw_GetTextSize( "INFO ABOUT WEAPON: " .. WEAPON_CURRENT_GROUP ) / 2 ), start_y + 3, "INFO ABOUT WEAPON: " .. WEAPON_CURRENT_GROUP, sclr, tclr );
    draw_ShadowRect( start_x + 1, start_y + 13, end_x - 1, start_y + 13, 1 );
    ----------------------------------------------------------------
    local left_x, left_y = start_x + 6, start_y + 17; 
    local right_x, right_y = start_x + 144, start_y + 17;
    ----------------------------------------------------------------
    local hitchance   = gui_GetValue( "rbot.hitscan.accuracy." .. WEAPON_CURRENT_GROUP .. ".hitchance" );
    draw_ShadowText( left_x, left_y, "HIT CHANCE: " .. hitchance, sclr, tclr );
    left_y = left_y + 10;
    ----------------------------------------------------------------
    local mindamage   = gui_GetValue( "rbot.hitscan.accuracy." .. WEAPON_CURRENT_GROUP .. ".mindamage" );
    draw_ShadowText( left_x, left_y, "MIN DAMAGE: " .. mindamage, sclr, tclr );
    left_y = left_y + 10;
    ----------------------------------------------------------------
    local inaccuracy  = entities_GetLocalPlayer( ):GetWeaponInaccuracy( );
    if inaccuracy then 
        draw_ShadowText( left_x, left_y, "INACCURACY: " .. string_format( "%0.3f", inaccuracy ), sclr, tclr );
    end
    left_y = left_y + 10;
    ----------------------------------------------------------------
    local primary_attack = entities_GetLocalPlayer( ):GetPropEntity( "m_hActiveWeapon" ):GetPropFloat( "LocalActiveWeaponData", "m_flNextPrimaryAttack" );
    local fire_mode      = gui_GetValue( "rbot.accuracy.attack." .. WEAPON_CURRENT_GROUP .. ".fire" )
    
    if fire_mode ~= "\"Off\"" then
        if fire_mode == "\"Shift Fire\"" then
            if primary_attack > globals_CurTime( ) or fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: SHIFT" ) , right_y, "FIRE: SHIFT", sxclr, tclr );
            else
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: SHIFT" ) , right_y, "FIRE: SHIFT", svclr, tclr );
            end
        elseif fire_mode == "\"Defensive Fire\"" then
            if primary_attack > globals_CurTime( ) or fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: DEFENSIVE" ) , right_y, "FIRE: DEFENSIVE", sxclr, tclr );
            else
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: DEFENSIVE" ) , right_y, "FIRE: DEFENSIVE", svclr, tclr );
            end
        elseif fire_mode == "\"Defensive Warp Fire\"" then
            if primary_attack > globals_CurTime( ) or fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: WARP" ) , right_y, "FIRE: WARP", sxclr, tclr );
            else
                draw_ShadowText( right_x - draw_GetTextSize( "FIRE: WARP" ) , right_y, "FIRE: WARP", svclr, tclr );
            end
        end
    else
        draw_ShadowText( right_x - draw_GetTextSize( "FIRE: OFF" ) , right_y, "FIRE: OFF", eclr, tclr );
    end
    right_y = right_y + 10;
    ----------------------------------------------------------------
    if gui_GetValue( "rbot.aim.posadj.resolver" ) == 0 then 
        draw_ShadowText( right_x - draw_GetTextSize( "RESOLVER: OFF" ) , right_y, "RESOLVER: OFF", eclr, tclr );
    elseif gui_GetValue( "rbot.aim.posadj.resolver" ) == 1 then 
        draw_ShadowText( right_x - draw_GetTextSize( "RESOLVER: ROLL" ) , right_y, "RESOLVER: ROLL", svclr, tclr );
    elseif gui_GetValue( "rbot.aim.posadj.resolver" ) == 2 then
        draw_ShadowText( right_x - draw_GetTextSize( "RESOLVER: DEF" ) , right_y, "RESOLVER: DEF", svclr, tclr );
    end
    right_y = right_y + 10;
    ----------------------------------------------------------------
    if fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
        if primary_attack > globals_CurTime( ) then
            draw_ShadowText( right_x - draw_GetTextSize( "FAKE DUCK" ) , right_y, "FAKE DUCK", sxclr, tclr );
        else
            draw_ShadowText( right_x - draw_GetTextSize( "FAKE DUCK" ) , right_y, "FAKE DUCK", svclr, tclr );
        end
    else
        draw_ShadowText( right_x - draw_GetTextSize( "FAKE DUCK" ) , right_y, "FAKE DUCK", eclr, tclr );
    end
    ----------------------------------------------------------------
    local base_angle  = math_abs( gui_GetValue( "rbot.antiaim.base.rotation" ) );
    local left_angle  = math_abs( gui_GetValue( "rbot.antiaim.left.rotation" ) );
    local right_angle = math_abs( gui_GetValue( "rbot.antiaim.right.rotation" ) );

    draw_ShadowText( left_x + 21 - ToInt( draw_GetTextSize( "LEFT" ) / 2 ), left_y, "LEFT", sclr, tclr )
    draw_Color( fclr[ 1 ], fclr[ 2 ], fclr[ 3 ], fclr[ 4 ] );
    draw_ShadowRect( left_x, left_y + 8, left_x + 44, left_y + 8 + 7, 8 )
    draw_RoundedRectFill( left_x, left_y + 8, left_x + 44, left_y + 8 + 8, 4, true, true, true, true );
    if left_angle >= 6 and gui_GetValue( "rbot.antiaim.condition.autodir.edges" ) then
        draw_Color( frclr[ 1 ], frclr[ 2 ], frclr[ 3 ], frclr[ 4 ] );
        draw_RoundedRectFill( left_x, left_y + 8, left_x + ( left_angle / 1.32 ), left_y + 8 + 8, 3, true, true, true, true )
    end

    draw_ShadowText( left_x + 21 + 3 + 44 - ToInt( draw_GetTextSize( "BASE" ) / 2 ), left_y, "BASE", sclr, tclr )
    draw_Color( fclr[ 1 ], fclr[ 2 ], fclr[ 3 ], fclr[ 4 ] );
    draw_ShadowRect( left_x + 44 + 3, left_y + 8, left_x + 44 + 3 + 44, left_y + 8 + 7, 8 )
    draw_RoundedRectFill( left_x + 44 + 3, left_y + 8, left_x + 44 + 3 + 44, left_y + 8 + 8, 4, true, true, true, true );
    if base_angle >= 6 then
        draw_Color( frclr[ 1 ], frclr[ 2 ], frclr[ 3 ], frclr[ 4 ] );
        draw_RoundedRectFill( left_x + 44 + 3, left_y + 8, left_x + 44 + 3 + ( base_angle / 1.32 ), left_y + 8 + 8, 3, true, true, true, true )
    end

    draw_ShadowText( left_x + 21 + 3 + 44 + 3 + 44 - ToInt( draw_GetTextSize( "RIGHT" ) / 2 ), left_y, "RIGHT", sclr, tclr )
    draw_Color( fclr[ 1 ], fclr[ 2 ], fclr[ 3 ], fclr[ 4 ] );
    draw_ShadowRect( left_x + 44 + 3 + 44 + 3, left_y + 8, left_x + 44 + 3 + 44 + 3 + 44, left_y + 8 + 7, 8 )
    draw_RoundedRectFill( left_x + 44 + 3 + 44 + 3, left_y + 8, left_x + 44 + 3 + 44 + 3 + 44, left_y + 8 + 8, 4, true, true, true, true );
    if right_angle >= 6 and gui_GetValue( "rbot.antiaim.condition.autodir.edges" ) then
        draw_Color( frclr[ 1 ], frclr[ 2 ], frclr[ 3 ], frclr[ 4 ] );
        draw_RoundedRectFill( left_x + 44 + 3 + 44 + 3, left_y + 8, left_x + 44 + 3 + 44 + 3 + ( right_angle / 1.32 ), left_y + 8 + 8, 3, true, true, true, true )
    end
end;

callbacks.Register( "Draw", "HoloPanelPosition", function( ) 
    local muzzle_temp = muzzle.Get( );
    if muzzle_temp == nil then return end;
    muzzle.m_pos = muzzle_temp.m_pos;
    muzzle_pos_x, muzzle_pos_y = client_WorldToScreen( muzzle.m_pos );

    local bone_pos = entities_GetLocalPlayer( ):GetBonePosition( 54 );
    bone_pos_x, bone_pos_y = client_WorldToScreen( bone_pos );
end );

callbacks.Register( "CreateMove", "HoloPanelCreateMove", function( )
    if WEAPON_CURRENT_GROUP == "shared" or WEAPON_CURRENT_GROUP == "knife" then return end;

    if HOLO_PANEL_COLORS_MODE:GetValue( ) == 0 then     -- BLUE    --
        color_main          = { 65, 190, 255, 255 };
        color_text          = { 255, 255, 255, 255 };
        color_text_shadow   = { 10, 10, 10, 180 };
        color_text_warning  = { 255, 255, 0, 255 };
        color_text_ok       = { 100, 255, 100, 255 };
        color_text_bad      = { 255, 125, 125, 255 };
        color_aa_general    = color_main;
        color_aa_background = { 25, 25, 25, 100 };
    elseif HOLO_PANEL_COLORS_MODE:GetValue( ) == 1 then -- RED     --
        color_main          = { 255, 75, 75, 255 };
        color_text          = { 255, 255, 255, 255 };
        color_text_shadow   = { 10, 10, 10, 180 };
        color_text_warning  = { 255, 255, 0, 255 };
        color_text_ok       = { 100, 255, 100, 255 };
        color_text_bad      = { 255, 150, 150, 255 };
        color_aa_general    = color_main;
        color_aa_background = { 25, 25, 25, 100 };
    elseif HOLO_PANEL_COLORS_MODE:GetValue( ) == 2 then -- BLACK   --
        color_main          = { 10, 10, 10, 255 };
        color_text          = { 255, 255, 255, 255 };
        color_text_shadow   = { 0, 0, 0, 0 };
        color_text_warning  = { 255, 255, 0, 255 };
        color_text_ok       = { 100, 255, 100, 255 };
        color_text_bad      = { 255, 50, 50, 255 };
        color_aa_general    = { 255, 255, 255, 255 };
        color_aa_background = { 255, 255, 255, 50 };
    elseif HOLO_PANEL_COLORS_MODE:GetValue( ) == 3 then -- WHITE   --
        color_main          = { 255, 255, 255, 255 };
        color_text          = { 0, 0, 0, 255 };
        color_text_shadow   = { 0, 0, 0, 0 };
        color_text_warning  = { 150, 150, 0, 255 };
        color_text_ok       = { 0, 150, 0, 255 };
        color_text_bad      = { 200, 0, 0, 255 };
        color_aa_general    = color_main;
        color_aa_background = { 25, 25, 25, 100 };
    elseif HOLO_PANEL_COLORS_MODE:GetValue( ) == 4 then -- RAINBOW --
        local r, g, b = HSVToRGB( globals_RealTime( ) * 0.1, 1, 1 );
        color_main          = { r, g, b, 255 };
        color_text          = { 255, 255, 255, 255 };
        color_text_shadow   = { 10, 10, 10, 180 };
        color_text_warning  = { 255, 255, 0, 255 };
        color_text_ok       = { 150, 255, 150, 255 };
        color_text_bad      = { 255, 125, 125, 255 };
        color_aa_general    = color_main;
        color_aa_background = { 25, 25, 25, 100 };
    elseif HOLO_PANEL_COLORS_MODE:GetValue( ) == 5 then -- CUSTOM  --
        color_main          = { HOLO_PANEL_COLORS_MAIN:GetValue( ) };
        color_text          = { HOLO_PANEL_COLORS_TEXT:GetValue( ) };
        color_text_shadow   = { HOLO_PANEL_COLORS_TEXTSHADOW:GetValue( ) };
        color_text_warning  = { HOLO_PANEL_COLORS_TEXTWARNING:GetValue( ) };
        color_text_ok       = { HOLO_PANEL_COLORS_TEXTOK:GetValue( ) };
        color_text_bad      = { HOLO_PANEL_COLORS_TEXTBAD:GetValue( ) };
        color_aa_general    = { HOLO_PANEL_COLORS_AA_GENERAL:GetValue( ) };
        color_aa_background = { HOLO_PANEL_COLORS_AA_BG:GetValue( ) };
    end;

    if HOLO_PANEL_FIRSTPERSON:GetValue( ) and not gui_GetValue( "esp.world.thirdperson" ) then
        if muzzle_pos_x == nil or muzzle_pos_y == nil then return end;

        local need_x, need_y = 0, 0;
        local diff_x, diff_y = 0, 0;

        if HOLO_PANEL_POSITION:GetValue( ) == 0 then
            need_x, need_y = muzzle_pos_x - 182, muzzle_pos_y - 108;
            diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        elseif HOLO_PANEL_POSITION:GetValue( ) == 1 then
            need_x, need_y = muzzle_pos_x - 210, muzzle_pos_y + 70;
            diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        end

        ind_x, ind_y = ind_x + ( diff_x / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) ), ind_y + ( diff_y / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) );
        
        first_person = true;
    else
        first_person = false;
    end;

    if HOLO_PANEL_THIRDPERSON:GetValue( ) and gui_GetValue( "esp.world.thirdperson" ) then
        if bone_pos_x == nil or bone_pos_y == nil then return end;


        local need_x, need_y = 0, 0;
        local diff_x, diff_y = 0, 0;

        if HOLO_PANEL_POSITION:GetValue( ) == 0 then
            need_x, need_y = bone_pos_x - 225, bone_pos_y - 100;
            diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        elseif HOLO_PANEL_POSITION:GetValue( ) == 1 then
            need_x, need_y = bone_pos_x - 50, bone_pos_y + 20;
            diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        end

        ind_x, ind_y = ind_x + ( diff_x / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) ), ind_y + ( diff_y / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) );

        third_person = true;
    else
        third_person = false;
    end;

    fakeduck      = gui_GetValue( "rbot.antiaim.extra.fakecrouchkey" );
    base_angle    = math_abs( gui_GetValue( "rbot.antiaim.base.rotation" ) );
    left_angle    = math_abs( gui_GetValue( "rbot.antiaim.left.rotation" ) );
    right_angle   = math_abs( gui_GetValue( "rbot.antiaim.right.rotation" ) );
end
);

callbacks.Register( "Draw", "HoloPanelDraw", function( )
    MenuController( );

    if WEAPON_CURRENT_GROUP == "shared" or WEAPON_CURRENT_GROUP == "knife" then return end;
    if not entities_GetLocalPlayer( ) or not entities_GetLocalPlayer( ):IsAlive( ) then return end
    if muzzle_pos_x == nil or muzzle_pos_y == nil then return end;

    if first_person then
        Drawholopanel( ToInt( ind_x ), ToInt( ind_y ), ToInt( muzzle_pos_x ), ToInt( muzzle_pos_y ), 
        color_main, color_text, color_text_shadow, color_aa_general, color_aa_background, color_text_warning, color_text_ok, color_text_bad );
    end;

    if third_person then
        if bone_pos_x == nil or bone_pos_y == nil then return end;

        Drawholopanel( ToInt( ind_x ), ToInt( ind_y ), ToInt( bone_pos_x ), ToInt( bone_pos_y ), 
        color_main, color_text, color_text_shadow, color_aa_general, color_aa_background, color_text_warning, color_text_ok, color_text_bad );
    end;
end
);
