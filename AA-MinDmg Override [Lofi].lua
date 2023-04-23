local Lofi = {
    OldDamage = {},
    Keybind = gui.Keybox( gui.Reference( "Ragebot", "Accuracy", "Position Adjustment" ), "lofi.mindmg", "Minimal Damage Override", 0 ),
    Slider = gui.Slider( gui.Reference( "Ragebot", "Accuracy", "Position Adjustment" ), "lofi.override", "Override Damage", 0, 0, 100 ),
    IsDown = false,
    DamageReferences = {
        "rbot.accuracy.weapon.asniper.mindmg",
        "rbot.accuracy.weapon.hpistol.mindmg",
        "rbot.accuracy.weapon.lmg.mindmg",
        "rbot.accuracy.weapon.pistol.mindmg",
        "rbot.accuracy.weapon.rifle.mindmg",
        "rbot.accuracy.weapon.scout.mindmg",
        "rbot.accuracy.weapon.smg.mindmg",
        "rbot.accuracy.weapon.shotgun.mindmg",
        "rbot.accuracy.weapon.shared.mindmg",
        "rbot.accuracy.weapon.sniper.mindmg",
        "rbot.accuracy.weapon.zeus.mindmg"
    }
}

function Lofi:OnDraw()
    if Lofi.Keybind:GetValue() == 0 then
        return --// Keybind is nothing
    end
    local IsDown = input.IsButtonDown( Lofi.Keybind:GetValue() )
    if IsDown and not Lofi.IsDown then
        for i,v in next, Lofi.DamageReferences do
            Lofi.OldDamage[i] = gui.GetValue( v )
        end
    end
    if not IsDown and Lofi.IsDown then
        for i,v in next, Lofi.DamageReferences do
            gui.SetValue( v, Lofi.OldDamage[i] )
        end
        Lofi.IsDown = false
    end
    if IsDown and Lofi.IsDown then
        for i,v in next, Lofi.DamageReferences do
            gui.SetValue( v, Lofi.Slider:GetValue() )
        end
    end
    Lofi.IsDown = IsDown
end

callbacks.Register( "Draw", Lofi.OnDraw )
