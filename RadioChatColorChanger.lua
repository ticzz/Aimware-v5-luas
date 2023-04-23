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

local RColor_index = {"Normal", "White", "Grey", "DarkGreen", "LightGreen", "LightDarkGreen", "LightBlue", "DarkBlue", "Purple", "LightRed", "DarkRed", "Gold"} -- for comboboxes

local function SendColoredRadioMessage(...)
    local processed_str = ""
    for i, v in pairs({...}) do
        processed_str = processed_str .. v
    end
    client.Command('playerchatwheel . "' .. processed_str .. '"', true)
end

-- ColoredRadioMessage(RColor.DarkRed, "Red! ", RColor.LightBlue, "Blue!")
--- paste above stuff to use colored radio chat for ur script

local tab = gui.Tab(gui.Reference("Misc"), "Chicken.RaidoColor.tab", "Radio color")
local color_picker = gui.Combobox(tab, "Chicken.RaidoColor.ColorPicker", "Colors", unpack(RColor_index))

local chat_spam = gui.Combobox( tab, "Chicken.RaidoColor.spam", "Enable mode", "Manaul send", "Auto spam");

local custom_msg = gui.Editbox( tab, "Chicken.RadioColor.messageentry", "custom message:");
local custom_msg_spam_delay = gui.Slider( tab, "Chicken.RadioColor.delay","Delay in Seconds" , 10,0.1,60)

local btn = gui.Button(tab, "Send", function()
    local color = RColor_index[color_picker:GetValue() + 1]
    SendColoredRadioMessage(RColor[color], custom_msg:GetValue())
end)
btn:SetWidth(608)

local delay = 0
callbacks.Register("Draw", function()
	local message = custom_msg:GetValue()
	if globals.CurTime() > delay and chat_spam:GetValue() == 1 and string.len(message) > 0 then
		local color = RColor_index[color_picker:GetValue() + 1]
		SendColoredRadioMessage(RColor[color], custom_msg:GetValue())
		delay = globals.CurTime() + custom_msg_spam_delay:GetValue()
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

