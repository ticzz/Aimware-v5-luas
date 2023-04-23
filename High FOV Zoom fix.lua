gui.Reference("Visuals","Local","Camera","View FOV"):SetInvisible(1)
gui.Reference("Visuals","Local","Camera","Viewmodel FOV"):SetInvisible(1)
local viewfovs = gui.Slider(gui.Reference("Visuals","Local","Camera"), "esp.local.fov.custom", "View FOV", 100, 50, 120 )
local viewmodelfovs = gui.Slider(gui.Reference("Visuals","Local","Camera"), "esp.local.viewmodelfov.custom", "Viewmodel FOV", 54, 40, 90 )
fov_1 = 90
fov_2 = 54
gui.SetValue("esp.local.fov",90)
gui.SetValue("esp.local.viewmodelfov",54)
oldv = gui.GetValue("esp.local.viewmodelfov")
oldi = gui.GetValue("esp.local.fov")
callbacks.Register( "Draw", function()
    if not entities.GetLocalPlayer() then  return end
    if not entities.GetLocalPlayer():IsAlive() then fov_1 = 90 fov_2 = 54 return end
    if entities.GetLocalPlayer():GetProp("m_bIsScoped") ~= 256 and entities.GetLocalPlayer():GetProp("m_bIsScoped") ~= 0 then
        fov_1 = 90
        fov_2 = 54
    else
        fov_1 = viewfovs:GetValue()
        fov_2 = viewmodelfovs:GetValue()
    end
    gui.SetValue("esp.local.fov",fov_1)
    gui.SetValue("esp.local.viewmodelfov",fov_2)
end)
callbacks.Register( "Unload", function() 
    gui.Reference("Visuals","Local","Camera","View FOV"):SetInvisible(0)
    gui.Reference("Visuals","Local","Camera","Viewmodel FOV"):SetInvisible(0) 
    fov_1 = 90
    fov_2 = 54
    viewfovs:SetValue(90)
    viewmodelfovs:SetValue(54)
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

