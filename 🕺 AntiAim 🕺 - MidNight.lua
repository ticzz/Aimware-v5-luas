--handle menu font
local debugFont = draw.CreateFont( "Tahoma", 60 );

--handle menu crap
local wnd_luatest = gui.Window( "wnd_luatest", "MidNight", 300, 200, 500, 430 );

-- thenks ticzz
wnd_luatest:SetOpenKey(45);

local lua_combobox = gui.Combobox( wnd_luatest, "lua_combobox", "LBY Modify ", "None", "Inward", "Outward" );
local lua_Pitch = gui.Combobox( wnd_luatest, "lua_Pitch", "Anti-Aaim Pitch", "None", "Pitch up", "Pitch down" );
local lua_DesyncType = gui.Combobox( wnd_luatest, "lua_DesyncType", "Desync Type", "None", "Micro static", "LBY flick", "Opposite" );
local lua_Static = gui.Checkbox( wnd_luatest, "lua_Static", "Static lby offset", false );
lua_Static:SetDescription("user higher fakelag. dont user above server max")
--local lua_Inverter = gui.Keybox( wnd_luatest, "lua_Inverter", "Inverter Key", 0 )
local lua_Inverter = gui.Checkbox( wnd_luatest, "lua_Inverter", "Inverter", false );
--idk how aimware menu works fully yet f
--if lua_DesyncType:GetValue() == 3 then
local lua_DesyncAmount = gui.Slider( wnd_luatest, "lua_DesyncAmount", "Desync Amount", 0, 0, 120 );
local lua_BreakDelta = gui.Slider( wnd_luatest, "lua_BreakDelta", "Break Delta", 0, 0, 180 );
--end
local lua_checkbox = gui.Checkbox( wnd_luatest, "lua_checkbox", "Fake Desync", false );

--set our font
local function OnDraw()
    draw.SetFont( debugFont );
end

callbacks.Register( "Draw", "LuaGuiTest", OnDraw);

--handle our local functions
local function get_local_player()
    local player = entities.GetLocalPlayer()
    if player == nil then return end
    return player
end

local g_flFreazeTime = false

--handle our info we need
local info = {
    m_flNextLBYUpdateTime = 0,
    m_flSpeed = 0,
    m_bPreBreak = false,
    m_bBreaklby = false,
    g_inverse = false,
    m_flInvert = 1
}

function info:Ticks_to_time(m_bTimeAhead)
    return globals:TickInterval() * m_bTimeAhead -- not sure if * works the same as c++ does but cant be f atm to check
end

function info:m_flBreakTime(Time_ahead)
    return globals.CurTime() + info:Ticks_to_time(Time_ahead) > info.m_flNextLBYUpdateTime -- i love this
end

function hasbit(x, p)
    return x % (p + p) >= p      
end

function info:AngleNormalize(angle)-- hmmm yeah i dont like lua

    angle = math.fmod(angle, 360)
    if angle > 180 then
        angle = angle - 360
    end
    if angle < -180 then
        angle = angle + 360
    end
    return angle -- 360
end

--handle our freetime
function FireGameEvent( Event )
    local player = entities.GetLocalPlayer()
    if ( Event:GetName() == 'round_prestart' ) then
    g_flFreazeTime = true
    elseif ( Event:GetName() == 'round_freeze_end' or Event:GetName() == 'game_newmap' ) then
    g_flFreazeTime = false
    end
end

client.AllowListener( 'round_prestart' );
client.AllowListener( 'round_freeze_end' );
client.AllowListener( 'game_newmap' );
callbacks.Register( 'FireGameEvent', 'FireGameEvent', FireGameEvent );

--handle our pitch
local function m_flPitch(cmd)
    if lua_Pitch:GetValue() == 0 then
      return cmd.viewangles.pitch
    elseif lua_Pitch:GetValue() == 1 then
      return -89
    elseif lua_Pitch:GetValue() == 2 then
      return 89
    end
end

--handle our real yaw
local function m_flRealYaw(cmd)

end

local function HandleInvert()
    if lua_Inverter:GetValue() then
      m_flInvert = -1
    else
      m_flInvert = 1
    end

    --200 iq inverter

    --if m_flInvert > 0 and input.IsButtonPressed(lua_Inverter:GetValue()) then
      -- m_flInvert = -1
    --elseif m_flInvert < 0 and input.IsButtonPressed(lua_Inverter:GetValue()) then
      --m_flInvert = 1
    --end

end

local function m_flSideMove(cmd)

    local m_flDuckAmount = get_local_player():GetPropFloat("m_flDuckAmount")

    if m_flDuckAmount == nil then return end

    if m_flDuckAmount then
      info.m_flSpeed = 3.3
    else
      info.m_flSpeed = 1.1
    end

    if math.abs(cmd.forwardmove) < 1.2 and math.abs(cmd.sidemove) < 1.2  then  
      if info.g_inverse then
          cmd.forwardmove = info.m_flSpeed
      elseif not info.g_inverse then
          cmd.forwardmove = -info.m_flSpeed
      end
    end
end

local function sidemove(cmd, pitch)

    if lua_Inverter:GetValue() then
      m_flInvert = -1
    else
      m_flInvert = 1
    end

    if lua_Static:GetValue() and cmd.sendpacket == false then
      m_flSideMove(cmd)
    elseif lua_Static:GetValue() == false and cmd.sendpacket == true then
      m_flSideMove(cmd)
    end

    --basicly 
    info.g_inverse = not info.g_inverse

    if cmd.sendpacket == false then
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 60 * m_flInvert , 0)
    elseif cmd.sendpacket == true then
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + 180, 0)
    end

end

local function lbyPreBreak(cmd, pitch)
    
    -- idk why we have non lby low delta simetimes
    -- use angle norm to cal our angles for us but this way = gay tho
    local m_flBreakAngle = info:AngleNormalize(180 + lua_BreakDelta:GetValue())
local m_flPreAngle = info:AngleNormalize(m_flBreakAngle + 170.0)
local m_flFakeYaw = info:AngleNormalize(180 + lua_DesyncAmount:GetValue())

    if info.m_bBreaklby then
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flBreakAngle * m_flInvert , 0)
      info.m_bBreaklby = false
    elseif info.m_bPreBreak then
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flPreAngle * m_flInvert , 0)
      info.m_bPreBreak = false
    elseif cmd.sendpacket == false then 
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + m_flFakeYaw * m_flInvert , 0)
    elseif cmd.sendpacket == true then 
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 180, 0)
    end

end

local function lbyBreakOpposite(cmd, pitch)
  
    if info.m_bBreaklby then
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 60 * m_flInvert , 0)
      info.m_bBreaklby = false
    elseif cmd.sendpacket == false then 
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + 60 * m_flInvert , 0)
    elseif cmd.sendpacket == true then 
      cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 180, 0)
    end

end

callbacks.Register("CreateMove", function(cmd)

    --dont run if in freaze time
    if g_flFreazeTime then return end

    local WeaponType = get_local_player():GetWeaponType()

    if WeaponType == 9 then return end --disable on WeaponType = grenade

    --dont run if clicking e or holding or in_attack
    if hasbit(cmd.buttons, 32) then return end -- E button check
    if hasbit(cmd.buttons, 2048) then return end -- in_attack2 check oh god help me if this changes ever
    if hasbit(cmd.buttons, 1) then return end -- in_attack check

    HandleInvert()

    --dont run if micro static or non
    if lua_DesyncType:GetValue() == 1 then sidemove(cmd, m_flPitch(cmd)) return end
    if lua_DesyncType:GetValue() == 0 then return end

    --local Velocity = get_local_player():GetPropFloat("localdata", "m_vecVelocity[0]")
    local Velocity = Vector3(get_local_player():GetPropFloat("localdata", "m_vecVelocity[0]"), get_local_player():GetPropFloat("localdata", "m_vecVelocity[1]"), get_local_player():GetPropFloat("localdata", "m_vecVelocity[2]")):Length2D()

    --dont run if Velocity = nil
    if Velocity == nil then return end

    if Velocity > 0.1 then
      info.m_flNextLBYUpdateTime = globals.CurTime() + 0.22
    else
      if info:m_flBreakTime(0) then
          info.m_flNextLBYUpdateTime = globals.CurTime() + 1.1
          info.m_bBreaklby = true
          cmd:SetSendPacket(false) --
      elseif info:m_flBreakTime(1) then -- allows us to do low delta desync
          info.m_bPreBreak = true
          cmd:SetSendPacket(false)
      elseif info:m_flBreakTime(2) then --we only wanna do this on preflick desync so we dont stuff up other lby desyncs
          cmd:SetSendPacket(true)
      end
    end

    if lua_DesyncType:GetValue() == 2 then 
      --preflick lby desync
      lbyPreBreak(cmd, m_flPitch(cmd))
    elseif lua_DesyncType:GetValue() == 3 then
      --opposite desync
      lbyBreakOpposite(cmd, m_flPitch(cmd))
    end

end)

callbacks.Register("CreateMove", function(cmd)

    -- f cheat resolvers hard buit idk if it does now tho and counting this is aimware
    if math.abs(cmd.forwardmove) < 1.2 and math.abs(cmd.sidemove) < 1.2  then    
        if lua_combobox:GetValue() == 1 then
            if globals.TickCount( ) % 8 == 0 then
                cmd.forwardmove = 1.01
            end
        elseif lua_combobox:GetValue() == 2 then
            if globals.TickCount( ) % 9 == 0 then
                cmd.forwardmove = 1.01
            end
        end
    end

end)

callbacks.Register("Draw", function()
  if lua_checkbox:GetValue() then
      if globals.TickCount() % 7 == 0 then
          gui.SetValue("rbot.antiaim.base.rotation", 1)
          gui.SetValue("rbot.antiaim.left.rotation", 1)
          gui.SetValue("rbot.antiaim.right.rotation", 1)
          gui.SetValue("rbot.antiaim.base", "179 Desync")
      else
          gui.SetValue("rbot.antiaim.base.rotation", 0)
          gui.SetValue("rbot.antiaim.left.rotation", 0)
          gui.SetValue("rbot.antiaim.right.rotation", 0)
          gui.SetValue("rbot.antiaim.base", "180 Desync")
      end
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

