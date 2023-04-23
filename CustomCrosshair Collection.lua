-- Crosshair_black_n_white

local VISUALz = gui.Reference('VISUALS', 'Other', 'Extra')
local visualtabmisc = gui.Text(VISUALz, "Choose a Custom Crosshair")
local basicbitch_crosshair = gui.Checkbox( VISUALz, "msc_basicbitch", "Black n White MiniCrosshair", 0)
local function basicbitchxhair()

if entities.GetLocalPlayer() == nil then end;

if basicbitch_crosshair:GetValue() ~= true then return;
    else
	if basicbitch_crosshair:GetValue() then
        local screencenter2X, screencenter2Y = draw.GetScreenSize() --getting the full screensize
        screencenter2X = screencenter2X / 2; screencenter2Y = screencenter2Y / 2 --dividing the screensize by 2 will place it perfectly in the center whatever resolution
        draw.Color( 255, 255, 255, 255)
        draw.RoundedRect(screencenter2X+1 , screencenter2Y+1 , screencenter2X-1, screencenter2Y-1)
        draw.Color( 0, 0,0, 255)
        draw.RoundedRect(screencenter2X , screencenter2Y , screencenter2X, screencenter2Y)
end
end
end
callbacks.Register( "Draw", basicbitchxhair)


------------------------------------------------------------------------------------------------------------------------------------------
-- Crosshair_rainbow_colored_Nazi88

local degree = 0
local VISUALz2 = gui.Reference('VISUALS', 'Other', 'Extra')
local swastikkka_crosshair = gui.Checkbox( VISUALz2, "msc_swastikkka", "88´er Rainbow Crosshair", 0)
local swastikkka_crosshairslidesize = gui.Slider(VISUALz2, "msc_swasisize", "SwastiSize", 15.0, 1, 100.0)
local swastikkka_crosshairsliderspeed = gui.Slider(VISUALz2, "msc_swasispeed", "SwastiSpeed", 1.0, -10.0, 10.0)

local function rainbowxhair()

if entities.GetLocalPlayer() == nil then end;

if swastikkka_crosshair:GetValue() ~= true then return;

    else
	if swastikkka_crosshair:GetValue() then
    local r = math.floor(math.sin(globals.RealTime() * swastikkka_crosshairsliderspeed:GetValue()) * 127 + 128)
    local g = math.floor(math.sin(globals.RealTime() * swastikkka_crosshairsliderspeed:GetValue() + 2) * 127 + 128)
    local b = math.floor(math.sin(globals.RealTime() * swastikkka_crosshairsliderspeed:GetValue() + 4) * 127 + 128)
    
    local cX, cY = draw.GetScreenSize()
    
    cX = cX / 2
    cY = cY / 2
    
    draw.Color(r, g, b)
    for i=0, 3 do
        local x1, y1, x2, y2
        
        x1 = swastikkka_crosshairslidesize:GetValue()*math.sin(math.rad(degree+(i*90)))
        y1 = swastikkka_crosshairslidesize:GetValue()*math.cos(math.rad(degree+(i*90)))
        
        x2 = swastikkka_crosshairslidesize:GetValue()*math.sin(math.rad(degree+270+(i*90)))
        y2 = swastikkka_crosshairslidesize:GetValue()*math.cos(math.rad(degree+270+(i*90)))

        draw.Line(cX, cY, cX+x1, cY-y1)
        draw.Line(cX+x1, cY-y1, cX+x1-x2, cY-y1+y2)
    end
    
    degree = degree+swastikkka_crosshairsliderspeed:GetValue()*100*globals.FrameTime()
    if degree >= 360 then
        degree = 0
    end
    end
end 
end
callbacks.Register( "Draw", rainbowxhair) 

