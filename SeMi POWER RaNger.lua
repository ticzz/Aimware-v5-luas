local Font = draw.CreateFont("Microsoft Tai Le",22, 2000)--("Verdana", 24, 700)
local Font2 = draw.CreateFont("Marlett", 35, 700)
--local Font2 = draw.CreateFont("Marlett", 35, 700)

local screenW, screenH = draw.GetScreenSize()
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local baim = 1;

 ------------------------------------------------ Window 
local Window = gui.Window( "semirageWindow", "Semirage Helper", 150, 150, 530, 730  )
Window:SetOpenKey( 45 )

--local TAB=gui.Tab(gui.Reference("Misc"), "semirage", "Extra")
local GROUPBOX_MAIN=gui.Groupbox(Window, "Semirage Helper", 10, 10, 300)

local GROUPBOX_AIMBOT=gui.Groupbox(Window, "Aimbot Things", 320, 160, 200)
 
local GROUPBOX_MISC=gui.Groupbox(Window, "Misc Things",320, 10, 200)--320, 10, 200
-----------------------------------------------------------Menu Items---------------------------------------------------------------
 
local KEYBOX_SWITCHBOT = gui.Keybox( GROUPBOX_MAIN, "switchBot", "Switch L/R", 0 )
KEYBOX_SWITCHBOT:SetDescription("Switch Legit and Rage")

local KEYBOX_AAOFF = gui.Keybox( GROUPBOX_MAIN, "aaoff", "LegitAA Off", 0 )
KEYBOX_SWITCHBOT:SetDescription("TurnOff legitAA")
 
local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "Inverter", 0)
KEYBOX_INVERTER:SetDescription("Switch the side of anti-aim")

local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "AutoWall", 0)
KEYBOX_AWSWITCH:SetDescription("Toggle Awall")

local KEYBOX_BAIM=gui.Keybox(GROUPBOX_MAIN, "baimkey", "Baim On Key", 0)
KEYBOX_BAIM:SetDescription("Set the hitboxes to pelvis")
 

 
local KEYBOX_RESOLVERSWITCH=gui.Keybox(GROUPBOX_MAIN, "resolverswitch", "Resolver", 0)
KEYBOX_RESOLVERSWITCH:SetDescription("Toggle the Resolver when the bind pressed")

  
local CHECKBOX_ALL = gui.Checkbox(GROUPBOX_MAIN, "IndicatorsALL", "Indicators", 0)


local IndX = gui.Slider(GROUPBOX_MAIN, "IndX", " Ind X Pos", 15, 0, screenW)
local IndY = gui.Slider(GROUPBOX_MAIN, "IndY", "Ind Y Pos", screenH/4*3, 0, screenH)

local ArrowX = gui.Slider(GROUPBOX_MAIN, "ArrowX", "Arrow X Pos", 15, 0, screenW)
local ArrowY = gui.Slider(GROUPBOX_MAIN, "ArrowY", "Arrow Y Pos", 15, 0, screenW)
--gui.Slider( parent, varname, name, value, min, max )

 
 
 
 -----------------------------------------------------------misc Things Menu---------------------------------------------------------------

local sniper_crosshair = gui.Checkbox(GROUPBOX_MISC, "sniper_crosshair", "Sniper Crosshair", false)

local aspect_ratio_check = gui.Checkbox(GROUPBOX_MISC, "aspect_ratio_check", "Aspect Ratio Changer", false);
local ASPECT_SLIDER = gui.Slider( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", 100, 1, 199)--gui.Combobox( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", "OFF", "1.0", "1.5", "2.0" )
 

 
local SLIDER_VIEW = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_view", "Viewmodel Field of View", 60, 0, 180 )
local SLIDER_VIEWX = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewX", "Viewmodel Offset X", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewY", "Viewmodel Offset Y", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewZ", "Viewmodel Offset Z", -1, -40, 40 ) 

 
-----------------------------------------------------------Aimbot things menu ---------------------------------------------------------------

local chk_dynfov = gui.Checkbox(GROUPBOX_AIMBOT, "chk_dynfov", "Dynamic FOV", false)
local sld_minfov = gui.Slider(GROUPBOX_AIMBOT, "sld_minfov", "Minimum Dynamic FOV", 5, 0, 30)
local sld_maxfov = gui.Slider(GROUPBOX_AIMBOT, "sld_maxfov", "Maximum Dynamic FOV", 25, 0, 30)
 -----------------------------------------------------------Indicators---------------------------------------------------------------

local function indicatorsMala()

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    draw.SetFont(Font)

--rbot indicator
if CHECKBOX_ALL:GetValue() then --legit / rage indicator

    if switchB then 

       draw.Color(100,100,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue(), "LEGIT[1]")
    else
        draw.Color(100,100,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue(), "RAGE[1]")
    end

end

--baim indicator
if CHECKBOX_ALL:GetValue() then 
    if (baim%2 == 0) then
        draw.Color(0, 255, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 20, "BAIM[3]")
    elseif (baim%2 == 1) then
        draw.Color(255, 0, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 20, "BAIM[3]")
    end
end

--awall indicator
if CHECKBOX_ALL:GetValue() then 
    if awtggl then
        draw.Color(0, 255, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 40, "AWALL[2]")
    else
        draw.Color(255, 0, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 40, "AWALL[2]")
    end
end

-- resolver indicator

if CHECKBOX_ALL:GetValue() then 
    if (gui.GetValue( "rbot.accuracy.posadj.resolver")) then 
        draw.Color( 0, 255, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 60, "RESOLVER[4]")
    else
        draw.Color(255, 0, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 60, "RESOLVER[4]")
    end 
end

--dsc inv indicator
if CHECKBOX_ALL:GetValue() then
    if invrtr and not aaoff then
        draw.Color(0,255,0,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 80, "DESYNC:RIGHT")
    elseif not invrtr and not aaoff then
		draw.Color(0,255,0,255)
		draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 80, "DESYNC:LEFT")
    else
		draw.Color(255,0,0,255)
		draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 80, "DESYNC:OFF")
	end
end

--fakelag indicator
if CHECKBOX_ALL:GetValue() then 
    if (gui.GetValue("misc.fakelag.enable") == true) then
        draw.Color(0, 255, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 100, "FAKELAG[H]")
    else
        draw.Color(255, 0, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 100, "FAKELAG[H]")
    end
end

--autofire indicator
if CHECKBOX_ALL:GetValue() then 
    if (gui.GetValue("rbot.aim.enable") == true) then
        draw.Color(0, 255, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 120, "AUTOFIRE[ALT]")
    else
        draw.Color(255, 0, 0, 255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 120, "AUTOFIRE[ALT]")
    end
end
 
 --fov indicator
if CHECKBOX_ALL:GetValue() then
    
        draw.Color(255,255,255,255)
        draw.TextShadow(IndX:GetValue(), IndY:GetValue() - 140, "FOV: ")
   
        draw.Color(255,255,255,255)
        draw.TextShadow(IndX:GetValue() + 40, IndY:GetValue() - 140, gui.GetValue( "rbot.aim.target.fov" ))
        
    
end
 

end


callbacks.Register("Draw", "semiragehelper", indicatorsMala)
callbacks.Register("Draw", function()
 
    IndX:SetInvisible(not CHECKBOX_ALL:GetValue())
    IndY:SetInvisible(not CHECKBOX_ALL:GetValue())
ArrowX:SetInvisible(not CHECKBOX_ALL:GetValue())
ArrowY:SetInvisible(not CHECKBOX_ALL:GetValue())
end)
-------------------------------------------------AA inverter Arrow
 


local function arrow()

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

    if not gui.GetValue( "rbot.master" ) then return end

    draw.SetFont( Font2 )
     

        if CHECKBOX_ALL:GetValue() then
            if invrtr and not aaoff then

                draw.Color(127,0,255,255)
                draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "⮞")

                draw.Color(229,204,255,255)
                draw.TextShadow( ArrowX:GetValue() - 120,ArrowY:GetValue(), "⮜")

            elseif not invrtr and not aaoff then

                draw.Color(229,204,255,255)
                draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "⮞")

                draw.Color(127,0,255,255)
                draw.TextShadow( ArrowX:GetValue() - 120,ArrowY:GetValue(), "⮜")
			else
				draw.Color(229,204,255,0)
                draw.TextShadow(ArrowX:GetValue() ,ArrowY:GetValue(), "⮞")

                draw.Color(127,0,255,0)
                draw.TextShadow( ArrowX:GetValue() - 120,ArrowY:GetValue(), "⮜")
                
            end
        end
    
    end
    callbacks.Register("Draw", "semiragehelper", arrow)
--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------Function---------------------------------------------------------------

-------------------------------------------------------- Toggle Awall

local function awswitch()


    
    if KEYBOX_AWSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AWSWITCH:GetValue()) then
            awtggl = not awtggl
        end
        if awtggl then
            
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 1)

            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 1)

        else
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 0)

            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 0)

        end
    end
end

callbacks.Register("Draw", "semiragehelper", awswitch)

-------------------------------------------------------- AA OFF

local function aaoff()
    if KEYBOX_AAOFF:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AAOFF:GetValue()) then
            aaoff = true
			gui.SetValue("rbot.antiaim.base", "0.0 Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
            gui.SetValue("rbot.antiaim.left", 0)
            gui.SetValue("rbot.antiaim.right", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
        end
    end
end

callbacks.Register("Draw", "semiragehelper", aaoff) 

-------------------------------------------------------- AA inverter

local function finverter()
    if KEYBOX_INVERTER:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_INVERTER:GetValue()) then
            invrtr = not invrtr
			aaoff=false
        end
        if invrtr and not aaoff then
            gui.SetValue("rbot.antiaim.base", "-29.0 Desync")
            gui.SetValue("rbot.antiaim.advanced.pitch", 0)
            gui.SetValue("rbot.antiaim.base.rotation", -58)
            gui.SetValue("rbot.antiaim.base.lby", 58)
            gui.SetValue("rbot.antiaim.left", 0)
            gui.SetValue("rbot.antiaim.right", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
            gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
        else
			if not invrtr and not aaoff then
				gui.SetValue("rbot.antiaim.base", "29.0 Desync")
				gui.SetValue("rbot.antiaim.advanced.pitch", 0)
				gui.SetValue("rbot.antiaim.base.rotation", 58)
				gui.SetValue("rbot.antiaim.base.lby", -58)
				gui.SetValue("rbot.antiaim.left", 0)
				gui.SetValue("rbot.antiaim.right", 0)
				gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
				gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
				gui.SetValue("rbot.antiaim.advanced.antialign", "Lowerbody")
			end
        end
    end
end

callbacks.Register("Draw", "semiragehelper", finverter) 

--------------------------------------------------Legit/Rage Switch

 local function switchBot()

    if KEYBOX_SWITCHBOT:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_SWITCHBOT:GetValue()) then
            switchB = not switchB
        end
        if switchB then
            
            gui.SetValue("lbot.master", 1)
            gui.SetValue("rbot.master", 0)
        else
            gui.SetValue("lbot.master", 0)

            gui.SetValue("rbot.master", 1)

        end
    end

 end
callbacks.Register("Draw", "semiragehelper", switchBot)


--------------------------------------------------toggle resolver
local function rslvSwitch()


    if KEYBOX_RESOLVERSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_RESOLVERSWITCH:GetValue()) then
           rslrswt = not rslrswt
        end
        if rslrswt then
            
            gui.SetValue("rbot.accuracy.posadj.resolver", 0)

        else

            gui.SetValue("rbot.accuracy.posadj.resolver", 1)

        end
    end

end

callbacks.Register( "Draw", "semiragehelper", rslvSwitch)


--------------------------------------------------Dynamic Fov(Pasted but nvm)


local viewangles;

local function dynamicfov_logic()
local pLocal = entities.GetLocalPlayer()

if not chk_dynfov:GetValue() then return end
if not pLocal then return end
if not pLocal:GetAbsOrigin() then return end

local dynamicfov_new_fov = gui.GetValue("rbot.aim.target.fov")
local players = entities.FindByClass("CCSPlayer")
local enemy_players = {}

local min_fov = sld_minfov:GetValue()
local max_fov = sld_maxfov:GetValue()

if min_fov > max_fov then
local store_min_fov = min_fov
min_fov = max_fov
max_fov = store_min_fov
end

for i = 1, #players do
if players[i]:GetPropInt("m_iTeamNum") ~= entities.GetLocalPlayer():GetPropInt("m_iTeamNum") and not players[i]:IsDormant() then
table.insert(enemy_players, players[i])
end
end

if #enemy_players ~= 0 then
local own_hitbox = pLocal:GetHitboxPosition(0)
local own_x, own_y, own_z = own_hitbox.x, own_hitbox.y, own_hitbox.z
local own_pitch, own_yaw = viewangles.pitch, viewangles.yaw
closest_enemy = nil
local closest_distance = math.huge

for i = 1, #enemy_players do
local enemy = enemy_players[i]
local enemy_x, enemy_y, enemy_z = enemy:GetHitboxPosition(0).x, enemy:GetHitboxPosition(0).y, enemy:GetHitboxPosition(0).z
local x = enemy_x - own_x
local y = enemy_y - own_y
local z = enemy_z - own_z

local yaw = (math.atan2(y, x) * 180 / math.pi)
local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 180 / math.pi)

            local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
            local pitch_dif = math.abs(own_pitch - pitch) % 360

            if yaw_dif > 180 then
                yaw_dif = 360 - yaw_dif
            end

            local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

            if closest_distance > real_dif then
                closest_distance = real_dif
                closest_enemy = enemy
            end
end

if closest_enemy ~= nil then
local closest_enemy_x, closest_enemy_y, closest_enemy_z = closest_enemy:GetHitboxPosition(0).x, closest_enemy:GetHitboxPosition(0).y, closest_enemy:GetHitboxPosition(0).z
            local real_distance = math.sqrt(math.pow(own_x - closest_enemy_x, 2) + math.pow(own_y - closest_enemy_y, 2) + math.pow(own_z - closest_enemy_z, 2))

            dynamicfov_new_fov = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
end
if (dynamicfov_new_fov > max_fov) then
            dynamicfov_new_fov = max_fov
        elseif dynamicfov_new_fov < min_fov then
            dynamicfov_new_fov = min_fov
        end

        dynamicfov_new_fov = math.floor(dynamicfov_new_fov + 0.5)

        if (dynamicfov_new_fov > closest_distance) then
            bool_in_fov = true
        else
            bool_in_fov = false
        end
    else
        dynamicfov_new_fov = min_fov
        bool_in_fov = false
    end

    if dynamicfov_new_fov ~= old_fov then
        gui.SetValue("rbot.aim.target.fov", dynamicfov_new_fov)
    end
end

callbacks.Register("Draw", "dynfov", dynamicfov_logic)

callbacks.Register("Draw", function()
sld_minfov:SetInvisible(not chk_dynfov:GetValue())
sld_maxfov:SetInvisible(not chk_dynfov:GetValue())
end)

callbacks.Register("CreateMove", function(cmd)
viewangles = cmd:GetViewAngles()
end)


------------------------------------------------Baim On Key


local function OnlybaimEnable()
    baimauto = guiGet("rbot.hitscan.points.asniper.scale")
    baimsniper = guiGet("rbot.hitscan.points.sniper.scale")
    baimpistol = guiGet("rbot.hitscan.points.pistol.scale")
    baimrevolver = guiGet("rbot.hitscan.points.hpistol.scale")
    baimsmg = guiGet("rbot.hitscan.points.smg.scale")
    baimrifle = guiGet("rbot.hitscan.points.rifle.scale")
    baimshotgun = guiGet("rbot.hitscan.points.shotgun.scale")
    baimscout = guiGet("rbot.hitscan.points.scout.scale")
    baimlmg = guiGet("rbot.hitscan.points.lmg.scale")

    gui.Command('rbot.hitscan.points.asniper.scale 0 0 0 0 5 0 0 0 ')
    gui.Command('rbot.hitscan.points.sniper.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.pistol.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.hpistol.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.smg.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.rifle.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.shotgun.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.scout.scale 0 0 0 0 5 0 0 0')
    gui.Command('rbot.hitscan.points.lmg.scale  0 0 0 0 5 0 0 0')
end

local function OnlybaimDisable()
    gui.Command('rbot.hitscan.points.asniper.scale ' ..baimauto)
    gui.Command('rbot.hitscan.points.sniper.scale ' ..baimsniper)
    gui.Command('rbot.hitscan.points.pistol.scale ' ..baimpistol)
    gui.Command('rbot.hitscan.points.hpistol.scale ' ..baimrevolver)
    gui.Command('rbot.hitscan.points.smg.scale ' ..baimsmg)
    gui.Command('rbot.hitscan.points.rifle.scale ' ..baimrifle)
    gui.Command('rbot.hitscan.points.shotgun.scale ' ..baimshotgun)
    gui.Command('rbot.hitscan.points.scout.scale ' ..baimscout)
    gui.Command('rbot.hitscan.points.lmg.scale ' ..baimlmg)
end


local function BaimOnKey()
    if KEYBOX_BAIM:GetValue() == 0 then return end
        if(input.IsButtonPressed(KEYBOX_BAIM:GetValue())) then
            baim = baim + 1;
        elseif(input.IsButtonDown) then
        -- do nothing
        end
        if(input.IsButtonReleased(KEYBOX_BAIM:GetValue())) then
                if (baim%2 == 0) then
    
                        OnlybaimEnable()
                        baim = 0;
                elseif (baim%2 == 1) then
                        OnlybaimDisable()
                        baim = 1;
                end
          
        end 
    
end
callbacks.Register( "Draw", "BaimOnKey", BaimOnKey )


-----------------------------------------------ViewModel FOV Changer
 

callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        local scoped = player_local:GetProp("m_bIsScoped")
 
          
        client.SetConVar("viewmodel_fov", SLIDER_VIEW:GetValue(), true)
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)	

-----------------------------------------------aspect ratio 
local aspect_ratio_table = {};
 
 
 
local function gcd(m, n) while m ~= 0 do m, n = math.fmod(n, m), m; end return n end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize(); local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height;
if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then aspectratio_value = 0; end
client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true); end

local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do local i2=i*0.01; i2 = 2 - i2; local divisor = gcd(screen_width*i2, screen_height); if screen_width*i2/divisor < 100 or i2 == 1 then aspect_ratio_table = screen_width*i2/divisor .. ":" .. screen_height/divisor; end end
local aspect_ratio = ASPECT_SLIDER:GetValue()*0.01; aspect_ratio = 2 - aspect_ratio; set_aspect_ratio(aspect_ratio); end
callbacks.Register('Draw', "does shit" ,on_aspect_ratio_changed)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

