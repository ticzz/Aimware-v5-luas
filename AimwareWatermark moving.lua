local x,y = 5,5
local flipX, flipY = false, false
local hitCorner = false
local cornerMoment = nil
local startmoment = globals.CurTime()
local start_ref = gui.Reference("MISC","General","Extra")
local speed = gui.Slider(start_ref,"misc.general.extra.screensaver_speed","Screensaver speed",1,1,20)
callbacks.Register("Draw",function()
    local scrW, scrH = draw.GetScreenSize()
    local text = "Aimware.net"
    local textW, textH = draw.GetTextSize(text)

    if(startmoment + 1 <= globals.CurTime()) then
        if(x <= 5 and y <= 5) then
            --hit left top corner
            hitCorner = true
            cornerMoment = globals.CurTime()
            speed:SetValue(1)
            print("CORNER HIT")
        end
        if(x >= scrW - (textW + 5) and y <= 5) then
            --hit right top corner
            hitCorner = true
            cornerMoment = globals.CurTime()
            speed:SetValue(1)
            print("CORNER HIT")
        end
        if(x >= scrW - (textW + 5) and y >= scrW - (textW + 5)) then
            --hit right bottom corner
            hitCorner = true
            cornerMoment = globals.CurTime()
            speed:SetValue(1)
            print("CORNER HIT")
        end
        if(x <= 5 and y >= scrW - (textW + 5)) then
            --hit right bottom corner
            hitCorner = true
            cornerMoment = globals.CurTime()
            speed:SetValue(1)
            print("CORNER HIT")
        end
    end

    if(x >= scrW - (textW + 5)) then
        flipX = true
    elseif(x <= 5) then
        flipX = false
    end

    if(y >= scrH - (textH + 5)) then
        flipY = true
    elseif(y <= 5) then
        flipY = false
    end

    if(flipX == true) then
        x = x - ((100 * speed:GetValue()) * globals.FrameTime())
    else
        x = x + ((100 * speed:GetValue()) * globals.FrameTime())
    end
    if(flipY == true) then
        y = y - ((100 * speed:GetValue()) * globals.FrameTime())
    else
        y = y + ((100 * speed:GetValue()) * globals.FrameTime())
    end
    draw.Color(255,255,255,255)
    draw.Text(x,y,"Aimware.net")
    if(hitCorner == true) then
        draw.Color(math.random(0,255),math.random(0,255),math.random(0,255),255)
        if(cornerMoment + 2 <= globals.CurTime()) then
            hitCorner = false
        end
    else
        draw.Color(255,0,0,128)
    end
    draw.FilledRect(x,y + textH + 2,x + textW,y + textH + 7)
    draw.Triangle(x - 5,y + textH + 2,x,y + textH + 2,x,y + textH + 7)
    draw.Triangle(x + textW,y + textH + 2,x + textW,y + textH + 7,x + textW + 5,y + textH + 2)
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

