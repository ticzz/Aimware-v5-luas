
-- FOVnViewFovModel changer incl Scopefix --

local visuals_menu = gui.Reference("VISUALS")	-- ("VISUALS", "OTHER", "Effects")

local TAB = gui.Tab(visuals_menu, "lua_fov_tab", "Fov Changer")

local FOVBOX = gui.Groupbox(TAB, "FOV", 15, 15)
local SLIDER = gui.Slider( FOVBOX, "lua_fov_slider", "Field of View", 90, 0, 180 )
local SLIDER_ONE = gui.Slider( FOVBOX, "lua_fov_slider_one", "Field of View for 1st Zoom", 80, 0, 180 )
local SLIDER_TWO = gui.Slider( FOVBOX, "lua_fov_slider_two", "Field of View for 2nd Zoom", 40, 0, 180 )
local FOVBETWEENCHECK = gui.Checkbox( FOVBOX, "lua_fov_between__shot_checkbox", "Reset FOV between scoped shots" , 1 )

local VIEWBOX = gui.Groupbox(TAB, "Viewmodel", 15, 260)
local SLIDER_VIEW = gui.Slider( VIEWBOX, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )
local SLIDER_VIEWX = gui.Slider( VIEWBOX, "lua_fov_slider_viewX", "Viewmodel Offset X", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( VIEWBOX, "lua_fov_slider_viewY", "Viewmodel Offset Y", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( VIEWBOX, "lua_fov_slider_viewZ", "Viewmodel Offset Z", -1, -40, 40 )
local ref1 = gui.Reference("Visuals", "Local", "Camera", "esp.local.fov");
local ref2 = gui.Reference("Visuals", "Local", "Camera", "esp.local.viewmodelfov");
ref1:SetDisabled(true);
ref2:SetDisabled(true);
ref1:SetInvisible(true);
ref2:SetInvisible(true);

local betweenshot

callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        local scoped = player_local:GetProp("m_bIsScoped")

        if scoped ~= 0 and scoped ~= 256 and (FOVBETWEENCHECK:GetValue() and tostring(scoped) == "65536") ~= true then
            local gWeapon = player_local:GetPropEntity("m_hActiveWeapon")
            local zoomLevel = gWeapon:GetProp("m_zoomLevel")
            if zoomLevel == 1 then 
                if SLIDER_ONE:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_ONE:GetValue(), true )
            elseif zoomLevel == 2 then 
                if SLIDER_TWO:GetValue() == 90 then
                    a = -40
                end
                client.SetConVar( "fov_cs_debug", SLIDER_TWO:GetValue(), true )
            end
        else
            client.SetConVar( "fov_cs_debug", SLIDER:GetValue(), true )
        end
        client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)	
	
-- End FOVnViewFovModel changer incl Scopefix --

--[[
--##--##--##--##- Viewmodel Changer + Zoom Changer + No Zoom -##--##--##--##--

	
local REFFF = gui.Reference("VISUALS")

local TAB = gui.Tab(REFFF, "lua_fov_tab", "Fov Changer")

local ZOOMGROUP = gui.Groupbox(TAB, "Scope Zoom" , 15, 15, 600)
local VIEWGROUP = gui.Groupbox(TAB, "Viewmodel" , 15, 280, 600)

local VIEWTOGGLE = gui.Checkbox(VIEWGROUP, "viewmodel_chkbox", "Custom Viewmodel", false)
local ZOOMTOGGLE = gui.Checkbox(ZOOMGROUP, "customzoom_chkbox", "Custom Zoom", false)
local RANDOMXYZ = gui.Checkbox(VIEWGROUP, "randomxyz_chkbox", "Random XYZ", false)
local NOZOOM = gui.Checkbox(ZOOMGROUP, "randomxyz_chkbox", "No Scope Zoom", false)

VIEWTOGGLE:SetDescription("Enable/Disabled Custom Viewmodel")
ZOOMTOGGLE:SetDescription("Enable/Disabled Custom Scope Zoom")
RANDOMXYZ:SetDescription("Random XYZ Offsets Between  -2 / 2")
NOZOOM:SetDescription("Remove Scope Zoom")

local ZOOM1 = gui.Slider( ZOOMGROUP, "zoom1", "Fov on First Zoom", 40, 0, 180)
local ZOOM2 = gui.Slider( ZOOMGROUP, "zoom2", "Fov on Second Zoom", 15, 0, 180)

local CFOV = gui.Slider(VIEWGROUP, "cfov", "Camera Fov",90 ,0 ,180)
local WFOV = gui.Slider( VIEWGROUP, "wfov", "Viewmoddel Fov", 70, 0, 140)
local X = gui.Slider( VIEWGROUP, "X", "X - Vertical", xO, -100, 100)
local Y = gui.Slider( VIEWGROUP, "Y", "Y - Horizontal", yO, -100, 100)
local Z = gui.Slider( VIEWGROUP, "Z", "Z - Zedical", zO, -100, 100)


local zoom = 0

callbacks.Register( "Draw", function()


if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then	
	local a = 0
    local local_player = entities.GetLocalPlayer();
    
	local scoped = local_player:GetProp("m_bIsScoped")
    if scoped ~= 0 and scoped ~= 256 then
	local gWeapon = local_player:GetPropEntity("m_hActiveWeapon")
	local zoomLevel = gWeapon:GetProp("m_zoomLevel")
	if zoomLevel == 1 then
    		if ZOOM1:GetValue() == 90 then
            
                client.SetConVar("r_drawviewmodel", 0, true);


            else
                client.SetConVar("r_drawviewmodel", 1, true);



            end
            if ZOOMTOGGLE:GetValue() then
                if NOZOOM:GetValue() then
                    if VIEWTOGGLE:GetValue() then
                        client.SetConVar( "fov_cs_debug", CFOV:GetValue(), true)
                    else
                        client.SetConVar( "fov_cs_debug", 90, true)
                    end
                    client.SetConVar("r_drawviewmodel", 0, true)
                else
                    client.SetConVar( "fov_cs_debug", ZOOM1:GetValue(), true)
                end
            else
                client.SetConVar( "fov_cs_debug", 40, true)
            end    
        elseif zoomLevel == 2 then
            if ZOOM2:GetValue() == 90 then
                client.SetConVar("r_drawviewmodel", 0, true);


            else
                client.SetConVar("r_drawviewmodel", 1, true);


            end
            if ZOOMTOGGLE:GetValue() then
                if NOZOOM:GetValue() then
                    if VIEWTOGGLE:GetValue() then
                        client.SetConVar( "fov_cs_debug", CFOV:GetValue(), true)
                    else
                        client.SetConVar( "fov_cs_debug", 90, true)
                    end
                    client.SetConVar("r_drawviewmodel", 0, true);
                else
                    client.SetConVar( "fov_cs_debug", ZOOM2:GetValue(), true)
                end
            else
                client.SetConVar( "fov_cs_debug", 15, true)
            end
        end
    else
        if VIEWTOGGLE:GetValue() then
            client.SetConVar( "fov_cs_debug", CFOV:GetValue(), true)
        else
            client.SetConVar( "fov_cs_debug", 90, true)
        end
        client.SetConVar("r_drawviewmodel", 1, true)
    end

    if VIEWTOGGLE:GetValue() then
        client.SetConVar("viewmodel_offset_x", X:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", Z:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", Y:GetValue(), true)
        client.SetConVar("viewmodel_fov", WFOV:GetValue(), true);
    else
        client.SetConVar("viewmodel_offset_x", 0, true);
        client.SetConVar("viewmodel_offset_z", 0, true);
        client.SetConVar("viewmodel_offset_y", 0, true)
        client.SetConVar("viewmodel_fov", 68, true);
    end
    
        if RANDOMXYZ:GetValue() then
            if VIEWTOGGLE:GetValue() then
                client.SetConVar("viewmodel_offset_randomize", 1, true);
            else
                client.SetConVar("viewmodel_offset_randomize", 0, true);
                client.SetConVar("viewmodel_offset_x", X:GetValue(), true);
                client.SetConVar("viewmodel_offset_z", Z:GetValue(), true);
                client.SetConVar("viewmodel_offset_y", Y:GetValue(), true)
            end
        else
            client.SetConVar("viewmodel_offset_randomize", 0, true);
            client.SetConVar("viewmodel_offset_x", X:GetValue(), true);
            client.SetConVar("viewmodel_offset_z", Z:GetValue(), true);
            client.SetConVar("viewmodel_offset_y", Y:GetValue(), true)
        end    
end
end)

--##--##--##--##- END Viewmodel Changer + Zoom Changer + No Zoom -##--##--##--##--
--]]


--##--##--##--##- noshadows -##--##--##--##--

local function noshadows()
    client.SetConVar( "r_shadows", 0, true );
    client.SetConVar( "cl_csm_static_prop_shadows", 0, true );
    client.SetConVar( "cl_csm_shadows", 0, true );
    client.SetConVar( "cl_csm_world_shadows", 0, true );
    client.SetConVar( "cl_foot_contact_shadows", 0, true );
    client.SetConVar( "cl_csm_viewmodel_shadows", 0, true );
    client.SetConVar( "cl_csm_rope_shadows", 0, true );
    client.SetConVar( "cl_csm_sprite_shadows", 0, true );
end


local function event(event)
    if event:GetName() == "round_start" then
        noshadows()
    end       
end

noshadows()

client.AllowListener("round_start")
callbacks.Register ("FireGameEvent", event)
callbacks.Register('Draw', 'noshadows', noshadows)


--##--##--##--##- End noshadows -##--##--##--##--

-------------------------------------------------------------------------------------------------

--[[
-- TranspirancyOnZoom ------------------>
local TransparencyOnZoom = gui.Reference("VISUALS", "LOCAL", "Helper")
local Enable_box = gui.Checkbox(TransparencyOnZoom, "enable_transparency_checkbox", "Enable TransparencyOnScope", 0)
Enable_box:SetDescription("Enable Local ChamsTransparecy on Scope")
local cache = {
clr_local,
clr_local_hidden,
clr_ghost,
clr_ghost_hidden
}
local invoke_cache_callback = function()
    if cache.clr_local ~= nil then
        gui.SetValue("esp.chams.local.visible.clr", cache.clr_local[1], cache.clr_local[2], cache.clr_local[3], cache.clr_local[4])
        cache.clr_local = nil
    end
	if cache.clr_local_hidden ~= nil then
        gui.SetValue("esp.chams.local.visible.clr", cache.clr_local_hidden[1], cache.clr_local_hidden[2], cache.clr_local_hidden[3], cache.clr_local_hidden[4])
        cache.clr_local_hidden = nil
    end
	if cache.clr_ghost ~= nil then
        gui.SetValue("esp.chams.ghost.visible.clr", cache.clr_ghost[1], cache.clr_ghost[2], cache.clr_ghost[3], cache.clr_ghost[4])
        cache.clr_ghost = nil
    end
	if cache.clr_ghost_hidden ~= nil then
        gui.SetValue("esp.chams.ghost.visible.clr", cache.clr_ghost_hidden[1], cache.clr_ghost_hidden[2], cache.clr_ghost_hidden[3], cache.clr_ghost_hidden[4])
        cache.clr_ghost_hidden = nil
    end
end
callbacks.Register("Draw", "scope_trpn", function()
    local me = entities.GetLocalPlayer()
    if me == nil or not me:IsAlive() or Enable_box:GetValue() == nil then
        invoke_cache_callback()
        return
    end
    local m_bIsScoped = me:GetProp("m_bIsScoped")
    local m_iTeamNum = me:GetProp("m_iTeamNum") -- T: 2 CT: 3
    if cache.clr_local == nil then cache.clr_local = { gui.GetValue("esp.chams.local.visible.clr") } end
	if cache.clr_local_hidden == nil then cache.clr_local_hidden = { gui.GetValue("esp.chams.local.occluded.clr") } end
    if cache.clr_ghost == nil then cache.clr_ghost = { gui.GetValue("esp.chams.ghost.visible.clr") } end
	if cache.clr_ghost_hidden == nil then cache.clr_ghost_hidden = { gui.GetValue("esp.chams.ghost.occluded.clr") } end
    print(cache.clr_local)
    print(cache.clr_local_hidden)
    print(cache.clr_ghost)    
	print(cache.clr_ghost_hidden)
	
	
    if m_bIsScoped == 1 or m_bIsScoped == 257 then
        if m_iTeamNum == 2 then gui.SetValue("esp.chams.local.visible.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 2 then gui.SetValue("esp.chams.local.occluded.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 2 then gui.SetValue("esp.chams.ghost.visible.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 2 then gui.SetValue("esp.chams.ghost.occluded.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 3 then gui.SetValue("esp.chams.local.visible.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 3 then gui.SetValue("esp.chams.local.occluded.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 3 then gui.SetValue("esp.chams.ghost.visible.clr", 90, 90, 90, 32) end
        if m_iTeamNum == 3 then gui.SetValue("esp.chams.ghost.occluded.clr", 90, 90, 90, 32) end
    else
        invoke_cache_callback()
    end
end)
-- END TranspirancyOnZoom ------------------>
--]]




--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#


-- TransparenzOnScope --

local REF = gui.Reference( "Visuals", "Fov Changer" ) -- ("Visual", "Local", "Helper")

--local TAB = gui.Tab(REF, "lua_transparent_on_scope_tab", "Transparent on scope")

local BOX = gui.Groupbox(REF, "Transparent on scope lua by atk3001", 15, 518)
local SLIDER = gui.Slider(BOX, "lua_transparent_on_scope_slider", "Level of transparency", 5, 0, 255)
local localchams = gui.Combobox(BOX, "lua_transparent_on_scope_set_localchams", "Select the local chams while scoped", "Use the already set one", "Flat", "Color", "Metallic", "Glow", "Textured", "invisible")
local switchghost = gui.Checkbox(BOX, "lua_transparent_on_scope_switchghost", "Turn off ghost chams while scoped", false)
local switchoc = gui.Checkbox(BOX, "lua_transparent_on_scope_switchoc", "Turn off occluded chams while scoped", false)
local switchol = gui.Checkbox(BOX, "lua_transparent_on_scope_switchol", "Turn off Overlay while scoped", false)

local stored = 0
local set = 0
local change = 0
local slidervalue
local localvisiblecustom
local cb1 = switchghost:GetValue()
local cb2 = switchoc:GetValue()
local cb3 = switchol:GetValue()
local localchamscheck = localchams:GetValue()

local ghostoccluded, ghostoverlay, ghostvisible
local localoccluded, localoverlay, localvisible

local ghostoccludedclr_r, ghostoccludedclr_g, ghostoccludedclr_b, ghostoccludedclr_a
local ghostoverlayclr_r, ghostoverlayclr_g, ghostoverlayclr_b, ghostoverlayclr_a
local ghostvisibleclr_r, ghostvisibleclr_g, ghostvisibleclr_b, ghostvisibleclr_a

local localoccludedclr_r, localoccludedclr_g, localoccludedclr_b, localoccludedclr_a
local localoverlayclr_r, localoverlayclr_g, localoverlayclr_b, localoverlayclr_a 
local localvisibleclr_r, localvisibleclr_g, localvisibleclr_b, localvisibleclr_a 

callbacks.Register( "Draw", function()
if entities.GetLocalPlayer() == NULL or entities.GetLocalPlayer() == nil then return end;
local player_local = entities.GetLocalPlayer();
if entities.GetLocalPlayer() == NULL or entities.GetLocalPlayer() == nil then return end;
local scoped = player_local:GetProp("m_bIsScoped")
if scoped == 1 or scoped == 257 then

    if slidervalue ~= SLIDER:GetValue() then
        change = 1
    end

    if cb1 ~= switchghost:GetValue() then
        change = 1
        cb1 = switchghost:GetValue()
    end

    if cb2 ~= switchoc:GetValue() then
        change = 1
        cb2 = switchoc:GetValue()
    end

    if cb3 ~= switchol:GetValue() then
        change = 1
        cb3 = switchol:GetValue()
    end

    if localchamscheck ~= localchams:GetValue() then
        change = 1
        localchamscheck = localchams:GetValue()
    end

    if stored == 0 then
        ghostoccluded = gui.GetValue( "esp.chams.ghost.occluded" )
        ghostoverlay = gui.GetValue( "esp.chams.ghost.overlay" )
        ghostvisible = gui.GetValue( "esp.chams.ghost.visible" )

        localoccluded = gui.GetValue( "esp.chams.local.occluded" )
        localoverlay = gui.GetValue( "esp.chams.local.overlay" )
        localvisible = gui.GetValue( "esp.chams.local.visible" )
        ghostoccludedclr_r, ghostoccludedclr_g, ghostoccludedclr_b, ghostoccludedclr_a = gui.GetValue( "esp.chams.ghost.occluded.clr" )
        ghostoverlayclr_r, ghostoverlayclr_g, ghostoverlayclr_b, ghostoverlayclr_a = gui.GetValue( "esp.chams.ghost.overlay.clr" )
        ghostvisibleclr_r, ghostvisibleclr_g, ghostvisibleclr_b, ghostvisibleclr_a = gui.GetValue( "esp.chams.ghost.visible.clr" )

        localoccludedclr_r, localoccludedclr_g, localoccludedclr_b, localoccludedclr_a = gui.GetValue( "esp.chams.local.occluded.clr" )
        localoverlayclr_r, localoverlayclr_g, localoverlayclr_b, localoverlayclr_a = gui.GetValue( "esp.chams.local.overlay.clr" )
        localvisibleclr_r, localvisibleclr_g, localvisibleclr_b, localvisibleclr_a = gui.GetValue( "esp.chams.local.visible.clr" )

        stored = 1
    else 
        if set == 0 or change == 1 then
            slidervalue = SLIDER:GetValue()

            if switchghost:GetValue() then
                gui.SetValue( "esp.chams.ghost.occluded", 0 )
                gui.SetValue( "esp.chams.ghost.overlay", 0 )
                gui.SetValue( "esp.chams.ghost.visible", 0 )
            else 
                gui.SetValue( "esp.chams.ghost.occluded", ghostoccluded )
                gui.SetValue( "esp.chams.ghost.overlay", ghostoverlay )
                gui.SetValue( "esp.chams.ghost.visible", ghostvisible ) 
            end

            if localchams:GetValue() ~= 0 then 
                localvisiblecustom = localchams:GetValue()
            else
                localvisiblecustom = localvisible
            end

            if switchoc:GetValue() == true then
                gui.SetValue( "esp.chams.ghost.occluded" , 0)
                gui.SetValue( "esp.chams.local.occluded" , 0)
            else
                if switchghost:GetValue() == 1 then
                gui.SetValue( "esp.chams.ghost.occluded" , ghostoccluded)
                end
                gui.SetValue( "esp.chams.local.occluded" , localoccluded)
                if ghostoccluded ~= 0 then
                    gui.SetValue("esp.chams.ghost.occluded.clr", ghostoccludedclr_r, ghostoccludedclr_g, ghostoccludedclr_b, slidervalue)
                end
                if localoccluded ~= 0 then
                    gui.SetValue( "esp.chams.local.occluded.clr", localoccludedclr_r, localoccludedclr_g, localoccludedclr_b, slidervalue)
                end
            end

            if switchol:GetValue() == true then
                gui.SetValue( "esp.chams.ghost.overlay" , 0)
                gui.SetValue( "esp.chams.local.overlay" , 0)
            else
                if switchghost:GetValue() == 1 then
                gui.SetValue( "esp.chams.ghost.overlay" , ghostoverlay)
                end
                gui.SetValue( "esp.chams.local.overlay" , localoverlay)
                if ghostoverlay ~= 0 then
                    gui.SetValue("esp.chams.ghost.overlay.clr", ghostoverlayclr_r, ghostoverlayclr_g, ghostoverlayclr_b, slidervalue)
                end
                if localoverlay ~= 0 then
                    gui.SetValue("esp.chams.local.overlay.clr", localoverlayclr_r, localoverlayclr_g, localoverlayclr_b, slidervalue)
                end
            end

            if ghostvisible ~= 0 then
                gui.SetValue("esp.chams.ghost.visible.clr", ghostvisibleclr_r, ghostvisibleclr_g, ghostvisibleclr_b, slidervalue)
            end
        
            if localvisiblecustom ~= 0 then
                gui.SetValue("esp.chams.local.visible", localvisiblecustom)
            end
            gui.SetValue("esp.chams.local.visible.clr", localvisibleclr_r, localvisibleclr_g, localvisibleclr_b, slidervalue)

        change = 0
        set = 1
        end
    end
else
    if set == 1 then

        gui.SetValue( "esp.chams.ghost.occluded", ghostoccluded )
        gui.SetValue( "esp.chams.ghost.overlay", ghostoverlay )
        gui.SetValue( "esp.chams.ghost.visible", ghostvisible )

        gui.SetValue( "esp.chams.local.occluded", localoccluded )
        gui.SetValue( "esp.chams.local.overlay", localoverlay )
        gui.SetValue( "esp.chams.local.visible", localvisible )
        
        gui.SetValue( "esp.chams.ghost.occluded.clr", ghostoccludedclr_r, ghostoccludedclr_g, ghostoccludedclr_b, ghostoccludedclr_a )
        gui.SetValue( "esp.chams.ghost.overlay.clr", ghostoverlayclr_r, ghostoverlayclr_g, ghostoverlayclr_b, ghostoverlayclr_a)
        gui.SetValue( "esp.chams.ghost.visible.clr", ghostvisibleclr_r, ghostvisibleclr_g, ghostvisibleclr_b, ghostvisibleclr_a)

        gui.SetValue( "esp.chams.local.occluded.clr", localoccludedclr_r, localoccludedclr_g, localoccludedclr_b, localoccludedclr_a)
        gui.SetValue( "esp.chams.local.overlay.clr" , localoverlayclr_r, localoverlayclr_g, localoverlayclr_b, localoverlayclr_a)
        gui.SetValue( "esp.chams.local.visible.clr" ,localvisibleclr_r, localvisibleclr_g, localvisibleclr_b, localvisibleclr_a)

        set = 0
        stored = 0
end
end
end
)
-- End TransparenzOnScope --


-------------------------------------------------------------------------------------------------


--------------------
-- ui setup
--------------------
local visualzz_ref = gui.Reference( "Visuals", "Other", "Effects" );
local tab = gui.Text( visualzz_ref, "" );
local Title = gui.Text( visualzz_ref, "# Extra Visuals #");

--------------------
-- ui items
--------------------
gui.Checkbox( visualzz_ref, "old_wep_esp", "Old weapon ESP", false );
gui.Checkbox( visualzz_ref, "old_hp_esp", "Old HP indicator", false );
gui.Checkbox( visualzz_ref, "nade_esp", "Grenade ESP", false );
--gui.Checkbox( visualzz_ref, "fov_enable", "Field of view override", false );
--gui.Slider( visualzz_ref, "fov_val", "Field of view amount", 60, 0, 140 );



--------------------
-- funcs
--------------------
local function GetWpnName( x )
	if x == 1 then return "desert eagle" end
	if x == 2 then return "dual berettas" end
	if x == 3 then return "five-seven" end
	if x == 4 then return "glock-18" end
	if x == 7 then return "ak-47" end
	if x == 8 then return "aug" end
	if x == 9 then return "awp" end
	if x == 10 then return "famas" end
	if x == 11 then return "g3sg1" end
	if x == 13 then return "galil ar" end
	if x == 14 then return "m249" end
	if x == 16 then return "m4a4" end
	if x == 17 then return "mac-10" end
	if x == 19 then return "p90" end
	if x == 23 then return "mp5-sd" end
	if x == 24 then return "ump-45" end
	if x == 25 then return "xm1014" end
	if x == 26 then return "pp-bizon" end
	if x == 27 then return "mag-7" end
	if x == 28 then return "negev" end
	if x == 29 then return "sawed-off" end
	if x == 30 then return "tec-9" end
	if x == 31 then return "zeus x27" end
	if x == 32 then return "p2000" end
	if x == 33 then return "mp7" end
	if x == 34 then return "mp9" end
	if x == 35 then return "nova" end
	if x == 36 then return "p250" end
	if x == 37 then return "ballistic shield" end
	if x == 38 then return "scar-20" end
	if x == 39 then return "sg 553" end
	if x == 40 then return "ssg 08" end
	if x == 41 then return "knife" end
	if x == 42 then return "knife" end
	if x == 43 then return "flashbang" end
	if x == 44 then return "high explosive grenade" end
	if x == 45 then return "smoke grenade" end
	if x == 46 then return "molotov" end
	if x == 47 then return "decoy grenade" end
	if x == 48 then return "incendiary grenade" end
	if x == 49 then return "c4 explosive" end
	if x == 50 then return "kevlar vest" end
	if x == 51 then return "kevlar + helmet" end
	if x == 52 then return "heavy assault suit" end
	if x == 54 then return "item_nvg" end
	if x == 55 then return "defuse kit" end
	if x == 56 then return "rescue kit" end
	if x == 57 then return "medi-shot" end
	if x == 58 then return "music kit" end
	if x == 59 then return "knife" end
	if x == 60 then return "m4a1-s" end
	if x == 61 then return "usp-s" end
	if x == 60 then return "m4a1-s" end
	if x == 61 then return "usp-s" end
	if x == 63 then return "cz75-auto" end
	if x == 64 then return "r8 revolver" end
	if x == 68 then return "tactical awareness grenade" end
	if x == 69 then return "bare hands" end
	if x == 70 then return "breach charge" end
	if x == 72 then return "tablet" end
	if x == 75 then return "axe" end
	if x == 76 then return "hammer" end
	if x == 78 then return "wrench" end
	if x == 80 then return "spectral shiv" end
	if x == 81 then return "fire bomb" end
	if x == 82 then return "diversion device" end
	if x == 83 then return "frag grenade" end
	if x == 84 then return "snowball" end
	if x == 85 then return "bump mine" end
	if x == 5027 then return "bloodhound gloves" end
	if x == 5028 then return "default t gloves" end
	if x == 5029 then return "default ct gloves" end
	if x == 5030 then return "sport gloves" end
	if x == 5031 then return "driver gloves" end
	if x == 5032 then return "hand wraps" end
	if x == 5033 then return "moto gloves" end
	if x == 5034 then return "specialist gloves" end
	if x == 5035 then return "hydra gloves" end
	if x == 5036 then return "local t agent" end
	if x == 5037 then return "local ct agent" end
end

local function DarkenMaterials( mat )
	local group = mat:GetTextureGroupName();

	if group == "World textures" or group == "StaticProp textures" or group == "SkyBox textures" then
		local modulate = ( group == "StaticProp textures" ) and 0.5 or 0.25;
		mat:ColorModulate( modulate, modulate, modulate );
	end
end

local function RestoreMaterials( mat ) 
	mat:ColorModulate( 1.0, 1.0, 1.0 );
end

--------------------
-- callbacks
--------------------
local function OnDrawESP( builder )
    local ent = builder:GetEntity();
    local localply = entities.GetLocalPlayer();
	
	--------------------
	-- old esp
	--------------------
	if ent:IsPlayer() and ent:GetTeamNumber() ~= localply:GetTeamNumber() then
		if gui.GetValue( "esp.other.old_wep_esp" ) then
			local id = ent:GetWeaponID();
	    	builder:AddTextBottom( GetWpnName( id ) );
		end

		if gui.GetValue( "esp.other.old_hp_esp" ) then
			builder:AddTextLeft( ent:GetHealth() .. " HP" .. " " );
		end 
	end
end

local function OnDraw( )
	--------------------
	-- fov changer
	--------------------
--	if gui.GetValue( "esp.other.fov_enable" ) then
--		client.SetConVar( "fov_cs_debug", gui.GetValue("esp.other.fov_val" ), true );
--	else
--		client.SetConVar( "fov_cs_debug", 0, true );
--	end


	--------------------
	-- ugly wip nade esp
	--------------------
	if gui.GetValue( "esp.other.nade_esp") then
		local nades = entities.FindByClass( "CBaseCSGrenadeProjectile" );
		for i = 1, #nades do
			local x, y = client.WorldToScreen( nades[ i ]:GetAbsOrigin() );
			if x ~= nil then
				draw.Color( 0, 0, 0, 250 )
				draw.FilledRect( x - 1, y - 1, x + 7, y + 7);

				draw.Color( 255, 0, 0, 255 );			
				draw.FilledRect( x, y, x + 5, y + 5);
			end
		end
	end
end



callbacks.Register( "DrawESP", OnDrawESP );
callbacks.Register( "Draw", OnDraw );

-------------------------------------------------------------------------------------------------

local nisc = gui.Reference('VISUALS', "Other", "Effects");
local vis_other_effects_title_SpaceLine = gui.Text(nisc, "");

local vis_other_effects_title = gui.Text(nisc, "# HvH Visuals #");
local EngineRadarchk = gui.Checkbox ( nisc, "lua_engine_radar", "Enable EngineRadar", 0 );
local SHOW = gui.Checkbox( nisc, "bulletimpacts", "Server-Side Bullet Impacts", false )
SHOW:SetDescription("Show server-side bullet impacts.")
local SHOW_CLIENT = gui.Checkbox( nisc, "bulletimpacts", "Client-Side Bullet Impacts", false )
SHOW_CLIENT:SetDescription("Show client-side bullet impacts.")
local COLOR = gui.ColorPicker( SHOW, "bulletimpacts.color", "cock", 0, 0, 255, 50 )
local impactpenCheckbox = gui.Checkbox( nisc, "lua_impactpen", "Bullet Penetration Impacts", 0 );
local showlagcompensationCheckbox = gui.Checkbox( nisc, "showlagcompensation", "Show Lagcompensation", 0 );
local FullbrightCheckbox = gui.Checkbox( nisc, "lua_fullbright", "Full Brightness", 0 );
local panorama_blur_off = gui.Checkbox(nisc,'lua_disable_panorama_blur', 'Disable Panorama Blur', 0)
local DisableWorldShadowsChkbox = gui.Checkbox(nisc, "lua_disable_shadows", "Disable WorldShadows", 0 );

local bulletImpacts = {}
callbacks.Register( "Draw", function()
    if not SHOW:GetValue() then return end
    if not entities.GetLocalPlayer() then return end
    if table.getn(bulletImpacts) == 0 then return end

    if globals.CurTime() >= bulletImpacts[1][2] then
        table.remove(bulletImpacts, 1)
    end

    for i = 1, #bulletImpacts do
        local vecBullet = bulletImpacts[i][1]

        local topLeftBottomX, topLeftBottomY = client.WorldToScreen( vecBullet + Vector3(2, -2, 2) )
        local topLeftTopX, topLeftTopY = client.WorldToScreen( vecBullet + Vector3(-2, -2, 2) )
        local topRightBottomX, topRightBottomY = client.WorldToScreen( vecBullet + Vector3(2, 2, 2) )
        local topRightTopX, topRightTopY = client.WorldToScreen( vecBullet + Vector3(-2, 2, 2) )

        local botLeftBottomX, botLeftBottomY = client.WorldToScreen( vecBullet + Vector3(2, -2, -2) )
        local botLeftTopX, botLeftTopY = client.WorldToScreen( vecBullet + Vector3(-2, -2, -2) )
        local botRightBottomX, botRightBottomY = client.WorldToScreen( vecBullet + Vector3(2, 2, -2) )
        local botRightTopX, botRightTopY = client.WorldToScreen( vecBullet + Vector3(-2, 2, -2) )

        if topLeftBottomX == nil or topLeftTopX == nil or topRightBottomX == nil or topRightTopX == nil or botLeftBottomX == nil or botLeftTopX == nil or botRightBottomX == nil or botRightTopX == nil then 
            goto continue 
        end

        draw.Color( 0, 0, 0, 100)
        draw.Line( topLeftBottomX, topLeftBottomY, topLeftTopX, topLeftTopY )
        draw.Line( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY )
        draw.Line( topRightTopX, topRightTopY, topRightBottomX, topRightBottomY )
        draw.Line( topRightBottomX, topRightBottomY, topLeftBottomX, topLeftBottomY )
        draw.Line( botLeftBottomX, botLeftBottomY, botLeftTopX, botLeftTopY )
        draw.Line( botLeftTopX, botLeftTopY, botRightTopX, botRightTopY )
        draw.Line( botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )
        draw.Line( botRightBottomX, botRightBottomY, botLeftBottomX, botLeftBottomY )
        draw.Line( topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY )
        draw.Line( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY )
        draw.Line( topRightTopX, topRightTopY, botRightTopX, botRightTopY )
        draw.Line( topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )

        draw.Color( COLOR:GetValue() )  
        draw.Triangle( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY, botLeftBottomX, botLeftBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY )
        draw.Triangle( topRightTopX, topRightTopY, botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )
        draw.Triangle( topRightTopX, topRightTopY, topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, botLeftTopX, botLeftTopY, botRightTopX, botRightTopY )
        draw.Triangle( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY, botRightTopX, botRightTopY )
        draw.Triangle( topLeftBottomX, topLeftBottomY, botLeftBottomX, botLeftBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftBottomX, topLeftBottomY, topRightBottomX, topRightBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topLeftBottomX, topLeftBottomY, topRightBottomX, topRightBottomY )
        draw.Triangle( topLeftTopX, topLeftTopY, topRightTopX, topRightTopY, topRightBottomX, topRightBottomY )
        draw.Triangle( botLeftTopX, botLeftTopY, botLeftBottomX, botLeftBottomY, botRightBottomX, botRightBottomY )
        draw.Triangle( botLeftTopX, botLeftTopY, botRightTopX, botRightTopY, botRightBottomX, botRightBottomY )

        ::continue::
    end
end )

callbacks.Register( "FireGameEvent", function(event)
    if event:GetName() ~= "bullet_impact" then return end
    if not SHOW:GetValue() then return end
    if client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) ) ~= client.GetLocalPlayerIndex() then return end
    table.insert(bulletImpacts, {Vector3(event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z")), globals.CurTime() + 4})
end )
client.AllowListener( "bullet_impact" )

-- show impacts 
callbacks.Register( "CreateMove", function()
    if SHOW_CLIENT:GetValue() then
        client.SetConVar( "sv_showimpacts", 2, true )
    else
        client.SetConVar( "sv_showimpacts", 0, true )
    end
end )

callbacks.Register( "Unload", function()
    client.SetConVar( "sv_showimpacts", 0, true )
end )

-- Bullet Penetration Impacts
local function impact()

    if impactpenCheckbox:GetValue() then
        client.SetConVar( "sv_showimpacts_penetration", 1, true )
    else
        client.SetConVar( "sv_showimpacts_penetration", 0, true )
    end
    
end

callbacks.Register( "Draw", "impact", impact )

--showlagcompensation--
local function showlagcompensation()
	
	if showlagcompensationCheckbox:GetValue() then
		client.SetConVar( "sv_showlagcompensation", 1, true )
	else
		client.SetConVar( "sv_showlagcompensation", 0, true )
	end
	
end

callbacks.Register( "Draw", "showlagcompensation", showlagcompensation )

-- Fullbright
local function Fullbright()
	
	if FullbrightCheckbox:GetValue() then
		client.SetConVar( "mat_fullbright", 1, true )
	else
		client.SetConVar( "mat_fullbright", 0, true )
	end
	
end

callbacks.Register( "Draw", "FullBrightness", Fullbright )

---disable panorama blur\--
local function disable_panorama_blur()
	
	if panorama_blur_off:GetValue() then
		client.SetConVar('@panorama_disable_blur', 1, true)
	else
		client.SetConVar('@panorama_disable_blur', 0, true)
		end 	
	
end

callbacks.Register('Draw', "disable_panorama_blur", disable_panorama_blur)

-- Engine Radar by Nyanpasu!
local function engine_radar_draw()

for index, Player in pairs(entities.FindByClass("CCSPlayer")) do

if not EngineRadarchk:GetValue() then        

Player:SetProp("m_bSpotted", 0);


else

Player:SetProp("m_bSpotted", 1);

end
end
end

callbacks.Register("Draw", "engine_radar_draw", engine_radar_draw);



-- No FOG  FPS Boost
local function nofog(event)
    if event:GetName() == "round_start" then
        client.SetConVar( "fog_enable", 0, true );
        client.SetConVar( "fog_enableskybox", 0, true );
        client.SetConVar( "fog_enable_water_fog", 0, true );
        client.SetConVar( "fog_override", 1, true );
        end        
    end
    
client.AllowListener("round_start")
callbacks.Register("FireGameEvent", "nofog", nofog)
-- END NoFog FPSboost ------------------

-- No WorldShadows FPS Boost
local function noshadows()

if not DisableWorldShadowsChkbox:GetValue() then
return
else
    client.SetConVar( "r_shadows", 0, true );
    client.SetConVar( "cl_csm_static_prop_shadows", 0, true );
    client.SetConVar( "cl_csm_shadows", 0, true );
    client.SetConVar( "cl_csm_world_shadows", 0, true );
    client.SetConVar( "cl_foot_contact_shadows", 0, true );
    client.SetConVar( "cl_csm_viewmodel_shadows", 0, true );
    client.SetConVar( "cl_csm_rope_shadows", 0, true );
    client.SetConVar( "cl_csm_sprite_shadows", 0, true );
end
end

local function eventz(event)
    if event:GetName() == "round_start" then
        noshadows()
    end       
end
--noshadows()

client.AllowListener("round_start")
callbacks.Register ("FireGameEvent", eventz)
callbacks.Register('Draw', 'noshadows', noshadows)

-- END WorldShadows FPSboost ------------------


