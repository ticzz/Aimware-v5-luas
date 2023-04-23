local a = gui.Tab(gui.Reference("MISC"), "improvments", "Autobuy and fixes")
local b = {
    {"SCAR 20 | G3SG1", "scar20"},
    {"SG 008", "ssg08"},
    {"AWP", "awp"},
    {"G3 SG1 | AUG", "sg556"},
    {"AK 47 | M4A1", "ak47"}
}
local c = {
    {"Dual Elites", "elite"},
    {"Desert Eagle | R8 Revolver", "deagle"},
    {"Five Seven | Tec 9", "tec9"},
    {"P250", "p250"}
}
local d = {{"None", nil, nil}, {"Kevlar Vest", "vest", nil}, {"Kevlar Vest + Helmet", "vest", "vesthelm"}}
local e = {
    {"Off", nil, nil},
    {"Grenade", "hegrenade", nil},
    {"Flashbang", "flashbang", nil},
    {"Smoke Grenade", "smokegrenade", nil},
    {"Decoy Grenade", "decoy", nil},
    {"Molotov | Incindiary Grenade", "molotov", "incgrenade"}
}
local f = gui.Groupbox(a, "Settings", 15, 15, 600, 600)
local g = gui.Checkbox(f, "autobuy.active", "Enable Auto Buy", false)
local h = gui.Checkbox(f, "autobuy.printlogs", "Print Logs To Aimware Console", false)
local i = gui.Combobox(f, "autobuy.primary", "Primary Weapon", b[1][1], b[2][1], b[3][1], b[4][1], b[5][1])
local j = gui.Combobox(f, "autobuy.secondary", "Secondary Weapon", c[1][1], c[2][1], c[3][1], c[4][1])
local k = gui.Combobox(f, "autobuy.armor", "Armor", d[1][1], d[2][1], d[3][1])
local l = gui.Combobox(f, "autobuy.grenade1", "Grenade Slot #1", e[1][1], e[2][1], e[3][1], e[4][1], e[5][1], e[6][1])
local m = gui.Combobox(f, "autobuy.grenade2", "Grenade Slot #2", e[1][1], e[2][1], e[3][1], e[4][1], e[5][1], e[6][1])
local n = gui.Combobox(f, "autobuy.grenade3", "Grenade Slot #3", e[1][1], e[2][1], e[3][1], e[4][1], e[5][1], e[6][1])
local o = gui.Combobox(f, "autobuy.grenade4", "Grenade Slot #4", e[1][1], e[2][1], e[3][1], e[4][1], e[5][1], e[6][1])
local p = gui.Checkbox(f, "autobuy.taser", "Buy Taser", false)
local q = gui.Checkbox(f, "autobuy.defuser", "Buy Defuse Kit", false)
gui.Text(f, "Auto Buy - Made By Rab(SamzSakerz#4758) ported by Clipper(superyu'#7167)")
local function r(s)
    if s == nil then
        return
    end
    if printLogs then
        print("Bought x1 " .. s)
    end
    client.Command('buy "' .. s .. '";', true)
end
local function t(u)
    for v, w in pairs(u) do
        r(w)
    end
end
local function x(y, u)
    local y = y:GetValue()
    local z = u[y + 1][2]
    r(z)
end
local function A(B)
    for C, y in pairs(B) do
        local y = y:GetValue()
        local D = e[y + 1]
        t({D[2], D[3]})
    end
end
callbacks.Register(
    "FireGameEvent",
    function(E)
        if g:GetValue() ~= true then
            return
        end
        local F = entities.GetLocalPlayer()
        local G = E:GetName()
        if F == nil or G ~= "player_spawn" then
            return
        end
        local H = client.GetPlayerIndexByUserID(E:GetInt("userid"))
        local I = F:GetIndex()
        if H ~= I then
            return
        end
        x(i, b)
        x(j, c)
        local J = k:GetValue()
        local K = d[J + 1]
        t({K[2], K[3]})
        if q:GetValue() then
            r("defuser")
        end
        if p:GetValue() then
            r("taser")
        end
        A({l, m, n, o})
    end
)
client.AllowListener("player_spawn")








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

