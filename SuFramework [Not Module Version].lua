local SuFramework = {
    mainGuiObjects = {};
    menuCreated = false;
    varnamePrefix = "",
    categoryNames = {},
    featureNames = {},
    categoryCount = 0;
    featureCount = 0;
    currentColumn = 0;
    currentY = 0;
    categories = {};
}
SuFramework.__index = SuFramework;

function SuFramework:createMenu(varnamePrefix, reference, tabName)
    if not varnamePrefix then
        return false;
    end

    self.mainGuiObjects.tab = gui.Tab(reference, varnamePrefix .. ".tab", tabName)
    self.mainGuiObjects.selectorGroup = gui.Groupbox(self.mainGuiObjects.tab, "Selector", 16, 16, 600, 64)
    self.mainGuiObjects.categorySelector = gui.Combobox(self.mainGuiObjects.selectorGroup, "selector.category", "Category", "")
    self.mainGuiObjects.featureSelector = gui.Combobox(self.mainGuiObjects.selectorGroup, "selector.feature", "Feature", "")
    self.mainGuiObjects.configureGroup = gui.Groupbox(self.mainGuiObjects.tab, "Configure", 16, 64+64, 600, 64)
    self.mainGuiObjects.categorySelector:SetWidth(300-16-4)
    self.mainGuiObjects.featureSelector:SetPosX(300-8)
    self.mainGuiObjects.featureSelector:SetPosY(0)
    self.mainGuiObjects.featureSelector:SetWidth(300-16-4)
    self.varnamePrefix = varnamePrefix;
    self.menuCreated = true;

    return true;
end

function SuFramework:addCategory(categoryName)

    if self.menuCreated == false then
        return false;
    end

    table.insert(self.categoryNames, categoryName)
    self.mainGuiObjects.categorySelector:SetOptions(unpack(self.categoryNames))
    self.categoryCount = self.categoryCount + 1;
    self.featureCount = 0;
    self.categories[self.categoryCount] = {}
    return true;
end

function SuFramework:addFeature(featureName)

    if self.menuCreated == false then
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

function SuFramework:nextColumn()

    if self.currentColumn + 1 < 3 then
        self.currentColumn = self.currentColumn + 1;
        self.currentY = 0;
        return true;
    else
        return false;
    end
end

function SuFramework:addCheckbox(varname, name, defaultValue, description, customParent)

    if self.menuCreated == false then
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

    if description then
        self.categories[self.categoryCount][self.featureCount][varname]:SetDescription(description);
        self.currentY = self.currentY + 28*1.66;
    else
        self.currentY = self.currentY + 28;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:addSlider(varname, name, defaultValue, min, max, stepSize, description)

    if self.menuCreated == false then
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
        self.currentY = self.currentY + 48*1.2;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:addCombobox(varname, name, optionsTable, description)

    if self.menuCreated == false then
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
        self.currentY = self.currentY + 48*1.5;
    else
        self.currentY = self.currentY + 48;
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:addColorPicker(varname, name, colorTable)

    if self.menuCreated == false then
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
    gui.ColorPicker(self.mainGuiObjects.configureGroup, awVarname, name, unpack(colorTable))

    if self.currentColumn == 2 then
        self.categories[self.categoryCount][self.featureCount][varname]:SetPosX(300-8);
    end
    self.categories[self.categoryCount][self.featureCount][varname]:SetPosY(self.currentY);

    self.currentY = self.currentY + 24;
    self.categories[self.categoryCount][self.featureCount][varname]:SetWidth(300-16-4)

    return self.categories[self.categoryCount][self.featureCount][varname];
end

function SuFramework:addText(varname, text)

    if self.menuCreated == false then
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

function SuFramework:addEditbox(varname, name, description)

    if self.menuCreated == false then
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

function SuFramework:addMultibox(varname, name, description)

    if self.menuCreated == false then
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

function SuFramework:handleUI()

    self.mainGuiObjects.featureSelector:SetOptions(unpack(self.featureNames[self.mainGuiObjects.categorySelector:GetValue() + 1]))

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







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

