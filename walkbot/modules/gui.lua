-- Walkbot by ShadyRetard

local walkbot_gui = {}
local walkbot = nil
local groupboxes = {}
walkbot_gui.debug_enabled_checkbox = nil

local rows = {{0, 0}}
local debug_variables = {}

function walkbot_gui.find_groupbox(name)
    for i=1, #groupboxes do
        if groupboxes[i]:GetName() == name then
            return groupboxes[i]
        end
    end
end

function walkbot_gui.add_groupbox(title, width, height)
    local existing_groupbox = walkbot_gui.find_groupbox(title)
    if  (existing_groupbox ~= nil) then
        return existing_groupbox
    end

    if (width == nil) then
        width = 296
    end

    -- Only items that fit within the tab are allowed
    if (width <= 0 or width > (walkbot.config.tab_width - (2 * walkbot.config.tab_padding))) then
        print("Invalid width")
        return
    end

    local x = walkbot.config.tab_padding
    local y = walkbot.config.tab_padding

    for i=1, #rows - 1 do
        y = rows[i][2] + walkbot.config.tab_padding
    end

    -- New row when row width exceeds tab width
    if ((rows[#rows][1] + width) > (walkbot.config.tab_width - (2 * walkbot.config.tab_padding))) then
        y = y + rows[#rows][2]
        table.insert(rows, {width, height})
    elseif (rows[#rows][1] > 0) then
        x = x + rows[#rows][1] + walkbot.config.tab_padding
        rows[#rows][1] = rows[#rows][1] + width
        if (height > rows[#rows][2]) then
            rows[#rows][2] = height
        end
    else
        rows[#rows][1] = rows[#rows][1] + width
        rows[#rows][2] = height
    end

    local groupbox = gui.Groupbox(walkbot_gui.main_tab, title, x, y, width, height)
    table.insert(groupboxes, groupbox)
    return groupbox
end

function walkbot_gui.add_debug_variable(variable, title, text, color)
    if (color == nil) then
        color = {255, 255, 255, 255}
    end

    debug_variables[variable] = {["title"] = title, ["text"] = text, ["color"] = color}
end

function walkbot_gui.remove_debug_variable(variable)
    debug_variables[variable] = nil
end

local function debug_draw()
    if (walkbot.enabled_checkbox:GetValue() == false) then return end
    if (walkbot_gui.debug_enabled_checkbox:GetValue() == false) then return end

    local x = walkbot.config.debug_x
    local y = walkbot.config.debug_y

    for _, debug_variable in pairs(debug_variables) do
        draw.Color(255, 255, 255, 255)
        draw.Text(x, y, debug_variable["title"])
        local text_color = debug_variable["color"]
        draw.Color(text_color[1], text_color[2], text_color[3], text_color[4])
        draw.Text(x + draw.GetTextSize(debug_variable["title"]) + 5, y, debug_variable["text"])
        y = y + 15
    end
end

local function initialize()
    local main_groupbox = walkbot_gui.add_groupbox("Main", nil, 100)
    walkbot.enabled_checkbox = gui.Checkbox(main_groupbox, "walkbot_enabled", "Enabled Walkbot", false)

    local debugging_groupbox = walkbot_gui.add_groupbox("Debugging", nil, 100)
    walkbot_gui.debug_enabled_checkbox = gui.Checkbox(debugging_groupbox, "walkbot_debug_enabled", "Enabled debug", false)

    callbacks.Register("Draw", "walkbot.gui.debug.draw", debug_draw)
end

function walkbot_gui.connect(walkbot_instance)
    walkbot = walkbot_instance
    walkbot_gui.main_tab = gui.Tab(gui.Reference("Settings"), "walkbot_main_tab", "Walkbot")
    initialize()
end

return walkbot_gui