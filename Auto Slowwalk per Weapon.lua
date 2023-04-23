local ref = gui.Reference("RAGEBOT", "ACCURACY", "Movement")
local pistol = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.pistol", "Pistol SlowWalk Speed", 30, 0, 30)
local heavypistol = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.heavypistol", "Heavy Pistol SlowWalk Speed", 30, 0, 30)
local submachine = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.submachineGun", "Submachine Gun SlowWalk Speed", 30, 0, 30)
local rifle = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.rifle", "Rifle SlowWalk Speed", 30, 0, 30)
local shotgun = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.shotgun", "Shotgun SlowWalk Speed", 30, 0, 30)
local scout = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.scout", "Scout SlowWalk Speed", 30, 0, 30)
local autosniper = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.autosniper", "Autosniper SlowWalk Speed", 30, 0, 30)
local awp = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.awp", "AWP SlowWalk Speed", 30, 0, 30)
local light = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.light", "Light Machine Gun SlowWalk Speed", 30, 0, 30)
local zeus = gui.Slider(ref, "rbot.accuracy.movement.slowspeed.zeus", "Zeus SlowWalk Speed", 30, 0, 30)

local value
local set = 0
local setweapon

local function slowspeed()
if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
    local activeweapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    local weapon = activeweapon:GetWeaponType()

    if setweapon ~= tostring(activeweapon) then
        set = 0
    end

    if set == 0 then
        set = 1
        setweapon = tostring(activeweapon)
        if tostring(activeweapon) == "weapon_taser" then
            value = zeus:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 1 then
        if tostring(activeweapon) == "weapon_revolver" or tostring(activeweapon) == "weapon_deagle" then
            value = heavypistol:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        else
            value = pistol:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        end
        elseif weapon == 2 then
            value = submachine:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 3 then
            value = rifle:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 4 then
            value = shotgun:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 5 then
            if tostring(activeweapon) == "weapon_ssg08" then
                value = scout:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            elseif tostring(activeweapon) == "weapon_awp" then
                value = awp:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            elseif tostring(activeweapon) == "weapon_g3sg1" or tostring(activeweapon) == "weapon_scar20" then  
                value = autosniper:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            end
        elseif weapon == 6 then
            value = light:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        end
    end
end
end
callbacks.Register("Draw", slowspeed)
