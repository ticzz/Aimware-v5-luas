-- Original lua creator - domve  ( https://aimware.net/forum/user-351364.html )
-- Converted it to Skybox Modulate - Dreammm ( https://aimware.net/forum/user-250431.html )

-- Enjoy

local ref = gui.Reference( "Visuals", "World");
local group = gui.Groupbox(ref, "Visuals", 328, 215, 280, 500 );
local ifififiifif = gui.Checkbox(group, "iifififififi", "Sky Modulate Checkbox", false );
local GayFunk = gui.Checkbox( group, "Just for Color pick", "color pick", false );
local GayColor = gui.ColorPicker(GayFunk, "gaycolor","Color Modulate Color", 255, 0, 0, 255 )
GayFunk:SetDescription("Just enable Sky Modulate Checkbox and change color. ")

local function DarkenMaterials( mat )
	local group = mat:GetTextureGroupName();
	r,g,b,a = GayColor:GetValue()
	if group == "SkyBox textures" then
		mat:ColorModulate( r/5, g/10, b/15 );
		mat:AlphaModulate( a);
	end
end

local function RestoreMaterials( mat ) 
	mat:ColorModulate( 1.0, 1.0, 1.0 );
	mat:AlphaModulate( 1.0);
end



local function OnDraw( )
	if ifififiifif:GetValue() then
			materials.Enumerate( DarkenMaterials )
		else
			materials.Enumerate( RestoreMaterials )
		end
	old_night_mode_value = ifififiifif:GetValue();
end

local function OnEvent( event )
	local name = event:GetName();
	if name == "round_start" or name == "round_end" or name == "cs_pre_restart" or name == "start_halftime" or ( name == "player_spawned" and event:GetInt( "userid" ) == client.GetLocalPlayerIndex( ) ) then
		if ifififiifif:GetValue() then
			materials.Enumerate( DarkenMaterials )
		else
			materials.Enumerate( RestoreMaterials )
		end
	end
end

callbacks.Register( "Draw", OnDraw );
callbacks.Register( "FireGameEvent", OnEvent )





;








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

