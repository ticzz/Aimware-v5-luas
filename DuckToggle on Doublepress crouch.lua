local duck_toggled = false
local temp_crouches = {}

local toggle_key = gui.Keybox(gui.Reference("Misc", "Movement", "Other"), "ToggleDuck.key", "Toggle duck", 17)

callbacks.Register("Draw", function()
    if input.IsButtonReleased(toggle_key:GetValue()) then

        if duck_toggled then
            duck_toggled = false
            temp_crouches = {}
            return
        end

        table.insert(temp_crouches, globals.CurTime())
    end
    if #temp_crouches == 1 then
        if globals.CurTime() - temp_crouches[1] > 1 then
            temp_crouches = {}
        end
    elseif #temp_crouches >= 2 then
        local delay_between_in_presses = temp_crouches[2] - temp_crouches[1]
        if delay_between_in_presses < 0.5 then
            duck_toggled = true
        end
        temp_crouches = {}
    end


end)

callbacks.Register("CreateMove", function(cmd)
    if duck_toggled then
        local buttons = bit.bor(cmd.buttons, 4)
        cmd.buttons = buttons
        return
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

