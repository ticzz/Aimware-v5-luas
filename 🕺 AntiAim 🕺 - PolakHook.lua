
local ref = gui.Tab(gui.Reference("Ragebot"), "polakmenu", "PolakHook");

--Anti-Aims
local guiAntiaimBlock = gui.Groupbox(ref, "Custom AA", 16, 16, 250, 250);
local guiAntiaimSwitchKey = gui.Keybox(guiAntiaimBlock , "aaswitchkey", "Switch Key", 70);
local guiArrowsColor = gui.ColorPicker(guiAntiaimBlock, "arrowscolorpicker", "Arrows Color", 255, 0, 0, 255);
local guiAntiaimDeltaSlider = gui.Slider(guiAntiaimBlock, "aadelta", "Desync Delta", 150, 0, 180);
local guiAntiaimRealMaxDeltaJitter = gui.Slider(guiAntiaimBlock, "aajittermaxdelta", "Desync Max Real Delta (Jitter)", 58, 0, 58);
local guiAntiaimRealMinDeltaJitter = gui.Slider(guiAntiaimBlock, "aajittermindelta", "Desync Min Real Delta (Jitter)", 50, 0, 58);
local guiAntiaimAntialignFlicking = gui.Checkbox(guiAntiaimBlock, "antialignflick", "Anti-Align Flicking", 1);
local guiAntiaimDesyncTypeFlicking = gui.Checkbox(guiAntiaimBlock, "desyncmodeflick", "Desync Type Flicking", 0);
local guiAntiaimMode = gui.Checkbox(guiAntiaimBlock, "aamode", "Rage mode", 0);
local guiAntiaimType = gui.Combobox(guiAntiaimBlock, "aatype", "Desync type", "Static (Not-recomended)", "Jitter", "Sway");


--Some Vars
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX * 0.5;
screenCenterY = screenCenterY * 0.5;

local aaInverted = 1;


local function StaticSync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", 58);
		gui.SetValue("rbot.antiaim.base.lby", guiAntiaimDeltaSlider:GetValue() * -1);
	else
		gui.SetValue("rbot.antiaim.base.rotation", -58);
		gui.SetValue("rbot.antiaim.base.lby", guiAntiaimDeltaSlider:GetValue());
	end
end

local function JitterSync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", RandomRange(guiAntiaimRealMinDeltaJitter:GetValue(), guiAntiaimRealMaxDeltaJitter:GetValue()));
		gui.SetValue("rbot.antiaim.base.lby", math.random(guiAntiaimDeltaSlider:GetValue() * -1));
	else
		gui.SetValue("rbot.antiaim.base.rotation", RandomRange(guiAntiaimRealMinDeltaJitter:GetValue() * -1, guiAntiaimRealMaxDeltaJitter:GetValue() * -1));
		gui.SetValue("rbot.antiaim.base.lby", math.random(guiAntiaimDeltaSlider:GetValue()));
	end
end

local iSwayIndex = 18;
local function SwaySync(bSide)
	if bSide == 1 then
		gui.SetValue("rbot.antiaim.base.rotation", 58);
		gui.SetValue("rbot.antiaim.base.lby", iSwayIndex * -1);
	else
		gui.SetValue("rbot.antiaim.base.rotation", -58);
		gui.SetValue("rbot.antiaim.base.lby", iSwayIndex);
	end
	
	if iSwayIndex + 5 > guiAntiaimDeltaSlider:GetValue() + 1 then
	   iSwayIndex = 0;
	end
	
	iSwayIndex = iSwayIndex + 5;	
end

local function CustomDesync()
	local aaRMode = 0;
	local aaSide = 0;
	
	gui.SetValue("rbot.antiaim.left", 0);
    gui.SetValue("rbot.antiaim.right", 0);
	gui.SetValue("rbot.antiaim.advanced.autodir.edges", 0);
    gui.SetValue("rbot.antiaim.advanced.autodir.targets", 0);
	
	if guiAntiaimMode:GetValue() then
		gui.SetValue("rbot.antiaim.base", "180.0 Desync");
		gui.SetValue("rbot.antiaim.advanced.pitch", 1);
		aaRMode = 1;
	else
		gui.SetValue("rbot.antiaim.base", "0.0 Desync");
		gui.SetValue("rbot.antiaim.advanced.pitch", 0);
	end
	
	if guiAntiaimAntialignFlicking:GetValue() == true then
		if math.random(34) == 1 then
			gui.SetValue("rbot.antiaim.advanced.antialign", 1);
		else
			gui.SetValue("rbot.antiaim.advanced.antialign", 0);
		end
	end
	
	if guiAntiaimDesyncTypeFlicking:GetValue() == true then
		if math.random(5) == 1 then
			guiAntiaimType:SetValue(2);
		else
			guiAntiaimType:SetValue(1);
		end
	end
	
	if guiAntiaimSwitchKey:GetValue() then
		if input.IsButtonPressed(guiAntiaimSwitchKey:GetValue()) then
			if aaInverted == 1 then
				aaInverted = 0;
			else
				aaInverted = 1;
			end
		end
	end
	
	if aaRMode == 1 then
		aaSide = 1 - aaInverted;
	else
		aaSide = aaInverted;
	end
	
	if guiAntiaimType:GetValue() == 0 then
		StaticSync(aaSide);
	elseif guiAntiaimType:GetValue() == 1 then
		JitterSync(aaSide);
	else
		SwaySync(aaSide);
	end
end


local function DrawInfo()
	local YAdd = 50;
	
	--Draw AA Arows
	draw.Color(46, 46, 46, 200);
	draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
	draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
	local r, g, b, a = guiArrowsColor:GetValue();
	draw.Color(r, g, b, a);
	
	if aaInverted == 1 then
		draw.Line(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8);
		draw.Line(screenCenterX + 50, screenCenterY - 7 + 15, screenCenterX + 65, screenCenterY - 7 + 8);
	else
		draw.Line(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8);
		draw.Line(screenCenterX - 50, screenCenterY - 7 + 15, screenCenterX - 65, screenCenterY - 7 + 8);
	end	
	--

end

callbacks.Register("Draw", DrawInfo);
callbacks.Register("Draw", CustomDesync);










--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

