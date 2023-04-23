local active = gui.Checkbox( gui.Reference( 'Visuals', 'World', 'Nade' ), 'esp.world.grenadeowner', 'Grenade Owner', 0 )
active:SetDescription('Shows owner of Smokes and Decoys')
local cb = gui.Combobox( gui.Reference( 'Visuals', 'World', 'Nade' ), 'esp.world.grenadeowner.types', 'Grenades', 'Decoys', 'Smokes', 'Infernos', 'All'  )
cb:SetDescription('Choose which Grenades should be shown')
local FindByClass, GetLocalPlayer, Text, Color, WorldToScreen, CurTime, format, GetTextSize = entities.FindByClass, entities.GetLocalPlayer, draw.Text, draw.Color, client.WorldToScreen, globals.CurTime, string.format, draw.GetTextSize
local throwername = {}
local inferno, dur = {}, 6.8

local function draw_decoys(team, index)
    if (not active:GetValue() or GetLocalPlayer == nil or cb:GetValue() == 1 or cb:GetValue() == 2) then return end
    local decoys = FindByClass('CDecoyProjectile')

    for i=1, #decoys do
        local decoy = decoys[i]
        local pX, pY, pZ = decoy:GetAbsOrigin()
        local tX, tY = WorldToScreen( pX, pY, pZ )
        if tX ~= nil then
            local thrower = decoy:GetPropEntity('m_hThrower')

            if thrower:GetIndex() == index then
                Color(255, 255, 255)
                Text(tX - 35, tY, 'Own Decoy')
            else
                local bX, bY = WorldToScreen( pX, pY, pZ )

                if thrower:GetTeamNumber() == team then
                    Color(0, 255, 42)
                    Text(bX, bY, 'Teammate '.. client.GetPlayerNameByIndex( thrower:GetIndex() ))
                    Text(tX, tY - 22, 'Decoy')
                else
                    Color(255, 0, 25)
                    Text(bX, bY, 'Enemy '.. client.GetPlayerNameByIndex( thrower:GetIndex() ))
                    Text(tX, tY - 22, 'Decoy')
                end
            end
        end
    end
end

local function draw_smokes(team, index)
    if (not active:GetValue() or GetLocalPlayer == nil or cb:GetValue() == 0 or cb:GetValue() == 2)  then return end
    local smokes = FindByClass('CSmokeGrenadeProjectile')

    for i=1, #smokes do
        local smoke = smokes[i]
        local pX, pY, pZ = smoke:GetAbsOrigin()
        local tX, tY = WorldToScreen( pX, pY, pZ )
        if tX ~= nil then
            local thrower = smoke:GetPropEntity('m_hThrower')

            if thrower:GetIndex() == index then
                Color(255, 255, 255)
                Text(tX - 38, tY, 'Own Smoke')
            else
                local bX, bY = WorldToScreen( pX, pY, pZ )

                if thrower:GetTeamNumber() == team then
                    Color(0, 255, 42)
                    Text(bX, bY, 'Teammate '.. client.GetPlayerNameByIndex( thrower:GetIndex() ))
                    Text(tX, tY - 22, 'Smoke')
                else
                    Color(255, 0, 25)
                    Text(bX, bY, 'Enemy '.. client.GetPlayerNameByIndex( thrower:GetIndex() ))
                    Text(tX, tY - 22, 'Smoke')
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
    if (not active:GetValue() or GetLocalPlayer == nil or cb:GetValue() == 0 or cb:GetValue() == 1)  then return end
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
    if (not active:GetValue() or GetLocalPlayer == nil or cb:GetValue() == 0 or cb:GetValue() == 1)  then return end
    local lp = GetLocalPlayer()
    for i=1, #inferno do
        local fire = inferno[i]
       
        local left = fire.duration - CurTime()
        if left >= 0 then
            local X, Y = WorldToScreen(fire.position)
            local text = 'Fire - '.. format('%.1f', left)
            local tW, tH = GetTextSize(text)
            Text(X - (tW*0.5), Y, text)
            Text(X - 18, Y - 20, throwername[1])
        end
    end
end


client.AllowListener( "inferno_startburn" )
callbacks.Register('FireGameEvent', event)
callbacks.Register('Draw', on_draw)

callbacks.Register('Draw', function()
    local lp = entities.GetLocalPlayer()
    local my_index = lp:GetIndex()
    local my_team = lp:GetTeamNumber()

    draw_decoys(my_team, my_index)
    draw_smokes(my_team, my_index)
end)