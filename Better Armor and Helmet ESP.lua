    local lua_ref = gui.Reference("Visuals", "Overlay", "Enemy", "Armor")

    local lua_enable_armor_esp = gui.Checkbox(lua_ref, "enable_armor_esp", "Enable Better Armor ESP", false)

    --textures
    local png_helmet_open = file.Open("armor esp/helmet.png","r")
    local png_helmet_read = png_helmet_open:Read()
    png_helmet_open:Close()
    local helmet_texture = draw.CreateTexture(common.DecodePNG(png_helmet_read))


    local png_armor_open = file.Open("armor esp/armor.png","r")
    local png_armor_read = png_armor_open:Read()
    png_armor_open:Close()
    local armor_texture = draw.CreateTexture(common.DecodePNG(png_armor_read))

local function draw_esp(builder)
    if not entities:GetLocalPlayer() or not entities:GetLocalPlayer():IsAlive() then return end
    if lua_enable_armor_esp:GetValue() then
        gui.SetValue("esp.overlay.enemy.armor", false)
        local m_armor = builder:GetEntity():GetPropInt("m_ArmorValue")
        local m_helmet = builder:GetEntity():GetPropInt("m_bHasHelmet") 

        if m_armor > 0 and m_helmet == 1 then
            builder:AddIconRight(helmet_texture)
        elseif m_armor > 0 and m_helmet == 0 then
            builder:AddIconRight(armor_texture)
        end
    end
end
callbacks.Register("DrawESP", draw_esp)

callbacks.Register( "Unload", function()

	gui.SetValue("esp.overlay.enemy.armor", true)

end )





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")