------------------------------------------Credits-------------------------------------------
--                             Holo Weapon Panel made by GLadiator                                
--                    Current weapon group from Chieftain by GLadiator
--	                   GradientRectV and GradientRectH by 2878713023 				        
--                            Drag and pos.save by 2878713023                               
--                                   LC ind.by Clipper                                      
------------------------------------------Credits-------------------------------------------



local math_floor, math_sqrt, string_lower, string_format
=
    math.floor, math.sqrt, string.lower, string.format
;

local draw_CreateFont, draw_SetFont, draw_GetTextSize, draw_Color, draw_Text, draw_Line, draw_CreateTexture, draw_SetTexture, draw_FilledRect, common_RasterizeSVG
= 
    draw.CreateFont, draw.SetFont, draw.GetTextSize, draw.Color, draw.Text, draw.Line, draw.CreateTexture, draw.SetTexture, draw.FilledRect, common.RasterizeSVG
; 

local entities_GetLocalPlayer, client_WorldToScreen, globals_CurTime, globals_RealTime, engine_GetServerIP
=
    entities.GetLocalPlayer, client.WorldToScreen, globals.CurTime, globals.RealTime, engine.GetServerIP
;

local input_IsButtonDown, input_GetMousePos, gui_GetValue, gui_Reference
=
    input.IsButtonDown, input.GetMousePos, gui.GetValue, gui.Reference
;

local WEAPONID_PISTOLS          = { 2, 3, 4, 30, 32, 36, 61, 63 }
local WEAPONID_HEAVYPISTOLS     = { 1, 64 }
local WEAPONID_SUBMACHINEGUNS   = { 17, 19, 23, 24, 26, 33, 34 }
local WEAPONID_RIFLES           = { 7, 8, 10, 13, 16, 39, 60 }
local WEAPONID_SHOTGUNS         = { 25, 27, 29, 35 }
local WEAPONID_SCOUT            = { 40 }
local WEAPONID_AUTOSNIPERS      = { 11, 38 }
local WEAPONID_SNIPER           = { 9 }
local WEAPONID_LIGHTMACHINEGUNS = { 14, 28 }
local WEAPONID_KNIFES           = { 41, 42, 59, 69, 74, 75, 76, 78, 500, 503, 505, 506, 507, 508, 509, 512, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 525 }
local WEAPONID_ALLWEAPONS       = { WEAPONID_PISTOLS, WEAPONID_HEAVYPISTOLS, WEAPONID_SUBMACHINEGUNS, WEAPONID_RIFLES, WEAPONID_SHOTGUNS, WEAPONID_SCOUT, WEAPONID_AUTOSNIPERS, WEAPONID_SNIPER, WEAPONID_LIGHTMACHINEGUNS, WEAPONID_KNIFES }
local WEAPON_GROUPS_NAME        = { 'PISTOL', 'HPISTOL', 'SMG', 'RIFLE', 'SHOTGUN', 'SCOUT', 'ASNIPER', 'SNIPER', 'LMG', 'KNIFE' }
local WEAPON_CURRENT_GROUP      = 'GLOBAL'

local function lp_weapon_id(WEAPONID)
    for k, v in pairs(WEAPONID) do
        if entities_GetLocalPlayer():GetWeaponID() == WEAPONID[k] then
            return true
        end
    end
end

callbacks.Register('Draw', 'current_weapon_group', function()
    if not engine_GetServerIP() or engine_GetServerIP() then
        if entities_GetLocalPlayer() then
            if not entities_GetLocalPlayer():IsAlive() then
                return
            end
        else
            return
        end
    end
    
    --Iterate through all weapon groups.
    for k, v in pairs(WEAPON_GROUPS_NAME) do
        --If the ID of the current weapon is not equal to one of the ID table, then set the 'global' group in the menu.
        if not lp_weapon_id(WEAPONID_ALLWEAPONS) then
            WEAPON_CURRENT_GROUP = 'GLOBAL'
        end
        --Iterate through all weapons id
        for k, v in pairs(WEAPONID_ALLWEAPONS) do
            --If the current weapon ID matches the key from all weapon IDs, then save the current weapon group from the key of all group names.
            if lp_weapon_id(WEAPONID_ALLWEAPONS[k]) then
                WEAPON_CURRENT_GROUP = WEAPON_GROUPS_NAME[k]
            end
        end
    end
end)

local RAGEBOT_TAB                     = gui_Reference('Ragebot', 'Aimbot')

local WEAPON_INFO_SUBTAB              = gui.Groupbox(RAGEBOT_TAB, 'Visuals', 16, 376, 296, 1)

local WEAPON_INFO_MULTIBOX            = gui.Multibox(WEAPON_INFO_SUBTAB, 'Weapon info')
local WEAPON_INFO_FIRSTPERSON         = gui.Checkbox(WEAPON_INFO_MULTIBOX, 'wpninfo.firstperson', 'First person', false)
local WEAPON_INFO_THIRDPERSON         = gui.Checkbox(WEAPON_INFO_MULTIBOX, 'wpninfo.thirdperson', 'Third person', false)
local WEAPON_INFO_RAINBOW             = gui.Checkbox(WEAPON_INFO_MULTIBOX, 'wpninfo.rainbow', 'LGBTQ+ Mode', false)
local WEAPON_INFO_BACKGROUND_CLR      = gui.ColorPicker(WEAPON_INFO_RAINBOW, 'wpninfo.backgroundclr', 'Background firstperson color', 0, 0, 0, 70)
local WEAPON_INFO_GENERAL_CLR         = gui.ColorPicker(WEAPON_INFO_RAINBOW, 'wpninfo.generalclr', 'General firstperson color', 255, 255, 255, 255)
local WEAPON_INFO_WARNINGGREEN_CLR    = gui.ColorPicker(WEAPON_INFO_RAINBOW, 'wpninfo.warninggreenclr', 'Warning green firstperson color', 0, 255, 0, 255)
local WEAPON_INFO_WARNINGRED_CLR      = gui.ColorPicker(WEAPON_INFO_RAINBOW, 'wpninfo.warningredclr', 'Warning red firstperson color', 255, 0, 0, 255)
local WEAPON_INFO_WARNINGYELLOW_CLR   = gui.ColorPicker(WEAPON_INFO_RAINBOW, 'wpninfo.warningyellowclr', 'Warning yellow thirdperson color', 255, 255, 0, 255)
local WEAPON_INFO_THIRDPERSON_POS     = gui.Combobox(WEAPON_INFO_SUBTAB, 'wpninfo.thirdperson.pos', 'Third person position', 'Weapon', 'Body')
local WEAPON_INFO_FIRSTPERSON_X       = gui.Slider(WEAPON_INFO_SUBTAB, 'wpninfo.firsperson.x', 'x', 500, 0, 10000, 1)
local WEAPON_INFO_FIRSTPERSON_Y       = gui.Slider(WEAPON_INFO_SUBTAB, 'wpninfo.firsperson.y', 'y', 300, 0, 10000, 1)
WEAPON_INFO_FIRSTPERSON_X:SetInvisible(true)
WEAPON_INFO_FIRSTPERSON_Y:SetInvisible(true)
WEAPON_INFO_MULTIBOX:SetDescription('Displays information about weapon and anti-aims.')
WEAPON_INFO_FIRSTPERSON:SetDescription('Displays weapon info in first person view.')
WEAPON_INFO_THIRDPERSON:SetDescription('Displays weapon info in third person view.')
WEAPON_INFO_RAINBOW:SetDescription('Turns on the fagot colors mode.')
WEAPON_INFO_THIRDPERSON_POS:SetDescription('Select the position where the weapon info will be located.')


local SHIFTED_TICKS = 0
local originRecords = {}

local function to_int(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

local function is_inside(vec_x, vec_y, x, y, w, h)
    return vec_x >= x and vec_x <= w and vec_y >= y and vec_y <= h
end

local weaponinfo_pos_x, weaponinfo_pos_y, weaponinfo_offset_x, weaponinfo_offset_y, weaponinfo_drag
local function drag_indicator(x, y, w, h)
    if not gui_Reference('Menu'):IsActive() then
        return weaponinfo_pos_x, weaponinfo_pos_y
    end
    local mouse_down = input_IsButtonDown(1)
    if mouse_down then
        local mouse_x, mouse_y = input_GetMousePos()
        if not weaponinfo_drag then
            local w, h = x + w, y + h
            if is_inside(mouse_x, mouse_y, x, y, w, h) then
                weaponinfo_offset_x = mouse_x - x
                weaponinfo_offset_y = mouse_y - y
                weaponinfo_drag = true
            end
        else
            weaponinfo_pos_x = mouse_x - weaponinfo_offset_x
            weaponinfo_pos_y = mouse_y - weaponinfo_offset_y
            WEAPON_INFO_FIRSTPERSON_X:SetValue(weaponinfo_pos_x)
            WEAPON_INFO_FIRSTPERSON_Y:SetValue(weaponinfo_pos_y)
        end
    else
        weaponinfo_drag = false
    end
    return weaponinfo_pos_x, weaponinfo_pos_y
end

local function position_save()
    if weaponinfo_pos_x ~= WEAPON_INFO_FIRSTPERSON_X:GetValue() or weaponinfo_pos_y ~= WEAPON_INFO_FIRSTPERSON_Y:GetValue() then
        weaponinfo_pos_x = WEAPON_INFO_FIRSTPERSON_X:GetValue()
        weaponinfo_pos_y = WEAPON_INFO_FIRSTPERSON_Y:GetValue()
    end
end

local function HSVtoRGB(h, s, v, a)
    local r, g, b
  
    local i = math_floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
  
    i = i % 6
  
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
  
    return r * 255, g * 255, b * 255, a * 255
end

local function draw_TextOutlined(x, y, text, color, font)
    draw_SetFont(font)
    draw_Color(0, 0, 0, 255)

    draw_Text(x - 1, y - 1, text)
    draw_Text(x - 1, y, text)

    draw_Text(x - 1, y + 1, text)
    draw_Text(x, y + 1, text)

    draw_Text(x, y - 1, text)
    draw_Text(x + 1, y - 1, text)

    draw_Text(x + 1, y, text)
    draw_Text(x + 1, y + 1, text)

    draw_Color(color[1], color[2], color[3], color[4])

    draw_Text(x, y, text)
end

local gradient_texture_b = draw_CreateTexture(common_RasterizeSVG([[<defs><linearGradient id="c" x1="0%" y1="100%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#c)" /></svg>]]))
local function draw_GradientRectV(x1, y1, x2, y2, color1, color2)
    local r, g, b, a = color2[1], color2[2], color2[3], color2[4]
    local r2, g2, b2, a2 = color1[1], color1[2], color1[3], color1[4]

    local t = (a ~= 255 or a2 ~= 255)
    draw_Color(r, g, b, a)
    draw_SetTexture(t and gradient_texture_b or nil)
    draw_FilledRect(x1, y1, x2, y2)

    draw_Color(r2, g2, b2, a2)
    local set_texture = not t and draw_SetTexture(draw_CreateTexture(gradient_texture_b))
    draw_FilledRect(x1, y1, x2, y2)
    draw_SetTexture(nil)
end

local function draw_GradientRectH(x, y, w, h, clr, clr1)
    local r, g, b, a = clr1[1], clr1[2], clr1[3], clr1[4]
    local r1, g1, b1, a1 = clr[1], clr[2], clr[3], clr[4]

    if a and a1 == nil then
        a, a1 = 255, 255
    end

    if clr[4] ~= 0 then
        if a1 and a ~= 255 then
            for i = 0, w do
                local a2 = i / w * a1
                draw_Color(r1, g1, b1, a2)
                draw_FilledRect(x + w - i, y, x + w - i + 1, y + h)
            end
        else
            draw_Color(r1, g1, b1, a1)
            draw_FilledRect(x, y, x + w, y + h)
        end
    end
    if a2 ~= 0 then
        for i = 0, w do
            local a2 = i / w * a
            draw_Color(r, g, b, a2)
            draw_FilledRect(x + i, y, x + i + 1, y + h)
        end
    end
    a, a1 = nil, nil
end


local function lc_status_and_shitftedticks(UserCmd)
    if UserCmd.sendpacket then
        table.insert(originRecords, entities_GetLocalPlayer():GetAbsOrigin())
    end

    if gui_GetValue('rbot.antiaim.advanced.antialign') == 0 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') > 1 then
            SHIFTED_TICKS = (gui_Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks'):GetValue() - (gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') - 1) - 2)
        else
            SHIFTED_TICKS = (gui_Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks'):GetValue() - 2)
        end
    else
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') > 1 then
            SHIFTED_TICKS = (gui_Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks'):GetValue() - (gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefirefl') - 1) - 1)
        else
            SHIFTED_TICKS = (gui_Reference('Misc', 'General', 'Server', 'sv_maxusrcmdprocessticks'):GetValue() - 1)
        end
    end
end

local font = draw_CreateFont("Mini 7 Condensed", 10, 400)

local function weaponinfo_draw(x, y, r, g, b, a)
    local pos_x_start, pos_y_start = to_int(x), to_int(y)

    if WEAPON_INFO_THIRDPERSON:GetValue() and gui_GetValue('esp.local.thirdperson') then
        if WEAPON_INFO_THIRDPERSON_POS:GetValue() == 0 then
            pos_x_start = to_int(x - 200)
        else
            pos_x_start = to_int(x - 250)
        end

        --LINE
        draw_Color(WEAPON_INFO_BACKGROUND_CLR:GetValue())
        draw_Line(pos_x_start + 150, pos_y_start + 33, x, y)
    end

    draw_SetFont(font)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --BACKGROUND
    draw_Color(WEAPON_INFO_BACKGROUND_CLR:GetValue())
    draw_FilledRect(pos_x_start, pos_y_start, pos_x_start + 150, pos_y_start + 67)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --WEAPON INFO TEXT
    draw_TextOutlined(pos_x_start + 2, pos_y_start + 2, "WEAPON INFO: " .. string_lower(WEAPON_CURRENT_GROUP), { r, g, b, a }, font)

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --NICKNAME
    if draw_GetTextSize(cheat.GetUserName()) < 50 then
        draw_TextOutlined(pos_x_start + 148 - draw_GetTextSize(cheat.GetUserName()), pos_y_start + 2, cheat.GetUserName(), { r, g, b, a }, font)
    else
        draw_TextOutlined(pos_x_start + 148 - draw_GetTextSize('UID :' .. cheat.GetUserID()), pos_y_start + 2, 'UID: ' .. cheat.GetUserID(), { r, g, b, a }, font)
    end

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --GACHI LINES
    draw_GradientRectH(pos_x_start, pos_y_start + 11, 75, 1, { r, g, b, 50 }, { r, g, b, a })
    draw_GradientRectH(pos_x_start + 76, pos_y_start + 11, 73, 1, { r, g, b, a }, { r, g, b, 50 })

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    pos_x1 = pos_x_start + 6
    pos_y1 = pos_y_start + 19
    pos_x2 = pos_x_start + 144
    pos_y2 = pos_y_start + 18

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --HC
    local hitchance = gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.hitchance')
    draw_TextOutlined(pos_x1, pos_y1, "HC: " .. hitchance, { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DMG
    local mindamage = gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.mindamage')
    draw_TextOutlined(pos_x1, pos_y1, "DMG: " .. mindamage, { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --SPREAD
    local spread = entities_GetLocalPlayer():GetWeaponInaccuracy()
    draw_TextOutlined(pos_x1, pos_y1, "SPREAD: " .. string_format("%0.3f", spread), { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --VELOCITY
    local m_vecVelocity0 = entities_GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[0]")
    local m_vecVelocity1 = entities_GetLocalPlayer():GetPropFloat("localdata", "m_vecVelocity[1]")
    local velocity = math_sqrt(m_vecVelocity0 * m_vecVelocity0 + m_vecVelocity1 * m_vecVelocity1)
    draw_TextOutlined(pos_x1, pos_y1, "VELOCITY: " .. string_format("%0.0f", velocity), { r, g, b, a }, font)
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DESYNC ANGLE
    local desync_rotation = gui_GetValue('rbot.antiaim.base.rotation')
    if desync_rotation > -1 then
        draw_TextOutlined(pos_x1, pos_y1, "DESYNC ANGLE: +" .. string_format("%0.0f", desync_rotation) .. "°", { r, g, b, a }, font)
    else
        draw_TextOutlined(pos_x1, pos_y1, "DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°", { r, g, b, a }, font)
    end

    local color_angle = {}
    if desync_rotation > -1 then
        color_angle = { 170 + (154 - 186) * desync_rotation / 58, 0 + (255 - 0) * desync_rotation / 58, 16 + (0 - 16) * desync_rotation / 58 , 255 }
    else
        color_angle = { 170 + (154 - 186) * desync_rotation / -58, 0 + (255 - 0) * desync_rotation / -58, 16 + (0 - 16) * desync_rotation / -58 , 255 }
    end

    local dec = { color_angle[1] - (color_angle[1] / 100 * 50), color_angle[2] - (color_angle[2] / 100 * 50), color_angle[3] - (color_angle[3] / 100 * 50) }

    desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°") + 3
    if desync_rotation > -1 then
        desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: +" .. string_format("%0.0f", desync_rotation) .. "°") + 3
    else
        desync_angle_pos_x1 = pos_x1 + draw_GetTextSize("DESYNC ANGLE: " .. string_format("%0.0f", desync_rotation) .. "°") + 3
    end
    desync_angle_pos_x2 = desync_angle_pos_x1 + 2
    desync_angle_pos_y1 = pos_y1 + 4
    draw_GradientRectV(desync_angle_pos_x1, desync_angle_pos_y1, desync_angle_pos_x2, desync_angle_pos_y1 - 5, { color_angle[1], color_angle[2], color_angle[3], 255 }, { dec[1], dec[2], dec[3], 100 })
    draw_GradientRectV(desync_angle_pos_x1, desync_angle_pos_y1, desync_angle_pos_x2, desync_angle_pos_y1 + 4, { dec[1], dec[2], dec[3], 100 }, { color_angle[1], color_angle[2], color_angle[3], 255 })
    pos_y1 = pos_y1 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --DT
    local primaryattack = entities_GetLocalPlayer():GetPropEntity('m_hActiveWeapon'):GetPropFloat('LocalActiveWeaponData', 'm_flNextPrimaryAttack')
    local doublefire = 'OFF'

    if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') == 1 then
        doublefire = ' DEFENSIVE'
    elseif gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') == 2 then
        doublefire = ' OFFENSIVE'
    end

    if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
        if primaryattack > globals_CurTime() or input_IsButtonDown(gui_Reference('Ragebot', 'Anti-Aim', 'Extra', 'Fake Duck'):GetValue()) then
            draw_TextOutlined(pos_x2 - draw_GetTextSize(doublefire .. ' DT'), pos_y2, doublefire .. ' DT', { WEAPON_INFO_WARNINGYELLOW_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize(SHIFTED_TICKS .. doublefire .. ' DT'), pos_y2, SHIFTED_TICKS .. doublefire .. ' DT', { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize(' OFF DT'), pos_y2, ' OFF DT', { WEAPON_INFO_WARNINGRED_CLR:GetValue() }, font)
    end

    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --LC
    if originRecords[1] ~= nil and originRecords[2] ~= nil then
        local delta = Vector3(originRecords[2].x - originRecords[1].x, originRecords[2].y - originRecords[1].y, originRecords[2].z - originRecords[1].z)
        delta = delta:Length2D()^2
        if delta > 4096 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LAGCOMP"), pos_y2, "LAGCOMP", { WEAPON_INFO_WARNINGRED_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LAGCOMP"), pos_y2, "LAGCOMP", { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
        if originRecords[3] ~= nil then
            table.remove(originRecords, 1)
        end
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --HS
    local hideshots = gui_GetValue('rbot.antiaim.condition.shiftonshot')
    if hideshots then
        draw_TextOutlined(pos_x2 - draw_GetTextSize("HIDESHOTS"), pos_y2, "HIDESHOTS", { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize("HIDESHOTS"), pos_y2, "HIDESHOTS", { WEAPON_INFO_WARNINGRED_CLR:GetValue() }, font)
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --FD
    local fakeduck = gui_GetValue('rbot.antiaim.extra.fakecrouchkey')
    if input_IsButtonDown(fakeduck) then
        draw_TextOutlined(pos_x2 - draw_GetTextSize("FAKEDUCK"), pos_y2, "FAKEDUCK", { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
    else
        draw_TextOutlined(pos_x2 - draw_GetTextSize("FAKEDUCK"), pos_y2, "FAKEDUCK", { WEAPON_INFO_WARNINGRED_CLR:GetValue() }, font)
    end
    pos_y2 = pos_y2 + 9

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --LBY
    local aa_type = gui_GetValue('rbot.antiaim.advanced.antialign')
    if aa_type == 0 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("! LBY"), pos_y2, "! LBY", { WEAPON_INFO_WARNINGRED_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("LBY"), pos_y2, "LBY", { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
        end
    elseif aa_type == 1 then
        if gui_GetValue('rbot.hitscan.accuracy.' .. string_lower(WEAPON_CURRENT_GROUP) .. '.doublefire') ~= 0 then
            draw_TextOutlined(pos_x2 - draw_GetTextSize("MM"), pos_y2, "MM", { WEAPON_INFO_WARNINGGREEN_CLR:GetValue() }, font)
        else
            draw_TextOutlined(pos_x2 - draw_GetTextSize("MM"), pos_y2, "MM", { WEAPON_INFO_WARNINGYELLOW_CLR:GetValue() }, font)
        end
    end
end

local function weapon_info()
    local r, g, b, a
    
    if WEAPON_INFO_RAINBOW:GetValue() then
        r, g, b = HSVtoRGB(globals_RealTime() * 0.1, 1, 1, 255)
        a = 255
    else
        r, g, b, a = WEAPON_INFO_GENERAL_CLR:GetValue()
    end

    if WEAPON_INFO_FIRSTPERSON:GetValue() and not gui_GetValue('esp.local.thirdperson') then
        position_save()
        local screen_x, screen_y = drag_indicator(weaponinfo_pos_x, weaponinfo_pos_y, 150, 67)

        weaponinfo_draw(screen_x, screen_y, r, g, b, a)
    elseif WEAPON_INFO_THIRDPERSON:GetValue() and gui_GetValue('esp.local.thirdperson') then
        local bone_pos = entities_GetLocalPlayer():GetBonePosition(54)
        if WEAPON_INFO_THIRDPERSON_POS:GetValue() == 0 then
            bone_pos = entities_GetLocalPlayer():GetBonePosition(54)
        else
            bone_pos = entities_GetLocalPlayer():GetBonePosition(5)
        end

        local bone_pos_x, bone_pos_y = client_WorldToScreen(bone_pos)

        if not bone_pos_x or not bone_pos_y then
            return
        end

        weaponinfo_draw(bone_pos_x, bone_pos_y, r, g, b, a)
    end
end

callbacks.Register('Draw', 'current_weapon_group', function()
    if not engine_GetServerIP() or engine_GetServerIP() then
        if entities_GetLocalPlayer() then
            if not entities_GetLocalPlayer():IsAlive() then
                return
            end
        else
            return
        end
    end

    if WEAPON_INFO_THIRDPERSON:GetValue() then
        WEAPON_INFO_THIRDPERSON_POS:SetInvisible(false)
    else
        WEAPON_INFO_THIRDPERSON_POS:SetInvisible(true)
    end

    if WEAPON_CURRENT_GROUP == 'GLOBAL' or WEAPON_CURRENT_GROUP == 'KNIFE' then
        return
    end

    weapon_info()

    return true
end)

callbacks.Register("CreateMove", 'WeaponInfoCMD', function(UserCmd)
    if not engine_GetServerIP() or engine_GetServerIP() then
        if entities_GetLocalPlayer() then
            if not entities_GetLocalPlayer():IsAlive() then
                return
            end
        else
            return
        end
    end

    if WEAPON_CURRENT_GROUP == 'GLOBAL' or WEAPON_CURRENT_GROUP == 'KNIFE' then
        return
    end

    if UserCmd.sendpacket then
        table.insert(originRecords, entities_GetLocalPlayer():GetAbsOrigin())
    end

    lc_status_and_shitftedticks(UserCmd)
end)




--***********************************************--

print("♥♥♥ " .. GetScriptName().." loaded without Errors ♥♥♥")