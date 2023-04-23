local multiplier = 1
local inverter_key_b = gui.Keybox((gui.Reference("Ragebot", "Anti-Aim", "Advanced")), "inverter", "Invert Key", 0)

inverter_key_b:SetDescription("Invert your base rotation angle.")

local function inverter()
    
    if inverter_key_b:GetValue() ~= 0 then
        if input.IsButtonPressed(inverter_key_b:GetValue()) then

            multiplier = -1
        else
            multiplier = 1
        end

        gui.SetValue("rbot.antiaim.base.rotation", gui.GetValue("rbot.antiaim.base.rotation") * multiplier)
    end
end

callbacks.Register("Draw", inverter)


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")