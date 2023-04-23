local points, sizes = {}, {}

local density = 75 -- changing this will raise your fps but have less dots, i notice only 5-6 frames drop with 75 points so that's what i use

for i = 1, density do -- generates our initial points and sizes, you can edit this in the drawing iteration to make them spin and other cool stuff
    table.insert( points, math.random(0, 80))
    table.insert( sizes, math.random())
end

callbacks.Register("Draw", function()
    local lp = entities.GetLocalPlayer()
    if not lp then return end

    local scrW, scrH = draw.GetScreenSize()
    local x, y = scrW / 2, scrH / 2 -- our center coords
    local wep = lp:GetPropEntity('m_hActiveWeapon')
    local spread = ((wep:GetWeaponInaccuracy() + wep:GetWeaponSpread()) * 500) * scrH / 480 -- i found this formula on UC and it is somewhat accurate, but it doesn't account for weapon zoom
    local dspread = spread * 0.015 -- this is to make the dots appear accurately, i just did this by hand; my resolution is 1920x1080 so for others it may not scale correctly

    draw.Color(255, 255, 255, 200)
    for i = 1, density do

        if globals.TickCount() % 7 == 0 then -- this adds the twinking effect, you can change this to be higher or lower but i found 7 to be perfect
            sizes[i] = math.random()      -- math.random's default param is between 0 and 1, so you get floats by default
        end
        local angle = i * math.pi / 10 -- the points can spread on 10 different axis, i've found this is enough to still appear random and not bug out
        local sx, sy = x + (points[i] * dspread) * math.cos(angle), y + (points[i] * dspread) * math.sin(angle) -- don't even ask me about this fuck math

        draw.FilledCircle(sx, sy, sizes[i]) -- draws our little star things. you can also do OutlinedCircle but it doesn't matter
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

