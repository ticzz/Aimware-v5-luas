--Coded by m0nsterJ#7898
local guiReference = gui.Reference("Ragebot", "Accuracy", "Movement")
local idealtickbox = gui.Checkbox(guiReference, "rbot.accuracy.movement.autopeekidealtick", "Ideal Tick", false)
local autopeekm=gui.Checkbox(guiReference,"rbot.accuracy.movement.autopeekidealtick.dtmode", "Autopeek Mode", 0)
local offautopeekdtmode=gui.Combobox(guiReference,"rbot.accuracy.movement.autopeekidealtick.offautopeek", "Off Autopeek DT Mode", "None", "Defensive", "Offensive")
idealtickbox:SetDescription("Enable Ideal Tick.")
autopeekm:SetDescription("Enable DT mode toggle if autopeek is disabled.")

local function idealtick()
    if idealtickbox:GetValue() == true then
        if autopeekm:GetValue() == true then

            if offautopeekdtmode:GetValue() == 2 then
    
                gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 2)
                gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 2)
    
        elseif offautopeekdtmode:GetValue() == 1 then
    
                gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 1)
                gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 1)
    
        elseif offautopeekdtmode:GetValue() == 0 then
    
                gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 0)
                gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 0)
            end
        end

    if input.IsButtonPressed(gui.GetValue("rbot.accuracy.movement.autopeekkey")) then
        toggle = not toggle
      end
    if not toggle then
    gui.SetValue("rbot.hitscan.accuracy.pistol.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.smg.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.rifle.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.shotgun.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.asniper.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.lmg.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 1)
    gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 1)
    gui.SetValue("rbot.antiaim.advanced.autodir.edges", 1)
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0)
    gui.SetValue("rbot.antiaim.left", 90, "Desync")
    gui.SetValue("rbot.antiaim.right", -90, "Desync")
    else
    gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0)
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", 1)
        end
    end
end

callbacks.Register("Draw", idealtick)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")