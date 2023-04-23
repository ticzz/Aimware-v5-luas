print("Loaded SemiRage Helper lua by cloudyne#1872")
local TAB=gui.Tab(gui.Reference("Misc"), "semirage", "Extra")
local GROUPBOX_MAIN=gui.Groupbox(TAB, "Semirage Helper", 10, 10, 300)
local KEYBOX_QUICKSWITCH=gui.Keybox (GROUPBOX_MAIN, "rlswitch", "Quickswitch", 0)
KEYBOX_QUICKSWITCH:SetDescription("Switches between legitbot and ragebot")
local KEYBOX_INVERTER=gui.Keybox(GROUPBOX_MAIN, "inverter", "Inverter", 0)
KEYBOX_INVERTER:SetDescription("This only works for ragebot")
local KEYBOX_AWSWITCH=gui.Keybox(GROUPBOX_MAIN, "awswitch", "AutoWall", 0)
KEYBOX_AWSWITCH:SetDescription("Turn autwall on and off")
local MULTIBOX_INDICATORS=gui.Multibox(GROUPBOX_MAIN, "Indicators")
local CHECKBOX_QUICKSWITCH = gui.Checkbox(MULTIBOX_INDICATORS, "switch", "Quickswitch", 0)
local CHECKBOX_AUTOWALLSWITCH = gui.Checkbox(MULTIBOX_INDICATORS, "autowswitch", "Autowall switch", 0)
local CHECKBOX_INVERTER = gui.Checkbox(MULTIBOX_INDICATORS, "dsncinverter", "Desync inverter", 0)
local rcol=gui.ColorPicker(CHECKBOX_QUICKSWITCH, "rcol_color", "Rage Indicator", 255, 25, 25, 255)
local lcol=gui.ColorPicker(CHECKBOX_QUICKSWITCH, "lcol_color", "Legit Indicator", 124, 176, 34, 255)
local aoff=gui.ColorPicker(CHECKBOX_AUTOWALLSWITCH, "aoff_color", "AW off Indicator", 255, 25, 25, 255)
local aon=gui.ColorPicker(CHECKBOX_AUTOWALLSWITCH, "aon_color", "AW on Indicator", 124, 176, 34, 255)
local aacol=gui.ColorPicker(CHECKBOX_INVERTER, "aacol_color", "Desync side Indicator", 28, 108, 204, 255)
local Font = draw.CreateFont("Verdana", 34, 700)
local screenW, screenH = draw.GetScreenSize()
function Indicators()
    draw.SetFont(Font)
    if CHECKBOX_QUICKSWITCH:GetValue() then
        if gui.GetValue("rbot.master") then
            draw.Color(rcol:GetValue())
            draw.TextShadow(10, screenH - 500, "Rage")
        else
            draw.Color(lcol:GetValue())
            draw.TextShadow(10, screenH - 500, "Legit")
        end
    end
    if CHECKBOX_AUTOWALLSWITCH:GetValue() then
        if awtggl then
            draw.Color(aon:GetValue())
            draw.TextShadow(10, screenH - 465, "AW")
        else
            draw.Color(aoff:GetValue())
            draw.TextShadow(10, screenH - 465, "AW")
        end
    end
    if CHECKBOX_INVERTER:GetValue() then
        if invrtr then
            draw.Color(aacol:GetValue())
            draw.TextShadow(10, screenH - 430, "Right")
        else
            draw.Color(aacol:GetValue())
            draw.TextShadow(10, screenH - 430, "Left")
        end
    end
end
callbacks.Register("Draw", "semiragehelper", Indicators)
function qswitch()
    if KEYBOX_QUICKSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_QUICKSWITCH:GetValue()) then
            rltggl = not rltggl
        end
        if rltggl then
            gui.SetValue("rbot.master", false)
            gui.SetValue("lbot.master", true)
        else
            gui.SetValue("rbot.master", true)
            gui.SetValue("lbot.master", false)
        end
    end
end    
callbacks.Register("Draw", "semiragehelper", qswitch)
function awswitch()
    if KEYBOX_AWSWITCH:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_AWSWITCH:GetValue()) then
            awtggl = not awtggl
        end
        if awtggl then   
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 1)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 1)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 1)
        else
            gui.SetValue( "rbot.hitscan.mode.asniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.hpistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.lmg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.pistol.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.shotgun.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.smg.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.scout.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.sniper.autowall", 0)
            gui.SetValue( "rbot.hitscan.mode.rifle.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.asniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.hpistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.lmg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.pistol.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.shotgun.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.smg.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.scout.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.sniper.autowall", 0)
            gui.SetValue( "lbot.weapon.vis.rifle.autowall", 0)
        end
    end
end
callbacks.Register("Draw", "semiragehelper", awswitch)
function finverter()
    gui.SetValue( "rbot.antiaim.advanced.pitch", off)
    gui.SetValue("rbot.antiaim.base", 0)
    if KEYBOX_INVERTER:GetValue() ~= 0 then
        if input.IsButtonPressed(KEYBOX_INVERTER:GetValue()) then
            invrtr = not invrtr
        end
        if invrtr then   
            gui.SetValue("rbot.antiaim.base.rotation", -58)
            gui.SetValue("rbot.antiaim.base.lby", 100)
        else
            gui.SetValue("rbot.antiaim.base.rotation", 58)
            gui.SetValue("rbot.antiaim.base.lby", -100)
        end
    end
end
callbacks.Register("Draw", "semiragehelper", finverter)