-- Semirage Things author: LilB4RT edited by Alicecsgo
local font = draw.CreateFont("segoe ui", 26, 1000   )--("Tahoma",26, 1000)--("Microsoft Tai Le",30, 600)--("segoe ui", 30, 600) -- skeet font
local Font = draw.CreateFont("Microsoft Tai Le",22, 2000)--("Verdana", 24, 700)
local Font2 = draw.CreateFont("Marlett", 34, 100)
local Font3 = draw.CreateFont("Yold Anglican", 24, 20)
local Font4 = draw.CreateFont("Tahoma", 18, 20)
local Font5 = draw.CreateFont("ActaSymbolsW95-Arrows", 18, 20)
local Font6 = draw.CreateFont('Microsoft Tai Le',14, 2000)
local xhair_font = draw.CreateFont("Microsoft Tai Le",14, 2000) 
local renderer = {}
local screenW, screenH = draw.GetScreenSize()
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local baim = 1;
local switch_fbaim = false;
local weapons_table = {"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "smg", "shotgun", "sniper", "zeus", "shared"};
local watermark_mouse_x, watermark_mouse_y, watermark_x, watermark_y, watermark_dx, watermark_dy, watermark_w = 0, 0, 1500, 10, 0, 0, 270;
local watermark_should_drag = false
local watermark_font = draw.CreateFont("verdana", 12)
------------------------------------------------ Window 
--local Window = gui.Window( "semirageWindow", "Semirage Helper by -_UnknownPerson_-#6472", 150, 150, 530, 700  )
--Window:SetOpenKey( 45 )

local ref = gui.Reference("RAGEBOT");
local tab = gui.Tab(ref,"Extra","Semirage's General")
local tab2 = gui.Tab( ref, "Extra2", "Semirage's Visuals" )

--local TAB=gui.Tab(gui.Reference("Misc"), "semirage", "Extra")
local GROUPBOX_MAIN=gui.Groupbox(tab, "KeyBinds", 10, 10, 300)

local GROUPBOX_AIMBOT=gui.Groupbox(tab, "Rage Things",320, 10, 300)


local GROUPBOX_IND=gui.Groupbox(tab2, "Indicators", 10, 10, 300)
local GROUPBOX_MISC=gui.Groupbox(tab2, "Visuals Things",320, 10, 300)--320, 10, 200
-----------------------------------------------------------Menu Items---------------------------------------------------------------

local KEYBOX_SWITCHBOT = gui.Keybox( GROUPBOX_MAIN, "switchBot", "Switch L/R", 0 )
KEYBOX_SWITCHBOT:SetDescription("Switch Legit and Rage")

local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "Inverter", 0)
KEYBOX_INVERTER:SetDescription("Switch the side of anti-aim")

local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "AutoWall", 0)
KEYBOX_AWSWITCH:SetDescription("Toggle Awall")

local KEYBOX_BAIM=gui.Keybox(GROUPBOX_MAIN, "baimkey", "Baim On Key", 0)
KEYBOX_BAIM:SetDescription("Toggle force baim")

local KEYBOX_RESOLVERSWITCH=gui.Keybox(GROUPBOX_MAIN, "resolverswitch", "Resolver", 0)
KEYBOX_RESOLVERSWITCH:SetDescription("Toggle the Resolver when the bind pressed (useless xd)")


local watermark_cb = gui.Checkbox(GROUPBOX_MISC,"watermark_cb", "Watermark", true);
local CHECKBOX_ALL = gui.Checkbox(GROUPBOX_IND, "IndicatorsALL", "Indicators", 0)
local INDICATORS_COLOR = gui.ColorPicker( GROUPBOX_IND, 'indicators_color', 'Indicators Color',152, 204, 0, 255)
local indicatorcenterr = gui.Multibox( GROUPBOX_IND, 'Indicators' )
local indcpeek = gui.Checkbox( indicatorcenterr, 'center_indcpeek', 'PEEK', false )
local indcduck = gui.Checkbox( indicatorcenterr, 'center_indcduck', 'DUCK', false )
local indcdt = gui.Checkbox( indicatorcenterr, 'center_indcdt', 'DT', false )
local indcawtl = gui.Checkbox( indicatorcenterr, 'center_indcawtl', 'AWALL', false )
local indcbaim = gui.Checkbox( indicatorcenterr, 'center_indcbaim','BAIM', false )
local indcautofire = gui.Checkbox( indicatorcenterr, 'center_indcautofire','TM', false )
local indcresolver = gui.Checkbox( indicatorcenterr, 'center_indcresolver','RESOLVER', false )
local indcfake = gui.Checkbox( indicatorcenterr, 'center_indcfake','FAKE', false )
local indcfov = gui.Checkbox( indicatorcenterr, 'center_indcfov','FOV', false )
local indcdmg = gui.Checkbox( indicatorcenterr, 'center_indcdmg','DMG', false )
local indcslow = gui.Checkbox( indicatorcenterr, 'center_indcragelegit','SLOW', false )
local indcping = gui.Checkbox( indicatorcenterr, 'center_indcragelegit','PING', false )
local indcragelegit = gui.Checkbox( indicatorcenterr, 'center_indcragelegit','RAGE/LEGIT', false )
local CROSSHAIR_INDICATORS = gui.Multibox( GROUPBOX_IND, 'Crosshair indicators' )
local ARROWTYPE = gui.Combobox( GROUPBOX_IND, "arrowtype", "Arrow Type", "1", "2", "3", "4" , "AW")

--crosshair indicators menu
local fov_crossx = gui.Checkbox( CROSSHAIR_INDICATORS, 'crosshair_fov', 'FOV', false )
local awall_crossx = gui.Checkbox( CROSSHAIR_INDICATORS, 'crosshair_awall', 'AWALL', false )
local baim_crossx = gui.Checkbox( CROSSHAIR_INDICATORS, 'crosshair_baim', 'BAIM', false )
local dmg_crossx = gui.Checkbox( CROSSHAIR_INDICATORS, 'crosshair_dmg', 'DAMAGE', false )
local duck_crossx = gui.Checkbox( CROSSHAIR_INDICATORS, 'crosshair_duck','DUCK', false )
--

local ArrowX = gui.Slider(GROUPBOX_IND, "ArrowX", "Arrow X Pos", 15, 0, screenW)





-----------------------------------------------------------misc Things Menu---------------------------------------------------------------

local sniper_crosshair = gui.Checkbox(GROUPBOX_MISC, "sniper_crosshair", "Sniper Crosshair", false)

local EngineRadarchk = gui.Checkbox( GROUPBOX_MISC, "engineradar", "Engine Radar", false )
local FakeDuckFixchk = gui.Checkbox( GROUPBOX_MISC, "fakeduckfix", "Disable AA on Duck", false )

local aspect_ratio_check = gui.Checkbox(GROUPBOX_MISC, "aspect_ratio_check", "Aspect Ratio Changer", false);
local ASPECT_SLIDER = gui.Slider( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", 100, 1, 199)--gui.Combobox( GROUPBOX_MISC, "aspectratio", "Aspect Ratio", "OFF", "1.0", "1.5", "2.0" )

local SLIDER_VIEWX = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewX", "Viewmodel Offset X", 1, -40, 40 )
local SLIDER_VIEWY = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewY", "Viewmodel Offset Y", 1, -40, 40 )
local SLIDER_VIEWZ = gui.Slider( GROUPBOX_MISC, "lua_fov_slider_viewZ", "Viewmodel Offset Z", -1, -40, 40 ) 


-----------------------------------------------------------Aimbot things menu ---------------------------------------------------------------

local chk_dynfov = gui.Checkbox(GROUPBOX_AIMBOT, "chk_dynfov", "Dynamic FOV", false)
local sld_minfov = gui.Slider(GROUPBOX_AIMBOT, "sld_minfov", "Minimum Dynamic FOV", 5, 0, 30)
local sld_maxfov = gui.Slider(GROUPBOX_AIMBOT, "sld_maxfov", "Maximum Dynamic FOV", 25, 0, 30)
local iunlock = gui.Checkbox(GROUPBOX_AIMBOT, "iunlock", "Inventory unlock", false)
local autodisconnect = gui.Checkbox(GROUPBOX_AIMBOT, "autodisconnect", "Auto Disconnect", false)
local changeKey = gui.Keybox( GROUPBOX_AIMBOT, "ChangeDmgKey", "Damage Override", 0);
local newDamage = gui.Slider( GROUPBOX_AIMBOT, "NewDamage", "Min damage", 100, 1, 199)

-----------------------------------------------------------renderer functions-------------------------------------------------------------------------
local function drag_watermark()
	-- creddits to ruppert for the drag feature
    if input.IsButtonDown(1) then
        watermark_mouse_x, watermark_mouse_y = input.GetMousePos();
        if watermark_should_drag then
            watermark_x = watermark_mouse_x - watermark_dx;
            watermark_y = watermark_mouse_y - watermark_dy;
		end
        if watermark_mouse_x >= watermark_x and watermark_mouse_x <= watermark_x + watermark_w and watermark_mouse_y >= watermark_y and watermark_mouse_y <= watermark_y + 40 then
            watermark_should_drag = true;
            watermark_dx = watermark_mouse_x - watermark_x;
            watermark_dy = watermark_mouse_y - watermark_y;
		end
		else
        watermark_should_drag = false;
	end
end

local function _color(r, g, b, a)
    local r = math.min(255, math.max(0, r))
    local g = math.min(255, math.max(0, g or r))
    local b = math.min(255, math.max(0, b or g or r))
    local a = math.min(255, math.max(0, a or 255))
    return r, g, b, a
end
local gradient_texture_a =
draw.CreateTexture(
    common.RasterizeSVG(
        [[<defs><linearGradient id="a" x1="100%" y1="0%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#a)" /></svg>]]
    )
)

local gradient_texture_b =
draw.CreateTexture(
    common.RasterizeSVG(
        [[<defs><linearGradient id="c" x1="0%" y1="100%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#c)" /></svg>]]
    )
)

function draw.gradient(xa, ya, xb, yb, ca, cb, ltr)
    local r, g, b, a = _color(ca[1], ca[2], ca[3], ca[4])
    local r2, g2, b2, a2 = _color(cb[1], cb[2], cb[3], cb[4])
    
    local texture = ltr and gradient_texture_a or gradient_texture_b
    
    local t = (a ~= 255 or a2 ~= 255)
    draw.Color(r, g, b, a)
    draw.SetTexture(t and texture or nil)
    draw.FilledRect(xa, ya, xb, yb)
    
    draw.Color(r2, g2, b2, a2)
    local set_texture = not t and draw.SetTexture(texture)
    draw.FilledRect(xb, yb, xa, ya)
    draw.SetTexture(nil)
end

function math.round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end
local function _round(number, precision)
    local mult = 10 ^ (precision or 0)
    return math.floor(number * mult + 0.5) / mult
end

renderer.text = function(x,y,string, col, font)
    
    draw.Color( col[1], col[2], col[3], col[4] )
    draw.SetFont( font )
    draw.Text( x, y, string )
    
end

renderer.outline_text = function(x,y, string, col, font) 
    
    draw.SetFont( font )
    draw.Color(0,0,0,255)
    draw.Text(x + 1, y + 1,string) 
    draw.Text(x - 1, y - 1,string) 
    draw.Text(x + 1, y - 1,string) 
    draw.Text(x - 1, y + 1,string) 
    
    draw.Color(col[1], col[2], col[3], col[4])
    draw.Text(x, y,string) 
    
    
end


renderer.rectangle = function(x, y, w, h, clr, fill, radius)
    local alpha = 255
    if clr[4] then
        alpha = clr[4]
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    if fill then
        draw.FilledRect(x, y, x + w, y + h)
        else
        draw.OutlinedRect(x, y, x + w, y + h)
    end
    if fill == "s" then
        draw.ShadowRect(x, y, x + w, y + h, radius)
    end
end

renderer.gradient = function(x, y, w, h, clr, clr1, vertical)
    local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
    local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]
    
    if a and a1 == nil then
        a, a1 = 255, 255
    end
    
    if vertical then
        if clr[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    renderer.rectangle(x, y + w - i, w, 1, {r1, g1, b1, i / w * a1}, true)
                end
                else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, h do
                renderer.rectangle(x, y + i, w, 1, {r, g, b, i / h * a}, true)
            end
        end
        else
        if clr[4] ~= 0 then
            if a1 and a ~= 255 then
                for i = 0, w do
                    renderer.rectangle(x + w - i, y, 1, h, {r1, g1, b1, i / w * a1}, true)
                end
                else
                renderer.rectangle(x, y, w, h, {r1, g1, b1, a1}, true)
            end
        end
        if a2 ~= 0 then
            for i = 0, w do
                renderer.rectangle(x + i, y, 1, h, {r, g, b, i / w * a}, true)
            end
        end
    end
end
renderer.rect = function(x, y, w, h, col)
    draw.Color(col[1], col[2], col[3], col[4]);
    draw.FilledRect(x, y, x + w, y + h);
end

--DON't TOUCH BELOW OR UR INDICATORS WILL BREAK
local indicator = {{}}
function draw.indicator(r,g,b,a, string)
    local new = {}
    local add = indicator[1]
    local x, y = draw.GetScreenSize()
    
    new.y = y / 1.4105 - #add * 35
    
    local i = #add + 1
    add[i] = {}
    
    setmetatable(add[i], new)
    new.__index = new
    new.r, new.g, new.b, new.a = _color(r,g,b,a )
    new.string = string or ""
    
    return new.y
end

callbacks.Register(
    "Draw",
    function()
        local temp = {}
        local add = indicator[1]
        local _x, y = draw.GetScreenSize()
        local x = 12
        local c = 0
        
        draw.SetFont(font)
        
        add.y = _round(y / 1.4105 - #temp * 35)
        
        for i = 1, #add do
            temp[#temp + 1] = add[i]
        end
        
        for i = 1, #temp do
            local _i = temp[i]
            
            local w, h = draw.GetTextSize(_i.string)
            local xa = _round(x + w * 0.45)
            local ya = add.y - 6
            local xb = add.y + 25
            --                                                               255 = _i.a (useless info xd)
            draw.gradient(x, ya, xa, xb, {c, c, c, c}, {c, c, c, 255 * 0.3}, true)
            draw.gradient(xa, ya, x + w * 0.9, xb, {c, c, c, 255 * 0.3}, {c, c, c, c}, true)
            
            draw.Color (_i.r, _i.g, _i.b, 255)
            draw.TextShadow(x + 1, add.y + 1.5, _i.string)
            
            add.y = add.y - 35
        end
        
        indicator[1] = {}
    end
)
--DON'T TOUCH ABOVE OR UR INDICATOR WILL BREAK
-----------------------------------------------------------------------------------------------------------------------------------------------

local function menu_weapon(var)
    local w = var:match("%a+"):lower()
    local w = w:find("heavy") and "hpistol" or w:find("auto") and "asniper" or w:find("submachine") and "smg" or w:find("light") and "lmg" or w
    return w
end

local function weapon()
	if not entities.GetLocalPlayer() then return end
	local entity = entities.GetLocalPlayer()
	local weaponID = entity:GetWeaponID()
	if weaponID==2 or weaponID==3 or weaponID==4 or weaponID==30 or weaponID==32 or weaponID==36 or weaponID==61 or weaponID==63 then
		return "pistol"
		elseif weaponID==9 then
		return "sniper"
		elseif weaponID==40 then
		return "scout"
		elseif weaponID==1 or weaponID==64 then
		return "hpistol"
		elseif weaponID==17 or weaponID== 19 or weaponID== 23 or weaponID== 24 or weaponID== 26 or weaponID== 33 or weaponID== 34 then
		return "smg"
		elseif weaponID==7 or weaponID==8 or weaponID== 10 or weaponID== 13 or weaponID== 16 or weaponID== 39 or weaponID== 61 then
		return "rifle"
		elseif weaponID== 25 or weaponID== 27 or weaponID== 29 or weaponID== 35 then
		return "shotgun"
		elseif weaponID == 38 or weaponID==11 then
		return "asniper"
		elseif weaponID == 28 or weaponID== 14 then
		return "lmg"
		else
		return "shared";
    end
end
local ragebot_accuracy_weapon = gui.Reference("Ragebot", "Accuracy", "Weapon")
callbacks.Register("Draw", "indicatorsMala", function()
    local r, g, b, a = INDICATORS_COLOR:GetValue()
    
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
    if CHECKBOX_ALL:GetValue() then
        if (gui.GetValue( 'rbot.master' )) then
            
            if indcpeek:GetValue() then
                if gui.GetValue('rbot.accuracy.movement.autopeekkey') ~= 0 then
                    if input.IsButtonDown(gui.GetValue('rbot.accuracy.movement.autopeekkey')) then
                        draw.indicator(r, g, b, a, 'PEEK')
                    end
                end
            end
            
            if indcping:GetValue() then
                if gui.GetValue("misc.fakelatency.enable") and (gui.GetValue("misc.fakelatency.amount")) then
                    draw.indicator(r, g, b, a, 'PING' .. ' ' ..gui.GetValue( 'misc.fakelatency.amount' ))
                end
            end
            
            if indcslow:GetValue() then
                if gui.GetValue('rbot.accuracy.movement.slowkey') ~= 0 then
                    if input.IsButtonDown(gui.GetValue('rbot.accuracy.movement.slowkey')) then
                        draw.indicator(r, g, b, a, 'SLOW')
                    end
                end
            end
            
            if indcduck:GetValue() then
                if gui.GetValue('rbot.antiaim.extra.fakecrouchkey') ~= 0 then
                    if input.IsButtonDown(gui.GetValue('rbot.antiaim.extra.fakecrouchkey')) then
                        draw.indicator(r, g, b, a, 'DUCK')
                    end
                end
            end
            
            if indcdt:GetValue() then
                local wid = entities.GetLocalPlayer():GetWeaponID()
                local weapon = menu_weapon(ragebot_accuracy_weapon:GetValue())
                local dt_pcall = pcall(gui.GetValue, 'rbot.hitscan.accuracy.' .. weapon .. '.doublefire')
                
                if dt_pcall and gui.GetValue('rbot.hitscan.accuracy.' .. weapon .. '.doublefire') > 0 then
                    
                    draw.indicator(r, g, b, a, 'DT')
                end
            end
            
            if indcawtl:GetValue() then
                if weapon() == nil then
                    else
                    if (guiGet("rbot.hitscan.mode."..weapon()..".autowall")) then
                        draw.indicator( r, g, b, a, 'AW')
                    end
                end
            end
            
            if indcbaim:GetValue() then
                if switch_fbaim then 
                    draw.indicator(r, g, b, a, 'BAIM') -- yellow/orange 255, 200, 0, 255
                end
            end
            
            if indcautofire:GetValue() then
                if gui.GetValue( 'rbot.aim.enable' ) then
                    draw.indicator(r, g, b, a, 'TM')
                end
            end
            
            if indcresolver:GetValue() then
                draw.indicator(r,g,b,a, gui.GetValue( 'rbot.accuracy.posadj.resolver' ) and 'R:ON' or 'R:OFF')
            end
            
            if indcfake:GetValue() then
                local body_yaw = math.max(-60, math.min(60, math.round((entities.GetLocalPlayer():GetPropFloat( 'm_flPoseParameter', '11') or 0)*120-60+0.5, 1)))
                draw.indicator(r, g, b, a, 'FAKE:' .. ' ' ..  math.abs(body_yaw) .. '°')
            end
            
            if indcfov:GetValue() then
                draw.indicator(r, g, b, a, 'FOV:' .. ' ' ..gui.GetValue( 'rbot.aim.target.fov' ) .. '°')
            end
            
            if indcdmg:GetValue() then
                if weapon() == nil then
                    else
                    dmgtext = guiGet('rbot.hitscan.accuracy.'..weapon()..'.mindamage')
                    if dmgtext >= 101 then 
                        dmgtext = 'HP+' .. dmgtext-100 
                    end
                    draw.indicator(r, g, b, a,  (dmgtext))
                end
            end
            
            
            if indcragelegit:GetValue() then
                local lbot = gui.GetValue('lbot.master')
                local rbot = gui.GetValue('rbot.master')
                
                local text = lbot and 'LEGIT' or rbot and 'RAGE'
                draw.indicator(r, g, b, a, text)
            end
            
        end 
    end
end)

local function underxhair()
    
    ballchunks = 1
    
    if dmg_crossx:GetValue() then
        if weapon() == nil then
            else
            dmgtext = guiGet("rbot.hitscan.accuracy."..weapon()..".mindamage")
            if dmgtext >= 101 then 
                dmgtext = "HP+" .. dmgtext-100 
            end
            renderer.text(screenW / 2 + 2, screenH / 2 + 25 +(14*ballchunks) ,   (dmgtext), {255,255,255, 255}, xhair_font)
            ballchunks = ballchunks + 1
        end
    end
    if fov_crossx:GetValue() then
        renderer.text(screenW / 2 + 2, screenH / 2 + 25 +(14*ballchunks) , 'FOV: ' .. gui.GetValue( "rbot.aim.target.fov" ) .. '°', {255,255,255, 255}, xhair_font)
        ballchunks = ballchunks + 1
    end
    
    if awtggl and awall_crossx:GetValue() then
        renderer.text(screenW / 2 + 2, screenH / 2 + 25 +(14*ballchunks) , 'AUTOWALL', {255,255,255, 255}, xhair_font)
        ballchunks = ballchunks + 1
    end
    
    if switch_fbaim and baim_crossx:GetValue() then 
        renderer.text(screenW / 2 + 2, screenH / 2 + 25 +(14*ballchunks) , 'BAIM', {255,255,255, 255}, xhair_font)
        ballchunks = ballchunks + 1
    end
    
    if duck_crossx:GetValue()  then 
        if gui.GetValue('rbot.antiaim.extra.fakecrouchkey') ~= 0 then
            if input.IsButtonDown(gui.GetValue('rbot.antiaim.extra.fakecrouchkey')) then
                renderer.text(screenW / 2 + 2, screenH / 2 + 25 +(14*ballchunks) , 'DUCK', {255,255,255, 255}, xhair_font)
                ballchunks = ballchunks + 1
            end
            
            
        end
    end
end
callbacks.Register("Draw", "semiragehelper", underxhair)

callbacks.Register("Draw", function()
    ArrowX:SetInvisible(not CHECKBOX_ALL:GetValue())
end)
-------------------------------------------------AA inverter Arrow



local function arrow()
    
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
    
    if not gui.GetValue( "rbot.master" ) then return end
    
    draw.SetFont( Font3 )
    
    
    
    if CHECKBOX_ALL:GetValue() then
        if invrtr then
            
            if ARROWTYPE:GetValue() == 0 then
                
                renderer.outline_text(screenW / 2 + 50 + ArrowX:GetValue(), screenH / 2 - 10, "-", {255,255,255,255}, Font3)
                
                
                elseif ARROWTYPE:GetValue() == 1 then
                
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(screenW / 2 + 50 + ArrowX:GetValue(), screenH / 2 - 10, "⮚")
                
                elseif ARROWTYPE:GetValue() == 2 then
                
                draw.SetFont( Font4 )
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(screenW / 2 + 50 + ArrowX:GetValue(),screenH / 2 - 7, "›")
                
                elseif ARROWTYPE:GetValue() == 3 then
                
                draw.Color(255, 255, 255, 255)
                draw.Triangle(screenW / 2 + 25 + ArrowX:GetValue(), screenH / 2 - 7 , screenW / 2 + 37 + ArrowX:GetValue(), screenH / 2, screenW / 2 + 25 + ArrowX:GetValue(), screenH / 2 + 7)
                
                elseif ARROWTYPE:GetValue() == 4 then
                draw.Color(255, 13, 0, 255)
                draw.SetFont(Font6) draw.TextShadow(screenW / 2 - 50 + ArrowX:GetValue(),screenH / 2 - 7,"AIM            ")
                local r, g, b, a = INDICATORS_COLOR:GetValue()
                draw.Color(255, 255, 255, 255)
                draw.SetFont(Font6) draw.TextShadow(screenW / 2 - 50 + ArrowX:GetValue(),screenH / 2 - 7,"        WARE")
                
            end
            
            
            else
            
            if ARROWTYPE:GetValue() == 0 then
                
                renderer.outline_text(screenW / 2 - 65 - ArrowX:GetValue(), screenH / 2 - 10, "-", {255,255,255,255}, Font3)
                
                
                elseif ARROWTYPE:GetValue() == 1 then
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(screenW / 2 - 65 - ArrowX:GetValue(), screenH / 2 - 10, "⮘")
                elseif ARROWTYPE:GetValue() == 2 then
                draw.SetFont( Font4 )
                draw.Color(255, 255, 255, 255)
                draw.TextShadow(screenW / 2 - 60 - ArrowX:GetValue(),screenH / 2 - 7, "‹")
                elseif ARROWTYPE:GetValue() == 3 then
                
                draw.Color(255, 255, 255, 255)
                draw.Triangle(screenW / 2 - 25 - ArrowX:GetValue(), screenH / 2 + 7, screenW / 2 - 25 - ArrowX:GetValue(), screenH / 2 - 7,  screenW / 2 - 37 - ArrowX:GetValue(), screenH / 2)
                
                elseif ARROWTYPE:GetValue() == 4 then
                draw.Color(255, 13, 0, 255)
                draw.SetFont(Font6) draw.TextShadow(screenW / 2 - 50 + ArrowX:GetValue(),screenH / 2 - 7,"        WARE")
                local r, g, b, a = INDICATORS_COLOR:GetValue()
                draw.Color(255, 255, 255, 255)
                draw.SetFont(Font6) draw.TextShadow(screenW / 2 - 50 + ArrowX:GetValue(),screenH / 2 - 7,"AIM            ")
                
            end
        end
        
        
        
        
    end
end
callbacks.Register("Draw", "semiragehelper", arrow)
--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------Function---------------------------------------------------------------

-------------------------------------------------------- Toggle Awall
local weapons_table = {"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "smg", "shotgun", "sniper", "zeus", "shared"};
local function awswitch()
    
    
    
    if KEYBOX_AWSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AWSWITCH:GetValue()) then
            awtggl = not awtggl
        end
        
        --[[ if awtggl then
            for i, v in next, weapons_table do
            gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 1);
            end
            else
            for i, v in next, weapons_table do
            gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 0);
            end 
        end--]]
        
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

-------------------------------------------------------- AA inverter

local function finverter()
    
    gui.SetValue("rbot.antiaim.base", "0 Desync")
    gui.SetValue("rbot.antiaim.left", 0)
    gui.SetValue("rbot.antiaim.right", 0)
    gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
    if KEYBOX_INVERTER:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_INVERTER:GetValue()) then
            invrtr = not invrtr
        end
        
        if invrtr then
            
            gui.SetValue("rbot.antiaim.base.rotation", -58)
            gui.SetValue("rbot.antiaim.base.lby", 120)
            
            else
            
            gui.SetValue("rbot.antiaim.base.rotation", 58)
            gui.SetValue("rbot.antiaim.base.lby", -120)
            
        end
    end
end

callbacks.Register("Draw", "semiragehelper", finverter)

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


----------------------------------------------baim key lol

local function baim_key()
    
    if KEYBOX_BAIM:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_BAIM:GetValue()) then
            if not switch_fbaim then
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 1);
                end
                switch_fbaim = true;
                else
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 0);
                end
                switch_fbaim = false;
            end
        end
    end
end

callbacks.Register( 'Draw', baim_key )
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


--------------------------------------------Sniper Crosshair


local function spr_crs()
    if not entities.GetLocalPlayer() then return end
    -- local is_scoped = entities.GetLocalPlayer():GetPropBool("m_bIsScoped");
    local wpn =  entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    local is_scoped = entities.GetLocalPlayer():GetPropBool("m_bIsScoped")
    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
    
    
    if sniper_crosshair:GetValue() and not is_scoped then 
        
        client.SetConVar( "weapon_debug_spread_show", 3, true )
        
        else
        
        client.SetConVar( "weapon_debug_spread_show", 0, true )
        
    end
    
end

callbacks.Register( "Draw", "spr_crs", spr_crs )



-----------------------------------------------ViewModel FOV Changer


callbacks.Register( "Draw", function()
    if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
        local a = 0
        local player_local = entities.GetLocalPlayer();
        --  local scoped = player_local:GetProp("m_bIsScoped")
        
        client.SetConVar("viewmodel_offset_x", SLIDER_VIEWX:GetValue(), true);
        client.SetConVar("viewmodel_offset_y", SLIDER_VIEWY:GetValue(), true);
        client.SetConVar("viewmodel_offset_z", SLIDER_VIEWZ:GetValue() + a, true);
    end
end)	

-----------------------------------------------engine radar
local function engine_radar_draw()
    
    if EngineRadarchk:GetValue() then        
        
        for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
            
            Player:SetProp("m_bSpotted", 1);
            
        end
        
        else
        for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
            
            Player:SetProp("m_bSpotted", 0);
            
        end
        
    end
    
    
end

callbacks.Register("Draw", "engine_radar_draw", engine_radar_draw);

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


-----------------------------------------------fakeduck fix

local function fakeduckfix() 
    if not FakeDuckFixchk:GetValue() then return end
    if gui.GetValue( "rbot.antiaim.extra.fakecrouchkey" ) ~= 0 then
        if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
            
            gui.SetValue("rbot.antiaim.base.rotation", 0)
            gui.SetValue("rbot.antiaim.base", 0)
            gui.SetValue("rbot.antiaim.base.lby", 0)
        end
    end
end
callbacks.Register( "Draw", fakeduckfix )


callbacks.Register('Unload', function()
    client.SetConVar( "weapon_debug_spread_show", 0, true )
    client.SetConVar( 'r_aspectratio', 0, true )
    client.SetConVar( 'viewmodel_offset_x', 2, true )
    client.SetConVar( 'viewmodel_offset_y', 2, true )
    client.SetConVar( 'viewmodel_offset_z', -2, true )
    
end)


local frame_rate = 0/10
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1 / frame_rate))
end

callbacks.Register( "Draw", 'watermark', function()
	if watermark_cb:GetValue() ~= true then return end
	drag_watermark()
	draw.SetFont(watermark_font)
    local map_name = engine.GetMapName()
	local LocalPlayer=entities.GetLocalPlayer()
	local UserName=cheat.GetUserName()
	if LocalPlayer ~= nil then
		pr=entities.GetPlayerResources()
		delay = pr:GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex())
		else
		delay="None "
	end
	server=engine.GetServerIP()
	if server == nil then
		serverip="Menu"
		serverdelay="None "
		elseif server=="loopback" then
		serverip="Local"
		serverdelay="None "
		else
		serverip=server
		serverdelay=delay
	end
	local r, g, b, a = INDICATORS_COLOR:GetValue()
	local watermarktext = cheat.GetUserName() .. " | map: " .. map_name .. " |  ping: ".. delay .."ms | " ..serverip.." | "..os.date("%H"..":%M"..":%S")
	local watermark_text_size_x, watermark_text_size_y = draw.GetTextSize(watermarktext)
	
	draw.Color(0, 0, 0, 150)
	draw.FilledRect(watermark_x, watermark_y, watermark_x + watermark_text_size_x + 6, watermark_y + 26); -- gray background
	
	draw.Color(r, g, b, a)
	draw.FilledRect(watermark_x, watermark_y, watermark_x + watermark_text_size_x + 6, watermark_y + 2); -- top line
	
	draw.Color(r, g, b, a)
	draw.Text(watermark_x + 3, watermark_y + 10, watermarktext)
end)

--auto disconect
callbacks.Register("FireGameEvent", 'AutoDisconnect', function(event)
	if autodisconnect:GetValue() then
		if event:GetName() == "cs_win_panel_match" then
			client.Command("disconnect", true)
		end
	end
end)
client.AllowListener( "cs_win_panel_match" );

--inventory unlock
callbacks.Register("Draw", "inventoryunlock", function()
	if not iunlock:GetValue() then        	
		panorama.RunScript([[
			LoadoutAPI.IsLoadoutAllowed = () => {
			return false;
			};
		]])
		else
		panorama.RunScript([[
			LoadoutAPI.IsLoadoutAllowed = () => {
			return true;
			};
		]])
	end
end)

--min damage
local auto = guiGet("rbot.hitscan.accuracy.asniper.mindamage")
local sniper = guiGet("rbot.hitscan.accuracy.sniper.mindamage")
local pistol = guiGet("rbot.hitscan.accuracy.pistol.mindamage")
local revolver = guiGet("rbot.hitscan.accuracy.hpistol.mindamage")
local smg = guiGet("rbot.hitscan.accuracy.smg.mindamage")
local rifle = guiGet("rbot.hitscan.accuracy.rifle.mindamage")
local shotgun = guiGet("rbot.hitscan.accuracy.shotgun.mindamage")
local scout = guiGet("rbot.hitscan.accuracy.scout.mindamage")
local lmg = guiGet("rbot.hitscan.accuracy.lmg.mindamage")
local toggle = 1;
callbacks.Register("Draw", "changeDmgMain", function()
	if (changeKey:GetValue() == 0) then
		return -1;
	end
	if(input.IsButtonPressed(changeKey:GetValue())) then
		toggle = toggle + 1;
		changeDmgMain = not changeDmgMain
		return
		elseif(input.IsButtonDown) then
		-- do nothing
	end
	if(input.IsButtonReleased(changeKey:GetValue())) then
		changeDmgMain = true
		dmgindic = true
		if changeDmgMain then
			if (toggle%2 == 0) and changeDmgMain and dmgindic then
				auto = guiGet("rbot.hitscan.accuracy.asniper.mindamage")
				sniper = guiGet("rbot.hitscan.accuracy.sniper.mindamage")
				pistol = guiGet("rbot.hitscan.accuracy.pistol.mindamage")
				revolver = guiGet("rbot.hitscan.accuracy.hpistol.mindamage")
				smg = guiGet("rbot.hitscan.accuracy.smg.mindamage")
				rifle = guiGet("rbot.hitscan.accuracy.rifle.mindamage")
				shotgun = guiGet("rbot.hitscan.accuracy.shotgun.mindamage")
				scout = guiGet("rbot.hitscan.accuracy.scout.mindamage")
				lmg = guiGet("rbot.hitscan.accuracy.lmg.mindamage")
				
				guiSet("rbot.hitscan.accuracy.asniper.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.sniper.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.pistol.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.hpistol.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.smg.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.rifle.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.shotgun.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.scout.mindamage", math.floor(newDamage:GetValue()))
				guiSet("rbot.hitscan.accuracy.lmg.mindamage", math.floor(newDamage:GetValue()))
				elseif (toggle%2 == 1) then
				guiSet("rbot.hitscan.accuracy.asniper.mindamage", auto)
				guiSet("rbot.hitscan.accuracy.sniper.mindamage", sniper)
				guiSet("rbot.hitscan.accuracy.pistol.mindamage", pistol)
				guiSet("rbot.hitscan.accuracy.hpistol.mindamage", revolver)
				guiSet("rbot.hitscan.accuracy.smg.mindamage", smg)
				guiSet("rbot.hitscan.accuracy.rifle.mindamage", rifle)
				guiSet("rbot.hitscan.accuracy.shotgun.mindamage", shotgun)
				guiSet("rbot.hitscan.accuracy.scout.mindamage", scout)
				guiSet("rbot.hitscan.accuracy.lmg.mindamage", lmg)
				toggle = 1;
			end
		end
	end
end)