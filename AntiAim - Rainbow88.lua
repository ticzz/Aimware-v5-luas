-- Change these values to your liking
local desyncValue = 58
local desyncInvertedValue = -58
local LBYValue = -126
local LBYInvertedValue = 126

print("Loading Rainbow88's Essentials. Have fun! 0/8")
-- Get Screen Size (For indicators)

local screenW, screenH;
local once = false
-- Variables

local isDTing;
local isInverted;
local DesyncSwitch;

-- Shortening Code

SetVal = gui.SetValue
GetVal = gui.GetValue
local font = draw.CreateFont("Verdana", 15, 800)
local desync_break_font = draw.CreateFont("Segoe UI", 13, 800)
-- References

-- gui tab
local ref = gui.Tab(gui.Reference("Ragebot"), "r88.tab", "Rainbow88's Essentials")

-- dt groupbox
local ref2 = gui.Groupbox(ref, "Doubletap", 16, 10, 297, 400)
local dtkey = gui.Keybox(ref2, "dt.key", "Doubletap Key", 0)

-- desync groupbox
local ref3 = gui.Groupbox(ref, "Desync", 16, 125, 297, 400)
local invertkey = gui.Keybox(ref3, "invert.desync", "Invert Desync", 0)
local desyncswitchjitter = gui.Checkbox(ref3, "invert.desync", "Desync Switch Jitter", 0)

-- manual aa groupbox



local ref4 = gui.Groupbox(ref, "Anti-Aim", 325, 10, 297, 400)

local Desync_Break = gui.Checkbox(ref4, "desync.break", "RainbowSync", false)
local DesyncBreakPhase = 0;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;
local ManualEnabled = gui.Checkbox(ref4, "manual.enable", "Manual AA", false)
local AntiAimLeft = gui.Keybox(ref4 , "aa_left", "Left Keybind", 0);
local AntiAimRight = gui.Keybox(ref4 , "aa_right", "Right Keybind", 0);
local AntiAimBack = gui.Keybox(ref4 , "aa_back", "Back Keybind", 0);

-- Get Menu Values

local DTmode;

-- Indicator Colors

local enabledClr = 124, 176, 34

-- Script Start

local function gatherInformation()
    screenW, screenH = draw.GetScreenSize()
end

callbacks.Register("Draw", gatherInformation)

print("Gathered screen information. 1/8")

-- Doubletap

local function indicateIsDTing()
    if dtkey:GetValue() ~= 0 then
        if DTmode == true then
            --local font = draw.CreateFont("Verdana", 30, 2000)
            draw.SetFont(font);
            draw.Color(124, 176, 34)
            draw.Text(10, screenH - 135, "DT")
            draw.TextShadow(10, screenH - 135, "DT")
        end
    end
end

local function setDT()
    if dtkey:GetValue() ~= 0 then
        if input.IsButtonDown(dtkey:GetValue()) then
            gui.SetValue( "rbot.accuracy.weapon.asniper.doublefire", 1 )
            DTmode = true
        else
            gui.SetValue( "rbot.accuracy.weapon.asniper.doublefire", 0 )
            DTmode = false
        end
    end
end

callbacks.Register("Draw", indicateIsDTing)
callbacks.Register("Draw", setDT)

print("Loaded Doubletap module. 2/8")

-- Desync Inverter

local function indicateIsInverted()
    if invertkey:GetValue() ~= 0 then
        if isInverted == true then
            --    local font = draw.CreateFont("Verdana", 30, 2000)
            draw.SetFont(font);
            draw.Color(124, 176, 34)
            draw.Text(10, screenH - 85, "L")
            draw.TextShadow(10, screenH - 85, "L")
            draw.Color(255, 25, 25)
            draw.Text(35, screenH - 85, "R")
            draw.TextShadow(35, screenH - 85, "R")
    
        else
            --local font = draw.CreateFont("Verdana", 30, 2000)
            draw.SetFont(font);
            draw.Color(255, 25, 25)
            draw.Text(10, screenH - 85, "L")
            draw.TextShadow(10, screenH - 85, "L")
            draw.Color(124, 176, 34)
            draw.Text(35, screenH - 85, "R")
            draw.TextShadow(35, screenH - 85, "R")
        end
    end
end

local function setInvert()
    if invertkey:GetValue() ~= 0 then
        if input.IsButtonPressed(invertkey:GetValue()) then
            if isInverted == true then
        
                SetVal("rbot.antiaim.base.rotation", desyncValue)
                SetVal("rbot.antiaim.base.lby", LBYValue)
                isInverted = false
        
            else
        
                SetVal("rbot.antiaim.base.rotation", desyncInvertedValue)
                SetVal("rbot.antiaim.base.lby", LBYInvertedValue)
                isInverted = true
            end
        end
    end
end

callbacks.Register("Draw", indicateIsInverted)
callbacks.Register("Draw", setInvert)


print("Loaded Desync Inverter. 3/8")
-- Anti-Aim

-- Manual AA

local function manualMain()
    if not ManualEnabled:GetValue() then return end

    if AntiAimLeft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimLeft:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimBack:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimBack:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
        end
    end
    
    if ( LeftKey == 1 ) then
        SetVal("rbot.antiaim.base", 90);
        --local font = draw.CreateFont("Verdana", 30, 2000)
        draw.SetFont(font);
        draw.Color(255, 25, 25)
        draw.Text(10, screenH - 110, "LEFT")
        draw.TextShadow(10, screenH - 110, "LEFT")
        BackKey = 0;
        RightKey = 0;
    elseif ( BackKey == 1 ) then
        SetVal("rbot.antiaim.base", 180);
        --local font = draw.CreateFont("Verdana", 30, 2000)
        draw.SetFont(font);
        draw.Color(255, 25, 25)
        draw.Text(10, screenH - 110, "BACK")
        draw.TextShadow(10, screenH - 110, "BACK")
        LeftKey = 0;
        RightKey = 0;
    elseif ( RightKey == 1 ) then
        SetVal("rbot.antiaim.base", -90);
        local font = draw.CreateFont("Verdana", 30, 2000)
        draw.SetFont(font);
        draw.Color(255, 25, 25)
        draw.Text(10, screenH - 110, "RIGHT")
        draw.TextShadow(10, screenH - 110, "RIGHT")
        LeftKey = 0;
        BackKey = 0;
    elseif ( LeftKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    elseif ( BackKey == 2 ) then
        SetVal("rbot.antiaim.base", 180);
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    elseif ( RightKey == 2 ) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    end
    
end

callbacks.Register("Draw", manualMain);

print("Loaded Manual Anti-Aim. 4/8")

local function IndicateDesyncBreak()
    if not Desync_Break:GetValue() then return end
    if GetVal("rbot.antiaim.base.rotation") >= -24 then

        draw.SetFont(desync_break_font);
        draw.Color(124, 176, 34)
        draw.Text(10, screenH - 73, "RAINBOWSYNC")
        draw.TextShadow(10, screenH - 73, "RAINBOWSYNC")
        
    
    else
    draw.SetFont(desync_break_font);
        draw.Color(255, 25, 25)
        draw.Text(10, screenH - 73, "RAINBOWSYNC")
        draw.TextShadow(10, screenH - 73, "RAINBOWSYNC")
    
    end
end

local function DesyncBreak()
if not Desync_Break:GetValue() then return end


DesyncBreakPhase = DesyncBreakPhase + 1

if DesyncBreakPhase == 0 then
SetVal("rbot.antiaim.base", 170)
SetVal("rbot.antiaim.base.rotation", -24)
SetVal("rbot.antiaim.base.lby", 140)
end

if DesyncBreakPhase == 1 then
SetVal("rbot.antiaim.base", -170)
--SetVal("rbot.antiaim.base.rotation", -16)
SetVal("rbot.antiaim.base.lby", 0)
end

if DesyncBreakPhase == 2 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -48)
end

if DesyncBreakPhase == 3 then
SetVal("rbot.antiaim.base", -170)
SetVal("rbot.antiaim.base.rotation", -36)
SetVal("rbot.antiaim.base.lby", 0)
end

if DesyncBreakPhase == 4 then
SetVal("rbot.antiaim.base", -170)
SetVal("rbot.antiaim.base.rotation", -24)
end

if DesyncBreakPhase == 5 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -54)
end

if DesyncBreakPhase == 6 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -8)
end

if DesyncBreakPhase == 7 then
SetVal("rbot.antiaim.base", -170)
SetVal("rbot.antiaim.base.rotation", -48)
end

if DesyncBreakPhase == 8 then
SetVal("rbot.antiaim.base", 170)
SetVal("rbot.antiaim.base.rotation", -24)
end

if DesyncBreakPhase == 9 then
SetVal("rbot.antiaim.base", -170)
--SetVal("rbot.antiaim.base.rotation", -16)
end

if DesyncBreakPhase == 10 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -48)
end

if DesyncBreakPhase == 11 then
SetVal("rbot.antiaim.base", -170)
SetVal("rbot.antiaim.base.rotation", -36)
end

if DesyncBreakPhase == 12 then
SetVal("rbot.antiaim.base", -170)
--SetVal("rbot.antiaim.base.rotation", -49)
end

if DesyncBreakPhase == 13 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -14)
end

if DesyncBreakPhase == 14 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", -57)
end

if DesyncBreakPhase == 15 then
SetVal("rbot.antiaim.base", -170)
SetVal("rbot.antiaim.base.rotation", -38)
SetVal("rbot.antiaim.base.lby", 0)
end

if DesyncBreakPhase == 16 then
SetVal("rbot.antiaim.base", 170)
--SetVal("rbot.antiaim.base.rotation", 24)
--SetVal("rbot.antiaim.base.lby", 140)
DesyncBreakPhase = 0
end
end

callbacks.Register("Draw", IndicateDesyncBreak)
callbacks.Register("Draw", DesyncBreak)

print("Loaded Desync Break / RainbowSync. 5/8")

local function DesyncSwitchJitter()
DesyncSwitch = not DesyncSwitch
if not desyncswitchjitter:GetValue() then return end

if DesyncSwitch == true then

SetVal("rbot.antiaim.base.rotation", 58)

else

SetVal("rbot.antiaim.base.rotation", -58)

end
end

callbacks.Register("Draw", DesyncSwitchJitter)

print("Loaded Desync Switch Jitter. 6/8")

local function Watermark()
    --local font = draw.CreateFont("Verdana", 30, 2000)
    draw.SetFont(font);
    draw.Color(124, 176, 34)
    draw.Text(10, screenH - 60, "RAINBOW88")
    draw.TextShadow(10, screenH - 60, "RAINBOW88")
end

callbacks.Register("Draw", Watermark);

print("Loaded Watermark. 7/8")
print("Loaded everything. Have fun! 8/8")