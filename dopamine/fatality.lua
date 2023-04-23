if dopamine == nil then
    RunScript("dopamine.lua")
end

local timing_switch = 15.81

local frametime = 0
local fps = 0
local cur_mode = 0
local timing = timing_switch

local function get_kd()
    local kills = entities.GetPlayerResources():GetPropInt("m_iKills", entities.GetLocalPlayer():GetIndex())
    local deaths = entities.GetPlayerResources():GetPropInt("m_iDeaths", entities.GetLocalPlayer():GetIndex())

    if deaths == 0 then deaths = 1 end

    return (math.floor((kills / deaths) * (10^(2 or 0)) + 0.5) / (10^(2 or 0)))
end


local clantag_timing = {
    [1] = function() return "f" end,
    [2] = function() return "fa" end,
    [3] = function() return "fat" end,
    [4] = function() return "fata" end,
    [5] = function() return "fatal" end,
    [6] = function() return "fatali" end,
    [7] = function() return "fatalit" end,
    [8] = function() return "fatality" end,
    [9] = function() return "fatality." end,
    [10] = function() return "fatality.w" end,
    [11] = function() return "fatality.wi" end,
    [12] = function() return "fatality.win" end,
    [13] = function() return "fatality.win " end,
    [14] = function() return "fatality.win  " end,
    [15] = function() return "fatality.win  " end,
    [16] = function() return "fatality.win  " end,
    [17] = function() return "fatality.win  " end,
    [18] = function() return "fatality.win  " end,
    [19] = function() return "fatality.win  " end,
    [20] = function() return "fatality.wi" end,
    [21] = function() return "fatality.w" end,
    [22] = function() return "fatality." end,
    [23] = function() return "fatality" end,
    [24] = function() return "fatalit" end,
    [25] = function() return "fatali" end,
    [26] = function() return "fatal" end,
    [27] = function() return "fata" end,
    [28] = function() return "fat" end,
    [29] = function() return "fa" end,
    [30] = function() return "f" end,
    [31] = function() return "" end,
    [32] = function() return "" end,
    [33] = function() return "" end,
    [34] = function() return "" end,
    [35] = function() return "" end,
    [36] = function() return "" end,
}

local function hk_create_move(cmd)
    timing = timing + 1
end

local function hk_draw()
    -- also """borrowed""" from Nexxed :)
    frametime = 0.9 * frametime + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    fps = math.floor((1.0 / frametime) + 0.5)

    if not dopamine.available() then
        return
    end
    
    if timing >= timing_switch then
        cur_mode = cur_mode + 1

        if cur_mode > #clantag_timing then
            cur_mode = 1
        end
        
        dopamine.set_clan_tag(clantag_timing[cur_mode]())
        timing = 0
    end
end

callbacks.Register("CreateMove", hk_create_move)
callbacks.Register("Draw", hk_draw)
