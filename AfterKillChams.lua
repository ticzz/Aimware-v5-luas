local visual_reference = gui.Reference("Visuals", "Other", "Effects")
local snap_boolean = gui.Checkbox(visual_reference, "thanos_snap", "AfterKill Chams", false)

callbacks.Register("Draw", "thanos_snap_callback", function()
    if not snap_boolean then return end
        gui.SetValue("esp.other.norenderdead", snap_boolean:GetValue() and 0 or 1, true)
	client.SetConVar("cl_ragdoll_physics_enable", snap_boolean:GetValue() and 0 or 1, true)
end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")