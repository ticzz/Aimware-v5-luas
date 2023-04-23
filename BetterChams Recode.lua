--[[
# DON'T BE A DICK PUBLIC LICENSE

> Version 1.1, December 2016

> Copyright (C) [2020] [Janek "superyu"]

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document.

> DON'T BE A DICK PUBLIC LICENSE
> TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

1. Do whatever you like with the original work, just don't be a dick.

   Being a dick includes - but is not limited to - the following instances:

 1a. Outright copyright infringement - Don't just copy this and change the name.
 1b. Selling the unmodified original with no work done what-so-ever, that's REALLY being a dick.
 1c. Modifying the original work to contain hidden harmful content. That would make you a PROPER dick.

2. If you become rich through modifications, related works/services, or supporting the original work,
share the love. Only a dick would make loads off this work and not buy the original work's
creator(s) a pint.

3. Code is provided with no warranty. Using somebody else's code and bitching when it goes wrong makes
you a DONKEY dick. Fix the problem yourself. A non-dick would submit the fix back.
]]


--- Variables that can't be done inside a table
local TAB = gui.Tab(gui.Reference("Visuals"), "vis.betterchams.tab", "BetterChams")
local GROUP_MAIN = gui.Groupbox(TAB, "Main", 15, 15, 600, 800)
local CONFIGURE_MODE = gui.Combobox(GROUP_MAIN, "betterchams.configure.mode", "Configure Mode", "Local", "Enemy", "Arms", "Weapons");
local CONFIGURE_TYPE = gui.Combobox(GROUP_MAIN, "betterchams.configure.type", "Configure Type", "Visible", "Hidden", "Fresnel");

local variables = {

	["VAR_NAMES"] = {
		"VIS_MODE", "VIS_COLOR", "HID_MODE", "HID_COLOR", "VIS_REF", "HID_REF", "FRES_X", "FRES_Y", "FRES_Z"
	},

	["MATERIALS"] = {
		[0] = {},
		[1] = {},
		[2] = {},
		[3] = {}
	},

	[0] = {
		["VIS_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.local", "Type", "Off", "Default", "Fresnel Glow"),
		["VIS_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.local", "Color", 107, 235, 52, 255),
		["HID_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.local.hidden", "Type", "Off", "Default", "Fresnel Glow"),
		["HID_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.local.hidden", "Color", 52, 137, 235, 255),
		["VIS_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["HID_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["FRES_X"] = gui.Slider(GROUP_MAIN, "betterchams.local.fresnelx", "Normal Angle", 0, 0, 10, 0.1),
		["FRES_Y"] = gui.Slider(GROUP_MAIN, "betterchams.local.fresnely", "Between Normal and Grazing Angle", 0.3, 0, 10, 0.1),
		["FRES_Z"] = gui.Slider(GROUP_MAIN, "betterchams.local.fresnelz", "Grazing Angle", 4, 0, 10, 0.1)
	},

	[1] = {
		["VIS_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.enemy", "Type", "Off", "Default", "Fresnel Glow"),
		["VIS_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.enemy", "Color", 107, 235, 52, 255),
		["HID_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.enemy.hidden", "Type", "Off", "Default", "Fresnel Glow"),
		["HID_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.enemy.hidden", "Color", 52, 137, 235, 255),
		["VIS_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["HID_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["FRES_X"] = gui.Slider(GROUP_MAIN, "betterchams.enemy.fresnelx", "Normal Angle", 0, 0, 10, 0.1),
		["FRES_Y"] = gui.Slider(GROUP_MAIN, "betterchams.enemy.fresnely", "Between Normal and Grazing Angle", 0.3, 0, 10, 0.1),
		["FRES_Z"] = gui.Slider(GROUP_MAIN, "betterchams.enemy.fresnelz", "Grazing Angle", 4, 0, 10, 0.1)
	},

	[2] = {
		["VIS_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.arms", "Type", "Off", "Default", "Fresnel Glow"),
		["VIS_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.arms", "Color", 107, 235, 52, 255),
		["HID_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.arms.hidden", "Type", "Off", "Default", "Fresnel Glow"),
		["HID_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.arms.hidden", "Color", 52, 137, 235, 255),
		["VIS_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["HID_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["FRES_X"] = gui.Slider(GROUP_MAIN, "betterchams.arms.fresnelx", "Normal Angle", 0, 0, 10, 0.1),
		["FRES_Y"] = gui.Slider(GROUP_MAIN, "betterchams.arms.fresnely", "Between Normal and Grazing Angle", 0.3, 0, 10, 0.1),
		["FRES_Z"] = gui.Slider(GROUP_MAIN, "betterchams.arms.fresnelz", "Grazing Angle", 4, 0, 10, 0.1)
	},

	[3] = {
		["VIS_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.weapons", "Type", "Off", "Default", "Fresnel Glow"),
		["VIS_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.weapons", "Color", 107, 235, 52, 255),
		["HID_MODE"] = gui.Combobox(GROUP_MAIN, "betterchams.enabled.weapons.hidden", "Type", "Off", "Default", "Fresnel Glow"),
		["HID_COLOR"] = gui.ColorPicker(GROUP_MAIN, "betterchams.color.weapons.hidden", "Color", 52, 137, 235, 255),
		["VIS_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["HID_REF"] = gui.Slider(GROUP_MAIN, "betterchams.reflectivity.weapons", "Reflectivity", 0, 0, 1, 0.01),
		["FRES_X"] = gui.Slider(GROUP_MAIN, "betterchams.weapons.fresnelx", "Normal Angle", 0, 0, 10, 0.1),
		["FRES_Y"] = gui.Slider(GROUP_MAIN, "betterchams.weapons.fresnely", "Between Normal and Grazing Angle", 0.3, 0, 10, 0.1),
		["FRES_Z"] = gui.Slider(GROUP_MAIN, "betterchams.weapons.fresnelz", "Grazing Angle", 4, 0, 10, 0.1)
	},

	["OLD_VARIABLES"] = {}
}

CONFIGURE_MODE:SetDescription("Select which chams target to configure.");
CONFIGURE_TYPE:SetDescription("Select which chams type to configure.")
for mode = 0, 3 do
	variables[mode]["VIS_MODE"]:SetDescription("The kind of visible chams.");
	variables[mode]["VIS_COLOR"]:SetDescription("The color of the visible chams.");
	variables[mode]["HID_MODE"]:SetDescription("The kind of hidden chams.");
	variables[mode]["HID_COLOR"]:SetDescription("The color of the hidden chams.");
	variables[mode]["VIS_REF"]:SetDescription("The reflectivity of the chams.");
	variables[mode]["HID_REF"]:SetDescription("The reflectivity of the chams.");
	variables[mode]["FRES_X"]:SetDescription("How much light is reflecting on the normal angle.");
	variables[mode]["FRES_Y"]:SetDescription("How much light is reflecting between the normal angle and grazing angle");
	variables[mode]["FRES_Z"]:SetDescription("How much light is reflecting on the grazing angle.");
end

--- Material Updater
local function updateMaterials(mode)

	for i = 0, 1 do

		local varPrefix = "VIS_"

		if i == 1 then
			varPrefix = "HID_"
		end

		if variables[mode][varPrefix .. "MODE"]:GetValue() == 2 then
			local x, y, z = variables[mode]["FRES_X"]:GetValue(), variables[mode]["FRES_Y"]:GetValue(), variables[mode]["FRES_Z"]:GetValue()
			local r, g, b = variables[mode][varPrefix .. "COLOR"]:GetValue()
			local newVMT = [[
			"VertexLitGeneric"
			{
				"$basetexture" "vgui/white_additive"
				"$envmap" "models/effects/cube_white"
				"$envmaptint" "[]] .. r / 255 .. [[ ]] .. g / 255 .. [[ ]] .. b / 255 .. [[]"
				"$envmapfresnel" "1"
				"$normalmapalphaenvmapmask" "1"
				"$envmapcontrast" "1"
				"$envmapfresnelminmaxexp" "[]] .. x .. [[ ]] .. y .. [[ ]] .. z .. [[]"
			} 
			]]
			variables["MATERIALS"][mode][i] = materials.Create("glowMat", newVMT, "VertexLitGeneric")
			if i == 1 then
				variables["MATERIALS"][mode][i]:SetMaterialVarFlag(32768, true)
			end
		else
			local re = variables[mode][varPrefix .. "REF"]:GetValue()
			local newVMT = [[
			"VertexLitGeneric"
			{
				"$basetexture" "vgui/white_additive"
				"$ignorez"      "0"
				"$envmap"       "env_cubemap"
				"$envmaptint" "[]] .. re .. [[ ]] .. re .. [[ ]] .. re .. [[]"
				"$nofog"        "1"
				"$model"        "1"
				"$nocull"       "0"
				"$selfillum"    "1"
				"$halflambert"  "1"
				"$znearer"      "0"
				"$flat"         "1"
			}
			]]
			variables["MATERIALS"][mode][i] = materials.Create("defaultMat", newVMT, "VertexLitGeneric")
			if i == 1 then
				variables["MATERIALS"][mode][i]:SetMaterialVarFlag(32768, true)
			end
		end
	end
end

--- Material Update checker
local function handleMaterials()

	for mode = 0, 3 do
		for varIndex = 1, 9 do
			local cur = variables[mode][variables["VAR_NAMES"][varIndex]]:GetValue();
			local old = variables["OLD_VARIABLES"][mode .. variables["VAR_NAMES"][varIndex]];
			if cur ~= old or old == nil then
				variables["OLD_VARIABLES"][mode .. variables["VAR_NAMES"][varIndex]] = cur;
				updateMaterials(mode);
			end
		end
	end
end

--- Handle the UI (Set GuiObjects to invisible etc.)
local function handleUserInterface()

	local m = CONFIGURE_MODE:GetValue()
	local t = CONFIGURE_TYPE:GetValue()

	for mode = 0, 3 do
		for varIndex = 1, 9 do
			variables[mode][variables["VAR_NAMES"][varIndex]]:SetInvisible(true);
		end
	end

	if t == 0 then
		variables[m]["VIS_MODE"]:SetInvisible(false);
		variables[m]["VIS_COLOR"]:SetInvisible(false);
		variables[m]["HID_REF"]:SetInvisible(true)
		if variables[m]["VIS_MODE"]:GetValue() == 2 then
			variables[m]["VIS_REF"]:SetInvisible(true)
		else
			variables[m]["VIS_REF"]:SetInvisible(false)
		end

		variables[m]["HID_MODE"]:SetInvisible(true);
		variables[m]["HID_COLOR"]:SetInvisible(true);

		variables[m]["FRES_X"]:SetInvisible(true);
		variables[m]["FRES_Y"]:SetInvisible(true);
		variables[m]["FRES_Z"]:SetInvisible(true);

	elseif t == 1 then
		variables[m]["VIS_MODE"]:SetInvisible(true);
		variables[m]["VIS_COLOR"]:SetInvisible(true);
		variables[m]["VIS_REF"]:SetInvisible(true)
		if variables[m]["HID_MODE"]:GetValue() == 2 then
			variables[m]["HID_REF"]:SetInvisible(true)
		else
			variables[m]["HID_REF"]:SetInvisible(false)
		end

		variables[m]["HID_MODE"]:SetInvisible(false);
		variables[m]["HID_COLOR"]:SetInvisible(false);

		variables[m]["FRES_X"]:SetInvisible(true);
		variables[m]["FRES_Y"]:SetInvisible(true);
		variables[m]["FRES_Z"]:SetInvisible(true);
	else
		variables[m]["VIS_MODE"]:SetInvisible(true);
		variables[m]["VIS_COLOR"]:SetInvisible(true);
		variables[m]["REF"]:SetInvisible(true)

		variables[m]["HID_MODE"]:SetInvisible(true);
		variables[m]["HID_COLOR"]:SetInvisible(true);

		variables[m]["FRES_X"]:SetInvisible(false);
		variables[m]["FRES_Y"]:SetInvisible(false);
		variables[m]["FRES_Z"]:SetInvisible(false);
	end

end

--- Apply chams
local function doChams(Context, mode)

	local material = variables["MATERIALS"][mode][0]
	local materialHidden = variables["MATERIALS"][mode][1]

	if material ~= nil and materialHidden ~= nil then

		if variables[mode]["HID_MODE"]:GetValue() > 0 then
			local r1, g1, b1, a1 = variables[mode]["HID_COLOR"]:GetValue()
			if variables[mode]["HID_MODE"]:GetValue() == 1 then
				materialHidden:ColorModulate(r1 / 255, g1 / 255, b1 / 255)
				materialHidden:AlphaModulate(a1 / 255)
				Context:ForcedMaterialOverride(materialHidden)
				Context:DrawExtraPass()
			else
				materialHidden:ColorModulate(0, 0, 0)
				materialHidden:AlphaModulate(a1 / 255)
				Context:ForcedMaterialOverride(materialHidden)
				Context:DrawExtraPass()
			end
		end

		if variables[mode]["VIS_MODE"]:GetValue() > 0 then
			local r2, g2, b2, a2 = variables[mode]["VIS_COLOR"]:GetValue()
			if variables[mode]["VIS_MODE"]:GetValue() == 1 then
				material:ColorModulate(r2 / 255, g2 / 255, b2 / 255)
				material:AlphaModulate(a2 / 255)
				Context:ForcedMaterialOverride(material)
			else
				material:ColorModulate(0, 0, 0)
				material:AlphaModulate(a2 / 255)
				Context:ForcedMaterialOverride(material)
			end
		end
	end
end

--- DrawModelHook
local function DrawModelHook(Context)
	local pEntity = Context:GetEntity();
	local pLocal = entities.GetLocalPlayer();
    if pEntity ~= nil then
		if pEntity:IsPlayer() then
			if pLocal and pLocal:IsAlive() then
				if pEntity:GetIndex() == pLocal:GetIndex() then
					doChams(Context, 0)
				end
			end

			if pEntity:GetTeamNumber() ~= pLocal:GetTeamNumber() then
				doChams(Context, 1)
			end
		else
			if Context:GetEntity():GetClass() == "CBaseAnimating" then
				doChams(Context, 2)

			elseif Context:GetEntity():GetClass() == "CPredictedViewModel" then
				doChams(Context, 3)
			end
		end
	end
end

--- Callbacks
callbacks.Register("Draw", handleMaterials)
callbacks.Register("Draw", handleUserInterface)
callbacks.Register("DrawModel", DrawModelHook)













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

