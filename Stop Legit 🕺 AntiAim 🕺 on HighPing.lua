local SetValue = gui.SetValue;
local GetValue = gui.GetValue;

local LBOT_EXTRA_REF = gui.Reference( "Legitbot", "Other","Extra");

local LBOT_ANTI_AIM_ON_PING = gui.Slider( LBOT_EXTRA_REF, "lua_lbot_antiaim_ping", "Legit Anti-Aim Off On Ping", 0, 0, 120 );

local LBOT_ANTI_AIM_MODE = GetValue( "lbot.antiaim.type" );

local function LegitAnitAimOnPing()

if ( GetValue( "lbot.antiaim.type") and LBOT_ANTI_AIM_MODE ~= 0 ) then

local LegitAnitAimOnPingValue = math.floor( LBOT_ANTI_AIM_ON_PING:GetValue() )

if entities.GetPlayerResources() ~= nil then

local Ping = entities.GetPlayerResources():GetPropInt( "m_iPing", client.GetLocalPlayerIndex() ); 

if LegitAnitAimOnPingValue > 0 then
if Ping <= LegitAnitAimOnPingValue then
SetValue( "lbot.antiaim.type.max", LBOT_ANTI_AIM_MODE );
else
SetValue( "lbot.antiaim.type.off");
end
end

end

end

end

callbacks.Register( "Draw", "Legit Anit-Aim On Ping", LegitAnitAimOnPing )







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

