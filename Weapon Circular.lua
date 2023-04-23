--Compile to aimware
--Mouse drag From An 2926669800
--By Qi
--
--gui
local X, Y = draw.GetScreenSize()
local Circular_WeaponUI_Reference = gui.Reference("Visuals", "Other", "Extra")
local Circular_WeaponUI_Enable = gui.Checkbox(Circular_WeaponUI_Reference, "ui.weaponcircular.enable", "Weapon Circular Enable", 0)
local Circular_WeaponUI_Clr = gui.ColorPicker(Circular_WeaponUI_Enable,"clr", "clr", 4, 4, 4, 150)
local Circular_WeaponUI_Clr2 = gui.ColorPicker(Circular_WeaponUI_Enable,"clr2", "clr2", 255, 255, 255, 255)
local Circular_WeaponUI_Clr3 = gui.ColorPicker(Circular_WeaponUI_Enable,"clr3", "clrtext", 255, 255, 255, 255)
local Circular_WeaponUI_Clr4 = gui.ColorPicker(Circular_WeaponUI_Enable,"clr4", "clr4", 255, 255, 255, 255)
local Circular_WeaponUI_sX = gui.Slider(Circular_WeaponUI_Reference, "ui.weaponcircular.x", "X", 450, 0, X)
local Circular_WeaponUI_sY = gui.Slider(Circular_WeaponUI_Reference, "ui.weaponcircularr.y", "Y", 400, 0, Y)
Circular_WeaponUI_sX:SetInvisible(true)
Circular_WeaponUI_sY:SetInvisible(true)

--font and var
local fontText = draw.CreateFont("Verdana", 12, 700)
local fontWeapon = draw.CreateFont("weaponIcons", 35)
local font2Weapon = draw.CreateFont("weaponIcons", 80)
local font3Weapon = draw.CreateFont("weaponIcons", 60)
local font4Weapon = draw.CreateFont("weaponIcons", 50)
local tX, tY, offsetX, offsetY, _drag
local weaponfont = {
    ["ak47"] = "A", ["aug"] = "B", ["awp"] = "C", ["axe"] = "D", ["bayonet"] = "E", ["bizon"] = "F", ["breachcharge"] = "G", 
    ["breachcharge_projectile"] = "H", ["c4"] = "I",["cz75a"] = "J", ["deagle"] = "K", ["decoy"] = "L", ["elite"] = "M", 
    ["famas"] = "N", ["firebomb"] = "O", ["fists"] = "P", ["fiveseven"] = "Q", ["flashbang"] = "R",
    ["frag_grenade"] = "S", ["g3sg1"] = "T", ["galilar"] = "U", ["glock"] = "V", ["hammer"] = "W", ["hegrenade"] = "X", 
    ["hkp2000"] = "Y", ["incgrenade"] = "Z", ["inferno"] = "a",["knife"] = "b", ["knife_bowie"] = "c", ["knife_butterfly"] = "d", 
    ["knife_falchion"] = "e", ["knife_flip"] = "f", ["knife_gut"] = "g", ["knife_gypsy_jackknife"] = "h",
    ["knife_karambit"] = "i", ["knife_m9_bayonet"] = "j", ["knife_push"] = "k", ["knife_stiletto"] = "l", ["knife_survival_bowie"] = "m", 
    ["knife_t"] = "n", ["knife_tactical"] = "o",["knife_ursus"] = "p", ["knife_widowmaker"] = "q", ["knifegg"] = "r", ["m4a1"] = "s", 
    ["m4a1_silencer"] = "t", ["m4a1_silencer_off"] = "u", ["m249"] = "v", ["mac10"] = "w",["mag7"] = "x", ["molotov"] = "y", 
    ["mp5sd"] = "z", ["mp7"] = "0", ["mp9"] = "1", ["negev"] = "2", ["nova"] = "3", ["p90"] = "4", ["p250"] = "5", ["planted_c4_survival"] = "6",
    ["prop_exploding_barrel"] = "7", ["radarjammer"] = "8", ["revolver"] = "9", ["sawedoff"] = "!", ["scar20"] = "\"", ["sg553"] = "#", 
    ["smokegrenade"] = "$", ["snowball"] = "%",["spanner"] = "&", ["ssg08"] = "\'", ["tagrenade"] = "(", ["taser"] = ")", 
    ["tec9"] = "*", ["ump45"] = "+", ["usp_silencer"] = ",", ["usp_silencer_off"] = "-", ["xm1014"] = ".",
}
local MENU = gui.Reference("MENU")
--function

--Mouse drag
local function is_inside(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end
local function drag_menu(x, y, w, h)
    if not MENU:IsActive() then
        return tX, tY
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not _drag then
            local w, h = x + w, y + h
            if is_inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                _drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            Circular_WeaponUI_sX:SetValue(tX) 
            Circular_WeaponUI_sY:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--alpha
local function alpha_stop(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end


--Circular
local function Circular(x, y, start, radius, number, thickness)

    if thickness > radius then
        thickness = radius
    end

    for steps = start, number + start - 1, 1 do   

        local sin_cur = math.sin(math.rad(steps))
        local sin_old = math.sin(math.rad(steps - 1))
        local cos_cur = math.cos(math.rad(steps))
        local cos_old = math.cos(math.rad(steps - 1))
        local cur_point = nil
        local old_point = nil
        local cur_point = {x + sin_cur * radius, y + cos_cur * radius}    
        local old_point = {x + sin_old * radius, y + cos_old * radius}
        local cur_point2 = nil
        local old_point2 = nil
        local cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)}    
        local old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)}

        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])    
    
    end

end
local function CircularAmmo(x, y, start, radius, number, thickness, thi)

    if thickness > radius then
        thickness = radius
    end

    for steps = start, number + start - 1, thi do   

        local sin_cur = math.sin(math.rad(steps))
        local sin_old = math.sin(math.rad(steps - 2.5))
        local cos_cur = math.cos(math.rad(steps))
        local cos_old = math.cos(math.rad(steps - 2.5))
        local cur_point = nil
        local old_point = nil
        local cur_point = {x + sin_cur * radius, y + cos_cur * radius}    
        local old_point = {x + sin_old * radius, y + cos_old * radius}
        local cur_point2 = nil
        local old_point2 = nil
        local cur_point2 = {x + sin_cur * (radius - thickness), y + cos_cur * (radius - thickness)}    
        local old_point2 = {x + sin_old * (radius - thickness), y + cos_old * (radius - thickness)}

        draw.Triangle(cur_point[1], cur_point[2], old_point[1], old_point[2], old_point2[1], old_point2[2])
        draw.Triangle(cur_point2[1], cur_point2[2], old_point2[1], old_point2[2], cur_point[1], cur_point[2])    
    
    end

end
--Let drag position save
local function PositionSave()
    if tX ~= Circular_WeaponUI_sX:GetValue() or tY ~= Circular_WeaponUI_sY:GetValue() then
        tX, tY = Circular_WeaponUI_sX:GetValue(), Circular_WeaponUI_sY:GetValue()
    end
end

--On draw

--draw Circular and text  I have to do the drawing over and over again to smooth it out
local function drawCircular()

    local lp = entities.GetLocalPlayer()
    if lp ~= nil then
        if lp:IsAlive() == true then

            local x, y = drag_menu(tX, tY, 100, 100)
            local x, y = x + 50, y + 50
            local r, g, b, a = 150, 150, 150, 255
            local r2, g2, b2, a2 = Circular_WeaponUI_Clr:GetValue()
            local r3, g3, b3, a3 = 77, 69, 174, 255
            local health = lp:GetHealth()
            local armor = lp:GetProp("m_ArmorValue")
            local Weapon_Ammo = lp:GetPropEntity("m_hActiveWeapon"):GetProp('m_iPrimaryReserveAmmoCount')
            local Weapon_Ammo_2 = lp:GetPropEntity("m_hActiveWeapon"):GetProp('m_iClip1')
            local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 50

            if health > 90 then
                r4, g4, b4, a4 = 66, 163, 58, 255
            elseif health > 80 then
                r4, g4, b4, a4 = 89, 136, 49, 255
            elseif health > 60 then
                r4, g4, b4, a4 = 190, 203, 96, 255
            elseif health > 40 then
                r4, g4, b4, a4 = 203, 178, 95, 255
            elseif health > 20 then
                r4, g4, b4, a4 = 255, 91, 58, 255
            elseif health > 0 then
                r4, g4, b4, a4 = 255, 36, 24, 255
            end

            if Halpha == nil then
                Halpha = {health = 130}
            end
            if health * 1.3 ~= 130 then -- alpha animation
                Halpha.health = alpha_stop(Halpha.health - fade_factor, health * 1.3, 130)
            else
                Halpha.health = alpha_stop(Halpha.health + fade_factor, 0, health * 1.3)
            end
            if Aalpha == nil then
                Aalpha = {armor = 130}
            end
            if armor * 1.3 ~= 130 then
                Aalpha.armor = alpha_stop(Aalpha.armor - fade_factor, armor * 1.3, 130)
            else
                Aalpha.armor = alpha_stop(Aalpha.armor + fade_factor, 0, armor * 1.3)
            end

            draw.Color(r2, g2, b2, a2 * 0.25)
            Circular(x, y, 25, 59, 130, 4.5)
            Circular(x, y, 205, 59, 130, 4.5)
            Circular(x, y, 25, 60, 130, 5)
            Circular(x, y, 205, 60, 130, 5)

            draw.Color(r3, g3, b3, a3 * 0.7)
            Circular(x, y, 25, 59.5, Aalpha.armor, 4.8)
            draw.Color(r3, g3, b3, a3 * 0.5)
            Circular(x, y, 25, 59, Aalpha.armor, 4.5)
            draw.Color(r3, g3, b3, a3 * 0.2)
            Circular(x, y, 25, 60, Aalpha.armor, 5)
            Circular(x, y, 25, 60, Aalpha.armor, 5)

            draw.Color(r4, g4, b4, a4 * 0.7)
            Circular(x, y, 335 - Halpha.health, 59.5, Halpha.health, 4.8)
            draw.Color(r4, g4, b4, a4 * 0.5)
            Circular(x, y, 335 - Halpha.health, 59, Halpha.health, 4.5)
            draw.Color(r4, g4, b4, a4 * 0.2)
            Circular(x, y, 335 - Halpha.health, 60, Halpha.health, 5)
            Circular(x, y, 335 - Halpha.health, 60, Halpha.health, 5)

            draw.Color(r2, g2, b2, a2* 0.3)
            draw.FilledCircle(x, y, 43)
            draw.FilledCircle(x, y, 43.3)
            draw.Color(r2, g2, b2, a2 * 0.2)
            draw.FilledCircle(x, y, 43.6)
            draw.Color(r2, g2, b2, a2 * 0.15)
            draw.FilledCircle(x, y, 43.9)
            draw.FilledCircle(x, y, 49.8)
            draw.Color(r2, g2, b2, a2 * 0.10)
            draw.FilledCircle(x, y, 44.2)
            draw.FilledCircle(x, y, 49.9)
            draw.Color(r2, g2, b2, a2 * 0.08)
            draw.FilledCircle(x, y, 44.5)
            draw.FilledCircle(x, y, 50)
            draw.Color(r2, g2, b2, a2 * 0.05)
            draw.FilledCircle(x, y, 44.7)
            draw.FilledCircle(x, y, 50)
            draw.SetFont(fontText)
            local x1, y1 = draw.GetTextSize(health)
            draw.Color(r4, g4, b4, a4)
            draw.TextShadow(x - (x1 / 2), y - 62, health)
            local x2, y2 = draw.GetTextSize(armor)
            draw.Color(r3, g3, b3, a3)
            draw.TextShadow(x - (x2 / 2), y + 52, armor)
            
            if Weapon_Ammo_2 ~= -1 then
                local x1 = draw.GetTextSize(Weapon_Ammo)
                draw.Color(Circular_WeaponUI_Clr3:GetValue())
                draw.TextShadow(x - (x1 / 2) + 1, y + 25, Weapon_Ammo)
            end
        end
    end

end

--WeaponIcon
local function WeaponIcon()

    local lp = entities.GetLocalPlayer()
    if lp ~= nil and lp:IsAlive() == true  then

        local x, y = drag_menu(tX, tY, 100, 100)
        local x, y = x + 50, y + 50
        local wid = lp:GetWeaponID()
        local r, g, b, a = Circular_WeaponUI_Clr2:GetValue()
        draw.Color(r, g, b, a)
        if wid == 1 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.deagle)
            Ammo2_Circular = 51.5
         elseif wid == 2 then
            draw.SetFont(font4Weapon)
            draw.Text(x - 21, y - 5, weaponfont.elite)
            Ammo2_Circular = 12
        elseif wid == 3 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.fiveseven)
            Ammo2_Circular = 18
        elseif wid == 4 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.glock)
            Ammo2_Circular = 18
        elseif wid == 7 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 5, weaponfont.ak47)
            Ammo2_Circular = 12
        elseif wid == 8 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 5, weaponfont.aug)
            Ammo2_Circular = 12
        elseif wid == 9 then
            draw.SetFont(font2Weapon)
            draw.Text(x - 39, y - 10, weaponfont.awp)
            Ammo2_Circular = 36
        elseif wid == 10 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 5, weaponfont.famas)
            Ammo2_Circular = 14.4
        elseif wid == 11 then
            draw.SetFont(font2Weapon)
            draw.Text(x - 39, y - 10, weaponfont.g3sg1)
            Ammo2_Circular = 18
        elseif wid == 13 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 5, weaponfont.galilar)
            Ammo2_Circular = 10.29
        elseif wid == 14 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 7, weaponfont.m249)
            Ammo2_Circular = 3.6
        elseif wid == 16 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 6, weaponfont.m4a1)
            Ammo2_Circular = 12
        elseif wid == 17 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.mac10)
            Ammo2_Circular = 12
        elseif wid == 19 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 9, weaponfont.p90)
            Ammo2_Circular = 7.2
        elseif wid == 23 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 6, weaponfont.mp5sd)
            Ammo2_Circular = 12
        elseif wid == 24 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.ump45)
            Ammo2_Circular = 14.4
        elseif wid == 25 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.xm1014)
            Ammo2_Circular = 51.43
        elseif wid == 26 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.bizon)
            Ammo2_Circular = 5.625
        elseif wid == 27 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.mag7)
            Ammo2_Circular = 72
        elseif wid == 28 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.negev)
            Ammo2_Circular = 2.4
        elseif wid == 29 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.sawedoff)
            Ammo2_Circular = 51.43
        elseif wid == 30 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 4, weaponfont.tec9)
            Ammo2_Circular = 20
        elseif wid == 31 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.taser)
            Ammo2_Circular = 360
        elseif wid == 32 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.hkp2000)
            Ammo2_Circular = 27.7
        elseif wid == 33 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.mp7)
            Ammo2_Circular = 12
        elseif wid == 34 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 20, y - 3, weaponfont.mp9)
            Ammo2_Circular = 12
        elseif wid == 35 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 6, weaponfont.nova)
            Ammo2_Circular = 45
        elseif wid == 36 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.p250)
            Ammo2_Circular = 27.7
        elseif wid == 38 then
            draw.SetFont(font2Weapon)
            draw.Text(x - 39, y - 10, weaponfont.scar20)
            Ammo2_Circular = 18
        elseif wid == 39 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 27, y - 6, weaponfont.sg553)
            Ammo2_Circular = 12
        elseif wid == 40 then
            draw.SetFont(font2Weapon)
            draw.Text(x - 39, y - 10, weaponfont.ssg08)
            Ammo2_Circular = 36
        elseif wid == 41 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife)
            Ammo2_Circular = 360
        elseif wid == 42 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife)
            Ammo2_Circular = 360
        elseif wid == 43 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 17, y - 2, weaponfont.flashbang)
            Ammo2_Circular = 360
        elseif wid == 44 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 17, y - 3, weaponfont.frag_grenade)
            Ammo2_Circular = 360
        elseif wid == 45 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 16, y - 3, weaponfont.smokegrenade)
            Ammo2_Circular = 360
        elseif wid == 46 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 17, y - 4, weaponfont.firebomb)
            Ammo2_Circular = 360
        elseif wid == 47 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 17, y - 3, weaponfont.decoy)
            Ammo2_Circular = 360
        elseif wid == 48 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 17, y - 3, weaponfont.incgrenade)
            Ammo2_Circular = 360
        elseif wid == 49 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 18, y - 3, weaponfont.c4)
            Ammo2_Circular = 360
        elseif wid == 57 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y, "?")
            Ammo2_Circular = 360
        elseif wid == 59 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_t)
            Ammo2_Circular = 360
        elseif wid == 60 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 5, weaponfont.m4a1_silencer)
            Ammo2_Circular = 14.4
        elseif wid == 61 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 5, weaponfont.usp_silencer)
            Ammo2_Circular = 30
        elseif wid == 63 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.cz75a)
            Ammo2_Circular = 30
        elseif wid == 64 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.revolver)
            Ammo2_Circular = 45
        elseif wid == 68 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.tagrenade)
            Ammo2_Circular = 360
        elseif wid == 69 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.fists)
            Ammo2_Circular = 360
        elseif wid == 70 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.breachcharge)
            Ammo2_Circular = 360
        elseif wid == 75 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.axe)
            Ammo2_Circular = 360
        elseif wid == 76 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.hammer)
            Ammo2_Circular = 360
        elseif wid == 78 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.spanner)
            Ammo2_Circular = 360
        elseif wid == 84 then
            draw.SetFont(fontWeapon)
            draw.Text(x - 15, y - 2, weaponfont.snowball)
            Ammo2_Circular = 360
        elseif wid == 500 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.bayonet)
            Ammo2_Circular = 360
        elseif wid == 503 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 15, y, "?")
            Ammo2_Circular = 360
        elseif wid == 505 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_flip)
            Ammo2_Circular = 360
        elseif wid == 506 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_gut)
            Ammo2_Circular = 360
        elseif wid == 507 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_karambit)
            Ammo2_Circular = 360
        elseif wid == 508 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_m9_bayonet)
            Ammo2_Circular = 360
        elseif wid == 509 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_tactical)
            Ammo2_Circular = 360
        elseif wid == 512 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_falchion)
            Ammo2_Circular = 360
        elseif wid == 514 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_bowie)
            Ammo2_Circular = 360
        elseif wid == 515 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_butterfly)
            Ammo2_Circular = 360
        elseif wid == 516 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_push)
            Ammo2_Circular = 360
        elseif wid == 517 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 15, y, "?")
            Ammo2_Circular = 360
        elseif wid == 518 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_survival_bowie)
            Ammo2_Circular = 360
        elseif wid == 519 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_ursus)
            Ammo2_Circular = 360
        elseif wid == 520 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_gypsy_jackknife)
            Ammo2_Circular = 360
        elseif wid == 521 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 15, y, "?")
            Ammo2_Circular = 360
        elseif wid == 522 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_stiletto)
            Ammo2_Circular = 360
        elseif wid == 523 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 28, y - 7, weaponfont.knife_widowmaker)
            Ammo2_Circular = 360
        elseif wid == 525 then
            draw.SetFont(font3Weapon)
            draw.Text(x - 15, y, "?")
            Ammo2_Circular = 360
        end
    end

end
--On Ammo Circular
local function AmmoCircular()

    local lp = entities.GetLocalPlayer()
    if lp ~= nil and lp:IsAlive() == true  then
        local x, y = drag_menu(tX, tY, 100, 100)
        local x, y = x + 50, y + 50
        local Weapon_Ammo = lp:GetPropEntity("m_hActiveWeapon"):GetProp('m_iPrimaryReserveAmmoCount')
        local Weapon_Ammo_2 = lp:GetPropEntity("m_hActiveWeapon"):GetProp('m_iClip1')
        local r, g, b, a = 16, 16, 16, 255
        local r2, g2, b2, a2 = Circular_WeaponUI_Clr4:GetValue()
        draw.Color(r2, g2, b2, a2 * 0.8)
        Circular(x, y, 270, 50, Weapon_Ammo_2*Ammo2_Circular, 4)
        draw.Color(r2, g2, b2, a2 * 0.5)
        Circular(x, y, 270, 49, Weapon_Ammo_2*Ammo2_Circular, 4.5)
        draw.Color(r2, g2, b2, a2 * 0.2)
        Circular(x, y, 270, 49.5, Weapon_Ammo_2*Ammo2_Circular, 4.6)
        Circular(x, y, 270, 50, Weapon_Ammo_2*Ammo2_Circular, 4.8)
        draw.Color(r2, g2, b2, a2 * 0.1)
        Circular(x, y, 270, 50, Weapon_Ammo_2*Ammo2_Circular, 5.5)
        Circular(x, y, 270, 51, Weapon_Ammo_2*Ammo2_Circular, 7)

        if Ammo2_Circular > 10 then
            draw.Color(r, g, b, a * 0.5)
            CircularAmmo(x, y, 270.5, 50, Weapon_Ammo_2*Ammo2_Circular, 5.5, Ammo2_Circular)
            draw.Color(r, g, b, a * 0.3)
            CircularAmmo(x, y, 270.5, 50.5, Weapon_Ammo_2*Ammo2_Circular, 5.5, Ammo2_Circular)
        end
    end

end
callbacks.Register("Draw", function()
    if Circular_WeaponUI_Enable:GetValue() then
        PositionSave()
        drawCircular()
        WeaponIcon()
        AmmoCircular()
    end
end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

