local KEY = gui.Keybox(gui.Reference("Misc", "Enhancement", "Fakelag"), "misc.fakelag.fix.key", "Fakelag Fix key", 0)
KEY:SetDescription("Set this key to your push to talk button.")
callbacks.Register("Draw", function()
    if KEY:GetValue() ~= 0 then
        if input.IsButtonDown(KEY:GetValue()) then
            gui.SetValue("misc.fakelag.enable", false)
        else
            gui.SetValue("misc.fakelag.enable", true)
        end
    end
end)