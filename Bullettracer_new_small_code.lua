local VIS_REF = gui.Reference("Visuals", "World", "Extra")
local tracer_enable = gui.Checkbox(VIS_REF, "tracer_enabled", "Enable bullet tracer for localplayer", true)
local tracer_duration = gui.Slider(VIS_REF, "tracer_duration", "Duration of bullet tracer (in seconds)", 2, 0, 60)
local colors =  {{255,0,0}, {0,255,0}, {0,255,255}}
local tracers = {}


local function FireGameEvent(e)
 if not tracer_enable:GetValue() then return end
    if (e:GetName() == "bullet_impact") then
        local shooter = entities.GetByUserID(e:GetInt("userid"))
        if shooter and shooter:GetName() == entities.GetLocalPlayer():GetName() then
            local hit_pos = Vector3(e:GetFloat("x"), e:GetFloat("y"), e:GetFloat("z"))
 local pos = entities.GetLocalPlayer():GetHitboxPosition(1) -- head
 
 table.insert(tracers, {
 hit_pos = hit_pos,
 lp_pos = pos,
 color = colors[ math.random(#colors)],
 time = globals.CurTime()
 })
 
        end
 end
end

local function draw_tracers()
 if not tracer_enable:GetValue() then return end
 for i, v in ipairs(tracers) do
 if globals.CurTime() < v.time + tracer_duration:GetValue() then
 local x, y = client.WorldToScreen( v.hit_pos )
 local x2, y2 = client.WorldToScreen( v.lp_pos ); 
 if x and x2 and y and y2 then
 -- tracers[i].cache = {x=x,y=y,x2=x2,y2=y2}
 draw.Color(unpack(v.color))
 draw.Line(x,y,x2,y2)
 end
 else
 table.remove(tracers, i)
 end
 end
end

client.AllowListener("bullet_impact")
client.AllowListener("player_hurt")
callbacks.Register("FireGameEvent", "FireGameEvent", FireGameEvent)
callbacks.Register("Draw", "draw_tracers", draw_tracers)



 







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

