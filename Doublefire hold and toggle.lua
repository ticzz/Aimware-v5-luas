
local DT_GB = gui.Groupbox(gui.Reference( "RAGEBOT", "Improvements" ), "Settings")
local selectMode = gui.Combobox( DT_GB, "ragebot.doubletap.mode", "Mode", "Off", "Hold", "Toggle")
local selectInterval = gui.Combobox( DT_GB, "ragebot.doubletap.interval", "Interval", "Off", "Shift", "Rapid")
local selectWeapon = gui.Combobox( DT_GB, "ragebot.doubletap.weapon", "Weapon", "Autosniper", "Pistols", "Rifles", "SMG", "LMG", "Heavy Pistol", "Current" )
local setKey = gui.Keybox( DT_GB, "ragebot.doubletap.key", "Doubletap key", 0 )
local pressed = false;

local weapons = {

[0] = "asniper",
[1] = "pistol",
[2] = "rifle",
[3] = "smg",
[4] = "lmg",
[5] = "hpistol"

}

local weaponID = {
    [61] = "pistol",
    [2] = "pistol",
    [26] = "pistol",
    [63] = "pistol",
    [1] = "hpistol",
    [3] = "pistol",
    [4] = "pistol",
    [32] = "pistol",
    [30] = "pistol",
    [7] = "rifle",
    [8] = "rifle",
    [10] = "rifle",
    [13] = "rifle",
    [60] = "rifle",
    [16] = "rifle",
    [39] = "rifle",
    [17] = "smg",
    [33] = "smg",
    [34] = "smg",
    [23] = "smg",
    [26] = "smg",
    [19] = "smg",
    [24] = "smg",
    [27] = "shotgun",
    [35] = "shotgun",
    [29] = "shotgun",
    [25] = "shotgun",
    [14] = "lmg",
    [28] = "lmg",
    [11] = "asniper",
    [38] = "asniper",
}

local function mainFunction()
local lp = entities.GetLocalPlayer()
if not lp then return end;
local lpwid = lp:GetWeaponID()
if setKey:GetValue() == 0 then
return
end
if setKey:GetValue() ~= 0 and selectMode:GetValue() ~= 0 and selectInterval:GetValue() ~= 0 then     
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 1 and selectWeapon:GetValue() ~= 6 then
gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 2 and selectWeapon:GetValue() ~= 6  then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )
end
if not input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectWeapon:GetValue() ~= 6  then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )
end                   
end

if setKey:GetValue() ~= 0 and selectMode:GetValue() == 1 and selectInterval:GetValue() ~= 0 and selectWeapon:GetValue() == 6 and weaponID[lpwid] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lpwid]) .. ".doublefire", 1 )
end
if input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectInterval:GetValue() == 2 and selectWeapon:GetValue() == 6 and weaponID[lpwid] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lpwid]) .. ".doublefire", 2 )
end
if not input.IsButtonDown(gui.GetValue( "rbot.ragebot.doubletap.tab.ragebot.doubletap.key" ) ) and selectWeapon:GetValue() == 6 and weaponID[lpwid] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lpwid]) .. ".doublefire", 0 )
end 

if setKey:GetValue() ~= 0 and selectMode:GetValue() == 2 and selectInterval:GetValue() ~= 0 and selectWeapon:GetValue() == 6 then
    if input.IsButtonPressed(setKey:GetValue()) then toggle = not toggle
    end   
    if toggle and selectInterval:GetValue() == 1 and weaponID[lpwid] ~= nil then
        gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lpwid]) .. ".doublefire", 1 )
    end
    if toggle and selectInterval:GetValue() == 2 and weaponID[lpwid] ~= nil then
        gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lpwid]) .. ".doublefire", 2 )
    if not toggle and weaponID[lpwid] ~= nil then
        gui.SetValue( "rbot.hitscan.accuracy.pistol.doublefire", 0 )   
        gui.SetValue( "rbot.hitscan.accuracy.rifle.doublefire", 0 ) 
        gui.SetValue( "rbot.hitscan.accuracy.hpistol.doublefire", 0 )  
        gui.SetValue( "rbot.hitscan.accuracy.shotgun.doublefire", 0 )  
        gui.SetValue( "rbot.hitscan.accuracy.asniper.doublefire", 0 ) 
        gui.SetValue( "rbot.hitscan.accuracy.smg.doublefire", 0 )  
        gui.SetValue( "rbot.hitscan.accuracy.lmg.doublefire", 0 )   
    end    
end
end 

if setKey:GetValue() ~= 0 and selectMode:GetValue() == 2 and selectInterval:GetValue() ~= 0 and selectWeapon:GetValue() ~= 6 then
if input.IsButtonPressed(setKey:GetValue()) then toggle = not toggle
end   
if toggle and selectInterval:GetValue() == 1 then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if toggle and selectInterval:GetValue() == 2 then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )
if not toggle then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )   
end    
end
end
end

callbacks.Register( 'Draw', mainFunction )


        







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

