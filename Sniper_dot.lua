local ref = gui.Reference("Visuals","Local","Helper")
local check = gui.Checkbox(ref, "sniper.dot", "Sniper Dot", false)
local color = gui.ColorPicker(ref, "sniper.dot.color", "Sniper Dot Color", 127, 255, 0, 150)

local function is_holding_sniper(weapon)
    if (weapon == nil) then
        return false
    end
    local name = weapon:GetName()

    if (string.find(name, "awp") or string.find(name, "ssg08") or string.find(name, "g3sg1") or string.find(name, "scar20")) then
        return true
    end

    return false
end

callbacks.Register("Draw", function()
    local local_player = entities.GetLocalPlayer()
    if (local_player == nil) then return end
    if (not local_player:IsAlive()) then return end
    local weapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    if(weapon == nil) then return end
if check:GetValue() then
    if (is_holding_sniper(weapon)) then
        local w, h = draw.GetScreenSize()

        draw.Color(color:GetValue())
        draw.FilledCircle(w/2, h/2, 1)
    end
end
end)