--cyberpunk 2077 ui
--working on aimware 2021/4/4
--by qi https://aimware.net/forum/user/366789

--region local variable
local globals_FrameCount = globals.FrameCount
local math_max = math.max
local math_min = math.min
local table_insert = table.insert
local math_modf = math.modf
--region end

--region file check and download
local renderer_lib_inspect = false
local imagepack_icons_lib_inspect = false

local function file_inspect(name)
    if name == "libraries/renderer.lua" then
        renderer_lib_inspect = true
    elseif name == "libraries/imagepack_icons.lua" then
        imagepack_icons_lib_inspect = true
    end
end
file.Enumerate(file_inspect)

if not renderer_lib_inspect then
    local function http_renderer(body)
        file.Write("libraries/renderer.lua", body)
    end
    http.Get("https://raw.githubusercontent.com/287871/aimware/renderer/renderer.lua", http_renderer)
elseif not imagepack_icons_lib_inspect then
    local function http_imagepack_icon(body)
        file.Write("libraries/imagepack_icons.lua", body)
    end
    http.Get("https://raw.githubusercontent.com/287871/aimware/renderer/imagepack_icons.lua", http_imagepack_icon)
end
--region end

--region require
local function require(modelname)
    package = package or {}

    package.loaded = package.loaded or {}

    package.loaded[modelname] = package.loaded[modelname] or RunScript(modelname .. ".lua")

    local modelname = package.loaded[modelname] or error("unable to load module " .. modelname, 2)

    return modelname
end

--make a request
--return to table
local renderer = require "libraries/renderer"
local csgo_weapons = require "libraries/imagepack_icons"
--region end

--region mouse drag
local menu = gui.Reference("menu")
local function dragging(parent, varname, base_x, base_y)
    return (function()
        local a = {}
        local b, c, d, e, f, g, h, i, j, k, l, m, n, o
        local p = {
            __index = {
                drag = function(self, ...)
                    local q, r = self:get()
                    local s, t = a.drag(q, r, ...)
                    if q ~= s or r ~= t then
                        self:set(s, t)
                    end
                    return s, t
                end,
                set = function(self, q, r)
                    local j, k = draw.GetScreenSize()
                    self.parent_x:SetValue(q / j * self.res)
                    self.parent_y:SetValue(r / k * self.res)
                end,
                get = function(self)
                    local j, k = draw.GetScreenSize()
                    return self.parent_x:GetValue() / self.res * j, self.parent_y:GetValue() / self.res * k
                end
            }
        }
        function a.new(r, u, v, w, x)
            x = x or 10000
            local j, k = draw.GetScreenSize()
            local y = gui.Slider(r, u .. "x", " position x", v / j * x, 0, x)
            local z = gui.Slider(r, u .. "y", " position y", w / k * x, 0, x)
            y:SetInvisible(true)
            z:SetInvisible(true)
            return setmetatable({parent = r, varname = u, parent_x = y, parent_y = z, res = x}, p)
        end
        function a.drag(q, r, A, B, C, D, E)
            if globals_FrameCount() ~= b then
                c = menu:IsActive()
                f, g = d, e
                d, e = input.GetMousePos()
                i = h
                h = input.IsButtonDown(0x01) == true
                m = l
                l = {}
                o = n
                n = false
                j, k = draw.GetScreenSize()
            end
            if c and i ~= nil then
                if (not i or o) and h and f > q and g > r and f < q + A and g < r + B then
                    n = true
                    q, r = q + d - f, r + e - g
                    if not D then
                        q = math_max(0, math_min(j - A, q))
                        r = math_max(0, math_min(k - B, r))
                    end
                end
            end
            table_insert(l, {q, r, A, B})
            return q, r, A, B
        end
        return a
    end)().new(parent, varname, base_x, base_y)
end

local screen_size = {renderer.screen_size()}
local reference = gui.Reference("visuals", "other", "extra")
local ui_health_armor_dragging = dragging(reference, "cyberpunk_ui.health_armor.", screen_size[1] * 0.25, screen_size[2] * 0.2)
local ui_weapon_dragging = dragging(reference, "cyberpunk_ui.weapon.", screen_size[1] * 0.25, screen_size[2] * 0.25)
--region end

--region load svg
local renderer_load_svg = renderer.load_svg
local load_svg_weapon = {
    [1] = renderer_load_svg(csgo_weapons["deagle"][3], 2),
    [2] = renderer_load_svg(csgo_weapons["elite"][3], 2),
    [3] = renderer_load_svg(csgo_weapons["fiveseven"][3], 2),
    [4] = renderer_load_svg(csgo_weapons["glock"][3], 2),
    [7] = renderer_load_svg(csgo_weapons["ak47"][3], 2),
    [8] = renderer_load_svg(csgo_weapons["aug"][3], 2),
    [9] = renderer_load_svg(csgo_weapons["awp"][3], 2, 2),
    [10] = renderer_load_svg(csgo_weapons["famas"][3], 2),
    [11] = renderer_load_svg(csgo_weapons["g3sg1"][3], 2),
    [13] = renderer_load_svg(csgo_weapons["galilar"][3], 2),
    [14] = renderer_load_svg(csgo_weapons["m249"][3], 2),
    [16] = renderer_load_svg(csgo_weapons["m4a1"][3], 2),
    [17] = renderer_load_svg(csgo_weapons["mac10"][3], 2),
    [19] = renderer_load_svg(csgo_weapons["p90"][3], 2),
    [23] = renderer_load_svg(csgo_weapons["mp5sd"][3], 2),
    [24] = renderer_load_svg(csgo_weapons["ump45"][3], 2),
    [25] = renderer_load_svg(csgo_weapons["xm1014"][3], 2),
    [26] = renderer_load_svg(csgo_weapons["bizon"][3], 2),
    [27] = renderer_load_svg(csgo_weapons["mag7"][3], 2),
    [28] = renderer_load_svg(csgo_weapons["negev"][3], 2),
    [29] = renderer_load_svg(csgo_weapons["sawedoff"][3], 2),
    [30] = renderer_load_svg(csgo_weapons["tec9"][3], 2),
    [31] = renderer_load_svg(csgo_weapons["taser"][3], 2),
    [32] = renderer_load_svg(csgo_weapons["hkp2000"][3], 2),
    [33] = renderer_load_svg(csgo_weapons["mp7"][3], 2),
    [34] = renderer_load_svg(csgo_weapons["mp9"][3], 2),
    [35] = renderer_load_svg(csgo_weapons["nova"][3], 2),
    [36] = renderer_load_svg(csgo_weapons["p250"][3], 2),
    [38] = renderer_load_svg(csgo_weapons["scar20"][3], 2),
    [39] = renderer_load_svg(csgo_weapons["sg556"][3], 2),
    [40] = renderer_load_svg(csgo_weapons["ssg08"][3], 2),
    [41] = renderer_load_svg(csgo_weapons["knifegg"][3], 2),
    [42] = renderer_load_svg(csgo_weapons["knife"][3], 2),
    [43] = renderer_load_svg(csgo_weapons["flashbang"][3], 2),
    [44] = renderer_load_svg(csgo_weapons["hegrenade"][3], 2),
    [45] = renderer_load_svg(csgo_weapons["smokegrenade"][3], 2),
    [46] = renderer_load_svg(csgo_weapons["molotov"][3], 2, 2),
    [47] = renderer_load_svg(csgo_weapons["decoy"][3], 2, 2),
    [48] = renderer_load_svg(csgo_weapons["incgrenade"][3], 2, 2),
    [49] = renderer_load_svg(csgo_weapons["c4"][3], 2),
    [59] = renderer_load_svg(csgo_weapons["knife"][3], 2),
    [60] = renderer_load_svg(csgo_weapons["m4a1_silencer"][3], 2),
    [61] = renderer_load_svg(csgo_weapons["usp_silencer"][3], 2),
    [63] = renderer_load_svg(csgo_weapons["cz75a"][3], 2),
    [64] = renderer_load_svg(csgo_weapons["revolver"][3], 2),
    [500] = renderer_load_svg(csgo_weapons["bayonet"][3], 2),
    [505] = renderer_load_svg(csgo_weapons["knife_flip"][3], 2),
    [506] = renderer_load_svg(csgo_weapons["knife_gut"][3], 2),
    [507] = renderer_load_svg(csgo_weapons["knife_karambit"][3], 2),
    [508] = renderer_load_svg(csgo_weapons["knife_m9_bayonet"][3], 2),
    [509] = renderer_load_svg(csgo_weapons["knife_tactical"][3], 2),
    [512] = renderer_load_svg(csgo_weapons["knife_falchion"][3], 2),
    [514] = renderer_load_svg(csgo_weapons["knife_bowie"][3], 2),
    [515] = renderer_load_svg(csgo_weapons["knife_butterfly"][3], 2),
    [516] = renderer_load_svg(csgo_weapons["knife_push"][3], 2),
    [519] = renderer_load_svg(csgo_weapons["knife_ursus"][3], 2),
    [520] = renderer_load_svg(csgo_weapons["knife_gypsy_jackknife"][3], 2),
    [522] = renderer_load_svg(csgo_weapons["knife_stiletto"][3], 2),
    [523] = renderer_load_svg(csgo_weapons["knife_widowmaker"][3], 2),
    [524] = renderer_load_svg(csgo_weapons["knife_t"][3], 2)
}
--regionend

--region font
local draw_CreateFont = draw.CreateFont
local font = {
    draw_CreateFont("bahnschrift", 25, 800),
    draw_CreateFont("bahnschrift", 19, 800),
    draw_CreateFont("bahnschrift", 17, 800),
    draw_CreateFont("bahnschrift", 33, 800),
    draw_CreateFont("bahnschrift", 29, 800),
    draw_CreateFont("bahnschrift", 16, 800)
}
--regionend

--region event kill count
local kills = {}
local exp_alpha = 0

local function kill_count(event)
    local local_player = client.GetLocalPlayerIndex()
    local attacker_index = client.GetPlayerIndexByUserID(event:GetInt("attacker"))
    local event_name = event:GetName()

    if (event_name == "client_disconnect") or (event_name == "begin_new_match") then
        kills = {}
    end
    if event_name == "player_death" then
        if attacker_index == local_player then
            kills[#kills + 1] = {}
            exp_alpha = 255
        end
    end
end
--regionend

local renderer_rectangle = renderer.rectangle
--region health armor
local function health_armor()
    local lp = entities.GetLocalPlayer()

    if not lp then
        return
    end

    local x, y = ui_health_armor_dragging:get()
    local x, y = math_modf(x), math_modf(y)
    ui_health_armor_dragging:drag(223, 35)

    local health = math_min(100, lp:GetHealth())
    local armor = math_min(100, lp:GetProp("m_ArmorValue"))

    local fade = ((1.0 / 0.15) * globals.FrameTime()) * 250

    if exp_alpha > 1 then
        exp_alpha = exp_alpha - 1
    end

    renderer_rectangle(x + 40, y + 12, 223, 10, 155, 51, 47, 102, "f")
    renderer_rectangle(x + 40, y + 12, (health * 2.23), 10, 234, 89, 82, 102, "f")

    renderer_rectangle(x + 40, y + 6, 223, 3, 47, 81, 79, 102, "f")
    renderer_rectangle(x + 40, y + 6, (armor * 2.23), 3, 139, 200, 191, 102, "f")

    draw.SetFont(font[1])
    draw.Color(222, 79, 70, 102)
    draw.Text(x + 280, y + 13, health)

    draw.SetFont(font[2])
    draw.Color(139, 200, 191, 102)
    draw.Text(x + 320, y + 9, armor)

    renderer_rectangle(x + 4, y + 6, 2, 20, 59, 153, 163, 102, "f")
    renderer_rectangle(x + 32, y + 6, 2, 27, 59, 153, 163, 102, "f")
    renderer_rectangle(x + 6, y + 6, 26, 2, 59, 153, 163, 102, "f")
    renderer_rectangle(x + 16, y + 33, 18, 3, 59, 153, 163, 102, "f")
    renderer.line(x + 4, y + 25, x + 16, y + 34, 59, 153, 163, 102)
    renderer.line(x + 5, y + 26, x + 16, y + 35, 59, 153, 163, 102)

    renderer_rectangle(x + 34, y + 6, (health * 2.23), 10, 234, 89, 82, 255, "f")

    renderer_rectangle(x + 34, y, 223, 3, 47, 81, 79, 255, "f")
    renderer_rectangle(x + 34, y, (armor * 2.23), 3, 139, 200, 191, 255, "f")

    draw.SetFont(font[1])
    draw.Color(222, 79, 70, 255)
    draw.Text(x + 274, y + 7, health)

    draw.SetFont(font[2])
    draw.Color(139, 200, 191, 255)
    draw.Text(x + 314, y + 3, armor)

    renderer_rectangle(x, y, 2, 21, 59, 153, 163, 255, "f")
    renderer_rectangle(x + 26, y, 2, 27, 59, 153, 163, 255, "f")
    renderer_rectangle(x, y, 27, 2, 59, 153, 163, 255, "f")
    renderer_rectangle(x + 10, y + 27, 18, 2, 59, 153, 163, 255, "f")
    renderer.line(x, y + 20, x + 9, y + 28, 59, 153, 163, 255)
    renderer.line(x + 1, y + 20, x + 10, y + 28, 559, 153, 163, 255)

    draw.SetFont(font[3])
    local w = draw.GetTextSize(#kills)
    draw.Color(139, 200, 191, 255)
    draw.Text(x + 14 - math_modf(w * 0.5), y + 5, #kills)

    draw.Color(139, 200, 191, exp_alpha)
    draw.Text(x + 34, y + 21, "You Kill Player! Get 1 Exp!")
end
--regionend

--region weapon
local function weapon()
    local lp = entities.GetLocalPlayer()

    if not (lp and lp:IsAlive()) then
        return
    end

    local x, y = ui_weapon_dragging:get()
    local x, y = math_modf(x), math_modf(y)
    ui_weapon_dragging:drag(300, 60)

    local wid = lp:GetWeaponID()
    local m_hActiveWeapon = lp:GetPropEntity("m_hActiveWeapon")
    local weapon_name = string.match(m_hActiveWeapon:GetName(), [[weapon_(.+)]])

    local ammo = m_hActiveWeapon:GetProp("m_iClip1") or -1
    local ammo = ammo > 0 and ammo or 0
    local reserve = m_hActiveWeapon:GetProp("m_iPrimaryReserveAmmoCount") or 0

    draw.SetFont(font[4])
    draw.Color(85, 226, 236, 102)
    draw.Text(x + 6, y + 4, 00 .. ammo)

    draw.SetFont(font[5])
    draw.Color(240, 91, 82, 102)
    draw.Text(x + 64, y + 4, 00 .. reserve)

    renderer.texture(load_svg_weapon[wid], x + 111, y + 10, csgo_weapons[weapon_name][1] * 1.7, csgo_weapons[weapon_name][2] * 1.7, 240, 91, 82, 102)

    draw.SetFont(font[6])
    draw.Color(240, 91, 82, 102)
    draw.Text(x + 127, y, weapon_name)

    draw.SetFont(font[4])
    draw.Color(85, 226, 236, 255)
    draw.Text(x, y + 10, 00 .. ammo)

    draw.SetFont(font[5])
    draw.Color(240, 91, 82, 255)
    draw.Text(x + 59, y + 10, 00 .. reserve)

    renderer.texture(load_svg_weapon[wid], x + 107, y + 14, csgo_weapons[weapon_name][1] * 1.7, csgo_weapons[weapon_name][2] * 1.7, 240, 91, 82, 255)

    draw.SetFont(font[6])
    draw.Color(240, 91, 82, 255)
    draw.Text(x + 121, y + 4, weapon_name)
end
--regionend

--region event
client.AllowListener("player_death")
client.AllowListener("client_disconnect")
client.AllowListener("begin_new_match")
--regionend

--region callbacks
callbacks.Register("FireGameEvent", kill_count)
callbacks.Register(
    "Draw",
    function()
        health_armor()
        weapon()
    end
)
--regionend






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

