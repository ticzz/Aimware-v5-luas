-- Gui

local friendly_overlay = gui.Reference( "Visuals" , "Overlay" , "Friendly" )
local friendly_name_Checkbox = gui.Checkbox( friendly_overlay, "customesp.friendly.name", "Name", 0 );
local friendly_name_ColorPicker = gui.ColorPicker( friendly_name_Checkbox, "clr", "clr", 255, 255, 255, 255 )
friendly_name_Checkbox:SetDescription("Draw entity name.")

local enemy_overlay = gui.Reference( "Visuals" , "Overlay" , "Enemy" )
local enemy_name_Checkbox = gui.Checkbox( enemy_overlay, "customesp.enemy.name", "Name", 0 );
local enemy_name_ColorPicker = gui.ColorPicker( enemy_name_Checkbox, "clr", "clr", 255, 255, 255, 255 )
local enemy_ammo_Checkbox = gui.Checkbox( enemy_overlay, "customesp.ammo", "Ammo", 0 );
local enemy_velo_Checkbox = gui.Checkbox( enemy_overlay, "customesp.velocity", "Velocity", 0 );
enemy_name_Checkbox:SetDescription("Draw entity name.")
enemy_ammo_Checkbox:SetDescription("Draw entity ammo.")
enemy_velo_Checkbox:SetDescription("Draw entity velocity.")

-- biggest shouts to trollface and scape

local ref = gui.Reference("Visuals")
local tab = gui.Tab(ref, "box", "MOAR BOX")
local gbox = gui.Groupbox(tab, "Box Settings", 16, 16, 296, 1)
local edge = gui.Checkbox(gbox, "edge", "Box Edge", 1)
local outline = gui.Checkbox(gbox, "outline", "Outline", 1)
local edgeamt = gui.Slider(gbox, "edge.size", "Edge Size", 30, 1, 50)
local edgecol = gui.ColorPicker(edge, "edge.color", "Edge Color", 255, 255, 255, 255)

local fill = gui.Checkbox(gbox, "fill", "Box Fill", 0)
local fillcol = gui.ColorPicker(fill, "fill.color", "Fill Color", 255, 255, 255, 150)
local fillhp = gui.Checkbox(gbox, "fill.hp", "Fill With HP", 0)
local fillcolhp = gui.Checkbox(gbox, "fill.color.hp", "Color by HP", 0)

callbacks.Register("DrawESP", function(esp)

    local e = esp:GetEntity();
	local name = e:GetName();
	if not e:IsAlive() then return end	
		
	
    if (e:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber()) then return end
    local x, y, x2, y2 = esp:GetRect()

    if fill:GetValue() then
        if fillcolhp:GetValue() then
            local hp = esp:GetEntity():GetHealth()
            local fillcolor = { fillcol:GetValue() }
            draw.Color(255 - (hp * (255/100)), ( hp * (255/100)), 0, fillcolor[4])
        else
            local fillcolor = { fillcol:GetValue() }
            draw.Color(fillcolor[1], fillcolor[2], fillcolor[3], fillcolor[4])
        end

        if fillhp:GetValue() then
            local hp = esp:GetEntity():GetHealth()
            draw.FilledRect(x, y2 - (y2 - y) * (hp * 0.01), x2, y2)
        else
            draw.FilledRect(x, y, x2, y2)
        end
    end

    if outline:GetValue() then

        local size = 1 - edgeamt:GetValue() * 0.01

        draw.Color(0, 0, 0, 255)
        draw.ShadowRect((x) + (x2 - x) * size, y2, x2, y2, 7)
        draw.ShadowRect(x2, (y) + (y2 - y) * size, x2, y2, 7)


        draw.ShadowRect(x, (y) + (y2 - y) * size, x, y2, 7)
        draw.ShadowRect(x, y2, (x2) - (x2 - x) * size, y2, 7)


        draw.ShadowRect(x, (y2) - (y2 - y) * size, x, y, 7)
        draw.ShadowRect(x, y, (x2) - (x2 - x) * size, y, 7)


        draw.ShadowRect((x) + (x2 - x) * size, y, x2, y, 7)
        draw.ShadowRect(x2, (y2) - (y2 - y) * size, x2, y, 7)

    end

    if edge:GetValue() then

        local size = 1 - edgeamt:GetValue() * 0.01
        local edgecolor = {edgecol:GetValue() }
        draw.Color(edgecolor[1], edgecolor[2], edgecolor[3], edgecolor[4])
        draw.Line((x) + (x2 - x) * size, y2, x2, y2)
        draw.Line(x2 , (y) + (y2 - y) * size, x2, y2)

        draw.Line(x, (y) + (y2 - y) * size, x, y2)
        draw.Line(x, y2, (x2) - (x2 - x) * size, y2)

        draw.Line((x) + (x2 - x) * size, y, x2, y)
        draw.Line(x, (y2) - (y2 - y) * size, x, y)


        draw.Line(x, y, (x2) - (x2 - x) * size, y)
        draw.Line(x2, (y2) - (y2 - y) * size, x2, y)
    end
	client.Command("echo [Aimware] Loading EdgeBox ESP",1)
	
	--##########################################################################################################
	
	if  enemy_ammo_Checkbox:GetValue() then
	if (e:IsPlayer() ~= true or entities.GetLocalPlayer() == nil) or not e:IsAlive() or entities.GetLocalPlayer():GetTeamNumber() == e:GetTeamNumber() then return end
    esp:Color(62, 214, 209, 255)
    ActiveWeapon = e:GetPropEntity("m_hActiveWeapon")
    esp:AddTextBottom(ActiveWeapon:GetProp("m_iClip1") .. "/" .. ActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount") )
	end
	client.Command("echo [Aimware] Loading Ammo ESP",1)
	
	--##########################################################################################################
	

	if  enemy_velo_Checkbox:GetValue() then
	if (e:IsPlayer() ~= true or entities.GetLocalPlayer() == nil) or not e:IsAlive() or entities.GetLocalPlayer():GetTeamNumber() == e:GetTeamNumber() then return end
    esp:Color(255, 255, 0, 255)
    esp:AddTextRight("IQ: " .. math.floor(Vector3(e:GetPropFloat("localdata", "m_vecVelocity[0]"), e:GetPropFloat("localdata", "m_vecVelocity[1]"), e:GetPropFloat("localdata", "m_vecVelocity[2]")):Length2D()))
	end
	client.Command("echo [Aimware] Loading Velocity ESP",1)
	
	--##########################################################################################################
	

	if friendly_name_Checkbox:GetValue() then
    gui.SetValue( "esp.overlay.friendly.name", 0 )
		if e:IsPlayer() and e:IsAlive() and e:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() then
			esp:Color( friendly_name_ColorPicker:GetValue() );    
			esp:AddTextTop(name);
		else	
			gui.SetValue( "esp.overlay.friendly.name", 1 )
		end	
	end
	client.Command("echo [Aimware] Loading ESP Name Colors",1)
	
	--##########################################################################################################
	
    
	if enemy_name_Checkbox:GetValue() then
	gui.SetValue( "esp.overlay.enemy.name", 0 )
		if e:IsPlayer() and e:IsAlive() and e:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then
			esp:Color( enemy_name_ColorPicker:GetValue() ); 
			esp:AddTextTop(name);  
		else	
			gui.SetValue( "esp.overlay.enemy.name", 1 )
		end	
	end
	client.Command("echo [Aimware] Loading ESP Name Colors",1)

end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

