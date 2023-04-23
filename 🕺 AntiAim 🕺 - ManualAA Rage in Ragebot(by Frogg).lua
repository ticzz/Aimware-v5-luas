-- Manual AA & Indicators
local gui_set = gui.SetValue
local gui_get = gui.GetValue
local left_key = 0
local back_key = 0
local right_key = 0
local up_key = 0
local rage_ref = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
local check_indicator = gui.Checkbox(rage_ref, "manual", "Manual AA", false)
local manual_left = gui.Keybox(rage_ref, "manual_left", "Left Keybind", 0)
local manual_right = gui.Keybox(rage_ref, "manual_right", "Right Keybind", 0)
local manual_back = gui.Keybox(rage_ref, "manual_back", "Back Keybind", 0)
local manual_up = gui.Keybox(rage_ref, "manual_up", "Up Keybind", 0)

-- Fonts
local text_font = draw.CreateFont("Verdana", 20, 700)
local arrow_font = draw.CreateFont("Marlett", 35, 700)

local function main()
  if manual_left:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_left:GetValue()) then
      left_key = left_key + 1
      back_key = 0
      right_key = 0
      up_key = 0
    end
  end

  if manual_back:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_back:GetValue()) then
      back_key = back_key + 1
      left_key = 0
      right_key = 0
      up_key = 0
    end
  end

  if manual_right:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_right:GetValue()) then
      right_key = right_key + 1
      left_key = 0
      back_key = 0
      up_key = 0
    end
  end

  if manual_up:GetValue() ~= 0 then
    if input.IsButtonPressed(manual_up:GetValue()) then
      up_key = up_key + 1
      left_key = 0
      back_key = 0
      right_key = 0
    end
  end
end

function CountCheck()
  if (left_key == 1) then
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (back_key == 1) then
    left_key = 0
    right_key = 0
    up_key = 0
  elseif (right_key == 1)  then
    left_key = 0
    back_key = 0
    up_key = 0
  elseif (up_key == 1) then
    left_key = 0
    back_key = 0
    right_key = 0
  elseif (left_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (back_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (right_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  elseif (up_key == 2) then
    left_key = 0
    back_key = 0
    right_key = 0
    up_key = 0
  end
end

function SetLeft()
  gui_set("rbot.antiaim.base", 90)
  gui_set("rbot.antiaim.advanced.autodir.targets", 0)
  gui_set("rbot.antiaim.advanced.autodir.edges", 0)
end

function SetBack()
  gui_set("rbot.antiaim.base", 180)
  gui_set("rbot.antiaim.advanced.autodir.targets", 0)
  gui_set("rbot.antiaim.advanced.autodir.edges", 0)
end

function SetRight()
  gui_set("rbot.antiaim.base", -90)
  gui_set("rbot.antiaim.advanced.autodir.targets", 0)
  gui_set("rbot.antiaim.advanced.autodir.edges", 0)
end

function SetUp()
  gui_set("rbot.antiaim.base", 0)
  gui_set("rbot.antiaim.advanced.autodir.targets", 0)
  gui_set("rbot.antiaim.advanced.autodir.edges", 0)
end

function SetAuto()
  gui_set("rbot.antiaim.base", 180)
  gui_set("rbot.antiaim.advanced.autodir.targets", 1)
  gui_set("rbot.antiaim.advanced.autodir.edges", 1)
end

function draw_indicator()
  if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then return end
  local active = check_indicator:GetValue()
  if active then
    local w, h = draw.GetScreenSize()
    if (left_key == 1) then
      SetLeft()
      draw.Color(78, 126, 242, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 60, h/2 - 16, "3")
    elseif (back_key == 1) then
      SetBack()
      draw.Color(78, 126, 242, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 17, h/2 + 33, "6")
    elseif (right_key == 1) then
      SetRight()
      draw.Color(78, 126, 242, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 + 30, h/2 - 16, "4")
    elseif (up_key == 1) then
      SetUp()
      draw.Color(78, 126, 242, 255)
      draw.SetFont(arrow_font)
      draw.TextShadow( w/2 - 17, h/2 + -66, "5")
    elseif ((left_key == 0) and (back_key == 0) and (right_key == 0) and (up_key == 0)) then
      SetAuto()
      draw.Color(78, 126, 242, 255)
      draw.SetFont(text_font)
      draw.TextShadow(15, h - 560, "auto")
    end
  end
end

callbacks.Register("Draw", "main", main)
callbacks.Register("Draw", "CountCheck", CountCheck)
callbacks.Register("Draw", "draw_indicator", draw_indicator)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

