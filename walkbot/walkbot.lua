-- Walkbot by ShadyRetard

local walkbot = {}

callbacks.Unregister("Draw", "walkbot_update_data_files")

walkbot.config = loadstring(file.Read("walkbot\\modules\\config.lua"))()
walkbot.json = loadstring(file.Read(walkbot.config.main_directory .. "\\json.lua"))()

for _, value in pairs(walkbot.config.modules) do
    walkbot[value] = loadstring(file.Read(walkbot.config.modules_directory .. "\\" .. value .. ".lua"))()
end

for _, value in pairs(walkbot.config.modules) do
    walkbot[value].connect(walkbot)
end