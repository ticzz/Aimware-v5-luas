
--MouseWhellAdjust By An
local WheelTab    = gui.Tab(gui.Reference("MISC"), "MISC.Wheel", "WhellAdjust")
local KeyGroup    = gui.Groupbox(WheelTab, "Master", 20, 20, 240, 200)
local WheelGroup  = gui.Groupbox(WheelTab, "Value", 280, 20, 300, 200)

local DMGKey      = gui.Checkbox( KeyGroup, "DMGKey", "DMG Checkbox", 0 )
local DMGValue    = gui.Slider( WheelGroup, "DMGValue", "DMG Value", 5, 1, 20 )
local HCKey       = gui.Checkbox( KeyGroup, "HCKey", "HC Checkbox", 0 )
local HCValue     = gui.Slider( WheelGroup, "HCValue", "HC Value", 5, 1, 20 )

local Indicator   = gui.Checkbox( KeyGroup, "Indicator", "Indicator", 1 )

function MouseWhell ()

    DMGOver = DMGKey:GetValue()
    HCOver  = HCKey :GetValue()
    MouseW  = input.GetMouseWheelDelta
    ScreenW, ScreenH = draw.GetScreenSize()
    XCenter = ScreenW / 2
    YCenter = ScreenH / 2
    
    if (entities.GetLocalPlayer() ~= nil) then
        hLocalPlayer = entities.GetLocalPlayer()
        wid = hLocalPlayer:GetWeaponID()
    end
    
    if  (wid == 1 or wid == 64) then
        Weapon = "hpistol"
    
    elseif  (wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63) then
        Weapon = "pistol"
    
    elseif  (wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60) then
        Weapon = "rifle"
    
    elseif  (wid == 11 or wid == 38) then
        Weapon = "asniper"
    
    elseif  (wid == 40) then
        Weapon = "scout"
    
    elseif  (wid == 9) then
        Weapon = "sniper"
    
    elseif  (wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34) then
        Weapon = "smg"
    
    elseif  (wid == 14 or wid == 28) then
        Weapon = "lmg"
    
    elseif  (wid == 25 or wid == 27 or wid == 29 or wid == 35) then
        Weapon = "shotgun"
    end
    
    if DMGOver or HCOver then
        client.Command("unbind MWHEELUP", true)
        client.Command("unbind MWHEELDOWN", true)
        if DMGOver then
            DMGWheel()
        end
        if HCOver then
            HCWheel()
        end
    else
        client.Command("bind MWHEELUP invprev", true)
        client.Command("bind MWHEELDOWN invnext", true)
    end


end

function DMGWheel()
    if MouseW() <= 0 then
        WeaponDMGValue = gui.GetValue( "rbot.hitscan.accuracy." .. Weapon .. ".mindamage" )
    else
        gui.SetValue( "rbot.hitscan.accuracy." .. Weapon .. ".mindamage", WeaponDMGValue+DMGValue:GetValue() )
    end
    if MouseW() >= 0 then
        WeaponDMGValue = gui.GetValue( "rbot.hitscan.accuracy." .. Weapon .. ".mindamage" )
    else
        gui.SetValue( "rbot.hitscan.accuracy." .. Weapon .. ".mindamage", WeaponDMGValue-DMGValue:GetValue() )
    end
    
    if Indicator:GetValue() then
        draw.Color( 255, 255, 255, 255 )
        draw.Text( XCenter-150, YCenter+30, "———" ..  WeaponDMGValue+2 )
        draw.Text( XCenter-150, YCenter+15, "——" ..  WeaponDMGValue+1 )
        draw.Text( XCenter-150, YCenter-15, "——" ..  WeaponDMGValue-1 )
        draw.Text( XCenter-150, YCenter-30, "———" ..  WeaponDMGValue-2 )
        draw.Color( 0, 255, 0, 255 )
        draw.Text( XCenter-150, YCenter,"—" ..  WeaponDMGValue .. "    DMG" )
    end
end

function HCWheel()
    if MouseW() <= 0 then
        WeaponHCValue = gui.GetValue( "rbot.hitscan.accuracy." .. Weapon .. ".hitchance" )
    else
        gui.SetValue( "rbot.hitscan.accuracy." .. Weapon .. ".hitchance", WeaponHCValue+HCValue:GetValue() )
    end
    if MouseW() >= 0 then
        WeaponHCValue = gui.GetValue( "rbot.hitscan.accuracy." .. Weapon .. ".hitchance" )
    else
        gui.SetValue( "rbot.hitscan.accuracy." .. Weapon .. ".hitchance", WeaponHCValue-HCValue:GetValue() )
    end
    
    if Indicator:GetValue() then
        draw.Color( 255, 255, 255, 255 )
        draw.Text( XCenter+100, YCenter+30,  WeaponHCValue+2 .. "———" )
        draw.Text( XCenter+100, YCenter+15, "   " ..  WeaponHCValue+1 .. "——"  )
        draw.Text( XCenter+100, YCenter-15, "   "  .. WeaponHCValue-1 .. "——" )
        draw.Text( XCenter+100, YCenter-30,  WeaponHCValue-2 .. "———" )
        draw.Color( 0, 255, 0, 255 )
        draw.Text( XCenter+ 76, YCenter,"HC        " ..  WeaponHCValue ..  "—" )
    end
end

callbacks.Register( "Draw", 'MouseWhell', MouseWhell )





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

