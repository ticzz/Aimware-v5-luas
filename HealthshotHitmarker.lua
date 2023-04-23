-- aimware.net/forum/thread-116236.html

hsounds = {"bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakhit.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Mediumimpact.wav"}
ksounds = {"bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakded.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Hardimpact.wav"}

local killsays = {
   [1] = "1 sniff",
   [2] = "1 nn",
   [3] = "n1",
   [4] = "rip",
   [5] = "Fat nn",
   [6] = "sit dog",
   [7] = "ah",

}
local activeFovs = {};

local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime
local ref = gui.Reference("Misc", "Enhancement")

local msc_ref = gui.Groupbox(ref, "Healthshot hitsound", 328,313, 296,400)
local allenabled = gui.Checkbox(msc_ref, 'lua_healthshot_hitsound_enabled', 'Hitsound/marker lua enabled', 1)

local hitcross = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_enabled', 'Enable crosshair marker', 0)
local hitmarkerColor = gui.ColorPicker(hitcross, "lua_healthshot_hitcross_color", "", 255, 165, 10, 255);
hitcross:SetDescription("Drawing a marker on the center of screen") 
local linesize = gui.Slider(msc_ref, 'lua_healthshot_hitcross_slider', 'Crosshair marker size', 15, 1, 30)
local hitcrossrotate = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_rotated', 'Rotate marker by 45', 0)

local killssounds = gui.Combobox(msc_ref, 'lua_healthshot_killsound_combobox', 'Killsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact (loud)")
killssounds:SetDescription("Overrides the headshot and hit sound on kill")
local hssounds = gui.Combobox(msc_ref, 'lua_healthshot_hssounds_combobox', 'Headshot sound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")
hssounds:SetDescription("Overrides the hitsound on HS")
local hitssounds = gui.Combobox(msc_ref, 'lua_healthshot_hitsound_combobox', 'Hitsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")
local Healthshot = gui.Combobox(msc_ref, 'lua_healthshot_hitmarker_combobox', 'Healthshot hitmarker', 'Off', 'On hit', 'On kill')
local slider = gui.Slider(msc_ref, 'lua_healthshot_hitmarker_slider', 'Healthshot duration (sec)', 1, 0, 10)

local FOVenabled = gui.Checkbox(msc_ref, 'lua_healthshot_fovmarker_enabled', 'FOVmarker enabled', 0)
local FovshotMode = gui.Combobox(msc_ref, 'lua_healthshot_fovmarker_combobox', 'Fovmarker', 'On hit', 'On kill')
local sliderFOV = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_duration', 'Animation duration (sec)', 1, 0, 10)
local sliderSmooth = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_smoothing', 'Animation smoothing', 80, 1, 100)
local sliderStart = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_startfov', 'Start FOV', 110, 50, 150)
local sliderEnd = gui.Slider(msc_ref, 'lua_healthshot_fovmarker_endfov', 'End FOV', 120, 50, 150)

local CrossTime = 0
local alpha = 0;
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX / 2;
screenCenterY = screenCenterY / 2;

listen('player_hurt')
listen('player_death')
local function add(time, ...)
  table.insert(activeFovs, {
      ["time"] = time,
      ["delay"] = globals.RealTime() + time,
      ["fov"] = sliderStart:GetValue(),
  })
end
local function healthshot_hitmarker(e)

  if not allenabled:GetValue() then
    return
  end
  if (entities.GetLocalPlayer() == nil) then return end

  local event_name = e:GetName()
  if (event_name ~= 'player_hurt' and event_name ~= 'player_death') then return end

  local hit = GetPlayerIndexByUserID(e:GetInt("hitgroup"))
  local me = localplayerindex()
  local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
  local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
  local im_attacker = attacker == me and victim ~= me
  local duration = slider:GetValue()
 
  if not im_attacker then
    return
  end

  if (event_name == 'player_death') then
    if (killssounds:GetValue() ~= 0 ) then
      local hitcmd = "play " .. ksounds[killssounds:GetValue()];
        client.Command(hitcmd, true);
    end
    if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 2 ) then
      localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
    end
    
    if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 1)) then
      add(slider:GetValue())
    end
  end
  
  if (event_name == 'player_hurt') then
    if (hssounds:GetValue() ~= 0 ) then
      if (e:GetInt("hitgroup") == 1) then  -- If hit head
        local hitcmd = "play " .. hsounds[hssounds:GetValue()];
          client.Command(hitcmd, true);
      else  -- If hit not-head
        if (hitssounds:GetValue() ~= 0 ) then
          local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
            client.Command(hitcmd, true);
        end
      end
    else
      if (hitssounds:GetValue() ~= 0 ) then
        local hitcmd = "play " .. hsounds[hitssounds:GetValue()];
          client.Command(hitcmd, true);
      end
    end
    if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 1 ) then
      localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
    end
    if ((FOVenabled:GetValue()) and (FovshotMode:GetValue() == 0)) then
      add(slider:GetValue())
    end
    if (hitcross:GetValue() == true) then
      CrossTime = globals.RealTime()
    end
  end
end

local function showFov(count, player)
  local nd = sliderEnd:GetValue()
  if globals.RealTime() < player.delay then
      if sliderStart:GetValue() > nd then
        if player.fov > nd then player.fov = player.fov - (nd + player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
        if player.fov < nd then player.fov = nd end
        --client.SetConVar("fov_cs_debug", player.fov, true)
        gui.SetValue("esp.local.fov", player.fov )
      else
      if player.fov < nd then player.fov = player.fov + (nd - player.fov) * sliderSmooth:GetValue()/1000 end -- время анимации
      if player.fov > nd then player.fov = nd end
      --client.SetConVar("fov_cs_debug", player.fov, true)
      gui.SetValue("esp.local.fov", player.fov )
  end
  else
    table.remove(activeFovs, count)
  end
end

callbacks.Register('FireGameEvent', healthshot_hitmarker)
callbacks.Register('Draw', function()
  for index, hitfov in pairs(activeFovs) do
      showFov(index, hitfov)
  end
  local step = 255 / 0.3 * globals.FrameTime()
  local r,g,b,a = hitmarkerColor:GetValue()
  if CrossTime + 0.4 > globals.RealTime() then
     alpha = 255
  else
     alpha = alpha - step
  end
  if (alpha > 0) then
    linesizeValue = linesize:GetValue()
    draw.Color( r,g,b,alpha)
      if(hitcrossrotate:GetValue() == true) then
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY - ( linesizeValue ))
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX - ( linesizeValue ), screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY + linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY - linesizeValue / 2, screenCenterX + ( linesizeValue ), screenCenterY - ( linesizeValue ))
      else
        draw.Line( screenCenterX, screenCenterY - linesizeValue / 2, screenCenterX, screenCenterY - ( linesizeValue ))
        draw.Line( screenCenterX - linesizeValue / 2, screenCenterY, screenCenterX - ( linesizeValue ), screenCenterY)
        draw.Line( screenCenterX, screenCenterY + linesizeValue / 2, screenCenterX, screenCenterY + ( linesizeValue ))
        draw.Line( screenCenterX + linesizeValue / 2, screenCenterY, screenCenterX + ( linesizeValue ), screenCenterY)
      end
    end
  if not allenabled:GetValue() then
    FovshotMode:SetInvisible( true )
    sliderFOV:SetInvisible( true )
    sliderSmooth:SetInvisible( true )
    sliderStart:SetInvisible( true )
    sliderEnd:SetInvisible( true )
    slider:SetInvisible( true )
    hitcross:SetInvisible( true )
    linesize:SetInvisible( true )
  else
    FovshotMode:SetInvisible( not FOVenabled:GetValue() )
    sliderFOV:SetInvisible( not FOVenabled:GetValue() )
    sliderSmooth:SetInvisible( not FOVenabled:GetValue() )
    sliderStart:SetInvisible( not FOVenabled:GetValue() )
    sliderEnd:SetInvisible( not FOVenabled:GetValue() )
    if Healthshot:GetValue() == 0 then
      slider:SetInvisible( true )
    else
      slider:SetInvisible( false )
    end
    if hitcross:GetValue() == false then
      linesize:SetInvisible( true )
      hitcrossrotate:SetInvisible( true )
    else      linesize:SetInvisible( false )
      hitcrossrotate:SetInvisible( false )
    end
  end
  FOVenabled:SetInvisible( not allenabled:GetValue() )
  killssounds:SetInvisible( not allenabled:GetValue() )
  hssounds:SetInvisible( not allenabled:GetValue() )
  hitssounds:SetInvisible( not allenabled:GetValue() )
  Healthshot:SetInvisible( not allenabled:GetValue() )
  hitcross:SetInvisible( not allenabled:GetValue() )

end);


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")