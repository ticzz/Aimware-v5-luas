--- Some References I will need.
local ref = gui.Reference("VISUALS", "Overlay")
local ref1 = gui.Reference("VISUALS", "Overlay", "Friendly")
local ref2 = gui.Reference("VISUALS", "Overlay", "Enemy")
local ref3 = gui.Reference("VISUALS", "Overlay", "Weapon")
local menuref = gui.Reference("MENU")

--- API Localization for faster acess
local getLocal = entities.GetLocalPlayer;
local getRealTime = globals.RealTime;

local dSetColor = draw.Color;
local dRect = draw.OutlinedRect;
local dFilledRect = draw.FilledRect;
local dText = draw.Text;
local dTextShadow = draw.TextShadow;
local dGetTextSize = draw.GetTextSize;
local dSetFont = draw.SetFont;
local dCreateFont = draw.CreateFont;

local setVal = gui.SetValue;
local getVal = gui.GetValue;

--- Rect metaclass
local Rect = {
    p1 = {x=0, y=0},
    p2 = {x=0, y=0},
    width = 0,
    height = 0,
    diagonalSqr = 0,
}

--- Create a new Rect
function Rect:New(x1, y1, x2, y2)
    local newRect = {};
    setmetatable(newRect, self)
    self.__index = self;
    newRect.p1 = {x=x1, y=y1};
    newRect.p2 = {x=x2, y=y2};
    newRect.width = x2-x1;
    newRect.height = y1-y2;
    newRect.diagonalSqr = (newRect.width^2) + (newRect.height^2)
    return newRect;
end

--- Color metaclass
local Color = {r=0, g=0, b=0, a=0};

--- Create a new color
function Color:New(r, g, b, a)
    local newColor = {};
    setmetatable(newColor, self)
    self.__index = self;
    newColor.r = r;
    newColor.g = g;
    newColor.b = b;
    newColor.a = a;
    return newColor;
end

--- Get color inbetween two colors based on percentage from 0-1
function Color:Inbetween(color, percent)

    if percent > 1 then
        percent = 1;
    elseif percent < 0 then
        percent = 0;
    end

    local newColor = Color:New(0, 0, 0, 0);
    newColor.r = self.r-(self.r-color.r)*percent
    newColor.g = self.g-(self.g-color.g)*percent
    newColor.b = self.b-(self.b-color.b)*percent
    newColor.a = self.a-(self.a-color.a)*percent
    return newColor;
end

--- BetterESP object
local BetterESP = {

    metadata = {
        scriptName = GetScriptName();
        version = "2.0 Beta 5";
        fileLink = "https://raw.githubusercontent.com/superyor/BetterESP/master/BetterESP.lua";
        versionLink = "https://raw.githubusercontent.com/superyor/BetterESP/master/version.txt";
        changelogLink = "https://raw.githubusercontent.com/superyor/BetterESP/master/changelog.txt";
    };

    gui = {
        options = {
            [1] = {}; --- Friendly
            [2] = {}; --- Enemy
        }
    };

    vars = {
        pLocal = nil;

        updater = {
            lastVersionCheck = 0;
            updated = false;
            isOutdated = false;
        };
    };

    flagcolors = {
        Color:New(51, 153, 255, 255),
        Color:New(255, 25, 25, 255),
    };

    maxAmmos = {
        7, 30, 20, 20, 0, 0, 30, 30, 10, 25, 20, 0, 35, 100, 0, 30, 30, 18, 50, 0, 0, 0, 30, 25, 7, 64, 5, 150, 7, 18, 0, 13, 30, 30, 8, 13, 0, 20, 30, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 12, 0, 12, 8
    };

    font = dCreateFont("Verdana", 12, 500);
};
BetterESP.__index = BetterESP;

--- BetterESP Functions
function BetterESP:createMenu()

    --- Autoupdater GUI Objects
    self.gui.updatergroup = gui.Groupbox(ref, "BetterESP | Updater for v" .. self.metadata.version, 16, 16, 400, 600)
    self.gui.updaterText = gui.Text(self.gui.updatergroup, "You shouldn't be able to see this...")
    self.gui.updaterButton = gui.Button(self.gui.updatergroup, "Update", function()
        if self.vars.updater.isOutdated then
            local nScript = http.Get(self.metadata.fileLink);
            local oScript = file.Open(self.metadata.scriptName, "w");
            oScript:Write(nScript);
            oScript:Close();
            self.vars.updater.updated = true;
            self.gui.updaterText:SetText("Please reload the lua.");
        end
    end)
    self.gui.updaterButton:SetWidth(400-32-8);
    self.gui.updaterButton:SetInvisible(true);

    --- Main GUI Objects
    self.gui.group = gui.Groupbox(ref, "BetterESP | v" .. self.metadata.version, 16, 128+13+16, 400, 600)
    self.gui.targetSelector = gui.Combobox(self.gui.group, "targetselector", "Target", "Enemy", "Friendly")

    self.gui.drawOptions = gui.Multibox(self.gui.group, "Draw Options")
    self.gui.outlined = gui.Checkbox(self.gui.drawOptions, "drawoptions.outlined", "Draw Outlined", false)
    self.gui.lowercase = gui.Checkbox(self.gui.drawOptions, "drawoptions.lowercase", "Force Lowercase", false)
    self.gui.barlines = gui.Checkbox(self.gui.drawOptions, p .. "drawoptions.barlines", "Bar lines", false)

    for i=1, 2 do
        p = i==1 and "betteresp.friendly" or "betteresp.enemy"
        --- Name
        self.gui.options[i].name = gui.Checkbox(self.gui.group, p .. ".name", "Show Name", false)
        self.gui.options[i].namecolor = gui.ColorPicker(self.gui.options[i].name, p .. ".name.color", "Color", 255, 255, 255, 255)

        --- Box
        self.gui.options[i].box = gui.Checkbox(self.gui.group, p .. ".box", "Show Box", false)
        self.gui.options[i].boxcolor = gui.ColorPicker(self.gui.options[i].box, p .. ".box.color", "Color", 255, 255, 255, 255)

        --- Health
        self.gui.options[i].health = gui.Combobox(self.gui.group, p .. ".health", "Show Health", "Off", "Number", "Bar")
        self.gui.options[i].healthcolor1 = gui.ColorPicker(self.gui.options[i].health, p .. ".health.color1", "Color", 25, 255, 25, 255)
        self.gui.options[i].healthcolor2 = gui.ColorPicker(self.gui.options[i].health, p .. ".health.color2", "Color2", 255, 25, 25, 255)
        self.gui.options[i].healthcolor1:SetPosX(400-64-16-8);

        --- Weapon
        self.gui.options[i].weapon = gui.Checkbox(self.gui.group, p .. ".weapon", "Show Weapon", false)
        self.gui.options[i].weaponcolor = gui.ColorPicker(self.gui.options[i].weapon, p .. ".weapon.color", "Color", 255, 255, 255, 255)

        --- Ammo
        self.gui.options[i].ammo = gui.Combobox(self.gui.group, p .. ".ammo", "Show Ammo", "Off", "Number", "Bar")
        self.gui.options[i].ammocolor1 = gui.ColorPicker(self.gui.options[i].ammo, p .. ".ammo.color1", "Color", 50, 125, 255, 255)
        self.gui.options[i].ammocolor2 = gui.ColorPicker(self.gui.options[i].ammo, p .. ".ammo.color2", "Color", 255, 25, 25, 255)
        self.gui.options[i].ammocolor1:SetPosX(400-64-16-8);

        --- Flags
        self.gui.options[i].flagsMulti = gui.Multibox(self.gui.group, "Flags");
        self.gui.options[i].flagArmor = gui.Checkbox(self.gui.options[i].flagsMulti , p .. ".flagarmor", "Show Armor", false)
        self.gui.options[i].flagScoped = gui.Checkbox(self.gui.options[i].flagsMulti , p .. ".flagscoped", "Show Scoped", false)
    end

    self.gui.changelogGroup = gui.Groupbox(ref, "BetterESP | Changelog for v" .. self.metadata.version, 16, 512+64+32, 400, 600)
    self.gui.changelogText = gui.Text(self.gui.changelogGroup, "You shouldn't be able to see this...")
end

function BetterESP:checkUpdates()

    if self.vars.updater.updated == false then

        local time = getRealTime()

        if self.vars.updater.lastVersionCheck < time-300 then

            local onlineVersion = http.Get(self.metadata.versionLink);

            if self.metadata.version ~= onlineVersion then
                self.gui.updaterText:SetText("A new update is available. Newest version: " .. onlineVersion);
                self.vars.updater.isOutdated = true;
                self.gui.updaterButton:SetInvisible(false);
            else
                self.gui.updaterText:SetText("Your client is up to date.");
            end

            local changelogContent = http.Get(self.metadata.changelogLink)
            self.gui.changelogText:SetText(changelogContent);

            self.vars.updater.lastVersionCheck = time;
        end

    end
end

function BetterESP:handleUI()

    local target = self.gui.targetSelector:GetValue()+1

    for i=1, 2 do
        self.gui.options[i].name:SetInvisible(i==target);
        self.gui.options[i].box:SetInvisible(i==target);
        self.gui.options[i].weapon:SetInvisible(i==target);
        self.gui.options[i].health:SetInvisible(i==target);
        self.gui.options[i].ammo:SetInvisible(i==target);
        self.gui.options[i].flagsMulti:SetInvisible(i==target);
    end
end

function BetterESP:drawBox(rect, color)
    if self.gui.outlined:GetValue() then
        dSetColor(0, 0, 0, 255);
        dRect(rect.p1.x+1, rect.p1.y+1, rect.p2.x-1, rect.p2.y-1)
        dRect(rect.p1.x-1, rect.p1.y-1, rect.p2.x+1, rect.p2.y+1)
        dSetColor(color.r, color.g, color.b, color.a);
        dRect(rect.p1.x, rect.p1.y, rect.p2.x, rect.p2.y)
    else
        dSetColor(color.r, color.g, color.b, color.a);
        dRect(rect.p1.x, rect.p1.y, rect.p2.x, rect.p2.y)
    end
end

function BetterESP:drawName(rect, color, name)

    if self.gui.lowercase:GetValue() then
        name = name:lower()
    end

    local w, h = dGetTextSize(name);
    dSetColor(color.r, color.g, color.b, color.a);

    if self.gui.outlined:GetValue() then
        dTextShadow((rect.p1.x+(rect.width/2))-(w/2), (rect.p1.y-(h/2)-9), name)
    else
        dText((rect.p1.x+(rect.width/2))-(w/2), (rect.p1.y-(h/2)-9), name)
    end
end

function BetterESP:drawWeaponName(rect, color, weapon, adjustBar)

    local weaponName = "";

    if weapon ~= nil then
        weaponName = weapon:GetClass()

        if weaponName == "CDeagle" and weapon:GetWeaponID() == 64 then
            weaponName = "R8"
        else
            weaponName = weaponName:gsub("CWeapon", "")
            weaponName = weaponName:gsub("CKnife", "Knife")
        end

        if (weaponName:sub(1, 1) == "C") then
            weaponName = weaponName:sub(2)
        end
    else
        weaponName = "Unknown Weapon"
    end

    if self.gui.lowercase:GetValue() then
        weaponName = weaponName:lower()
    end

    local w, h = dGetTextSize(weaponName);
    dSetColor(color.r, color.g, color.b, color.a);

    local o = 0;

    if adjustBar then
        o = 6;
    end

    if self.gui.outlined:GetValue() then
        dTextShadow((rect.p1.x+(rect.width/2))-(w/2), (rect.p2.y+(h/2))-2+o, weaponName)
    else
        dText((rect.p1.x+(rect.width/2))-(w/2), (rect.p2.y+(h/2))-2+o, weaponName)
    end
end

function BetterESP:drawHealth(rect, color, percentage, type)

    local offset = 0;

    if self.gui.outlined:GetValue() then
        offset = 1;
    end

    if type == 2 then
        dSetColor(0, 0, 0, 255)
        dRect(rect.p1.x-6-offset, rect.p1.y-offset, rect.p1.x-2-offset, rect.p2.y+offset)

        dSetColor(25, 25, 25, 255/1.33)
        dFilledRect(rect.p1.x-5-offset, (rect.p1.y-offset+1), rect.p1.x-3-offset, rect.p2.y+offset-1)

        local value = (rect.p2.y+offset-1)-(rect.p1.y-offset+1) - ((((rect.p2.y+offset-1)-(rect.p1.y-offset+1))*percentage) / 100);

        dSetColor(color.r, color.g, color.b, color.a)
        dFilledRect(rect.p1.x-5-offset, (rect.p1.y-offset+1)+value, rect.p1.x-3-offset, rect.p2.y+offset-1)

        dSetColor(255, 255, 255, 255)

        if percentage ~= 100 then
            dSetColor(255, 255, 255, 255)
            local hpString = tostring(percentage);
            local w, h = dGetTextSize(hpString);

            if self.gui.outlined:GetValue() then
                dTextShadow(rect.p1.x-8-w-offset, (rect.p1.y-offset+1)+value-(h/2), hpString)
            else
                dText(rect.p1.x-8-w-offset, (rect.p1.y-offset+1)+value-(h/2), hpString)
            end
        end

        if self.gui.barlines:GetValue() then
            dSetColor(0, 0, 0, 255)
            for i=0.1, 0.9, 0.1 do
                local h = (rect.p2.y+offset)-(rect.p1.y-offset) - (((rect.p2.y+offset)-(rect.p1.y-offset))*i);
                dFilledRect(rect.p1.x-6-offset, (rect.p1.y-offset) + h, rect.p1.x-2-offset, (rect.p1.y-offset) + h+1)
            end
        end
    else
        dSetColor(255, 255, 255, 255)
        local hpString = tostring(percentage);
        local w, h = dGetTextSize(hpString);
        if self.gui.outlined:GetValue() then
            dTextShadow(rect.p1.x-2-w-offset, (rect.p1.y-offset)+(((rect.p2.y+offset)-(rect.p1.y-offset))/2)-(w/2.5), hpString)
        else
            dText(rect.p1.x-2-w-offset, (rect.p1.y-offset)+(((rect.p2.y+offset)-(rect.p1.y-offset))/2)-(w/2.5), hpString)
        end
    end
end

function BetterESP:drawAmmo(rect, color, percentage, val, maxval, type, callId)

    local offset = 0;

    if self.gui.outlined:GetValue() then
        offset = 1;
    end

    if type == 2 then
        dSetColor(0, 0, 0, 255)
        dRect(rect.p2.x-rect.width-offset, rect.p2.y+5+offset, rect.p2.x+offset, rect.p2.y+3+offset)

        dSetColor(25, 25, 25, 255/1.33)
        dFilledRect(rect.p2.x-rect.width-offset+1, rect.p2.y+5+offset, rect.p2.x+offset-1, rect.p2.y+3+offset)

        local wv = (rect.p2.x-rect.width-offset)-(rect.p2.x+offset)
        local value = wv - ((wv*percentage) / 100);

        dSetColor(color.r, color.g, color.b, color.a)
        dFilledRect(rect.p2.x-rect.width-offset+1, rect.p2.y+5+offset, rect.p2.x-offset+value-1, rect.p2.y+3+offset)

        dSetColor(255, 255, 255, 255)

        if percentage ~= 100 then
            dSetColor(255, 255, 255, 255)
            local ammoString = tostring(val);
            local w, h = dGetTextSize(ammoString);

            if self.gui.outlined:GetValue() then
                dTextShadow(rect.p2.x+(w)-2, (rect.p2.y), ammoString)
            else
                dText(rect.p2.x+(w)-2, (rect.p2.y), ammoString)
            end
        end

        if self.gui.barlines:GetValue() then
            dSetColor(0, 0, 0, 255)
            for i=0.1, 0.9, 0.1 do
                local h = (rect.p2.y+offset)-(rect.p1.y-offset) - (((rect.p2.y+offset)-(rect.p1.y-offset))*i);
                local lv = wv - (wv*i);
                dFilledRect(rect.p2.x-offset+lv-1, rect.p2.y+5+offset, rect.p2.x-offset+lv-1+1, rect.p2.y+3+offset)
            end
        end
    else
        dSetColor(255, 255, 255, 255)
        local ammoString = tostring("(" .. val .. " / " .. maxval .. ")");
        local w, h = dGetTextSize(ammoString);

        local m = 0
        if self.gui.options[callId].weapon:GetValue() then
            m = 1;
        end

        if self.gui.outlined:GetValue() then
            dTextShadow((rect.p1.x+(rect.width/2))-(w/2), (rect.p2.y+(h/2))+offset-2+(m*(h+3)), ammoString)
        else
            dText((rect.p1.x+(rect.width/2))-(w/2), (rect.p2.y+(h/2))+offset-2+(m*(h+3)), ammoString)
        end
    end
end

function BetterESP:drawFlags(rect, pEntity, callId)

    local flags = {};

    if self.gui.options[callId].flagArmor:GetValue() then
        if pEntity:GetPropInt("m_ArmorValue") ~= 0 then
            flags[#flags+1] = "K"
        end

        if pEntity:GetPropInt("m_bHasHelmet") == 1 then
            flags[#flags] = "H" .. flags[#flags]
        end
    end

    if self.gui.options[callId].flagScoped:GetValue() then
        if pEntity:GetPropBool("m_bIsScoped") then
            flags[#flags+1] = "SC"
        end
    end

    local sampleTextWidth, sampleTextHeight = dGetTextSize("Test");
    local posX = rect.p1.x+rect.width+2;
    local posY = rect.p1.y-sampleTextHeight-3;

    if self.gui.outlined:GetValue() then
        posY = posY-1;
    end

    for k=1, #flags do
        local flagString = flags[k];

        if self.gui.lowercase:GetValue() then
            flagString = flagString:lower()
        end

        dSetColor(self.flagcolors[k].r, self.flagcolors[k].g, self.flagcolors[k].b, self.flagcolors[k].a)

        if self.gui.outlined:GetValue() then
            dTextShadow(posX, posY+(k*(sampleTextHeight+2)), flagString)
        else
            dText(posX, posY+(k*(sampleTextHeight+2)), flagString)
        end
    end
end

function BetterESP:doESP(pEntity, rect, index)

    if self.gui.options[index].name:GetValue() then
        self:drawName(rect, Color:New(self.gui.options[index].namecolor:GetValue()), pEntity:GetName())
    end

    if self.gui.options[index].weapon:GetValue() then
        if self.gui.options[index].ammo:GetValue() == 2 then
            self:drawWeaponName(rect, Color:New(self.gui.options[index].weaponcolor:GetValue()), pEntity:GetPropEntity("m_hActiveWeapon"), true)
        else
            self:drawWeaponName(rect, Color:New(self.gui.options[index].weaponcolor:GetValue()), pEntity:GetPropEntity("m_hActiveWeapon"), false)
        end
    end

    if self.gui.options[index].ammo:GetValue() > 0 then

        local weapon = pEntity:GetPropEntity("m_hActiveWeapon");
        local ammo = weapon:GetPropInt("m_iClip1")

        if ammo >= 0 then
            local clipSize = self.maxAmmos[weapon:GetWeaponID()]

            if clipSize then
                if clipSize == 0 then
                    clipSize = 1;
                end

                local percent = (ammo/clipSize) * 100;

                if self.gui.options[index].ammo:GetValue() == 1 then
                    local col = Color:New(self.gui.options[index].ammocolor1:GetValue());
                    self:drawAmmo(rect, col, percent, ammo, clipSize, 1, index);
                else
                    local c1 = Color:New(self.gui.options[index].ammocolor2:GetValue());
                    local c2 = {}
                    c2.r, c2.g, c2.b, c2.a = self.gui.options[index].ammocolor1:GetValue()
                    local col = c1:Inbetween(Color:New(c2.r, c2.g, c2.b, c2.a), percent/100);

                    self:drawAmmo(rect, col, percent, ammo, clipSize, 2, index)
                end
            end
        end
    end

    if self.gui.options[index].health:GetValue() > 0 then
        local hp = pEntity:GetHealth()

        if self.gui.options[index].health:GetValue() == 1 then
            local col = Color:New(self.gui.options[index].healthcolor1:GetValue());
            self:drawHealth(rect, col, hp, 1);
        else
            local c1 = Color:New(self.gui.options[index].healthcolor2:GetValue());
            local c2 = {}
            c2.r, c2.g, c2.b, c2.a = self.gui.options[index].healthcolor1:GetValue()
            local col = c1:Inbetween(Color:New(c2.r, c2.g, c2.b, c2.a), hp/100);
            self:drawHealth(rect, col, hp, 2);
        end
    end

    if self.gui.options[index].flagArmor:GetValue() or self.gui.options[index].flagScoped:GetValue() then
        self:drawFlags(rect, pEntity, index)
    end

    if self.gui.options[index].box:GetValue() then
        self:drawBox(rect, Color:New(self.gui.options[index].boxcolor:GetValue()))
    end

end

function BetterESP:doESPPlayers(pEntity, rect)

    if self.vars.pLocal ~= nil then

        if pEntity:IsPlayer() and pEntity:IsAlive() then

            if pEntity:GetTeamNumber() ~= self.vars.pLocal:GetTeamNumber() then
                dSetFont(self.font);
                self:doESP(pEntity, rect, 2)

            elseif pEntity:GetTeamNumber() == self.vars.pLocal:GetTeamNumber() and pEntity:GetIndex() ~= self.vars.pLocal:GetIndex() then
                dSetFont(self.font);
                self:doESP(pEntity, rect, 1);
            end
        end
    end
end

--- Callback Functions
function BetterESP:hkLoad() -- ok not really callback function but idc
    ref1:SetInvisible(true)
    ref2:SetInvisible(true)

    for i=1, 2 do
        p = i==1 and "friendly" or "enemy"
        setVal("esp.overlay." .. p .. ".box", 0)
        setVal("esp.overlay." .. p .. ".precision", 0)
        setVal("esp.overlay." .. p .. ".name", 0)
        setVal("esp.overlay." .. p .. ".skeleton", 0)
        setVal("esp.overlay." .. p .. ".health.healthbar", 0)
        setVal("esp.overlay." .. p .. ".health.healthnum", 0)
        setVal("esp.overlay." .. p .. ".armor", 0)
        setVal("esp.overlay." .. p .. ".weapon", 0)
        setVal("esp.overlay." .. p .. ".defusing", 0)
        setVal("esp.overlay." .. p .. ".planting", 0)
        setVal("esp.overlay." .. p .. ".scoped", 0)
        setVal("esp.overlay." .. p .. ".reloading", 0)
        setVal("esp.overlay." .. p .. ".flashed", 0)
        setVal("esp.overlay." .. p .. ".hasdefuser", 0)
        setVal("esp.overlay." .. p .. ".hasc4", 0)
        setVal("esp.overlay." .. p .. ".money", 0)
    end

    self:createMenu();
    self:checkUpdates()
end

function BetterESP:hkUnload()
    ref1:SetInvisible(false)
    ref2:SetInvisible(false)
end

function BetterESP:hkDraw()
    self.vars.pLocal = getLocal()

    if menuref:IsActive() then
        self:handleUI()
        self:checkUpdates()
    end
end

function BetterESP:hkDrawESP(espBuilder)
    local pEntity = espBuilder:GetEntity()

    if pEntity ~= nil then
        local x1, y1, x2, y2 = espBuilder:GetRect();
        local rect = Rect:New(x1, y1, x2, y2);
        BetterESP:doESPPlayers(pEntity, rect);
    end
end

--- Some function calls
BetterESP:hkLoad();

--- Callbacks
callbacks.Register("Draw", function() BetterESP:hkDraw() end)
callbacks.Register("DrawESP", function(espBuilder) BetterESP:hkDrawESP(espBuilder) end)
callbacks.Register("Unload", function() BetterESP:hkUnload() end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

