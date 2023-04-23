-- Gui

local friendly_name_Reference = gui.Reference( "Visuals" , "Overlay" , "Friendly" , "Name" );
local friendly_name_Checkbox = gui.Checkbox( gui.Reference( "Visuals" , "Overlay" , "Friendly" ), "esp.overlay.friendly.name", "Name", 0 );
local friendly_name_ColorPicker = gui.ColorPicker( friendly_name_Checkbox, "clr", "clr", 255, 255, 255, 255 )
friendly_name_Checkbox:SetDescription("Draw entity name.")

local enemy_name_Reference = gui.Reference( "Visuals" , "Overlay" , "Enemy" , "Name" );
local enemy_name_Checkbox = gui.Checkbox( gui.Reference( "Visuals" , "Overlay" , "Enemy" ), "esp.overlay.enemy.name", "Name", 0 );
local enemy_name_ColorPicker = gui.ColorPicker( enemy_name_Checkbox, "clr", "clr", 255, 255, 255, 255 )
enemy_name_Checkbox:SetDescription("Draw entity name.")

-- Draw ESP 
callbacks.Register("DrawESP", function(builder)
    local builderEntity = builder:GetEntity()
	local name = builderEntity:GetName();
    local weaponName = builderEntity:GetWeaponID();
    if  friendly_name_Checkbox:GetValue() and builderEntity:IsPlayer() and builderEntity:IsAlive() and builderEntity:GetTeamNumber() == entities.GetLocalPlayer():GetTeamNumber() then
    gui.SetValue( "esp.overlay.friendly.name", 0 )
    builder:Color( friendly_name_ColorPicker:GetValue() );    
    builder:AddTextTop(name);
    end
    if  enemy_name_Checkbox:GetValue() and builderEntity:IsPlayer() and builderEntity:IsAlive() and builderEntity:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then
    gui.SetValue( "esp.overlay.enemy.name", 0 )
    builder:Color( enemy_name_ColorPicker:GetValue() ); 
    builder:AddTextTop(name);  
    end
end)
client.Command("echo [Aimware] Loading ESP Name Colors",1)
-- end








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

