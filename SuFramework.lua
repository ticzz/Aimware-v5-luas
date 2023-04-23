--- Automatic updater
local Updater = {
    version = "4";
    link = "https://raw.githubusercontent.com/superyor/SuFramework/master/SuFramework.lua";
    versionLink = "https://raw.githubusercontent.com/superyor/SuFramework/master/version.txt";
}

function Updater:UpdateCheck()
    if Updater.version ~= http.Get(Updater.versionLink) then
        local script = file.Open("Modules\\Superyu\\SuFramework.lua", "w");
        newScript = http.Get(Updater.link)
        script:Write(newScript);
        script:Close()
        return false;
    else
        return true;
    end
end

--- Framework
local SuFramework = {
    reference = nil;
    tabName = "";
    mainGuiObjects = {};
    menuInitialized = false;
    varnamePrefix = "",
    categoryNames = {},
    featureNames = {},
    categoryCount = 0;
    featureCount = 0;
    currentColumn = 0;
    currentY = 0;
    categories = {};
    lastCategorySelection = 0;
}

--- Actually important functions
function SuFramework:NewMenu(varnamePrefix, reference, tabName)
    local o = {
        reference = nil;
        tabName = "";
        mainGuiObjects = {};
        menuInitialized = false;
        varnamePrefix = "",
        categoryNames = {},
        featureNames = {},
        categoryCount = 0;
        featureCount = 0;
        currentColumn = 0;
        currentY = 0;
        categories = {};
        lastCategorySelection = 0;
    };

    setmetatable(o, self)
    self.__index = self;

    o.varnamePrefix = varnamePrefix;
    o.reference = reference;
    o.tabName = tabName;

    return o;
end

function SuFramework:Initialize()
    self.mainGuiObjects.tab = gui.Tab(self.reference, self.varnamePrefix:lower() .. ".tab", self.tabName)
    self.mainGuiObjects.selectorGroup = gui.Groupbox(self.mainGuiObjects.tab, "Selector", 16, 16, 600, 64)
    self.mainGuiObjects.categorySelector = gui.Combobox(self.mainGuiObjects.selectorGroup, "selector.category", "Category", "")
    self.mainGuiObjects.featureSelector = gui.Combobox(self.mainGuiObjects.selectorGroup, "selector.feature", "Feature", "")
    self.mainGuiObjects.configureGroup = gui.Groupbox(self.mainGuiObjects.tab, "Configure", 16, 64+64, 600, 64)
    self.mainGuiObjects.categorySelector:SetWidth(300-16-4)
    self.mainGuiObjects.featureSelector:SetPosX(300-8)
    self.mainGuiObjects.featureSelector:SetPosY(0)
    self.mainGuiObjects.featureSelector:SetWidth(300-16-4)
    self.menuInitialized = true;

    return true;
end

function SuFramework:HandleUI()

    self.mainGuiObjects.featureSelector:SetOptions(unpack(self.featureNames[self.mainGuiObjects.categorySelector:GetValue() + 1]))

    if self.lastCategorySelection ~= self.mainGuiObjects.categorySelector:GetValue()+1 then
        local c = 0;
        for k, v in pairs(self.featureNames[self.mainGuiObjects.categorySelector:GetValue() + 1]) do
            c = c + 1;
        end
        if self.mainGuiObjects.featureSelector:GetValue()+1 > c then
            self.mainGuiObjects.featureSelector:SetValue(c+1);
        end

        self.lastCategorySelection = self.mainGuiObjects.categorySelector:GetValue()+1;
    end

    for catKey, categories in pairs(self.categories) do
        for featKey, features in pairs(categories) do
            for guiKey, guiObject in pairs(features) do
                if catKey == self.mainGuiObjects.categorySelector:GetValue() + 1 then
                    if featKey == self.mainGuiObjects.featureSelector:GetValue() + 1 then
                        guiObject:SetInvisible(false);
                    else
                        guiObject:SetInvisible(true);
                    end
                else
                    guiObject:SetInvisible(true);
                end
            end
        end
    end
end

function SuFramework:Shutdown()

    for catKey, categories in pairs(self.categories) do
        for featKey, features in pairs(categories) do
            for guiKey, guiObject in pairs(features) do
                guiObject:Remove();
            end
        end
    end

    self.mainGuiObjects.categorySelector:Remove()
    self.mainGuiObjects.featureSelector:Remove()
    self.mainGuiObjects.selectorGroup:Remove()
    self.mainGuiObjects.configureGroup:Remove()
    self.mainGuiObjects.tab:Remove();
    self = {};
end

--- All the adding stuff to the menu
function SuFramework:AddCategory(categoryName)

    if self.menuInitialized == false then
        return false;
    end

    table.insert(self.categoryNames, categoryName)
    self.mainGuiObjects.categorySelector:SetOptions(unpack(self.categoryNames))
    self.categoryCount = self.categoryCount + 1;
    self.featureCount = 0;
    self.categories[self.categoryCount] = {}
    return true;
end

function SuFramework:AddFeature(featureName)

    if self.menuInitialized == false then
        return false;
    end

    self.featureCount = self.featureCount + 1;

    local temp = self.featureNames[self.categoryCount];
    if temp == nil then
        self.featureNames[self.categoryCount] = {};
        table.insert(self.featureNames[self.categoryCount], featureName)
    else
        table.insert(self.featureNames[self.categoryCount], featureName)
    end

    self.categories[self.categoryCount][self.featureCount] = {};
    self.currentColumn = 1;
    self.currentY = 0;
    return true;
end

function SuFramework:NextColumn()

    if self.currentColumn + 1 < 3 then
        self.currentColumn = self.currentColumn + 1;
        self.currentY = 0;
        return true;
    else
        return false;
    end
end

function SuFramework:AddCheckbox(varname, name, defaultValue, description, customParent)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();

    if customParent then
        self.categories[self.categoryCount][self.featureCount][varname] =
        gui.Checkbox(customParent, awVarname, name, defaultValue);
    else
        self.categories[self.categoryCount][self.featureCount][varname] =
        gui.Checkbox(self.mainGuiObjects.configureGroup, awVarname, name, defaultValue);
    end

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);


    if not customParent then
        if description then
            self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
            self.currentY = self.currentY + 28*1.66;
        else
            self.currentY = self.currentY + 28;
        end
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddSlider(varname, name, defaultValue, min, max, stepSize, description)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();
    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Slider(self.mainGuiObjects.configureGroup, awVarname, name, defaultValue, min, max, stepSize)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 48*1.4;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddCombobox(varname, name, optionsTable, description)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();
    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Combobox(self.mainGuiObjects.configureGroup, awVarname, name, unpack(optionsTable))

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 48*1.4;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddColorPicker(varname, name, colorTable, customParent)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();

    if customParent then
        self.categories[self.categoryCount][self.featureCount][varname] =
        gui.ColorPicker(customParent, awVarname, name, unpack(colorTable))
    else
        self.categories[self.categoryCount][self.featureCount][varname] =
        gui.ColorPicker(self.mainGuiObjects.configureGroup, awVarname, name, unpack(colorTable))
    end

    if not customParent then
        if self.currentColumn == 2 then
            self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
        end
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

        self.currentY = self.currentY + 24;
        self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)
    end

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddText(varname, text)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();
    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Text(self.mainGuiObjects.configureGroup, text)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    self.currentY = self.currentY + 24;
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddEditbox(varname, name, description)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();
    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Editbox(self.mainGuiObjects.configureGroup, awVarname, name)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 48*1.5;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddMultibox(varname, name, description)

    if self.menuInitialized == false then
        return false;
    end

    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Multibox(self.mainGuiObjects.configureGroup, name)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 48*1.5;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddKeybox(varname, name, key, description)

    if self.menuInitialized == false then
        return false;
    end

    local catName = self.categoryNames[self.categoryCount]
    catName = catName:gsub(" ", "");
    catName = catName:lower();

    local featName = self.featureNames[self.categoryCount][self.featureCount];
    featName = featName:gsub(" ", "");
    featName = featName:lower();

    local awVarname = catName .. "." .. featName .. "." .. varname:lower();

    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Keybox(self.mainGuiObjects.configureGroup, awVarname, name, key)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 48*1.5;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddButton(varname, name, callback)

    if self.menuInitialized == false then
        return false;
    end

    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Button(self.mainGuiObjects.configureGroup, name, callback)

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    self.currentY = self.currentY + 32+16;
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:AddListbox(varname, height, optionsTable)

    if self.menuInitialized == false then
        return false;
    end

    self.categories[self.categoryCount][self.featureCount][varname] =
    gui.Listbox(self.mainGuiObjects.configureGroup, varname, height, unpack(optionsTable))

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    self.currentY = self.currentY + height+16;
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

if Updater:UpdateCheck() then
    return SuFramework;
else
    return "Updated";
end