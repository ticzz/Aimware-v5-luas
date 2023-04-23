function DrawThatShit()

local light_font = draw.CreateFont("Tahoma", 27, 600);
		
	local pLocalPlayer = entities.GetLocalPlayer();


	local function Shift(pos)

	local pLocalPlayer = entities.GetLocalPlayer();

 	local vx = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]")
   	local vy = pLocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]")
	
	local velocity = math.floor(math.min(10000, math.sqrt(vx*vx + vy*vy) + 0.5))

	draw.SetFont(light_font)

	if velocity < 1 and not input.IsButtonDown(0x20) then
		draw.Color(130, 180, 0)
	else
		draw.Color(141, 153, 0)
	end

	if input.IsButtonDown(0x20) then
		draw.Color(233, 4, 4)
	end

	draw.TextShadow(10, 985 + (pos * 25), "Shift")
end

		draw.SetFont(light_font)

	if gui.GetValue("rbot.antiaim.condition.shiftonshot") then
   	 draw.Color( 130, 180, 0, 255 );
    	draw.Text( 10, 960, "Shift")
		draw.TextShadow(10, 985 + (pos * 25), "Shift")
    else
    	draw.Color( 233, 4, 4, 255 );
   	 draw.Text( 10, 960, "No Shift")
		draw.TextShadow(10, 985 + (pos * 25), "No Shift")
  end
end

callbacks.Register("Draw", DrawThatShit)

local pLocalPlayer = entities.GetLocalPlayer();

	if pLocalPlayer == nil then
	return;
	end

	if not pLocalPlayer:IsAlive()



 then
	return;
	end
	








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

