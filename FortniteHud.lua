-- Fortnite Hud by stacky

CreateTexture = draw.CreateTexture
DecodePNG = common.DecodePNG
Get = http.Get
SetFont = draw.SetFont
SetTexture = draw.SetTexture
FilledRect = draw.FilledRect
GetTextSize = draw.GetTextSize
GetScreenSize = draw.GetScreenSize
GetLocalPlayer = entities.GetLocalPlayer
Text = draw.Text
GetPlayerResources = entities.GetPlayerResources
CreateFont = draw.CreateFont
Color = draw.Color
GetLocalPlayerIndex = client.GetLocalPlayerIndex

local function loadTexture(url)
    return CreateTexture(DecodePNG(Get(url)))
end

local equipment = {
    ["weapon_deagle"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/deagle.png"),
    ["weapon_elite"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/berretas.png"),
	["weapon_fiveseven"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/fiveseven.png"),
	["weapon_glock"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/glock.png"),
    ["weapon_usp_silencer"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/usp.png"),
    ["weapon_cz75a"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/czauto.png"),
	["weapon_ak47"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/ak47.png"),
	["weapon_aug"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/aug.png"),
	["weapon_awp"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/sniper/awp.png"),
	["weapon_famas"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/famas.png"),
	["weapon_g3sg1"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/sniper/g3sg1.png"),
	["weapon_galilar"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/galil.png"),
	["weapon_m249"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/lmg/m249.png"),
    ["weapon_m4a1_silencer"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/m4a1s.png"),
    ["weapon_m4a1"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/m4a4.png"),
	["weapon_mac10"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/mac10.png"),
	["weapon_mp5sd"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/mp5.png"),
	["weapon_p90"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/p90.png"),
	["weapon_sg556"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/rifle/sg553.png"),
	["weapon_ump45"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/ump45.png"),
	["weapon_xm1014"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/shotgun/xm1014.png"),
	["weapon_bizon"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/ppbizon.png"),
	["weapon_mag7"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/shotgun/mag7.png"),
	["weapon_negev"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/lmg/negev.png"),
	["weapon_sawedoff"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/shotgun/sawedoff.png"),
	["weapon_tec9"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/tec9.png"),
	["weapon_taser"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/zeus.png"),
	["weapon_hkp2000"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/p2000.png"),
	["weapon_mp7"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/mp7.png"),
    ["weapon_revolver"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/revolver.png"),
    ["weapon_mp9"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/smg/mp9.png"),
	["weapon_nova"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/shotgun/nova.png"),
	["weapon_p250"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/pistol/p250.png"), 
	["weapon_scar20"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/sniper/scar20.png"),
	["weapon_ssg08"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/sniper/scout.png"),
	["weapon_flashbang"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/flashbang.png"), 
	["weapon_hegrenade"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/hegrenade.png"), 
	["weapon_smokegrenade"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/smoke.png"), 
	["weapon_molotov"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/molotov.png"),
	["weapon_decoy"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/decoy.png"), 
	["weapon_incgrenade"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/grenade/incendiary.png"), 
    ["weapon_c4"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/c4.png"), 
    ["knife"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/knife.png"), 
    ["empty"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/empty.png"),
    ["active"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/active.png"),
    ["defusekit"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/defusekit.png"),
    ["bullets_light"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/bullets/bullets_light.png"),
    ["bullets_medium"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/bullets/bullets_medium.png"),
    ["bullets_heavy"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/bullets/bullets_heavy.png"),
    ["bullets_slugs"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/bullets/bullets_slugs.png"),
    ["bullets_lightning"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/bullets/lightning.png"),
    ["bars"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/bars.png"),
    ["empty_grenade"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/emptygrenade.png"),
    ["materials_full"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/materials/full.png"),
    ["time"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/time.png"),
    ["players"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/players.png"),
    ["kills"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/kills.png"),
    ["map"] = loadTexture("https://raw.githubusercontent.com/stqcky/AimwareScripts/master/Fortnite Hud/images/other/map.png")
}

local compass = {
    [0] = {"NW", "330", "345", "N", "15", "30", "NE"},
    [15] = {"330", "345", "N", "15", "30", "NE", "60"},
    [30] = {"345", "N", "15", "30", "NE", "60", "75"},
    [45] = {"N", "15", "30", "NE", "60", "75", "E"},
    [60] = {"15", "30", "NE", "60", "75", "E", "105"},
    [75] = {"30", "NE", "60", "75", "E", "105", "120"},
    [90] = {"NE", "60", "75", "E", "105", "120", "SE"},
    [105] = {"60", "75", "E", "105", "120", "SE", "150"},
    [120] = {"75", "E", "105", "120", "SE", "150", "175"},
    [135] = {"E", "105", "120", "SE", "150", "165", "S"},
    [150] = {"105", "120", "SE", "150", "165", "S", "195"},
    [165] = {"120", "SE", "150", "165", "S", "195", "210"},
    [180] = {"SE", "150", "165", "S", "195", "210", "SW"},
    [195] = {"150", "165", "S", "195", "210", "SW", "240"},
    [210] = {"165", "S", "195", "210", "SW", "240", "255"},
    [225] = {"S", "195", "210", "SW", "240", "255", "W"},
    [240] = {"195", "210", "SW", "240", "255", "W", "285"},
    [255] = {"210", "SW", "240", "255", "W", "285", "300"},
    [270] = {"SW", "240", "255", "W", "285", "300", "NW"},
    [285] = {"240", "255", "W", "285", "300", "NW", "330"},
    [300] = {"255", "W", "285", "300", "NW", "330", "345"},
    [315] = {"W", "285", "300", "NW", "330", "345", "N"},
    [330] = {"285", "300", "NW", "330", "345", "N", "15"},
    [345] = {"300", "NW", "330", "345", "N", "15", "30"}
}

local weapons = {
    ["deagle"] = "a pistol",
    ["elite"] = "a pistol",
	["fiveseven"] = "a pistol",
	["glock"] = "a pistol",
    ["usp_silencer"] = "a pistol",
    ["cz75a"] = "a pistol",
	["ak47"] = "a rifle",
	["aug"] = "a rifle",
	["awp"] = "a sniper rifle",
	["famas"] = "a rifle",
	["g3sg1"] = "a sniper rifle",
	["galilar"] = "a rifle",
	["m249"] = "a machine gun",
    ["m4a1_silencer"] = "a rifle",
    ["m4a1"] = "a rifle",
	["mac10"] = "an smg",
	["mp5sd"] = "an smg",
	["p90"] = "an smg",
	["sg556"] = "a rifle",
	["ump45"] = "an smg",
	["xm1014"] = "a shotgun",
	["bizon"] = "an smg",
	["mag7"] = "a shotgun",
	["negev"] = "a machine gun",
	["sawedoff"] = "a shotgun",
	["tec9"] = "a pistol",
	["taser"] = "a taser",
	["hkp2000"] = "a pistol",
	["mp7"] = "an smg",
    ["revolver"] = "a pistol",
    ["mp9"] = "an smg",
	["nova"] = "a shotgun",
	["p250"] = "a pistol", 
	["scar20"] = "a sniper rifle",
	["ssg08"] = "a sniper rifle",
	["flashbang"] = "a flashbang", 
	["hegrenade"] = "a HE grenade", 
	["smokegrenade"] = "a smoke grenade", 
	["molotov"] = "a molotov",
	["decoy"] = "a decoy", 
	["incgrenade"] = "a incendiary grenade", 
    ["c4"] = "c4", 
    ["knife"] = "a knife"
}

local screenW, screenH = GetScreenSize()
draw.AddFontResource( Get("https://github.com/stqcky/AimwareScripts/raw/master/Fortnite%20Hud/images/font/NotoSans-Black.ttf") )
draw.AddFontResource( Get("https://github.com/stqcky/AimwareScripts/raw/master/Fortnite%20Hud/images/font/NotoSans-Light.ttf") )

local TAB = gui.Tab( gui.Reference( "Visuals" ), "fortnitehud", "Fortnite Hud" )

local SETTINGS_GBOX = gui.Groupbox( TAB, "Settings", 10, 10, 310, 0 )
local SETTINGS_ENABLE = gui.Checkbox( SETTINGS_GBOX, "settings.enable", "Enable Fortnite Hud", false )
local SETTINGS_HIDECSGO = gui.Checkbox( SETTINGS_GBOX, "settings.hidecsgo", "Hide CSGO Hud", false )
local SETTINGS_CUSTOMIZE = gui.Combobox( SETTINGS_GBOX, "settings.customize", "Customize", "Nothing", "Inventory", "Health & Armor Bars", "Ammo", "Compass", "Teammates", "Killfeed", "Materials", "Details", "Map")

local ELEMENTS_GBOX = gui.Groupbox( TAB, "Elements", 330, 10, 295, 0 )
local ELEMENTS_BARS = gui.Checkbox( ELEMENTS_GBOX, "elements.bars", "Health & Armor Bars", false )
local ELEMENTS_AMMO = gui.Checkbox( ELEMENTS_GBOX, "elements.ammo", "Ammo", false )
local ELEMENTS_INVENTORY = gui.Checkbox( ELEMENTS_GBOX, "elements.inventory", "Inventory", false )
local ELEMENTS_COMPASS = gui.Checkbox( ELEMENTS_GBOX, "elements.compass", "Compass", false )
local ELEMENTS_TEAMMATES = gui.Checkbox( ELEMENTS_GBOX, "elements.teammates", "Teammates", false )
local ELEMENTS_KILLFEED = gui.Checkbox( ELEMENTS_GBOX, "elements.killfeed", "Killfeed", false )
local ELEMENTS_MATERIALS = gui.Checkbox( ELEMENTS_GBOX, "elements.materials", "Materials", false )
local ELEMENTS_DETAILS = gui.Checkbox( ELEMENTS_GBOX, "elements.details", "Details", false )
local ELEMENTS_MAP = gui.Checkbox( ELEMENTS_GBOX, "elements.map", "Map", false )

local INVENTORY_GBOX = gui.Groupbox( TAB, "Inventory Customizer", 10, 200, 310, 0)
local INVENTORY_X = gui.Slider( INVENTORY_GBOX, "inventory.x", "X Offset", screenW - 566, 0, screenW )
local INVENTORY_Y = gui.Slider( INVENTORY_GBOX, "inventory.y", "Y Offset", screenH - 140, 0, screenH )
local INVENTORY_GAP = gui.Slider( INVENTORY_GBOX, "inventory.gap", "Gap Size", 2, 0, 10 )
local INVENTORY_SCALE = gui.Slider( INVENTORY_GBOX, "inventory.scale", "Scale", 1, 0.1, 5, 0.1 )

local BARS_GBOX = gui.Groupbox( TAB, "Bars Customizer", 10, 200, 310, 0)
local BARS_X = gui.Slider( BARS_GBOX, "bars.x", "X Offset", screenW / 2 - 227, 0, screenW )
local BARS_Y = gui.Slider( BARS_GBOX, "bars.y", "Y Offset", screenH - 142, 0, screenH )
local BARS_SCALE = gui.Slider( BARS_GBOX, "bars.scale", "Scale", 1.7, 0.1, 5, 0.1 )

local AMMO_GBOX = gui.Groupbox( TAB, "Ammo Customizer", 10, 200, 310, 0)
local AMMO_X = gui.Slider( AMMO_GBOX, "ammo.x", "X Offset", screenW / 2, 0, screenW )
local AMMO_Y = gui.Slider( AMMO_GBOX, "ammo.y", "Y Offset", screenH - 180, 0, screenH )
local AMMO_SCALE = gui.Slider( AMMO_GBOX, "ammo.scale", "Scale", 1, 0.1, 5, 0.1 )

local COMPASS_GBOX = gui.Groupbox( TAB, "Compass Customizer", 10, 200, 310, 0)
local COMPASS_X = gui.Slider( COMPASS_GBOX, "compass.x", "X Offset", screenW / 2, 0, screenW )
local COMPASS_Y = gui.Slider( COMPASS_GBOX, "compass.y", "Y Offset", 50, 0, screenH )
local COMPASS_SCALE = gui.Slider( COMPASS_GBOX, "compass.scale", "Scale", 1, 0.1, 5, 0.1 )

local TEAMMATES_GBOX = gui.Groupbox( TAB, "Teammates Customizer", 10, 200, 310, 0)
local TEAMMATES_X = gui.Slider( TEAMMATES_GBOX, "teammates.x", "X Offset", 25, 0, screenW )
local TEAMMATES_Y = gui.Slider( TEAMMATES_GBOX, "teammates.y", "Y Offset", 50, 0, screenH )
local TEAMMATES_SCALE = gui.Slider( TEAMMATES_GBOX, "teammates.scale", "Scale", 1, 0.1, 5, 0.1 )

local KILLFEED_GBOX = gui.Groupbox( TAB, "Killfeed Customizer", 10, 200, 310, 0)
local KILLFEED_X = gui.Slider( KILLFEED_GBOX, "killfeed.x", "X Offset", 50, 0, screenW )
local KILLFEED_Y = gui.Slider( KILLFEED_GBOX, "killfeed.y", "Y Offset", screenH - 200, 0, screenH )
local KILLFEED_SCALE = gui.Slider( KILLFEED_GBOX, "killfeed.scale", "Scale", 1, 0.1, 5, 0.1 )
local KILLFEED_DISSAPEAR = gui.Slider( KILLFEED_GBOX, "killfeed.dissapear", "Dissapear Time", 5, 0.1, 10, 0.5 )

local MATERIALS_GBOX = gui.Groupbox( TAB, "Materials Customizer", 10, 200, 310, 0)
local MATERIALS_X = gui.Slider( MATERIALS_GBOX, "materials.x", "X Offset", screenW - 200, 0, screenW )
local MATERIALS_Y = gui.Slider( MATERIALS_GBOX, "materials.y", "Y Offset", screenH - 450, 0, screenH )
local MATERIALS_SCALE = gui.Slider( MATERIALS_GBOX, "materials.scale", "Scale", 1, 0.1, 5, 0.1 )

local DETAILS_GBOX = gui.Groupbox( TAB, "Details Customizer", 10, 200, 310, 0)
local DETAILS_X = gui.Slider( DETAILS_GBOX, "details.x", "X Offset", screenW - 270, 0, screenW )
local DETAILS_Y = gui.Slider( DETAILS_GBOX, "details.y", "Y Offset", screenH - 760, 0, screenH )
local DETAILS_SCALE = gui.Slider( DETAILS_GBOX, "details.scale", "Scale", 1, 0.1, 5, 0.1 )

local MAP_GBOX = gui.Groupbox( TAB, "Map Customizer", 10, 200, 310, 0)
local MAP_X = gui.Slider( MAP_GBOX, "map.x", "X Offset", screenW - 300, 0, screenW )
local MAP_Y = gui.Slider( MAP_GBOX, "map.y", "Y Offset", 50, 0, screenH )
local MAP_SCALE = gui.Slider( MAP_GBOX, "map.scale", "Scale", 1, 0.1, 5, 0.1 )

-- Inventory variables
local inventoryFont = CreateFont( "Noto Sans Blk", 25, 25 )
local InventoryXOffset = INVENTORY_X:GetValue()
local InventoryYOffset = INVENTORY_Y:GetValue()
local InventoryGap = INVENTORY_GAP:GetValue()
local InventoryScale = INVENTORY_SCALE:GetValue()
local InventorySize = 90
local weaponSlots = nil
local activeWeapon = nil
local grenadeIndexes = {}
local grenadeCount = 0
local lPlayer = GetLocalPlayer()
local inventoryLastScale = INVENTORY_SCALE:GetValue()
local inventoryChangeFont = false
local InventoryHealthshot = false

-- Bars variables
local BarsXOffset = BARS_X:GetValue()
local BarsYOffset = BARS_Y:GetValue()
local BarsScale = BARS_SCALE:GetValue()
local HP = 0
local HPBAR = 0
local MAXHP = 0
local ARMOR = 0
local ARMORBAR = false
local HELMET = 0
local BarsChangeFont = false
local BarsLastScale = BARS_SCALE:GetValue()
local BarsGap = 0
local barsFont = CreateFont( "Noto Sans Blk", 50 / BarsScale, 50 / BarsScale )

-- Ammo variables
local AmmoFont = CreateFont( "Noto Sans Light", 45, 45 )
local AmmoXOffset = BARS_X:GetValue()
local AmmoYOffset = BARS_Y:GetValue()
local AmmoScale = BARS_SCALE:GetValue()
local AmmoChangeFont = false
local AmmoLastScale = BARS_SCALE:GetValue()

-- Compass variables
local CompassFont = CreateFont( "Noto Sans Light", 45, 45 )
local CompassArrowFont = CreateFont( "Noto Sans Light", 20, 20 )
local CompassXOffset = COMPASS_X:GetValue()
local CompassYOffset = COMPASS_Y:GetValue()
local CompassScale = COMPASS_SCALE:GetValue()
local CompassChangeFont = false
local CompassLastScale = COMPASS_SCALE:GetValue()
local CompassMain = ""
local CompassLeft = ""
local CompassRight = ""

-- Teammates variables
local TeammatesFont = CreateFont( "Noto Sans Blk", 30, 30 )
local TeammatesXOffset = TEAMMATES_X:GetValue()
local TeammatesYOffset = TEAMMATES_Y:GetValue()
local TeammatesScale = TEAMMATES_SCALE:GetValue()
local TeammatesChangeFont = false
local TeammatesLastScale = TEAMMATES_SCALE:GetValue()
local TeammatesPlayers = {}

-- Killfeed variables
local KillfeedFont = CreateFont( "Noto Sans Light", 20, 20 )
local KillfeedXOffset = KILLFEED_X:GetValue()
local KillfeedYOffset = KILLFEED_Y:GetValue()
local KillfeedScale = KILLFEED_SCALE:GetValue()
local KillfeedChangeFont = false
local KillfeedLastScale = KILLFEED_SCALE:GetValue()
local KillfeedTime = KILLFEED_DISSAPEAR:GetValue()
local KillFeedEntries = {}

-- Materials variables
local MaterialsFont = CreateFont( "Noto Sans Blk", 24, 24 )
local MaterialsXOffset = TEAMMATES_X:GetValue()
local MaterialsYOffset = TEAMMATES_Y:GetValue()
local MaterialsScale = TEAMMATES_SCALE:GetValue()
local MaterialsChangeFont = false
local MaterialsLastScale = TEAMMATES_SCALE:GetValue()
local MaterialsTScore = 0
local MaterialsCTScore = 0
local MaterialsMoney = 0

-- Details variables
local DetailsFont = CreateFont( "Noto Sans Blk", 24, 24 )
local DetailsXOffset = DETAILS_X:GetValue()
local DetailsYOffset = DETAILS_Y:GetValue()
local DetailsScale = DETAILS_SCALE:GetValue()
local DetailsChangeFont = false
local DetailsLastScale = DETAILS_SCALE:GetValue()
local DetailsTime = 0
local DetailsPlayers = 0
local DetailsKills = 0

-- Map variables
local MapXOffset = DETAILS_X:GetValue()
local MapYOffset = DETAILS_Y:GetValue()
local MapScale = DETAILS_SCALE:GetValue()

callbacks.Register( "CreateMove", function(cmd)
    if SETTINGS_ENABLE:GetValue() and lPlayer ~= nil then
        if ELEMENTS_INVENTORY:GetValue() or ELEMENTS_AMMO:GetValue() then
            local m_hActiveWeapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
            activeWeapon = {m_hActiveWeapon:GetWeaponType(), m_hActiveWeapon:GetProp("m_iClip1"), m_hActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount"), 
                            m_hActiveWeapon:GetProp("m_iClip1") + m_hActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount"),
                            {}, {}, m_hActiveWeapon:GetName()}

            if activeWeapon[1] == 1 then
                activeWeapon[5] = "bullets_light"
                activeWeapon[6] = 3
            elseif activeWeapon[1] == 2 then
                activeWeapon[5] = "bullets_light"
                activeWeapon[6] = 2
            elseif activeWeapon[1] == 3 then
                activeWeapon[5] = "bullets_medium"
                activeWeapon[6] = 2
            elseif activeWeapon[1] == 4 then
                activeWeapon[5] = "bullets_slugs"
                activeWeapon[6] = 2
            elseif activeWeapon[1] == 5 then
                activeWeapon[5] = "bullets_heavy"
                activeWeapon[6] = 2
            elseif activeWeapon[1] == 6 then
                activeWeapon[5] = "bullets_medium"
                activeWeapon[6] = 2
            elseif activeWeapon[1] == 7 then
                activeWeapon[5] = ""
                activeWeapon[6] = 6
            elseif activeWeapon[1] == 9 then
                activeWeapon[5] = ""
                activeWeapon[6] = 5
            elseif activeWeapon[1] == 0 and activeWeapon[2] ~= -1 then
                activeWeapon[5] = "bullets_lightning"
                activeWeapon[6] = 4
            elseif activeWeapon[1] == 0 then
                activeWeapon[5] = ""
                activeWeapon[6] = 1
            end

            weaponSlots = {{"knife", 0, -1, -1, -1}, {}, {}, {}, {}, {}}
            InventoryHealthshot = false
            for i = 1, 9 do 
                local weapon = entities.GetLocalPlayer():GetPropEntity("m_hMyWeapons", i)
                local weaponInfo = {}
                if weapon:GetName() ~= nil then        
                    weaponInfo = {weapon:GetName(), weapon:GetWeaponType(), weapon:GetProp("m_iClip1"), 
                                weapon:GetProp("m_iPrimaryReserveAmmoCount"), 
                                weapon:GetProp("m_iClip1") + weapon:GetProp("m_iPrimaryReserveAmmoCount")}
                else
                    weaponInfo = {nil}
                end

                if weaponInfo[2] == 1 then
                    weaponInfo[6] = "bullets_light"
                    weaponSlots[3] = weaponInfo
                elseif weaponInfo[2] == 2 then
                    weaponInfo[6] = "bullets_light"
                    weaponSlots[2] = weaponInfo
                elseif weaponInfo[2] == 3 then
                    weaponInfo[6] = "bullets_medium"
                    weaponSlots[2] = weaponInfo
                elseif weaponInfo[2] == 4 then
                    weaponInfo[6] = "bullets_slugs"
                    weaponSlots[2] = weaponInfo
                elseif weaponInfo[2] == 5 then
                    weaponInfo[6] = "bullets_heavy"
                    weaponSlots[2] = weaponInfo
                elseif weaponInfo[2] == 6 then
                    weaponInfo[6] = "bullets_medium"
                    weaponSlots[2] = weaponInfo
                elseif weaponInfo[2] == 0 then
                    weaponInfo[6] = "bullets_lightning"
                    weaponSlots[4] = weaponInfo
                elseif weaponInfo[2] == 7 then
                    weaponSlots[6] = weaponInfo
                elseif weaponInfo[2] == 9 then
                    table.insert(weaponSlots[5], weaponInfo)
                elseif weaponInfo[2] == 11 then
                    InventoryHealthshot = true
                end
            end

            if lPlayer:GetProp("m_bHasDefuser") == 1 then
                weaponSlots[6] = {"defusekit", 0, -1, -1, -1}
            end

            grenadeIndexes = {}
            grenadeCount = 0
            local grenades = weaponSlots[5]
            if grenades ~= nil then
                for i = 1, #grenades do
                    grenadeCount = grenadeCount + 1
                    table.insert(grenadeIndexes, i)
                end
            end

            InventoryXOffset = INVENTORY_X:GetValue()
            InventoryYOffset = INVENTORY_Y:GetValue()
            InventoryGap = INVENTORY_GAP:GetValue()
            InventoryScale = INVENTORY_SCALE:GetValue()

            if inventoryLastScale ~= InventoryScale then
                inventoryChangeFont = true
            end
            inventoryLastScale = InventoryScale

            AmmoXOffset = AMMO_X:GetValue()
            AmmoYOffset = AMMO_Y:GetValue()
            AmmoScale = AMMO_SCALE:GetValue()
            if AmmoLastScale ~= AmmoScale then
                AmmoChangeFont = true
            end
            AmmoLastScale = AmmoScale
        end

        if ELEMENTS_BARS:GetValue() then
            if BarsLastScale ~= BARS_SCALE:GetValue() then
                BarsChangeFont = true
            end
            BarsLastScale = BARS_SCALE:GetValue()

            BarsXOffset = BARS_X:GetValue()
            BarsYOffset = BARS_Y:GetValue()
            BarsScale = BARS_SCALE:GetValue()
            BarsGap = 20 / BarsScale

            HP = lPlayer:GetHealth()
            local temphp = HP
            if HP > 100 then temphp = 100 end
            temphp = temphp + 5
            HPBAR = BarsXOffset + ((868 / BarsScale) * (temphp * 0.01))
            MAXHP = lPlayer:GetMaxHealth()

            ARMOR = lPlayer:GetProp("m_ArmorValue")
            if ARMOR > 100 then ARMOR = 100 end
            if ARMOR > 1 then
                ARMORBAR = BarsXOffset + (868 / BarsScale) * (ARMOR + 5) * 0.01
            else
                ARMORBAR = BarsXOffset + 47 / BarsScale
            end
            HELMET = lPlayer:GetProp("m_bHasHelmet") == 1
        end

        if ELEMENTS_COMPASS:GetValue() then
            if CompassLastScale ~= COMPASS_SCALE:GetValue() then
                CompassChangeFont = true
            end
            CompassLastScale = COMPASS_SCALE:GetValue()

            CompassXOffset = COMPASS_X:GetValue()
            CompassYOffset = COMPASS_Y:GetValue()
            CompassScale = COMPASS_SCALE:GetValue()

            local yaw = math.floor(cmd.viewangles["y"])
            if yaw < 0 then yaw = 360 + yaw else yaw = yaw end
            yaw = 360 - yaw
        
            local stepsUp = 0
            local numberUp = yaw

            local stepsDown = 0
            local numberDown = yaw
        
            for i = 1, 15 do 
                if numberUp == 360 then numberUp = 0 end
                if numberDown == 360 then numberDown = 0 end

                if numberUp % 15 ~= 0 then
                    numberUp = numberUp + 1
                    stepsUp = stepsUp + 1
                end

                if numberDown % 15 ~= 0 then
                    numberDown = numberDown - 1
                    stepsDown = stepsDown + 1
                end
            end
        
            if stepsUp < stepsDown then 
                local tmp = compass[numberUp]
                CompassMain = tmp[4]
                CompassLeft = tmp[1] .. "  " .. tmp[2] .. "  " .. tmp[3] .. "  "
                CompassRight = "  " .. tmp[5] .. "  " .. tmp[6] .. "  " .. tmp[7]
            else
                local tmp = compass[numberDown]
                CompassMain = tmp[4]
                CompassLeft = tmp[1] .. "  " .. tmp[2] .. "  " .. tmp[3] .. "  "
                CompassRight = "  " .. tmp[5] .. "  " .. tmp[6] .. "  " .. tmp[7]
            end
        end

        if ELEMENTS_TEAMMATES:GetValue() or ELEMENTS_DETAILS:GetValue() then
            if TeammatesLastScale ~= TEAMMATES_SCALE:GetValue() then
                TeammatesChangeFont = true
            end
            TeammatesLastScale = TEAMMATES_SCALE:GetValue()

            TeammatesXOffset = TEAMMATES_X:GetValue()
            TeammatesYOffset = TEAMMATES_Y:GetValue()
            TeammatesScale = TEAMMATES_SCALE:GetValue()

            TeammatesPlayers = {}

            DetailsPlayers = 0

            local players = entities.FindByClass( "CCSPlayer" )
            local selfTeam = lPlayer:GetTeamNumber()
            local selfIndex = lPlayer:GetIndex()
            for i = 1, #players do
                local player = players[i]
                if player:GetTeamNumber() == selfTeam and selfIndex ~= player:GetIndex() then
                    table.insert(TeammatesPlayers, {player:GetName(), player:GetHealth(), player:GetProp("m_ArmorValue"), GetPlayerResources():GetPropInt("m_iCompTeammateColor", player:GetIndex())})
                else
                    if player:IsAlive() then
                        DetailsPlayers = DetailsPlayers + 1
                    end
                end
            end
        end

        DetailsPlayers = DetailsPlayers - 1

        if ELEMENTS_KILLFEED:GetValue() then
            if KillfeedLastScale ~= KILLFEED_SCALE:GetValue() then
                KillfeedChangeFont = true
            end
            KillfeedLastScale = KILLFEED_SCALE:GetValue()

            KillfeedXOffset = KILLFEED_X:GetValue()
            KillfeedYOffset = KILLFEED_Y:GetValue()
            KillfeedScale = KILLFEED_SCALE:GetValue()
            KillfeedTime = KILLFEED_DISSAPEAR:GetValue()

            local entry = KillFeedEntries[1]
            if entry ~= nil then
                if globals.CurTime() >= entry[2] then
                    table.remove(KillFeedEntries, 1)
                end
            end
        end

        if ELEMENTS_MATERIALS:GetValue() then
            if MaterialsLastScale ~= MATERIALS_SCALE:GetValue() then
                MaterialsChangeFont = true
            end
            MaterialsLastScale = MATERIALS_SCALE:GetValue()

            MaterialsXOffset = MATERIALS_X:GetValue()
            MaterialsYOffset = MATERIALS_Y:GetValue()
            MaterialsScale = MATERIALS_SCALE:GetValue()

            MaterialsTScore = entities.FindByClass( "CCSTeam" )[3]:GetProp("m_scoreTotal")
            MaterialsCTScore = entities.FindByClass( "CCSTeam" )[4]:GetProp("m_scoreTotal")
            MaterialsMoney = lPlayer:GetProp("m_iAccount")
        end

        if ELEMENTS_DETAILS:GetValue() then
            if DetailsLastScale ~= DETAILS_SCALE:GetValue() then
                DetailsChangeFont = true
            end
            DetailsLastScale = DETAILS_SCALE:GetValue()

            DetailsXOffset = DETAILS_X:GetValue()
            DetailsYOffset = DETAILS_Y:GetValue()
            DetailsScale = DETAILS_SCALE:GetValue()

            --DetailsTime = entities.FindByClass( "CCSTeam" )[3]:GetProp("m_scoreTotal")
            DetailsKills = GetPlayerResources():GetPropInt("m_iKills", GetLocalPlayerIndex())
        end

        if ELEMENTS_MAP:GetValue() then
            MapXOffset = MAP_X:GetValue()
            MapYOffset = MAP_Y:GetValue()
            MapScale = MAP_SCALE:GetValue()
        end

        if SETTINGS_HIDECSGO:GetValue() then client.SetConVar( "cl_drawhud", 0, true ) else client.SetConVar( "cl_drawhud", 1, true ) end
    end
end )

callbacks.Register( "Draw", function()
    lPlayer = GetLocalPlayer()

    INVENTORY_GBOX:SetInvisible(true)
    local customize = SETTINGS_CUSTOMIZE:GetValue()

    INVENTORY_GBOX:SetInvisible(true)
    BARS_GBOX:SetInvisible(true)
    AMMO_GBOX:SetInvisible(true)
    COMPASS_GBOX:SetInvisible(true)
    TEAMMATES_GBOX:SetInvisible(true)
    KILLFEED_GBOX:SetInvisible(true)
    MATERIALS_GBOX:SetInvisible(true)
    DETAILS_GBOX:SetInvisible(true)
    MAP_GBOX:SetInvisible(true)

    if customize == 1 then
        INVENTORY_GBOX:SetInvisible(false)
    elseif customize == 2 then
        BARS_GBOX:SetInvisible(false)
    elseif customize == 3 then
        AMMO_GBOX:SetInvisible(false)
    elseif customize == 4 then
        COMPASS_GBOX:SetInvisible(false)
    elseif customize == 5 then
        TEAMMATES_GBOX:SetInvisible(false)
    elseif customize == 6 then 
        KILLFEED_GBOX:SetInvisible(false)
    elseif customize == 7 then
        MATERIALS_GBOX:SetInvisible(false)
    elseif customize == 8 then
        DETAILS_GBOX:SetInvisible(false)
    elseif customize == 9 then
        MAP_GBOX:SetInvisible(false)
    end

    screenW, screenH = GetScreenSize()

    if SETTINGS_ENABLE:GetValue() and lPlayer ~= nil then
        if ELEMENTS_INVENTORY:GetValue() then
            if inventoryChangeFont then 
                inventoryFont = CreateFont( "Noto Sans Blk", 25 / InventoryScale, 25 / InventoryScale )
                inventoryChangeFont = false
            end
            SetFont(inventoryFont)

            local localXOffset = InventoryXOffset
            local localYOffset = InventoryYOffset
            local activeXOffset = 0
            local activeYOffset = 0

            local nadeActive = false

            local sizeScaled = InventorySize / InventoryScale

            for i = 1, 6 do            
                local weapon = weaponSlots[i]
                if weapon[1] ~= nil then
                    if i == activeWeapon[6] then
                        localYOffset = localYOffset - 10 / InventoryScale
                        activeXOffset = localXOffset
                        activeYOffset = localYOffset
                    end

                    if i ~= 5 then
                        -- Draw weapon icon
                        SetTexture(equipment[weapon[1]])
                        FilledRect(localXOffset, localYOffset, localXOffset + sizeScaled, localYOffset + sizeScaled)

                        local totalAmmo = weapon[5]
                        if totalAmmo ~= -1 then
                            -- Draw total ammo
                            local strTotalAmmo = tostring(totalAmmo)
                            local totalAmmoW, totalAmmoH = GetTextSize(strTotalAmmo)
                            Text(localXOffset + (InventorySize / 2) / InventoryScale - totalAmmoW / 2, localYOffset + (InventorySize / 1.35) / InventoryScale, strTotalAmmo)

                            -- Draw ammo icon
                            SetTexture(equipment[weapon[6]])
                            FilledRect(localXOffset + (InventorySize / 1.25) / InventoryScale - 5 / InventoryScale, localYOffset + (InventorySize / 1.3) / InventoryScale - 5 / InventoryScale,
                                        localXOffset + sizeScaled - 5 / InventoryScale, localYOffset + (InventorySize / 1.3) / InventoryScale + totalAmmoH)
                        end
                    else
                        local grenadesDrawn = 0
                        if grenadeCount == 1 then
                            SetTexture(equipment[weapon[grenadeIndexes[1]][1]])
                            FilledRect(localXOffset, localYOffset, localXOffset + sizeScaled, localYOffset + sizeScaled)
                        else
                            SetTexture(equipment["empty_grenade"])
                            FilledRect(localXOffset, localYOffset, localXOffset + sizeScaled, localYOffset + sizeScaled)
                            
                            for i = 1, #weapon do 
                                local grenade = weapon[i]
                                local x1, y1, x2, y2 = nil, nil

                                if grenadesDrawn == 0 then
                                    x1 = localXOffset
                                    y1 = localYOffset
                                    x2 = localXOffset + sizeScaled / 2
                                    y2 = localYOffset + sizeScaled / 2 
                                elseif grenadesDrawn == 1 then
                                    x1 = localXOffset + sizeScaled / 2
                                    y1 = localYOffset
                                    x2 = localXOffset + sizeScaled
                                    y2 = localYOffset + sizeScaled / 2
                                elseif grenadesDrawn == 2 then
                                    x1 = localXOffset
                                    y1 = localYOffset + sizeScaled / 2 
                                    x2 = localXOffset + sizeScaled / 2 
                                    y2 = localYOffset + sizeScaled 
                                else
                                    x1 = localXOffset + sizeScaled / 2 
                                    y1 = localYOffset + sizeScaled / 2 
                                    x2 = localXOffset + sizeScaled 
                                    y2 = localYOffset + sizeScaled 
                                end

                                SetTexture(equipment[grenade[1]])
                                FilledRect(x1, y1, x2, y2)

                                if activeWeapon[7] == grenade[1] then
                                    activeXOffset = x1
                                    activeYOffset = y1
                                    nadeActive = true
                                end

                                grenadesDrawn = grenadesDrawn + 1
                            end
                        end
                    end
                else
                    SetTexture(equipment["empty"])
                    FilledRect(localXOffset, localYOffset, localXOffset + sizeScaled, localYOffset + sizeScaled)
                end

                if i ~= 1 then 
                    localXOffset = localXOffset + (InventorySize + InventoryGap) / InventoryScale
                else -- Increase gap after knife
                    localXOffset = localXOffset + (InventorySize + InventoryGap * 4) / InventoryScale
                end

                localYOffset = InventoryYOffset
            end

            if not nadeActive then
                SetTexture(equipment["active"])
                FilledRect(activeXOffset, activeYOffset, activeXOffset + sizeScaled, activeYOffset + sizeScaled)
            else
                SetTexture(equipment["active"])
                FilledRect(activeXOffset, activeYOffset, activeXOffset + InventorySize / 2 / InventoryScale, activeYOffset + InventorySize / 2 / InventoryScale)
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_BARS:GetValue() then
            if BarsChangeFont then 
                barsFont = CreateFont( "Noto Sans Blk", 50 / BarsScale, 50 / BarsScale )
                BarsChangeFont = false
            end
            SetFont(barsFont)

            local x1 = BarsXOffset + 47 / BarsScale
            local y = BarsYOffset + 102 / BarsScale
            local bar47 = 47 / BarsScale

            SetTexture(equipment["bars"])
            FilledRect(BarsXOffset, BarsYOffset, 
                       BarsXOffset + 910 / BarsScale, y)

            -- HP
            SetTexture(nil)
            Color( 100, 204, 67, 255 )
            FilledRect(x1, y - bar47, HPBAR, BarsYOffset + 102 / BarsScale)

            Color( 255, 255, 255, 255 )
            local hptext = tostring(HP)
            if InventoryHealthshot then
                hptext = hptext .. "H "
            else
                hptext = hptext .. " "
            end
            local W, H = GetTextSize(hptext)
            Text(x1 + BarsGap, y - bar47 + H / 2.5, hptext)
            Color( 255, 255, 255, 127)
            hptext = "ǀ " .. tostring(MAXHP)
            Text(x1 + BarsGap + W, y - bar47 + H / 2.5, hptext)

            -- Armor
            Color( 0, 112, 185, 255 )
            FilledRect(x1, BarsYOffset, ARMORBAR, BarsYOffset + bar47)

            Color( 255, 255, 255, 255 )
            local armortext = tostring(ARMOR)
            if HELMET then armortext = armortext .. "H" end
            W, H = GetTextSize(armortext)
            Text(x1 + BarsGap, BarsYOffset + H / 2.5, armortext)
            Color(255, 255, 255, 127)
            armortext = " ǀ 100" 
            Text(x1 + BarsGap + W, BarsYOffset + H / 2.5, armortext)
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_AMMO:GetValue() then
            if AmmoChangeFont then 
                AmmoFont = CreateFont( "Noto Sans Light", 45 / AmmoScale, 45 / AmmoScale )
                AmmoChangeFont = false
            end
            SetFont(AmmoFont)

            if activeWeapon[2] ~= -1 then
                local ammoFull = tostring(activeWeapon[2] .. " | " .. activeWeapon[3])
                Color(255, 255, 255, 255)
                local W, H = GetTextSize(ammoFull)
                Text(AmmoXOffset - W / 2, AmmoYOffset - H / 2, ammoFull )
                SetTexture( equipment[activeWeapon[5]] )
                FilledRect(AmmoXOffset + W / 2 + 20 / AmmoScale, AmmoYOffset - H, AmmoXOffset + W / 2 + 70 / AmmoScale, AmmoYOffset + H)
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_COMPASS:GetValue() then
            if CompassChangeFont then 
                CompassFont = CreateFont( "Noto Sans Light", 45 / CompassScale, 45 / CompassScale )
                CompassArrowFont = CreateFont( "Noto Sans Light", 20 / CompassScale, 20 / CompassScale )
                CompassChangeFont = false
            end

            Color(255, 255, 255, 255)

            SetFont(CompassFont)
            local mainW, mainH = GetTextSize(CompassMain)
            local leftW, leftH = GetTextSize(CompassLeft)
            local rightW, rightH = GetTextSize(CompassRight)

            Text( CompassXOffset - mainW / 2 , CompassYOffset,  CompassMain)
            Text( CompassXOffset - leftW - mainW / 2, CompassYOffset, CompassLeft )
            Text( CompassXOffset + mainW / 2, CompassYOffset, CompassRight )

            SetFont(CompassArrowFont)
            local arrowW, arrowH = GetTextSize("▼")
            Text( CompassXOffset - arrowW / 2 , CompassYOffset - mainH, "▼" )
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_TEAMMATES:GetValue() then
            if TeammatesChangeFont then 
                TeammatesFont = CreateFont( "Noto Sans Blk", 30 / TeammatesScale, 30 / TeammatesScale )
                TeammatesChangeFont = false
            end
            SetFont(TeammatesFont)

            local localYOffset = TeammatesYOffset
            SetTexture(nil)

            for i = 1, #TeammatesPlayers do
                local player = TeammatesPlayers[i]
                local playerName = player[1]
                local playerHP = player[2]
                local playerColor = player[4]

                if playerHP > 1 then
                    Color(255, 255, 255 ,255)
                else
                    Color(255, 0, 0, 255)
                end
                local nameW, nameH = GetTextSize(playerName)
                draw.TextShadow(TeammatesXOffset, localYOffset, playerName )

                if playerColor == 0 then
                    Color(255, 255, 0, 255)
                elseif playerColor == 1 then
                    Color(148, 0, 211, 255)
                elseif playerColor == 2 then
                    Color(0, 255, 0, 255)
                elseif playerColor == 3 then
                    Color(0, 0, 255, 255)
                elseif playerColor == 4 then
                    Color(255,140,0, 255)
                else
                    Color(128,128,128, 255)
                end

                local tmp1 = localYOffset + nameH * 1.5
                local tmp2 = TeammatesXOffset + 9 / TeammatesScale
                local tmp3 = tmp2 + 200 / TeammatesScale
                local tmp7 = localYOffset + nameH * 2
                local tmp4 = tmp7 + 2 / TeammatesScale
                local tmp5 = localYOffset + nameH * 3
                local tmp6 = 0.01 / TeammatesScale

                -- Color
                SetTexture(nil)
                FilledRect(TeammatesXOffset, tmp1, TeammatesXOffset + 7 / TeammatesScale, tmp5)

                -- Armor
                Color(0, 0, 0, 127)
                FilledRect(tmp2, tmp1, tmp3, tmp7)
                Color( 0, 112, 185, 255 )
                FilledRect(tmp2, tmp1, tmp2 + 200 * player[3] * tmp6, tmp7)

                -- HP
                Color(0, 0, 0, 127)
                FilledRect(tmp2, tmp4, tmp3, tmp5)
                Color( 100, 204, 67, 255 )
                FilledRect(tmp2, tmp4, tmp2 + 200 * playerHP * tmp6, tmp5)

                localYOffset = localYOffset + nameH * 4
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_KILLFEED:GetValue() then
            if KillfeedChangeFont then 
                KillfeedFont = CreateFont( "Noto Sans Light", 15 / KillfeedScale, 15 / KillfeedScale )
                KillfeedChangeFont = false
            end
            SetFont(KillfeedFont)

            SetTexture(nil)

            local localYOffset = KillfeedYOffset

            for i = 1, #KillFeedEntries do
                local text = KillFeedEntries[i][1]
                local textW, textH = GetTextSize(text)

                Color(0, 0, 0, 127)
                FilledRect(KillfeedXOffset - 4 / KillfeedScale, localYOffset - 4 / KillfeedScale,
                           KillfeedXOffset + textW + 4 / KillfeedScale, localYOffset + textH + 4 / KillfeedScale)
                Color(255, 255, 255, 255)
                Text(KillfeedXOffset, localYOffset, text)

                localYOffset = localYOffset + textH + 8 / KillfeedScale
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_MATERIALS:GetValue() then
            if MaterialsChangeFont then 
                MaterialsFont = CreateFont( "Noto Sans Blk", 24 / MaterialsScale, 24 / MaterialsScale )
                MaterialsChangeFont = false
            end
            SetFont(MaterialsFont)

            local text = ""
            local localXOffset = MaterialsXOffset

            SetTexture(equipment["materials_full"])
            FilledRect(MaterialsXOffset, MaterialsYOffset, MaterialsXOffset + 180 / MaterialsScale, MaterialsYOffset + 80 / MaterialsScale)

            for i = 1, 3 do
                if i == 1 then
                    text = MaterialsMoney
                elseif i == 2 then
                    text = MaterialsCTScore
                else
                    text = MaterialsTScore
                end

                local textW, textH = GetTextSize(text)
                Text(localXOffset + 29 / MaterialsScale - textW / 2, MaterialsYOffset + 56 / MaterialsScale, text)
                localXOffset = localXOffset + 63 / MaterialsScale
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_DETAILS:GetValue() then
            if DetailsChangeFont then 
                DetailsFont = CreateFont( "Noto Sans Blk", 24 / DetailsScale, 24 / DetailsScale )
                DetailsChangeFont = false
            end
            SetFont(DetailsFont)

            local text = ""
            local localXOffset = DetailsXOffset
            
            for i = 1, 3 do
                if i == 1 then
                    text = DetailsTime
                    SetTexture(equipment["time"])
                elseif i == 2 then
                    text = DetailsPlayers
                    SetTexture(equipment["players"])
                else
                    text = DetailsKills
                    SetTexture(equipment["kills"])
                end

                local textW, textH = GetTextSize(text)
                local x35 = localXOffset + 35 / DetailsScale
                local scale30 = 30 / DetailsScale

                FilledRect(localXOffset, DetailsYOffset, localXOffset + scale30, DetailsYOffset + scale30)
                Text(x35, DetailsYOffset + textH / 2, text)

                localXOffset = x35 + textW * 2
            end
        end

        SetTexture(nil)
        Color(255, 255, 255, 255)

        if ELEMENTS_MAP:GetValue() then
            SetTexture(equipment["map"])
            FilledRect(MapXOffset, MapYOffset, MapXOffset + 250 / MapScale, MapYOffset + 250 / MapScale)
        end
    end
end )

callbacks.Register( "FireGameEvent", function(event)
    if ELEMENTS_KILLFEED:GetValue() and event:GetName() == "player_death" then
        table.insert(KillFeedEntries, {client.GetPlayerNameByUserID( event:GetInt("attacker") ) .. " eliminated " .. client.GetPlayerNameByUserID( event:GetInt("userid") ) .. " with " .. weapons[event:GetString("weapon")],
                                       globals.CurTime() + KillfeedTime})
    end
end )

client.AllowListener( "player_death" )













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

