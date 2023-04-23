--[[
MIT License

Copyright (c) 2020 LeoDeveloper

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Github: https://github.com/le0developer/awluas/blob/master/project_alpha/project_alpha.moon
Automatically generated and compiled on Sat Oct 10 21:45:20 2020
]]
local gui_invert
local __version__ = [[3af2ad6a18fb20948569cfcb03e8c766c81ef676a75a99eedbec72caf0001b30]]
local types = { }
local add_type
add_type = function(name, description, apply_func, setup_func)
  return table.insert(types, {
    name = name,
    description = description,
    apply = apply_func,
    setup = setup_func
  })
end
add_type("Legit AA", "Legit AA with Ragebot", function(cmd)
  local changes = { }
  if gui_invert:GetValue() then
    changes["rbot.antiaim.fakeyawstyle"] = 2
  else
    changes["rbot.antiaim.fakeyawstyle"] = 1
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.lbyoverride", true)
  gui.SetValue("rbot.antiaim.lby", 58)
  gui.SetValue("rbot.antiaim.lbyextend", true)
  gui.SetValue("rbot.antiaim.extra.advconfig", true)
  gui.SetValue("rbot.antiaim.desync", 58)
  gui.SetValue("rbot.antiaim.yawstyle", 1)
  return gui.SetValue("rbot.antiaim.yaw", 0)
end)
add_type("Real Rapid Switch", "Switching the real from the left to the right side very fast.\nBasically makes hitting you pure luck.", function(cmd)
  local changes = { }
  if cmd.tick_count % (1 / globals.TickInterval() % 16) >= 2 then
    changes["rbot.antiaim.fakeyawstyle"] = 1
  else
    changes["rbot.antiaim.fakeyawstyle"] = 2
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.lbyextend", false)
  gui.SetValue("rbot.antiaim.lbyoverride", false)
  return gui.SetValue("rbot.antiaim.desync", 58)
end)
add_type("Real Rapid Switch & Jitter", "Switching the real from the left to the right when moving and jittering at full extended when standing.", function(cmd)
  local localplayer = entities.GetLocalPlayer()
  local velocity = math.sqrt(localplayer:GetPropFloat("localdata", "m_vecVelocity[0]") ^ 2 + localplayer:GetPropFloat("localdata", "m_vecVelocity[1]") ^ 2)
  local changes = { }
  if velocity > 5 then
    changes["rbot.antiaim.lbyextend"] = false
    if cmd.tick_count % (1 / globals.TickInterval() / 16) >= 2 then
      changes["rbot.antiaim.fakeyawstyle"] = 1
    else
      changes["rbot.antiaim.fakeyawstyle"] = 2
    end
  else
    changes["rbot.antiaim.lbyextend"] = true
    if gui_invert:GetValue() then
      changes["rbot.antiaim.fakeyawstyle"] = 2
    else
      changes["rbot.antiaim.fakeyawstyle"] = 1
    end
    if cmd.tick_count % (1 / globals.TickInterval() / 16) >= 2 then
      changes["rbot.antiaim.yaw"] = 178
    else
      changes["rbot.antiaim.yaw"] = -178
    end
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.desync", 58)
  gui.SetValue("rbot.antiaim.extra.advconfig", false)
  gui.SetValue("rbot.antiaim.lbyextend", false)
  return gui.SetValue("rbot.antiaim.lbyoverride", false)
end)
add_type("Sway Fake and Sway Real", "Sways the real and fake.\nGood against skeet but wouldn't recommend against bruteforce.", function(cmd)
  local changes = { }
  if cmd.tick_count % (1 / globals.TickInterval()) == 0 then
    if gui.GetValue("rbot.antiaim.lby") == 58 then
      changes["rbot.antiaim.lby"] = -58
    else
      changes["rbot.antiaim.lby"] = 58
    end
  end
  if gui_invert:GetValue() then
    changes["rbot.antiaim.fakeyawstyle"] = 2
  else
    changes["rbot.antiaim.fakeyawstyle"] = 1
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.lbyextend", true)
  gui.SetValue("rbot.antiaim.lbyoverride", true)
  gui.SetValue("rbot.antiaim.extra.advconfig", true)
  gui.SetValue("rbot.antiaim.desync", 0)
  return gui.SetValue("rbot.antiaim.fakeyawstyle", 1)
end)
add_type("Jitter Fake Out", "Gets OTCv2 to dump every shot as long as the real is not hitable.\nWorks good against free cheats/pastes.", function(cmd)
  local changes = { }
  if gui_invert:GetValue() then
    changes["rbot.antiaim.fakeyawstyle"] = 3
  else
    changes["rbot.antiaim.fakeyawstyle"] = 4
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.lbyextend", true)
  gui.SetValue("rbot.antiaim.lbyoverride", false)
  return gui.SetValue("rbot.antiaim.extra.advconfig", true)
end)
add_type("Random", "Changes real every 0.25sec between LEFT, MID and RIGHT.", function(cmd)
  local changes = { }
  if cmd.tick_count % (1 / globals.TickInterval() * 0.25) == 0 then
    local angle = math.random(-1, 1)
    if angle < 0 then
      changes["rbot.antiaim.fakeyawstyle"] = 1
    else
      changes["rbot.antiaim.fakeyawstyle"] = 2
    end
    changes["rbot.antiaim.desync"] = math.abs(angle * 58)
  end
  return changes
end, function()
  gui.SetValue("rbot.antiaim.extra.advconfig", false)
  gui.SetValue("rbot.antiaim.lbyextend", false)
  return gui.SetValue("rbot.antiaim.lbyoverride", false)
end)
local gui_tab = gui.Tab(gui.Reference("Ragebot"), "project_alpha", "Project Alpha")
local gui_aa = gui.Groupbox(gui_tab, "AntiAim Modes", 16, 16, 300, 400)
local gui_misc = gui.Groupbox(gui_tab, "Misc", 332, 16, 300, 400)
local gui_type = gui.Combobox(gui_aa, "project_alpha.type", "Type", "No special AA", unpack((function()
  local _accum_0 = { }
  local _len_0 = 1
  for _index_0 = 1, #types do
    local k = types[_index_0]
    _accum_0[_len_0] = k.name
    _len_0 = _len_0 + 1
  end
  return _accum_0
end)()))
local gui_description = gui.Text(gui_aa, "No description.")
do
  local _with_0 = gui.Checkbox(gui_aa, "project_alpha.invert", "Invert", false)
  _with_0:SetDescription("Should be used for invertion. Might not have effect.")
  gui_invert = _with_0
end
local gui_version = gui.Text(gui_misc, "Checking for update...")
local gui_update = gui.Button(gui_misc, "Update", function()
  gui_update:SetDisabled(true)
  http.Get([[https://raw.githubusercontent.com/Le0Developer/awluas/master/project_alpha/dist/project_alpha.min.lua]], function(content)
    file.Write(GetScriptName(), content)
    gui_update:SetDisabled(false)
    gui_version:SetText("Updated, please reload the lua.")
    
  end)
  
end)
local gui_debug
do
  local _with_0 = gui.Checkbox(gui_misc, "project_alpha.debug", "Debug", false)
  _with_0:SetDescription("Prints debug information in console.")
  gui_debug = _with_0
end
local last_type_move = nil
local last_type_draw = nil
local apply_changes
apply_changes = function(changes, debug)
  for name, value in pairs(changes) do
    if gui.GetValue(name) ~= value then
      if debug then
        print("[PROJECT ALPHA] [" .. tostring(debug) .. "] Changed value at " .. tostring(name) .. " from " .. tostring(gui.GetValue(name)) .. " to " .. tostring(value))
      end
      gui.SetValue(name, value)
    end
  end
end
callbacks.Register("Draw", function()
  local typeno = gui_type:GetValue()
  if typeno ~= last_type_draw then
    if typeno == 0 then
      gui_description:SetText("You currently have no type selected, so this lua does nothing.")
    else
      gui_description:SetText(types[typeno].description)
    end
    last_type_draw = typeno
  end
end)
callbacks.Register("CreateMove", function(cmd)
  local typeno = gui_type:GetValue()
  if typeno == 0 then
    last_type_move = 0
    return 
  end
  local type = types[typeno]
  if typeno ~= last_type_move then
    type.setup()
    last_type_move = typeno
  end
  do
    local changes = type.apply(cmd)
    if changes then
      return apply_changes(changes, (function()
        if gui_debug:GetValue() then
          return cmd.tick_count
        else
          return nil
        end
      end)())
    end
  end
end)
http.Get([[https://raw.githubusercontent.com/Le0Developer/awluas/master/project_alpha/dist/project_alpha.version]], function(content)
  if not (content) then
    return 
  end
  if content == "404: Not Found" then
    gui_version:SetText("Github repository is down.")
    gui_update:SetDisabled(true)
    return 
  end
  if content == __version__ then
    return gui_version:SetText("You are up to date.")
  else
    return gui_version:SetText("An update is available, please press update!")
  end
end)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

