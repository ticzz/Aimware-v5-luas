local gui_ref = gui.Reference("Ragebot", "Accuracy", "Weapon")
local gui_dtap = gui.Checkbox(gui_ref, "lua.dtap.fix", "Double Tap Fix", 0)
local cache = {dtap}

callbacks.Register("CreateMove", function(cmd)
    if cache.dtap then
        cmd.sidemove = 0
        cmd.forwardmove = 0
        cache.dtap = false
    end
end)

callbacks.Register("FireGameEvent", function(event)
if not entities.GetLocalPlayer() then return end
    if ( event:GetName() == 'weapon_fire' ) then

        local lp = client.GetLocalPlayerIndex()
        local int_shooter = event:GetInt('userid')
        local index_shooter = client.GetPlayerIndexByUserID(int_shooter)

        if ( index_shooter == lp) then
            if gui_dtap:GetValue() then
                cache.dtap = true
            end
        end
    end
end)

client.AllowListener('weapon_fire')







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

