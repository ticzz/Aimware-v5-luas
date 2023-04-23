local SetValue = gui.SetValue
local GetValue = gui.GetValue

local MENU = gui.Reference( "menu" );

local MSC_FAKELAG_REF = gui.Reference( "Misc", "Enhancement", "Fakelag" );
local FAKELAG_WND_CHECKBOX = gui.Checkbox ( MSC_FAKELAG_REF, "lua.fakelag.wnd", "Advance Fakelag Configuration", 0 );

local x, y = GetValue( "menu" );
local FAKELAG_WINDOW = gui.Window( "lua.wnd.fakelag", "Advance Fakelag Configuration", x+816, y+168, 400, 670+32 );

--local MASTER_SWITCH = gui.Checkbox( FAKELAG_WINDOW, "lua_fakelag", "Master Switch", 1 );

local FAKELAG_SMART_MODE = gui.Checkbox( FAKELAG_WINDOW, "lua_fakelag_smartmode_enable", "Show/Hide SmartMode", 0 );
local SMARTMODE_GROUPBOX = gui.Groupbox( FAKELAG_WINDOW, "Fakelag Smart Mode", 16, 76, 200 - 32, 400 - 64 );
local FAKELAG_EXTRA_GROUPBOX = gui.Groupbox( FAKELAG_WINDOW, "Fakelag Extra", (200-32)+32, 76, 200 - 16, 400 - 64 );


local FAKELAG_SMART_MODE_STANDING = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.standing", "While Standing", "Off", "On");
local FAKELAG_SMART_MODE_STANDING_TYPE = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.standing.type", "Type","Normal", "Adaptive", "Random", "Switch" );
local FAKELAG_SMART_MODE_STANDING_FACTOR = gui.Slider( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.standing.factor", "Factor", 15, 1, 62 );
local FAKELAG_SMART_MODE_MOVING = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.moving", "While Moving", "Off", "On" );
local FAKELAG_SMART_MODE_MOVING_TYPE = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.moving.type", "Type", "Normal", "Adaptive", "Random", "Switch" );
local FAKELAG_SMART_MODE_MOVING_FACTOR = gui.Slider( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.moving.factor", "Factor", 15, 1, 62 );
local FAKELAG_SMART_MODE_INAIR = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.inair", "While In Air",  "Off", "On" );
local FAKELAG_SMART_MODE_INAIR_TYPE = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.inair.type", "Type", "Normal", "Adaptive", "Random", "Switch" );
local FAKELAG_SMART_MODE_INAIR_FACTOR = gui.Slider( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.inair.factor", "Factor", 15, 1, 62 );
local FAKELAG_SMART_MODE_PEEK = gui.Combobox( SMARTMODE_GROUPBOX, "lua.misc.fakelag.condition.peek", "Fakelag on Peek", "Off", "On" );

local FAKELAG_EXTRA = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_extra_enable", "Enable", 0 );
local FAKELAG_ON_KNIFE = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_knife", "Disable On Knife", 0 );
local FAKELAG_ON_NADE = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_nade", "Disable On Nade", 0 );
local FAKELAG_ON_PISTOL = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_pistol", "Disable On Pistol", 0 );
local FAKELAG_ON_DOUBLETAP = gui.Checkbox (FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_doubletap" , "Disable on Doubletap", 0)
local FAKELAG_ON_REVOLVER = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_revolver", "Disable On Revolver", 0 );
local FAKELAG_ON_SLOWWALK = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_slowwalk", "Disable On Slow Walk", 0 );
local FAKELAG_ON_TASER = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_taser", "Disable On Taser", 0 );
local FAKELAG_ON_PING = gui.Checkbox( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_ping", "Disable On Ping", 0 );
local FAKELAG_ON_PING_AMOUNT = gui.Slider( FAKELAG_EXTRA_GROUPBOX, "lua_fakelag_ping_amount", "On Ping Amount", 120, 0, 1000 );
local Ping = 0
local Time = 0

callbacks.Register( 'Draw',  function()

	if FAKELAG_WND_CHECKBOX:GetValue() and MENU:IsActive() then
		FAKELAG_WINDOW:SetActive(1)
	else
		FAKELAG_WINDOW:SetActive(0)
	end

	if FAKELAG_WND_CHECKBOX:GetValue() and FAKELAG_SMART_MODE:GetValue() then

		SMARTMODE_GROUPBOX:SetDisabled(false)
		SMARTMODE_GROUPBOX:SetInvisible(false)

	elseif not FAKELAG_WND_CHECKBOX:GetValue() and not FAKELAG_SMART_MODE:GetValue() then

		SMARTMODE_GROUPBOX:SetDisabled(true)
		SMARTMODE_GROUPBOX:SetInvisible(true)	
	
	elseif FAKELAG_WND_CHECKBOX:GetValue() and not FAKELAG_SMART_MODE:GetValue() then

		SMARTMODE_GROUPBOX:SetDisabled(true)
		SMARTMODE_GROUPBOX:SetInvisible(true)		

	elseif not FAKELAG_WND_CHECKBOX:GetValue() and FAKELAG_SMART_MODE:GetValue() then

		SMARTMODE_GROUPBOX:SetDisabled(true)
		SMARTMODE_GROUPBOX:SetInvisible(true)	


	end

	if entities.GetLocalPlayer() == nil then
		return
	end

	local LocalPlayerEntity = entities.GetLocalPlayer();
	local WeaponID = LocalPlayerEntity:GetWeaponID();
	local WeaponType = LocalPlayerEntity:GetWeaponType();

	if ( WeaponType == 0 and WeaponID ~= 31 ) then Knife = true else Knife = false end
	if ( WeaponType == 1 and WeaponID ~= 64 ) then Pistol = true else Pistol = false end
	if WeaponID == 31 then Taser = true else Taser = false end
	if WeaponID == 64 then Revolver = true else Revolver = false end
	if WeaponType == 9 then Nade = true else Nade = false end
	
end)

local function FakelagExtra()

	if not FAKELAG_WND_CHECKBOX:GetValue() then
		return
	end

	if not FAKELAG_EXTRA:GetValue() then
		return
	end

		if ( FAKELAG_ON_KNIFE:GetValue() and Knife ) or -- On Knife
	   ( FAKELAG_ON_NADE:GetValue() and Nade ) or -- On Nade
	   ( FAKELAG_ON_TASER:GetValue() and Taser ) or -- On Taser
	   ( FAKELAG_ON_PISTOL:GetValue() and Pistol ) or -- On Pistol
	   ( FAKELAG_ON_REVOLVER:GetValue() and Revolver ) then -- On Revolver
		SetValue( "misc.fakelag.enable", 0 );
	else
		SetValue( "misc.fakelag.enable", 1 );
	end

end

local function FakelagOnPing()

	if not FAKELAG_WND_CHECKBOX:GetValue() then
		return
	end

	if not FAKELAG_EXTRA:GetValue() then
		return
	end

	if not FAKELAG_ON_PING:GetValue() then
		return
	end

	if entities.GetPlayerResources() ~= nil then
		Ping = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() );
	end

	FakelagOnPingAmount = math.floor( FAKELAG_ON_PING_AMOUNT:GetValue() )

	if ( Ping >= FakelagOnPingAmount ) or
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) then
		SetValue( "misc.fakelag.enable", 0 );
	else
		SetValue( "misc.fakelag.enable", 1 );
	end

end		

local function FakelagOnSlowWalk()

	if not FAKELAG_WND_CHECKBOX:GetValue() then
		return
	end

	if not FAKELAG_EXTRA:GetValue() then
		return
	end

	if GetValue( "rbot.accuracy.movement.slowkey" ) ~= 0 then
		SlowWalkFakelagOff = input.IsButtonDown( GetValue( "rbot.accuracy.movement.slowkey" ) )
	end

	if FAKELAG_ON_SLOWWALK:GetValue() and GetValue( "rbot.accuracy.movement.slowkey" ) ~= 0 then
		if ( SlowWalkFakelagOff ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PING:GetValue() and Ping >= FakelagOnPingAmount ) then																									 
			SetValue( "misc.fakelag.enable", 0 );
		else
			SetValue( "misc.fakelag.enable", 1 );
		end
	end
end

local function FakelagOnDoubletap()

	if not FAKELAG_WND_CHECKBOX:GetValue() then
		return
	end

	if not FAKELAG_EXTRA:GetValue() then
		return
	end
	
	if not FAKELAG_ON_DOUBLETAP:GetValue() then
		return
	end
	
	if GetValue( "rbot.hitscan.accuracy.asniper.doublefire" ) >= 0 then
		Doubletap_On = true
	end

	if FAKELAG_ON_DOUBLETAP:GetValue() then
		if ( Doubletap_On ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PING:GetValue() and Ping >= FakelagOnPingAmount ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_SLOWWALK:GetValue() and SlowWalkFakelagOff ) then
			SetValue( "misc.fakelag.enable", 0 );
		else
			SetValue( "misc.fakelag.enable", 1 );
		end
	end
end

local function FakelagSmartMode()

	if not FAKELAG_WND_CHECKBOX:GetValue() then
		return
	end

	if not FAKELAG_SMART_MODE:GetValue() then
		return
	end

	local FAKELAG_STANDING = FAKELAG_SMART_MODE_STANDING:GetValue();
	local FAKELAG_MOVING = FAKELAG_SMART_MODE_MOVING:GetValue();
	local FAKELAG_INAIR = FAKELAG_SMART_MODE_INAIR:GetValue();
	local FAKELAG_PEEK = FAKELAG_SMART_MODE_PEEK:GetValue();

	local FAKELAG_STANDING_FACTOR = math.floor( FAKELAG_SMART_MODE_STANDING_FACTOR:GetValue() )
	local FAKELAG_MOVING_FACTOR = math.floor( FAKELAG_SMART_MODE_MOVING_FACTOR:GetValue() )
	local FAKELAG_INAIR_FACTOR = math.floor( FAKELAG_SMART_MODE_INAIR_FACTOR:GetValue() )

	local FAKELAG_STANDING_TYPE = math.floor( FAKELAG_SMART_MODE_STANDING_TYPE:GetValue() )
	local FAKELAG_MOVING_TYPE = math.floor( FAKELAG_SMART_MODE_MOVING_TYPE:GetValue() )
	local FAKELAG_INAIR_TYPE = math.floor( FAKELAG_SMART_MODE_INAIR_TYPE:GetValue() )



	if entities.GetLocalPlayer() ~= nil then

		local LocalPlayerEntity = entities.GetLocalPlayer();
		local fFlags = LocalPlayerEntity:GetProp( "m_fFlags" );

		local VelocityX = LocalPlayerEntity:GetPropFloat( "localdata", "m_vecVelocity[0]" );
		local VelocityY = LocalPlayerEntity:GetPropFloat( "localdata", "m_vecVelocity[1]" );

		local Velocity = math.floor(math.min(10000, math.sqrt(VelocityX*VelocityX + VelocityY*VelocityY) + 0.5))

		-- Standing
		if ( Velocity == 0 and ( fFlags == 257 or fFlags == 261 or fFlags == 263 ) ) then
			Standing = true
		else
			Standing = false
		end

		-- Moving
		if ( Velocity > 0 and ( fFlags == 257 or fFlags == 261 or fFlags == 263 ) ) then
			Moving = true
		else
			Moving = false
		end

		-- In Air
		if fFlags == 256 or fFlags == 262 then
			InAir = true
			Time = globals.CurTime();
		else
			InAir = false
		end
	end

	if Standing and Time + 0.2 < globals.CurTime() then
		if ( FAKELAG_STANDING == 0 ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) or 	 -- On Revolver
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PING:GetValue() and Ping >= FakelagOnPingAmount ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_SLOWWALK:GetValue() and GetValue( "rbot.accuracy.movement.slowkey" ) ~= 0 and SlowWalkFakelagOff ) or
	   	( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_DOUBLETAP:GetValue() and GetValue("rbot.hitscan.accuracy.asniper.doublefire") >= 1 ) then
			SetValue( "misc.fakelag.enable", 0 );
		else
			SetValue( "misc.fakelag.enable", 1 );
		end
		if FAKELAG_STANDING > 0 then
			STANDING_MODE = ( FAKELAG_STANDING - 1 )
		end
		SetValue( "misc.fakelag.condition.standing", FAKELAG_STANDING );
		SetValue( "misc.fakelag.factor", FAKELAG_STANDING_FACTOR );
		SetValue( "misc.fakelag.type", FAKELAG_STANDING_TYPE );
	end

	if Moving and Time + 0.2 < globals.CurTime() then
		if ( FAKELAG_MOVING == 0 ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PING:GetValue() and Ping >= FakelagOnPingAmount ) or
			  ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_SLOWWALK:GetValue() and GetValue( "rbot.accuracy.movement.slowkey" ) ~= 0 and SlowWalkFakelagOff ) or -- On Revolver
	   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_DOUBLETAP:GetValue() and GetValue("rbot.hitscan.accuracy.asniper.doublefire") >= 1 ) then
		SetValue( "misc.fakelag.enable", 0 );
		else
		SetValue( "misc.fakelag.enable", 1 );
		end
		if FAKELAG_MOVING > 0 then
			MOVING_MODE = ( FAKELAG_MOVING - 1 )
		end
		SetValue( "misc.fakelag.condition.moving", FAKELAG_MOVING );
		SetValue( "misc.fakelag.factor", FAKELAG_MOVING_FACTOR );
		SetValue( "misc.fakelag.type", FAKELAG_MOVING_TYPE );
	end

	if InAir then
		if ( FAKELAG_INAIR == 0 ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_KNIFE:GetValue() and Knife ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_NADE:GetValue() and Nade ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_TASER:GetValue() and Taser ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PISTOL:GetValue() and Pistol ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_REVOLVER:GetValue() and Revolver ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_PING:GetValue() and Ping >= FakelagOnPingAmount ) or
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_SLOWWALK:GetValue() and GetValue( "rbot.accuracy.movement.slowkey" ) ~= 0 and SlowWalkFakelagOff ) or -- On Revolver
		   ( FAKELAG_EXTRA:GetValue() and FAKELAG_ON_DOUBLETAP:GetValue() and GetValue("rbot.hitscan.accuracy.asniper.doublefire") >= 1 ) then
			SetValue( "misc.fakelag.enable", 0 );
		else
			SetValue( "misc.fakelag.enable", 1 );
		end
			if FAKELAG_INAIR > 0 then
			INAIR_MODE = ( FAKELAG_INAIR - 1 )
		end
		SetValue( "misc.fakelag.condition.inair", FAKELAG_INAIR );
		SetValue( "misc.fakelag.factor", FAKELAG_INAIR_FACTOR );
		SetValue( "misc.fakelag.type", FAKELAG_INAIR_TYPE );
	end		
	if FAKELAG_PEEK == 0 then
			SetValue( "misc.fakelag.condition.peek", 0 );
		else
			SetValue( "misc.fakelag.condition.peek", 1 );
end
end

callbacks.Register( 'Draw', FakelagExtra )
callbacks.Register( 'Draw', FakelagOnPing )
callbacks.Register( 'Draw', FakelagOnSlowWalk )
callbacks.Register( 'Draw', FakelagOnDoubletap )
callbacks.Register( 'Draw', FakelagSmartMode )











--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

