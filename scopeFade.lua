local itemsToOverride = {
    {item = "esp.chams.local.visible",  mode = 2, alpha = 119},
    {item = "esp.chams.ghost.visible", mode = 2, alpha = 119},
}
local cache = {
    cache = {},
    create = function(self)
        for k,v in pairs(itemsToOverride) do
            itm = v.item
            table.insert(self.cache, {
                menu = itm,
                mode = gui.GetValue(itm), 
                color = {gui.GetValue(itm .. ".clr")}
            })
        end
    end,
    destroy = function(self)
        self.cache = {}
    end,
    revert = function(self)
        for k,v in pairs(self.cache) do
            gui.SetValue(v.menu, v.mode)
            gui.SetValue(v.menu .. ".clr", unpack(v.color))
        end
        self:destroy()
    end
}
local weaponsWithScope = {
    ["weapon_awp"] = true,
    ["weapon_g3sg1"] = true,
    ["weapon_scar20"] = true,
    ["weapon_ssg08"] = true,
}

local function canScope(weapon)
    return weaponsWithScope[tostring(weapon)] or false
end

local overriden = false
local manaullyChanging = false

local function override()
    cache:create()

    for k,v in pairs(itemsToOverride) do
        local color = {gui.GetValue(v.item .. ".clr")}
        color[4] = v.alpha
        gui.SetValue(v.item, v.mode)
        gui.SetValue(v.item .. ".clr", unpack(color))
    end
    
    overriden = true
    manaullyChanging = true
end

local function undo()
    cache:revert()
    overriden = false
    manaullyChanging = false
end

local function scopeFade(e)
    local eventName = e:GetName()
    if eventName ~= "weapon_zoom" and eventName ~= "item_equip" then return end
    local lp = entities.GetLocalPlayer()
    local player = entities.GetByUserID(e:GetInt("userid"))
    if lp:GetIndex() ~= player:GetIndex() then return end
    local weapon = lp:GetPropEntity("m_hActiveWeapon")

    if not canScope(weapon) then if overriden then undo() end return end
    local isScoped = weapon:GetPropBool("m_zoomLevel")
    if isScoped and not overriden then
        override()
    elseif not isScoped and overriden then
        undo()
    end
end
local function unload()
    cache:revert()
end

callbacks.Register("FireGameEvent", scopeFade)
callbacks.Register("Unload", unload)
client.AllowListener("weapon_zoom")
client.AllowListener("item_equip")






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

