font3 = draw.CreateFont("Verdana", 40)


local active = gui.Checkbox( gui.Reference( 'Visuals', 'World', 'Nade' ), 'esp.world.grenadewarning', 'Grenade Warning', 1 )
local FindByClass, GetLocalPlayer, Text, Color, WorldToScreen, CurTime, format, GetTextSize = entities.FindByClass, entities.GetLocalPlayer, draw.Text, draw.Color, client.WorldToScreen, globals.CurTime, string.format, draw.GetTextSize
local throwername = {}
local inferno, dur = {}, 6.8



local function draw_hegrenade(team, index)
 if not active:GetValue() then return end
 local Grenades = FindByClass('CBaseCSGrenadeProjectile')
 local throws_in_distance = {};
 for i=1, #Grenades do
        local grenade = Grenades[i]
        local pX, pY, pZ = grenade:GetAbsOrigin()
		
        local tX, tY = WorldToScreen( pX, pY, pZ )
        if tX ~= nil then
            local thrower = grenade:GetPropEntity('m_hThrower')
            if thrower:GetIndex() == index then
 draw.Color(23,23,23,255);
 draw.FilledCircle( tX, tY, 20 )	
 draw.Color(128,128,128,255);
 draw.OutlinedCircle( tX, tY, 20)	
 draw.Color(255,255,0,255);
 draw.SetFont(font3)
 Text(tX - 7, tY - 12, '!')	
    else
    local bX, bY = WorldToScreen( pX, pY, pZ )

                if thrower:GetTeamNumber() == team then
 draw.Color(23,23,23,255);
 draw.FilledCircle( tX, tY, 20 )	
 draw.Color(128,128,128,255);
 draw.OutlinedCircle( tX, tY, 20)
  draw.Color(255,255,0,255);
  draw.SetFont(font3)
 Text(tX - 7, tY - 12, '!')
                else
 draw.Color(23,23,23,255);
 draw.FilledCircle( tX, tY, 20 )	
 draw.Color(128,128,128,255);
 draw.OutlinedCircle( tX, tY, 20)	
  draw.Color(255,255,0,255);
  draw.SetFont(font3)
 Text(tX - 7, tY - 12, '!')
                end
            end
        end
    end
 
end

callbacks.Register( 'FireGameEvent', function(e)
 if e:GetName() == 'grenade_thrown' then
 if e:GetString('weapon') == 'incgrenade' or e:GetString('weapon') == 'molotov' then
 local throwerid = e:GetInt('userid')
 table.insert(throwername, client.GetPlayerNameByUserID( throwerid ))
 if e:GetName() == 'inferno_extinguish' or e:GetName() == 'inferno_expire' then
 table.remove(throwername, 1) 
 inferno = {};
 left = 0;
 end
 end
 end
end)

local function event(e)
 if (not active:GetValue()) then return end
    if e:GetName() == 'inferno_startburn' then
        inferno[#inferno + 1] = {
            position = Vector3(e:GetFloat('x'), e:GetFloat('y'), e:GetFloat('z')),
            duration = CurTime() + dur
        }
 end
 if e:GetName() == 'round_prestart' then
 inferno = {};
 left = 0;
 end
end

local function on_draw()
 if (not active:GetValue()) then return end
 local lp = GetLocalPlayer()
    for i=1, #inferno do
        local fire = inferno[i]
        
        local left = fire.duration - CurTime()
        if left >= 0 then
 local X, Y = WorldToScreen(fire.position)
 local text = '!'
 local tW, tH = GetTextSize(text)
 draw.Color(23,23,23,255);
 draw.FilledCircle( X, Y, 20 )	
 draw.Color(128,128,128,255);
 draw.OutlinedCircle( X, Y, 20)
 draw.Color(255,255,0,255);
 draw.SetFont(font3)
 Text(X - 7, Y - 12, text)
 end
 end
end


client.AllowListener( "inferno_startburn" )
callbacks.Register('FireGameEvent', event)
callbacks.Register('Draw', on_draw)

callbacks.Register('Draw', function()
 local lp = entities.GetLocalPlayer()
	if not lp then return end;

    local my_index = lp:GetIndex()
    local my_team = lp:GetTeamNumber()
	
	draw_hegrenade(my_team, my_index)
end)