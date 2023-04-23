local config_switch_tab = gui.Tab(gui.Reference("Settings"), "config_switch", "Config switcher")
local config_enabled = gui.Checkbox(config_switch_tab, "config_enabled", "Enabled", false)


local config_toggle_key = gui.Keybox( config_switch_tab, "config_switch_key", "Config switch key", 81)
config_toggle_key:SetWidth(1215)

function get_config_files(exclusion)
    local config_files = {}
    file.Enumerate(function(file_name)
        if string.find(file_name, ".cfg") then
            if file_name ~= exclusion then
                table.insert(config_files, file_name)
            end
        end
    end)
    return config_files
end

local config_files = get_config_files()
local config_1 = gui.Combobox(config_switch_tab, "config_cfg_1", "First config", unpack(config_files))
local config_2 = gui.Combobox(config_switch_tab, "config_cfg_2", "Second config", unpack(config_files))
config_2:SetValue(1)

-- Indicator options
local config_indicator = gui.Checkbox(config_switch_tab, "config_draw_indicator", "Show config indicator", true)
config_indicator:SetPosY(230)
local w, h = draw.GetScreenSize()

local config_indicator_font_size = gui.Slider( config_switch_tab, "config_draw_indicator_font_size", "Font size", 50, 0, 100, 5 )
config_indicator_font_size:SetWidth(100)
config_indicator_font_size:SetPosX(160)
config_indicator_font_size:SetPosY(217)

local config_indicator_x_pos = gui.Slider( config_switch_tab, "config_draw_indicator_x_pos", "X pos", w * 0.02, 0, w, 5 )
config_indicator_x_pos:SetWidth(100)
config_indicator_x_pos:SetPosX(280)
config_indicator_x_pos:SetPosY(217)

local config_indicator_y_pos = gui.Slider( config_switch_tab, "config_draw_indicator_y_pos", "Y pos", h * 0.2, 0, h, 5 )
config_indicator_y_pos:SetWidth(100)
config_indicator_y_pos:SetPosX(390)
config_indicator_y_pos:SetPosY(217)

local fonts = {"Arial", "Fixedsys", "Verdana", "Verdana Bold", "icomoon", "Tahoma", "Marlett"}
local config_indicator_font_family = gui.Combobox( config_switch_tab, "config_draw_indicator_font", "Font family", unpack(fonts))
config_indicator_font_family:SetWidth(120)
config_indicator_font_family:SetPosX(500)
config_indicator_font_family:SetPosY(212)

config_indicator_font_size:SetInvisible(true)
config_indicator_x_pos:SetInvisible(true)
config_indicator_y_pos:SetInvisible(true)
config_indicator_font_family:SetInvisible(true)


function table.find(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then return i end
    end
end

local switched = false
local currently_loaded_cfg = ''
callbacks.Register("Draw", function()
    if config_enabled:GetValue() then  
           local config_1_name = config_files[config_1:GetValue() + 1]
        local config_2_name = config_files[config_2:GetValue() + 1]
        if input.IsButtonReleased(config_toggle_key:GetValue()) then
            switch = not switch
             if switch then
                 gui.Command("cfg.load " .. config_1_name)
                 currently_loaded_cfg = config_1_name
             else
                 gui.Command("cfg.load " .. config_2_name)
                 currently_loaded_cfg = config_2_name
             end
         end
    end


     if config_indicator:GetValue() then
         local font = draw.CreateFont(fonts[config_indicator_font_family:GetValue() + 1], config_indicator_font_size:GetValue(), 400)
        draw.SetFont(font)
         draw.Text( config_indicator_x_pos:GetValue(), config_indicator_y_pos:GetValue(), currently_loaded_cfg)
         config_indicator_font_size:SetInvisible(false)
        config_indicator_x_pos:SetInvisible(false)
        config_indicator_y_pos:SetInvisible(false)
        config_indicator_font_family:SetInvisible(false)
    else
        config_indicator_font_size:SetInvisible(true)
        config_indicator_x_pos:SetInvisible(true)
        config_indicator_y_pos:SetInvisible(true)
        config_indicator_font_family:SetInvisible(true)

     end
end)



local delay = globals.CurTime() + 1
function update_ui()
    if not config_enabled:GetValue() then
        config_1:SetDisabled(true)
        config_2:SetDisabled(true)
        config_indicator:SetValue(false)
        config_indicator:SetDisabled(true)
    else
        config_1:SetDisabled(false)
        config_2:SetDisabled(false)
        config_indicator:SetDisabled(false)
    end
    if globals.CurTime() > delay then
        local config_1_name = config_files[config_1:GetValue() + 1]
        local config_2_name = config_files[config_2:GetValue() + 1]

        config_files = get_config_files()

        config_1:SetOptions(unpack(config_files))
        config_1:SetValue(table.find(config_files, config_1_name) - 1)

        config_2:SetOptions(unpack(config_files))
        config_2:SetValue(table.find(config_files, config_2_name) - 1)

        delay = globals.CurTime() + 1
    end
end

callbacks.Register("Draw", update_ui)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

