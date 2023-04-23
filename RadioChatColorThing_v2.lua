local RColor = {
    Normal = '',
    White = '',
    Grey = '',
    DarkGreen = '',
    LightGreen = '',
    LightDarkGreen ='',
    LightBlue = '',
    DarkBlue ='',
    Purple ='',
    LightRed = '',
    DarkRed = '',
    Gold = '',
}

local menu = gui.Reference("MENU")
local tab = gui.Tab(gui.Reference("Misc"), "Chicken.RaidoColor.tab", "Radio color")
local custom_msg = gui.Editbox( tab, "Chicken.RadioColor.messageentry", "Custom message:")

local english = true
local chinese = false

local english_preset_messages = {
	"None",
	"{linebreak}{color.DarkRed}Aimware{color.Purple}{linebreak}is{color.DarkGreen}{linebreak}#1",
}

local chinese_preset_messages = {
	"None"
}


local english_preset = gui.Combobox( tab, "Chicken.RadioColor.presets.english", "Presets", unpack(english_preset_messages))
local chinese_preset = gui.Combobox( tab, "Chicken.RadioColor.presets.chinease_btn", "Presets", unpack(chinese_preset_messages))
chinese_preset:SetInvisible(true)

local oEnglishPreset = 0
local oChinesePreset = 0
callbacks.Register("Draw", function()
	if menu:IsActive() then
		local current_english_preset = english_preset:GetValue()
		if english and oEnglishPreset ~= current_english_preset then
			custom_msg:SetValue(english_preset_messages[current_english_preset + 1] == "None" and "" or english_preset_messages[current_english_preset + 1])
			oEnglishPreset = current_english_preset
		end
		
		local current_chinese_preset = chinese_preset:GetValue()
		if chinese and oChinesePreset ~= current_chinese_preset then
			custom_msg:SetValue(chinese_preset_messages[current_chinese_preset + 1] == "None" and "" or chinese_preset_messages[current_chinese_preset + 1])
			oChinesePreset = current_chinese_preset
		end
	end
end)


local function convert_text_to_color(str)
	if string.match(str, "%.") then
		local base,property = str:match("([^.]*).(.*)")
		base = string.lower(base)
		if base == "color" then
			return RColor[property]
		end
	else
		if str == "linebreak" then
			return " "
		end
	end
	-- return back the string if nothing is found
	return "{" .. str .. "}"
end

local function process_string(str)
	local inside = false
	
	local processed_str = ""
	local temp_str = ""
	
	for i=0, string.len(str) do
		local char = string.sub(str, i, i)
		if not inside and char == "{" then
			inside = true
		elseif inside then
			if char == "}" then
				inside = false
				processed_str = processed_str .. convert_text_to_color(temp_str)
				temp_str = ""
			else
				temp_str = temp_str .. char
			end
		else
			processed_str = processed_str .. char
		end
	end
	return processed_str
end


local btn = gui.Button(tab, "Send", function()
    client.Command('playerchatwheel . "' .. process_string(custom_msg:GetValue()) .. '"', true)
end)

btn:SetWidth(608)


local text  = gui.Text(tab, [[
Coloring:

{color.Normal}

{color.White}

{color.Grey}

{color.DarkGreen}

{color.LightGreen}

{color.LightDarkGreen}

{color.LightBlue}

{color.DarkBlue}

{color.Purple}

{color.LightRed}

{color.DarkRed}

{color.Gold}

{linebreak}



]])

local english_btn = gui.Button(tab, "EN", function()
	english = true
	chinese = false
	
	english_preset:SetInvisible(false)
	chinese_preset:SetInvisible(true)
end)
english_btn:SetHeight(18)
english_btn:SetWidth(25)
english_btn:SetPosX(60)
english_btn:SetPosY(68)

local chinese_btn = gui.Button(tab, "中文", function()
	chinese = true
	english = false
	chinese_preset:SetInvisible(false)
	english_preset:SetInvisible(true)
end)
chinese_btn:SetHeight(18)
chinese_btn:SetWidth(30)
chinese_btn:SetPosX(60 + 25 + 5)
chinese_btn:SetPosY(68)


local function split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end


function file.Append(filename, append_text)
	local f = file.Open(filename, "a")
	f:Write(append_text)
	f:Close()
end


local fname = "radio_presets_v2.txt"
file.Append(fname, "en,{linebreak}{color.DarkRed}Aimware{color.Purple}{linebreak}is{color.DarkGreen}{linebreak}#1")




local function update_presets()
	english_preset_messages = {"None"}
	chinese_preset_messages = {"None"}
	local contents_split = split(file.Read(fname), "\n")
	for i, line in ipairs(contents_split) do
		local split_line = split(line, ",")
		local lang, message = split_line[1], split_line[2]
		
		if lang == "en" then
			table.insert(english_preset_messages, message)
		elseif lang == "cn" then
			table.insert(chinese_preset_messages, message)
		end
		
	end
	english_preset:SetOptions(unpack(english_preset_messages))
	chinese_preset:SetOptions(unpack(chinese_preset_messages))
end
update_presets()
local save_btn = gui.Button(tab, "Save current custom message to preset.", function()
	file.Append(fname, (english and "en," or "cn,") .. custom_msg:GetValue() .. "\n")
	update_presets()
end)

save_btn:SetHeight(18)
save_btn:SetWidth(499)
save_btn:SetPosX(60 + 25 + 5 + 30 + 5)
save_btn:SetPosY(68)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

