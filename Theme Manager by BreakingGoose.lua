function listThemes()
    local t = {}
    file.Enumerate(function(filename)
        if (string.find(string.lower(filename), "themes") and string.find(string.lower(filename), ".dat")) then
            local toAdd = filename:sub(8)
            table.insert(t, toAdd)
        end
    end)
    return t 
end

function SetPosition(p, x, y)
    if (x <= -1) then 
        p:SetPosY(y)
        return;
    elseif (y <= -1) then 
        p:SetPosX(x)
        return;
    else
        p:SetPosX(x)
        p:SetPosY(y)
        return;
    end
end
function SetSize(p, w, h)
    if (w <= -1) then 
        p:SetHeight(h)
        return;
    elseif (h <= -1) then 
        p:SetWidth(w)
        return;
    else
        p:SetWidth(w)
        p:SetHeight(h)
        return;
    end
end

local managerTab = gui.Reference("Settings", "Theme")
local managerGroup = gui.Groupbox(managerTab, "Manage themes", 16, 16, 608, 496)
local managerList = gui.Listbox(managerGroup, "list", 432, unpack(listThemes()))
local managerText = gui.Text(managerGroup, "Name")
local managerName = gui.Editbox(managerGroup, "name", "")
local themeRefs = {
    "theme.header.bg",
    "theme.header.line",
    "theme.header.text",

    "theme.ui.bg1",
    "theme.ui.bg2",
    "theme.ui.border",

    "theme.nav.bg",
    "theme.nav.active",
    "theme.nav.shadow",
    "theme.nav.text",

    "theme.tablist.text",
    "theme.tablist.textactive",
    "theme.tablist.shadow",
    "theme.tablist.tabactivebg",
    "theme.tablist.tabdecorator",

    "theme.footer.bg",
    "theme.footer.text"
}

local managerCreate = gui.Button(managerGroup, "Create", function()
    for i, v in pairs(listThemes()) do 
        if (v == managerName:GetValue() .. ".dat") then return end
    end

    local contStr
    for i=1, #themeRefs do
        local r, g, b, a = gui.GetValue(themeRefs[i])
        if (contStr == nil) then 
            contStr = r..", "..g..", "..b..", "..a
        else
            contStr = contStr..";"..r..", "..g..", "..b..", "..a
        end
    end
    file.Write("themes/".. managerName:GetValue() .. ".dat", contStr)
end)
local managerRename = gui.Button(managerGroup, "Rename", function()
    for i, v in pairs(listThemes()) do 
        if (v == managerName:GetValue() .. ".dat") then return end
    end
    local rData = file.Read("themes/".. listThemes()[managerList:GetValue() + 1])
    file.Delete("themes/".. listThemes()[managerList:GetValue() + 1])
    file.Write("themes/".. managerName:GetValue() .. ".dat", rData)
end)

local managerLoad = gui.Button(managerGroup, "Load", function()
    local fileData = file.Read("themes/".. listThemes()[managerList:GetValue() + 1], "r")

    for str in string.gmatch(ffi.string(fileData), "([^\n]+)") do
        local pData = str:split(";")
        for i=1, #themeRefs do
            local r, g, b, a = gui.GetValue(themeRefs[i])
            if (pData[i] == nil) then
                pData[i] = r.. ", ".. g.. ", ".. b.. ", ".. a
            end
            
            gui.SetValue(themeRefs[i], pData[i]:split(", ")[1], pData[i]:split(", ")[2], pData[i]:split(", ")[3], pData[i]:split(", ")[4])
        end
    end
end)
local managerSave = gui.Button(managerGroup, "Save", function()
    local contStr
    for i=1, #themeRefs do
        local r, g, b, a = gui.GetValue(themeRefs[i])
        if (contStr == nil) then 
            contStr = r..", "..g..", "..b..", "..a
        else
            contStr = contStr..";"..r..", "..g..", "..b..", "..a
        end
    end
    file.Write("themes/".. listThemes()[managerList:GetValue() + 1], contStr)
end)

local managerReset = gui.Button(managerGroup, "Reset", function()
    local themeDefault = {{200, 40, 40, 255}, {220, 60, 40, 255}, {255, 255, 255, 255}, {20, 20, 20, 220}, {255, 255, 255, 100}, {255, 255, 255, 50}, {170, 30, 30, 255}, {220, 60, 40, 255}, {0, 0, 0, 127}, {255, 255, 255, 255}, {255, 255, 255, 255}, {220, 40, 20, 200}, {0, 0, 0, 127}, {50, 50, 50, 255}, {220, 40, 20, 255}, {200, 40, 40, 255}, {255, 255, 255, 255}}
    for i=1, #themeRefs do
        gui.SetValue(themeRefs[i], themeDefault[i][1], themeDefault[i][2], themeDefault[i][3], themeDefault[i][4])
    end
end)
local managerDelete = gui.Button(managerGroup, "Delete", function()
    file.Delete("themes/".. listThemes()[managerList:GetValue() + 1])
end)

SetPosition(managerText, 296, 0);SetPosition(managerName, 296, -1)
SetPosition(managerCreate, 296, -1);SetPosition(managerRename, 440, 65)
SetPosition(managerLoad, 296, 125);SetPosition(managerSave, 440, 125)
SetPosition(managerReset, 296, 185);SetPosition(managerDelete, 440, 185)

SetSize(managerName, 280, 20);SetSize(managerList, 280, -1)
SetSize(managerCreate, 136, 28);SetSize(managerRename, 136, 28)
SetSize(managerLoad, 136, 28);SetSize(managerSave, 136, 28)
SetSize(managerReset, 136, 28);SetSize(managerDelete, 136, 28)

function moveThemeOptions(unload)
    local whRef = gui.Reference("Settings", "Theme", "Window Header")
    local uiRef = gui.Reference("Settings", "Theme", "UI")
    local nvRef = gui.Reference("Settings", "Theme", "Navigation")
    local tlRef = gui.Reference("Settings", "Theme", "Tab List")
    local wfRef = gui.Reference("Settings", "Theme", "Window Footer")

    if (unload) then 
        SetPosition(whRef, -1, 16)
        SetPosition(uiRef, -1, 16)
        SetPosition(nvRef, -1, 182)
        SetPosition(tlRef, -1, 182)
        SetPosition(wfRef, -1, 382)
    else
        SetPosition(whRef, -1, 528)
        SetPosition(uiRef, -1, 528)
        SetPosition(nvRef, -1, 694)
        SetPosition(tlRef, -1, 694)
        SetPosition(wfRef, -1, 894)
    end
end

moveThemeOptions(false)
callbacks.Register("Unload", function() moveThemeOptions(true) end)
callbacks.Register("Draw", function() managerList:SetOptions(unpack(listThemes())) end)
