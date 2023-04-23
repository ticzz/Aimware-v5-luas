local items = {
    primarys = {"ak47", "aug", "awp", "famas", "g3sg1" ,"galilar" , "m4a1", "m4a1_silencer", "scar20", "sg556", "ssg08","scout", "sawedoff", "nova", "mag7", "negev", "m249", "bizon", "mac10", "mp5sd", "mp7", "mp9", "p90", "ump45"},
    secondarys = {"deagle", "elite", "fn57", "glock", "tec9", "hkp2000", "p250", "usps_silencer", "cz75a"},
    grenades = {"decoy", "flashbang", "hegrenade", "incgrenade", "molotov", "smokegrenade"},
    utility = {"defuser ","vest", "vesthelm", "taser"}
}

local function TransformGuiObject(obj, x, y, w, h, s)
    if x then obj:SetPosX(x) end
    if y then obj:SetPosY(y) end
    if w then obj:SetWidth(w) end
    if h then obj:SetHeight(h) end
    if s then obj:SetDescription(s) end
end

local buyBotTab = gui.Tab(gui.Reference("Misc"), buybot, "Buy Bot")
local buyBot = gui.Groupbox(buyBotTab, "Buy Bot", 16, 16, 608, 0)

local defaultPrimary = gui.Combobox(buyBot, "buybot.primary", "Primary", "none", unpack(items.primarys))

local padding = 24
local width = 576
local indent = 60

local defaultSecondary = gui.Combobox(buyBot, "buybot.secondary.default", "Secondary", "none", unpack(items.secondarys))
local altSecondary = gui.Combobox(buyBot, "buybot.secondary.alt", "", "none", unpack(items.secondarys))

local parent = gui.Multibox(buyBot, "Utility")
local altParent = gui.Multibox(buyBot, "")

local ignoreSecondary = gui.Checkbox(buyBot, "buybot.secondary.ignore", "Ignore Secondary", true)
local ignorePrimary = gui.Checkbox(buyBot, "buybot.primary.ignore", "Ignore Primary", true)

local defaultUtility = {}
local altUtility = {}

for k, v in pairs(items.grenades) do
    defaultUtility[v] =  gui.Checkbox(parent, "buybot.grenade.default"..v, v, false)
    altUtility[v] =  gui.Checkbox(altParent, "buybot.grenade.alt"..v, v, false)
end

for k, v in pairs(items.utility) do
    defaultUtility[v] =  gui.Checkbox(parent, "buybot.utility.default"..v, v, false)
    altUtility[v] =  gui.Checkbox(altParent, "buybot.utility.alt"..v, v, false)
end

--                                     x                                y       w                                h        desc
TransformGuiObject(ignoreSecondary,   x,                                164,     (width / 2) - padding,            h, "Buy a primary even if you have one.")
TransformGuiObject(ignorePrimary,     1*(width / 3),                    164,     (width / 2) - padding,            h, "Buy a secondary even if you have one.")
TransformGuiObject(parent,            (width / 2) + padding,            0,       (width / 2) - padding,            h                      ) 
TransformGuiObject(altParent,         (width / 2) + indent + padding,   30,      (width / 2) - padding - indent,   34, "Pistol round buy.")
TransformGuiObject(defaultSecondary,   x,                               y,       (width / 2) - padding,            h                      )
TransformGuiObject(altSecondary,       indent,                          86,      (width / 2) - padding - indent,   34, "Pistol round buy.")
TransformGuiObject(defaultPrimary,     x,                               y,       (width / 2) - padding,            h                      )

local function GoShopping(list)
    if #list == 0 then return end
    local cmd = "buy "..table.concat(list, "; buy ")
    client.Command(cmd, false)
end

callbacks.Register("FireGameEvent", function(event) 
    if event and event:GetName() == "enter_buyzone" then
        local userID = event:GetFloat("userid")
        local entity = entities.GetByUserID(userID)
        
        if entity and client.GetLocalPlayerIndex() == entity:GetIndex() then
            local COND_HAS_PRIMARY = false
            local COND_HAS_SECONDARY = false

            for i = 1, 62 do 
                local weapon = entity:GetPropEntity("m_hMyWeapons", i)
                local weapon_type = weapon:GetWeaponType()

                if weapon:GetName() then
                    if weapon_Type == 1 then
                        COND_HAS_SECONDARY = true
                    elseif weapon_type >= 2 and weapon_type <= 6 then
                        COND_HAS_PRIMARY = true
                    end
                end
            end

            local COND_IS_PISTOL_ROUND = tonumber(entity:GetProp("m_iAccount")) <= tonumber(client.GetConVar("mp_startmoney")) 
            local COND_SHOULD_BUY_PRIMARY = (not COND_IS_PISTOL_ROUND and not COND_HAS_PRIMARY) or (COND_HAS_PRIMARY and ignorePrimary:GetValue())
            local COND_SHOULD_BUY_SECONDARY = (COND_HAS_SECONDARY and not ignoreSecondary:GetValue()) or ignoreSecondary:GetValue()
            
            local list = {}

            if COND_SHOULD_BUY_PRIMARY then 
                table.insert(list, items.primarys[defaultPrimary:GetValue()])
            end

            if COND_SHOULD_BUY_SECONDARY then 
                if COND_IS_PISTOL_ROUND and altSecondary:GetValue() ~= 0 then
                    table.insert(list, items.secondarys[altSecondary:GetValue()])
                elseif not COND_IS_PISTOL_ROUND then
                    table.insert(list, items.secondarys[defaultSecondary:GetValue()])
                end
            end

            local utilityList = defaultUtility
            if COND_IS_PISTOL_ROUND then utilityList = altUtility end

            for k, e in pairs(utilityList) do 
                if e:GetValue() then
                    table.insert(list, e:GetName())
                end
            end

            GoShopping(list)
        end
    end
end)

client.AllowListener("enter_buyzone")










--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

