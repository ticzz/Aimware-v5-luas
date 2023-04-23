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

local api_key = ''

------------------------------------
----------- IGNORE BELOW -----------
------------------------------------

if api_key=='' then return error('api_key is empty.')end
local url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
local translate_url = url..'?key='..api_key

local ChatSay, Get, byte, tonumber, char, gsub, gmatch, Text, format, concat = client.ChatSay, http.Get, string.byte, tonumber, string.char, string.gsub, string.gmatch, gui.Text, string.format, table.concat
local cth = function(c)return format("%%%02X",c:byte()or'')end
local htc = function(x)return tonumber(x,16):char()end
local encode = function(u)return u:gsub("\n","\r\n"):gsub("([^%w ])",cth):gsub(" ","+")end
local decode = function(u)return u:gsub("+"," "):gsub("%%(%x%x)",htc)end
local in_table=function(t,a)for i=1,#t do if t[i]==a then return true end end end

local menu_open, MENU = true, gui.Reference('MENU')
local w=gui.Window('lan_wm', 'Translation', 100, 100, 400, 405)
local g=gui.Groupbox(w,'Console Commands',15,15,185,125)Text(g,'-languages')Text(g,'-translate [from] [to] [text]')Text(g,'example:')Text(g,'-translate en ru Hello')
local g2,g3=gui.Groupbox(w,'Languages',215,15,170,345),gui.Groupbox(w,'Translate',15,150,185,210)
Text(g3,'From')local _FROM=gui.Editbox(g3,'translate_from','')Text(g3,'To')local _TO=gui.Editbox(g3,'translate_to','')Text(g3,'Text')local _TEXT=gui.Editbox(g3,'translate_text','')

local langs, langs2 = {}, {}
Get('https://pastebin.com/raw/udLBVaym', function(cnt)
	for line in cnt:gmatch('([^\n]*)\n') do
		langs[#langs + 1] = line
		Text(g2, line)
	end

	for i=1,#langs do
		local words = {}

		for c in langs[i]:gmatch('([^->]*)$') do
			words[#words + 1] = c:sub(2, -2)
		end

		langs2[#langs2 + 1] = words[1]
	end
end)

local get_translation = function(from, to, text)
	local text = '&text='.. encode(text)
	local from_to = '&lang='..from..'-'..to

	Get(translate_url.. text.. from_to, function(cnt)
		local txt = decode(cnt)
		local text = txt:match('\"text":(.*)\"'):gsub('[[]"','')
		ChatSay(text)
	end)
end

gui.Button(g3,'Say in Chat',function()get_translation(_FROM:GetValue(), _TO:GetValue(), _TEXT:GetValue())end)

local function OnSendStringCmd(CMD)
	local cmd = CMD:Get()

	if cmd:find('-languages') then
		for i=1, #langs do
			print(langs[i])
		end

		return CMD:Set('Output_in_Aimware_Console.')
	end

	if cmd:sub(1, 10) == '-translate' then
		local s, t, N = {}, {}, 1
		for word in cmd:gmatch('([^ ]*)') do
			if N > 3 then
				t[#t + 1] = word
			else
				s[N] = word
			end
			N=N+1
		end

		local from = in_table(langs2, s[2]) and s[2] or 'en'
		local to = in_table(langs2, s[3]) and s[3] or 'en'
		local text = concat(t, ' ')

		get_translation(from, to, text)
		CMD:Set('')
	end
end

callbacks.Register('SendStringCmd', OnSendStringCmd)
gui.Button(gui.Reference('SETTINGS','Miscellaneous'),'Show/Hide Translation Window',function()menu_open=not menu_open end)
callbacks.Register('Draw', function()w:SetActive(menu_open and MENU:IsActive())end)
