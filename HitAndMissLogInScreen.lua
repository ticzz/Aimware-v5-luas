--??:???sir ?????? 
--????:aw????
--??????????? ??????????

gui.SetValue('misc.log.console',1)
tab_VISUAL_GLB = gui.Tab(gui.Reference("Visuals"),'VISUAL_PAGE', 'VISUAL_PAGE')
gp_visual_glb= gui.Groupbox(tab_VISUAL_GLB, "VISUAL_PAGE(SoShy.Lua)", 15, 15, 610, 0 )
print("_init_ lua is ready!")
local font = draw.CreateFont("CirceBold", 13 , 550)
local font1 = draw.CreateFont("CirceBold", 13 , 600)

local renderer = {}
local size_x,size_y = draw.GetScreenSize()

local ckb_hitlogs_switch = gui.Checkbox(gp_visual_glb, "ckb_hitlogs", "hitlogs(switch)", 1)
ckb_hitlogs_switch:SetDescription('on/off')
local posx_hitlogs = gui.Slider(gp_visual_glb, "posx_hitlogs", "X ", size_x/2, 0, size_x)
local posy_hitlogs = gui.Slider(gp_visual_glb, "posy_hitlogs", "Y ", size_y/3*2, 0, size_y)
local comb_hitlogs_tpye = gui.Combobox( gp_visual_glb , "comb_hitlogs_tpye" , "type" , "left","center" )

local alpha1 = 0
local function dealWithalpha()
    
    if alpha1 >= 30 then
        inv1 = true
    elseif alpha1 <= 0 then
        inv1 = false
    end
    if inv1 then
        if globals.TickCount()%5 == 0 then
            alpha1 = alpha1-1
        end

    else
        if globals.TickCount()%5 == 0 then
        alpha1 = alpha1+1
        end
    end
        
end
callbacks.Register( "Draw", "dealWithalpha", dealWithalpha)

renderer.text = function(x, y, clr, shadow, string, font, flags)
    local alpha = 255
    if font then
        draw.SetFont(font)
    end
    local textW, textH = draw.GetTextSize(string)
    if clr[4] then
        alpha = clr[4]
    end
    if flags == "l" then
        x = x - textW
    elseif flags == "r" then
        x = x + textW
    elseif flags == "lc" then
        x = x - (textW / 2)
    elseif flags == "rc" then
        x = x + (textW / 2)
    end
    if shadow then
        draw.Color(0, 0, 0, alpha)
        draw.Text(x + 1, y + 1, string)
    end
    draw.Color(clr[1], clr[2], clr[3], alpha)
    draw.Text(x, y, string)
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
local function hue2rgb(p, q, t)
    if (t < 0) then
        t = t + 1
    end
    if (t > 1) then
        t = t - 1
    end
    if (t < 1 / 6) then
        return p + (q - p) * 6 * t
    end
    if (t < 1 / 2) then
        return q
    end
    if (t < 2 / 3) then
        return p + (q - p) * (2 / 3 - t) * 6
    end
    return p
end
local function hslToRgb(h, s, l)
    local r, g, b

    if (s == 0) then
        r = l
        g = l
        b = l
    else
        local q = 0
        if (l < 0.5) then
            q = l * (1 + s)
        else
            q = l + s - l * s
        end

        local p = 2 * l - q

        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end
    return {r * 255, g * 255, b * 255}
end

local function clamp(val, min, max)
    if (val > max) then
        return max
    elseif (val < min) then
        return min
    else
        return val
    end
end

local logArray = {}
local logArray_time = {}
 
 
 
local attacker_name = ''
local dmg = 0
local victim = ''
local lefthp = 0
local hitbox = ''
local hitboxes = {"head","body","pelvis","left arm","right arm","right leg","left leg"}

--begin
local hit = 0
local shot = 0
local lastupdate = 0
local logArray = {
    hit = {

    },
    miss = {

    },
    dmg = {

    },
    victim = {

    },
    lefthp = {

    },
    hitbox = {

    },
    attacker = {

    },
    time = {

    },
    reason = {

    }
}
callbacks.Register( "FireGameEvent","EventHook", function(e)
    if ckb_hitlogs_switch:GetValue() == false then
        return
    end
    local En = e:GetName()
    
    if En == "player_hurt" then
        
        

        if client.GetPlayerNameByUserID(e:GetInt("attacker")) == entities.GetLocalPlayer():GetName() then 
            attacker_name = entities.GetByUserID(e:GetInt('attacker')):GetName()
            dmg = e:GetInt("dmg_health")
            victim = client.GetPlayerNameByUserID(e:GetInt("userid"))
            lefthp = e:GetInt("health")
            hitbox = hitboxes[e:GetInt("hitgroup")]
            
            table.insert( logArray.hit,'hit')
            table.insert( logArray.time,globals.FrameCount())
            table.insert( logArray.victim,victim)
            table.insert( logArray.dmg,dmg)
            table.insert( logArray.attacker,attacker_name)
            table.insert( logArray.lefthp,lefthp)
            table.insert( logArray.hitbox,hitbox)
            table.insert( logArray.reason,'')

            hit = hit + 1
           
        
        end
    end
        
        
    

    if En == "weapon_fire"  then
        
        
        if client.GetPlayerNameByUserID(e:GetInt("userid")) ~= entities.GetLocalPlayer():GetName() then 
            return 
        end 
        
        if entities.GetLocalPlayer():GetWeaponType() == 0 then 
            return 
        end
        
        shot = shot + 1 
        lastupdate = globals.FrameCount()        
    end    
end)

local reasons = {
    'spread',
    'resolve',
    'prediction',
}


local function hitlog()
    if ckb_hitlogs_switch:GetValue() == false then
        return
    end
    if (shot > hit and (globals.FrameCount() - lastupdate > 1)) then
        if (globals.FrameCount() - lastupdate > 1) then
          shot = 0;
          hit = 0;
        end
        table.insert( logArray.hit,"missed")
        table.insert( logArray.time,globals.FrameCount())
        table.insert( logArray.reason,reasons[math.random(1,#reasons)])
        table.insert( logArray.dmg, '?')
        table.insert( logArray.attacker, '?')
        table.insert( logArray.victim, "due to ("..reasons[math.random(1,#reasons)]..")")
        table.insert( logArray.hitbox, '?')
        table.insert( logArray.lefthp, '?')

    end
    


    for i = 1 ,#logArray.time do
        if logArray.time[i] == nil then return end
        if globals.FrameCount() - logArray.time[i] > 500 then
            table.remove( logArray.hit, i)
            table.remove( logArray.time, i)
            table.remove( logArray.dmg, i)
            table.remove( logArray.victim, i)
            table.remove( logArray.attacker, i)
            table.remove( logArray.reason, i)
            table.remove( logArray.hitbox, i)
            table.remove( logArray.lefthp, i)
        end
    end

    local x,y = posx_hitlogs:GetValue(),posy_hitlogs:GetValue()
    local time_1 = 100
    local time_2 = 400
    local speed = 3
    local length = 0
    local jiange = 0
    for j = 1, #logArray.time do
        if logArray.lefthp[j] == 0 then
            logArray.hit[j] = 'kill'
        end
        if comb_hitlogs_tpye:GetValue() == 1 then
            draw.SetFont(font1)
            length = time_1*speed*2 + draw.GetTextSize(logArray.hit[j] .. " ".." ("..logArray.hitbox[j]..")".." "..logArray.victim[j] .. " in the".." ("..logArray.hitbox[j]..")".." ("..logArray.dmg[j].."/"..logArray.lefthp[j]..")")
            x = posx_hitlogs:GetValue() - length/2
        elseif comb_hitlogs_tpye:GetValue() == 0 then
            length = time_1*speed*2 
            x = posx_hitlogs:GetValue() - length/2
        end
        if globals.FrameCount() - logArray.time[j] <time_1 then
            if logArray.hit[j] == 'kill' then
                renderer.text(x + (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{0,255,0,255},true,logArray.hit[j],font1)
            elseif logArray.hit[j] == 'hit' then
                renderer.text(x + (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{255,255,0,255},true,logArray.hit[j],font1)
            else
                renderer.text(x + (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{255,0,0,255},true,logArray.hit[j],font1)
            end
            draw.SetFont(font1)
            jiange = draw.GetTextSize(logArray.hit[j] .. " ")
            
            renderer.text(x +jiange+ (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{255,255,255,255},true," "..logArray.victim[j] .. " in the",font1)
            if logArray.hit[j] == 'kill' then
                draw.SetFont(font1)
                xxx1,yyy1 = draw.GetTextSize("  "..logArray.victim[j]) 
                draw.Color( 255 , 0 , 0 , 255 )
                draw.Line(x +jiange+ (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100+2,x +jiange+ (globals.FrameCount() - logArray.time[j])*speed+xxx1 ,y + 15*j +100 + yyy1-2)
            end
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" "..logArray.victim[j] .. " in the")
            renderer.text(x +jiange+ (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{255,0,0,255},true," ("..logArray.hitbox[j]..")",font1)
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" ("..logArray.hitbox[j]..")")
            renderer.text(x +jiange+ (globals.FrameCount() - logArray.time[j])*speed ,y + 15*j +100,{255,255,255,255},true," ("..logArray.dmg[j].."/"..logArray.lefthp[j]..")",font1)
            

        elseif (globals.FrameCount() - logArray.time[j]) >time_1 and (globals.FrameCount() - logArray.time[j]) <time_2 then
            if logArray.hit[j] == 'kill' then
                renderer.text(x +time_1*speed ,y + 15*j +100,{0,255,0,255},true,logArray.hit[j],font1)
            elseif logArray.hit[j] == 'hit' then
                renderer.text(x +time_1*speed ,y + 15*j +100,{255,255,0,255},true,logArray.hit[j],font1)
            else
                renderer.text(x +time_1*speed ,y + 15*j +100,{255,0,0,255},true,logArray.hit[j],font1)
            end
            
            draw.SetFont(font1)
            jiange = draw.GetTextSize(logArray.hit[j] .. " ")
            
            renderer.text(x +jiange+ time_1*speed ,y + 15*j +100,{255,255,255,255},true," "..logArray.victim[j] .. " in the",font1)
            if logArray.hit[j] == 'kill' then
                draw.SetFont(font1)
                xxx1,yyy1 = draw.GetTextSize("  "..logArray.victim[j]) 
                draw.Color( 255 , 0 , 0 , 255 )
                draw.Line(x +jiange+ time_1*speed ,y + 15*j +100+2,x +jiange+ time_1*speed +xxx1,y + 15*j +100+yyy1-2)
            end
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" "..logArray.victim[j] .. " in the")
            renderer.text(x +jiange+ time_1*speed ,y + 15*j +100,{255,0,0,255},true," ("..logArray.hitbox[j]..")",font1)
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" ("..logArray.hitbox[j]..")")
            renderer.text(x +jiange+ time_1*speed ,y + 15*j +100,{255,255,255,255},true," ("..logArray.dmg[j].."/"..logArray.lefthp[j]..")",font1)
            

        elseif (globals.FrameCount() - logArray.time[j]) >time_2 then
            if logArray.hit[j] == 'kill' then
                renderer.text(x + time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{0,255,0,255},true,logArray.hit[j],font1)
            elseif logArray.hit[j] == 'hit' then
                renderer.text(x + time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{255,255,0,255},true,logArray.hit[j],font1)
            else
                renderer.text(x + time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{255,0,0,255},true,logArray.hit[j],font1)
            end
            draw.SetFont(font1)
            jiange = draw.GetTextSize(logArray.hit[j] .. " ")
            renderer.text(x +jiange +  time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{255,255,255,255},true," "..logArray.victim[j] .. " in the",font1)
            if logArray.hit[j] == 'kill' then
                draw.SetFont(font1)
                xxx1,yyy1 = draw.GetTextSize("  "..logArray.victim[j]) 
                draw.Color( 255 , 0 , 0 , 255 )
                draw.Line(x +jiange +  time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100+2,x +jiange +  time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed +xxx1,y + 15*j +100+yyy1-2)
            end
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" "..logArray.victim[j] .. " in the")
            renderer.text(x +jiange+ time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{255,0,0,255},true," ("..logArray.hitbox[j]..")",font1)
            
            draw.SetFont(font1)
            jiange = jiange + draw.GetTextSize(" ("..logArray.hitbox[j]..")")
            renderer.text(x +jiange+ time_1*speed + (globals.FrameCount()-time_2 - logArray.time[j])*speed ,y + 15*j +100,{255,255,255,255},true," ("..logArray.dmg[j].."/"..logArray.lefthp[j]..")",font1)
        end
        
    end
end
callbacks.Register( "Draw", "hitlog", hitlog)





--***********************************************--

print("??? " .. GetScriptName() .. " loaded without Errors ???")

