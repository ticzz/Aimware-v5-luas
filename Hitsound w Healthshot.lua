-- aimware.net/forum/thread-116236.html

hsounds = {"bubble.wav", "laser.wav", "nelfo.wav", "qbeep.wav", "spittle.wav", "bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakhit.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Mediumimpact.wav"}
ksounds = {"bubble.wav", "laser.wav", "nelfo.wav", "qbeep.wav", "spittle.wav", "bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "kovaakded.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3", "rust.wav", "toy.wav", "Hardimpact.wav"}

local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime
local ref = gui.Reference("Visuals", "World", "Extra")
local msc_ref = gui.Groupbox(ref, "Healthshot hitsound", 328,313, 296,400)

local allenabled = gui.Checkbox(msc_ref, 'lua_hitsound_enabled', 'Hitsound/marker enabled', 1)

local killssounds = gui.Combobox(msc_ref, 'lua_killsound_combobox', 'Killsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact (loud)")
killssounds:SetDescription("Overrides the headshot and hit sound on kill")

local hssounds = gui.Combobox(msc_ref, 'lua_hssounds_combobox', 'Headshot sound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")
hssounds:SetDescription("Overrides the hitsound on HS")

local hitssounds = gui.Combobox(msc_ref, 'lua_hitsound_combobox', 'Hitsound', "Off", "Bass", "Battlefield 4", "Bowhit", "Bruh", "You a gay", "Kovaak", "Cookie", "Windows XP error", "Roblox", "Vitas", "Minecraft hit", "Gachimuchi", "Metro 2033", "Minecraft oh", "Rust HS", "Toy", "Impact")

local Healthshot = gui.Combobox(msc_ref, 'lua_healthshot_hitmarker_combobox', 'Healthshot hitmarker', 'Off', 'On hit', 'On kill')
local slider = gui.Slider(msc_ref, 'lua_healthshot_hitmarker_slider', 'Healthshot duration (sec)', 1, 0, 10, 0.1)

listen('player_hurt')
listen('player_death')

local function healthshot_hitmarker(e)

  if not allenabled:GetValue() then
    return
  end
  local event_name = e:GetName()
  if event_name ~= 'player_hurt' and event_name ~= 'player_death' then
    return
  end
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
    client.ChatSay(HITGROUP)
    if (killssounds:GetValue() ~= 0 ) then
      local hitcmd = "play " .. ksounds[killssounds:GetValue()];
        client.Command(hitcmd, true);
    end

    if (Healthshot:GetValue() ~= 0 ) and (Healthshot:GetValue() == 2 ) then
      localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
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
  end
end
callbacks.Register('FireGameEvent', healthshot_hitmarker)
callbacks.Register('Draw',function()
	if(allenabled:GetValue()) then
		gui.SetValue("esp.world.hiteffects.sound", "Off");
		gui.SetValue("esp.world.hiteffects.marker", "Off");
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")