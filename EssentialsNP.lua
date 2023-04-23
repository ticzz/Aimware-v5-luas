-- EssentialsNP by Nyanpasu!
EssentialsNP = {};
EssentialsNP.Vector3 = {};
EssentialsNP.Drawing = {};

	-- Vector3
	local function vector3_add(input0, input1) -- Adds vector input1 to input0
		return {input0[1] + input1[1], input0[2] + input1[2], input0[3] + input1[3]};
	end
	
	local function vector3_subtract(input0, input1) -- Subtracts vector input1 from input0
		return {input0[1] - input1[1], input0[2] - input1[2], input0[3] - input1[3]};
	end
	
	local function vector3_hypotenuse(input0, input1) -- Gets the hypotenuse between input0 and input1
		local vectorDelta = vector3_subtract(input0, input1);
		
		return math.sqrt(vectorDelta[1] ^ 2 + vectorDelta[2] ^ 2 + vectorDelta[3] ^ 2);	
	end
	
	local function vector3_getangles(input0, input1) -- Gets the pitch and yaw needed to aim from input1 to input0
		local vectorDelta = vector3_subtract(input0, input1);
		local hypotenuse = vector3_hypotenuse(input0, input1);
		
		local AngX = math.asin(vectorDelta[3]/hypotenuse) * -(180/math.pi);
		local AngY = math.atan(vectorDelta[2]/vectorDelta[1]) * (180/math.pi);
		
		if vectorDelta[1] <= 0 then
			AngY = AngY + 180;
		end
		
		return {AngX, AngY};
	end
	
	-- Drawing
	local function drawing_hue(input0) -- Transforms a HUE radian angle into RGB
		local Red = math.floor(math.sin(input0 * 3) * 127 + 128);
		local Green = math.floor(math.sin(input0 * 3 + 2) * 127 + 128);
		local Blue = math.floor(math.sin(input0 * 3 + 4) * 127 + 128)
	
		return {Red, Green, Blue};
	end

EssentialsNP.Vector3.Add = vector3_add;
EssentialsNP.Vector3.Subtract = vector3_subtract;
EssentialsNP.Vector3.Hypotenuse = vector3_hypotenuse;
EssentialsNP.Vector3.GetAngles = vector3_getangles;

EssentialsNP.Drawing.Hue = drawing_hue;
	
-- EssentialsNP by Nyanpasu!












--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

