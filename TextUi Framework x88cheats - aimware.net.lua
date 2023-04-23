--[[
# DON'T BE A DICK PUBLIC LICENSE

> Version 1.1, December 2016

> Copyright (C) [2020] [Janek "superyu"]

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document.

> DON'T BE A DICK PUBLIC LICENSE
> TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

1. Do whatever you like with the original work, just don't be a dick.

   Being a dick includes - but is not limited to - the following instances:

 1a. Outright copyright infringement - Don't just copy this and change the name.
 1b. Selling the unmodified original with no work done what-so-ever, that's REALLY being a dick.
 1c. Modifying the original work to contain hidden harmful content. That would make you a PROPER dick.

2. If you become rich through modifications, related works/services, or supporting the original work,
share the love. Only a dick would make loads off this work and not buy the original work's
creator(s) a pint.

3. Code is provided with no warranty. Using somebody else's code and bitching when it goes wrong makes
you a DONKEY dick. Fix the problem yourself. A non-dick would submit the fix back.
]]

--[[
    ---INSTRUCTIONS---
    Hey, this is an x88 style menu framework.
    This is my first GUI Framework so if you find bugs then report them.
    I tried building it up in an object structure.
    The oMenu object is basically the menu.
    There is rows and columns, current row current column for the selection and a VARS table where all gui objects are stored.
    There is also a keystates table. I SUGGEST NOT TOUCHING ANY OF THOSE TABLES WITH EXECPTION OF THE X AND Y TABLE!!!

    The good thing about this framework is, you don't need to hardcode anything.
    You create the oMenu, then you simply create for example a boolSwitch (checkbox) in the on_paint with

    oMenu.addBoolSwitch(name, varname, defaultValue)

    or to put it into actual useable code:

    oMenu.addBoolSwitch("Bhop", "misc.strafe.enable", false)

    As you can see, it's very simple to use this framework.
    Now have fun making your own x88 styled menu! :D
]]

--- Keybox.
local KEY = gui.Keybox(gui.Reference("Settings", "Advanced", "Manage advanced settings"), "x88framework.key", "x88 Framework - Menu Key", 0)

--- Menu Object
local oMenu = {
    ["VISIBLE"] = false,
    ["X"] = -300,
    ["Y"] = 25,
    ["XSPACING"] = 400,
    ["YSPACING"] = 15,
    ["ROW"] = 0,
    ["COLUMN"] = 0,
    ["CURRENTROW"] = 0,
    ["CURRENTCOLUMN"] = 1,
    ["ROWSINCOLUMN"] = {},
    ["COLUMNSINROW"] = {},
    ["SHOULDSKIP"] = {},
    ["VARS"] = {},

    ["KEYSTATES"] = {
        ["BACKSPACE"] = false,
        ["ENTER"] = false,
        ["LEFTARROW"] = false,
        ["UPARROW"] = false,
        ["RIGHTARROW"] = false,
        ["DOWNARROW"] = false,
    },
}

--- Font creation
local font = draw.CreateFont("Tahoma", 18, 750);

--- API Localization
local getKeyState = input.IsButtonPressed
local drawText = draw.TextShadow
local setColor = draw.Color
local setVal = gui.SetValue
local getVal = gui.GetValue

--- Handle input for keycode and set keystate to true/false.
function oMenu.handleInput(keycode, value)
    if keycode == 0 then return end
    oMenu["KEYSTATES"][value] = getKeyState(keycode)
end

function oMenu.tableLength()
    local count = 0
    for kek in pairs(table) do count = count + 1 end
    return count
end

function oMenu.color(r, g, b, a)
    local color = {}
    color.r, color.g, color.b, color.a = r, g, b, a
    return color;
end

function oMenu.percentageColor(color1, color2, percent)
    if percent > 1 then
        percent = 1
    elseif percent < 0 then
        percent = 0
    end
    local r, g, b = color1.r-(color1.r-color2.r)*percent, color1.g-(color1.g-color2.g)*percent, color1.b-(color1.b-color2.b)*percent
    return oMenu.color(math.floor(r), math.floor(g), math.floor(b), 255)
end

function oMenu.renderText(x, y, color, text)
    setColor(color.r, color.g, color.b, color.a)
    drawText(x, y, text)
end

--- Add a boolswitch, basically a checkbox.
function oMenu.addBoolSwitch(name, varname, default)
    if oMenu["VARS"][varname] == nil then
        oMenu["VARS"][varname] = varname;
        setVal(oMenu["VARS"][varname], default)
    end

    local x, y = oMenu["X"]+(oMenu["XSPACING"]*oMenu["COLUMN"]), oMenu["Y"]+(25*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            setVal(oMenu["VARS"][varname], not getVal(oMenu["VARS"][varname]))
        end
        oMenu.renderText(x, y, oMenu.color(255, 255, 25, 255), name);
    else
        oMenu.renderText(x, y, oMenu.color(255, 255, 255, 255), name)
    end

    if getVal(oMenu["VARS"][varname]) then
        oMenu.renderText(x+150, y, oMenu.color(25, 255, 25, 255), "ON")
    else
        oMenu.renderText(x+150, y, oMenu.color(255, 25, 25, 255), "OFF")
    end

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

--- Slider
function oMenu.addSlider(name, varname, default, minValue, maxValue, step)
    if oMenu["VARS"][varname] == nil then
        oMenu["VARS"][varname] = varname;
        setVal(oMenu["VARS"][varname], default)
    end

    local x, y = oMenu["X"]+(oMenu["XSPACING"]*oMenu["COLUMN"]), oMenu["Y"]+(25*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            if getVal(oMenu["VARS"][varname])+step <= maxValue then
                setVal(oMenu["VARS"][varname], getVal(oMenu["VARS"][varname])+step)
            end
        end

        if oMenu["KEYSTATES"]["BACKSPACE"] then
            if getVal(oMenu["VARS"][varname])-step >= minValue then
                setVal(oMenu["VARS"][varname], getVal(oMenu["VARS"][varname])-step)
            end
        end

        oMenu.renderText(x, y, oMenu.color(255, 255, 25, 255), name);
    else
        oMenu.renderText(x, y, oMenu.color(255, 255, 255, 255), name)
    end

    local color = oMenu.percentageColor(oMenu.color(255, 25, 25, 255), oMenu.color(25, 255, 25, 255), (getVal(oMenu["VARS"][varname])-minValue)/(maxValue-minValue))
    oMenu.renderText(x+150, y, color, tostring(getVal(oMenu["VARS"][varname])))

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

--- An multiSwitch, basically a multibox
function oMenu.addMultiSwitch(name, varname, default, options)
    if oMenu["VARS"][varname] == nil then
        oMenu["VARS"][varname] = varname;
        setVal(oMenu["VARS"][varname], default)
    end

    local x, y = oMenu["X"]+(oMenu["XSPACING"]*oMenu["COLUMN"]), oMenu["Y"]+(25*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            if getVal(oMenu["VARS"][varname])+1 <= oMenu.tableLength(options) then
                setVal(oMenu["VARS"][varname], getVal(oMenu["VARS"][varname])+1)
            end
        end

        if oMenu["KEYSTATES"]["BACKSPACE"] then
            if getVal(oMenu["VARS"][varname])-1 >= 0 then
                setVal(oMenu["VARS"][varname], getVal(oMenu["VARS"][varname])-1)
            end
        end

        oMenu.renderText(x, y, oMenu.color(255, 255, 25, 255), name);
    else
        oMenu.renderText(x, y, oMenu.color(255, 255, 255, 255), name)
    end

    local col = oMenu.color(255, 255, 255, 255)
    if getVal(oMenu["VARS"][varname]) == 0 then
        col = oMenu.color(255, 25, 25, 255)
    end
    oMenu.renderText(x+150, y, col, options[getVal(oMenu["VARS"][varname])+1])
    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.addLabel(text, color)
    local x, y = oMenu["X"]+(oMenu["XSPACING"]*oMenu["COLUMN"]), oMenu["Y"]+(25*oMenu["ROW"])
    oMenu.renderText(x, y, color, text)
    table.insert(oMenu["SHOULDSKIP"], {oMenu["COLUMN"], oMenu["ROW"]})
    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.addEmpty()
    table.insert(oMenu["SHOULDSKIP"], {oMenu["COLUMN"], oMenu["ROW"]})
    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"];
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

--- Start a new column in the menu
function oMenu.nextColumn()
    oMenu["ROWSINCOLUMN"][oMenu["COLUMN"]] = oMenu["ROW"]
    oMenu["COLUMN"] = oMenu["COLUMN"] + 1
    oMenu["ROW"] = 0;
    return true;
end

--- Create the menu, update keystates.
function oMenu.Create()

    oMenu.handleInput(KEY:GetValue(), "MENUKEY");

    if oMenu["KEYSTATES"]["MENUKEY"] then
        oMenu["VISIBLE"] = not oMenu["VISIBLE"];
    end

    if oMenu["VISIBLE"] then
        oMenu.handleInput(8, "BACKSPACE")
        oMenu.handleInput(13, "ENTER")
        oMenu.handleInput(37, "LEFTARROW")
        oMenu.handleInput(38, "UPARROW")
        oMenu.handleInput(39, "RIGHTARROW")
        oMenu.handleInput(40, "DOWNARROW")

        for k, v in ipairs(oMenu["SHOULDSKIP"]) do
            gui.Command("clear")
            print("COL:" .. v[1] .. " - " .. oMenu["CURRENTCOLUMN"])
            print("ROW:" .. v[2] .. " - " .. oMenu["CURRENTROW"])
            if v[1] == oMenu["CURRENTCOLUMN"] and v[2] == oMenu["CURRENTROW"] then
                oMenu["CURRENTROW"] = oMenu["CURRENTROW"] - 1
            end
        end

        oMenu["ROWSINCOLUMN"][oMenu["COLUMN"]] = oMenu["ROW"]

        if oMenu["KEYSTATES"]["LEFTARROW"] then
            if oMenu["CURRENTCOLUMN"] > 1 then
                oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] - 1
                for k, v in ipairs(oMenu["SHOULDSKIP"]) do
                    if v[1] == oMenu["CURRENTCOLUMN"] and v[2] == oMenu["CURRENTROW"] then
                        if oMenu["CURRENTCOLUMN"] > 1 then
                            oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] - 1
                        else
                            oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] + 1
                        end
                    end
                end
            end
        end

        if oMenu["KEYSTATES"]["RIGHTARROW"] then
            if oMenu["CURRENTCOLUMN"] < oMenu["COLUMN"] then
                if oMenu["COLUMNSINROW"][oMenu["CURRENTROW"]] > oMenu["CURRENTCOLUMN"] then
                    oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] + 1
                end
                for k, v in ipairs(oMenu["SHOULDSKIP"]) do
                    if v[1] == oMenu["CURRENTCOLUMN"] and v[2] == oMenu["CURRENTROW"] then
                        if oMenu["COLUMNSINROW"][oMenu["CURRENTROW"]] > oMenu["CURRENTCOLUMN"] then
                            oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] + 1
                        else
                            oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] - 1
                        end
                    end
                end
            end
        end

        if oMenu["KEYSTATES"]["UPARROW"] then
            if oMenu["CURRENTROW"] > 0 then
                oMenu["CURRENTROW"] = oMenu["CURRENTROW"] - 1
                for k, v in ipairs(oMenu["SHOULDSKIP"]) do
                    if v[1] == oMenu["CURRENTCOLUMN"] and v[2] == oMenu["CURRENTROW"] then
                        if oMenu["CURRENTROW"] > 0 then
                            oMenu["CURRENTROW"] = oMenu["CURRENTROW"] - 1
                        else
                            oMenu["CURRENTROW"] = oMenu["CURRENTROW"] + 1
                        end
                    end
                end
            end
        end

        if oMenu["KEYSTATES"]["DOWNARROW"] then
            if oMenu["ROWSINCOLUMN"][oMenu["CURRENTCOLUMN"]] ~= nil then
                if oMenu["CURRENTROW"] < oMenu["ROWSINCOLUMN"][oMenu["CURRENTCOLUMN"]] - 1 then
                    oMenu["CURRENTROW"] = oMenu["CURRENTROW"] + 1
                end
                for k, v in ipairs(oMenu["SHOULDSKIP"]) do
                    if v[1] == oMenu["CURRENTCOLUMN"] and v[2] == oMenu["CURRENTROW"] then
                        if oMenu["CURRENTROW"] < oMenu["ROWSINCOLUMN"][oMenu["CURRENTCOLUMN"]] - 1 then
                            oMenu["CURRENTROW"] = oMenu["CURRENTROW"] + 1
                        else
                            oMenu["CURRENTROW"] = oMenu["CURRENTROW"] - 1
                        end
                    end
                end
            end
        end

        oMenu["ROW"] = 0
        oMenu["COLUMN"] = 1;
        draw.SetFont(font)
        return true;
    else
        return false;
    end
end

local function hkDraw()

    if oMenu.Create() then

        oMenu.addBoolSwitch("Autostrafe", "misc.strafe.enable", false)
        oMenu.addSlider("Retrack Speed", "misc.strafe.retrack", 0, 0, 8, 0.5)
        oMenu.addMultiSwitch("Enemy Chams", "esp.chams.enemy.occluded", 1, {"Off", "Flat", "Color", "Metallic", "Glow"})

        if oMenu.nextColumn() then
            oMenu.addBoolSwitch("Fakelag", "misc.fakelag.enable", false)
            oMenu.addLabel("sup nigga", oMenu.color(255, 255, 255, 255))
            oMenu.addSlider("Fakelag Factor", "misc.fakelag.factor", 6, 3, 17, 1)
        end
    end
end

callbacks.Register("Draw", hkDraw)