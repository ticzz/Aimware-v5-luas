local mineware_enable_menu = gui.Tab( gui.Reference( "Visuals" ), "lua_mineware_enable_menu", "MINEWARE.net V5" )

local elements_group = gui.Groupbox( mineware_enable_menu, "Settings", 10, 10, 620, 0 )
local hotbar = gui.Checkbox( elements_group, "lua_mineware_enable_hotbar", "Hotbar", false )
local health = gui.Checkbox( elements_group, "lua_mineware_enable_health", "Health Bar", false )
local armor = gui.Checkbox( elements_group, "lua_mineware_enable_armor", "Armor Bar", false )
local hud = gui.Checkbox( elements_group, "lua_mineware_disable_hud", "Disable Default Health HUD", false )
local scale = gui.Slider( elements_group, "lua_mineware_scale", "Hud Scale", 100, 25, 300 )

local mineware_about = gui.Groupbox(mineware_enable_menu, "About MINEWARE", 10, 260, 620, 80)
local mineware_about_text = gui.Text(mineware_about, "Author: Nevvy#0001")
local mineware_about_text2 = gui.Text(mineware_about, "Credits: zReko#1326")
local mineware_about_text2 = gui.Text(mineware_about, "Ported to V5 by: oflavioferreira")

local current_slot = 1
local tick_interval = globals.TickCount()
local get_weapon_slot = {}
local start_delay = false
local localPlayer = nil
local old_hud_state = nil

CreateTexture = draw.CreateTexture
DecodePNG = common.DecodePNG
Get = http.Get

local function loadTexture(url)
    return CreateTexture(DecodePNG(Get(url)))
end

local decode = {
    ["hotbar"] = loadTexture("https://i.imgur.com/vIg33Fr.png"),
    ["hp_100"] = loadTexture("https://i.imgur.com/iZsSAgH.png"),
    ["hp_95"] = loadTexture("https://i.imgur.com/ar21geU.png"),
    ["hp_90"] = loadTexture("https://i.imgur.com/a54z79G.png"),
    ["hp_85"] = loadTexture("https://i.imgur.com/VaCRPap.png"),
    ["hp_80"] = loadTexture("https://i.imgur.com/0R3UlqP.png"),
    ["hp_75"] = loadTexture("https://i.imgur.com/ggTMSg5.png"),
    ["hp_70"] = loadTexture("https://i.imgur.com/7xGr0TE.png"),
    ["hp_65"] = loadTexture("https://i.imgur.com/XzFqfGt.png"),
    ["hp_60"] = loadTexture("https://i.imgur.com/lMSAISA.png"),
    ["hp_55"] = loadTexture("https://i.imgur.com/809kI4d.png"),
    ["hp_50"] = loadTexture("https://i.imgur.com/2UO0Lwf.png"),
    ["hp_45"] = loadTexture("https://i.imgur.com/2j5VI4X.png"),
    ["hp_40"] = loadTexture("https://i.imgur.com/ugi8skL.png"),
    ["hp_35"] = loadTexture("https://i.imgur.com/wwjMlyn.png"),
    ["hp_30"] = loadTexture("https://i.imgur.com/MXi9NGq.png"),
    ["hp_25"] = loadTexture("https://i.imgur.com/X2NkEKw.png"),
    ["hp_20"] = loadTexture("https://i.imgur.com/xVuwcAb.png"),
    ["hp_15"] = loadTexture("https://i.imgur.com/DVnFJgm.png"),
    ["hp_10"] = loadTexture("https://i.imgur.com/WLND2rG.png"),
    ["hp_5"] = loadTexture("https://i.imgur.com/gCXXKWc.png"),
    ["hp_0"] = loadTexture("https://i.imgur.com/9r7Vj1M.png"),
    ["armor_100"] = loadTexture("https://i.imgur.com/gzHGJKC.png"),
    ["armor_95"] = loadTexture("https://i.imgur.com/xKliKl1.png"),
    ["armor_90"] = loadTexture("https://i.imgur.com/zQrE2zJ.png"),
    ["armor_85"] = loadTexture("https://i.imgur.com/KKpJkKP.png"),
    ["armor_80"] = loadTexture("https://i.imgur.com/2K5jz4i.png"),
    ["armor_75"] = loadTexture("https://i.imgur.com/fJHq13N.png"),
    ["armor_70"] = loadTexture("https://i.imgur.com/pF5RPjy.png"),
    ["armor_65"] = loadTexture("https://i.imgur.com/vqi586K.png"),
    ["armor_60"] = loadTexture("https://i.imgur.com/SIxtdLw.png"),
    ["armor_55"] = loadTexture("https://i.imgur.com/hJiNjtc.png"),
    ["armor_50"] = loadTexture("https://i.imgur.com/GBcSA3b.png"),
    ["armor_45"] = loadTexture("https://i.imgur.com/9reT6PD.png"),
    ["armor_40"] = loadTexture("https://i.imgur.com/T78Sd51.png"),
    ["armor_35"] = loadTexture("https://i.imgur.com/ZBPv8hh.png"),
    ["armor_30"] = loadTexture("https://i.imgur.com/0TNTNMe.png"),
    ["armor_25"] = loadTexture("https://i.imgur.com/Q0EywkM.png"),
    ["armor_20"] = loadTexture("https://i.imgur.com/uVDkNTv.png"),
    ["armor_15"] = loadTexture("https://i.imgur.com/yacvgJU.png"),
    ["armor_10"] = loadTexture("https://i.imgur.com/Jk7y2Z4.png"),
    ["armor_5"] = loadTexture("https://i.imgur.com/RCVpxrk.png"),
    ["armor_0"] = loadTexture("https://i.imgur.com/ybzii6k.png"),
    ["slot"] = loadTexture("https://i.imgur.com/IOglVsh.png"),
    ["weapon_usp_silencer"] = loadTexture("https://i.imgur.com/ljm95bT.png"),
    ["weapon_ssg08"] = loadTexture("https://i.imgur.com/CG8EvuY.png"),
    ["weapon_mp7"] = loadTexture("https://i.imgur.com/xjEbexD.png"),
    ["weapon_hkp2000"] = loadTexture("https://i.imgur.com/ObFHnFe.png"),
    ["weapon_nova"] = loadTexture("https://i.imgur.com/Aqfb3AB.png"),
    ["weapon_p250"] = loadTexture("https://i.imgur.com/ja5uTCX.png"),
    ["weapon_cz75a"] = loadTexture("https://i.imgur.com/L3jafED.png"),
    ["weapon_m249"] = loadTexture("https://i.imgur.com/Z849Zy5.png"),
    ["weapon_revolver"] = loadTexture("https://i.imgur.com/S2MjmxD.png"),
    ["weapon_negev"] = loadTexture("https://i.imgur.com/uTy9kzK.png"),
    ["weapon_aug"] = loadTexture("https://i.imgur.com/nFuhsUw.png"),
    ["weapon_g3sg1"] = loadTexture("https://i.imgur.com/nKwyUWr.png"),
    ["weapon_mp5sd"] = loadTexture("https://i.imgur.com/sLGLeaa.png"),
    ["weapon_ump45"] = loadTexture("https://i.imgur.com/WAnwiG3.png"),
    ["weapon_ak47"] = loadTexture("https://i.imgur.com/6doraqS.png"),
    ["weapon_bizon"] = loadTexture("https://i.imgur.com/5MRvVao.png"),
    ["weapon_galilar"] = loadTexture("https://i.imgur.com/dqETtqG.png"),
    ["weapon_sg556"] = loadTexture("https://i.imgur.com/CafTXA8.png"),
    ["weapon_elite"] = loadTexture("https://i.imgur.com/Xxuioex.png"),
    ["weapon_scar20"] = loadTexture("https://i.imgur.com/DJCP5nS.png"),
    ["weapon_famas"] = loadTexture("https://i.imgur.com/tZMSa5T.png"),
    ["weapon_xm1014"] = loadTexture("https://i.imgur.com/uRIcfp4.png"),
    ["weapon_fiveseven"] = loadTexture("https://i.imgur.com/PSSesXt.png"),
    ["weapon_glock"] = loadTexture("https://i.imgur.com/xNkfnjk.png"),
    ["weapon_deagle"] = loadTexture("https://i.imgur.com/96hP2Z3.png"),
    ["weapon_mac10"] = loadTexture("https://i.imgur.com/l58spNS.png"),
    ["weapon_knife"] = loadTexture("https://i.imgur.com/FaUXB7R.png"),
    ["weapon_tec9"] = loadTexture("https://i.imgur.com/3hGEhpQ.png"),
    ["weapon_m4a1"] = loadTexture("https://i.imgur.com/AAqNp7C.png"),
    ["weapon_mag7"] = loadTexture("https://i.imgur.com/gJwkQrZ.png"),
    ["weapon_taser"] = loadTexture("https://i.imgur.com/ZJVLaV4.png"),
    ["weapon_p90"] = loadTexture("https://i.imgur.com/JRNf3H7.png"),
    ["weapon_mp9"] = loadTexture("https://i.imgur.com/rxhi5NH.png"),
    ["weapon_awp"] = loadTexture("https://i.imgur.com/2cKLRTy.png"),
    ["weapon_sawedoff"] = loadTexture("https://i.imgur.com/35CA1R8.png"),
    ["weapon_knife_t"] = loadTexture("https://i.imgur.com/YjDLdEF.png"),
    ["weapon_fists"] = loadTexture("https://i.imgur.com/mVKiivC.png"),
    ["weapon_knife_m9_bayonet"] = loadTexture("https://i.imgur.com/mWr2F5w.png"),
    ["weapon_knife_karambit"] = loadTexture("https://i.imgur.com/ix5dLYU.png"),
    ["weapon_knife_falchion"] = loadTexture("https://i.imgur.com/Ks5av9h.png"),
    ["weapon_knife_flip"] = loadTexture("https://i.imgur.com/hE0Bnxs.png"),
    ["weapon_knife_ursus"] = loadTexture("https://i.imgur.com/mz9kN2d.png"),
    ["weapon_knife_gypsy_jackknife"] = loadTexture("https://i.imgur.com/99QmwLX.png"),
    ["weapon_knife css"] = loadTexture("https://i.imgur.com/lY6PO2r.png"),
    ["weapon_bayonet"] = loadTexture("https://i.imgur.com/OMzfPb7.png"),
    ["weapon_knife_tactical"] = loadTexture("https://i.imgur.com/ixJULFS.png"),
    ["weapon_knife_butterfly"] = loadTexture("https://i.imgur.com/KpbNBHz.png"),
    ["weapon_hammer"] = loadTexture("https://i.imgur.com/kgsiAVI.png"),
    ["weapon_axe"] = loadTexture("https://i.imgur.com/c8yGRDz.png"),
    ["weapon_spanner"] = loadTexture("https://i.imgur.com/aJ8QPDW.png"),
    ["weapon_knife_survival bowie"] = loadTexture("https://i.imgur.com/vCO5cSy.png"),
    ["weapon_knife_stiletto"] = loadTexture("https://i.imgur.com/fvN20CX.png"),
    ["weapon_knife_gut"] = loadTexture("https://i.imgur.com/c5PhyH3.png"),
    ["weapon_knife_push"] = loadTexture("https://i.imgur.com/t1ERZSK.png"),
    ["weapon_knife_widowmaker"] = loadTexture("https://i.imgur.com/ip8a2yf.png"),
    ["weapon_knife_canis"] = loadTexture("https://i.imgur.com/pUdnO2a.png"),
    ["weapon_knife_cord"] = loadTexture("https://i.imgur.com/HhdtriP.png"),
    ["weapon_knife_outdoor"] = loadTexture("https://i.imgur.com/wNDGeQm.png"),
    ["weapon_knife_skeleton"] = loadTexture("https://i.imgur.com/UEyOcnU.png"),
    ["weapon_m4a1_silencer"] = loadTexture("https://i.imgur.com/4zrkB1k.png"),
    ["weapon_hegrenade"] = loadTexture("https://i.imgur.com/GzLR0Eu.png"),
    ["weapon_smokegrenade"] = loadTexture("https://i.imgur.com/cRYOId3.png"),
    ["weapon_flashbang"] = loadTexture("https://i.imgur.com/m9JaDkc.png"),
    ["weapon_molotov"] = loadTexture("https://i.imgur.com/Xv7Mk2Q.png"),
    ["weapon_incgrenade"] = loadTexture("https://i.imgur.com/GjXyiHf.png"),
    ["weapon_decoy"] = loadTexture("https://i.imgur.com/koyF2VN.png"),
    ["weapon_c4"] = loadTexture("https://i.imgur.com/IDPbISq.png")
}

local size = {
    ["hotbar_h"] = 66,
    ["hotbar_w"] = 546,
    ["hotbarslot_h"] = 72,
    ["hotbarslot_w"] = 552,
    ["ibar_h"] = 27,
    ["ibar_w"] = 243,
    ["slot_hw"] = 72,
    ["slot_icn"] = 48,
    ["slotmove"] = 60
}
local weapon_table = {
    {
        "weapon_m4a1",
        "weapon_m4a1_silencer",
        "weapon_ak47",
        "weapon_aug",
        "weapon_awp",
        "weapon_famas",
        "weapon_g3sg1",
        "weapon_galilar",
        "weapon_scar20",
        "weapon_sg556",
        "weapon_ssg08",
        "weapon_bizon",
        "weapon_mac10",
        "weapon_mp7",
        "weapon_mp9",
        "weapon_p90",
        "weapon_ump45",
        "weapon_mp5sd",
        "weapon_m249",
        "weapon_mag7",
        "weapon_negev",
        "weapon_nova",
        "weapon_sawedoff",
        "weapon_xm1014"
    },
    {
        "weapon_usp_silencer",
        "weapon_deagle",
        "weapon_elite",
        "weapon_fiveseven",
        "weapon_glock",
        "weapon_hkp2000",
        "weapon_p250",
        "weapon_tec9",
        "weapon_cz75a",
        "weapon_revolver"
    },
    {
        "weapon_knife",
        "weapon_knife_t",
        "weapon_bayonet",
        "weapon_knife_flip",
        "weapon_knife_gut",
        "weapon_knife_css",
        "weapon_knife_karambit",
        "weapon_knife_m9_bayonet",
        "weapon_knife_tactical",
        "weapon_knife_falchion",
        "weapon_knife_survival_bowie",
        "weapon_knife_butterfly",
        "weapon_knife_push",
        "weapon_knife_ursus",
        "weapon_knife_gypsy_jackknife",
        "weapon_knife_stiletto",
        "weapon_knife_widowmaker",
        "weapon_knife_canis",
        "weapon_knife_cord",
        "weapon_knife_outdoor",
        "weapon_knife_skeleton",
        "weapon_axe",
        "weapon_spanner",
        "weapon_hammer",
        "weapon_fists",
        "weapon_taser"
    },
    {
        "weapon_hegrenade",
        "weapon_smokegrenade",
        "weapon_flashbang",
        "weapon_molotov",
        "weapon_incgrenade",
        "weapon_decoy"
    },
    {
        "weapon_c4"
    }
}
local count = 0
local function get_wep()
    if globals.TickCount() - tick_interval >= 0 and start_delay == true then
        get_weapon_slot = {}
        count = 0
        for i = 0, 8, 1 do
            for ii, v in pairs(weapon_table) do
                for iii, vv in pairs(v) do
                    local my_wep = localPlayer:GetPropEntity("m_hMyWeapons", "00" .. i)
                    if my_wep ~= nil and my_wep:GetName() == vv then
                        if ii == 4 then
                            count = count + 1
                        end
                        local info = {vv, ii, count}
                        table.insert(get_weapon_slot, info)
                    end
                end
            end
        end
        for ii, v in pairs(weapon_table) do
            for _, vv in pairs(v) do
                local active_wpn_ent = localPlayer:GetPropEntity("m_hActiveWeapon")
                if active_wpn_ent ~= nil and active_wpn_ent:GetName():gsub(' %b()', '') == vv then
                    current_slot = ii
                end
            end
        end
        start_delay = false
    end
end
local function get_stuff()
    start_delay = true
    tick_interval = globals.TickCount()
end
local function slot_manager(Event)
    if (Event:GetName() == "item_equip" or Event:GetName() == "item_pickup") then
        get_stuff()
    end
end
local function mineware()
    ---window_manage()
    if entities.GetLocalPlayer() == nil then
        return
    end
    localPlayer = entities.GetLocalPlayer()
    if not localPlayer:IsAlive() then
        return
    end
    local w, h = draw.GetScreenSize()
    local hud_scale = scale:GetValue() / 100
    local mc_hud = hud:GetValue()
    local mc_hud_hotbar = hotbar:GetValue()
    local mc_hud_health = health:GetValue()
    local mc_hud_armor = armor:GetValue()
    if mc_hud_hotbar then
        local x = w / 2 - (size.hotbar_w * hud_scale) / 2
        local y = h - (size.hotbar_h * hud_scale) * 1.04
        draw.SetTexture(decode.hotbar)
        draw.FilledRect(x, y, x + (size.hotbar_w * hud_scale), y + (size.hotbar_h * hud_scale))
    end

    if mc_hud_health then
        local health = localPlayer:GetHealth()
        if health >= 100 then
            health = 100
        end
        local calc_health = math.floor(health / 5) * 5
        local x = w / 2 - (size.hotbar_w * hud_scale) / 2
        local y = h - (size.hotbar_h * hud_scale) * 1.55
        draw.SetTexture(decode["hp_" .. calc_health])
        draw.FilledRect(x, y, x + (size.ibar_w * hud_scale), y + (size.ibar_h * hud_scale))
    end

    if mc_hud_armor then
        local armor = localPlayer:GetProp("m_ArmorValue")
        if armor >= 100 then
            armor = 100
        end
        local calc_armor = math.floor(armor / 5) * 5
        local x = w / 2 + (size.hotbar_w * hud_scale) / 2 - (size.ibar_w * hud_scale)
        local y = h - (size.hotbar_h * hud_scale) * 1.55
        draw.SetTexture(decode["armor_" .. calc_armor])
        draw.FilledRect(x, y, x + (size.ibar_w * hud_scale), y + (size.ibar_h * hud_scale))
    end

    if mc_hud_hotbar then
        local count_same = 0
        local x = w / 2 - (size.hotbarslot_w * hud_scale) / 2 + (size.slotmove * hud_scale) * (current_slot - 1)
        local y = h - (size.hotbarslot_h * hud_scale)
        draw.SetTexture(decode.slot)
        draw.FilledRect(x, y, x + (size.slot_hw * hud_scale), y + (size.slot_hw * hud_scale))
        for i, v in pairs(get_weapon_slot) do
            if v[2] == 4 then
                count_same = count_same + 1
            end
            local x = w / 2 - (size.hotbarslot_w * hud_scale) / 2 + (size.slotmove * hud_scale) * (v[2] - 1)
            local y = h - (size.hotbarslot_h * hud_scale)
            --draw.TextShadow(255,255+(10*i),v[1])
            if decode[v[1]] ~= nil then
                draw.SetTexture(decode[v[1]])
                local x_left = x + 12 * hud_scale
                local y_top = y + 12 * hud_scale
                local x_right = x + 60 * hud_scale
                local y_bottom = y + 60 * hud_scale
                if count > 1 then
                    if count_same == 1 and v[2] == 4 then
                        x_left = x + 12 * hud_scale
                        y_top = y + 12 * hud_scale
                        x_right = x + 36 * hud_scale
                        y_bottom = y + 36 * hud_scale
                    elseif count_same == 2 and v[2] == 4 then
                        x_left = x + 36 * hud_scale
                        y_top = y + 12 * hud_scale
                        x_right = x + 60 * hud_scale
                        y_bottom = y + 36 * hud_scale
                    elseif count_same == 3 and v[2] == 4 then
                        x_left = x + 12 * hud_scale
                        y_top = y + 35 * hud_scale
                        x_right = x + 36 * hud_scale
                        y_bottom = y + 60 * hud_scale
                    elseif count_same == 4 and v[2] == 4 then
                        x_left = x + 36 * hud_scale
                        y_top = y + 36 * hud_scale
                        x_right = x + 60 * hud_scale
                        y_bottom = y + 60 * hud_scale
                    end
                end
                if v[1] == "weapon_taser" then
                    x_left = x + 36 * hud_scale
                    y_top = y + 36 * hud_scale
                    x_right = x + 60 * hud_scale
                    y_bottom = y + 60 * hud_scale
                end
                draw.Color(255,255,255,255)
                draw.FilledRect(x_left, y_top, x_right, y_bottom)
            end
        end
    end
    get_wep()
    if mc_hud and mc_hud ~= old_hud_state then
        client.SetConVar("hidehud", 8, true)
    elseif not mc_hud and mc_hud ~= old_hud_state then
        client.SetConVar("hidehud", 0, true)
    end
    old_hud_state = mc_hud
end
get_stuff()
client.AllowListener("item_equip")
client.AllowListener("item_pickup")
callbacks.Register("FireGameEvent", "slot_manager", slot_manager)
callbacks.Register("Draw", "lua_mineware", mineware)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

