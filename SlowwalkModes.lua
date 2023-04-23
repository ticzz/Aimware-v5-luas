--Slow Walk Mode by lntranets

--references
local slowwalkspeed = 'rbot.accuracy.movement.slowspeed'
local choose = gui.Reference('Ragebot', 'Accuracy', 'Movement')
local activate = gui.Checkbox( choose, 'activate_sw', 'Use Lua Slow Walk', false )
local swcombo = gui.Combobox( choose, 'sw_combobox', 'Slow Walk Modes', 'Favor Anti-Aim', 'Favor Speed')
local x, y = draw.GetScreenSize()
x = x * 0.5;
y = y * 0.51;

--handle slowwalk
local function slowwalkhandle()
 if activate:GetValue() then

 if swcombo:GetValue() == 0 then
 gui.SetValue(slowwalkspeed, 5)

 elseif swcombo:GetValue() == 1 then
 gui.SetValue(slowwalkspeed, 30)
 end
 else return
 end
end
callbacks.Register('CreateMove', slowwalkhandle)

--draw speed
local function speed()
 local swsped = gui.GetValue(slowwalkspeed)
 if activate:GetValue() then
        draw.TextShadow(x, y, swsped .. ' Movement Speed')
 end
end
callbacks.Register('Draw', 'speed', speed)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

