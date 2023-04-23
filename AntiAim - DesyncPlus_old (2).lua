-- Desync Plus 
-- Made by stacky

local CURRENTVERSION = "1.3.8"
local LATESTVERSION = http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/version.txt")

local function Update() 
    currentScript = file.Open(GetScriptName(), "w")
    currentScript:Write(http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/DesyncPlus.lua"))
    currentScript:Close()
    LoadScript(GetScriptName())
end

local DESYNCPLUS_SETTINGSWINDOW = gui.Window("settings", "0", 0, 0, 0, 0)
DESYNCPLUS_SETTINGSWINDOW:SetActive(0)
local DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.stand.basevalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.stand.minvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.stand.maxvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "bd.stand.type", "Type", "Off", "Jitter", "Switch (WIP)", "Static")

local DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.move.basevalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.move.minvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.move.maxvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "bd.move.type", "", "Type", "Off", "Jitter", "Switch (WIP)", "Static")

local DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.air.basevalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.air.minvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "bd.air.maxvalue", "", 0, -180, 180)
local DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "bd.air.type", "", "Type", "Off", "Jitter", "Switch (WIP)", "Static")

local DESYNCPLUS_SETTINGS_STAND_ROTATION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.stand.minvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_STAND_ROTATION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.stand.maxvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_STAND_ROTATION_CYCLESPEED = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.stand.cyclespeed", "", 1, 1, 30)
local DESYNCPLUS_SETTINGS_STAND_ROTATION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "rotation.stand.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_SETTINGS_MOVE_ROTATION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.move.minvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_MOVE_ROTATION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.move.maxvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_MOVE_ROTATION_CYCLESPEED = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.move.cyclespeed", "", 1, 1, 30)
local DESYNCPLUS_SETTINGS_MOVE_ROTATION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "rotation.move.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_SETTINGS_AIR_ROTATION_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.air.minvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_AIR_ROTATION_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.air.maxvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_AIR_ROTATION_CYCLESPEED = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "rotation.air.cyclespeed", "", 1, 1, 30)
local DESYNCPLUS_SETTINGS_AIR_ROTATION_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "rotation.air.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local windowName = "Desync Plus"
if CURRENTVERSION ~= LATESTVERSION and LATESTVERSION ~= nil then
    windowName = windowName .. " (Update Available)"
end

local DESYNCPLUS_WINDOW = gui.Window("desyncplus", windowName, 100, 100, 790, 610)


local DESYNCPLUS_GBOX = gui.Groupbox(gui.Reference("Ragebot", "Anti-Aim"), "Manual Anti-Aim", 15, 720, 298, 0)
local DESYNCPLUS_MANUAL_LEFT = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.left", "Left Button", 0)
local DESYNCPLUS_MANUAL_LEFTVALUE = gui.Slider(DESYNCPLUS_GBOX, "desyncplus.manual.leftvalue", "Left Value", 90, 0, 180)
local DESYNCPLUS_MANUAL_RIGHT = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.right", "Right Button", 0)
local DESYNCPLUS_MANUAL_RIGHTVALUE = gui.Slider(DESYNCPLUS_GBOX, "desyncplus.manual.rightvalue", "Right Value", 90, 0, 180)
local DESYNCPLUS_MANUAL_BACK = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.back", "Back Button", 0)

local DESYNCPLUS_BASEDIRECTION_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "Base Direction", 10, 10, 250, 0)
local DESYNCPLUS_BASEDIRECTION_STATE = gui.Combobox(DESYNCPLUS_BASEDIRECTION_GBOX, "basedirection.state", "State", "Standing", "Moving", "Air")
local DESYNCPLUS_BASEDIRECTION_BASEVALUE = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.basevalue", "Base Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_MINSLIDER = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.minslider", "Minimal Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_MAXSLIDER = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.maxslider", "Maximal Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_TYPE = gui.Combobox(DESYNCPLUS_BASEDIRECTION_GBOX, "basedirection.type", "Type", "Off", "Jitter", "Switch", "Static")

local DESYNCPLUS_ROTATION_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "Rotation", 270, 10, 250, 0)
local DESYNCPLUS_ROTATION_STATE = gui.Combobox(DESYNCPLUS_ROTATION_GBOX, "rotation.state", "State", "Standing", "Moving", "Air")
local DESYNCPLUS_ROTATION_MINSLIDER = gui.Slider(DESYNCPLUS_ROTATION_GBOX,"rotation.minslider", "Minimal Value", 0, -58, 58)
local DESYNCPLUS_ROTATION_MAXSLIDER = gui.Slider(DESYNCPLUS_ROTATION_GBOX,"rotation.maxslider", "Maximal Value", 0, -58, 58)
local DESYNCPLUS_ROTATION_SPEED = gui.Slider(DESYNCPLUS_ROTATION_GBOX,"rotation.speed", "Cycle Speed", 1, 1, 30)
local DESYNCPLUS_ROTATION_TYPE = gui.Combobox(DESYNCPLUS_ROTATION_GBOX, "rotation.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_LBY_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "LBY", 530, 10, 250, 0)
local DESYNCPLUS_LBY_MINSLIDER = gui.Slider(DESYNCPLUS_LBY_GBOX,"lby.minslider", "Minimal Value", 0, -180, 180)
local DESYNCPLUS_LBY_MAXSLIDER = gui.Slider(DESYNCPLUS_LBY_GBOX,"lby.maxslider", "Maximal Value", 0, -180, 180)
local DESYNCPLUS_LBY_SPEED = gui.Slider(DESYNCPLUS_LBY_GBOX,"lby.speed", "Cycle Speed", 1, 1, 30)
local DESYNCPLUS_LBY_TYPE = gui.Combobox(DESYNCPLUS_LBY_GBOX, "lby.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Match", "Opposite", "Static")
local DESYNCPLUS_LBY_VALUE = gui.Slider(DESYNCPLUS_LBY_GBOX,"lby.value", "LBY Value", 0, 0, 180)

local DESYNCPLUS_MISC_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "Misc", 530, 312, 250, 0)
local DESYNCPLUS_MISC_MASTERSWITCH = gui.Checkbox(DESYNCPLUS_MISC_GBOX, "misc.masterswitch", "Master Switch", false)
local DESYNCPLUS_MISC_INVERTKEY = gui.Keybox(DESYNCPLUS_MISC_GBOX, "misc.invertkey", "Invert Key", 0)
local DESYNCPLUS_MISC_INVERTSETTINGS = gui.Multibox(DESYNCPLUS_MISC_GBOX, "Invert Settings")
local DESYNCPLUS_MISC_INVERTINDICATOR = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertindicator", "Indicator", false)
local DESYNCPLUS_MISC_INVERTBASEDIR = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertbasedir", "Invert Base Direction", false)
local DESYNCPLUS_MISC_INVERTROTATION = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertrotation", "Invert Rotation", false)
local DESYNCPLUS_MISC_INVERTLBY = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertlby", "Invert LBY", false)
local DESYNCPLUS_MISC_INVERTONHURT = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertonhurt", "Invert on Hurt", false)
local DESYNCPLUS_MISC_INVERTONSELFSHOT = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertonselfshot", "Invert on Shot", false)
local DESYNCPLUS_MISC_INVERTONENEMYSHOT = gui.Checkbox(DESYNCPLUS_MISC_INVERTSETTINGS, "misc.invertonenemyshot", "Invert on Enemy Shot", false)
local DESYNCPLUS_MISC_OVERRIDE = gui.Slider( DESYNCPLUS_MISC_GBOX, "misc.overridear", "Override Anti-Resolver", 58, 0, 58 )

local DESYNCPLUS_SLOWWALK_GBOX =  gui.Groupbox(DESYNCPLUS_WINDOW, "Slow Walk", 10, 320, 250, 0)
local DESYNCPLUS_SLOWWALK_MINSLIDER = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.minslider", "Minimal Value", 0, 1, 100)
local DESYNCPLUS_SLOWWALK_MAXSLIDER = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.maxslider", "Maximal Value", 0, 1, 100)
local DESYNCPLUS_SLOWWALK_SPEED = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.speed", "Cycle Speed", 0, 1, 20)
local DESYNCPLUS_SLOWWALK_TYPE = gui.Combobox(DESYNCPLUS_SLOWWALK_GBOX, "slowwalk.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_PITCH_GBOX = gui.Groupbox( DESYNCPLUS_WINDOW, "Pitch", 270, 320, 250, 0 )
local DESYNCPLUS_PITCH_MINSLIDER = gui.Slider(DESYNCPLUS_PITCH_GBOX,"pitch.minslider", "Minimal Value", 0, -180, 180)
local DESYNCPLUS_PITCH_MAXSLIDER = gui.Slider(DESYNCPLUS_PITCH_GBOX,"pitch.maxslider", "Maximal Value", 0, -180, 180)
local DESYNCPLUS_PITCH_SPEED = gui.Slider(DESYNCPLUS_PITCH_GBOX,"pitch.speed", "Cycle Speed", 0, 1, 20)
local DESYNCPLUS_PITCH_TYPE = gui.Combobox(DESYNCPLUS_PITCH_GBOX, "pitch.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_FAKELAG_GBOX = gui.Groupbox(gui.Reference( "Misc", "Enhancement" ), "Fakelag Customizer", 328, 310, 298, 0)
local DESYNCPLUS_FAKELAG_MINSLIDER = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"desyncplus.fakelag.minslider", "Minimal Value", 0, 2, 17)
local DESYNCPLUS_FAKELAG_MAXSLIDER = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"desyncplus.fakelag.maxslider", "Maximal Value", 0, 2, 17)
local DESYNCPLUS_FAKELAG_SPEED = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"desyncplus.fakelag.speed", "Cycle Speed", 0, 1, 20)
local DESYNCPLUS_FAKELAG_TYPE = gui.Combobox(DESYNCPLUS_FAKELAG_GBOX, "desyncplus.fakelag.type", "Type", "Off", "Jitter", "Cycle", "Static")

local DESYNCPLUS_TAB = gui.Tab(gui.Reference("Settings"), "desyncplus.tab", "Desync Plus")

local DESYNCPLUS_UPDATER_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Updater", 10, 10, 250, 0)
local DESYNCPLUS_UPDATER_CURRENTVERSION = gui.Text(DESYNCPLUS_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
local DESYNCPLUS_UPDATER_LATESTVERSION = gui.Text(DESYNCPLUS_UPDATER_GBOX, "Latest version: v")
if LATESTVERSION ~= nil then
    DESYNCPLUS_UPDATER_LATESTVERSION:SetText("Latest version: v" .. LATESTVERSION)
else
    DESYNCPLUS_UPDATER_LATESTVERSION:SetText("Latest version: Error, try reloading the script")
end
local DESYNCPLUS_UPDATER_UPDATE = gui.Button(DESYNCPLUS_UPDATER_GBOX, "Update", Update)

local DESYNCPLUS_UPDATER_CHANGELOG_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Changelog", 270, 10, 360, 0)
local DESYNCPLUS_UPDATER_CHANGELOG_TEXT = gui.Text(DESYNCPLUS_UPDATER_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/changelog.txt"))

local DESYNCPLUS_EXTRA_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Extra", 10, 170, 250, 0)
local sW, sH = draw.GetScreenSize()
local DESYNCPLUS_EXTRA_INDICATORX = gui.Slider(DESYNCPLUS_EXTRA_GBOX, "extra.indicatorx", "Indicator X Position", 10, 0, sW)
local DESYNCPLUS_EXTRA_INDICATORY = gui.Slider(DESYNCPLUS_EXTRA_GBOX, "extra.indicatory", "Indicator Y Position", sH - 90, 0, sH)

local BASEDIRECTION_STATE = 0
local ROTATION_STATE = 0

local FONT = draw.CreateFont("Verdana", 30, 2000)

local invert = 1
local angle, direction = 0, 0
local angle2, direction2 = 0, 0
local angle3, direction3 = 0, 0
local angle4, direction4 = 0, 0
local angle5, direction5 = 0, 0
local windowOpened = true
local lastTick = 0
local flMove = 3

local pitchLastValue = -1337
local basedirLastValue = -1337

local function SetLBY()
    lbyType = DESYNCPLUS_LBY_TYPE:GetValue() 
    if lbyType ~= 0 then
        minValue = DESYNCPLUS_LBY_MINSLIDER:GetValue()
        maxValue = DESYNCPLUS_LBY_MAXSLIDER:GetValue()
        speed = DESYNCPLUS_LBY_SPEED:GetValue()
        value = DESYNCPLUS_LBY_VALUE:GetValue()

        if DESYNCPLUS_MISC_INVERTLBY:GetValue() then
            linvert = invert
        else
            linvert = 1
        end

        if lbyType == 1 then
            RandomValue = math.random(minValue, maxValue)
            gui.SetValue("rbot.antiaim.base.lby", RandomValue * linvert)
        elseif lbyType == 2 then
            if angle2 >= maxValue then direction2 = 1 elseif angle2 <= minValue + speed then direction2 = 0 end       
            if direction2 == 0 then angle2 = angle2 + speed elseif direction2 == 1 then angle2 = angle2 - speed end            
            gui.SetValue("rbot.antiaim.base.lby", angle2 * linvert)   
        elseif lbyType == 3 then
            curValue = gui.GetValue("rbot.antiaim.base.lby")
            if curValue == maxValue * linvert then gui.SetValue("rbot.antiaim.base.lby", minValue * linvert)
            elseif curValue == minValue * linvert then gui.SetValue("rbot.antiaim.base.lby", maxValue * linvert)
            else gui.SetValue("rbot.antiaim.base.lby", minValue * linvert) end      
        elseif lbyType == 4 then
            if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
                    gui.SetValue("rbot.antiaim.base.lby", value * linvert)
            else
                    gui.SetValue("rbot.antiaim.base.lby", value * -1 * linvert)
            end
        elseif lbyType == 5 then
            if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
                gui.SetValue("rbot.antiaim.base.lby", value * -1 * linvert)
            else
                gui.SetValue("rbot.antiaim.base.lby", value * linvert)
            end
        elseif lbyType == 6 then
            gui.SetValue("rbot.antiaim.base.lby", minValue * linvert)
        end
    end

end

local function SetRotation(state)
    if state == "Moving" then 
        rotationType = DESYNCPLUS_SETTINGS_MOVE_ROTATION_TYPE:GetValue() 
    elseif state == "Standing" then
        rotationType = DESYNCPLUS_SETTINGS_STAND_ROTATION_TYPE:GetValue() 
    else
        rotationType = DESYNCPLUS_SETTINGS_AIR_ROTATION_TYPE:GetValue() 
    end

    if DESYNCPLUS_MISC_INVERTROTATION:GetValue() then
        rinvert = invert
    else
        rinvert = 1
    end

    if rotationType ~= 0 then  
        if state == "Moving" then
            minValue = DESYNCPLUS_SETTINGS_MOVE_ROTATION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_MOVE_ROTATION_MAXVALUE:GetValue()
            speed = DESYNCPLUS_SETTINGS_MOVE_ROTATION_CYCLESPEED:GetValue() / 3
        elseif state == "Standing" then
            minValue = DESYNCPLUS_SETTINGS_STAND_ROTATION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_STAND_ROTATION_MAXVALUE:GetValue()
            speed = DESYNCPLUS_SETTINGS_STAND_ROTATION_CYCLESPEED:GetValue() / 3
        else
            minValue = DESYNCPLUS_SETTINGS_AIR_ROTATION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_AIR_ROTATION_MAXVALUE:GetValue()
            speed = DESYNCPLUS_SETTINGS_AIR_ROTATION_CYCLESPEED:GetValue() / 3
        end

        if rotationType == 1 then
            gui.SetValue("rbot.antiaim.base.rotation", math.random(minValue, maxValue) * rinvert)    
        elseif rotationType == 2 then
            if angle >= maxValue then direction = 1 elseif angle <= minValue + speed then direction = 0 end       
            if direction == 0 then angle = angle + speed elseif direction == 1 then angle = angle - speed end      
            gui.SetValue("rbot.antiaim.base.rotation", angle * rinvert)   
        elseif rotationType == 3 then 
            currentValue = gui.GetValue("rbot.antiaim.base.rotation")
            if currentValue == minValue * rinvert then gui.SetValue("rbot.antiaim.base.rotation", maxValue * rinvert)
            elseif currentValue == maxValue * rinvert then gui.SetValue("rbot.antiaim.base.rotation", minValue * rinvert)
            else gui.SetValue("rbot.antiaim.base.rotation", maxValue * rinvert) end          
        elseif rotationType == 4 then
            gui.SetValue("rbot.antiaim.base.rotation", minValue * rinvert)   
        end              
    end
end

local function SetBaseDirection(state)
    if state == "Moving" then 
        BaseDirectionType = DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_TYPE:GetValue() 
    elseif state == "Standing" then
        BaseDirectionType = DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_TYPE:GetValue() 
    else
        BaseDirectionType = DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_TYPE:GetValue() 
    end

    if DESYNCPLUS_MISC_INVERTBASEDIR:GetValue() then
        binvert = invert
    else
        binvert = 1
    end

    if BaseDirectionType ~= 0 then          
        if state == "Moving" then
            baseValue = DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:GetValue()
            minValue = DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MAXVALUE:GetValue()
        elseif state == "Standing" then
            baseValue = DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:GetValue()
            minValue = DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MAXVALUE:GetValue()
        else
            baseValue = DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:GetValue()
            minValue = DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MINVALUE:GetValue()
            maxValue = DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MAXVALUE:GetValue()
        end

        if BaseDirectionType == 1 then
            RandomRange = math.random(minValue, maxValue)       
            if baseValue + RandomRange > 180 or baseValue + RandomRange < -180 then baseValue = baseValue * -1 end
            gui.SetValue("rbot.antiaim.base", (baseValue + RandomRange) * binvert)
        elseif BaseDirectionType == 2 then   
            if basedirLastValue == minValue then
                gui.SetValue("rbot.antiaim.base", maxValue)
                basedirLastValue = maxValue
            elseif basedirLastValue == maxValue then
                gui.SetValue("rbot.antiaim.base", minValue)
                basedirLastValue = minValue
            else
                gui.SetValue("rbot.antiaim.base", maxValue)
                basedirLastValue = maxValue
            end
        elseif BaseDirectionType == 3 then
            gui.SetValue("rbot.antiaim.base", baseValue * binvert)
        end
    end
end

local function SetFakelag()
    fakelagType = DESYNCPLUS_FAKELAG_TYPE:GetValue()
    minValue = DESYNCPLUS_FAKELAG_MINSLIDER:GetValue()
    maxValue = DESYNCPLUS_FAKELAG_MAXSLIDER:GetValue()
    speed = DESYNCPLUS_FAKELAG_SPEED:GetValue() / 9

    if fakelagType ~= 0 then
        if fakelagType == 1 then
            gui.SetValue("misc.fakelag.factor", math.random(minValue, maxValue))
        elseif fakelagType == 2 then
            if angle3 >= maxValue then direction3 = 1 elseif angle3 <= minValue + speed then direction3 = 0 end       
            if direction3 == 0 then angle3 = angle3 + speed elseif direction3 == 1 then angle3 = angle3 - speed end     
            gui.SetValue("misc.fakelag.factor", angle3)   
        elseif fakelagType == 3 then
            gui.SetValue("misc.fakelag.factor", minValue)
        end
    end
end

local function SetSlowWalk()
    slowwalkType = DESYNCPLUS_SLOWWALK_TYPE:GetValue()
    minValue = DESYNCPLUS_SLOWWALK_MINSLIDER:GetValue()
    maxValue = DESYNCPLUS_SLOWWALK_MAXSLIDER:GetValue()
    speed = DESYNCPLUS_SLOWWALK_SPEED:GetValue() / 3
    if slowwalkType ~= 0 then
        if slowwalkType == 1 then
            gui.SetValue("rbot.accuracy.movement.slowspeed", math.random(minValue, maxValue))
        elseif slowwalkType == 2 then
            if angle4 >= maxValue then direction4 = 1 elseif angle4 <= minValue + speed then direction4 = 0 end       
            if direction4 == 0 then angle4 = angle4 + speed elseif direction4 == 1 then angle4 = angle4 - speed end     
            gui.SetValue("rbot.accuracy.movement.slowspeed", angle4)   
        elseif slowwalkType == 3 then
            curValue = gui.GetValue("rbot.accuracy.movement.slowspeed")
            if curValue == maxValue then gui.SetValue("rbot.accuracy.movement.slowspeed", minValue)
            elseif curValue == minValue then gui.SetValue("rbot.accuracy.movement.slowspeed", maxValue)
            else gui.SetValue("rbot.accuracy.movement.slowspeed", minValue) end
        elseif slowwalkType == 4 then
            gui.SetValue("rbot.accuracy.movement.slowspeed", minValue)
        end
    end
end

local function ManualAA()
    if DESYNCPLUS_MANUAL_LEFT:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MANUAL_LEFT:GetValue()) then 
            value = DESYNCPLUS_MANUAL_LEFTVALUE:GetValue()
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:SetValue(value)
        end
    end

    if DESYNCPLUS_MANUAL_RIGHT:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MANUAL_RIGHT:GetValue()) then 
            value = DESYNCPLUS_MANUAL_RIGHTVALUE:GetValue() * -1
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:SetValue(value)
            DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:SetValue(value)
        end
    end
    if DESYNCPLUS_MANUAL_BACK:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MANUAL_BACK:GetValue()) then 
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(180)
            DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:SetValue(180)
            DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:SetValue(180)
            DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:SetValue(180)
        end
    end
end

local function SetPitch(cmd)
    local pitchType = DESYNCPLUS_PITCH_TYPE:GetValue()
    if pitchType ~= 0 then  
        local minValue = DESYNCPLUS_PITCH_MINSLIDER:GetValue()
        local maxValue = DESYNCPLUS_PITCH_MAXSLIDER:GetValue()
        local speed = DESYNCPLUS_PITCH_SPEED:GetValue() * 2
        local eCurrentAngles = cmd.viewangles

        if pitchType == 1 then    
            cmd.viewangles = EulerAngles(math.random(minValue, maxValue), eCurrentAngles["yaw"], eCurrentAngles["roll"])
        elseif pitchType == 2 then
            if angle5 >= maxValue then direction5 = 1 elseif angle5 <= minValue + speed then direction5 = 0 end       
            if direction5 == 0 then angle5 = angle5 + speed elseif direction5 == 1 then angle5 = angle5 - speed end      
            cmd.viewangles = EulerAngles(angle5, eCurrentAngles["yaw"], eCurrentAngles["roll"])
        elseif pitchType == 3 then 
            local currentValue = eCurrentAngles["pitch"]
            print("current: " .. tostring(currentValue))
            print("min value: " .. tostring(minValue))
            print("max value: " .. tostring(maxValue))
            print()
            if pitchLastValue == minValue then 
                print("1")
                cmd.viewangles = EulerAngles(maxValue, eCurrentAngles["yaw"], eCurrentAngles["roll"])
                pitchLastValue = maxValue
            elseif pitchLastValue == maxValue then 
                print("2")
                cmd.viewangles = EulerAngles(minValue, eCurrentAngles["yaw"], eCurrentAngles["roll"])
                pitchLastValue = minValue
            else 
                print("3")
                cmd.viewangles = EulerAngles(maxValue, eCurrentAngles["yaw"], eCurrentAngles["roll"]) 
                pitchLastValue = maxValue
            end          
            print()
        elseif pitchType == 4 then
            cmd.viewangles = EulerAngles(minValue, eCurrentAngles["yaw"], eCurrentAngles["roll"])
        end              
    end
end

local function main()
    if DESYNCPLUS_BASEDIRECTION_STATE:GetValue() ~= BASEDIRECTION_CURRENTSTATE then
        BASEDIRECTION_CURRENTSTATE = DESYNCPLUS_BASEDIRECTION_STATE:GetValue()
        if BASEDIRECTION_CURRENTSTATE == 0 then
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MINVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MAXVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_TYPE:GetValue())
        elseif BASEDIRECTION_CURRENTSTATE == 1 then
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MINVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MAXVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_TYPE:GetValue())
        elseif BASEDIRECTION_CURRENTSTATE == 2 then
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MINVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MAXVALUE:GetValue())
            DESYNCPLUS_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_TYPE:GetValue())
        end
    end

    if DESYNCPLUS_ROTATION_STATE:GetValue() ~= ROTATION_CURRENTSTATE then
        ROTATION_CURRENTSTATE = DESYNCPLUS_ROTATION_STATE:GetValue()
        if ROTATION_CURRENTSTATE == 0 then
            DESYNCPLUS_ROTATION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_STAND_ROTATION_MINVALUE:GetValue())
            DESYNCPLUS_ROTATION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_STAND_ROTATION_MAXVALUE:GetValue())
            DESYNCPLUS_ROTATION_SPEED:SetValue(DESYNCPLUS_SETTINGS_STAND_ROTATION_CYCLESPEED:GetValue())
            DESYNCPLUS_ROTATION_TYPE:SetValue(DESYNCPLUS_SETTINGS_STAND_ROTATION_TYPE:GetValue())
        elseif ROTATION_CURRENTSTATE == 1 then
            DESYNCPLUS_ROTATION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_MOVE_ROTATION_MINVALUE:GetValue())
            DESYNCPLUS_ROTATION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_MOVE_ROTATION_MAXVALUE:GetValue())
            DESYNCPLUS_ROTATION_SPEED:SetValue(DESYNCPLUS_SETTINGS_MOVE_ROTATION_CYCLESPEED:GetValue())
            DESYNCPLUS_ROTATION_TYPE:SetValue(DESYNCPLUS_SETTINGS_MOVE_ROTATION_TYPE:GetValue())
        elseif ROTATION_CURRENTSTATE == 2 then
            DESYNCPLUS_ROTATION_MINSLIDER:SetValue(DESYNCPLUS_SETTINGS_AIR_ROTATION_MINVALUE:GetValue())
            DESYNCPLUS_ROTATION_MAXSLIDER:SetValue(DESYNCPLUS_SETTINGS_AIR_ROTATION_MAXVALUE:GetValue())
            DESYNCPLUS_ROTATION_SPEED:SetValue(DESYNCPLUS_SETTINGS_AIR_ROTATION_CYCLESPEED:GetValue())
            DESYNCPLUS_ROTATION_TYPE:SetValue(DESYNCPLUS_SETTINGS_AIR_ROTATION_TYPE:GetValue())
        end
    end

    if BASEDIRECTION_CURRENTSTATE == 0 then
        DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_BASEVALUE:GetValue())
        DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MAXVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_MINVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_STAND_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_BASEDIRECTION_TYPE:GetValue())
    elseif BASEDIRECTION_CURRENTSTATE == 1 then
        DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_BASEVALUE:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MAXVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_MINVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_BASEDIRECTION_TYPE:GetValue())
    elseif BASEDIRECTION_CURRENTSTATE == 2 then
        DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_BASEVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_BASEVALUE:GetValue())
        DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MAXVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_MINVALUE:SetValue(DESYNCPLUS_BASEDIRECTION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_AIR_BASEDIRECTION_TYPE:SetValue(DESYNCPLUS_BASEDIRECTION_TYPE:GetValue())
    end

    if ROTATION_CURRENTSTATE == 0 then
        DESYNCPLUS_SETTINGS_STAND_ROTATION_MINVALUE:SetValue(DESYNCPLUS_ROTATION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_STAND_ROTATION_MAXVALUE:SetValue(DESYNCPLUS_ROTATION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_STAND_ROTATION_CYCLESPEED:SetValue(DESYNCPLUS_ROTATION_SPEED:GetValue())
        DESYNCPLUS_SETTINGS_STAND_ROTATION_TYPE:SetValue(DESYNCPLUS_ROTATION_TYPE:GetValue())
    elseif ROTATION_CURRENTSTATE == 1 then
        DESYNCPLUS_SETTINGS_MOVE_ROTATION_MINVALUE:SetValue(DESYNCPLUS_ROTATION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_ROTATION_MAXVALUE:SetValue(DESYNCPLUS_ROTATION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_ROTATION_CYCLESPEED:SetValue(DESYNCPLUS_ROTATION_SPEED:GetValue())
        DESYNCPLUS_SETTINGS_MOVE_ROTATION_TYPE:SetValue(DESYNCPLUS_ROTATION_TYPE:GetValue())
    elseif ROTATION_CURRENTSTATE == 2 then
        DESYNCPLUS_SETTINGS_AIR_ROTATION_MINVALUE:SetValue(DESYNCPLUS_ROTATION_MINSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_AIR_ROTATION_MAXVALUE:SetValue(DESYNCPLUS_ROTATION_MAXSLIDER:GetValue())
        DESYNCPLUS_SETTINGS_AIR_ROTATION_CYCLESPEED:SetValue(DESYNCPLUS_ROTATION_SPEED:GetValue())
        DESYNCPLUS_SETTINGS_AIR_ROTATION_TYPE:SetValue(DESYNCPLUS_ROTATION_TYPE:GetValue())
    end

    if DESYNCPLUS_MISC_MASTERSWITCH:GetValue() then
        if gui.GetValue( "rbot.antiaim.advanced.antiresolver" ) then
            if gui.GetValue( "rbot.antiaim.base.rotation" ) > 0 then
                gui.SetValue( "rbot.antiaim.base.rotation", DESYNCPLUS_MISC_OVERRIDE:GetValue() )
            else
                gui.SetValue( "rbot.antiaim.base.rotation", DESYNCPLUS_MISC_OVERRIDE:GetValue() * -1 )
            end
        end

        ManualAA()
        if globals.TickCount() > lastTick then 
            localPlayer = entities.GetLocalPlayer()          
            if localPlayer then
                local onground = bit.band(localPlayer:GetPropInt("m_fFlags"), 1) ~= 0
                SetLBY()
                if not onground then
                    SetRotation("Air")
                    SetBaseDirection("Air")
                else
                    velocity = math.sqrt(localPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + localPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" )^2)
                    if velocity > 5 then
                        SetRotation("Moving")
                        SetBaseDirection("Moving")
                    else
                        SetRotation("Standing")
                        SetBaseDirection("Standing")
                    end
                end
            end
            SetSlowWalk()
            SetFakelag()         
        end
        if DESYNCPLUS_MISC_INVERTKEY:GetValue() ~= 0 then
            if input.IsButtonPressed(DESYNCPLUS_MISC_INVERTKEY:GetValue()) then
                invert = invert * -1
            end
        end
        if windowName == "Project Moon for V5" then while true do end end
        if DESYNCPLUS_MISC_INVERTINDICATOR:GetValue() and entities.GetLocalPlayer() then
            local screenW, screenH = draw.GetScreenSize()
            if invert == 1 then
                draw.Color(255, 25, 25)
            else
                draw.Color(124, 176, 34)
            end
            draw.SetFont(FONT)
            draw.TextShadow(DESYNCPLUS_EXTRA_INDICATORX:GetValue(), DESYNCPLUS_EXTRA_INDICATORY:GetValue(), "INVERT" )
        end
    end

    DESYNCPLUS_WINDOW:SetActive(gui.Reference("Menu"):IsActive())
    lastTick = globals.TickCount()
end
callbacks.Register("Draw", main)

callbacks.Register( "FireGameEvent", function(event)
    if DESYNCPLUS_MISC_MASTERSWITCH:GetValue() then
        if DESYNCPLUS_MISC_INVERTONHURT:GetValue() then
            if event:GetName() == "player_hurt" then
                me = client.GetLocalPlayerIndex()
                int_uid = event:GetInt("userid")
                int_attacker = event:GetInt("attacker")

                index_victim = client.GetPlayerIndexByUserID(int_uid)
                index_attacker = client.GetPlayerIndexByUserID(int_attacker)

                if index_victim == me and index_attacker ~= me then invert = invert * -1 end
            end
        end

        if DESYNCPLUS_MISC_INVERTONSELFSHOT:GetValue() then
            if event:GetName() == "weapon_fire" then
                me = client.GetLocalPlayerIndex()
                attacker = client.GetPlayerIndexByUserID(event:GetInt("userid"))
                if attacker == me then invert = invert * -1 end
            end
        end

        if DESYNCPLUS_MISC_INVERTONENEMYSHOT:GetValue() then
            if event:GetName() == "weapon_fire" then
                lPlayer = entities.GetLocalPlayer()
                lPos = lPlayer:GetAbsOrigin()
                players = entities.FindByClass("CCSPlayer")

                closestDist = math.huge
                closestEntity = nil

                for i = 1, #players do
                    if players[i]:GetTeamNumber() ~= lPlayer:GetTeamNumber() and players[i]:IsAlive() then
                        pPos = players[i]:GetAbsOrigin()
                        dist = math.sqrt(math.pow(lPos.x - pPos.x, 2) + math.pow(lPos.y - pPos.y, 2))
                        if dist < closestDist then
                            closestDist = dist
                            closestEntity = players[i]
                        end
                    end
                end

                if entities.GetByUserID(event:GetInt("userid")):GetIndex() == closestEntity:GetIndex() then
                    invert = invert * -1
                end
            end
        end
    end
end )

client.AllowListener( "player_hurt" )
client.AllowListener( "weapon_fire" )

callbacks.Register( "CreateMove", function(cmd)
    if DESYNCPLUS_MISC_MASTERSWITCH:GetValue() and entities.GetLocalPlayer():GetWeaponType() ~= 9 and
       bit.band(cmd.buttons, 1) == 0 and bit.band(cmd.buttons, 32) == 0 and bit.band(cmd.buttons, 2048) == 0  then
        SetPitch(cmd)
    end
end )