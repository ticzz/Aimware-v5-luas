--[=====[
    Rainbow Spread Crosshair Made by Rab(SamzSakerz#4758)
             __        __
            |__)  /\  |__)
            |  \ /~~\ |__)
       __   __   ___      ___  ___
      /  ` |__) |__   /\   |  |__
      \__, |  \ |___ /~~\  |  |___
               ___  __           ___     ___
|  | |__|  /\   |  /__`    |\ | |__  \_/  |
|/\| |  | /~~\  |  .__/    | \| |___ / \  |

--]=====]

local a,b,c,d,e,f,g,h,i,j,select,pcall=callbacks.Register,draw.Color,draw.GetScreenSize,draw.Line,entities.GetLocalPlayer,globals.RealTime,math.cos,math.floor,math.rad,math.sin,select,pcall;local function k(l,m)return h(j((f()+l)*m)*127+128),h(j((f()+l)*m+2)*127+128),h(j((f()+l)*m+4)*127+128),255 end;local function n(o,p,q)local r,s;for t=0,360,10 do local u,v=o+q*g(i(t)),p+q*j(i(t))if u and r then b(k(t,10))d(u,v,r,s)end;r,s=u,v end end;a("Draw",function()pcall(function()n(c()/2,select(2,c())/2,e():GetPropEntity("m_hActiveWeapon"):GetWeaponInaccuracy()*1000)end)end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

