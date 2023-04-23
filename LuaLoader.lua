if not timer then
 timer = {}
 local timers = {}

 function timer.Exists(name)
 for k,v in pairs(timers) do
 if name == v.name then
 return true
 end
 end
 return false
 end


 function timer.Simple(name, delay, func)
 if not timer.Exists(name) then
 table.insert(timers, {type = "Simple", name = name, func = func, lastTime = globals.CurTime() + delay, delay = delay})
 end
 end


 function timer.Remove(name)
 for k,v in pairs(timers or {}) do
 if name == v.name then
 table.remove(timers, k)
 return true
 end
 end
 return false
 end


 function timer.Tick()
 for k, v in pairs(timers or {}) do
 if not v.pause then
 -- timer.Create
 if v.type == "Create" then
 if v.repetitions <= 0 then
 table.remove(timers, k)
 end
 if globals.CurTime() >= v.lastTime then
 v.lastTime = globals.CurTime() + v.delay
 v.repStartTime = globals.CurTime()
 v.func()
 v.repetitions = v.repetitions - 1
 end
 -- timer.Simple
 elseif v.type == "Simple" then
 if globals.CurTime() >= v.lastTime then
 v.func()
 table.remove(timers, k)
 end
 -- timer.Spam
 elseif v.type == "Spam" then
 v.func()
 if globals.CurTime() >= v.lastTime + v.duration then
 table.remove(timers, k)
 end
 end
 end
 end
 end
end

callbacks.Register( "Draw", timer.Tick)


local oCheckBox = gui.Checkbox
local changeable_ui_objects = {}


function gui.Checkbox(parent, varname, name, value, onchange)
    local checkbox = oCheckBox(parent, varname, name, value)
    if onchange then
        table.insert(changeable_ui_objects, {old_value = checkbox:GetValue(), ui_object = checkbox, onchange_callback = onchange})
    end
    return checkbox
end

function CheckForChanges()
    for k, v in pairs(changeable_ui_objects) do
        if v.ui_object:GetValue() ~= v.old_value then
            v.onchange_callback(v.ui_object, v.ui_object:GetValue())
        end
        v.old_value = v.ui_object:GetValue()
    end
end

callbacks.Register("Draw", "CheckForChanges", CheckForChanges)


function file.Exists(file_name)
  local exists = false
  file.Enumerate(function(_name)
    if file_name == _name then
      exists = true
    end
  end)
  return exists
end

function file.Contents(file_name)
  local f = file.Open(file_name, "r")
  local contents = f:Read()
  f:Close()
  return contents
end

function split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function pprint(s, mod)
 if not mod then
 print("[Lua loader][+] " .. s)
 else
 print("[Lua loader][" .. mod  .. "] " .. s)
 end
end



local Loader_Window = gui.Tab(gui.Reference("Settings"), "loader.tab", "Lua loader")
local current_tab = "Approved scripts"

local readme = [[

--------------------------------------------------------------------------------------------------------------------
README.txt
Lua loader is meant to make it easier for aimware users to try, test and download scripts from the aimware forums that other aimware users have made and publiclily released.
If you have a script and don't want it on here, and your script is on here PM Chicken4676 on the aimware forums. You should also note it is possible that a script cannot be loaded via this lua loader.
Credits: Chicken4676 (patient player)
]]


local banner_texts = {
 approved_scripts = "Approved scripts - This is where you can find approved aimware scripts, approved meaning an aimware moderator verfied this is a working lua script." .. readme,
 unapproved_scripts = "Unapproved scripts - This is where you can find unapproved aimware scripts, unapproved meaning an aimware moderator has NOT verfied this is a working lua script." .. readme,
 autorun_scripts = "Autorun scripts - This is where you selected and downloaded luas to automatically run when lua loader is running" .. readme
}

local Loader_banner_gb = gui.Groupbox(Loader_Window, "Infomation\n\n\n\n", 15, 15, 610, 50)
local Loader_banner_text = gui.Text(Loader_banner_gb, banner_texts.approved_scripts .. readme)


local Loader_search_filter = gui.Editbox(Loader_Window, "loader.filter", "Search fitler")

local Loader_unapproved_scripts = gui.Button(Loader_Window, "Unapproved scripts", function() current_tab = "Unapproved scripts" end)
local Loader_approved_scripts = gui.Button(Loader_Window, "Approved scripts", function() current_tab = "Approved scripts" end)
local Loader_autorun_scripts = gui.Button(Loader_Window, "Autorun scripts",  function() current_tab = "Autorun scripts" end)

Loader_search_filter:SetPosX(15)


Loader_unapproved_scripts:SetWidth(200)
Loader_approved_scripts:SetWidth(200)
Loader_autorun_scripts:SetWidth(200)

Loader_unapproved_scripts:SetPosX(15)

Loader_approved_scripts:SetPosX(218)
Loader_approved_scripts:SetPosY(295)

Loader_autorun_scripts:SetPosX(420)
Loader_autorun_scripts:SetPosY(295)



local Loader_sort_options = gui.Combobox(Loader_Window, "loader.sort", "Sort and update", "Date added (newest)", "Date added (oldest)")
Loader_sort_options:SetWidth(600)
Loader_sort_options:SetPosX(15)
Loader_sort_options:SetPosY(340)

if not file.Exists("lua_loader/autorun_scripts.dat") then
 local f = file.Open("lua_loader/autorun_scripts.dat", "a")
 pprint("Writing autorun file..")
 f:Write('')
 f:Close()
end


local temp_running_files = {}
local download_path = "lua_loader/downloaded_files/"
local temp_path = "lua_loader/temp_files/"


pprint("Loaded")
local updated = false
function CheckForUpdate()
 http.Get("https://raw.githubusercontent.com/AWSCRIPtS001/AimwareScripts1/master/lua_loader.lua", function(text)
 if "awaiting update\n" == text then print("Awaiting update..") return end
 if string.len(text) ~= string.len(file.Contents(GetScriptName())) then
 local f = file.Open(GetScriptName(), "w"); f:Write(""); f:Close()
 local f = file.Open(GetScriptName(), "a")
 f:Write(text)
 f:Close()
 updated = true
 gui.Command("lua.unload " .. GetScriptName())
 end
 end)
end
CheckForUpdate()

function GetAutorunLuaScripts()
 return split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")
end

function temp_file_exists(id)
 return file.Exists(temp_path .. id .. ".lua")
end

function downloaded_file_exists(id)
 return file.Exists(download_path .. id .. ".lua")
end

function Autorun()
 for k, id in pairs(GetAutorunLuaScripts()) do
 if downloaded_file_exists(id) then
 pprint("Autorunning " .. download_path .. id .. ".lua")
 LoadScript(download_path .. id .. ".lua")
 end
 end
end

Autorun()

function RunLuaScript(url, id)
 if downloaded_file_exists(id) then
 LoadScript(download_path .. id .. ".lua")
 pprint("Running downloaded verison")
 return
 end
 http.Get(url, function(text)
 local f = nil
 local temp_file_path = temp_path .. id .. ".lua"
 if temp_file_exists(id) then 
 f = file.Open(temp_file_path, "w")
 else
 f = file.Open(temp_path .. id  .. ".lua", "a")
 end
 pprint("Running temp version")

 f:Write(text)
 f:Close()
 LoadScript(temp_file_path)
 table.insert(temp_running_files, temp_file_path)
 end)
end

function UnloadLuaScript(id)
 if downloaded_file_exists(id) then -- user downloaded this lua file
 UnloadScript(download_path .. id .. ".lua")
 else
 UnloadScript(temp_path .. id .. ".lua")
 file.Delete(temp_path .. id .. ".lua")
 end
 pprint("Unloaded script")
end

function DownloadLuaScript(url, id)
 local file_path = download_path .. id .. ".lua"
 local f = nil
 http.Get(url, function(text)
 if downloaded_file_exists(id) then
 if file.Contents(file_path) == text then
 pprint("Lua has not been updated.")
 return
 end
 pprint("Lua has received an update")
 f = file.Open(file_path, "w")
 else
 f = file.Open(file_path, "a")
 end
 f:Write(text)
 f:Close()
 end)
end

function UninstallLuaScript(id)
 if downloaded_file_exists(id) then
 UnloadScript(download_path .. id .. ".lua")
 file.Delete(download_path .. id .. ".lua")
 pprint("Uinstalled script")
 end
end

local autorun_scripts = split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")

function id_in_autorun(id)
 local contents = split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")
 for k, line in pairs(contents) do
 if line == id then
 return true
 end
 end
 return false
end

function AddToAutorun(id)
 if not downloaded_file_exists(id) then
 pprint("you should not have been able to click the autorun checkbox.", "BUG")
 else
 local f = file.Open("lua_loader/autorun_scripts.dat", "a")
 f:Write(id .. "\n")
 f:Close()
 end
 autorun_scripts = split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")
end

function RemoveFromAutorun(id)
 local contents = split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")
 file.Delete("lua_loader/autorun_scripts.dat")
 local fitlered_lines = {}
 local f = file.Open("lua_loader/autorun_scripts.dat", "a")
 for k, line in pairs(contents) do
 if line ~= id then
 f:Write(line .. "\n")
 pprint("Successfully remomoved " .. id .. ".lua from autorun")
 end
 end
 f:Close()
 autorun_scripts = split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")
end

local script_boxes = {}

function CreateScriptBox(script_info)  -- Had a CreateScriptBoxes, but creating and deleting ui objects frequently seems to crash the game.
 -- So I seed the items (1000) and then edit the 
 local width = 300 
 local group_box = gui.Groupbox(Loader_Window, script_info.forum_title .. ' ' .. script_info.id, 0,0, width, 0)
 local author_text = gui.Text(group_box, "Author: " .. script_info.author)

 local b = {}


 local script_box = {
 script_catergory = script_info.category,
 downloaded = false,
 running = false,
 was_running = script_info.was_running,
 id = script_info.id,

 author_text = author_text,
 group_box = group_box,
 buttons = b,
 autorun_checkbox = gui.Checkbox(group_box, "autorun", "Autorun", false , function(self, checked)
 if checked then
 if id_in_autorun(script_info.id) then return end
 AddToAutorun(script_info.id)
 else
 RemoveFromAutorun(script_info.id)
 end
 end),

 url_button = gui.Button(group_box, "Forum link", function() 
 panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("' .. script_info.forum_url .. '")')
 end),

 forum_title = script_info.forum_title,
 forum_url = script_info.forum_url,
 author = script_info.author,
 }

 for k, id in pairs(split(file.Contents("lua_loader/autorun_scripts.dat"), "\n")) do -- Check if the script your adding to the ui is one of our auto run scripts
 if id == script_info.id then
 script_box.autorun_checkbox:SetValue(true)
 end
 end

 b.run_button = gui.Button(group_box, "Run", function() 
 RunLuaScript(script_info.raw_code_url, script_info.id)
 timer.Simple("_1", 0.1, function() b.unrun_button:SetInvisible(false) end)
 b.run_button:SetInvisible(true)
 script_box.running = true
 end)

 b.unrun_button = gui.Button(group_box, "Unload", function() 
 UnloadLuaScript(script_info.id)
 timer.Simple("_2", 0.1, function() b.run_button:SetInvisible(false) end)
 b.unrun_button:SetInvisible(true)
 script_box.running = false
 end)

 b.download_button = gui.Button(group_box, "Download", function()
 pprint("Downloading " .. script_info.forum_title .. " by " .. script_info.author)
 DownloadLuaScript(script_info.raw_code_url, script_info.id)
 timer.Simple("_3", 0.1, function() b.uninstall_button:SetInvisible(false) end)
 b.download_button:SetInvisible(true)
 script_box.downloaded = true
 end)

 b.uninstall_button = gui.Button(group_box, "Uninstall", function() 
 pprint("Uninstalling " .. script_info.forum_title .. " (" .. script_info.id .. ".lua)")
 script_box.autorun_checkbox:SetValue(false)
 UninstallLuaScript(script_info.id)
 timer.Simple("_4", 0.1, function() b.download_button:SetInvisible(false) end)
 b.uninstall_button:SetInvisible(true)
 script_box.downloaded = false
 end)

 for k, id in pairs(GetAutorunLuaScripts()) do
 if id == script_info.id then
 script_box.autorun_checkbox:SetValue(true)
 script_box.running = true
 end
 end

 if script_box.running or script_box.was_running then
 b.run_button:SetInvisible(true)
 b.unrun_button:SetInvisible(false)
 else
 b.run_button:SetInvisible(false)
 b.unrun_button:SetInvisible(true)
 end


 b.run_button:SetPosY(29)
 b.run_button:SetWidth(100)

 b.unrun_button:SetWidth(100)


 b.unrun_button:SetPosY(29)

 b.download_button:SetWidth(100)
 b.download_button:SetPosY(29)
 b.download_button:SetPosX(102)

 b.uninstall_button:SetWidth(100)
 b.uninstall_button:SetPosY(29)
 b.uninstall_button:SetPosX(102)

 if downloaded_file_exists(script_info.id) then
 b.uninstall_button:SetInvisible(false)
 b.download_button:SetInvisible(true)
 script_box.downloaded = true
 else
 b.uninstall_button:SetInvisible(true)
 b.download_button:SetInvisible(false)
 script_box.downloaded = false
 end

 script_box.url_button:SetWidth(75)
 script_box.url_button:SetPosY(29)
 script_box.url_button:SetPosX(204)


 script_box.autorun_checkbox:SetPosY(-40)
 script_box.autorun_checkbox:SetPosX(205)
 script_box.autorun_checkbox:SetDisabled(true)
 table.insert(script_boxes, script_box)
end

function FilterBySearchFilter(user_input, _script_boxes)
 local filtered_script_boxes = {}
 for k, v in pairs(_script_boxes) do
 if string.match(v.forum_title:lower(), user_input:lower()) or string.match(v.author:lower(), user_input:lower()) then
 table.insert(filtered_script_boxes, v)
 else
 v.group_box:SetInvisible(true)
 end
 end
 return filtered_script_boxes
end

function FilterByUnapprovedScripts(script_boxes)
 local filtered_script_boxes = {}
 for k, v in pairs(script_boxes) do
 if v.script_catergory == "unapproved_scripts" then
 table.insert(filtered_script_boxes, v)
 else
 v.group_box:SetInvisible(true)
 end
 end
 return filtered_script_boxes
end

function FilterByApprovedScripts(script_boxes)
 local filtered_script_boxes = {}
 for k, v in pairs(script_boxes) do
 if v.script_catergory == "approved_scripts" then
 table.insert(filtered_script_boxes, v)
 else
 v.group_box:SetInvisible(true)
 end
 end
 return filtered_script_boxes
end

function FilterByAutorunScripts(script_boxes)
 local filtered_script_boxes = {}
 for k, v in pairs(script_boxes) do
 if v.autorun_checkbox:GetValue() then
 table.insert(filtered_script_boxes, v)
 else
 v.group_box:SetInvisible(true)
 end
 end
 return filtered_script_boxes
end

local updating = false
function adjust_layout()
 if updating then return end

 local starting_pos_y = 330 -- The Y pos for the first row of group boxes to be placed
 local spacing = 70

 local filtered_script_boxes = {}

 if current_tab == "Approved scripts" then
 filtered_script_boxes = FilterByApprovedScripts(script_boxes)
 Loader_banner_text:SetText(banner_texts.approved_scripts)
 elseif current_tab == "Autorun scripts" then
 filtered_script_boxes = FilterByAutorunScripts(script_boxes)
 Loader_banner_text:SetText(banner_texts.autorun_scripts)
 elseif current_tab == "Unapproved scripts" then
 Loader_banner_text:SetText(banner_texts.unapproved_scripts)
 filtered_script_boxes = FilterByUnapprovedScripts(script_boxes)
 end

 if Loader_search_filter:GetValue():len() ~= 0 then
 filtered_script_boxes = FilterBySearchFilter(Loader_search_filter:GetValue(), filtered_script_boxes)
 end

 for i, script_box in ipairs(filtered_script_boxes) do
 script_box.group_box:SetInvisible(false)
 if script_box.downloaded then
 script_box.autorun_checkbox:SetDisabled(false)
 else
 script_box.autorun_checkbox:SetDisabled(true)
 end
 if i % 2 == 0 then
 script_box.group_box:SetPosX(325)
 script_box.group_box:SetPosY(starting_pos_y + spacing * (i - 1))
 else
 script_box.group_box:SetPosY(starting_pos_y + spacing * i)
 script_box.group_box:SetPosX(15)
 end
 end
end

callbacks.Register("Draw", "adjust_layout", adjust_layout)
 
function dump(o)
  if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
  else
      return tostring(o)
  end
end

function stringtotable(text)
 local running_scripts = {}



 for i, v in ipairs(script_boxes) do
 running_scripts[v.id] = v.running
 v.author_text:Remove()
 v.autorun_checkbox:Remove()
 v.url_button:Remove()
 v.buttons.run_button:Remove()
 v.buttons.unrun_button:Remove()
 v.buttons.download_button:Remove()
 v.buttons.uninstall_button:Remove()
 v.group_box:Remove()
 end
 script_boxes = {}
 local _script_boxes = {}
 local lines = split(text, "\n")
 for k, line in pairs(lines) do
 if string.sub(line, 1, 2) ~= "--" then
 local line_split = split(line, "|")
 line_split[1] = line_split[1]:gsub("|", "")
 line_split[6]  = line_split[6]:sub(1, -2)
 local script =  {
 category = line_split[1],
 forum_title = line_split[2],
 forum_url = line_split[3],
 raw_code_url = line_split[4],
 author = line_split[5],
 id = line_split[6],
 }
 script.was_running = running_scripts[script.id]

 table.insert(_script_boxes, script)
 end
 end
 return _script_boxes
end


local data_link = "https://raw.githubusercontent.com/AWSCRIPtS001/AimwareScripts1/master/aimware_scripts.txt?anticache=" .. globals.CurTime()
function clear_temp_files()
 http.Get(data_linkx, function(text)
 local scripts_table = stringtotable(text)
 for k, v in pairs(scripts_table) do
 if file.Exists(temp_path .. v.id .. ".lua") then
 pprint("Found temp lua file (" .. v.id .. ".lua) due to bad unload. Deleting " .. v.id .. ".lua")
 file.Delete(temp_path .. v.id .. ".lua")
 end
 end
 end)
end
clear_temp_files()


local delay = globals.CurTime() - 1
local old_sort_option = 0
local i = 0

function heartbeat()
 if globals.CurTime() > delay or old_sort_option ~= Loader_sort_options:GetValue() then
 http.Get(data_link, function(text)
 local scripts_table = stringtotable(text)
 if Loader_sort_options:GetValue() == 1 then
 for i=1, #scripts_table do 
 CreateScriptBox(scripts_table[i])
 end
 elseif Loader_sort_options:GetValue() == 0 then
 for i=#scripts_table, 1, -1 do 
 CreateScriptBox(scripts_table[i])
 end
 end
 end)
 old_sort_option = Loader_sort_options:GetValue()
 delay = globals.CurTime() + 300
 -- i = i + 1
 -- pprint("Updated", i)
 end
end

callbacks.Register("Draw", "heartbeat", heartbeat)

callbacks.Register("Unload", function()
 if updated then return end
 pprint("Unhooking functions", "-")
 callbacks.Unregister("Draw", "heartbeat")
 callbacks.Unregister("Draw", "endadjust_layout")
 callbacks.Unregister("Draw", "CheckForChanges")
 
 pprint("Unloading all scripts", "-")
 for k, v in pairs(script_boxes) do
 if v.running then
 pprint("Unloaded " .. v.id .. ".lua", "-")
 UnloadScript(download_path .. v.id .. ".lua")
 end
 end

 for k,v in pairs(script_boxes) do
 v.author_text:Remove()
 v.autorun_checkbox:Remove()
 v.url_button:Remove()
 v.buttons.run_button:Remove()
 v.buttons.unrun_button:Remove()
 v.buttons.download_button:Remove()
 v.buttons.uninstall_button:Remove()
 v.group_box:Remove()
 end
 pprint("Goodbye! https://aimware.net/forum/thread-134637.html for updates", "-")
end) 