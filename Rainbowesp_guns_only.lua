frequency = 0.5 -- range: [0, oo) | lower is slower
intensity = 255 -- range: [0, 255] | lower is darker
saturation = 1 -- range: [0.00, 1.00] | lower is less saturated

function hsvToR(h, s, v)
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return r * intensity
end

function hsvToG(h, s, v)
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return g * intensity
end

function hsvToB(h, s, v)
  local r, g, b

  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);

  i = i % 6

  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end

  return b * intensity
end

function rainbowweaponesp()
    local R = hsvToR((globals.RealTime() * frequency) % 1, saturation, 1)
	local G = hsvToG((globals.RealTime() * frequency) % 1, saturation, 1)
	local B = hsvToB((globals.RealTime() * frequency) % 1, saturation, 1)
	gui.SetValue( "esp.chams.weapon.visible.clr", math.floor(R), math.floor(G), math.floor(B),255)
	gui.SetValue( "esp.chams.weapon.overlay.clr", math.floor(R), math.floor(G), math.floor(B),255)
end

callbacks.Register( "Draw", rainbowweaponesp)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

