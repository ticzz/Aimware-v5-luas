--该脚本应在每种分辨率下均能很好地扩展
--在非常低的分辨率下，速度和距离将在框外渲染（如果启用）
--速度指示器的字体大小也与分辨率成比例，但是speedGain和distance不会
--修复了速度图观战模式下会闪动的问题
--修复了速度图FPS掉帧导致闪退的问题
--START OF SETTINGS--

uiSpeed = true -- Enable speed indicator
uiGraph = true -- Enable speed graph
uiGraphJumps = true -- Speed graph display jumps

uiGraphWidth = 250 -- Speed graph width (min: 0, max: 700, default: 250)
uiGraphMaxY = 400 -- Speed graph max speed (min: 0, max: 5000, default: 400)

bMakeGraphScalableWithResolution = true -- Causes uiGraphWidth and uiGraphMaxY to be ignored, instead graph size will be dynamically calculated from screen size

bRenderBoxGlobal = false -- Renders a box around the graph. Requires bMakeGraphScalableWithResolution enabled to work
boxColor = {255, 255, 255, 255} -- box color in rgba format

uiGraphCompression = 3 -- Speed graph compression
uiGraphFreq = 0 -- Speed graph delay (min: 0, max: 150, default: 0)
uiGraphSpread = 10 -- Speed graph spread (min: 0, max: 50, default: 10)
uiGraphAlpha = 255 -- Speed graph alpha (min: 0, max: 255, default: 255)

bRainbowColor = true -- Masterswitch for rainbow colors
bRainbowCurve = false -- Changes graph curve color to rainbow
bRainbowBox = false -- Changes boxColor var to rainbow
bRainbowIndicator = false -- Changes speed indicator color to rainbow

-- END OF SETTINGS --

lastVel = 0
tickPrev = 0
history = {} -- set this to empty upon changing vars above when script is running (if you implement gui)
lastGraph = 0

jumpTime = 0
jumping = false
jumpPos = nil
landPos = nil
jumpSpeed = nil

lastJump = 0
graphSetJump = false
graphSetLand = false

text = nil

lastYaw = 0

last_realtime = globals.RealTime()
FL_ONGROUND = bit.lshift(1,0)
FL_PARTIALGROUND = bit.lshift(1,18)

local function get_local_player()
    local player = entities.GetLocalPlayer()
    if player == nil then return end
    if (not player:IsAlive()) then
        player = player:GetPropEntity("m_hObserverTarget")
    end
    return player
end

local function round(number, decimals)
    local power = (10 ^ decimals)
    return (math.floor(number * power) / power)
end

local function colour(dist)
    if dist >= 235 then
        return {255, 137, 34}
    elseif dist >= 230 then
        return {255, 33, 33}
    elseif dist >= 227 then
        return {57, 204, 96}
    elseif dist >= 225 then
        return {91, 225, 255}
    else
        return {170, 170, 170}
    end
end

local function speedgraph(vel, x, y, tickNow, bShouldRenderBox)
    if(bShouldRenderBox and bRenderBoxGlobal) then
        draw.Color(boxColor[1], boxColor[2], boxColor[3], boxColor[4])
      
        if(bRainbowColor and bRainbowBox) then
            draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), 255)
        end

        draw.OutlinedRect(x - (x * 0.13), y - (y * 0.1582), x + (x * 0.1325), y + (y * 0.0011454753722795)) -- first 'y' is a little bit off on purpose so you can tell the difference between max velocity and 0 velocity with box on
    end

    local sx, sy = draw.GetScreenSize()

    local alpha = uiGraphAlpha
    local graphMaxY = uiGraphMaxY
    local w = uiGraphWidth
  
    if(bMakeGraphScalableWithResolution) then
        graphMaxY = (sy * 0.37)
        w = (sx * 0.1302083)
    end

    local graphCompression = uiGraphCompression

    local graphFreq = uiGraphFreq
    local graphSpread = (uiGraphSpread / 10)

    x = x - (w / 2)

    if(jumpSpeed == nil) then
        jumpSpeed = 0
    end

    if (lastGraph + graphFreq < tickNow) then
        local temp = {}
        temp.vel = math.min(vel, graphMaxY)
        if graphSetJump then
            graphSetJump = false
            temp.jump = true
            temp.jumpSpeed = jumpSpeed
            temp.jumpPos = jumpPos
        end

        if graphSetLand then
            graphSetLand = false
            temp.landed = true
            temp.landPos = landPos
        end

        table.insert(history, temp)
        lastGraph = tickNow
    end

    local over = #history - w / graphSpread
    if over > 0 then
        table.remove(history, 1)
    end

    for i = 2, #history, 1 do
        local val = history[i].vel
        local prevVal = history[i].vel

        local curX = x + ((i * graphSpread))
        local prevX = x + ((i - 1) * graphSpread)

        local curY = y - (val / graphCompression)
        local prevY = y - (prevVal / graphCompression)

        if (uiGraphJumps) then
            if history[i].jump then
                local index

                for q = i + 1, #history, 1 do
                    if history[q].jump then
                        index = q
                        break
                    end

                    if history[q].landed then
                        index = q
                        break
                    end
                end

                local above = 13

                if index then
                    if history[index].landPos and history[index].landPos[1] then
                        local jSpeed = history[i].jumpSpeed
                        local lSpeed = history[index].vel

                        local speedGain = lSpeed - jSpeed

                        if speedGain > -100 then
                            local jPos = history[i].jumpPos[1]
                            local lPos = history[index].landPos[1]
                      
                          

                            distX = (lPos.x - jPos.x)
                            distY = (lPos.y - jPos.y)
                          
                          

                            local distance = math.sqrt( (distX ^ 2) + (distY ^ 2) ) + 32

                            if distance > 150 then
                                local jumpX = curX - 1
                                local jumpY = curY

                                local landX = x + (index * graphSpread)
                                local landY = y - (history[index].vel / graphCompression)

                                local topY = landY - above
                                if topY > jumpY or topY > jumpY - above then
                                    topY = jumpY - above
                                end

                                draw.Color(255, 255, 255, math.max(alpha - 55, 50))
                              
                                if(bRainbowColor and bRainbowCurve) then
                                    draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), alpha)
                                end
                              
                                draw.Line(jumpX, jumpY, jumpX, topY)
                                draw.Line(landX, topY, landX, landY)

                                --draw.SetFont(draw.CreateFont("Tahoma", 12))

                                text = speedGain > 0 and "+" or ""
                                text = text .. math.floor(speedGain+0.5)

                                local middleX = ((jumpX + landX) / 2) - 18

                                draw.Color(255, 255, 255, alpha)
                                draw.Text(middleX, topY - 13, text)

                                local ljColour = colour(distance)
                                draw.Color(ljColour[1], ljColour[2], ljColour[3], alpha)
                                draw.Text(middleX, topY, "(" .. math.floor(distance+0.5) .. ")")
                            end
                        end
                    end
                end
            end
        end

        draw.Color(255, 255, 255, alpha)
      
        if(bRainbowColor and bRainbowCurve) then
            draw.Color( (math.sin(globals.RealTime()) * 255), (math.cos(globals.RealTime()) * 255), (math.tan(globals.RealTime()) * 255), alpha)
        end
        draw.Line(prevX, prevY, curX, curY)
    end
end

callbacks.Register('Draw',function()
        if not uiSpeed and not uiGraph then
            return
        end

        if get_local_player() == nil then
            return
        end

        local sx, sy = draw.GetScreenSize()

        local flags = get_local_player():GetPropInt('m_fFlags')
        if flags == nil then
            return
        end
        local onground = bit.band(flags, 1) ~= 0

        local movetype = get_local_player():GetPropInt('m_iMoveState') -- this isn't proper way to get 'movetype'

        if movetype == 2 then -- moving on a ladder and nocliping
            jumping = false
            landPos = {nil, nil, nil}
            graphSetLand = true
            return
        end

        if not onground and not jumping then
            local x, y, z = get_local_player():GetAbsOrigin()
            if x == nil then
                return
            end

            local vx = get_local_player():GetPropFloat('localdata', 'm_vecVelocity[0]')
            local vy = get_local_player():GetPropFloat('localdata', 'm_vecVelocity[1]')

            if vx == nil then
                return
            end

            graphSetJump = true
            jumping = true
            jumpPos = {x, y, z}
            jumpSpeed = math.floor(math.min(10000, math.sqrt(vx * vx + vy * vy) + 0.5))

            local thisTick = globals.TickCount()
            lastJump = thisTick

            if last_realtime + 4 < globals.RealTime() then
                if lastJump == thisTick then
                    jumpSpeed = nil
                end
                last_realtime = globals.RealTime()
            end
        end

        if jumping and onground then
            local x, y, z = get_local_player():GetAbsOrigin()
            if x == nil then
                return
            end

            jumping = false
            landPos = {x, y, z}
            graphSetLand = true
        end

        --draw.SetFont(draw.CreateFont("Trebuchet MS", math.floor( (sx*0.015625) + 0.5) )) -- 30 on fhd

if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end

        local vx = get_local_player():GetPropFloat('localdata', 'm_vecVelocity[0]')
        local vy = get_local_player():GetPropFloat('localdata', 'm_vecVelocity[1]')

        if vx ~= nil then
            local velocity = math.floor(math.min(10000, math.sqrt(vx * vx + vy * vy) + 0.5))

            local x = (sx / 2)
            local y = (sy / 1.2)

            if (uiSpeed) then
                local r, g, b = 255, 255, 255

                if lastVel < velocity then
                    r, g, b = 30, 255, 109
                end

                if lastVel == velocity then
                    r, g, b = 255, 199, 89
                end

                if lastVel > velocity then
                    r, g, b = 255, 119, 119
                end

                local text = velocity

                if jumpSpeed then
                    text = text .. ' (' .. jumpSpeed .. ')'
                end

                draw.Color(r, g, b, 255)

                if (bRainbowColor and bRainbowIndicator) then
                    draw.Color(
                        (math.sin(globals.RealTime()) * 255),
                        (math.cos(globals.RealTime()) * 255),
                        (math.tan(globals.RealTime()) * 255),
                        255
                    )
                end

                if (velocity == 0) then
                    draw.Text(x - (x * 0.0175), y, text)
                else
                    draw.Text(x - (x * 0.0175), y, text)
                end
            end

            local tickNow = globals.TickCount()
            if (uiGraph) then
                if (bMakeGraphScalableWithResolution == false) then
                    -- if graph size is set manually then don't render box because it'd be broken
                    speedgraph(velocity, x, y - (y * 0.03), tickNow, false)
                else
                    speedgraph(velocity, x, y - (y * 0.03), tickNow, true)
                end
            end

            if tickPrev + 5 < tickNow then
                lastVel = velocity
                tickPrev = tickNow
            end
        end
    end
)


client.AllowListener("player_connect_full");
callbacks.Register("FireGameEvent", function(event)
    tickPrev = globals.TickCount()
    lastGraph = globals.TickCount()
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

