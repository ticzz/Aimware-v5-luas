-- NameStealer Plus by stacky

local pNames = {}
local time = globals.CurTime()
local lastCycle = globals.CurTime()
local cycleIterator = 1
local before = ""
local originalName = client.GetConVar("name")
local function silent2() if globals.CurTime() >= time + 0.1 then client.SetConVar("name", before) else silent2() end end
local ref = gui.Reference("Misc")
local WINDOW = gui.Tab(ref, "namestealerplustab", "NameStealer Plus")

local NAMESTEALER_GBOX = gui.Groupbox( WINDOW, "Name Stealer", 10, 10, 250, 0 )
NAMESTEALER_GBOX:SetWidth(200)
local NAMESTEALER_PLAYERS = gui.Combobox( NAMESTEALER_GBOX, "namestealer.players", "Players", "" )
local NAMESTEALER_STEAL = gui.Button( NAMESTEALER_GBOX, "Steal Name", function() client.SetConVar("name", pNames[NAMESTEALER_PLAYERS:GetValue() + 1] .. "­­") end )

local CUSTOMNAME_GBOX = gui.Groupbox( WINDOW, "Custom Name", 10, 170, 250, 0 )
CUSTOMNAME_GBOX:SetWidth(200)
local CUSTOMNAME_NAME = gui.Editbox( CUSTOMNAME_GBOX, "namestealer.name", "Name" )
local CUSTOMNAME_CHANGE = gui.Button( CUSTOMNAME_GBOX, "Change Name", function() client.SetConVar("name", CUSTOMNAME_NAME:GetValue() .. "­­") end )

local OTHER_GBOX = gui.Groupbox( WINDOW, "Other", 10, 330, 250, 0 )
OTHER_GBOX:SetWidth(200)
OTHER_GBOX:SetPosX(220)
OTHER_GBOX:SetPosY(10)
local OTHER_MAKESILENT = gui.Button( OTHER_GBOX, "Silent Change", function() 
    before = client.GetConVar("name")
    client.SetConVar("name", "\n\xAD\xAD\xAD\xAD") 
    time = globals.CurTime()
    silent2()
end )
local OTHER_RESET = gui.Button( OTHER_GBOX, "Reset Name", function()
    client.SetConVar("name", originalName) 
end )
local OTHER_CYCLE = gui.Checkbox( OTHER_GBOX, "other.cycle", "Cycle Names", false )
local OTHER_CYCLEINTERVAL = gui.Slider( OTHER_GBOX, "other.cycleinterval", "Cycle Interval in Seconds", 1, 0, 10, 0.5 )

callbacks.Register( "Draw", function()
    WINDOW:SetActive(gui.Reference("Menu"):IsActive())
    OTHER_CYCLEINTERVAL:SetInvisible(not OTHER_CYCLE:GetValue())
    
    if OTHER_CYCLE:GetValue() then
        if globals.CurTime() - OTHER_CYCLEINTERVAL:GetValue() >= lastCycle then
            client.SetConVar("name", pNames[cycleIterator]) 
            lastCycle = globals.CurTime()
            cycleIterator = cycleIterator + 1
            if cycleIterator > table.getn(pNames) then cycleIterator = 0 end
        end
    end
end )

callbacks.Register( "CreateMove", function()
    local players = entities.FindByClass("CCSPlayer")
    pNames = {}
    for i = 1, #players do table.insert(pNames, players[i]:GetName() .. "­­") end
    NAMESTEALER_PLAYERS:SetOptions(unpack(pNames))
	end)