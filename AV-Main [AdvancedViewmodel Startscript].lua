local function MakeRainbow(speed,gamma)
    local r = (math.sin(globals.RealTime() * speed / 10) * 127 + 128) * gamma / 100
    local g = (math.sin(globals.RealTime() * speed / 10 + 2) * 127 + 128) * gamma / 100
    local b = (math.sin(globals.RealTime() * speed / 10 + 4) * 127 + 128) * gamma / 100
    return r,g,b
end

local function lerp(a,b,t) return a * (1-math.abs(t)) + b * math.abs(t) end








TAB = gui.Tab( gui.Reference( "Visuals" ), "viewmodel.tab", "Adv.Viewmodel" )

local HG = gui.Groupbox( TAB, "Hand", 15, 15, (640-45)/2, 640 )
local HC = gui.Checkbox( HG, "viewmodel.hand", "Enable For Hands", false )
local H_CLR = gui.ColorPicker( HC, "viewmodel.hand.clr", "Hand Color", 255, 255, 255, 255 )
local HT = gui.Combobox( HG, "viewmodel.hand.type", "Hand Material", "Custom","Flat","Chromium","Glow","Crystal" )
local HT_CLR = gui.ColorPicker( HT, "viewmodel.hand.type.clr", "Special Hand Color", 255, 255, 255, 255 )
local HA = gui.Checkbox( HG, "viewmodel.hand.additive", "Additive", false )
local HCOLOR = gui.Combobox( HG, "viewmodel.hand.colorbase", "Color Modulation Base", "Static","Rainbow","Lerp" )
local H_CLR_L_1 = gui.ColorPicker( HG, "viewmodel.hand.lerp.clr1", "Lerp From", 255, 255, 255, 255 )
local H_CLR_L_2 = gui.ColorPicker( HG, "viewmodel.hand.lerp.clr2", "Lerp To", 255, 255, 255, 255 )
local HSPEED = gui.Slider( HG, "viewmodel.hand.speed", "Lerp/Rainbow Speed", 10, 1, 100 )
local HRG = gui.Slider( HG, "viewmodel.hand.rainbow.gamma", "Rainbow Gamma", 100, 1, 100 )
local HPHONG = gui.Slider( HG, "viewmodel.hand.phong", "Phong", 0, 0, 100 )
local HPEARL = gui.Slider( HG, "viewmodel.hand.pearl","Pearlescent", 0, 0, 100 )
local HREFLECTIVITY = gui.Slider(HG,"viewmodel.hand.reflectivity","Reflectivity",0,0,100)
local HGLOW = gui.Slider( HG, "viewmodel.hand.glowint", "Glow Int", 2, 2, 50 )



local HO = gui.Multibox( HG, "Overlay" )
local HO_WIRE = gui.Checkbox( HO, "viewmodel.hand.overlay.wire", "Wire", false )
local HO_GLOW = gui.Checkbox( HO, "viewmodel.hand.overlay.glow", "Glow", false)
local HO_WIRE_CLR = gui.ColorPicker( HG, "viewmodel.hand.overlay.wire.clr", "Wire Overlay Color", 255, 255, 255, 255 )
local HO_GLOW_CLR = gui.ColorPicker( HG, "viewmodel.hand.overlay.glow.clr", "Glow Overlay Color", 255, 255, 255, 255 )
local HO_GLOW_INT = gui.Slider( HG, "viewmodel.hand.overlay.glow.int", "Glow Overlay Int", 2, 2, 50 )

local ho_w = nil
local ho_g = nil
local hg_old_r,hg_old_g,hg_old_b,hg_old_a = 255
local hg_old_glow = 2



local h_old_r,h_old_g,h_old_b,h_old_a = 255
local h_old_type = 0
local h_old_phong, h_old_pearl, h_old_reflectivity, h_old_glow = 0
local hmat = nil






local function HOnDraw()
    local r,g,b,a = HT_CLR:GetValue()
    local type = HT:GetValue()
    local pearl = HPEARL:GetValue() / 100 * 10
    local phong = HPHONG:GetValue() / 100 * 20
    local reflectivity = HREFLECTIVITY:GetValue()/100
    local glow = HGLOW:GetValue()
    
    if h_old_type ~= type or hmat == nil or h_old_r ~= r or h_old_g ~= g or h_old_b ~= b or h_old_a ~= a or h_old_pearl ~= pearl or h_old_phong ~= phong or h_old_reflectivity ~= reflectivity or h_old_glow ~= glow then
        if type == 0 then
            hmat = materials.Create("aw_vm_hands",
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
            hmat = materials.Create("aw_vm_hands",
            [[
                UnlitGeneric
                {
                    $model 1
                }
            ]])
        elseif type == 2 then
            hmat = materials.Create("aw_vm_hands",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additve
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                }
            ]])
        elseif type == 3 then
            hmat = materials.Create("aw_vm_hands",
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
            hmat = materials.Create( "aw_vm_hands", 
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
    h_old_r,h_old_g,h_old_b,h_old_a = HT_CLR:GetValue()
    h_old_type = type
    h_old_pearl = pearl
    h_old_phong = phong
    h_old_reflectivity = reflectivity
    h_old_glow = glow

end



local function HOverlay()
    local wr,wg,wb,wa = HO_WIRE_CLR:GetValue()
    local gr,gg,gb,ga = HO_GLOW_CLR:GetValue()
    local glow = HO_GLOW_INT:GetValue()
    if ho_w == nil then
        ho_w = materials.Create("aw_vm_hands_wire",
        [[
            VertexLitGeneric
            {
                $basetexture vgui/white_additive
            }
        ]])
    end
    if ho_g == nil or hg_old_r ~= gr or hg_old_g ~= gg or hg_old_b ~= gb or hg_old_glow ~= glow then
        ho_g = materials.Create("aw_vm_hands_glow",
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
    hg_old_r,hg_old_g,hg_old_b,hg_old_a = HO_GLOW_CLR:GetValue()
    hg_old_glow = HO_GLOW_INT:GetValue()
end


local function HModel(Context)
    if Context:GetEntity() ~= nil and HC:GetValue() then
        if Context:GetEntity():GetClass() == "CBaseAnimating" then
            local r,g,b,a = H_CLR:GetValue()
            if HCOLOR:GetValue() == 0 then
                hmat:ColorModulate(r/255,g/255,b/255)
            elseif HCOLOR:GetValue() == 1 then
                r,g,b = MakeRainbow(HSPEED:GetValue(),HRG:GetValue())
                hmat:ColorModulate(r/255,g/255,b/255)
            elseif HCOLOR:GetValue() == 2 then
                local r1,g1,b1,a1 = H_CLR_L_1:GetValue()
                local r2,g2,b2,a2 = H_CLR_L_2:GetValue()
                r = lerp(r1,r2,math.sin(globals.RealTime() * HSPEED:GetValue() / 10))
                g = lerp(g1,g2,math.sin(globals.RealTime() * HSPEED:GetValue() / 10))
                b = lerp(b1,b2,math.sin(globals.RealTime() * HSPEED:GetValue() / 10))
                hmat:ColorModulate(r/255,g/255,b/255)
            end
            hmat:AlphaModulate(a/255)
            hmat:SetMaterialVarFlag(128,HA:GetValue())
            Context:ForcedMaterialOverride(hmat)
            
            if HO_WIRE:GetValue() then
                local r,g,b,a = HO_WIRE_CLR:GetValue()
                Context:DrawExtraPass()
                ho_w:AlphaModulate(a/255)
                ho_w:ColorModulate(r/255,g/255,b/255)
                ho_w:SetMaterialVarFlag(268435456,1)
                Context:ForcedMaterialOverride(ho_w)
            end
            if HO_GLOW:GetValue() then
                local r,g,b,a = HO_GLOW_CLR:GetValue()
                Context:DrawExtraPass()
                ho_g:AlphaModulate(a/255)
                Context:ForcedMaterialOverride(ho_g)
            end
        end
    end
end


local function HGUIWork()
    if HCOLOR:GetValue() == 0 then
        H_CLR_L_1:SetDisabled(true)
        H_CLR_L_2:SetDisabled(true)
        HSPEED:SetDisabled(true)
        HRG:SetDisabled(true)
    elseif HCOLOR:GetValue() == 1 then
        H_CLR_L_1:SetDisabled(true)
        H_CLR_L_2:SetDisabled(true)
        HSPEED:SetDisabled(false)
        HRG:SetDisabled(false)
    elseif HCOLOR:GetValue() == 2 then
        H_CLR_L_1:SetDisabled(false)
        H_CLR_L_2:SetDisabled(false)
        HSPEED:SetDisabled(false)
        HRG:SetDisabled(true)
    end
    if HT:GetValue() == 0 then
        HPHONG:SetDisabled(false)
        HREFLECTIVITY:SetDisabled(false)
        HPEARL:SetDisabled(false)
    else
        HPHONG:SetDisabled(true)
        HREFLECTIVITY:SetDisabled(true)
        HPEARL:SetDisabled(true)
    end
    if HT:GetValue() == 3 then
        HGLOW:SetDisabled(false)
    else
        HGLOW:SetDisabled(true)
    end
    if HO_GLOW:GetValue() then
        HO_GLOW_INT:SetDisabled(false)
        HO_GLOW_CLR:SetDisabled(false)
    else
        HO_GLOW_INT:SetDisabled(true)
        HO_GLOW_CLR:SetDisabled(true)
    end
    if HO_WIRE:GetValue() then
        HO_WIRE_CLR:SetDisabled(false)
    else
        HO_WIRE_CLR:SetDisabled(true)
    end
end

callbacks.Register( "Draw", HGUIWork )
callbacks.Register( "Draw", HOnDraw )
callbacks.Register( "DrawModel", HModel)
callbacks.Register( "Draw", HOverlay )









local WG = gui.Groupbox( TAB, "Weapon", 30 + (640-45)/2, 15, (640-45)/2, 640 )
local WC = gui.Checkbox( WG, "viewmodel.weapon", "Enable For Weapons", false )
local W_CLR = gui.ColorPicker( WC, "viewmodel.weapon.clr", "Weapon Color", 255, 255, 255, 255 )
local WT = gui.Combobox( WG, "viewmodel.weapon.type", "Weapon Material", "Custom","Flat","Chromium","Glow","Crystal" )
local WT_CLR = gui.ColorPicker( WT, "viewmodel.weapon.type.clr", "Special Weapon Color", 255, 255, 255, 255 )
local WA = gui.Checkbox( WG, "viewmodel.weapon.additive", "Additive", false )
local WCOLOR = gui.Combobox( WG, "viewmodel.weapon.colorbase", "Color Modulation Base", "Static","Rainbow","Lerp" )
local W_CLR_L_1 = gui.ColorPicker( WG, "viewmodel.weapon.lerp.clr1", "Lerp From", 255, 255, 255, 255 )
local W_CLR_L_2 = gui.ColorPicker( WG, "viewmodel.weapon.lerp.clr2", "Lerp To", 255, 255, 255, 255 )
local WSPEED = gui.Slider( WG, "viewmodel.weapon.speed", "Lerp/Rainbow Speed", 10, 1, 100 )
local WRG = gui.Slider( WG, "viewmodel.weapon.rainbow.gamma", "Rainbow Gamma", 100, 1, 100 )
local WPHONG = gui.Slider( WG, "viewmodel.weapon.phong", "Phong", 0, 0, 100 )
local WPEARL = gui.Slider( WG, "viewmodel.weapon.pearl","Pearlescent", 0, 0, 100 )
local WREFLECTIVITY = gui.Slider(WG,"viewmodel.weapon.reflectivity","Reflectivity",0,0,100)
local WGLOW = gui.Slider( WG, "viewmodel.weapon.glowint", "Glow Int", 2, 2, 50 )



local WO = gui.Multibox( WG, "Overlay" )
local WO_WIRE = gui.Checkbox( WO, "viewmodel.weapon.overlay.wire", "Wire", false )
local WO_GLOW = gui.Checkbox( WO, "viewmodel.weapon.overlay.glow", "Glow", false)
local WO_WIRE_CLR = gui.ColorPicker( WG, "viewmodel.weapon.overlay.wire.clr", "Wire Overlay Color", 255, 255, 255, 255 )
local WO_GLOW_CLR = gui.ColorPicker( WG, "viewmodel.weapon.overlay.glow.clr", "Glow Overlay Color", 255, 255, 255, 255 )
local WO_GLOW_INT = gui.Slider( WG, "viewmodel.weapon.overlay.glow.int", "Glow Overlay Int", 2, 2, 50 )

local wo_w = nil
local wo_g = nil
local wg_old_r,wg_old_g,wg_old_b,wg_old_a = 255
local wg_old_glow = 2

local w_old_r,w_old_g,w_old_b,w_old_a = 255
local w_old_phong, w_old_pearl, w_old_reflectivity, w_old_glow = 0
local wmat = nil
local w_old_type = 0


local function WOnDraw()
    local r,g,b,a = WT_CLR:GetValue()
    local type = WT:GetValue()
    local pearl = WPEARL:GetValue() / 100 * 10
    local phong = WPHONG:GetValue() / 100 * 20
    local reflectivity = WREFLECTIVITY:GetValue()/100
    local glow = WGLOW:GetValue()
    if w_old_type ~= type or wmat == nil or w_old_r ~= r or w_old_g ~= g or w_old_b ~= b or w_old_a ~= a or w_old_pearl ~= pearl or w_old_phong ~= phong or w_old_reflectivity ~= reflectivity or w_old_glow ~= glow then
        if type == 0 then
            wmat = materials.Create("aw_vm_weapon",
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
            wmat = materials.Create("aw_vm_weapon",
            [[
                UnlitGeneric
                {
                    $model 1
                }
            ]])
        elseif type == 2 then
            wmat = materials.Create("aw_vm_weapon",
            [[
                VertexLitGeneric
                {
                    $basetexture vgui/white_additve
                    $envmap env_cubemap
                    $envmaptint "[]] .. r/255 .. " " .. g/255 .. " " .. b/255 .. [[]"
                }
            ]])
        elseif type == 3 then
            wmat = materials.Create("aw_vm_weapon",
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
            wmat = materials.Create( "aw_vm_weapon", 
            [[
                VertexLitGeneric
                {
	                $baseTexture			black
	                $bumpmap				effects\flat_normal
	                $translucent 1
	                $alpha 0.4
	                $envmap		models\effects\crystal_cube_vertigo_hdr
	                $envmaptint "[]] .. wr/255 .. " " .. wg/255 .. " " .. wb/255 ..[[]"
	                //$envmaptint "[0.8 1.2 1.5]"
	                //$envmapcontrast 1.2
	                $envmapsaturation 0.1
	                $envmapfresnel 0
	                $phong 1
	                $phongexponent 16
	                $phongtint "[]].. wr/255 .. " " .. wg/255 .. " " .. wb/255 ..[[]"
	                $phongboost 2
	                //$nocull 1
                }
            ]])
        end
    end
    w_old_r,w_old_g,w_old_b,w_old_a = WT_CLR:GetValue()
    w_old_type = type
    w_old_pearl = pearl
    w_old_phong = phong
    w_old_reflectivity = reflectivity
    w_old_glow = glow
end

local function WOverlay()
    local wr,wg,wb,wa = WO_WIRE_CLR:GetValue()
    local gr,gg,gb,ga = WO_GLOW_CLR:GetValue()
    local glow = WO_GLOW_INT:GetValue()
    if wo_w == nil then
        wo_w = materials.Create("aw_vm_hands_wire",
        [[
            VertexLitGeneric
            {
                $basetexture vgui/white_additive
            }
        ]])
    end
    if wo_g == nil or wg_old_r ~= gr or wg_old_g ~= gg or wg_old_b ~= gb or wg_old_glow ~= glow then
        wo_g = materials.Create("aw_vm_hands_glow",
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
    wg_old_r,wg_old_g,wg_old_b,wg_old_a = WO_GLOW_CLR:GetValue()
    wg_old_glow = WO_GLOW_INT:GetValue()
end

local function WModel(Context)
    if Context:GetEntity() ~= nil and WC:GetValue() then
        if Context:GetEntity():GetClass() == "CPredictedViewModel" then
            local r,g,b,a = W_CLR:GetValue()
            if WCOLOR:GetValue() == 0 then
                wmat:ColorModulate(r/255,g/255,b/255)
            elseif WCOLOR:GetValue() == 1 then
                r,g,b = MakeRainbow(WSPEED:GetValue(),WRG:GetValue())
                wmat:ColorModulate(r/255,g/255,b/255)
            elseif WCOLOR:GetValue() == 2 then
                local r1,g1,b1,a1 = W_CLR_L_1:GetValue()
                local r2,g2,b2,a2 = W_CLR_L_2:GetValue()
                r = lerp(r1,r2,math.sin(globals.RealTime() * WSPEED:GetValue() / 10))
                g = lerp(g1,g2,math.sin(globals.RealTime() * WSPEED:GetValue() / 10))
                b = lerp(b1,b2,math.sin(globals.RealTime() * WSPEED:GetValue() / 10))
                wmat:ColorModulate(r/255,g/255,b/255)
            end
            wmat:AlphaModulate(a/255)
            wmat:SetMaterialVarFlag(128,WA:GetValue())
            Context:ForcedMaterialOverride(wmat)

            if WO_WIRE:GetValue() then
                local r,g,b,a = WO_WIRE_CLR:GetValue()
                Context:DrawExtraPass()
                wo_w:AlphaModulate(a/255)
                wo_w:ColorModulate(r/255,g/255,b/255)
                wo_w:SetMaterialVarFlag(268435456,1)
                Context:ForcedMaterialOverride(wo_w)
            end
            if WO_GLOW:GetValue() then
                local r,g,b,a = WO_GLOW_CLR:GetValue()
                Context:DrawExtraPass()
                wo_g:AlphaModulate(a/255)
                Context:ForcedMaterialOverride(wo_g)
            end
        end
    end
end

local function WGUIWork()
    if WCOLOR:GetValue() == 0 then
        W_CLR_L_1:SetDisabled(true)
        W_CLR_L_2:SetDisabled(true)
        WSPEED:SetDisabled(true)
        WRG:SetDisabled(true)
    elseif WCOLOR:GetValue() == 1 then
        W_CLR_L_1:SetDisabled(true)
        W_CLR_L_2:SetDisabled(true)
        WSPEED:SetDisabled(false)
        WRG:SetDisabled(false)
    elseif WCOLOR:GetValue() == 2 then
        W_CLR_L_1:SetDisabled(false)
        W_CLR_L_2:SetDisabled(false)
        WSPEED:SetDisabled(false)
        WRG:SetDisabled(true)
    end
    if WT:GetValue() == 0 then
        WPHONG:SetDisabled(false)
        WREFLECTIVITY:SetDisabled(false)
        WPEARL:SetDisabled(false)
    else
        WPHONG:SetDisabled(true)
        WREFLECTIVITY:SetDisabled(true)
        WPEARL:SetDisabled(true)
    end
    if WT:GetValue() == 3 then
        WGLOW:SetDisabled(false)
    else
        WGLOW:SetDisabled(true)
    end
    if WO_GLOW:GetValue() then
        WO_GLOW_INT:SetDisabled(false)
        WO_GLOW_CLR:SetDisabled(false)
    else
        WO_GLOW_INT:SetDisabled(true)
        WO_GLOW_CLR:SetDisabled(true)
    end
    if WO_WIRE:GetValue() then
        WO_WIRE_CLR:SetDisabled(false)
    else
        WO_WIRE_CLR:SetDisabled(true)
    end
end

callbacks.Register( "Draw", WGUIWork )
callbacks.Register( "Draw", WOnDraw )
callbacks.Register( "DrawModel", WModel)
callbacks.Register( "Draw", WOverlay )



LoadScript( "AdvancedViewmodel/AV-Local.lua" )
LoadScript( "AdvancedViewmodel/AV-Teammate.lua" )
LoadScript( "AdvancedViewmodel/AV-Enemy.lua" )
