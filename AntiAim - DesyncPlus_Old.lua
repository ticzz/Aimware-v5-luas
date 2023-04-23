-- Desync Plus 
-- Made by stacky

--local CURRENTVERSION = "1.3"
--local LATESTVERSION = http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/version.txt")
--
--local function Update() 
--    currentScript = file.Open(GetScriptName(), "w")
--    currentScript:Write(http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/DesyncPlus.lua"))
--    currentScript:Close()
--    LoadScript(GetScriptName())
--end

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

local DESYNCPLUS_SETTINGS_SLOWWALK_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "slowwalk.minvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_SLOWWALK_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "slowwalk.maxvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_SLOWWALK_CYCLESPEED = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "slowwalk.cyclespeed", "", 1, 1, 30)
local DESYNCPLUS_SETTINGS_SLOWWALK_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "slowwalk.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_SETTINGS_FAKELAG_MINVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "fakelag.minvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_FAKELAG_MAXVALUE = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "fakelag.maxvalue", "", 0, -58, 58)
local DESYNCPLUS_SETTINGS_FAKELAG_CYCLESPEED = gui.Slider(DESYNCPLUS_SETTINGSWINDOW, "fakelag.cyclespeed", "", 1, 1, 30)
local DESYNCPLUS_SETTINGS_FAKELAG_TYPE = gui.Combobox(DESYNCPLUS_SETTINGSWINDOW, "fakelag.type", "Type", "Off", "Jitter", "Cycle", "Static")

local DESYNCPLUS_SETTINGS_MASTERSWITCH = gui.Checkbox(DESYNCPLUS_SETTINGSWINDOW, "misc.masterswitch", "", false)
local DESYNCPLUS_SETTINGS_FAKELAGSTAND = gui.Checkbox(DESYNCPLUS_SETTINGSWINDOW, "misc.fakelagstand", "", false)

--local windowName = "Desync Plus"
--if CURRENTVERSION ~= LATESTVERSION then
--    windowName = windowName .. " (Update Available)"
--end
local DesyncPlus_ref = gui.Reference("Ragebot")
local DESYNCPLUS_tab = gui.Tab(DesyncPlus_ref, "lus_desyncplus_tab", "DesyncPlus")
local DesyncPlus_Group = gui.Groupbox(DESYNCPLUS_tab, "DesyncPlus Config", 15, 15)
local DesyncPluschkbx = gui.Checkbox(DesyncPlus_Group, "lua_desyncplus_configurate", "Show DesyncPlus Configuration", false) 
local DESYNCPLUS_WINDOW = gui.Window("desyncplus", windowName, 100, 100, 790, 610)

local DESYNCPLUS_GBOX = gui.Groupbox(gui.Reference("Ragebot", "Anti-Aim"), "Manual Anti-Aim", 15, 650, 300, 0)
local DESYNCPLUS_MANUAL_LEFT = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.left", "Left Button", 0)
local DESYNCPLUS_MANUAL_RIGHT = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.right", "Right Button", 0)
local DESYNCPLUS_MANUAL_BACK = gui.Keybox(DESYNCPLUS_GBOX, "desyncplus.manual.back", "Back Button", 0)

local DESYNCPLUS_BASEDIRECTION_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "Base Direction", 10, 10, 250, 0)
local DESYNCPLUS_BASEDIRECTION_STATE = gui.Combobox(DESYNCPLUS_BASEDIRECTION_GBOX, "basedirection.state", "State", "Standing", "Moving", "Air")
local DESYNCPLUS_BASEDIRECTION_BASEVALUE = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.basevalue", "Base Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_MINSLIDER = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.minslider", "Minimal Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_MAXSLIDER = gui.Slider(DESYNCPLUS_BASEDIRECTION_GBOX,"basedirection.maxslider", "Maximal Value", 0, -180, 180)
local DESYNCPLUS_BASEDIRECTION_TYPE = gui.Combobox(DESYNCPLUS_BASEDIRECTION_GBOX, "basedirection.type", "Type", "Off", "Jitter", "Switch (WIP)", "Static")

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

local DESYNCPLUS_SLOWWALK_GBOX =  gui.Groupbox(DESYNCPLUS_WINDOW, "Slow Walk", 10, 320, 250, 0)
local DESYNCPLUS_SLOWWALK_MINSLIDER = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.minslider", "Minimal Value", 0, 1, 100)
local DESYNCPLUS_SLOWWALK_MAXSLIDER = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.maxslider", "Maximal Value", 0, 1, 100)
local DESYNCPLUS_SLOWWALK_SPEED = gui.Slider(DESYNCPLUS_SLOWWALK_GBOX,"slowwalk.speed", "Cycle Speed", 0, 1, 20)
local DESYNCPLUS_SLOWWALK_TYPE = gui.Combobox(DESYNCPLUS_SLOWWALK_GBOX, "slowwalk.type", "Type", "Off", "Jitter", "Cycle", "Switch", "Static")

local DESYNCPLUS_FAKELAG_GBOX = gui.Groupbox(DESYNCPLUS_WINDOW, "Fakelag", 270, 320, 250, 0)
local DESYNCPLUS_FAKELAG_MINSLIDER = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"fakelag.minslider", "Minimal Value", 0, 2, 17)
local DESYNCPLUS_FAKELAG_MAXSLIDER = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"fakelag.maxslider", "Maximal Value", 0, 2, 17)
local DESYNCPLUS_FAKELAG_SPEED = gui.Slider(DESYNCPLUS_FAKELAG_GBOX,"fakelag.speed", "Cycle Speed", 0, 1, 20)
local DESYNCPLUS_FAKELAG_TYPE = gui.Combobox(DESYNCPLUS_FAKELAG_GBOX, "fakelag.type", "Type", "Off", "Jitter", "Cycle", "Static")

local DESYNCPLUS_TAB = gui.Tab(gui.Reference("Settings"), "desyncplus.tab", "Desync Plus")
--
--local DESYNCPLUS_UPDATER_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Updater", 10, 10, 250, 0)
--local DESYNCPLUS_UPDATER_CURRENTVERSION = gui.Text(DESYNCPLUS_UPDATER_GBOX, "Current version: v" .. CURRENTVERSION)
--local DESYNCPLUS_UPDATER_LATESTVERSION = gui.Text(DESYNCPLUS_UPDATER_GBOX, "Latest version: v" .. LATESTVERSION)
--local DESYNCPLUS_UPDATER_UPDATE = gui.Button(DESYNCPLUS_UPDATER_GBOX, "Update", Update)
--
--local DESYNCPLUS_UPDATER_CHANGELOG_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Changelog", 270, 10, 360, 0)
--local DESYNCPLUS_UPDATER_CHANGELOG_TEXT = gui.Text(DESYNCPLUS_UPDATER_CHANGELOG_GBOX, http.Get("https://raw.githubusercontent.com/stqcky/DesyncPlus/master/changelog.txt"))


local function check_stuff()
    if DesyncPluschkbx:GetValue() and gui.Reference("MENU"):IsActive() == true then
        DESYNCPLUS_WINDOW:SetActive(1)
    else
        DESYNCPLUS_WINDOW:SetActive(0)
    end
end


local DESYNCPLUS_EXTRA_GBOX = gui.Groupbox(DESYNCPLUS_TAB, "Extra", 10, 175, 250, 0)
local DESYNCPLUS_EXTRA_TOGGLEWINDOW = gui.Button(DESYNCPLUS_EXTRA_GBOX, "Toggle Window", toggleWindow)

local BASEDIRECTION_STATE = 0
local ROTATION_STATE = 0

local invert = 1
local angle, direction = 0, 0
local angle2, direction2 = 0, 0
local angle3, direction3 = 0, 0
local angle4, direction4 = 0, 0
local windowOpened = true
local lastTick = 0
local flMove = 3

local function SetLBY()
    lbyType = DESYNCPLUS_LBY_TYPE:GetValue() 
    if lbyType ~= 0 then
        minValue = DESYNCPLUS_LBY_MINSLIDER:GetValue()
        maxValue = DESYNCPLUS_LBY_MAXSLIDER:GetValue()
        speed = DESYNCPLUS_LBY_SPEED:GetValue()
        value = DESYNCPLUS_LBY_VALUE:GetValue()

        if lbyType == 1 then
            RandomValue = math.random(minValue, maxValue)
            gui.SetValue("rbot.antiaim.base.lby", RandomValue * invert)
        elseif lbyType == 2 then
            if angle2 >= maxValue then direction2 = 1 elseif angle2 <= minValue + speed then direction2 = 0 end       
            if direction2 == 0 then angle2 = angle2 + speed elseif direction2 == 1 then angle2 = angle2 - speed end            
            gui.SetValue("rbot.antiaim.base.lby", angle2 * invert)   
        elseif lbyType == 3 then
            curValue = gui.GetValue("rbot.antiaim.base.lby")
            if curValue == maxValue * invert then gui.SetValue("rbot.antiaim.base.lby", minValue * invert)
            elseif curValue == minValue * invert then gui.SetValue("rbot.antiaim.base.lby", maxValue * invert)
            else gui.SetValue("rbot.antiaim.base.lby", minValue * invert) end      
        elseif lbyType == 4 then
            if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
                    gui.SetValue("rbot.antiaim.base.lby", value * invert)
            else
                    gui.SetValue("rbot.antiaim.base.lby", value * -1 * invert)
            end
        elseif lbyType == 5 then
            if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
                gui.SetValue("rbot.antiaim.base.lby", value * -1 * invert)
            else
                gui.SetValue("rbot.antiaim.base.lby", value * invert)
            end
        elseif lbyType == 6 then
            gui.SetValue("rbot.antiaim.base.lby", minValue * invert)
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
            gui.SetValue("rbot.antiaim.base.rotation", math.random(minValue, maxValue) * invert)    
        elseif rotationType == 2 then
            if angle >= maxValue then direction = 1 elseif angle <= minValue + speed then direction = 0 end       
            if direction == 0 then angle = angle + speed elseif direction == 1 then angle = angle - speed end      
            gui.SetValue("rbot.antiaim.base.rotation", angle * invert)   
        elseif rotationType == 3 then 
            currentValue = gui.GetValue("rbot.antiaim.base.rotation")
            if currentValue == minValue * invert then gui.SetValue("rbot.antiaim.base.rotation", maxValue * invert)
            elseif currentValue == maxValue * invert then gui.SetValue("rbot.antiaim.base.rotation", minValue * invert)
            else gui.SetValue("rbot.antiaim.base.rotation", maxValue * invert) end          
        elseif rotationType == 4 then
            gui.SetValue("rbot.antiaim.base.rotation", minValue * invert)   
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
            gui.SetValue("rbot.antiaim.base", baseValue + RandomRange)
        elseif BaseDirectionType == 2 then   
            --aaaaaaaaaaaaaaaaaaaaa
        elseif BaseDirectionType == 3 then
            gui.SetValue("rbot.antiaim.base", baseValue)
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
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(90)
        end
    end

    if DESYNCPLUS_MANUAL_RIGHT:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MANUAL_RIGHT:GetValue()) then 
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(-90)
        end
    end
    if DESYNCPLUS_MANUAL_BACK:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MANUAL_BACK:GetValue()) then 
            DESYNCPLUS_BASEDIRECTION_BASEVALUE:SetValue(180)
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
        ManualAA()
        if globals.TickCount() > lastTick then 
            localPlayer = entities.GetLocalPlayer()
            local onground = bit.band(localPlayer:GetPropInt("m_fFlags"), 1) ~= 0
            if localPlayer then 
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
    end

    if DESYNCPLUS_MISC_INVERTKEY:GetValue() ~= 0 then
        if input.IsButtonPressed(DESYNCPLUS_MISC_INVERTKEY:GetValue()) then
            invert = invert * -1
        end
    end

    if input.IsButtonPressed(45) then 
        if windowOpened then DESYNCPLUS_WINDOW:SetActive(0) else DESYNCPLUS_WINDOW:SetActive(1) end 
        windowOpened = not windowOpened
    end
    lastTick = globals.TickCount()
end
callbacks.Register("Draw", main)
callbacks.Register("Draw", "Desyncpluswindow_thing", check_stuff)
