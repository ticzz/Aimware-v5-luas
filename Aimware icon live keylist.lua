--Working on aimware
--by Qi
--gui
local Lve_KeyIndicator_Reference = gui.Reference( "Misc", "General", "Extra");
local Lve_KeyIndicator_Checkbox = gui.Checkbox( Lve_KeyIndicator_Reference, "lve.keyIndicator.enable", "Lve Key Indicator", 0 );
local Lve_KeyIndicator_ColorPicker = gui.ColorPicker( Lve_KeyIndicator_Checkbox, 'clr', 'clr', 255, 0, 0, 255 )
local Lve_KeyIndicator_ColorPicker2 = gui.ColorPicker( Lve_KeyIndicator_Checkbox, 'clr2', 'clr2', 255, 0, 0, 255 )
local Lve_KeyIndicator_ColorPicker3 = gui.ColorPicker( Lve_KeyIndicator_Checkbox, 'clr3', 'clr3', 255, 50, 50, 255 )
local Lve_KeyIndicator_ColorPicker4 = gui.ColorPicker( Lve_KeyIndicator_Checkbox, 'clr4', 'clr4', 255, 0, 0, 20 )

local X, Y = draw.GetScreenSize();
local Lve_KeyIndicator_X = gui.Slider( Lve_KeyIndicator_Checkbox, "lve.keyIndicator.x", 'X', 350, 0, X );
local Lve_KeyIndicator_Y = gui.Slider( Lve_KeyIndicator_Checkbox, "lve.keyIndicator.y", 'Y', 310, 0, Y );
Lve_KeyIndicator_X:SetInvisible(true)
Lve_KeyIndicator_Y:SetInvisible(true)
Lve_KeyIndicator_Checkbox:SetDescription("Display part of active key indicator.")

--var
local B64_Aimware_Icon = [[iVBORw0KGgoAAAANSUhEUgAAAHgAAAB4CAYAAAA5ZDbSAAAACXBIWXMAAC4jAAAuIwF4pT92AAAFwmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDIgNzkuMTYwOTI0LCAyMDE3LzA3LzEzLTAxOjA2OjM5ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIiB4bXA6Q3JlYXRlRGF0ZT0iMjAyMC0wNi0xOFQxNDo0ODo1MSswMjowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMC0wNi0xOFQxNDo0ODo1MSswMjowMCIgeG1wOk1vZGlmeURhdGU9IjIwMjAtMDYtMThUMTQ6NDg6NTErMDI6MDAiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6ZTM3ODA4YTUtZDIxYi1lOTQ1LWJiODUtNTk3OTUxZjM5MzIzIiB4bXBNTTpEb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6OTM4ZDBmNWItNTNkMi0wYjRkLWFhZDItZjBl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]];
local tX, tY, offsetX, offsetY, Drag
local font = draw.CreateFont( "Arial", 14, 0 );
local font2 = draw.CreateFont( "Verdana", 13, 0 );
--function

--mouse drag
local function Is_Inside(a, b, x, y, w, h) 
    return 
    a >= x and a <= w and b >= y and b <= h 
end

local Drag_menu = function(x, y, w, h)
    if not gui.Reference("MENU"):IsActive() then
        return tX, tY
    end
    local mouse_down = input.IsButtonDown(1)
    if mouse_down then
        local X, Y = input.GetMousePos()
        if not Drag then
            local w, h = x + w, y + h
            if Is_Inside(X, Y, x, y, w, h) then
                offsetX, offsetY = X - x, Y - y
                Drag = true
            end
        else
            tX, tY = X - offsetX, Y - offsetY
            Lve_KeyIndicator_X:SetValue(tX) 
            Lve_KeyIndicator_Y:SetValue(tY)
        end
    else
        Drag = false
    end
    return tX, tY
end


--64Bit to Png Decoder
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end
local Icon = dec(B64_Aimware_Icon)
local RGBA, width, height = common.DecodePNG(Icon)
local texture = draw.CreateTexture(RGBA, width, height)

--On draw
local function Ondraw()
    if tX ~= Lve_KeyIndicator_X:GetValue() or tY ~= Lve_KeyIndicator_Y:GetValue() then -- Make location saveable
        tX, tY = Lve_KeyIndicator_X:GetValue(),Lve_KeyIndicator_Y:GetValue()
    end

    local lp = entities.GetLocalPlayer()
    local x, y = Drag_menu(tX, tY, 200, 160)
    local r, g, b, a = Lve_KeyIndicator_ColorPicker:GetValue()
    local r2, g2, b2, a2 = Lve_KeyIndicator_ColorPicker2:GetValue()
    local r3, g3, b3, a3 = Lve_KeyIndicator_ColorPicker3:GetValue()
    local r4, g4, b4, a4 = Lve_KeyIndicator_ColorPicker4:GetValue()

    if lp ~= nil and Lve_KeyIndicator_Checkbox:GetValue() then
        --Draw background
        draw.Color( r, g, b, a*0.2 )
        draw.OutlinedRect( x-0.5, y-0.5, x+202.5, y+162.5 )
        draw.OutlinedRect( x+0.5, y+0.5, x+201.5, y+161.5 )
        draw.Color( r, g, b, a*0.3 )
         draw.OutlinedRect( x-0.2, y-0.2, x+202.2, y+162.2 )
        draw.OutlinedRect( x+0.2, y+0.2, x+201.2, y+161.2 )
        draw.Color( r, g, b, a)
        draw.OutlinedRect( x, y, x+202, y+162 )
        draw.Color( 4, 4, 4, a4*0.7)
        draw.FilledRect( x, y, x+202, y+162 )

        draw.Color( 0, 0, 0, a4)
        draw.FilledRect( x+0.5, y+0.5, x+201.5, y+40 )
        draw.Color( r4*0.7, g4*0.7, b4*0.7, a4)
        draw.FilledRect( x+0.5, y+0.5, x+201.5, y+39 )
        draw.Color( r4, g4, b4, a4)
        draw.FilledRect( x+0.5, y+0.5, x+201.5, y+38 )
    
        draw.Color( r4*0.7, g4*0.7, b4*0.7, a4)
        draw.FilledRect( x+9, y+59, x+191, y+151 )
        draw.FilledRect( x+14, y+49, x+61, y+60 )
        draw.Color( r4, g4, b4, a4)
        draw.FilledRect( x+10, y+60, x+190, y+150 )
        draw.FilledRect( x+15, y+50, x+60, y+60 )

        --Draw Key
        draw.SetFont( font )
        draw.Color( r, g, b, 255)
        draw.TextShadow( x+19, y+56, 'Key list' )
        draw.SetFont( font2 )
        
        draw.Color( 74, 74, 74, 255)
        if gui.GetValue("rbot.master") and gui.GetValue("rbot.accuracy.movement.slowkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.accuracy.movement.slowkey")) then
            draw.Color( r2, g2, b2, 255)
        end
        draw.TextShadow( x+20, y+72, 'Slow walk' )

        draw.Color( 74, 74, 74, 255)
        if gui.GetValue("rbot.master") and gui.GetValue("rbot.antiaim.extra.fakecrouchkey") ~= 0 and input.IsButtonDown(gui.GetValue("rbot.antiaim.extra.fakecrouchkey")) then
            draw.Color( r2, g2, b2, 255)
        end
        draw.TextShadow( x+20, y+87, 'Fake duck' )

        draw.Color( 74, 74, 74, 255)
        if gui.GetValue("rbot.antiaim.condition.shiftonshot") then
            draw.Color( r2, g2, b2, 255)
        end
        draw.TextShadow( x+20, y+102, 'Hide shots' )

        local Doublefire = false
        local wid = lp:GetWeaponID()
        if gui.GetValue("rbot.master") and (wid == 1 ) and gui.GetValue("rbot.hitscan.accuracy.hpistol.doublefire") then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) and gui.GetValue("rbot.hitscan.accuracy.pistol.doublefire") ~= 0 then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) and gui.GetValue("rbot.hitscan.accuracy.rifle.doublefire") ~= 0 then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 11 or wid == 38) and gui.GetValue("rbot.hitscan.accuracy.asniper.doublefire") ~= 0 then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) and gui.GetValue("rbot.hitscan.accuracy.smg.doublefire") ~= 0 then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 14 or wid == 28) and gui.GetValue("rbot.hitscan.accuracy.lmg.doublefire") ~= 0 then
            Doublefire = true
        elseif gui.GetValue("rbot.master") and (wid == 25 or wid == 27 or wid == 29 or wid == 35) and gui.GetValue("rbot.hitscan.accuracy.shotgun.doublefire") ~= 0 then
            Doublefire = true
        end
        draw.Color( 74, 74, 74, 255)
        if Doublefire then
            draw.Color( r2, g2, b2, 255)
        end
        draw.TextShadow( x+20, y+117, 'Double fire' )

        draw.Color( 74, 74, 74, 255)
        if gui.GetValue("rbot.antiaim.base.rotation") < 0 then
            draw.Color( r2, g2, b2, 255)
        end 
        draw.TextShadow( x+20, y+132, 'AA Inverter' )

    end

    --Draw Icon
    if lp ~= nil and Lve_KeyIndicator_Checkbox:GetValue() then
        draw.SetTexture(texture)
        draw.Color(r3, g3, b3, a3*0.7)
        draw.FilledRect(x+84.2, y+1.2, x+width+0.5, y+height-82.5)
        draw.Color(r3, g3, b3, a3)
        draw.FilledRect(x+85, y+1.7, x+width, y+height-83)
    end


end

--callback
callbacks.Register("Draw", Ondraw)
--end

--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

