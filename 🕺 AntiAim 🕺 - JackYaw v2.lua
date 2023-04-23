local fonte = draw.CreateFont("segoe ui", 26, 1000   )--("Tahoma",26, 1000)--("Microsoft Tai Le",30, 600)--("segoe ui", 30, 600) -- skeet fonte
local fonte = draw.CreateFont("Microsoft Tai Le",22, 2000)--("Verdana", 24, 700)
local fonte2 = draw.CreateFont("Marlett", 34, 100)
local fonte3 = draw.CreateFont("Yold Anglican", 24, 20)
local fonte4 = draw.CreateFont("Tahoma", 18, 20)
local fonte5 = draw.CreateFont("ActaSymbolsW95-Arrows", 18, 20)

local renderer = {}
local screenW, screenH = draw.GetScreenSize()
local guiSet = gui.SetValue
local guiGet = gui.GetValue
local baim = 1;
local switch_fbaim = false;
local weapons_table = {"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "smg", "shotgun", "sniper", "zeus", "shared"};


 ------------------------------------------------ Window 

local visuals_menu = gui.Reference("VISUALS", "OTHER", "Effects")
local visuals_custom_viewmodel_editor = gui.Checkbox( visuals_menu, "lua_custom_viewmodel_editor", "Custom Viewmodel Editor", 0 );
local xO = client.GetConVar("viewmodel_offset_x");  
local yO = client.GetConVar("viewmodel_offset_y");  
local zO = client.GetConVar("viewmodel_offset_z");   
local xS = gui.Slider(visuals_menu, "lua_x", "X", xO, -20, 20);   
local yS = gui.Slider(visuals_menu, "lua_y", "Y", yO, -100, 100);   
local zS = gui.Slider(visuals_menu, "lua_z", "Z", zO, -20, 20);  
local INDICATORS_COLOR = gui.ColorPicker( visuals_menu, 'indicators_color', 'Indicators Color',152, 204, 0, 255)
local r, g, b, a = INDICATORS_COLOR:GetValue()
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

        draw.SetFont(fonte)

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

local defaultratio = client.GetConVar("r_aspectratio")

callbacks.Register( "Draw", function()
    for i, Player in pairs(entities.FindByClass("CCSPlayer")) do
        Player:SetProp("m_bSpotted", 1)
    end
end)

local function UnlockInventory()
    panorama.RunScript([[ LoadoutAPI.IsLoadoutAllowed = () => { return true; }; ]]);
end

callbacks.Register( "Draw", UnlockInventory)
 
local function Visuals_Viewmodel() 

   if visuals_custom_viewmodel_editor:GetValue() then  
	client.SetConVar("viewmodel_offset_x", xS:GetValue(), true); 
	client.SetConVar("viewmodel_offset_y", yS:GetValue(), true); 
	client.SetConVar("viewmodel_offset_z", zS:GetValue(), true); 
else
	client.SetConVar("viewmodel_offset_x", x0, true); 
	client.SetConVar("viewmodel_offset_y", y0, true); 
	client.SetConVar("viewmodel_offset_z", z0, true); 

   end
   end
local function Visuals_Disable_Post_Processing()
       if visuals_disable_post_processing:GetValue() then  
           client.SetConVar( "mat_postprocess_enable", 0, true );
   else
       client.SetConVar( "mat_postprocess_enable", 1, true );
       end
   end
 local function unload_viewmodel()
	client.SetConVar("viewmodel_offset_x", x0, true); 
	client.SetConVar("viewmodel_offset_y", y0, true); 
	client.SetConVar("viewmodel_offset_z", z0, true); 
end

callbacks.Register("Draw", "Custom Viewmodel Editor", Visuals_Viewmodel)
callbacks.Register("Unload", unload_viewmodel)

local aspect_ratio_table = {};   
local aspect_ratio_check = gui.Checkbox(visuals_menu, "aspect_ratio_check", "Aspect Ratio Changer", false); 
local aspect_ratio_reference = gui.Slider(visuals_menu, "aspect_ratio_reference", "Force aspect ratio", 100, 1, 199)
local function gcd(m, n)    while m ~= 0 do   m, n = math.fmod(n, m), m; 
end
return n
end

local function set_aspect_ratio(aspect_ratio_multiplier)
local screen_width, screen_height = draw.GetScreenSize();   local aspectratio_value = (screen_width*aspect_ratio_multiplier)/screen_height; 
    if aspect_ratio_multiplier == 1 or not aspect_ratio_check:GetValue() then  aspectratio_value = 0;   end
        client.SetConVar( "r_aspectratio", tonumber(aspectratio_value), true);   end
local function on_aspect_ratio_changed()
local screen_width, screen_height = draw.GetScreenSize();
for i=1, 200 do   local i2=i*0.01;    i2 = 2 - i2;   local divisor = gcd(screen_width*i2, screen_height);    if screen_width*i2/divisor < 100 or i2 == 1 then   aspect_ratio_table[i] = screen_width*i2/divisor .. ":" .. screen_height/divisor;  end  end
local aspectonload = aspect_ratio_reference:GetValue()
local aspect_ratio = aspectonload*0.01;
aspect_ratio = 2 - aspect_ratio;
set_aspect_ratio(aspect_ratio);
end

local function unload_aspect_ratio()
	client.SetConVar( "r_aspectratio", defaultratio, true);
end
callbacks.Register('Draw', "Aspect Ratio" ,on_aspect_ratio_changed)
callbacks.Register("Unload", unload_aspect_ratio)

callbacks.Register("FireGameEvent", "Crosshair", function(event)
    if event:GetName()=="round_start" then
    	if entities.GetLocalPlayer()~=nil then
    		client.SetConVar("weapon_recoil_view_punch_extra", 0, true)
    		client.SetConVar("weapon_debug_spread_show",3,true)
    		client.SetConVar("view_punch_decay", 0, true)
    		client.SetConVar("viewmodel_recoil", 0, true)
    	end
    end
end)

client.AllowListener("round_start")

local guiSet = gui.SetValue
local guiGet = gui.GetValue
local togglekey = input.IsButtonDown
local ref = gui.Reference("RAGEBOT");
local tab = gui.Tab(ref,"Extra","Jackyaw")
local dmgsettings = gui.Groupbox(tab,"Jackyaw",16,16,280,300)
local togglekey = gui.Keybox(dmgsettings, "ChangeDmgKey", "Mindamage Key", 0)
local setDmg = gui.Combobox(dmgsettings, "mindmgmode", "Min Damage Mode", "Off", "Toggle", "Hold")
local awpdmg = gui.Groupbox(tab,"Awp Damage Settings",16,190,280,300)
local awpori = gui.Slider(awpdmg, "awpori", "Awp Original Min Damage", 1, 0, 130)
local awpDamage = gui.Slider(awpdmg, "awpDamage", "Awp Override Min Damage", 1, 0, 130)
local scoutdmg = gui.Groupbox(tab,"Scout Damage Settings",310,16,280,300)
local scoutori = gui.Slider(scoutdmg, "scoutori", "Scout Original Min Damage", 1, 0, 130)
local scoutDamage = gui.Slider(scoutdmg, "scoutDamage", "Scout Override Min Damage", 1, 0, 130)
local autodmg = gui.Groupbox(tab,"Auto Damage Settings",310,190,280,300)
local autoori = gui.Slider(autodmg, "autoori", "Auto Original Min Damage", 1, 0, 130)
local autoDamage = gui.Slider(autodmg, "autoDamage", "Auto Override Min Damage", 1, 0, 130)
local r8dmg = gui.Groupbox(tab,"R8 Damage Settings",16,350,280,300)
local r8ori = gui.Slider(r8dmg, "r8ori", "R8 Original Min Damage", 1, 0, 130)
local r8Damage = gui.Slider(r8dmg, "R8Damage", "R8 Override Min Damage", 1, 0, 130)


local Toggle =-1
local pressed = false

function changeMinDamage()
if (setDmg:GetValue()==1) then
        if input.IsButtonReleased(togglekey:GetValue()) then
            pressed=true;
Toggle = Toggle *-1

        elseif (pressed and input.IsButtonPressed(togglekey:GetValue())) then
            pressed=false;

            if Toggle == 1 then
            guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.hpistol.mindamage", r8Damage:GetValue())
            else
        guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
        guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
        guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
        guiSet("rbot.hitscan.accuracy.hpistol.mindamage", r8ori:GetValue())
            end
        end
    elseif (setDmg:GetValue()==2) then
        if input.IsButtonDown(togglekey:GetValue()) then
            guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoDamage:GetValue())
            guiSet("rbot.hitscan.accuracy.hpistol.mindamage", r8Damage:GetValue())
        else
        guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
        guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
        guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
        guiSet("rbot.hitscan.accuracy.hpistol.mindamage", r8ori:GetValue())
        end
    elseif (setDmg:GetValue()==0) then
        Toggle = -1
        guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
        guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
        guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
        guiSet("rbot.hitscan.accuracy.hpistol.mindamage", r8ori:GetValue())
    end
end

-- get weapon in hand 
local function weapon()
	if not entities.GetLocalPlayer() then return end
	entity = entities.GetLocalPlayer()
	weaponID = entity:GetWeaponID()
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
		return nil
	end
end

local fonte = draw.CreateFont( "tahoma negrito", 40 )

function Drawtext()
	if gui.GetValue("rbot.master")==false then return end
	if entities.GetLocalPlayer()==nil then return end
	if entities.GetLocalPlayer():IsAlive()==false then return end
	localp = entities.GetLocalPlayer()

	local r, g, b, a = INDICATORS_COLOR:GetValue()
	if not weapon()==nil then
		local dt_pcall = pcall(gui.GetValue, "rbot.hitscan.accuracy." .. weapon() .. ".doublefire")
	end
	draw.SetFont(fonte)
    local w, h = draw.GetScreenSize()
    w = 14
    h = (h/2)-14
    
   --
   	if gui.GetValue("rbot.antiaim.extra.fakecrouchkey")~=0 then
	    if input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
	        draw.indicator(255,255,255, 255, "DUCK")
	    end
	end
    if gui.GetValue("rbot.accuracy.movement.autopeekkey") ~= 0 then
        if input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.autopeekkey")) then
        	draw.indicator(255,255,255, 255, "PEEK")
        end
    end
    if weapon()~=nil then
        if gui.GetValue("rbot.hitscan.accuracy." .. weapon() .. ".doublefire") > 0 then   
            draw.indicator(255,255,255,255, "DT")
        end
    end
    local body_yaw = math.max(-60, math.min(60, math.round((entities.GetLocalPlayer():GetPropFloat( "m_flPoseParameter", "11") or 0)*120-60+0.5, 1)))
    if weapon()=="sniper" then
    	text = "DMG: " .. gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
    	draw.indicator(r,g,b,a,text)
    elseif weapon()=="scout" then
    	text = "DMG: " .. gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
        draw.indicator(r,g,b,a,text)
    elseif weapon()=="hpistol" then
    	text = "DMG: " .. gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
    	draw.indicator(r,g,b,a,text)
    elseif weapon()=="asniper" then
    	text = "DMG: " .. gui.GetValue("rbot.hitscan.accuracy.asniper.mindamage")
    	draw.indicator(r,g,b,a,text)
    end
    draw.indicator(r, g, b, a, 'FAKE:' .. ' ' ..  math.abs(body_yaw) .. '°')
    draw.indicator(r, g, b, a, 'FOV:' .. ' ' ..gui.GetValue( "rbot.aim.target.fov" ) .. '°')
end

callbacks.Register("Draw", "Drawtext", Drawtext);
callbacks.Register("Draw", "changeMinDamage", changeMinDamage);

local cb = gui.Checkbox( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.ghost.pulsating", "Pulsating Chams", 1)
local picker = gui.ColorPicker( gui.Reference( "Visuals", "Other", "Effects" ), "esp.chams.ghost.pulsating.clr", "Color Chams", 0, 0, 0, 0 )

callbacks.Register("Draw", function()
    if not cb:GetValue() then return end
    local r,g,b,o = picker:GetValue()
    local o = math.floor(math.sin((globals.RealTime()) * 6) * 68 + 112) - 40
    gui.SetValue("esp.chams.ghost.visible.clr", r, g, b, o)
end)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
