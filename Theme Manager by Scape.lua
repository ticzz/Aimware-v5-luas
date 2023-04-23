-- Presets and updater stuff
local VERSION_LINK = "https://raw.githubusercontent.com/lennonc1atwit/Luas/master/Theme%20Manager/version.txt"
local PRESET_LINK = "https://raw.githubusercontent.com/lennonc1atwit/Luas/master/Theme%20Manager/Presets.txt"
local SCRIPT_LINK = "https://raw.githubusercontent.com/lennonc1atwit/Luas/master/Theme%20Manager/Core.lua"
local SCRIPT_NAME = GetScriptName()
local SCRIPT_VERSION = "1.1.0"
local PRESETS = {}

local REAL_VERSION = string.gsub(http.Get(VERSION_LINK), "\n", "")

if SCRIPT_VERSION ~= REAL_VERSION then
    local new_script_raw = http.Get(SCRIPT_LINK)
    local old_script = file.Open(SCRIPT_NAME, "w");
    old_script:Write(new_script_raw);
    old_script:Close();
    print("Theme Manager Updated")
end

for str in string.gmatch(http.Get(PRESET_LINK), "[^\r\n]+") do
    local t = {}

    for wrd in string.gmatch(str, "([^,]+)") do
        wrd = string.gsub(wrd, "\"", "")
        table.insert(t, wrd)
    end

    table.insert(PRESETS, t)
end

-- File management stuff
local FOLDER_NAME = "Saved Themes/" -- You can change this folder name to your liking
local FILE_PATTERN = FOLDER_NAME..".+%.txt" -- NEVER CHANGE THIS you could accidentally delete configs or scripts
local THEME_VARNAMES = {"theme.footer.bg","theme.footer.text","theme.header.bg","theme.header.line","theme.header.text","theme.nav.active","theme.nav.bg","theme.nav.shadow","theme.nav.text","theme.tablist.shadow","theme.tablist.tabactivebg","theme.tablist.tabdecorator","theme.tablist.text","theme.tablist.textactive","theme.ui.bg1","theme.ui.bg2","theme.ui.border"}

local tab = gui.Tab(gui.Reference("Settings"), "savedthemes", "Saved Themes")
local SavedGroupbox = gui.Groupbox(tab, "Manage Saved Themes", 16, 16, 608, 400 )

gui.Text(SavedGroupbox, "Custom Themes")
local SavedThemes = gui.Listbox(SavedGroupbox, "", 178)
SavedThemes:SetWidth(280)

gui.Text(SavedGroupbox, "Presets")
local PresetThemes = gui.Listbox(SavedGroupbox, "", 178)
PresetThemes:SetWidth(280)

local SavedThemeName = gui.Editbox(SavedGroupbox, "", "Name")
SavedThemeName:SetDescription("Create or rename theme")
SavedThemeName:SetWidth(280)
SavedThemeName:SetPosX(296)
SavedThemeName:SetPosY(0)
SavedThemes:SetWidth(280)

local ThemeImport = gui.Editbox(SavedGroupbox, "", "Import Code")
ThemeImport:SetDescription("Paste theme codes here to import.")
ThemeImport:SetWidth(280)
ThemeImport:SetPosX(296)
ThemeImport:SetPosY(304)

-- Important functions
-- Ripped from stackoverflow https://stackoverflow.com/questions/34618946/lua-base64-encode
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

local function apply(theme)
    for str in string.gmatch(theme, "[^\r\n]+") do 
        local set = {}

        for wrd in string.gmatch(str, "%S+") do 
            set[#set + 1] = wrd
        end
        
        if #set == 5 then
            gui.SetValue(set[1], set[2], set[3], set[4], set[5])
        end
    end
end

local function getTheme()
    local data = ""
    -- Creates a string out of current theme settings
    for i, varname in ipairs(THEME_VARNAMES) do 
        local r, g, b, a = gui.GetValue(varname)
        data = data..string.format( "%s %s %s %s %s\n", varname, r, g, b, a)
    end

    return data
end


local function refresh() 
    local t = {}
    -- Gets all text files in the theme folder
    file.Enumerate(function(filename)
        if string.match(filename, FILE_PATTERN) then
            filename = filename:gsub(FOLDER_NAME, "")
            table.insert(t, filename)
        end
    end)

    SavedThemes:SetOptions(unpack(t))
end

-- Gui stuff
local CreateButton = gui.Button(SavedGroupbox, "Create", function() 
    -- Create new file with name
    local file_name = string.format( "%s%s.txt", FOLDER_NAME, SavedThemeName:GetValue())
    local f = file.Open(file_name, "w")

    -- Save current theme in a string
    local data = getTheme()

    -- Write string and refresh
    f:Write(data)
    f:Close()

    refresh()
end)
CreateButton:SetPosX(296)
CreateButton:SetPosY(64)
CreateButton:SetWidth(136)
CreateButton:SetHeight(28)

local RenameButton = gui.Button(SavedGroupbox, "Rename", function() 
    local index = 0
    file.Enumerate(function(filename)
        if string.match(filename, FILE_PATTERN) then
            if index == SavedThemes:GetValue() then
                -- Sanitize filenames for renaming procedure
                if not (SavedThemeName:GetValue():match("%W")) then
                    -- Save and delete old file
                    local f = file.Open(filename, "r")
                    local backup = f:Read()
                    f:Close()
                    file.Delete(filename)
                    -- Create new file with new name same data
                    local r = file.Open(string.format( "%s%s.txt",FOLDER_NAME, SavedThemeName:GetValue()), "w")
                    r:Write(backup)
                    r:Close()

                    refresh()
                else
                    SavedThemeName:SetValue("Invalid filename, Alphanum chars only!")
                end
                
                return
            end
        
        index = index + 1
        end
    end)
end)
RenameButton:SetPosX(440)
RenameButton:SetPosY(64)
RenameButton:SetWidth(136)
RenameButton:SetHeight(28)

local RefreshButton = gui.Button(SavedGroupbox, "Refresh", refresh)
RefreshButton:SetPosX(296)
RefreshButton:SetPosY(404)
RefreshButton:SetWidth(136)
RefreshButton:SetHeight(28)

local SaveButton = gui.Button(SavedGroupbox, "Save", function()
    local index = 0
    file.Enumerate(function(filename)
        if string.match(filename, FILE_PATTERN) then
            if index == SavedThemes:GetValue() then
                local f = file.Open(filename, "w")

                f:Write(getTheme())
                f:Close()
            end
        
        index = index + 1
        end
    end)
end)
SaveButton:SetPosX(440)
SaveButton:SetPosY(124)
SaveButton:SetWidth(136)
SaveButton:SetHeight(28)

local LoadButton = gui.Button(SavedGroupbox, "Load", function() 
    local index = 0
    local data

    -- Find selected file and save its data
    file.Enumerate(function(filename)
        if string.match(filename, FILE_PATTERN) then
            if index == SavedThemes:GetValue() then
                f = file.Open(filename, "r")
                data = f:Read()
                f:Close()
            end

            index = index + 1
        end
    end)

    -- Load the theme if there is data
    if data then 
        apply(data)
    end
end)
LoadButton:SetPosX(296)
LoadButton:SetPosY(124)
LoadButton:SetWidth(136)
LoadButton:SetHeight(28)

local DeleteButton = gui.Button(SavedGroupbox, "Delete", function()
    local index = 0
    file.Enumerate(function(filename)
        if string.match(filename, FILE_PATTERN) then
            if index == SavedThemes:GetValue() then
                file.Delete(filename)
            end

            index = index + 1
        end
    end)

    refresh()
end)
DeleteButton:SetPosX(440)
DeleteButton:SetPosY(184)
DeleteButton:SetWidth(136)
DeleteButton:SetHeight(28)

local ImportButton = gui.Button(SavedGroupbox, "Import From Code", function()
    apply(dec(ThemeImport:GetValue()))
    ThemeImport:SetValue("")
end)
ImportButton:SetPosX(440)
ImportButton:SetPosY(244)
ImportButton:SetWidth(136)
ImportButton:SetHeight(28)

local ExportButton = gui.Button(SavedGroupbox, "Export To Console", function() 
    print(enc(getTheme()))
end)
ExportButton:SetPosX(296)
ExportButton:SetPosY(244)
ExportButton:SetWidth(136)
ExportButton:SetHeight(28)

local LoadPreset = gui.Button(SavedGroupbox, "Load Preset", function()
    apply(dec(PRESETS[PresetThemes:GetValue()+1][2]))
end)
LoadPreset:SetPosX(296)
LoadPreset:SetPosY(184)
LoadPreset:SetWidth(136)
LoadPreset:SetHeight(28)

local SafeMode = gui.Checkbox(SavedGroupbox, "safemode", "Safe Mode", true)
SafeMode:SetDescription("Disable delete button.")
SafeMode:SetPosX(460)
SafeMode:SetPosY(394)
-- Finishing touches

local names = {}
for i, t in ipairs(PRESETS) do 
    table.insert(names, t[1])
end

PresetThemes:SetOptions(unpack(names))
refresh()

-- Just safe mode lol
callbacks.Register("Draw", function() DeleteButton:SetDisabled(SafeMode:GetValue()) end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

