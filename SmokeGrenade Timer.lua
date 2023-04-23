local entity_get = entities.FindByClass
local tickcount = globals.TickCount
local tickinterval = globals.TickInterval
local w2s = client.WorldToScreen
local duration = 18

local function SmokeTimer()

   local smoke_grenades = entity_get("CSmokeGrenadeProjectile")
   local tick_current = tickcount()
   local seconds_per_tick = tickinterval()

   for i=1, #smoke_grenades do
       local smoke_grenade = smoke_grenades[i]
 if ("******") then
  local ticks = smoke_grenade:GetProp("m_nSmokeEffectTickBegin")
           local time_since_explosion = seconds_per_tick * (tick_current - ticks)
           if time_since_explosion > 0 and time_since_explosion < duration +1 then
local x, y, z = smoke_grenade:GetProp("m_vecOrigin")
               local worldX, worldY = w2s(x, y, z)
               if worldX ~= nil then
                   local progress = 1 - time_since_explosion / duration

draw.Color(255,20 + progress * 235,20 + progress * 235,255)
message = string.format("%.1f s", duration-time_since_explosion)
draw.TextShadow(worldX, worldY, message)

               end
           end
       end
   end
end

callbacks.Register( "Draw", "SmokeTimer", SmokeTimer );
