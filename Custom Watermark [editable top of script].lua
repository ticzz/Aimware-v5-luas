local name = 'aimware.net Beta';
local seperator = '|';
local fps = "fps";

local count = 0;
local last = globals.RealTime();

local frame_rate = 0.0
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end


local function draw_logo( )
    draw.Color(110,110,110, 255)
    draw.FilledRect(5, 5, 245, 35)
    draw.Color(255, 255, 255, 255)
    draw.FilledRect(10, 10, 240, 30)
    draw.Color(0, 0, 0, 255)
    draw.Text(15, 15, name)
    draw.Text(137, 14, seperator)

    local fps = get_abs_fps()

if fps<30 then
draw.Color(150, 0, 0, 255)
elseif fps<60 then
draw.Color(150, 150, 0, 255)
else
draw.Color(0, 150, 0, 255)
end
    
    draw.Text(143, 15, get_abs_fps())
    draw.Text(165, 15, "  fps")
end

callbacks.Register( 'Draw', 'Logo', draw_logo );

