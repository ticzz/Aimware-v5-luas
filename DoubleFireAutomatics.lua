local DT_REF = gui.Reference( "RAGEBOT", "Accuracy", "Weapon" )
local DT_TAB = gui.Tab(gui.Reference("RAGEBOT"), "doubletap.tab", "Doubletap Automatics")
local DT_GB = gui.Groupbox(DT_TAB, "doubletap.groupbox", "Settings")
local enable = gui.Checkbox( DT_GB, "doubletap.enable", "Doubletap Automatic", 0 )
local selectInterval = gui.Combobox( DT_GB, "doubletap.interval", "Interval", "Off", "Shift", "Rapid")
local selectWeapon = gui.Combobox( DT_GB, "doubletap.weapon", "Weapon", "Autosniper", "Pistols", "Rifles", "SMG", "LMG", "Heavy Pistol", "Current" )


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
local LocalPlayerEntity = entities.GetLocalPlayer()
if not LocalPlayerEntity then return end;
local lp_gwid = LocalPlayerEntity:GetWeaponID()
if not lp_gwid then return end;
if enable:GetValue() == 0 then
return
end
if enable:GetValue() ~= 0 and selectInterval:GetValue() ~= 0 then     
if selectInterval:GetValue() == 1 and selectWeapon:GetValue() ~= 6 then
gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if selectInterval:GetValue() == 2 and selectWeapon:GetValue() ~= 6  then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )
end
if selectWeapon:GetValue() ~= 6  then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )
end                   
end

if enable:GetValue() ~= 0 and selectInterval:GetValue() ~= 0 and selectWeapon:GetValue() == 6 and weaponID[lp_gwid] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lp_gwid]) .. ".doublefire", 1 )
end
if selectInterval:GetValue() == 2 and selectWeapon:GetValue() == 6 and weaponID[lp] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lp_gwid]) .. ".doublefire", 2 )
end
if selectWeapon:GetValue() == 6 and weaponID[lp_gwid] ~= nil then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lp_gwid]) .. ".doublefire", 0 )
end 

if enable:GetValue() ~= 0 and selectInterval:GetValue() ~= 0 and selectWeapon:GetValue() == 6 then
   
    if selectInterval:GetValue() == 1 and weaponID[lp_gwid] ~= nil then
        gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lp_gwid]) .. ".doublefire", 1 )
    end
    if selectInterval:GetValue() == 2 and weaponID[lp_gwid] ~= nil then
        gui.SetValue( "rbot.hitscan.accuracy." .. (weaponID[lp_gwid]) .. ".doublefire", 2 )
    if weaponID[lp_gwid] ~= nil then
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

   
if selectInterval:GetValue() == 1 then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 1 )
end
if selectInterval:GetValue() == 2 then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 2 )

if selectInterval:GetValue() == 0 then
    gui.SetValue( "rbot.hitscan.accuracy." .. (weapons[selectWeapon:GetValue()]) .. ".doublefire", 0 )   
end    
end
end


callbacks.Register( 'Draw', mainFunction )           







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

