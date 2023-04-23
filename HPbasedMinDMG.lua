--gui
local ref = gui.Reference("Ragebot", "Accuracy", "Position Adjustment")
local hp2box = gui.Checkbox(ref, "hp2ck", "HP/X", false)
local hp2slider = gui.Slider(ref, "hp2slider", "HP/X", 2, 2, 6)
local hp2combo = gui.Multibox(ref, "HP/X Weapons")
local hp2auto = gui.Checkbox(hp2combo, "hp2auto", "Auto", false)
local hp2scout = gui.Checkbox(hp2combo, "hp2scout", "Scout", false)
local hp2awp = gui.Checkbox(hp2combo, "hp2awp", "AWP", false)
local hp2rifle = gui.Checkbox(hp2combo, "hp2rifle", "Rifle", false)
local hp2pistol = gui.Checkbox(hp2combo, "hp2pistol", "Pistol", false)
local hp2hvpistol = gui.Checkbox(hp2combo, "hp2hvpistol", "Heavy Pistol", false)
local hp2shotgun = gui.Checkbox(hp2combo, "hp2shotgun", "Shotgun", false)
local hp2smg = gui.Checkbox(hp2combo, "hp2smg", "SMG", false)
local hp2lmg = gui.Checkbox(hp2combo, "hp2lmg", "LMG", false)
local slidernumb = "1" --stops errors
hp2box:SetDescription("Divides Enemies HP By Set Value")




local function handlegui()

    if hp2box:GetValue()then
        hp2combo:SetInvisible(false)
        hp2slider:SetInvisible(false)
     else
        hp2combo:SetInvisible(true)
        hp2slider:SetInvisible(true)
     end
    
    end


local function health(player)
    local enemyhp = player:GetHealth()
    local bruh = hp2slider:GetValue()

    if enemyhp == nil then -- stops stupid errors    
            return
        end

    if hp2box:GetValue() then
        local sethp = (enemyhp / bruh)
                if hp2auto:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", sethp)
                end  
                if hp2scout:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", sethp)
                end
                
                if hp2awp:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", sethp)
                end

                if hp2rifle:GetValue() then 
                    gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", sethp)
                end

                if hp2pistol:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", sethp)
                end

                if hp2shotgun:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", sethp)
                end

                if hp2smg:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", sethp)
                end

                if hp2lmg:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", sethp)
                end

                if hp2hvpistol:GetValue() then
                    gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", sethp)
                end

    else
        return
    end
end



callbacks.Register("AimbotTarget",function(player)

        health(player)

    end)

callbacks.Register("Draw", handlegui)


