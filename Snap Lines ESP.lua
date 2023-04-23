function SnapLines() 
local screenCenterX, screenH = draw.GetScreenSize();
screenCenterX = screenCenterX * 0.5;

draw.Color( 255, 0, 0, 255 );

local players = entities.FindByClass( "CCSPlayer" );

for i = 1, #players do
local player = players[ i ];

if player:IsAlive() then
local x, y = client.WorldToScreen( player:GetAbsOrigin() );

if x ~= nil and y ~= nil then
draw.Line( x, y, screenCenterX, screenH );
end
end
end
end

callbacks.Register( "Draw", "SnapLines", SnapLines )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

