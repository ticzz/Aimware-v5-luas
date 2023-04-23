--------GUI Stuff--------
local misc_ref = gui.Reference("Misc")
local tab = gui.Tab(misc_ref, "RetardAlert", "ThighHighs.club")

local left_tab = gui.Groupbox(tab, "Killsay / Deathsay", 10, 15, 310, 400)
local left_tab3 = gui.Groupbox(tab, "Misc", 10, 210, 310, 400)
local right_tab = gui.Groupbox(tab, "Game-Chat", 325, 15, 305, 400)

local enable_killsays = gui.Checkbox(left_tab, "enable.killsays", "Enable Killsay Deathsay", false)
local killsay_mode = gui.Combobox(left_tab, "killsay.mode", "Select Killsay Mode", "Hentai", "Lewd", "Apologetic", "Edgy", "EZfrags", "AFK")
local killsay_speed = gui.Slider(left_tab, "killsay.speed", "Killsay / Deathsay Delay", 0, 0, 5)

local EngineRadar = gui.Checkbox(left_tab3, "engine.radar", "Engine Radar", false)
local ForceCrosshair = gui.Checkbox(left_tab3, "force.crosshair", "Force Crosshair", false)
local RecoilCrosshair = gui.Checkbox(left_tab3, "recoil.crosshair", "Recoil Crosshair", false)

local enable_chatcmds = gui.Checkbox(right_tab, "enable.chatcmds", "Enable Chat Commands", false)
local chat_commands = gui.Multibox(right_tab, "Select Chat Commands")
local enable_ranks = gui.Checkbox(chat_commands, "enable.ranks", "!ranks", true)
local enable_roll = gui.Checkbox(chat_commands, "enable.roll", "!roll", true)
local enable_8ball = gui.Checkbox(chat_commands, "enable.8ball", "!8ball", true)
local enable_gaydar = gui.Checkbox(chat_commands, "enable.gaydar", "!gay", true)
local enable_coin_flip = gui.Checkbox(chat_commands, "enable.flip", "!flip", true)
local enable_anime = gui.Checkbox(chat_commands, "enable.anime", "!anime", true)
local ranks_mode = gui.Combobox(right_tab, "ranks.mode", "Select Chat Mode (Ranks)", "Team Chat", "All Chat")

local enable_throwsay = gui.Checkbox(right_tab, "enable.throwsay", "Enable Grenade Throwsay", false)
local grenade_throwsay = gui.Multibox(right_tab, "Select Grenades")
local enable_hegrenade = gui.Checkbox(grenade_throwsay, "enable.hegrenade", "HE Grenade", true)
local enable_flashbang = gui.Checkbox(grenade_throwsay, "enable.flashbang", "Flashbang", true)
local enable_smokegrenade = gui.Checkbox(grenade_throwsay, "enable.smokegrenade", "Smoke", true)
local enable_molotov = gui.Checkbox(grenade_throwsay, "senable.molotov", "Molotov/Incendiary", true)
local throwsay_speed = gui.Slider(right_tab, "throwsay.speed", "Grenade Throwsay Delay", 0, 0, 5)

local enable_msgevents = gui.Checkbox(right_tab, "enable.msgevents", "Enable Message Events", false)
local msgevents_mode = gui.Combobox(right_tab, "msgevents.mode", "Select Message Mode", "Copy Player Messages", "Chat Breaker")
local msgevents_speed = gui.Slider(right_tab, "msgevents.speed", "Message Events Delay", 0, 0, 5)

local autoDerank = gui.Checkbox(left_tab3, 'enable.auto.derank', 'Automatic Derank', false)
autoDerank:SetDescription('Have the rest of your team leave before the match starts.')

local function Derank(e)
	if e:GetName() == 'round_prestart' and autoDerank:GetValue() or e:GetName() == 'round_start' and autoDerank:GetValue() then
		client.Command('disconnect', true)
		panorama.RunScript("CompetitiveMatchAPI.ActionReconnectToOngoingMatch()")
	end
end


callbacks.Register('FireGameEvent', Derank)

--------Draw Image--------
local function OnUnload()

	if clantagset == 1 then
		set_clantag("", "")
	end
end

--------Miscellaneous--------
client.Command("+right", true)
client.Command("+left", true)
client.Command("snd_menumusic_volume 0", true)
client.Command("cl_timeout 0 0 0 7", true)

--------Engine Radar--------
callbacks.Register('CreateMove', function()
	local isEngineRadarOn = EngineRadar:GetValue() and 1 or 0

	for _, Player in ipairs(entities.FindByClass('CCSPlayer')) do
		Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)

--		--------Force Crosshair--------
--		client.AllowListener('item_equip')
--		callbacks.Register('FireGameEvent', function(e)
--			if not ForceCrosshair:GetValue() or e:GetName() ~= 'item_equip' then
--				if not client.GetConVar('weapon_debug_spread_show') == '3' then
--					client.SetConVar('weapon_debug_spread_show', 0, true)
--				end
--				return
--			end
--		
--			local LocalPlayerIndex = client.GetLocalPlayerIndex()
--			local PlayerIndex = client.GetPlayerIndexByUserID( e:GetInt('userid') )
--			local WeaponType = e:GetInt('weptype')
--		
--			if LocalPlayerIndex == PlayerIndex then
--				if WeaponType == 5 then
--					client.SetConVar('weapon_debug_spread_show', 3, true)
--				end
--			end
--		end)
--		
--		--------Recoil Crosshair--------
--		local function CrosshairRecoil()
--			if RecoilCrosshair:GetValue() and not gui.GetValue("rbot.master") then
--				client.SetConVar("cl_crosshair_recoil", 1, true)
--			else
--				client.SetConVar("cl_crosshair_recoil", 0, true)
--			end
--		end

--------Inventory Unlocker--------
local function UnlockInventory()
	panorama.RunScript('LoadoutAPI.IsLoadoutAllowed = () => true');
end

--------Message Events--------
local ranks = {"S1","S2","S3","S4","SE","SEM","GN1","GN2","GN3","GNM","MG1","MG2","MGE","DMG","LE","LEM","SMFC","GE",}
local numbers = {"1","2","3","4","5","6",}
local responses = {"Yes - definitely.","It is decidedly so.","Without a doubt.","Reply hazy, try again.","Ask again later.","Better not tell you now.","My sources say no.","Outlook not so good.","Very doubtful.",}
local results = {"won the coinflip!","lost the coinflip!",}
local gaydar = {"is gay!","is not gay!",}
local anime = {
    {
        "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄",
        "⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄",
        "⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄",
        "⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄",
        "⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰",
        "⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤",
        "⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗",
        "⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄",
        "⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄",
        "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄",
        "⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄",
        "⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄",
        "⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴",
        "⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿",
    },
    {
        "⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿",
        "⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹",
        "⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆",
        "⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿",
        "⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿",
        "⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿",
        "⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿",
        "⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸",
        "⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸",
        "⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘",
        "⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄",
        "⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄",
        "⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀",
        "⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿",
    },
    {
        "⠄⠄⠄⢀⣤⣾⣿⡟⠋⠄⠄⠄⣀⡿⠄⠊⠄⠄⠄⠄⠄⠄⢸⠇⠄⢀⠃⠙⣿⣿",
        "⣤⠒⠛⠛⠛⠛⠛⠛⠉⠉⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⠄⢀⠊⠄⠄⠈⢿",
        "⣿⣠⠤⠴⠶⠒⠶⠶⠤⠤⣤⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠃⠄⠂⣀⣀⣀⡀⠄",
        "⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠙⠂⠄⠄⠄⠄⠄⠄⢀⢎⠐⠛⠋⠉⠉⠉⠉⠛",
        "⡇⠄⠄⠄⣀⡀⠄⠄⠄⢀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠎⠁⠄⠄⠄⠄⠄⠄⠄⠄",
        "⡧⠶⣿⣿⣿⣿⣿⣿⠲⠦⣭⡃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡀⠄⠄⠄⠄⠄⠄",
        "⡇⠄⣿⣿⣿⣿⣿⣿⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣾⣿⣿⣿⡟⠛⠶⠄",
        "⡇⠄⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣼⣿⣿⣿⣿⡇⠄⠄⢀",
        "⡇⠄⢿⣿⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⡇⠄⠄⢊",
        "⢠⠄⠈⠛⠛⠛⠛⠋⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢿⣿⣿⣿⡦⠁⠄⠄⣼",
        "⢸⠄⠈⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠉⠄⠄⠄⠄⢰⣿",
        "⢸⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠉⠄⢸⣿",
        "⠄⣆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿",
        "⠄⢿⣷⣶⣄⡀⠄⠄⠄⠄⠄⠄⠉⠉⠉⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣴⣿⣿",
        "⠄⢸⣿⣿⣿⣿⣷⣦⣤⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⣠⣤⣶⣿⣿⣿⣿⣿",
    },
    {
        "⣿⠟⣽⣿⣿⣿⣿⣿⢣⠟⠋⡜⠄⢸⣿⣿⡟⣬⢁⠠⠁⣤⠄⢰⠄⠇⢻⢸",
        "⢏⣾⣿⣿⣿⠿⣟⢁⡴⡀⡜⣠⣶⢸⣿⣿⢃⡇⠂⢁⣶⣦⣅⠈⠇⠄⢸⢸",
        "⣹⣿⣿⣿⡗⣾⡟⡜⣵⠃⣴⣿⣿⢸⣿⣿⢸⠘⢰⣿⣿⣿⣿⡀⢱⠄⠨⢸",
        "⣿⣿⣿⣿⡇⣿⢁⣾⣿⣾⣿⣿⣿⣿⣸⣿⡎⠐⠒⠚⠛⠛⠿⢧⠄⠄⢠⣼",
        "⣿⣿⣿⣿⠃⠿⢸⡿⠭⠭⢽⣿⣿⣿⢂⣿⠃⣤⠄⠄⠄⠄⠄⠄⠄⠄⣿⡾",
        "⣼⠏⣿⡏⠄⠄⢠⣤⣶⣶⣾⣿⣿⣟⣾⣾⣼⣿⠒⠄⠄⠄⡠⣴⡄⢠⣿⣵",
        "⣳⠄⣿⠄⠄⢣⠸⣹⣿⡟⣻⣿⣿⣿⣿⣿⣿⡿⡻⡖⠦⢤⣔⣯⡅⣼⡿⣹",
        "⡿⣼⢸⠄⠄⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣕⡜⡌⡝⡸⠙⣼⠟⢱⠏",
        "⡇⣿⣧⡰⡄⣿⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣋⣪⣥⢠⠏⠄",
        "⣧⢻⣿⣷⣧⢻⣿⣿⣿⡇⠄⢀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠂⠄⠄",
        "⢹⣼⣿⣿⣿⣧⡻⣿⣿⣇⣴⣿⣿⣿⣷⢸⣿⣿⣿⣿⣿⣿⣿⣿⣰⠄⠄⠄",
        "⣼⡟⡟⣿⢸⣿⣿⣝⢿⣿⣾⣿⣿⣿⢟⣾⣿⣿⣿⣿⣿⣿⣿⣿⠟⠄⡀⡀",
        "⣿⢰⣿⢹⢸⣿⣿⣿⣷⣝⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠄⠄⣸⢰⡇",
        "⣿⣾⣹⣏⢸⣿⣿⣿⣿⣿⣷⣍⡻⣛⣛⣛⡉⠁⠄⠄⠄⠄⠄⠄⢀⢇⡏⠄",
    },
    {
        "⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣠⣤⣶⣶",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢰⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⣀⣾⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⡏⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿",
        "⣿⣿⣿⣿⣿⣿⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⣿",
        "⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀⣸⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀⠀⠀⠠⣿⣿⣷⠀⢸⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿",
    },
    {
        "⣿⡇⣿⣿⣿⠛⠁⣴⣿⡿⠿⠧⠹⠿⠘⣿⣿⣿⡇⢸⡻⣿⣿⣿⣿⣿⣿⣿",
        "⢹⡇⣿⣿⣿⠄⣞⣯⣷⣾⣿⣿⣧⡹⡆⡀⠉⢹⡌⠐⢿⣿⣿⣿⡞⣿⣿⣿",
        "⣾⡇⣿⣿⡇⣾⣿⣿⣿⣿⣿⣿⣿⣿⣄⢻⣦⡀⠁⢸⡌⠻⣿⣿⣿⡽⣿⣿",
        "⡇⣿⠹⣿⡇⡟⠛⣉⠁⠉⠉⠻⡿⣿⣿⣿⣿⣿⣦⣄⡉⠂⠈⠙⢿⣿⣝⣿",
        "⠤⢿⡄⠹⣧⣷⣸⡇⠄⠄⠲⢰⣌⣾⣿⣿⣿⣿⣿⣿⣶⣤⣤⡀⠄⠈⠻⢮",
        "⠄⢸⣧⠄⢘⢻⣿⡇⢀⣀⠄⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠄⢀",
        "⠄⠈⣿⡆⢸⣿⣿⣿⣬⣭⣴⣿⣿⣿⣿⣿⣿⣿⣯⠝⠛⠛⠙⢿⡿⠃⠄⢸",
        "⠄⠄⢿⣿⡀⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⡾⠁⢠⡇⢀",
        "⠄⠄⢸⣿⡇⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣫⣻⡟⢀⠄⣿⣷⣾",
        "⠄⠄⢸⣿⡇⠄⠈⠙⠿⣿⣿⣿⣮⣿⣿⣿⣿⣿⣿⣿⣿⡿⢠⠊⢀⡇⣿⣿",
        "⠒⠤⠄⣿⡇⢀⡲⠄⠄⠈⠙⠻⢿⣿⣿⠿⠿⠟⠛⠋⠁⣰⠇⠄⢸⣿⣿⣿",
        "⠄⠄⠄⣿⡇⢬⡻⡇⡄⠄⠄⠄⡰⢖⠔⠉⠄⠄⠄⠄⣼⠏⠄⠄⢸⣿⣿⣿",
        "⠄⠄⠄⣿⡇⠄⠙⢌⢷⣆⡀⡾⡣⠃⠄⠄⠄⠄⠄⣼⡟⠄⠄⠄⠄⢿⣿⣿",
    },
    {
        "⣿⢸⣿⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⢿⣿⡇⡇⣿⣿⡇⢹⣿⣿⣿⣿⣿⣿⠄⢸⣿",
        "⡟⢸⣿⣿⣭⣭⡭⣼⣶⣿⣿⣿⣿⢸⣧⣇⠇⢸⣿⣿⠈⣿⣿⣿⣿⣿⣿⡆⠘⣿",
        "⡇⢸⣿⣿⣿⣿⡇⣻⡿⣿⣿⡟⣿⢸⣿⣿⠇⡆⣝⠿⡌⣸⣿⣿⣿⣿⣿⡇⠄⣿",
        "⢣⢾⣾⣷⣾⣽⣻⣿⣇⣿⣿⣧⣿⢸⣿⣿⡆⢸⣹⣿⣆⢥⢛⡿⣿⣿⣿⡇⠄⣿",
        "⣛⡓⣉⠉⠙⠻⢿⣿⣿⣟⣻⠿⣹⡏⣿⣿⣧⢸⣧⣿⣿⣨⡟⣿⣿⣿⣿⡇⠄⣿",
        "⠸⣷⣹⣿⠄⠄⠄⠄⠘⢿⣿⣿⣯⣳⣿⣭⣽⢼⣿⣜⣿⣇⣷⡹⣿⣿⣿⠁⢰⣿",
        "⠄⢻⣷⣿⡄⢈⠿⠇⢸⣿⣿⣿⣿⣿⣿⣟⠛⠲⢯⣿⣒⡾⣼⣷⡹⣿⣿⠄⣼⣿",
        "⡄⢸⣿⣿⣷⣬⣽⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⢀⠉⠙⠛⠛⠳⠽⠿⢠⣿⣿",
        "⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢄⣹⡿⠃⠄⠄⣰⠎⡈⣾⣿⣿",
        "⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⣽⣖⣄⣴⣯⣾⢷⣿⣿⣿",
        "⣧⠸⣿⣿⣿⣿⣿⣿⠯⠊⠙⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣾⣿⣿⣿",
        "⣿⣦⠹⣿⣿⣿⣿⣿⠄⢀⣴⢾⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿⣿⣿⣿",
        "⣿⣿⣇⢽⣿⣿⣿⡏⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⡿⣿⣛⣻⠿⣟⣼⣿⣿⣿⣿⢃",
        "⣿⣿⣿⡎⣷⣽⠻⣇⣿⣿⣿⡿⣟⣵⣿⣟⣽⣾⣿⣿⣿⣿⢯⣾⣿⣿⣿⠟⠱⡟",
        "⣿⣿⣿⣿⢹⣿⣿⢮⣚⡛⠒⠛⢛⣋⣶⣿⣿⣿⣿⣿⣟⣱⠿⣿⣿⠟⣡⣺⢿",
    }
}

local timer = timer or {}
local timers = {}

function timer.Create(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

function timer.Remove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

callbacks.Register("DispatchUserMessage", function(msg)
    if msg:GetID() == 6 then
        local index = msg:GetInt(1)
		local message = msg:GetString(4,1)
        local message2 = msg:GetString(4,1):lower()
        local m = string.match
        local ec = enable_chatcmds:GetValue()
        local ecf = enable_coin_flip:GetValue()

        local player_name = client.GetPlayerNameByIndex(index)
        local lp = entities.GetLocalPlayer()
        local lp_name = client.GetPlayerInfo( lp:GetIndex() )[ "Name" ]
        local number = numbers[math.random(#numbers)]
        local response = responses[math.random(#responses)]
        local result = results[math.random(#results)]
        local thingy = gaydar[math.random(#gaydar)]
		
		if enable_msgevents:GetValue() and msgevents_mode:GetValue() == 0 then
			if player_name ~= lp_name then
				timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
					client.ChatSay(message)
				end)
			end
		elseif enable_msgevents:GetValue() and msgevents_mode:GetValue() == 1 then
			if player_name ~= lp_name then
				timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
					client.ChatSay("﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽")
				end)
			end
		end

        if m(message2, "!roll") and enable_chatcmds:GetValue() and enable_roll:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s rolled a %s'):format(player_name, number)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!8ball") and enable_chatcmds:GetValue() and enable_8ball:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                client.ChatSay("❽: " .. response)
            end)
        end

        if m(message2, "!gay") and enable_chatcmds:GetValue() and enable_gaydar:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, thingy)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!cf") and ec and ecf or m(message2, "!flip") and ec and ecf or m(message2, "!coin flip") and ec and ecf or m(message2, "!coinflip") and ec and ecf then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, result)
                client.ChatSay(msg)
            end)
        end

        if m(message, "!anime") and ec and enable_anime:GetValue() then
            random = math.random(1, #anime)
            for i=1, #anime[random] do
                timer.Create("message_delay", 0.7, i, function()
                    client.ChatSay(anime[random][i])
                end)
            end
        end

        if m(message, "!ranks") and ec and enable_ranks:GetValue() then
            for i, v in next, entities.FindByClass("CCSPlayer") do
                if v:GetName() ~= "GOTV" and entities.GetPlayerResources():GetPropInt("m_iPing", v:GetIndex()) ~= 0 then
                    local index = v:GetIndex()
                    local rank_index = entities.GetPlayerResources():GetPropInt("m_iCompetitiveRanking", index)
                    local wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
                    local rank = ranks[rank_index] or "no rank"
                    if ranks_mode:GetValue() == 0 then 
                        timer.Create("message_delay", 0.7, i, function()
                            client.ChatTeamSay(v:GetName() .. " has " .. wins .. " wins " .. "(" .. rank .. ")")
                        end)

                    elseif ranks_mode:GetValue() == 1 then 
                        timer.Create("message_delay", 0.7, i, function()
                            client.ChatSay(v:GetName() .. " has " .. wins .. " wins " .. "(" .. rank .. ")")
                        end)
                    end
                end
            end
        end
    end
end)

callbacks.Register("Draw", function()
    for k,v in pairs(timers or {}) do
  
        if (v["times"] <= 0) then table.remove(timers, k) end
      
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]()
        end  
    end
end)


--Throwsays
local ThrowSays = {
	hegrenade = {
		'Catch retard!',
		'Heads up!',
		'This is gonna hurt.',
	},

	flashbang = {
		'Look a bird!',
		'Look a plane!',
		'FLASHBANG!',
		'Bang bang bangity bang I said bang bang bangity bang bang bang bang',
	},

	molotov = {
		'Fire hot retard!',
		'BURN BABY BURN!',
	},

	incgrenade = {
		'Fire hot retard!',
		'BURN BABY BURN!',
	},

	smokegrenade = {
		'I am a ninja',
		'Very Sneaky Man',
		'NINJA DEFUSE!',
	},
}

local function for_throwsay(e)
	if not enable_throwsay:GetValue() then
		return
	end

	if e:GetName() ~= 'grenade_thrown' then
		return
	end

	if client.GetPlayerIndexByUserID( e:GetInt('userid') ) ~= client.GetLocalPlayerIndex() then
		return
	end

	local wep = e:GetString('weapon')
	local says = ThrowSays[wep]
	local say_msg =
	   (wep == 'hegrenade' and enable_hegrenade:GetValue()) or 
	   (wep == 'flashbang' and enable_flashbang:GetValue()) or
	   ((wep == 'molotov' or wep == 'incgrenade') and enable_molotov:GetValue()) or
	   (wep == 'smokegrenade' and enable_smokegrenade:GetValue())

	if say_msg then
        timer.Create("message_delay", throwsay_speed:GetValue(), 1, function()
            client.ChatSay( says[math.random(#says)] )
        end)
	end
end


-- KillSays
local KillSays = {
	Hentai = {
		Kill = {
			"S-Sorry onii-chan p-please d-do me harder ;w;",
			"Y-You got me all wet now Senpai!",
			"D-Don't t-touch me there Senpai",
			"P-Please l-love me harder oniichan ohh grrh aahhhh~!",
			"Give me all your cum Senpai ahhhhh~",
			"F-Fuck me harder chan!",
			"Oh my god I hate you so much Senpai but please k-keep fucking me harder! ahhh~",
			"D-Do you like my stripped panties getting soaked by you and your hard cock? ehhh master you're so lewd ^0^~",
			"Kun your cute little dick between my pussy lips looks really cute, I'm blushing",
			"M-Master does it feel good when I slide by tits up and down on your cute manly part?",
			"O-Oniichan my t-toes are so warm with your cum all over them uwu~",
			"Lets take this swimsuit off already <3 i'll drink your unknown melty juice",
			"S-Stop Senpai if we keep making these lewd sounds im going to cum~~",
			"You're such a pervert for filling me up with your baby batter Senpai~~",
			"Fill up my baby chamber with your semen kun ^-^",
			"M-Master d-dont spank my petite butt so hard ahhhH~~~ you're getting me so w-wet~",
			"Senpai your cock is already throbbing from my huge tits~",
			"Hey kun, Can I have some semen?",
			"M-My baby chamber is overflowing with your semen M-Master",
			"Fill my throat pussy with your semen kun",
			"It-It's not gay if you're wearing thigh highs M-Master",
			"I-I need somewhere to blow my load. Can i borrow your bussy?",
			"A-ah shit... Y-your cock is big and in my ass -- already~?!",
			"I'll swallow your sticky essence along with you~!",
			"B-Baka please let me be your femboy sissy cum slut!",
			"That's a penis UwU you towd me you wewe a giww!!",
			"Ahhhh... It's like a dream come true... I get to stick my dick inside your ass...!",
			"Hey, who wants a piece of this plump 19-year-old boy-pussy? Single file, boys, come get it while it's hot!",
			"M-Master, if you keep thrusting that hard, my boobs will fall off!",
			"When do you wanna meet up again? I've really taken a liking to your dick! (,,◠∇◠) I want you and only you to slam it into my pussy every day! (≧∇≦)",
			"All I did was crossplay 'cause I felt like it might be fun... But now I'm just a little girl that cums from big dicks!",
			"D-Don't get the wrong idea!!! I don't w-want you to fuck my b-bussy because I l-love you or anything! d-definitely not!",
			"I-I know I said you could be as rough as you want... But surprise fisting wasn't what I had in mind!!",
			"W-Why is it that lately... Y-You haven't been playing with my ass!!?",
		},

		Death = {
			"Hehe don't touch me there Onii-chann UwU",
			"Your cum is all over my wet clit M-Master",
			"It Feels like you're pounding me with the force of a thousand suns Senpai",
			"Y-Yes right there S-Sempai hooyah",
			"P-Please keep filling my baby chamber S-Sempai",
			"O-Onii-chan it felt so good when you punded my bussy",
			"P-Please Onii-chan keep filling my baby chamber with your melty juice",
			"O-Onii-chan you just one shot my baby chamber",
			"I-Im nothing but a f-fucktoy slut for your m-monster fuckmeat!",
			"Dominate my ovaries with your vicious swimmers!",
			"Y-Your meat septer has penetrated my tight boy hole",
			"Mnn FASTER... HARDER! Turn me into your femboy slut~!",
			"Mmmm- soothe me, caress me, Fuck me, breed me!",
			"Probe your thick, wet, throbbing cock deeper and deeper into my boipussy~!!",
			"Hya! Not my ears! Ah... It tickles! Ah!",
			"Kouta... I can't believe how BIG his... Wait! Forget about that!! Is Nyuu-chan really giving him a Tit-Fuck!?",
			"Senpai shove deeper your penis in m-my pussy (>ω<) please",
			"I'm coming fwom you fwuking my asshole mmyyy!",
			"P-Please be gentle, S-Senpai!",
			"D-Don't get the wrong idea!! I didn't give up my viginity to you because I like you or anything!!",
			"Let me taste your futa cock with my pussy~",
		}
	},

	Lewd = {
		Kill = {
			"Oh do you wanna eat? Do you wanna take a bath? Or do you want me!",
			"It's not gay if you swallow the evidence!",
			"That's a penis UwU you towd me you wewe a giww!!",
			"You are cordially invited to fuck my ass!",
			"Grab them, squeeze them, pinch them, pull them, lick them, bite them, suck them!",
			"It feels like your dick is sliding into a slimy pile of macaroni!",
			"This is the cock block police! Hold it right there!",
			"Ohoo, getting creampied made you cum? What a lewd bitch you are!",
			"I've jerked off every single day... Given birth to countless snails... All while fantasizing about the day I'd get to fuck you!",
			"You're looking at porn when you could be using your little sister instead!",
			"Umm... I don't wanna sound rude, but have you had a bath? Your panties look a bit yellow...",
			"Papa you liar! How could you say that while having such a HUGE erection.",
			"I-I just wanna borrow y-your dick...",
			"If a man inserts his hose into another man's black hole, can they make a baby?",
			"I-I had a itch down there... and I-I just needed something to-to stick up in there!",
			"You have some tasty-looking panties there...",
			"You're my personal cum bucket!!",
			"I-I'm cumming, I'm cumming, CUM with me too!",
			"Your resistance only makes my penis harder!",
			"Cum, you naughty cock! Do it! Do it! DO IT!!!",
			"Boys just can't consider themselves an adult... Until they've had a chance to cum with a girl's ampit.",
			"We're both gonna fuck your pussy at the same time!",
			"When everyone's gone home for the day and the class-room's empty you have no choice but to expose yourself and jerk off, right?",
		},

		Death = {
			"Dominate my ovaries with your vicious swimmers!",
			"Impregnate me with your viral stud genes!",
			"M-My body yearns for your sweet dick milk",
			"My nipples are being tantalized",
			"Penetrate me until I bust!",
			"Mmmm- soothe me, caress me, Fuck me, breed me!",
			"I'm your personal cum bucket!!",
			"Can you really blame me for getting a boner after seeing that?",
			"The two of us will cover my sis with our cum!",
			"This... This is almost like... like somehow I'm the one raping him!",
			"You're impregnating my balls!?",
			"If you weren't a pervert, you wouldn't be getting off on having a girl do you in the butt, would you?",
			"Well, well... What a cutie you are! I will claim your virginity!",
			"Oh, yeahh! You wanna fuck?",
			"I'm getting pissed off and hormy right now!",
		}
	},

	Apologetic = {
		Sorry = {"am sorry that","am feeling sad after","am distressed because","am upset with myself because","have been diagnosed with depression because","am broken hearted that","apologize that","would like to apologize because","am quite remorseful because","am ashamed of myself because"},
		Kill = {"killed","destroyed","put an end to","ended","assassinated","terminated","eliminated","executed","slaughtered","butchered","shot and killed"},
		Regret = {":(","Please forgive me","I didn't mean to.","I'm a failure","I will go easy on you next time.","That was my fault","Please excuse my behaviour"}
	},

	Edgy = {
		Kill = {
			"Let my K/D do the talking",
			"mad cuz bad",
			"No Aimware no talk",
			"Config error, user banned, thread locked.",
			"IQ error",
			"I'm the reason your dads gay faggot",
			"How's your mom doin after last night?",
			"Dead people can't talk nn",
			"Warmth, love, and affection. These are the things I have taken away from you.",
			"I’ve made a contract with the devil, so I can’t be friends with a god.",
			"Corpses are good. They don’t babble.",
			"The weak are destined to lie beneath the boots of the strong.",
			"Options -> How to play",
			"The world is better without you",
			"Life is endless suffering...",
			"I'm just killing the spiders to save the butterflies.",
			"Fear is what creates order.",
			"No matter how much you cry I won't stop.",
			"Deleted",
			"*DEAD*",
			"Re_solved",
			"De_stroyed",
			"If G-D wanted you to live he would not have created me.",
			"Earn your damnation",
			"Vengeance is mine",
			"If at first you do not succeed... try, try again.",
			"Watch your head",
			"When you are ready call for me",
			"I have become death destroyer of worlds",
			"Easy come easy go",
			"I stay you go",
			"End of the line for you",
			"Maybe tomorrow.",
			"I'm fucking invincible.",
			"See you in a couple of minutes.",
			"You are strong child, but I am beyond strength",
		},

		Death = {
			"You only killed me because I ran out of health..",
			"I bet dead people are easier to get along with.",
			"The real hell is inside the person.",
			"The ones who kill should be prepared to be killed.",
			"I gave you that one",
			"Congratulations! You're on the scoarboard now.",
			"Emotions are a mental disorder",
			"Carpe Diem",
			"Gone but not forgotten",
			"I'll be back",
			"Deploying the counter measure",
			"There are no ends only new beginnings",
		}
	},

	EZfrags = {
		Kill = {
			"Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
			"Stop being a noob! Get good with www.EZfrags.co.uk",
			"I'm not using www.EZfrags.co.uk, you're just bad",
			"You just got pwned by EZfrags, the #1 CS:GO cheat",
			"If I was cheating, I'd use www.EZfrags.co.uk",
			"Think you could do better? Not without www.EZfrags.co.uk",
		},

		Death = {
			"You only killed me because I'm not using www.EZfrags.co.uk",
			"You're lucky I'm not using www.EZfrags.co.uk",
			"I would have destroyed you if I was using www.EZfrags.co.uk",
			"You only killed me because you're using www.EZfrags.co.uk the finest public & private CS:GO cheat",
		}
	},

    AFK = {
        AfkSorry = {"Sorry",},
        Kill = {"I'm AFK. This is a bot. You died to a ",}, 
        Death = {"You only killed me because I'm AFK.",}
    },
}


local function for_chatsay(e)
	if not enable_killsays:GetValue() then
		return
	end

	if e:GetName() ~= 'player_death' then
		return
	end

	local mode = killsay_mode:GetString()
	local lp = client.GetLocalPlayerIndex()
	local victim = client.GetPlayerIndexByUserID(e:GetInt('userid'))
	local attacker = client.GetPlayerIndexByUserID(e:GetInt('attacker'))
	local say = KillSays[mode]

	if attacker == lp and victim ~= lp then
		local msg = say.Kill[math.random(#say.Kill)]

		if mode == 'Apologetic' then
			local victim_name = client.GetPlayerNameByIndex(victim)

			local sry1 = say.Sorry[ math.random(#say.Sorry) ]
			local sry3 = say.Regret[ math.random(#say.Regret) ]

			msg = ('%s, I %s I %s you. %s'):format(victim_name, sry1, msg, sry3)
		end

        if mode == 'AFK' then
            local victim_name = client.GetPlayerNameByIndex(victim)
            local attacker_weapon = e:GetString('weapon')

            local afk1 = say.AfkSorry[ math.random(#say.AfkSorry) ]

            msg = ('%s %s, %s %s.'):format(afk1, victim_name, msg, attacker_weapon)
        end

        timer.Create("message_delay", killsay_speed:GetValue(), 1, function()
            client.ChatSay( msg )
        end)
	elseif attacker ~= lp and victim == lp then
		if say.Death then
            timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
                client.ChatSay( say.Death[math.random(#say.Death)] )
			end)
		end
	end
end


--------Lua Callbacks & Listeners--------
client.AllowListener('player_death')
client.AllowListener('grenade_thrown')
client.AllowListener('round_prestart')
client.AllowListener('round_start')
callbacks.Register('FireGameEvent', for_chatsay)
callbacks.Register('FireGameEvent', for_throwsay)
callbacks.Register('CreateMove', CrosshairRecoil)
callbacks.Register("Draw", UnlockInventory)
callbacks.Register("Unload", OnUnload)
