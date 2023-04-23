local line = "theme.header.line"
local delay = 0
local state = 1;
local r = 255;
local g = 0;
local b = 0;

function rgbline(lol)
    if not kubrickmode:GetValue() then return end
    if globals.CurTime() < delay then return end

    if g < 255 and state == 1 then
        g = g+1
        r = r-1
        if g == 255 then
            state = 2
        end
    end

    if b < 255 and state == 2 then
        b = b+1
        g = g-1
        if b == 255 then
            state = 3
        end
    end

    
    if state == 3 then
        r = r+1
        b = b-1
        if b == 0 then
            state = 1
        end
    end

    gui.SetValue(line, r, g, b, 255)

    if kubrickdebug:GetValue() then
        print(r,g,b)
    end

    delay = globals.CurTime() + kubrickslider:GetValue() / 1000

end

function UI()
    kubrickmode = gui.Checkbox(gui.Reference("Settings","Theme", "Window Header"), "trans_right", "RGB Line", false)
    kubrickslider = gui.Slider(gui.Reference("Settings","Theme", "Window Header"), "kubrickslider", "Speed", 1, 1, 20, 1)
    kubrickdebug = gui.Checkbox(gui.Reference("Settings","Theme", "Window Header"), "lolzxesew", "RGB Info (DEBUG)", false)

end 
UI();

callbacks.Register("Draw", "isupporttransright", rgbline);

-- lua by https://aimware.net/forum/user/63613
-- stack overflow for rgb cycle https://stackoverflow.com/questions/31784658/how-can-i-loop-through-all-rgb-combinations-in-rainbow-order-in-java cuz small brain
-- facepunch for doing simple timer with curtime https://wiki.facepunch.com/gmod/Global.CurTime








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

