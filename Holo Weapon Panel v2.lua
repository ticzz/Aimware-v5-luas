------------------------------------------Credits-------------------------------------------
--                            Holo Panel v2 made by GLadiator                             --
--                                                                                        --
--             Getting muzzle position for nixware by elleqt(thanks so much)              --
--               Gettings muzzle position adapted for aimware by GLadiator                --
--                    Current weapon group from Chieftain by GLadiator                    --
------------------------------------------Credits-------------------------------------------

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
    local localplayer       = entities_GetLocalPlayer( )
    if localplayer == nil or not localplayer:IsAlive( ) then return end

    local my_weapon         = localplayer:GetPropEntity( "m_hActiveWeapon" )
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
local WEAPON_GROUPS_NAME        = { "pistol", "hpistol", "smg", "rifle", "shotgun", "scout", "asniper", "sniper", "lmg", "knife" }
local WEAPON_CURRENT_GROUP      = "global"

local function LPWeaponID( weapon_id )
    for k, v in pairs( weapon_id ) do
        if entities_GetLocalPlayer( ):GetWeaponID( ) == weapon_id[ k ] then
            return true
        end
    end
end

callbacks.Register( "Draw", "CurrentWeaponGroupholopanelRedux", function( )
    if entities_GetLocalPlayer( ) == nil or not entities_GetLocalPlayer( ):IsAlive( ) then return end;
    
    --Iterate through all weapon groups.
    for k, v in pairs( WEAPON_GROUPS_NAME ) do
        --If the ID of the current weapon is not equal to one of the ID table, then set the "global" group in the menu.
        if not LPWeaponID( WEAPONID_ALLWEAPONS ) then
            WEAPON_CURRENT_GROUP = "global";
        end;
        --Iterate through all weapons id
        for k, v in pairs( WEAPONID_ALLWEAPONS ) do
            --If the current weapon ID matches the key from all weapon IDs, then save the current weapon group from the key of all group names.
            if LPWeaponID( WEAPONID_ALLWEAPONS[ k ] ) then
                WEAPON_CURRENT_GROUP = WEAPON_GROUPS_NAME[ k ];
            end;
        end;
    end;
end
);

local RAGEBOT_TAB                    = gui_Reference( "Ragebot", "Aimbot" )

local HOLO_PANEL_SUBTAB              = gui.Groupbox( RAGEBOT_TAB, "Visuals", 16, 376, 296, 1 )

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
local HOLO_PANEL_ANIMSPEED           = gui.Slider( HOLO_PANEL_SUBTAB, "holopanel.animspeed", "Animation speed", 50, 1, 100 );
HOLO_PANEL_MULTIBOX:SetDescription( "Holographic panel with weapon and antiaims information." )
HOLO_PANEL_FIRSTPERSON:SetDescription( "Displays holographic panel in first person view." )
HOLO_PANEL_THIRDPERSON:SetDescription( "Displays holographic panel in third person view." )
HOLO_PANEL_COLORS_MODE:SetDescription( "Holographic panel color scheme." )
HOLO_PANEL_ANIMSPEED:SetDescription( "The speed of movement of the panel from the muzzle." )

----------------------------------------------------------------------------------------------------------------------------------------------------
local sv_maxusrcmdprocessticks      = gui_Reference( "Misc", "General", "Server", "sv_maxusrcmdprocessticks" );

local third_person, first_person;
local ind_x, ind_y = draw_GetScreenSize( ); ind_x, ind_y = ind_x / 2, ind_y / 2;
local muzzle_pos_x, muzzle_pos_y;
local bone_pos_x, bone_pos_y;

local shift_on_shot, fakeduck, shifted_tick, base_angle, left_angle, right_angle = 0;

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
    local end_x, end_y = start_x + 150, start_y + 70;
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
    draw_ShadowText( left_x, left_y, "INACCURACY: " .. string_format( "%0.3f", inaccuracy ), sclr, tclr );
    left_y = left_y + 10;
    ----------------------------------------------------------------
    local primary_attack = entities_GetLocalPlayer( ):GetPropEntity( "m_hActiveWeapon" ):GetPropFloat( "LocalActiveWeaponData", "m_flNextPrimaryAttack" );
    local dt_mode        = gui_GetValue( "rbot.hitscan.accuracy." .. WEAPON_CURRENT_GROUP .. ".doublefire" )
    if dt_mode ~= 0 then
        if dt_mode == 1 then
            if primary_attack > globals_CurTime( ) or fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
                draw_ShadowText( right_x - draw_GetTextSize( shifted_ticks .. " DEFENSIVE DT" ) , right_y, shifted_ticks .. " DEFENSIVE DT", sxclr, tclr );
            else
                draw_ShadowText( right_x - draw_GetTextSize( shifted_ticks .. " DEFENSIVE DT" ) , right_y, shifted_ticks .. " DEFENSIVE DT", svclr, tclr );
            end
        else
            if primary_attack > globals_CurTime( ) or fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
                draw_ShadowText( right_x - draw_GetTextSize( shifted_ticks .. " DEFENSIVE DT" ) , right_y, shifted_ticks .. " DEFENSIVE DT", sxclr, tclr );
            else
                draw_ShadowText( right_x - draw_GetTextSize( shifted_ticks .. " DEFENSIVE DT" ) , right_y, shifted_ticks .. " DEFENSIVE DT", svclr, tclr );
            end
        end
    else
        draw_ShadowText( right_x - draw_GetTextSize( "OFF DT" ) , right_y, "OFF DT", eclr, tclr );
    end
    right_y = right_y + 10;
    ----------------------------------------------------------------
    if shift_on_shot then
        draw_ShadowText( right_x - draw_GetTextSize( "SHIFT ON SHOT" ) , right_y, "SHIFT ON SHOT", svclr, tclr );
    else
        draw_ShadowText( right_x - draw_GetTextSize( "SHIFT ON SHOT" ) , right_y, "SHIFT ON SHOT", eclr, tclr );
    end
    right_y = right_y + 10;
    ----------------------------------------------------------------
    if fakeduck ~= 0 and input_IsButtonDown( fakeduck ) then
        draw_ShadowText( right_x - draw_GetTextSize( "FAKE DUCK" ) , right_y, "FAKE DUCK", svclr, tclr );
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
    if left_angle >= 6 and gui_GetValue( "rbot.antiaim.advanced.autodir.edges" ) then
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
    if right_angle >= 6 and gui_GetValue( "rbot.antiaim.advanced.autodir.edges" ) then
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
    if WEAPON_CURRENT_GROUP == "global" or WEAPON_CURRENT_GROUP == "knife" then return end;

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

    if gui_GetValue( "rbot.hitscan.accuracy." .. WEAPON_CURRENT_GROUP .. ".doublefirefl" ) > 1 then
        shifted_ticks = ( sv_maxusrcmdprocessticks:GetValue( ) - gui_GetValue( "rbot.hitscan.accuracy." .. WEAPON_CURRENT_GROUP .. ".doublefirefl") - 1 );
    else
        shifted_ticks = ( sv_maxusrcmdprocessticks:GetValue( ) - 1 );
    end;

    if gui_GetValue( "rbot.antiaim.advanced.antialign" ) == 0 then
        shifted_ticks = shifted_ticks - 1;
    end;

    if HOLO_PANEL_FIRSTPERSON:GetValue( ) and not gui_GetValue( "esp.local.thirdperson" ) then
        if muzzle_pos_x == nil or muzzle_pos_y == nil then return end;

        local need_x, need_y = muzzle_pos_x - 182, muzzle_pos_y - 108;
        local diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        ind_x, ind_y = ind_x + ( diff_x / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) ), ind_y + ( diff_y / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) );
        
        first_person = true;
    else
        first_person = false;
    end;

    if HOLO_PANEL_THIRDPERSON:GetValue( ) and gui_GetValue( "esp.local.thirdperson" ) then
        if bone_pos_x == nil or bone_pos_y == nil then return end;

        local need_x, need_y = bone_pos_x - 225, bone_pos_y - 100;
        local diff_x, diff_y = need_x - ind_x, need_y - ind_y;
        ind_x, ind_y = ind_x + ( diff_x / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) ), ind_y + ( diff_y / ( 101 - HOLO_PANEL_ANIMSPEED:GetValue( ) ) );

        third_person = true;
    else
        third_person = false;
    end;

    shift_on_shot = gui_GetValue( "rbot.antiaim.condition.shiftonshot" );
    fakeduck      = gui_GetValue( "rbot.antiaim.extra.fakecrouchkey" );
    base_angle    = math_abs( gui_GetValue( "rbot.antiaim.base.rotation" ) );
    left_angle    = math_abs( gui_GetValue( "rbot.antiaim.left.rotation" ) );
    right_angle   = math_abs( gui_GetValue( "rbot.antiaim.right.rotation" ) );
end
);

callbacks.Register( "Draw", "HoloPanelDraw", function( )
    MenuController( );

    if WEAPON_CURRENT_GROUP == "global" or WEAPON_CURRENT_GROUP == "knife" then return end;
    if not entities_GetLocalPlayer( ) or not entities_GetLocalPlayer( ):IsAlive( ) then return end;
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




--***********************************************--

print("♥♥♥ " .. GetScriptName().." loaded without Errors ♥♥♥")