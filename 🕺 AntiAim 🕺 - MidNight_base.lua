--this is kinda messy atm sorry about that i norm just do the stuff then clean the code up and aimware does some lua stuff that i dont like what makes alot of stuff more messy

local rage_reff = gui.Reference("Ragebot")

--handle menu font
local debugFont = draw.CreateFont( "Tahoma", 60 );

--handle menu crap
local wnd_luatest = gui.Tab( rage_reff,"midnight.tab.title", "MidNight");
local tab_groupbox = gui.Groupbox( wnd_luatest , "Settings", 10, 10, 300, 500)
local lua_combobox = gui.Combobox( tab_groupbox, "lua_combobox", "LBY Modify ", "None", "Inward", "Outward" );
--local lua_Pitch = gui.Combobox( tab_groupbox, "lua_Pitch", "Anti-Aaim Pitch", "None", "Pitch up", "Pitch down" );
local lua_DesyncType = gui.Combobox( tab_groupbox, "lua_DesyncType", "Desync Type", "None", "Micro static", "LBY flick" );
local lua_DesyncAmount = gui.Slider( tab_groupbox, "lua_DesyncAmount", "Desync Amount", 0, 0, 120 );
local lua_BreakDelta = gui.Slider( tab_groupbox, "lua_BreakDelta", "Break Delta", 0, 0, 180 );
local lua_checkbox = gui.Checkbox( tab_groupbox, "lua_checkbox", "Fake Desync", false );

--wnd_luatest:SetOpenKey(45);

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

--handle our local calls false or true
local g_inverse = false
local g_flFreazeTime = false
local m_bBreaklby = false
local m_bPreBreak = false

--handle our local calls =
local m_flNextLBYUpdateTime = 0
local m_flSpeed = 0

--handle local stuff i made

local Rim = {}

function Rim:Ticks_to_time(m_bTimeAhead)
    return globals:TickInterval() * m_bTimeAhead -- not sure if * works the same as c++ does but cant be f atm to check
end

function Rim:m_flBreakTime(Time_ahead)
    return globals.CurTime() + Rim:Ticks_to_time(Time_ahead) > m_flNextLBYUpdateTime -- i love this
end

function hasbit(x, p)
    return x % (p + p) >= p       
end

function Rim:AngleNormalize(angle)-- hmmm yeah i dont like lua

    angle = math.fmod(angle, 360)
    if angle > 180 then
        angle = angle - 360 --360
    end
    if angle < -180 then
        angle = angle + 360 --360
    end
    return angle --- 360
end

--handle our freetime
--function FireGameEvent ( Event )
--    local player = entities.GetLocalPlayer()
--    if ( Event:GetName() == 'round_prestart' ) then
--    g_flFreazeTime = true
--    elseif ( Event:GetName() == 'round_freeze_end' or Event:GetName() == 'game_newmap' ) then
--    g_flFreazeTime = false
--    end
--end
--
--client.AllowListener( 'round_prestart' );
--client.AllowListener( 'round_freeze_end' );
--client.AllowListener( 'game_newmap' );
--callbacks.Register( 'FireGameEvent', 'FireGameEvent', FireGameEvent );

--handle our pitch
local function m_flPitch(cmd)
    if lua_Pitch:GetValue() == 0 then
      return cmd.aimdirection.pitch
    elseif lua_Pitch:GetValue() == 1 then
      return -89   
	elseif lua_Pitch:GetValue() == 2 then
       return 89
    end							-- aimdirection
end

--handle our real yaw
local function m_flRealYaw(cmd)

end

local function sidemove(cmd, pitch)

    local m_flDuckAmount = get_local_player():GetPropFloat("m_flDuckAmount")

    if m_flDuckAmount == nil then return end

    if m_flDuckAmount then
       m_flSpeed = 3.3
    else
       m_flSpeed = 1.01
    end
    -- this fixes when we move and wont fuck up with stuff like walkbot etc
    if math.abs(cmd.forwardmove) < 1.2 and math.abs(cmd.sidemove) < 1.2  then  
       if g_inverse then
          cmd.forwardmove = m_flSpeed
       elseif not g_inverse then
          cmd.forwardmove = -m_flSpeed
       end
    end

    --basicly 
    g_inverse = not g_inverse

    if cmd.sendpacket == false then
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 60, 0)
    elseif cmd.sendpacket == true then
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + 180, 0)
    end

end

local function lbyBreak(cmd, pitch)
    
    -- idk why we have non lby low delta simetimes
    -- use angle norm to cal our angles for us but this way = gay tho
    local m_flBreakAngle = Rim:AngleNormalize(180 + lua_BreakDelta:GetValue())
	local m_flPreAngle = Rim:AngleNormalize(m_flBreakAngle + 170.0)
	local m_flFakeYaw = Rim:AngleNormalize(180 + lua_DesyncAmount:GetValue())

    if m_bBreaklby then
       --cmd:SetSendPacket(false) --choke the flick idk why its still visible f
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flBreakAngle, 0)
       m_bBreaklby = false
    elseif m_bPreBreak then
       --cmd:SetSendPacket(false) 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flPreAngle, 0)
       m_bPreBreak = false
    elseif cmd.sendpacket == false then 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + m_flFakeYaw, 0)
    elseif cmd.sendpacket == true then 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 180, 0)
    end

end

callbacks.Register("CreateMove", function(cmd)

    --dont run if in freaze time
    --if g_flFreazeTime then return end

    --dont run if clicking e or holding or in_attack
    
    if hasbit(cmd.buttons, 1) then return end -- in_attack check
	if hasbit(cmd.buttons, 32) then return end -- E button check
	if IsButtonPressed( 1 ) then return end
	if IsButtonPressed( 69 ) then return end
	
    --dont run if micro static or non
    if lua_DesyncType:GetValue() == 1 then sidemove(cmd, pitch) return end
    if lua_DesyncType:GetValue() == 0 then return end

    local Velocity = get_local_player():GetPropFloat("localdata", "m_vecVelocity[0]")

    --dont run if Velocity = nil
    if Velocity == nil then return end

    if Velocity > 0.1 then
       m_flNextLBYUpdateTime = globals.CurTime() + 0.22
    else
       if Rim:m_flBreakTime(0) then
          m_flNextLBYUpdateTime = globals.CurTime() + 1.1
          m_bBreaklby = true
          cmd:SetSendPacket(false)
          elseif Rim:m_flBreakTime(1) then -- allows us to do low delta desync
          m_bPreBreak = true
          cmd:SetSendPacket(false)
          elseif Rim:m_flBreakTime(2) then
          cmd:SetSendPacket(true)
       end
       --not gonna do preflick atm
    end

    lbyBreak(cmd, pitch)

end)

local function lbyBreak(cmd, pitch)
    
    -- idk why we have non lby low delta simetimes
    -- use angle norm to cal our angles for us but this way = gay tho
    local m_flBreakAngle = Rim:AngleNormalize(180 + lua_BreakDelta:GetValue())
	local m_flPreAngle = Rim:AngleNormalize(m_flBreakAngle + 170.0)
	local m_flFakeYaw = Rim:AngleNormalize(180 + lua_DesyncAmount:GetValue())

    if m_bBreaklby then
       --cmd:SetSendPacket(false) --choke the flick idk why its still visible f
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flBreakAngle, 0)
       m_bBreaklby = false
    elseif m_bPreBreak then
       --cmd:SetSendPacket(false) 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - m_flPreAngle, 0)
       m_bPreBreak = false
    elseif cmd.sendpacket == false then 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw + m_flFakeYaw, 0)
    elseif cmd.sendpacket == true then 
       cmd.viewangles = EulerAngles(pitch, cmd.viewangles.yaw - 180, 0)
    end

end



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
           gui.SetValue("rbot.antiaim.desync", 1)
           gui.SetValue("rbot.antiaim.desyncleft", 1)
           gui.SetValue("rbot.antiaim.desyncright", 1)
           gui.SetValue("rbot.antiaim.yaw", 179)
       else
           gui.SetValue("rbot.antiaim.desync", 0)
           gui.SetValue("rbot.antiaim.desyncleft", 0)
           gui.SetValue("rbot.antiaim.desyncright", 0)
           gui.SetValue("rbot.antiaim.yaw", 180)
       end
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

