-- Crosshair_black_n_white

local VISUALz = gui.Reference('VISUALS', 'Other', 'Extra')
local visualtabmisc = gui.Text(VISUALz, "Choose a Custom Crosshair")
local basicbitch_crosshair = gui.Checkbox( VISUALz, "msc_basicbitch", "Black n White MiniCrosshair", 0)
function basicbitchxhair()
if not basicbitch_crosshair:GetValue() then return end;
        if entities.GetLocalPlayer() == nil then end;
    if basicbitch_crosshair:GetValue() then
        local screencenter2X, screencenter2Y = draw.GetScreenSize() --getting the full screensize
        screencenter2X = screencenter2X / 2; screencenter2Y = screencenter2Y / 2 --dividing the screensize by 2 will place it perfectly in the center whatever resolution
        draw.Color( 255, 255, 255, 255)
        draw.RoundedRect(screencenter2X+1 , screencenter2Y+1 , screencenter2X-1, screencenter2Y-1)
        draw.Color( 0, 0,0, 255)
        draw.RoundedRect(screencenter2X , screencenter2Y , screencenter2X, screencenter2Y)
end
end
callbacks.Register( "Draw", basicbitchxhair)

