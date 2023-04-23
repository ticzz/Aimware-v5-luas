local wnd_ui = gui.Window("wnd_ui", "Advanced Snap Lines", 200, 200, 250, 250)

local mst_sw = gui.Checkbox(wnd_ui, "mst_sw", "Master Switch", false)
local filter_mb = gui.Multibox(wnd_ui, "Snap Lines Filter")
local enemies_filter = gui.Checkbox(filter_mb, "enemies_filter", "Enemy", true)
local friendlies_filter = gui.Checkbox(filter_mb, "friendlies_filter", "Friendly", true)

local enemy_col = gui.ColorPicker(enemies_filter, "enemy_col", "", unpack({240, 60, 30, 255}))
local friendly_col = gui.ColorPicker(friendlies_filter, "friendly_col", "", unpack({30, 154, 247, 255}))

local screen_pos_cb = gui.Combobox(wnd_ui, "screen_pos_cb", "Screen Position", unpack({"Top", "Center", "Bottom"}))
local entity_pos_cb = gui.Combobox(wnd_ui, "entity_pos_cb", "Entity Position", unpack({"Top", "Bottom", "Head"}))

local function ui()
    local cheat_menu = gui.Reference("Menu")

    if not cheat_menu:IsActive() then
        wnd_ui:SetActive(false)
    else
        wnd_ui:SetActive(true)
    end
end

local function screen_pos(pos, screenY)
    if pos == 0 then
        return 0
    elseif pos == 1 then
        return screenY / 2
    elseif pos == 2 then
        return screenY
    end
end

local function ent_pos_wts(pos, entity)
    local x, y = client.WorldToScreen(entity:GetAbsOrigin())
    local head_x, head_y = client.WorldToScreen(entity:GetHitboxPosition(0))
    local advanced_mathematics, center = nil, nil

    if x == nil or y == nil or head_x == nil or head_y == nil then return end

    if head_y ~= nil then
        advanced_mathematics = y - head_y
        center = (advanced_mathematics / 2) / 2 
    end

    if center == nil then return end

    if pos == 0 then
        return head_x , head_y - center / 2
    elseif pos == 1 then
        return x, y
    elseif pos == 2 then
        return head_x, head_y
    end
end

local function SnapLines()
    if not mst_sw:GetValue() then return end

    local screenX, screenY = draw.GetScreenSize();

    local players = entities.FindByClass("CCSPlayer");
    local localplayer = entities.GetLocalPlayer()

    for i = 1, #players do
        local player = players[i];

        if player:GetIndex() == localplayer:GetIndex() then goto continue end

        if player:GetTeamNumber() == localplayer:GetTeamNumber() then
            draw.Color(friendly_col:GetValue())
        elseif player:GetTeamNumber() ~= localplayer:GetTeamNumber() then
            draw.Color(enemy_col:GetValue())
        end

        if not enemies_filter:GetValue() then
            if localplayer:GetTeamNumber() ~= player:GetTeamNumber() then
                goto continue
            end
        end

        if not friendlies_filter:GetValue() then
            if localplayer:GetTeamNumber() == player:GetTeamNumber() then
                goto continue
            end
        end

        if player:IsAlive() and not player:IsDormant() then
            local x, y = ent_pos_wts(entity_pos_cb:GetValue(), player)

            if x ~= nil and y ~= nil then
                draw.Line(x, y, screenX/2, screen_pos(screen_pos_cb:GetValue(), screenY));
            end
        end

        ::continue::
    end
end


callbacks.Register("Draw", function() 
    ui()
    SnapLines()
end)