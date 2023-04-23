local function MakeRainbow(speed,gamma)
    local r = (math.sin(globals.RealTime() * speed / 10) * 127 + 128) * gamma / 100
    local g = (math.sin(globals.RealTime() * speed / 10 + 2) * 127 + 128) * gamma / 100
    local b = (math.sin(globals.RealTime() * speed / 10 + 4) * 127 + 128) * gamma / 100
    return r,g,b
end

local function lerp(a,b,t) return a * (1-math.abs(t)) + b * math.abs(t) end

local TAB = gui.Reference( "Visuals", "Adv.Viewmodel" )



local IG = gui.Groupbox( TAB, "Enemy Invisible", 30 + (640-45)/2, 2350, (640-45)/2, 640 )
local IC = gui.Checkbox( IG, "viewmodel.enemyinv", "Enable For Enemy", false )
local ICLR = gui.ColorPicker( IC, "viewmodel.enemyinv.clr", "Enemy Color", 255, 255, 255, 255 )
local IT = gui.Combobox( IG, "viewmodel.enemyinv.type", "Local Model Material", "Custom","Flat","Chromium","Glow","Crystal" )
local IT_CLR = gui.ColorPicker( IT, "viewmodel.enemyinv.type.clr", "Special Enemy Color", 255, 255, 255, 255 )
local IA = gui.Checkbox( IG, "viewmodel.enemyinv.additive", "Additive", false )
local ICOLOR = gui.Combobox( IG, "viewmodel.enemyinv.colorbase", "Color Modulation Base", "Static","Rainbow","Lerp" )
local ICLR_L_1 = gui.ColorPicker( IG, "viewmodel.enemyinv.lerp.clr1", "Lerp From", 255, 255, 255, 255 )
local ICLR_L_2 = gui.ColorPicker( IG, "viewmodel.enemyinv.lerp.clr2", "Lerp To", 255, 255, 255, 255 )
local ISPEED = gui.Slider( IG, "viewmodel.enemyinv.speed", "Lerp/Rainbow Speed", 10, 1, 100 )
local IRG = gui.Slider( IG, "viewmodel.enemyinv.rainbow.gamma", "Rainbow Gamma", 100, 1, 100 )
local IPHONG = gui.Slider( IG, "viewmodel.enemyinv.phong", "Phong", 0, 0, 100 )
local IPEARL = gui.Slider( IG, "viewmodel.enemyinv.pearl","Pearlescent", 0, 0, 100 )
local IREFLECTIVITY = gui.Slider(IG,"viewmodel.enemyinv.reflectivity","Reflectivity",0,0,100)
local IGLOW = gui.Slider( IG, "viewmodel.enemyinv.glowint", "Glow Int", 2, 2, 50 )

local io_w = nil
local io_g = nil
local ig_old_r,ig_old_g,ig_old_b,ig_old_a = 255
local ig_old_glow = 2

local iold_r,iold_g,iold_b,old_a = 255
local iold_phong, iold_pearl, iold_reflectivity, iold_glow = 0
local imat = nil
local iold_type = 0

local function IOnDraw()
    local r,g,b,a = IT_CLR:GetValue()
    local type = IT:GetValue()
    local pearl = IPEARL:GetValue() / 100 * 10
    local phong = IPHONG:GetValue() / 100 * 20
    local reflectivity = IREFLECTIVITY:GetValue()/100
    local glow = IGLOW:GetValue()
    if iold_type ~= type or imat == nil or iold_r ~= r or iold_g ~= g or iold_b ~= b or iold_a ~= a or iold_pearl ~= pearl or iold_phong ~= phong or iold_reflectivity ~= reflectivity or iold_glow ~= glow then
        if type == 0 then
            imat = materials.Create("aw_vm_enemyinv",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additive
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 * reflectivity .. " " .. g/255 * reflectivity .. " " .. b/255 * reflectivity .. [[]"
                    $phong 1
                    $phongboost ]] .. phong .. [[
                    $basemapalphaphongmask 1
                    $pearlescent ]] .. pearl.. [[
                    $ignorez 1
                    $nocull 1
                }
            ]])
        elseif type == 1 then
            imat = materials.Create("aw_vm_enemyinv",
            [[
                UnlitGeneric
                {
                    $model 1
                    $ignorez 1
                }
            ]])
        elseif type == 2 then
            imat = materials.Create("aw_vm_enemyinv",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additve
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                    $ignorez 1
                }
            ]])
        elseif type == 3 then
            imat = materials.Create("aw_vm_enemyinv",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additive
                    $envmap models/effects/cube_white
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                    $envmapfresnel 1
                    $envmapfresnelminmaxexp "[0 1 ]] ..  glow .. [[]"
                    $ignorez 1
                }
            ]])
        elseif type == 4 then
            imat = materials.Create( "aw_vm_enemyinv", 
            [[
                VertexLitGeneric
                {
	                $baseTexture			black
	                $bumpmap				effects\flat_normal
	                $translucent 1
	                $alpha 0.4
	                $envmap		models\effects\crystal_cube_vertigo_hdr
	                $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 ..[[]"
	                //$envmaptint "[0.8 1.2 1.5]"
	                //$envmapcontrast 1.2
	                $envmapsaturation 0.1
	                $envmapfresnel 0
	                $phong 1
	                $phongexponent 16
	                $phongtint "[]].. r/255 .. " " .. g/255 .. " " .. b/255 ..[[]"
	                $phongboost 2
                    //$nocull 1
                    $ignorez 1
                }
            ]])
        end
    end
    iold_r,iold_g,iold_b,iold_a = IT_CLR:GetValue()
    iold_type = type
    iold_pearl = pearl
    iold_phong = phong
    iold_reflectivity = reflectivity
    iold_glow = glow
end

local function IModel(Context)
    if Context:GetEntity() ~= nil and IC:GetValue() then
        gui.SetValue( "esp.chams.enemy.occluded", 0 )
        if Context:GetEntity():GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and Context:GetEntity():IsPlayer() then
            local r,g,b,a = ICLR:GetValue()
            if ICOLOR:GetValue() == 0 then
                imat:ColorModulate(r/255,g/255,b/255)
            elseif ICOLOR:GetValue() == 1 then
                r,g,b = MakeRainbow(ISPEED:GetValue(),IRG:GetValue())
                imat:ColorModulate(r/255,g/255,b/255)
            elseif ICOLOR:GetValue() == 2 then
                local r1,g1,b1,a1 = ICLR_L_1:GetValue()
                local r2,g2,b2,a2 = ICLR_L_2:GetValue()
                r = lerp(r1,r2,math.sin(globals.RealTime() * ISPEED:GetValue() / 10))
                g = lerp(g1,g2,math.sin(globals.RealTime() * ISPEED:GetValue() / 10))
                b = lerp(b1,b2,math.sin(globals.RealTime() * ISPEED:GetValue() / 10))
                mat:ColorModulate(r/255,g/255,b/255)
            end
            imat:AlphaModulate(a/255)
            imat:SetMaterialVarFlag(128,IA:GetValue())
            Context:ForcedMaterialOverride(imat)
            Context:DrawExtraPass()
        end
    end
end

local function IGUIWork()
    if ICOLOR:GetValue() == 0 then
        ICLR_L_1:SetDisabled(true)
        ICLR_L_2:SetDisabled(true)
        ISPEED:SetDisabled(true)
        IRG:SetDisabled(true)
    elseif ICOLOR:GetValue() == 1 then
        ICLR_L_1:SetDisabled(true)
        ICLR_L_2:SetDisabled(true)
        ISPEED:SetDisabled(false)
        IRG:SetDisabled(false)
    elseif ICOLOR:GetValue() == 2 then
        ICLR_L_1:SetDisabled(false)
        ICLR_L_2:SetDisabled(false)
        ISPEED:SetDisabled(false)
        IRG:SetDisabled(true)
    end
    if IT:GetValue() == 0 then
        IPHONG:SetDisabled(false)
        IREFLECTIVITY:SetDisabled(false)
        IPEARL:SetDisabled(false)
    else
        IPHONG:SetDisabled(true)
        IREFLECTIVITY:SetDisabled(true)
        IPEARL:SetDisabled(true)
    end
    if IT:GetValue() == 3 then
        IGLOW:SetDisabled(false)
    else
        IGLOW:SetDisabled(true)
    end
end

callbacks.Register( "Draw", IGUIWork )
callbacks.Register( "Draw", IOnDraw )
callbacks.Register( "DrawModel", IModel)



local G = gui.Groupbox( TAB, "Enemy Visible", 15, 2350, (640-45)/2, 640 )
local C = gui.Checkbox( G, "viewmodel.enemy", "Enable For Enemy", false )
local CLR = gui.ColorPicker( C, "viewmodel.enemy.clr", "Enemy Color", 255, 255, 255, 255 )
local T = gui.Combobox( G, "viewmodel.enemy.type", "Local Model Material", "Custom","Flat","Chromium","Glow","Crystal" )
local T_CLR = gui.ColorPicker( T, "viewmodel.enemy.type.clr", "Special Enemy Color", 255, 255, 255, 255 )
local A = gui.Checkbox( G, "viewmodel.enemy.additive", "Additive", false )
local COLOR = gui.Combobox( G, "viewmodel.enemy.colorbase", "Color Modulation Base", "Static","Rainbow","Lerp" )
local CLR_L_1 = gui.ColorPicker( G, "viewmodel.enemy.lerp.clr1", "Lerp From", 255, 255, 255, 255 )
local CLR_L_2 = gui.ColorPicker( G, "viewmodel.enemy.lerp.clr2", "Lerp To", 255, 255, 255, 255 )
local SPEED = gui.Slider( G, "viewmodel.enemy.speed", "Lerp/Rainbow Speed", 10, 1, 100 )
local RG = gui.Slider( G, "viewmodel.enemy.rainbow.gamma", "Rainbow Gamma", 100, 1, 100 )
local PHONG = gui.Slider( G, "viewmodel.enemy.phong", "Phong", 0, 0, 100 )
local PEARL = gui.Slider( G, "viewmodel.enemy.pearl","Pearlescent", 0, 0, 100 )
local REFLECTIVITY = gui.Slider(G,"viewmodel.enemy.reflectivity","Reflectivity",0,0,100)
local GLOW = gui.Slider( G, "viewmodel.enemy.glowint", "Glow Int", 2, 2, 50 )



local O = gui.Multibox( G, "Overlay" )
local O_WIRE = gui.Checkbox( O, "viewmodel.enemy.overlay.wire", "Wire", false )
local O_GLOW = gui.Checkbox( O, "viewmodel.enemy.overlay.glow", "Glow", false)
local O_WIRE_CLR = gui.ColorPicker( G, "viewmodel.enemy.overlay.wire.clr", "Wire Overlay Color", 255, 255, 255, 255 )
local O_GLOW_CLR = gui.ColorPicker( G, "viewmodel.enemy.overlay.glow.clr", "Glow Overlay Color", 255, 255, 255, 255 )
local O_GLOW_INT = gui.Slider( G, "viewmodel.enemy.overlay.glow.int", "Glow Overlay Int", 2, 2, 50 )

local o_w = nil
local o_g = nil
local g_old_r,g_old_g,g_old_b,g_old_a = 255
local g_old_glow = 2

local old_r,old_g,old_b,old_a = 255
local old_phong, old_pearl, old_reflectivity, old_glow = 0
local mat = nil
local old_type = 0


local function OnDraw()
    local r,g,b,a = T_CLR:GetValue()
    local type = T:GetValue()
    local pearl = PEARL:GetValue() / 100 * 10
    local phong = PHONG:GetValue() / 100 * 20
    local reflectivity = REFLECTIVITY:GetValue()/100
    local glow = GLOW:GetValue()
    if old_type ~= type or mat == nil or old_r ~= r or old_g ~= g or old_b ~= b or old_a ~= a or old_pearl ~= pearl or old_phong ~= phong or old_reflectivity ~= reflectivity or old_glow ~= glow then
        if type == 0 then
            mat = materials.Create("aw_vm_enemy",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additive
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 * reflectivity .. " " .. g/255 * reflectivity .. " " .. b/255 * reflectivity .. [[]"
                    $phong 1
                    $phongboost ]] .. phong .. [[
                    $basemapalphaphongmask 1
                    $pearlescent ]] .. pearl.. [[ 
                }
            ]])
        elseif type == 1 then
            mat = materials.Create("aw_vm_enemy",
            [[
                UnlitGeneric
                {
                    $model 1
                }
            ]])
        elseif type == 2 then
            mat = materials.Create("aw_vm_enemy",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additve
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                }
            ]])
        elseif type == 3 then
            mat = materials.Create("aw_vm_enemy",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additive
                    $envmap models/effects/cube_white
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                    $envmapfresnel 1
                    $envmapfresnelminmaxexp "[0 1 ]] ..  glow .. [[]"
                }
            ]])
        elseif type == 4 then
            mat = materials.Create( "aw_vm_enemy", 
            [[
                VertexLitGeneric
                {
	                $baseTexture			black
	                $bumpmap				effects\flat_normal
	                $translucent 1
	                $alpha 0.4
	                $envmap		models\effects\crystal_cube_vertigo_hdr
	                $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 ..[[]"
	                //$envmaptint "[0.8 1.2 1.5]"
	                //$envmapcontrast 1.2
	                $envmapsaturation 0.1
	                $envmapfresnel 0
	                $phong 1
	                $phongexponent 16
	                $phongtint "[]].. r/255 .. " " .. g/255 .. " " .. b/255 ..[[]"
	                $phongboost 2
	                //$nocull 1
                }
            ]])
        end
    end
    old_r,old_g,old_b,old_a = T_CLR:GetValue()
    old_type = type
    old_pearl = pearl
    old_phong = phong
    old_reflectivity = reflectivity
    old_glow = glow
end

local function Overlay()
    local wr,wg,wb,wa = O_WIRE_CLR:GetValue()
    local gr,gg,gb,ga = O_GLOW_CLR:GetValue()
    local glow = O_GLOW_INT:GetValue()
    if o_w == nil then
        o_w = materials.Create("aw_vm_enemy_wire",
        [[
            VertexLitGeneric
            {
                $basetexture vgui/white_additive
            }
        ]])
    end
    if o_g == nil or g_old_r ~= gr or g_old_g ~= gg or g_old_b ~= gb or g_old_glow ~= glow then
        o_g = materials.Create("aw_vm_enemy_glow",
        [[
            VertexLitGeneric
            {
                $additive 1
                $envmap models/effects/cube_white
                $envmaptint "[]].. gr/255 .. " " .. gg/255 .. " " .. gb/255 .. [[]"
                $envmapfresnel 1
                $envmapfresnelminmaxexp "[0 1 ]].. glow .. [[]"
            }
        ]])
    end

    g_old_r,g_old_g,g_old_b,g_old_a = O_GLOW_CLR:GetValue()
    g_old_glow = O_GLOW_INT:GetValue()
    
end

local function Model(Context)
    if Context:GetEntity() ~= nil and C:GetValue() then
        gui.SetValue( "esp.chams.enemy.visible", 0 )
        if Context:GetEntity():GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and Context:GetEntity():IsPlayer() then
            local r,g,b,a = CLR:GetValue()
            if COLOR:GetValue() == 0 then
                mat:ColorModulate(r/255,g/255,b/255)
            elseif COLOR:GetValue() == 1 then
                r,g,b = MakeRainbow(SPEED:GetValue(),RG:GetValue())
                mat:ColorModulate(r/255,g/255,b/255)
            elseif COLOR:GetValue() == 2 then
                local r1,g1,b1,a1 = CLR_L_1:GetValue()
                local r2,g2,b2,a2 = CLR_L_2:GetValue()
                r = lerp(r1,r2,math.sin(globals.RealTime() * SPEED:GetValue() / 10))
                g = lerp(g1,g2,math.sin(globals.RealTime() * SPEED:GetValue() / 10))
                b = lerp(b1,b2,math.sin(globals.RealTime() * SPEED:GetValue() / 10))
                mat:ColorModulate(r/255,g/255,b/255)
            end
            mat:AlphaModulate(a/255)
            mat:SetMaterialVarFlag(128,A:GetValue())
            Context:ForcedMaterialOverride(mat)

            if O_WIRE:GetValue() then
                local r,g,b,a = O_WIRE_CLR:GetValue()
                Context:DrawExtraPass()
                o_w:AlphaModulate(a/255)
                o_w:ColorModulate(r/255,g/255,b/255)
                o_w:SetMaterialVarFlag(268435456,1)
                Context:ForcedMaterialOverride(o_w)
            end
            if O_GLOW:GetValue() then
                local r,g,b,a = O_GLOW_CLR:GetValue()
                Context:DrawExtraPass()
                o_g:AlphaModulate(a/255)
                Context:ForcedMaterialOverride(o_g)
            end
        end
    end
end

local function GUIWork()
    if COLOR:GetValue() == 0 then
        CLR_L_1:SetDisabled(true)
        CLR_L_2:SetDisabled(true)
        SPEED:SetDisabled(true)
        RG:SetDisabled(true)
    elseif COLOR:GetValue() == 1 then
        CLR_L_1:SetDisabled(true)
        CLR_L_2:SetDisabled(true)
        SPEED:SetDisabled(false)
        RG:SetDisabled(false)
    elseif COLOR:GetValue() == 2 then
        CLR_L_1:SetDisabled(false)
        CLR_L_2:SetDisabled(false)
        SPEED:SetDisabled(false)
        RG:SetDisabled(true)
    end
    if T:GetValue() == 0 then
        PHONG:SetDisabled(false)
        REFLECTIVITY:SetDisabled(false)
        PEARL:SetDisabled(false)
    else
        PHONG:SetDisabled(true)
        REFLECTIVITY:SetDisabled(true)
        PEARL:SetDisabled(true)
    end
    if T:GetValue() == 3 then
        GLOW:SetDisabled(false)
    else
        GLOW:SetDisabled(true)
    end
    if O_GLOW:GetValue() then
        O_GLOW_INT:SetDisabled(false)
        O_GLOW_CLR:SetDisabled(false)
    else
        O_GLOW_INT:SetDisabled(true)
        O_GLOW_CLR:SetDisabled(true)
    end
    if O_WIRE:GetValue() then
        O_WIRE_CLR:SetDisabled(false)
    else
        O_WIRE_CLR:SetDisabled(true)
    end
end

callbacks.Register( "Draw", GUIWork )
callbacks.Register( "Draw", OnDraw )
callbacks.Register( "DrawModel", Model)
callbacks.Register( "Draw", Overlay )