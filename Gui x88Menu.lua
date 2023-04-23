local oMenu = {
    ["VISIBLE"] = true,
    ["X"] = 100,
    ["Y"] = 60,
    ["ROW"] = 0,
    ["COLUMN"] = 0,
    ["CURRENTROW"] = 0,
    ["CURRENTCOLUMN"] = 1,
    ["ROWSINCOLUMN"] = {},
    ["COLUMNSINROW"] = {},
    ["VARS"] = {},

    ["KEYSTATES"] = {
        ["BACKSPACE"] = false,
        ["ENTER"] = false,
        ["LEFTARROW"] = false,
        ["UPARROW"] = false,
        ["RIGHTARROW"] = false,
        ["DOWNARROW"] = false,
    },

    ["LASTKEYSTATES"] = {}
}

local font1 = draw.CreateFont('Verdana', 14, 0, true)
local lastTick = 0;
draw.SetFont( font1 );

local function handle_weapon(wid)
    if wid == 1 or wid == 64 then
        return "hpistol"
    elseif wid == 2 or wid == 3 or wid == 4 or wid == 30 or wid == 32 or wid == 36 or wid == 61 or wid == 63 then
        return "pistol"
    elseif wid == 7 or wid == 8 or wid == 10 or wid == 13 or wid == 16 or wid == 39 or wid == 60 then
        return "rifle"
    elseif wid == 11 or wid == 38 then
        return "asniper"
    elseif wid == 17 or wid == 19 or wid == 23 or wid == 24 or wid == 26 or wid == 33 or wid == 34 then
        return "smg"
    elseif wid == 14 or wid == 28 then
        return "lmg"
    elseif wid == 25 or wid == 27 or wid == 29 or wid == 35 then
        return "shotgun"
    elseif wid == 9 then
        return "sniper"
    elseif wid == 40 then
        return "scout"
    else
        return "scout"
    end
end


function oMenu.addBoolSwitch(name, i, guiObject, default)
    draw.SetFont( font1 );
    if oMenu["VARS"][i] == nil then
        oMenu["VARS"][i] = guiObject;
    end

    local x, y = oMenu["X"]+(200*oMenu["COLUMN"]), oMenu["Y"]+(15*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            gui.SetValue( oMenu["VARS"][i], not gui.GetValue( oMenu["VARS"][i] ))
            print(gui.GetValue( oMenu["VARS"][i] ))
        end
        draw.Color(255, 255, 25, 255)
        draw.TextShadow(x, y, name);
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x, y, name)
    end

    if gui.GetValue(oMenu["VARS"][i]) then
        draw.Color(31, 142, 255, 255)
        draw.TextShadow(x+110, y, "ON")
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x+110, y, "OFF")
    end

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.addDropDown(name, i, guiObject, rangeMax, drawName)
    draw.SetFont( font1 );
    if oMenu["VARS"][i] == nil then
        oMenu["VARS"][i] = guiObject;
    end

    local x, y = oMenu["X"]+(200*oMenu["COLUMN"]), oMenu["Y"]+(15*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] and gui.GetValue( oMenu["VARS"][i] ) <= rangeMax then
            gui.SetValue( oMenu["VARS"][i], gui.GetValue( oMenu["VARS"][i] ) + 1)
        elseif oMenu["KEYSTATES"]["BACKSPACE"] and gui.GetValue(oMenu["VARS"][i]) >= 0 then
            gui.SetValue( oMenu["VARS"][i], gui.GetValue( oMenu["VARS"][i] ) - 1)
        end
        draw.Color(255, 255, 25, 255)
        draw.TextShadow(x, y, name);
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x, y, name)
    end

    if gui.GetValue(oMenu["VARS"][i]) > 0 then
        draw.Color(31, 142, 255, 255)
        draw.TextShadow(x+110, y, drawName[gui.GetValue( oMenu["VARS"][i] )])
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x+110, y, "OFF")
    end

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.addAAMode(name, i, guiObject, rangeMax, drawName)
    draw.SetFont( font1 );
    if oMenu["VARS"][i] == nil then
        oMenu["VARS"][i] = guiObject;
    end

    local x, y = oMenu["X"]+(200*oMenu["COLUMN"]), oMenu["Y"]+(15*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] and gui.GetValue( oMenu["VARS"][i] ) <= rangeMax then
            gui.SetValue( oMenu["VARS"][i], gui.GetValue( oMenu["VARS"][i] ) + 1)
        elseif oMenu["KEYSTATES"]["BACKSPACE"] and gui.GetValue(oMenu["VARS"][i]) >= 0 then
            gui.SetValue( oMenu["VARS"][i], gui.GetValue( oMenu["VARS"][i] ) - 1)
        end
        draw.Color(255, 255, 25, 255)
        draw.TextShadow(x, y, name);
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x, y, name)
    end

    if(gui.GetValue(oMenu["VARS"][i]) == 0) then
        draw.Color(31, 142, 255, 255)
        draw.TextShadow(x+110, y, "Lowerbody")
    else
        draw.Color(31, 142, 255, 255)
        draw.TextShadow(x+110, y, "Micromovement")
    end

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.handleInput(keycode, value)
    draw.SetFont( font1 );
    local isActive = input.IsButtonPressed(keycode)
    if oMenu["LASTKEYSTATES"][value] == nil then
        if isActive and oMenu["LASTKEYSTATES"][keycode] == false then
            oMenu["KEYSTATES"][value] = true;
        else
              oMenu["KEYSTATES"][value] = false;
        end
    end
    oMenu["LASTKEYSTATES"][keycode] = isActive
end

function oMenu.tableLength()
    draw.SetFont( font1 );
    local count = 0
    for kek in pairs(table) do count = count + 1 end
    return count
end

function oMenu.percentageColor(r1, g1, b1, a1, r2, g2, b2, a2, percent)
    draw.SetFont( font1 );
    if percent > 1 then
        percent = 1
    elseif percent < 0 then
        percent = 0
    end
    local r, g, b = r1-(r1-r2)*percent, g1-(g1-g2)*percent, b1-(b1-b2)*percent
    return math.floor(r), math.floor(g), math.floor(b)
end

function oMenu.nextColumn()
    draw.SetFont( font1 );
    oMenu["ROWSINCOLUMN"][oMenu["COLUMN"]] = oMenu["ROW"]
    oMenu["COLUMN"] = oMenu["COLUMN"] + 1
    oMenu["ROW"] = 0;
    return true;
end

function oMenu.Create()
    draw.SetFont( font1 );
    --oMenu.handleInput(keybox:get_value(), "MENUKEY");
    if oMenu["KEYSTATES"]["MENUKEY"] then
        oMenu["VISIBLE"] = not oMenu["VISIBLE"];
    end

    if 1 == 1 then
        oMenu.handleInput(8, "BACKSPACE")
        oMenu.handleInput(13, "ENTER")
        oMenu.handleInput(37, "LEFTARROW")
        oMenu.handleInput(38, "UPARROW")
        oMenu.handleInput(39, "RIGHTARROW")
        oMenu.handleInput(40, "DOWNARROW")

        oMenu["ROWSINCOLUMN"][oMenu["COLUMN"]] = oMenu["ROW"]

        if oMenu["KEYSTATES"]["LEFTARROW"] then
            if oMenu["CURRENTCOLUMN"] > 1 then
                oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] - 1
            end
        end

        if oMenu["KEYSTATES"]["RIGHTARROW"] then
            if oMenu["CURRENTCOLUMN"] < oMenu["COLUMN"] then
                if oMenu["COLUMNSINROW"][oMenu["CURRENTROW"]] > oMenu["CURRENTCOLUMN"] then
                    oMenu["CURRENTCOLUMN"] = oMenu["CURRENTCOLUMN"] + 1
                end
            end
        end

        if oMenu["KEYSTATES"]["UPARROW"] then
            if oMenu["CURRENTROW"] > 0 then
                oMenu["CURRENTROW"] = oMenu["CURRENTROW"] - 1
            end
        end

        if oMenu["KEYSTATES"]["DOWNARROW"] then
            if oMenu["ROWSINCOLUMN"][oMenu["CURRENTCOLUMN"]] ~= nil then
                if oMenu["CURRENTROW"] < oMenu["ROWSINCOLUMN"][oMenu["CURRENTCOLUMN"]] - 1 then
                    oMenu["CURRENTROW"] = oMenu["CURRENTROW"] + 1
                end
            end
        end

        oMenu["ROW"] = 0
        oMenu["COLUMN"] = 1;
        return true;
    else
        return false;
    end
end

function oMenu.addAAswitch(name, i, guiObject, default)
    draw.SetFont( font1 );
    if oMenu["VARS"][i] == nil then
        oMenu["VARS"][i] = guiObject;
    end
  
    local x, y = oMenu["X"]+(200*oMenu["COLUMN"]), oMenu["Y"]+(15*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            gui.SetValue("rbot.antiaim.base", "180 Desync")
        elseif oMenu["KEYSTATES"]["BACKSPACE"] then
            gui.SetValue("rbot.antiaim.base", "180 Off")
        end
        draw.Color(255, 255, 25, 255)
        draw.TextShadow(x, y, name);
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x, y, name)
    end

    if gui.GetValue("rbot.antiaim.base") then --FIXME
        draw.Color(255, 25, 25, 255)
        draw.TextShadow(x+110, y, "ON")
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x+110, y, "OFF")
    end

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

function oMenu.addSlider(name, value, guiObject, default, minValue, maxValue, pValue)
    draw.SetFont( font1 );
    if oMenu["VARS"][value] == nil then
        oMenu["VARS"][value] = guiObject;
    end

    local x, y = oMenu["X"]+(200*oMenu["COLUMN"]), oMenu["Y"]+(15*oMenu["ROW"])

    if oMenu["CURRENTROW"] == oMenu["ROW"] and oMenu["CURRENTCOLUMN"] == oMenu["COLUMN"] then
        if oMenu["KEYSTATES"]["ENTER"] then
            if gui.GetValue(oMenu["VARS"][value]) + pValue <= maxValue then
                gui.SetValue(oMenu["VARS"][value], tonumber(gui.GetValue(oMenu["VARS"][value])+pValue))
            end
        end

        if oMenu["KEYSTATES"]["BACKSPACE"] then
            if gui.GetValue(oMenu["VARS"][value]) - pValue >= minValue then
                gui.SetValue(oMenu["VARS"][value], tonumber(gui.GetValue(oMenu["VARS"][value])-pValue))
            end
        end

        draw.Color(255, 255, 25, 255)
        draw.TextShadow(x, y, name);
    else
        draw.Color(255, 255, 255, 255)
        draw.TextShadow(x, y, name)
    end

    local r, g, b = oMenu.percentageColor(255, 25, 25, 255, 25, 255, 25, 255, (gui.GetValue(oMenu["VARS"][value])-minValue)/(maxValue-minValue))
    draw.Color(r, g,b)
    draw.TextShadow(x+110, y, tostring(gui.GetValue(oMenu["VARS"][value])))

    oMenu["COLUMNSINROW"][oMenu["ROW"]] = oMenu["COLUMN"]
    oMenu["ROW"] = oMenu["ROW"] + 1;
end

local real = 0
local lby = 0
local kills = 0
local deaths = 0
local kd = 0
local ping = ""

local function create_move(cmd)
    local local_player = entities.GetLocalPlayer()

    if not local_player == nil or local_player:IsAlive() == true then
        real = cmd:GetViewAngles().y
        lby = local_player:GetProp("m_flLowerBodyYawTarget");
    end
end

local function welcome()
    draw.SetFont( font1 );
    draw.TextShadow(300, 7, "Hello Masterlooser :)");
    draw.TextShadow(300, 22, "hydratioN :)"); --insert your retarded name here

    draw.TextShadow(300, 37, "Real: " .. math.floor(real * 100) / 100)
    draw.TextShadow(410, 37, "LBY: " .. math.floor(lby * 100) / 100)
    draw.TextShadow(500, 37, "Diff: " .. math.floor((real - lby) * 100) / 100)
    draw.TextShadow(500, 150, "Kills: " .. kills)
    draw.TextShadow(520, 165, "Deaths: " .. deaths)
    draw.Color(85 * kd, 100 * kd, 0 * kd, 255)
    draw.TextShadow(500, 180, "KD: " .. math.floor(kd * 100) / 100)
    draw.Color(255, 255, 255, 255)
    draw.TextShadow(500, 195, "Ping: " .. ping)
end

local function props()
    local local_player = entities.GetLocalPlayer()
    local playerResources = entities.GetPlayerResources()

    if not local_player == nil or local_player:IsAlive() == true then
        ping = playerResources:GetPropInt("m_iPing", client.GetLocalPlayerIndex())
        kills = entities.GetPlayerResources():GetPropInt('m_iKills', client.GetLocalPlayerIndex());
        deaths = entities.GetPlayerResources():GetPropInt('m_iDeaths', client.GetLocalPlayerIndex());
        kd = kills / deaths
    end
end

local function on_draw()
    draw.SetFont( font1 );
    welcome()
    local local_player = entities.GetLocalPlayer()

    --if local_player:IsAlive() == false or local_player == nil then return end

    local local_weapon = local_player:GetWeaponID()

    local str_min_damage = "rbot.hitscan.accuracy.".. handle_weapon(local_weapon) ..".mindamage"

    if oMenu.Create() then
        oMenu.addBoolSwitch("Triggerbot:", "x88.trigger", "lbot.trg.enable", 0)
        oMenu.addDropDown("Bunnyhop:", "x88.bhop", "misc.autojump", 2, {"PERFECT", "LEGIT"})
        oMenu.addDropDown("Chams:", "x88.chams", "esp.chams.enemy.occluded", 6, {"F_Static", "V_Static", "M_Static", "G_Static", "P_Static", "B_Static"})
        oMenu.addDropDown("Esp:", "x88.esp", "esp.overlay.enemy.box", 2, {"ON", "ON"})
        oMenu.addBoolSwitch("RankESP:", "x88.rankesp", "misc.rankreveal", 1)
        oMenu.addDropDown("HandChams:", "x88.nohands", "esp.chams.localarms.visible", 8, {"F_Static", "V_Static", "M_Static", "G_Static", "P_Static", "B_Static", "T_Static", "I_Static"})
        oMenu.addAAswitch("AA:", "x88.aa", "rbot.antiaim.base", "false")
        oMenu.addAAMode("AA Mode:", "x88.aamode", "rbot.antiaim.advanced.antialign", 2, {"Lowerbody", "Micromovement"})
        oMenu.addBoolSwitch("Clantag:", "x88.clantag", "misc.clantag", 0)
        oMenu.addBoolSwitch("Fakelag:", "x88.fakelag", "misc.fakelag.enable", 0)
        oMenu.addSlider("FOVChanger:", "x88.fov", "esp.local.fov", 90, 50, 120, 5)
        oMenu.addSlider("Weapon FOV:", "x88.weapon.fov", "esp.local.viewmodelfov", 54, 40, 90, 5 )
        oMenu.addBoolSwitch("Crosshair:", "x88.crosshair", "esp.other.crosshair", 0)
        oMenu.addBoolSwitch("pSilent:", "x88.silent", "lbot.semirage.silentaimbot", 0)
        oMenu.addBoolSwitch("Auto Revolver:", "x88.revolver", "rbot.aim.automation.revolver", 1)
        oMenu.addBoolSwitch("HvH mode:", "x88.hvh", "rbot.master", 0)
        --oMenu.addBoolSwitch("")
        --oMenu.addDropDown("")
    end

    if(oMenu.nextColumn()) then
        oMenu.addBoolSwitch("Silent HvH:", "x88.silent.hvh", "rbot.aim.target.silentaim", 1)
        oMenu.addBoolSwitch("Legit:", "x88.legit", "lbot.master", 1)
        oMenu.addBoolSwitch("Thirdp:", "x88.thirdperson", "esp.local.thirdperson", 0)
        oMenu.addDropDown("BTChams:", "x88.btchams", "esp.chams.backtrack.visible", 8, {"F_Static", "V_Static", "M_Static", "G_Static", "P_Static", "B_Static", "T_Static", "I_Static"})
        oMenu.addBoolSwitch("Fakelag:", "x88.fakelag", "misc.fakelag.enable", 0)
        oMenu.addSlider("Legit FOV:", "x88.legit.fov", "lbot.weapon.target.shared.maxfov", 1.5, 0, 30, 1)
        --trolling
      
    end
end

callbacks.Register("Draw", props)
callbacks.Register("CreateMove", create_move)
callbacks.Register("Draw", on_draw)




--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")