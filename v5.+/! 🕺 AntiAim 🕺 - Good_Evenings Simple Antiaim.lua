local ANTIAIM = gui.Reference("ragebot", "antiaim");

local UI_ANTIAIM_A = gui.Groupbox(ANTIAIM, "Yaw", 16, 226, 192, 300);
local UI_ANTIAIM_B = gui.Groupbox(ANTIAIM, "Jitter", 224, 226, 192, 300);
local UI_ANTIAIM_C = gui.Groupbox(ANTIAIM, "Fake", 432, 226, 192, 300);

local UI = {
	ANTIAIM = {
		BASE_MASTER = gui.Checkbox(UI_ANTIAIM_A, "master", "Base Master Switch", false);
		BACKWARD = gui.Checkbox(UI_ANTIAIM_A, "backward", "Backwards", false);
		YAW_OFFSET = gui.Slider(UI_ANTIAIM_A, "yaw_offset", "Offset", 0, -180, 180, 1);


		JITTER_TYPE = gui.Combobox(UI_ANTIAIM_B, "jitter_type", "Type", "Disabled", "Normal", "Random");
		JITTER_OFFSET = gui.Slider(UI_ANTIAIM_B, "jitter_offset", "Offset", 0, -90, 90, 1);


		INVERTER = gui.Checkbox(UI_ANTIAIM_C, "invert_fake", "Inverter [Bind]", false);
		JITTER_FAKE = gui.Checkbox(UI_ANTIAIM_C, "jitter_fake", "Jitter", false);
		DESYNC = gui.Slider(UI_ANTIAIM_C, "desync", "Desync", 58, 0, 58, 1);
	};
};


local AntiAim = {
	INVERTED = false;
	INVERT_TICK = 0;

	SET = function(self, tick)
		local ANTIAIM = UI.ANTIAIM;

		if not ANTIAIM.BASE_MASTER:GetValue() then
			gui.SetValue("rbot.antiaim.base", "0 Off")
			gui.SetValue("rbot.antiaim.right", "0 Off")
			gui.SetValue("rbot.antiaim.left", "0 Off")

			return
		end

		local DESYNC,INVERTED=ANTIAIM.DESYNC:GetValue(),self.INVERTED;

		-- Jitter must be limited in speed if desync is enable, otherwise desync wont work
		if math.abs(tick-self.INVERT_TICK)>=3 or DESYNC == 0 then self.INVERT_TICK,INVERTED=tick,not INVERTED;end

		INVERTED,self.INVERTED=(INVERTED)and -1 or 1,INVERTED;

		local YAW=0;

		if ANTIAIM.BACKWARD:GetValue() then YAW=180+ANTIAIM.YAW_OFFSET:GetValue();else YAW=-ANTIAIM.YAW_OFFSET:GetValue();end

		-- Calculate Jitter Offset
		local JITTER_TYPE = ANTIAIM.JITTER_TYPE:GetValue()
		if JITTER_TYPE==1 then YAW=YAW + ANTIAIM.JITTER_OFFSET:GetValue()*INVERTED; -- Normal Jitter
		elseif JITTER_TYPE==2 then YAW=YAW + math.random(0,ANTIAIM.JITTER_OFFSET:GetValue())*INVERTED;end -- Random Jitter

		-- Normalize Yaw
		if YAW>180 then YAW=YAW-360;elseif YAW<-180 then YAW=YAW+360;end

		-- Desync is set to zero so we disable it completely
		if DESYNC==0 then
			gui.SetValue("rbot.antiaim.base", tostring(YAW) .. " Backward")
			gui.SetValue("rbot.antiaim.right", "-90 Backward")
			gui.SetValue("rbot.antiaim.left", "90 Backward")

			return
		end

		gui.SetValue("rbot.antiaim.base.rotation", DESYNC*(ANTIAIM.JITTER_FAKE:GetValue() and INVERTED or (ANTIAIM.INVERTER:GetValue() and -1 or 1)))
		gui.SetValue("rbot.antiaim.base", tostring(YAW) .. " Desync")

		gui.SetValue("rbot.antiaim.right.rotation", DESYNC)
		gui.SetValue("rbot.antiaim.right", "-90 Desync")

		gui.SetValue("rbot.antiaim.left.rotation", -DESYNC)
		gui.SetValue("rbot.antiaim.left", "90 Desync")
	end;
};

callbacks.Register("CreateMove", function(cmd)
	if not cmd then return end
	if not cmd.sendpacket then return end

	AntiAim:SET(cmd.tick_count)
end)

callbacks.Register("Unload", ((function()
	--* Called on load
	local Base_Direction = gui.Reference("ragebot", "antiaim", "base");
	local Left_Direction = gui.Reference("ragebot", "antiaim", "left");
	local Right_Direction = gui.Reference("ragebot", "antiaim", "right");

	local Extra = gui.Reference("ragebot", "antiaim", "extra");
	local Condition = gui.Reference("ragebot", "antiaim", "condition");
	local Advanced = gui.Reference("ragebot", "antiaim", "advanced");

	local Anti_Resolver = gui.Reference("ragebot", "antiaim", "advanced", "antiresolver");

	Base_Direction:SetInvisible(true)
	Left_Direction:SetInvisible(true)
	Right_Direction:SetInvisible(true)

	Anti_Resolver:SetInvisible(true)
	Anti_Resolver:SetValue(false)

	Base_Direction:SetPosY(16)
	Base_Direction:SetName("Extra")

	Left_Direction:SetPosY(16)
	Left_Direction:SetName("Condition")

	Right_Direction:SetPosY(16)
	Right_Direction:SetName("Advanced")

	--* Called on unload
	return function()
		Base_Direction:SetInvisible(false)
		Left_Direction:SetInvisible(false)
		Right_Direction:SetInvisible(false)
		Anti_Resolver:SetInvisible(false)

		Extra:SetPosY(306)
		Extra:SetName("Extra")

		Condition:SetPosY(306)
		Condition:SetName("Condition")

		Advanced:SetPosY(306)
		Advanced:SetName("Advanced")
	end;
end)()))