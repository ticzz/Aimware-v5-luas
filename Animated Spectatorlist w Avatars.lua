local draw = require and require "draw" or draw
local menu = gui.Reference("menu")

local spectators_win_h = 36
local spectators_icon =
    draw.CreateTexture(
    common.RasterizeSVG(
        [[<svg t="1632482623198" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="943" width="20" height="20"><path d="M19.97 17.462l-.462-1.715-1.28 1.279-1.251-.054-1.278 1.278-.271-.271-1.307 1.306.271.272-1.36 1.36-.271-.272-1.307 1.307.272.272-1.36 1.36-.272-.272-1.307 1.307.272.271-1.252 1.252-.463 1.769-.925.924c-.255.255-.508.254-.762 0L.814 23.992c-.254-.254-.255-.508 0-.763l.925-.925 1.742-.49 1.252-1.252.3.3 1.307-1.306-.3-.3 1.36-1.36.3.3 1.307-1.307-.3-.3 1.36-1.36.3.3 1.306-1.307-.3-.3 1.278-1.278-.027-1.225 1.742-1.742c.254-.254.508-.253.762.001l.381.38 1.524.109L18.12 9.08c-.381-.49-.39-.916-.028-1.278.235-.236.472-.31.708-.219.146.036.354.19.626.463l2.993 2.993-1.524 6.586-8.571 8.571-1.905-.652c-.272-.091-.381-.254-.326-.49.072-.254.262-.372.57-.354.272.018.636.09 1.089.217l.572.191 7.646-7.646z" p-id="944" fill="#cdcdcd"></path></svg>]]
    )
)


local spectators_win = gui.Window("newspectators", "Spectators list", 20, 20, 200, spectators_win_h)
spectators_win:SetIcon(spectators_icon, 0.7)

local spectators_set = gui.Window("newspectators.set", "set", 20, 20, 160, 106)
local spectators_set_active = false

local g_name_clr = gui.ColorPicker(spectators_set, "nameclr", "Name Color", 255, 255, 255, 255)
local g_show_avatar = gui.Checkbox(spectators_set, "showavatar", "Show Avatar", 1)

local function clamp(val, min, max)
    return val > max and max or val < min and min or val
end

local fonts = {}
local function setup_font(name, size, dpi, width, out)
    local dpi = dpi or 1
    fonts[dpi] = fonts[dpi] or draw.CreateFont(name, size * dpi, width or 0, out or false)
    return draw.SetFont(fonts[dpi])
end

local alpha = {}
local function get_spectators(ent, fade)
    if not ent then
        return
    end
    local ent_idx = ent:GetIndex()
    local temp = {}

    for k, v in pairs(entities.FindByClass("CCSPlayer")) do
        local idx = v:GetIndex()
        if v:GetName() ~= "GOTV" then
            local observer_idx = v:GetPropEntity("m_hObserverTarget"):GetIndex()

            alpha[idx] = alpha[idx] or 0
            alpha[idx] =
                clamp(
                alpha[idx] + (observer_idx == ent_idx and not entities.GetPlayerResources():GetPropBool("m_bAlive", v:GetIndex()) and fade or -fade),
                0,
                1
            )

            if alpha[idx] ~= 0 then
                temp[#temp + 1] = {player = v, alpha = alpha[idx]}
            end
        end
    end
    return temp
end

local function setup_spectator()
    local spectators = {}

    callbacks.Register(
        "Draw",
        function()
            local lp = entities.GetLocalPlayer()
            local fade = globals.FrameTime() * 5
            spectators = get_spectators(lp, fade) or {}
            spectators_win:SetActive(#spectators > 0 or menu:IsActive())
        end
    )

    gui.Custom(
        spectators_win,
        "",
        0,
        -10,
        200,
        12,
        function(x1, y1, x2, y2, active)
            local lp = entities.GetLocalPlayer()

            local dpi = (gui.GetValue("adv.dpi") + 3) * 0.25
            local fade = globals.FrameTime() * 6

            local w, h = x2 - x1, y2 - y1

            local nr, ng, nb, na = g_name_clr:GetValue()

            setup_font("Bahnschrift", 15, dpi)

            spectators_win:SetHeight(spectators_win_h)

            for k, v in pairs(spectators) do
                local name = v.player:GetName()
                local name = #name > 20 and (name:sub(0, 20) .. "...") or name

                local tx, ty = x1 + 15 * dpi, y1 + 20 * dpi * k
                local tw, th = draw.GetTextSize(name)

                local ax, ay = x1 + 165 * dpi, y1 + 20 * dpi * k - 5 * dpi
                local aw, ah = ax + 20 * dpi, ay + 20 * dpi

                spectators_win:SetHeight(spectators_win_h + k * 20)

                draw.Color(255, 255, 255, v.alpha * 50)
                draw.SetScissorRect(tx, ty - 5 * dpi, w, (th + 15 * dpi) * v.alpha)

                do
                    if g_show_avatar:GetValue() then
                        local avatar = draw.GetSteamAvatar and draw.GetSteamAvatar(client.GetPlayerInfo(v.player:GetIndex()).SteamID, 1)
                        if avatar then
                            draw.Color(11, 11, 11, v.alpha * 255)
                            draw.ShadowRect(ax, ay, aw, ah, 3)
                            draw.Color(255, 255, 255, v.alpha * 255)
                            draw.SetTexture(avatar)
                            draw.FilledRect(ax + 1, ay + 1, aw - 1, ah - 1)
                            draw.SetTexture(nil)
                        else
                            draw.Color(11, 11, 11, v.alpha * 255)
                            draw.ShadowRect(ax, ay, aw, ah, 3)
                            draw.Color(34, 34, 34, v.alpha * 255)
                            draw.FilledRect(ax + 1, ay + 1, aw - 1, ah - 1)
                            draw.Color(255, 255, 255, v.alpha * 255)

                            draw.Text(aw - 13 * dpi, ah - 15 * dpi, "?")
                        end
                    end
                end

                draw.Color(nr, ng, nb, v.alpha * na)
                draw.Text(tx, ty, name)
            end

            draw.SetScissorRect(0, 0, draw.GetScreenSize())
        end
    )
end

setup_spectator()

local function intersect(x, y, w, h)
    local cx, cy = input.GetMousePos()
    return cx >= x and cx <= x + w and cy >= y and cy <= y + h
end

gui.Custom(
    spectators_win,
    "",
    0,
    -24,
    200,
    24,
    function(x1, y1, x2, y2, active)
        local dpi = (gui.GetValue("adv.dpi") + 3) * 0.25
        local w, h = x2 - x1, y2 - y1

        local sx, sy = gui.GetValue("newspectators.set")

        if intersect(x1, y1, w, h) and menu:IsActive() then
            draw.Color(255, 255, 255, 100)
            draw.Text(x1 + 5 * dpi, y1 - 14 * dpi, "Right click to enable other settings.")
        end

        if intersect(x1, y1, w, h) and menu:IsActive() and input.IsButtonPressed(0x02) then
            local x, y = input.GetMousePos()
            spectators_set:SetPosX(x)
            spectators_set:SetPosY(y)
            spectators_set_active = true
        elseif not intersect(sx, sy, 160, 106) and active and input.IsButtonPressed(0x01) or input.IsButtonPressed(0x02) then
            spectators_set_active = false
        end

        if not spectators_win:IsActive() then
            spectators_set_active = false
        end

        spectators_set:SetActive(spectators_win:IsActive() and spectators_set_active)
    end
)

