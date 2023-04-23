 --[[Made by superyu'#7167]]--
VALUE = gui.Slider(gui.Reference("Visuals", "World", "Materials"), "esp.world.materials.nightmode", "Nightmode", 1, 1, 100);
APPLY = gui.Button(gui.Reference("Visuals", "World", "Materials"), "Apply Nightmode", function()
    local v = (100 - VALUE:GetValue()) / 100
    materials.Enumerate(function(mat)
        if string.find(mat:GetTextureGroupName(), "World") then
            mat:ColorModulate(v, v, v);
        end
    end)
end)
