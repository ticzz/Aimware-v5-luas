--Working on aimware
--by qi

--gui
local dt_storage_indicator_reference = gui.Reference("Misc" , "General" , "Extra");
local dt_storage_indicator_enable = gui.Checkbox(dt_storage_indicator_reference, 'dtstorageind.enable', "Enable DT indicator", 1)
local dt_storage_indicator_clr1 = gui.ColorPicker(dt_storage_indicator_enable, 'clr', 'clr', 255, 255, 255, 255)
local dt_storage_indicator_clr2 = gui.ColorPicker(dt_storage_indicator_enable, 'clr2', 'clr2', 255, 255, 255, 255)
local dt_storage_indicator_text_clr = gui.ColorPicker(dt_storage_indicator_enable, 'text.clr', 'textclr', 255, 255, 255, 255)
local x, y = draw.GetScreenSize()
local dt_storage_indicator_x = gui.Slider(dt_storage_indicator_reference, "dtstorageind.x", "dt_storage_indicator_x", 500, 0, x)
local dt_storage_indicator_y = gui.Slider(dt_storage_indicator_reference, "dtstorageind.y", "dt_storage_indicator_y", 500, 0, y)
dt_storage_indicator_x:SetInvisible(true)
dt_storage_indicator_y:SetInvisible(true)

--var
local MENU = gui.Reference("MENU")
local tX, tY, offsetX, offsetY, _drag
local font = draw.CreateFont( "Verdana", 12.5, 11.5 )
local tickbase = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks")

--function

--Mouse drag
local is_inside = function(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end

local drag_menu = function(x, y, w, h)
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
            dt_storage_indicator_x:SetValue(tX) 
            dt_storage_indicator_y:SetValue(tY)
        end
    else
        _drag = false
    end
    return tX, tY
end

--alpha function
local function alpha_stop( val, min, max )
	if val < min then return min end
	if val > max then return max end
	return val;
end

--On draw indicator
local function draw_indicator()

    local lp = entities.GetLocalPlayer() 
    if lp ~= nil then

        local hActiveWeapon = lp:GetPropEntity("m_hActiveWeapon")
        local _SecondaryAttack =  hActiveWeapon:GetPropFloat("LocalActiveWeaponData", "m_flNextSecondaryAttack") --Get ammunition reply

        if _SecondaryAttack ~= nil and dt_storage_indicator_enable:GetValue() then

            --Let drag position save
            if tX ~= dt_storage_indicator_x:GetValue() or tY ~= dt_storage_indicator_y:GetValue() then
                tX, tY = dt_storage_indicator_x:GetValue(),dt_storage_indicator_y:GetValue()
            end
            --var
            local wid = lp:GetWeaponID()
            local x, y = drag_menu(tX, tY, 300, 25)
            local r, g, b, a = dt_storage_indicator_clr1:GetValue()
            local r2, g2, b2, a2 = dt_storage_indicator_clr2:GetValue()
            local r3, g3, b3, a3 = dt_storage_indicator_text_clr:GetValue()

            local fade_factor = ((1.0 / 0.15) * globals.FrameTime()) * 100
            local storage = false
            local ready = "Chaging"

            if _SecondaryAttack <= globals.CurTime() then
                storage = true
                ready = "Ready"
            end
            
            local text = "     [Aimware] | Tickbase("..tickbase:GetValue().."tick):"..ready
            local w, h = draw.GetTextSize(text)

            if alpha == nil then
                alpha = {alpha = 200};
            end
            if not storage and alpha ~= 200 then -- alpha animation
                alpha.alpha = alpha_stop(alpha.alpha - fade_factor, 0, 200)
            else
                alpha.alpha = alpha_stop(alpha.alpha + fade_factor, 0, 200)
            end

            draw.Color(r2, g2, b2, a2)
            draw.FilledRect(x, y, x + 200, y + 2)

            draw.Color(r, g, b, a)
            draw.FilledRect(x, y, x + alpha.alpha, y + 2)
            draw.Color(r3, g3, b3, a3)
            draw.SetFont(font)
            draw.TextShadow(x + 5, y + 5, text)
            --Check whether DT is on
            local Doubletap = false
            if gui.GetValue("rbot.master") and (wid == 1) and gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.hitscan.accuracy.smg.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire") ~= 0 then
                Doubletap = true
            elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire") ~= 0 then
                Doubletap = true
            end
            --Set color
            if Doubletap then
                a3_1 = 255
            else
                a3_1 = math.floor(math.sin((globals.RealTime()) * 4) * 100 + 200) - 80
            end
            if storage then
                r3, g3, b3 = r3, g3, b3
            else
                r3, g3, b3 = 255, 0, 0, a3_1   
            end 

            draw.Color(r3, g3, b3, a3_1)
            draw.Text(x + 3, y + 5.5, 'DT')
            draw.Text(x + 3, y + 5.5, 'DT')
        end
    end

end
--callbacks
callbacks.Register('Draw', draw_indicator)
--end





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

