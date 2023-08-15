local walkbot = {}
local is_downloading = false
local num_data_files_downloaded = 0
local num_data_files_available = 0
local num_data_files_failed = 0

local function download_files(path, local_directory)
    is_downloading = true
    local data_files = http.Get(path .. "/files.txt")

    for s in data_files:gmatch("[^\r\n]+") do
        num_data_files_available = num_data_files_available + 1
        http.Get(path .. "/" .. s, function(online_file_content)
            if (online_file_content == nil or online_file_content == "error") then
                num_data_files_failed = num_data_files_failed + 1
                return
            end

            file.Write( local_directory .. "\\" .. s, online_file_content )
            num_data_files_downloaded = num_data_files_downloaded + 1
        end)
    end
end

local core_path = "https://raw.githubusercontent.com/Trollface7272/aimware_walkbot/master"
local core_local_path = "walkbot"
local core_version

if not pcall(function() file.Read(core_local_path .. "\\version.txt") end) then
    file.Write( core_local_path .. "\\version.txt", '0' )
else
    core_version = file.Read(core_local_path .. "\\version.txt")
end

local online_core_version = http.Get(core_path .. "/version.txt")

local success, configRaw = pcall(function() return file.Read("walkbot\\modules\\config.lua") end)

walkbot.config = success and loadstring(configRaw)() or nill


if (walkbot.config == nil or core_version ~= online_core_version) then
    download_files(core_path, core_local_path)
    print( ('[walkbot Update] Core updating from "%s" to "%s"'):format(core_version, online_core_version) )
end

local data_path = "https://raw.githubusercontent.com/Trollface7272/aimware_walkbot/master/data"
local data_local_path = "walkbot\\data"
local data_version

if not pcall(function() file.Read(data_local_path .. "\\version.txt") end) then
    file.Write( data_local_path .. "\\version.txt", '0' )
else
    data_version = file.Read(data_local_path .. "\\version.txt")
end

local online_data_version = http.Get(data_path .. "/version.txt")

if (data_version ~= online_data_version) then
    download_files(data_path, data_local_path)
    print( ('[walkbot Update] Data updating from "%s" to "%s"'):format(data_version, online_data_version) )
end

callbacks.Register("Draw", "walkbot_update_data_files", function()
	if (num_data_files_available == 0) then return end

    if (num_data_files_available ~= (num_data_files_downloaded + num_data_files_failed)) then
        draw.Text(0, 0, "[Walkbot Update] Downloading..." .. num_data_files_downloaded .. " / " .. num_data_files_available .. " files.")
    elseif (num_data_files_failed > 0) then
        draw.Text(0, 0, "[Walkbot Update] Downloads failed: " .. num_data_files_failed .. ", restart lua to try again.")
    else
        draw.Text(0, 0, "[Walkbot Update] Update completed, please restart lua to use walkbot.")
    end
end)

if (is_downloading == false) then
    callbacks.Unregister("Draw", "walkbot_update_data_files")
	RunScript("walkbot\\walkbot.lua")
end