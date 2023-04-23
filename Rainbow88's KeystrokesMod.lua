-- why did i make this

print("made by rainbow88 hf")
local ref = gui.Tab(gui.Reference("Visuals"), "r88.keystrokes", "Rainbow88's Keystrokes")
local ref2 = gui.Groupbox(ref, "Keystrokes", 16, 10, 297, 400)
local tog= gui.Checkbox(ref2, "toggle", "Toggle Keystrokes", 0)

local maincolor = gui.ColorPicker(ref2, "color", "Main Color", 255, 255, 255, 255);
local secondcolor = gui.ColorPicker(ref2, "color2", "Second Color", 100, 100, 100, 255);
local bgcolor = gui.ColorPicker(ref2, "color3", "Background Color", 25, 25, 25, 255);

local r, g, b, a = maincolor:GetValue();
local r2, g2, b2, a2 = secondcolor:GetValue();
local r3, g3, b3, a3 = bgcolor:GetValue();

local screenX, screenY = draw.GetScreenSize()

local posX = gui.Slider(ref2, "posX", "X position", 0, 0, screenX)
local posY = gui.Slider(ref2, "posX", "Y position", 0, 0, screenY)
local mainfont = draw.CreateFont("Segoe UI", 30, 400)
local mainfont_mid = draw.CreateFont("Segoe UI", 20, 400)
local mainfont_small = draw.CreateFont("Segoe UI", 12, 200)
local CountCPS = 0
local CountCPS2 = 0
local CountCPS3 = 0
local CountCPS4 = 0
local counter = 1

local function DrawRect()
-- useless function but who cares its just as useless as this script
if not tog:GetValue() then return end
local r3, g3, b3, a3 = bgcolor:GetValue();
draw.Color(r3, g3, b3, a3)
draw.FilledRect(posX:GetValue() - 35, posY:GetValue() - 42, posX:GetValue() + 48, posY:GetValue() + 60) -- draw.FilledRect(posX:GetValue() - 35, posY:GetValue() - 42, posX:GetValue() + 48, posY:GetValue() + 25)
local r, g, b, a = maincolor:GetValue();
draw.Color(r, g, b, a)
draw.FilledRect(posX:GetValue() - 35, posY:GetValue() - 25, posX:GetValue() + 48, posY:GetValue() - 27)
end

callbacks.Register("Draw", DrawRect)

local str = "0 CPS -"
local str2 = "0 CPS +"
local function CPS() -- this is so useless but asd wanted it so why not
if not tog:GetValue() then return end

local r, g, b, a = maincolor:GetValue();
if input.IsButtonPressed("Mouse1") then
CountCPS = CountCPS + 1
end

if input.IsButtonPressed("Mouse2") then
CountCPS3 = CountCPS3 + 1
end

draw.SetFont(mainfont_small);
draw.Color(r, g, b, a)
draw.Text(posX:GetValue() - 25, posY:GetValue() + 35, str)
draw.Text(posX:GetValue() + 15, posY:GetValue() + 35, str2)
end

local time = globals.RealTime()

local function onceASecond()
if globals.RealTime() - counter >= time then
    if not tog:GetValue() then return end
    --print ("gamer move")
    CountCPS2 = CountCPS
    CountCPS4 = CountCPS3
    str = CountCPS.." CPS"
    str2 = CountCPS3.." CPS"
    CountCPS = 0
    CountCPS3 = 0
    counter = counter + 1
end
end

callbacks.Register("Draw", CPS)
callbacks.Register("Draw", onceASecond)

local function keystrokesMain()
    
    local r, g, b, a = maincolor:GetValue();
    local r2, g2, b2, a2 = secondcolor:GetValue();

    -- positions calculated from center letter (s) (retarded but good enough for me)
    if not tog:GetValue() then return end
    
    -- if pressed
    
    if input.IsButtonDown("W") then
        draw.SetFont(mainfont);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue() - 5, posY:GetValue() - 20, "W")
    end
    
    if input.IsButtonDown("A") then
        draw.SetFont(mainfont);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue() - 20, posY:GetValue(), "A")
    end
    
    if input.IsButtonDown("S") then
        draw.SetFont(mainfont);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue(), posY:GetValue(), "S")
    end
    
    if input.IsButtonDown("D") then
        draw.SetFont(mainfont);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue() + 18, posY:GetValue(), "D")
    end
    
    if input.IsButtonDown("Mouse1") then
        draw.SetFont(mainfont_mid);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue() - 28, posY:GetValue() + 20, "LMB")
    end
    
    if input.IsButtonDown("Mouse2") then
        draw.SetFont(mainfont_mid);
        draw.Color(r, g, b, a)
        draw.Text(posX:GetValue() + 10, posY:GetValue() + 20, "RMB")
    end
    
    -- if not pressed
    
    if not input.IsButtonDown("W") then
        draw.SetFont(mainfont);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue() - 5, posY:GetValue() - 20, "W")
    end
    
    if not input.IsButtonDown("A") then
        draw.SetFont(mainfont);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue() - 20, posY:GetValue(), "A")
    end
    
    if not input.IsButtonDown("S") then
        draw.SetFont(mainfont);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue(), posY:GetValue(), "S")
    end
    
    if not input.IsButtonDown("D") then
        draw.SetFont(mainfont);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue() + 18, posY:GetValue(), "D")
    end
    
    if not input.IsButtonDown("Mouse1") then
        draw.SetFont(mainfont_mid);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue() - 28, posY:GetValue() + 20, "LMB")
    end
    
    if not input.IsButtonDown("Mouse2") then
        draw.SetFont(mainfont_mid);
        draw.Color(r2, g2, b2, a2)
        draw.Text(posX:GetValue() + 10, posY:GetValue() + 20, "RMB")
    end
    
    draw.SetFont(mainfont_small);
    draw.Color(r, g, b, a)
    draw.Text(posX:GetValue() - 33, posY:GetValue() - 40, "keystrokes")
end

local function RetardedWatermark()
if not tog:GetValue() then return end
local r4 = math.floor(math.sin(globals.RealTime() * 1) * 127 + 128);
local g4 = math.floor(math.sin(globals.RealTime() * 1 + 2) * 127 + 128);
local b4 = math.floor(math.sin(globals.RealTime() * 1 + 4) * 127 + 128);

draw.Color(r4, g4, b4, 255);
draw.SetFont(mainfont_small);
draw.Text(posX:GetValue() - 21, posY:GetValue() + 47, "by rainbow88")

end

callbacks.Register("Draw", RetardedWatermark)
callbacks.Register("Draw", keystrokesMain)