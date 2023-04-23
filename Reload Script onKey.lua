local advanced_ref = gui.Reference("Settings", "Lua Scripts", "Manage scripts")
local key_box = gui.Keybox(advanced_ref, "reload_script_key", "", 70)
local txt = gui.Text(advanced_ref, "      Reload script on key")

txt:SetPosX(438)
txt:SetPosY(200)

key_box:SetWidth(140)
key_box:SetHeight(30)
key_box:SetPosX(438)
key_box:SetPosY(220)

local lua_files = {}
file.Enumerate(function(lua_file)
    if string.match(lua_file, ".lua") then
        table.insert(lua_files, lua_file)
    end
end)

local combo_box = gui.Combobox(advanced_ref, "reload_script_picker", "", unpack(lua_files))

combo_box:SetPosX(438)
combo_box:SetPosY(235)
combo_box:SetWidth(140)
-- combo_box:SetHeight(140) -- sets it's Y pos instead of height?


callbacks.Register("Draw", function()
  if input.IsButtonReleased(key_box:GetValue()) then
        UnloadScript(lua_files[combo_box:GetValue() + 1])
        LoadScript(lua_files[combo_box:GetValue() + 1])
    end
end)
