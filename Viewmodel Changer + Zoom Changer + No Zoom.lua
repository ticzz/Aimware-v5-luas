local REF = gui.Reference( "VISUALS")


local ZOOMGROUP = gui.Groupbox(REF, "Scope Zoom", 15, 15, 605, 500)
local VIEWGROUP = gui.Groupbox(REF, "Viewmodel", 15, 220, 605, 500)

local VIEWTOGGLE = gui.Checkbox(VIEWGROUP, "viewmodel", "Custom Viewmodel", false)
local ZOOMTOGGLE = gui.Checkbox(ZOOMGROUP, "customzoom", "Custom Zoom", false)
local RANDOMXYZ = gui.Checkbox(VIEWGROUP, "randomxyz", "Random XYZ", false)
local NOZOOM = gui.Checkbox(ZOOMGROUP, "randomxyz", "No Scope Zoom", false)

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

end)