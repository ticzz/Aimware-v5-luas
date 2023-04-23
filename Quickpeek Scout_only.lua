local aimbot_extra = gui.Reference("Ragebot", "Aimbot", "Extra")

local quickpeek_key = gui.Keybox(aimbot_extra, "C_QuickPeek.key", "QuickPeek key", 0)
quickpeek_key:SetDescription("(ESC to clear)")

function blacklisted()
    local blacklisted_weapons = {
        "CKnife",
        "CMolotovGrenade",
        "CSmokeGrenade",
        "CHEGrenade",
        "CFlashbang",
        "CDecoyGrenade",
        "CIncendiaryGrenade"
    }
    if not entities.GetLocalPlayer() then return true end
    if not entities.GetLocalPlayer():IsAlive() then return true end
    local weapon_class = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon"):GetClass()
    for k, blacklisted_weapon in pairs(blacklisted_weapons) do
        if blacklisted_weapon == weapon_class then
            return true
        end
    end
    return false

end


local reset_shots = 0
callbacks.Register("Draw", function()
    if (input.IsButtonReleased(65) or input.IsButtonReleased(68) or (not input.IsButtonDown(65) and not input.IsButtonDown(68))) and reset_shots >= 1 then
        reset_shots = 0
    end
    
end)

callbacks.Register("AimbotTarget", function()
    reset_shots = reset_shots + 1
end)

callbacks.Register("CreateMove", function(cmd)
    if blacklisted() then return end
    
    if quickpeek_key:GetValue() ~= 0 and not input.IsButtonDown(quickpeek_key:GetValue()) then
        return
    end
    
    if reset_shots >= 1 then
        if input.IsButtonDown(65) then -- A
            cmd.sidemove = 255
        elseif input.IsButtonDown(68) then -- D
            cmd.sidemove = -255
        end
    end
    
    if cmd.buttons == 4194305 then
        reset_shots = reset_shots + 1
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

