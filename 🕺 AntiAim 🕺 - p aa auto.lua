local miscRef = gui.Reference("RAGEBOT")
local privateAA = gui.Tab(miscRef, "privateAA", "privateAA")
local gb_main = gui.Groupbox(privateAA, "Main", 16, 16, 296, 400);
local enabled = gui.Checkbox(gb_main, "enabled", "Enabled", 0);
local miscGroup = gui.Groupbox(privateAA, "AA Settings", 16,116,296,100)
local miscGroup2 = gui.Groupbox(privateAA, "Misc Settings", 328,16,296,100)


local lagSyncCheckBox2 = gui.Checkbox(miscGroup, "lagsync2", "HVH", false)
local idealTickCheckBox = gui.Checkbox(miscGroup, "idealTick", "Ideal Tick", false)
local idealTickMinDmg = gui.Slider(miscGroup, "idealTickMinDmg", "idealTick Min Dmg", 1, 1, 130)

local engineGrenadePred = gui.Checkbox(miscGroup2, "grenPred", "Engine Grenade Prediction", false)



local devMode = "[DEV]"
local userName = client.GetConVar( "name" )
local indFont = draw.CreateFont(Verdana, 26, 800)

local function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function draw.Rect(x,y,w,h)
    draw.FilledRect(x,y, x + w, y + h)
end

local function Getserver()
    if (engine.GetServerIP() == "loopback") then return "Local Server" 
    elseif (engine.GetServerIP() == nil) then return "Main Menu"
    else return engine.GetServerIP();        
    end
end

cache = {}


--[[idealTick Start]]--

cache2 = {}
local function cache_fn()
    cache2.scoutMinDmg = gui.GetValue("rbot.hitscan.accuracy.scout.mindamage")
    cache2.awpMinDmg = gui.GetValue("rbot.hitscan.accuracy.sniper.mindamage")
    cache2.hpistolMinDmg = gui.GetValue("rbot.hitscan.accuracy.hpistol.mindamage")
    cache2.fakeLatency = gui.GetValue("misc.fakelatency.enable")
    cache2.fakeLatencyAmount = gui.GetValue("misc.fakelatency.amount")
    cache2.fakeLag = gui.GetValue("misc.fakelag.enable")
    cache2.fakeLagAmount = gui.GetValue("misc.fakelag.factor")
end

cache_fn()

local overriden = false
local manaully_changing = false

function idealTick()
    local quickPeakKey = gui.GetValue("rbot.accuracy.movement.autopeekkey")
	if enabled:GetValue() and quickPeakKey ~= 0 and input.IsButtonDown(quickPeakKey) and not overriden and idealTickCheckBox:GetValue() then
        gui.SetValue("misc.fakelatency.enable", true)
        gui.SetValue("misc.fakelatency.amount", 100)
        gui.SetValue("misc.fakelag.enable", false)
        gui.SetValue("misc.fakelag.factor", 1)
        gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 2)
        gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 2)
        gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 2)
        gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", idealTickMinDmg:GetValue())
        gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", idealTickMinDmg:GetValue())
        gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", idealTickMinDmg:GetValue())
        overriden = true
		manaully_changing = true
	end
	
	if enabled:GetValue() and quickPeakKey ~= 0 and input.IsButtonReleased(quickPeakKey) and overriden then
        gui.SetValue("misc.fakelatency.enable", cache2.fakeLatency)
        gui.SetValue("misc.fakelatency.amount", cache2.fakeLatencyAmount)
        gui.SetValue("misc.fakelag.enable", cache2.fakeLag)
        gui.SetValue("misc.fakelag.factor", cache2.fakeLagAmount)
        gui.SetValue("rbot.hitscan.accuracy.sniper.doublefire", 0)
        gui.SetValue("rbot.hitscan.accuracy.scout.doublefire", 0)
        gui.SetValue("rbot.hitscan.accuracy.hpistol.doublefire", 0)
        gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", cache2.scoutMinDmg)
        gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", cache2.awpMinDmg)
        gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", cache2.hpistolMinDmg)
		overriden = false
		manaully_changing = false
	end
	
	if not manaully_changing then
		cache_fn()
	end
	
end

--[[idealTick End]]--




--[[lagSync2 Start]]--

local function HVH()
    if enabled:GetValue() and lagSyncCheckBox2:GetValue() == true then  
if globals.TickCount() % 4 == 0 then        
gui.SetValue("rbot.antiaim.base", 180)
        
        gui.SetValue("rbot.antiaim.base.rotation", (math.random(1, 2) * 19 * (math.random(0, 1) * 2 - 1)))
        end 
else
        return
    end
end

--[[lagSync2 End]]--



--[[GRENADE PRED START]]--
local function engineNadePred()
    if enabled:GetValue() and engineGrenadePred:GetValue() == true then
        if gui.GetValue("esp.world.nadetracer.local") == true then
            gui.SetValue("esp.world.nadetracer.local", 0)
            client.SetConVar("cl_grenadepreview", 1, 1)
        else
            client.SetConVar("cl_grenadepreview", 1, 1)
        end
    else
        client.SetConVar("cl_grenadepreview", 0, 1)
    end
end
--[[GRENADE PRED END]]--






callbacks.Register("Draw", HVH)
callbacks.Register("Draw", idealTick)
callbacks.Register("Draw", engineNadePred)

callbacks.Register("FireGameEvent", "nadePredict", engineNadePred)





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")