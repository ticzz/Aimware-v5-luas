local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime
local ref = gui.Reference("Misc", "Enhancement")
local msc_ref = gui.Groupbox(ref, "Healthshot hitsound", 328,369, 296,400)
local masterswitch = gui.Checkbox(msc_ref, 'lua_hitmarker_masterswitch', 'Hitmarker Masterswitch', 1)
local hitcross = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_enabled', 'Enable crosshair marker', 0)
local hitmarkerColor = gui.ColorPicker(hitcross, "lua_healthshot_hitcross_color", "", 255, 165, 10, 255);
hitcross:SetDescription("Drawing a marker on the center of screen") 
local linesize = gui.Slider(msc_ref, 'lua_healthshwdot_hitcross_slider', 'Crosshair marker size', 15, 1, 30)
local hitcrossrotate = gui.Checkbox(msc_ref, 'lua_healthshot_hitcross_rotated', 'Rotate marker by 45', 0)

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

  local event_name = e:GetName()
  if (event_name ~= 'player_hurt' and event_name ~= 'player_death') then return end

  local hit = GetPlayerIndexByUserID(e:GetInt("hitgroup"))
  local me = localplayerindex()
  local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
  local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
  local im_attacker = attacker == me and victim ~= me
  
 
  if not im_attacker then
    return
  end

    if (hitcross:GetValue() == true) then
      CrossTime = globals.RealTime()
    end
end

callbacks.Register('FireGameEvent', "healthshot_hitmarker", healthshot_hitmarker)

callbacks.Register('Draw', function()

  if (entities.GetLocalPlayer() == nil) then return end

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
    if hitcross:GetValue() == false then
      linesize:SetInvisible( true )
      hitcrossrotate:SetInvisible( true )
    else
      linesize:SetInvisible( false )
      hitcrossrotate:SetInvisible( false )
    end
hitcross:SetInvisible( not masterswitch:GetValue())
end)

print(GetScriptName() .. "successfully loaded")







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

