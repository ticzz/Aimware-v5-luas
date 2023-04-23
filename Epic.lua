local XML = gui.XML(file.Read("Epic.xml"))

local Menu = {
    Aimware     = gui.Reference("MENU"),
    Menu        = XML:Children()(),
    Blur        = XML:Reference("DisablePanoramaBlur"),
    DeadEsp     = XML:Reference("EspWhileDead"),
    FakeDuckInd = XML:Reference("FakeDuckIndicator"),
    YawMode     = XML:Reference("AntiAimYawMode"),
    YawMin      = XML:Reference("YawMin"),
    YawMax      = XML:Reference("YawMax"),
    DoorSpamKey = XML:Reference("DoorSpamKeybind"),
    Hitsay      = XML:Reference("Hitsay"),
    DisableSpec = XML:Reference("DisableSpecList"),
    MusicKit    = XML:Reference("MusicKit"),
    HealthShot  = XML:Reference("HealthShot"),
    DisableAA   = XML:Reference("DisableAAOnFreeze"),
    LegitAAOnE  = XML:Reference("LegitAAOnE"),
    Players     = XML:Reference("Players"),
    AirStuck    = XML:Reference("AirStuck"),
    EspToggle    = XML:Reference("EspToggle")
}

local INT_MAX =  2147483647
local INT_MIN = -2147483648
local ScreenX, ScreenY = draw.GetScreenSize()
local UseState      = true
local CycleDir      = true
local Prefix        = {"breathtaking","cool","awesome","ahahahahah that","trash","good","cant tell if u are serious about that","pls give","send selly link for that sick","amazing","fantastic","crazy","interesting","mcdonalds","laughting my ass of that","nice fucking","insane","lidl","sick","astonishing","nice","u sell that","refund that","lol that","shit","xDDDDDDD that","u pay for that","nice pasted","LOL that","top","best","superior","get good get","nice public","nice private","one step ahead of your"}
local Suffix        = {"lagswitch","mother","account","settings","paste","internet","resolver","serverside","imaginary girlfriend","death","kd","keybind","osiris","skeet","vip hack","computer","1","gamingcarpet","negative IQ","config","gamesense","steeringwheel assistence","antiaim","uid issue","visuals","lethality","knifechanger","pasta","brain","cheat","skinchanger","mindmg","miss","baim","onshot","haram","media","safepoints","fanta","toes","IQ"}
local CrouchedTime  = {}
local LastSpecTick  = 0
local Trollface     = http.Get("https://cdn.discordapp.com/attachments/353918280068497418/785591263645663252/hw.svg")
local imgRGBA, imgWidth, imgHeight = common.RasterizeSVG(Trollface)
local texture       = draw.CreateTexture( imgRGBA, imgWidth, imgHeight )
local Trolled       = http.Get("http://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Trollface_non-free.png/220px-Trollface_non-free.png")
local Epicrgba, EpicWidth, EpicHeight = common.DecodePNG(Trolled)
local EpicTexture   = draw.CreateTexture(Epicrgba, EpicWidth, EpicHeight)

Menu.Menu:SetIcon(texture)

local EpicCords = {
    x = 0,
    y = 0,
    DirX = true,
    DirY = true,
    SpeedX = math.random(2,3),
    SpeedY = math.random(2,3)
}
local PlayerList = {
    Names    = {},
    Players  = {},
    Indexes  = {},
    Settings = {}
}

Menu.Menu:SetOpenKey(gui.GetValue("adv.menukey"))

function DisablePanoramaBlur()
    client.SetConVar("@panorama_disable_blur", Menu.Blur:GetValue() and 1 or 0, true)
end

function EspWhileDead() 
    local lp = entities.GetLocalPlayer()
    local EspToggle = Menu.EspToggle
    if not Menu.DeadEsp:GetValue() or not lp then return end
    gui.SetValue("esp.overlay.enemy.box", lp:IsAlive() or EspToggle:GetValue() and 0 or 1)
	gui.SetValue("esp.chams.enemy.occluded", lp:IsAlive() or EspToggle:GetValue() and 0 or 4)
end

function FakeDuckIndicator(esp)
    if not Menu.FakeDuckInd:GetValue() then return end
    local lp = entities.GetLocalPlayer()
    local Entity = esp:GetEntity()
    if not Entity:IsPlayer() or not lp or not Entity:IsAlive() then return end
    local ammount,speed = Entity:GetProp("m_flDuckAmount"), Entity:GetProp("m_flDuckSpeed")
    if speed == 8 and 1 > ammount and ammount > 0 then
        esp:Color(0,255,0,255)
        esp:AddTextTop("Fakeducking")
    end
end

function YawChanger()

end

function DoorSpam()
    if Menu.DoorSpamKey:GetValue() ~= 0 and input.IsButtonDown(Menu.DoorSpamKey:GetValue()) or not UseState then
        if UseState then
            client.Command("+use")
            UseState = false
        else
            client.Command("-use")
            UseState = true
        end
    end
end

function HitSay(e)
    if e:GetName() ~= "player_hurt" or not Menu.Hitsay:GetValue() then return end
    local lp = entities.GetLocalPlayer()
    local attacker = entities.GetByUserID(e:GetInt("attacker"))
    local hurt = entities.GetByUserID("userid")
    if attacker:GetIndex() == lp:GetIndex() and lp:GetIndex() ~= hurt:GetIndex() then
        client.ChatSay(Prefix[math.random(1, #Prefix)] .. " " .. Suffix[math.random(1, #Suffix)])
    end
end

function DisableSpectatorList()
    if not Menu.DisableSpec:GetValue() or not (LastSpecTick < globals.TickCount()) then return end
    LastSpecTick = globals.TickCount()
    local players = entities.FindByClass("CCSPlayer")
    for key, val in pairs(players) do
        if val:GetPropEntity("m_hObserverTarget"):GetIndex() == entities.GetLocalPlayer():GetIndex() then
            gui.SetValue("misc.showspec", true)
            return
        end
    end
    gui.SetValue("misc.showspec", false)
end

function MusicKitChanger()
    if entities.GetLocalPlayer() == nil then return end
    local kit = Menu.MusicKit:GetValue()
    entities.GetPlayerResources():SetPropInt(kit, "m_nMusicID", client.GetLocalPlayerIndex())
end

function HealthShotEffect(e)
    if not Menu.HealthShot:GetValue() then return end
    if e:GetName() ~= "player_death" then return end
    if entities.GetByUserID(e:GetInt("attacker")):GetIndex() ~= client.GetLocalPlayerIndex() then return end
    entities.GetLocalPlayer():SetProp("m_flHealthShotBoostExpirationTime", globals.CurTime() + 1.2)
end

function EpicTrolled()
    local x, y = EpicCords.x, EpicCords.y

    draw.Color(255,255,255,255)
    draw.SetTexture(EpicTexture)
    if Menu.Aimware:IsActive() then draw.FilledRect(x, y, x + EpicWidth, y + EpicWidth) end
    if EpicCords.DirX then
        EpicCords.x = x + EpicCords.SpeedX
    else
        EpicCords.x = x - EpicCords.SpeedX
    end
    if EpicCords.DirY then
        EpicCords.y = y + EpicCords.SpeedY
    else
        EpicCords.y = y - EpicCords.SpeedY
    end
    if EpicCords.DirX and x + EpicWidth > ScreenX then
        EpicCords.DirX = false
        EpicCords.SpeedX = math.random(2,3)
    elseif not EpicCords.DirX and x < 0 then
        EpicCords.DirX = true
        EpicCords.SpeedX = math.random(2,3)
    end
    if EpicCords.DirY and y + EpicHeight > ScreenY then
        EpicCords.DirY = false
        EpicCords.SpeedY = math.random(2,3)
    elseif not EpicCords.DirY and y < 0 then
        EpicCords.DirY = true
        EpicCords.SpeedY = math.random(2,3)
    end
    draw.SetTexture(nil)
end

function AutoStraferFix(cmd)
    local angles = cmd:GetViewAngles()
	angles.z = 0 
	cmd:SetViewAngles(angles)
end

function DisableAAOnFreezeTime(e)
    if not Menu.DisableAA:GetValue() then return end
    if e:GetName() == "round_start" or e:GetName() == "start_halftime" then
        gui.SetValue("rbot.antiaim.enable", 0)
    elseif e:GetName() == "round_freeze_end" then
        gui.SetValue("rbot.antiaim.enable", 1)
    end
end

function LegitAAOnE()
    if not Menu.LegitAAOnE:GetValue() then return end
    if input.IsButtonPressed(69) then
        AACache = {
            Pitch = gui.GetValue("rbot.antiaim.pitchstyle"),
            Yaw = gui.GetValue("rbot.antiaim.yawstyle"),
            Conditions = gui.GetValue("rbot.antiaim.extra.condition")
        }
        gui.SetValue("rbot.antiaim.pitchstyle", 0)
        gui.SetValue("rbot.antiaim.yawstyle", 0)
        gui.SetValue("rbot.antiaim.extra.condition", 0)
    elseif input.IsButtonReleased(69) then
        gui.SetValue("rbot.antiaim.pitchstyle", AACache.Pitch)
        gui.SetValue("rbot.antiaim.yawstyle", AACache.Yaw)
        gui.SetValue("rbot.antiaim.extra.condition", AACache.Conditions)
    end
end

function AirStuck(cmd)
    if Menu.AirStuck:GetValue() ~= 0 and input.IsButtonDown(Menu.AirStuck:GetValue()) then
        cmd.tick_count = 0x7F7FFFFF --INT_MAX
        cmd.command_number = 0x00000 --0
    end
end


--[[                  PlayerList                  ]]--
function CreatePlayersArray()
    local players = entities.FindByClass("CCSPlayer")
    for key, val in pairs(players) do
        if PlayerList.Players[val:GetIndex()] == nil then
            PlayerList.Players[val:GetIndex()] = val
            ShowNamesInMenu()
        end
    end
end

function ShowNamesInMenu()
    PlayerList.Names = {}
    PlayerList.Indexes = {}
    for key, val in pairs(PlayerList.Players) do
        table.insert(PlayerList.Names, val:GetName())
        table.insert(PlayerList.Indexes, val:GetIndex())
    end
    Menu.Players:SetOptions(unpack(PlayerList.Names))
end

function onClientDisconnect()
    PlayerList.Names   = {}
    PlayerList.Players = {}
    PlayerList.Indexes = {}
    Menu.Players:SetOptions("")
end

function PlayerListHandle(esp)
    PlayerList.Settings[Menu.Players:GetValue()+1] = {
        
    }
    local ent = esp:GetEntity()
    if ent:GetIndex() == PlayerList.Indexes[Menu.Players:GetValue()+1] then
        esp:AddTextTop("Sex")
    end    
end



function onDraw()
    DisablePanoramaBlur()
    EspWhileDead()
    DoorSpam()
    DisableSpectatorList()
    MusicKitChanger()
    --EpicTrolled()
    --LegitAAOnE()
    --PlayerListHandle()
    if (Menu.Aimware:IsActive() and not Menu.Menu:IsActive()) or (Menu.Menu:IsActive() and not Menu.Aimware:IsActive()) then
        Menu.Menu:SetActive()
    end
    
end
callbacks.Register("Draw", onDraw)

function onCreateMove(cmd)
    YawChanger()
    AutoStraferFix(cmd)
    --CreatePlayersArray()
    AirStuck(cmd)
end
callbacks.Register("CreateMove", onCreateMove)

function onDrawESP(esp)
    FakeDuckIndicator(esp)
end
callbacks.Register("DrawESP", onDrawESP)

function onFireGameEvent(e)
    HitSay(e)
    HealthShotEffect(e)
    --DisableAAOnFreezeTime(e)
    --onClientDisconnect()
end
callbacks.Register("FireGameEvent", onFireGameEvent)

client.AllowListener("player_death")
client.AllowListener("start_halftime")
client.AllowListener("round_start")
client.AllowListener("round_freeze_end")
client.AllowListener("client_disconnect")