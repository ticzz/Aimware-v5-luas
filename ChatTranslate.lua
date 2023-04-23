--[[
	How to use:
		Go to: https://passport.yandex.com/
		if you don't have an account, create one.
		After that go to: https://translate.yandex.com/developers/keys
		Click: https://i.imgur.com/hT36B17.png [Create a new key]
		Once you've done that click: https://i.imgur.com/0TGozfg.png
		After you've done that, paste the key into
			local api_key = ''
		
		So it should look like:
			https://i.imgur.com/giMswWQ.png
--]]
local api_key = 'trnsl.1.1.20200524T120406Z.b79a9c64a32d6281.486b24d7c476b909d31ae3809f20c78a895e1a4f'

------------------------------------
-----------	IGNORE BELOW -----------
------------------------------------

if api_key=='' then return error('api_key is empty.')end
local url = 'https://translate.yandex.net/api/v1.5/tr.json/translate?key='..api_key

local spacing = '     ------------------------------------------   Translations   ------------------------------------------'
local cth = function(c)return string.format("%%%02X",c:byte()or'')end
local htc = function(x)return tonumber(x,16):char()end
local encode = function(u)return u:gsub("\n","\r\n"):gsub("([^%w ])",cth):gsub(" ","+")end
local decode = function(u)return u:gsub("+"," "):gsub("%%(%x%x)",htc)end

local show_menu = gui.Keybox(gui.Reference('Misc', 'General', 'Extra'), 'show_translation_menu', 'Toggle Translation Menu', 0)
local window = gui.Window('translation', 'Translate Window', 300, 300, 580, 399)
local background = gui.Listbox(window, 'translated', 268, spacing)
background:SetPosX(17)
background:SetPosY(87)
background:SetWidth(546)

http.Get('https://pastebin.com/raw/udLBVaym', function(cnt)
	local langs, keys = {}, {}

	for line in cnt:gmatch('([^\n]*)\n') do	
		local words = {}
		for word in line:gmatch('[A-Za-z]*') do
			words[#words + 1] = word
		end

		langs[words[1]] = words[6]
		keys[#keys + 1] = words[1]
	end

	_G.Langs = langs
	_G.Keys = keys
end)
local langs, keys = _G.Langs, _G.Keys
local messages = {}

local active = gui.Checkbox(window, 'active', 'Active', false)
active:SetDescription('Log sent messages.')
active:SetPosX(17)
active:SetPosY(16)

local from = gui.Combobox(window, 'from', 'From Language', 'Auto', unpack(keys))
from:SetDescription('Language to translate from.')
from:SetPosX(126)
from:SetPosY(16)
from:SetWidth(133)

local to = gui.Combobox(window, 'to', 'To Language', 'Auto', unpack(keys))
to:SetDescription('Language to translate to.')
to:SetPosX(275)
to:SetPosY(16)
to:SetWidth(133)

local clear = gui.Button(window, 'Clear Messages', function() messages = {} background:SetOptions(spacing) end)
clear:SetPosX(424)
clear:SetPosY(16) 
clear:SetHeight(16) 

local function chat_translate(text, to, from, sender)
	local text = '&text='.. encode(text)
	local lang = to and to or 'en'

	if to and from then
		lang = from.. '-'.. to
	end

	http.Get(url..text..'&lang='..lang, function(c)
		messages[#messages + 1] = sender.. ': '.. decode(c):match('\"text":(.*)\"'):gsub('[[]"', '')
		background:SetOptions( spacing, unpack(messages) )
	end)
end

local function main(msg)
	if not active:GetValue() then
		return
	end

	if msg:GetID() == 6 then
		chat_translate( msg:GetString(4, 1), langs[keys[to:GetValue()]], langs[keys[from:GetValue()]], client.GetPlayerNameByIndex(msg:GetInt(1)) )
	end
end

callbacks.Register('DispatchUserMessage', main)
callbacks.Register('CreateMove', function() window:SetOpenKey(show_menu:GetValue()) end)
