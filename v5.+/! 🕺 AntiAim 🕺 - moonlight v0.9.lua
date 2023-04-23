local setConVar = function(name, value, unrestrict) if client.GetConVar(name) ~= value then client.SetConVar(name, value, unrestrict) end end
local gv = gui.GetValue
local sv = function(name, value) local val = gv(name) if val == true then val = 1 elseif val == false then val = 0 elseif val == "On" then val = 1 elseif val == "Off" then val = 0 end if val ~= value then gui.SetValue(name, value) return end end

gui.Command("clear")
local scriptVersion = "0.9"
local latestScriptVersion
if http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/ver.txt") == nil then
	print("Unable to fetch version information. Please check your internet connection.")
	latestScriptVersion = "9"
elseif http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/ver.txt") == "404: Not Found" then
	print([[
Unable to fetch version information. Please post this on the Discord server:
---------------------
download error
file not found
---------------------
]])
	latestScriptVersion = "9"
else
	latestScriptVersion = http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/ver.txt"):gsub("\n", "")
end
if scriptVersion == latestScriptVersion then
	print("\n\nYou're running the latest version of moonlight (v" .. scriptVersion .. ")!")
elseif scriptVersion < latestScriptVersion then
	print("\n\nYou're running an older or modified version of moonlight (v" .. scriptVersion .. ")!")
	print("Latest offical version: v" .. latestScriptVersion)
	print("Get it @ https://www.xbluescripts.xyz/scripts/moonlight/")
else
	print("\n\n𝗬𝗼𝘂'𝗿𝗲 𝗿𝘂𝗻𝗻𝗶𝗻𝗴 𝗮 𝗺𝗼𝗱𝗶𝗳𝗶𝗲𝗱 𝘃𝗲𝗿𝘀𝗶𝗼𝗻 𝗼𝗳 𝗺𝗼𝗼𝗻𝗹𝗶𝗴𝗵𝘁 (v" .. scriptVersion .. ")!")
end

local logoImageTexture = draw.CreateTexture(common.DecodePNG(http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/files/logo.png")))
local awlogoImageTexture = draw.CreateTexture(common.DecodePNG(http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/files/awlogo.png")))
local moonlightGui = gui.XML(
[[
	<Window var="moonlight" name="       𝚖𝚘𝚘𝚗𝚕𝚒𝚐𝚑𝚝           " width="600" height="600">
		<Tab var="main" name="            𝚖𝚊𝚒𝚗"></Tab>
		<Tab var="legit" name="           𝚕𝚎𝚐𝚒𝚝"></Tab>
		<Tab var="esp" name="             𝚎𝚜𝚙"></Tab>
		<Tab var="other" name="           𝚘𝚝𝚑𝚎𝚛"></Tab>
	</Window>
]])

local mainTab 	=  moonlightGui:Reference("main")
local legitTab	=  moonlightGui:Reference("legit")
local espTab 	=  moonlightGui:Reference("esp")
local otherTab	=  moonlightGui:Reference("other")

local moonlightFont1 = draw.CreateFont("Bahnschrift Light", 20, 0, 900)
local moonlightFont2 = draw.CreateFont("Sitka Small", 20, 0, 0)
local moonlightFont3 = draw.CreateFont("Sitka Small", 18, 0, 0) -- spec list / indicators
local moonlightFont4 = draw.CreateFont("Sitka Small", 15, 0, 0) -- watermark

local screenWidth, screenHeight = draw.GetScreenSize()
local moduleWidth = screenWidth * 0.07 -- 0.5 centre
local moduleHeight = screenHeight * 0.46 -- 0.485 above crosshair


--  ███    ███  █████  ██ ███   ██ 
--  ████  ████ ██   ██ ██ ████  ██ 
--  ██ ████ ██ ███████ ██ ██ ██ ██ 
--  ██  ██  ██ ██   ██ ██ ██  ████ 
--  ██      ██ ██   ██ ██ ██   ███ 

local mainScriptToggleBox = gui.Groupbox(mainTab, "Master Switch", 10, 10, 285, 30)
local script_toggle = gui.Checkbox(mainScriptToggleBox, "masterswitch", "Master Switch", false)
script_toggle:SetDescription("Enable moonlight lua script.")

local menu_main_hud = gui.Groupbox(mainTab, "HUD Options", 10, 130, 285, 50)
local draw_watermark = gui.Checkbox(menu_main_hud, "watermark", 'Draw Watermark', false)
draw_watermark:SetDescription('Show moonlight watermark on the screen.')
local watermark_logo = gui.Checkbox(menu_main_hud, "watermark.logo", 'Watermark Logo', false)
watermark_logo:SetDescription('Show moonlight logo in the watermark.')
watermark_logo:SetDisabled(true)

callbacks.Register("Draw", function()
	if script_toggle:GetValue() and draw_watermark:GetValue() then
		local ping = ""
		if entities.GetLocalPlayer() ~= nil then
			ping = " | " .. (entities.GetPlayerResources():GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex()) .. " ms")
		end
		draw.SetFont(moonlightFont4)
		local user = cheat.GetUserName()
		local temp = draw.GetTextSize(user .. ping)
		draw.Color(0, 0, 20, 255)
		if watermark_logo:GetValue() then
			draw.ShadowRect(screenWidth-116-temp, 20, screenWidth-20, 42, 4)
			draw.Color(57, 108, 255, 255)
			draw.Line(screenWidth-115-temp, 20, screenWidth-20, 20)
			draw.Color(255, 255, 255, 255)
			draw.TextShadow(screenWidth-90-temp, 27, "moonlight | " .. user .. ping)
			draw.SetTexture(logoImageTexture)
			draw.FilledRect(screenWidth-111-temp, 22, screenWidth-93-temp, 40) -- 18x18px
		else
			draw.ShadowRect(screenWidth-96-temp, 20, screenWidth-20, 42, 4)
			draw.Color(57, 108, 255, 255)
			draw.Line(screenWidth-95-temp, 20, screenWidth-20, 20)
			draw.Color(255, 255, 255, 255)
			draw.TextShadow(screenWidth-90-temp, 27, "moonlight | " .. user .. ping)
		end
		watermark_logo:SetDisabled(false)
	else
		watermark_logo:SetDisabled(true)
	end
end)

local drawToggles = gui.Checkbox(menu_main_hud, "toggles", "Draw Toggles List", false)
drawToggles:SetDescription("Show toggles list.")
local drawTogglesColours = {
	gui.ColorPicker(drawToggles, "togglesListWindowNameColour", "Toggles List Window Name Colour", 255, 255, 255, 255),
	gui.ColorPicker(drawToggles, "togglesListNameColour", "Toggles List Name Colour", 57, 108, 255, 255)
}

local minimiseWindow = gui.Window("minimiseWindow", "moonlight mini", 100, 100, 160, 90)
minimiseWindow:SetActive(true)
local changeAimwareMenuLogo = gui.Checkbox(menu_main_hud, "changeAimwareMenuLogo", "Change Menu Icon", false)
changeAimwareMenuLogo:SetDescription("Change default aimware logo to moonlight.")
callbacks.Register("Draw", function()
	if changeAimwareMenuLogo:GetValue() and script_toggle:GetValue() then
		gui.Reference("Menu"):SetIcon(logoImageTexture, 0.75)
	else
		gui.Reference("Menu"):SetIcon(awlogoImageTexture, 0.8)
	end
end)

local minimise = false
local minimiseToggle1 = gui.Button(mainTab, "Minimise", function() minimise = true end)
minimiseToggle1:SetWidth(95); minimiseToggle1:SetHeight(25); minimiseToggle1:SetPosX(494); minimiseToggle1:SetPosY(508)
local minimiseToggle2 = gui.Button(minimiseWindow, "Maximise", function() minimise = false end)

callbacks.Register("Draw", function()
	if minimise then
		moonlightGui:SetInvisible(true)
		if not gui.Reference("Menu"):IsActive() then
			minimiseWindow:SetActive(false)
		else
			minimiseWindow:SetActive(true)
		end
	else
		minimiseWindow:SetActive(false)
		if not gui.Reference("Menu"):IsActive() then
			moonlightGui:SetInvisible(true)
		else
			moonlightGui:SetInvisible(false)
		end
	end
end)

local mainScriptInfoBox = gui.Groupbox(mainTab, "Welcome to moonlight v" .. scriptVersion, 305, 10, 285, 30)
local additionalText = ""
if math.random(1, 10) == 8 then
	additionalText = [[
If you like what you see, please leave a +rep
on my forums profile! Thanks!

]]
end
local usageInformation = gui.Text(mainScriptInfoBox, [[
Thank you for using my script.

]]
.. additionalText ..
[[
The settings in the "Other" category can be
used without enabling the Master Switch.

User: ]] .. cheat.GetUserName() .. "\nUser ID: " .. cheat.GetUserID())
if scriptVersion < latestScriptVersion then
	local warnUserAboutUpdate = gui.Text(mainScriptInfoBox, "A new version of moonlight is available!\nCurrently running v" .. scriptVersion .. ", latest release: v" .. latestScriptVersion)
	local updateMoonlight = gui.Button(mainScriptInfoBox, "Update to v" .. latestScriptVersion, function()
		http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/moonlight%20v" .. latestScriptVersion .. ".lua", function(content)
			local f = file.Open("moonlight v".. latestScriptVersion .. ".lua" , "w")
			f:Write(content)
			f:Close()
		end)
	end)
	local moonlightWebsite = gui.Button(mainScriptInfoBox, "Website", function()
		panorama.RunScript('SteamOverlayAPI.OpenExternalBrowserURL("https://www.xbluescripts.xyz/scripts/moonlight/")')
	end)
elseif scriptVersion ~= latestScriptVersion then
	local warnUserAboutUpdate = gui.Text(mainScriptInfoBox, "You are using a modified version of moonlight!\nCurrently running v" .. scriptVersion .. ", latest release: v" .. latestScriptVersion)
end

local mainMenuCredits = gui.Text(mainTab, "𝙈𝙖𝙙𝙚 𝙗𝙮 𝙭𝘽𝙡𝙪𝙚 | 404765")
mainMenuCredits:SetPosX(10)
mainMenuCredits:SetPosY(524)

--  ██    ██  █████  ██████   ██████ 
--  ██    ██ ██   ██ ██   ██ ██      
--   ██  ██  ███████ ██████   █████  
--    ████   ██   ██ ██   ██      ██ 
--     ██    ██   ██ ██   ██ ██████  

local espMainVariables = {
	"esp.overlay.enemy.name",
	"esp.overlay.enemy.health.healthbar",
	"esp.overlay.enemy.health.healthnum",
	"esp.overlay.enemy.weapon",
	"esp.overlay.enemy.ammo",
	"esp.overlay.enemy.money",
	"esp.overlay.enemy.dormant",
	"esp.overlay.enemy.flags.defusing",
	"esp.overlay.enemy.flags.planting",
	"esp.overlay.enemy.flags.scoped",
	"esp.overlay.enemy.flags.reloading",
	"esp.overlay.enemy.flags.flashed",
	"esp.overlay.enemy.flags.hasdefuser",
	"esp.overlay.enemy.flags.hasc4",
	"esp.overlay.enemy.ping",
	"esp.overlay.weapon.name",
	"esp.overlay.weapon.defuser",
	"esp.overlay.weapon.c4timer",
	"esp.overlay.enemy.box",
	"esp.overlay.enemy.skeleton",
	"esp.overlay.enemy.armor",
	"esp.overlay.enemy.barrel"
}
local miscOtherVariables = {
	"lbot.master",
	"lbot.extra.backtrack",
	"lbot.trg.enable",
	"lbot.antiaim.type",
	"lbot.aim.enable",
	"misc.autojump",
	"lbot.trg.key",
	"lbot.trg.autofire"
}
local legitTriggerbotItems = {
	"lbot.trg.shared.",
	"lbot.trg.zeus.",
	"lbot.trg.pistol.",
	"lbot.trg.hpistol.",
	"lbot.trg.smg.",
	"lbot.trg.rifle.",
	"lbot.trg.shotgun.",
	"lbot.trg.scout.",
	"lbot.trg.asniper.",
	"lbot.trg.sniper.",
	"lbot.trg.lmg."
}
local eventList = {
	"round_start",
	"round_end",
	"player_connect",
	"player_disconnect",
	"round_prestart",
	"player_death"
}
local indicatorItems = {}
indicatorItems.toggleList = {
	"aimbot",
	"triggerbot",
	"bunnyhop",
	"esp",
	"backtrack",
	"chams"
}
indicatorItems.toggleColours = {
	{255, 255, 255, 255},
	{3, 252, 165, 255},	 
	{3, 252, 74, 255},	 
	{3, 132, 252, 255},	 
	{212, 51, 51, 255},	 
}
indicatorItems.toggleListBTStates = {
	"off",
	"50",
	"100",
	"200",
	"400"
}
indicatorItems.toggleListValues = {
	0,
	0,
	0,
	0,
	1
}
local btGroupWpns = {
    "Pistols",
    "Heavy Pistols",
    "Rifles",
    "Scout",
    "AWP",
    "Autosniper",
    "SMGs",
    "Shotguns",
    "LMGs",
    "Shared"
}
local isHealthBarEspEnabled

local chams_values_size = {5, 4, 4, 4, 4, 5, 4, 4, 5, 4, 4, 4, 4, 4, 4}
local chams_values_names = {
	"Enemy Model", "Enemy Attachments", "Enemy Ragdoll", "Enemy Backtrack", "Enemy On Shot", "Friendly Model", "Friendly Attachments", "Friendly Ragdoll", "Local Model", "Local Weapon Model", "Local Arms", "Local Attachments", "Local Fake", "Weapons", "Grenades"
}
local chams_values_vars = {
	"enemy.model", "enemy.attachment", "enemy.ragdoll", "enemy.backtrack", "enemy.onshot", "friendly.model", "friendly.attachment", "friendly.ragdoll", "local.model", "local.weapon", "local.arms", "local.attachment", "local.fake", "other.weapon", "other.grenade"
}
local chams_values = {}
chams_values[1] = {
	"esp.chams.enemy.occluded"							,	0,
	"esp.chams.enemy.visible"							,	0,
	"esp.chams.enemy.overlay.glow"						,	0,
	"esp.chams.enemy.overlay.glowhealth"				,	0,
	"esp.chams.enemy.overlay.wireframe"					,	0
}
chams_values[2] = {
	"esp.chams.enemyattachments.occluded"				,	0,
	"esp.chams.enemyattachments.visible"				,	0,
	"esp.chams.enemyattachments.overlay.glow"			,	0,
	"esp.chams.enemyattachments.overlay.wireframe"		,	0
}
chams_values[3] = {
	"esp.chams.enemyragdoll.occluded"					,	0,
	"esp.chams.enemyragdoll.visible"					,	0,
	"esp.chams.enemyragdoll.overlay.glow"				,	0,
	"esp.chams.enemyragdoll.overlay.wireframe"			,	0
}
chams_values[4] = {
	"esp.chams.backtrack.occluded"						,	0,
	"esp.chams.backtrack.visible"						,	0,
	"esp.chams.backtrack.overlay.glow"					,	0,
	"esp.chams.backtrack.overlay.wireframe"				,	0
}
chams_values[5] = {
	"esp.chams.onshot.occluded"							,	0,
	"esp.chams.onshot.visible"							,	0,
	"esp.chams.onshot.overlay.glow"						,	0,
	"esp.chams.onshot.overlay.wireframe"				,	0
}
chams_values[6] = {
	"esp.chams.friendly.occluded"						,	0,
	"esp.chams.friendly.visible"						,	0,
	"esp.chams.friendly.overlay.glow"					,	0,
	"esp.chams.friendly.overlay.glowhealth"				,	0,
	"esp.chams.friendly.overlay.wireframe"				,	0
}
chams_values[7] = {
	"esp.chams.friendlyattachments.occluded"			,	0,
	"esp.chams.friendlyattachments.visible"				,	0,
	"esp.chams.friendlyattachments.overlay.glow"		,	0,
	"esp.chams.friendlyattachments.overlay.wireframe"	,	0
}
chams_values[8] = {
	"esp.chams.friendlyragdoll.occluded"				,	0,
	"esp.chams.friendlyragdoll.visible"					,	0,
	"esp.chams.friendlyragdoll.overlay.glow"			,	0,
	"esp.chams.friendlyragdoll.overlay.wireframe"		,	0
}
chams_values[9] = {
	"esp.chams.local.occluded"							,	0,
	"esp.chams.local.visible"							,	0,
	"esp.chams.local.overlay.glow"						,	0,
	"esp.chams.local.overlay.glowhealth"				,	0,
	"esp.chams.local.overlay.wireframe"					,	0
}
chams_values[10] = {
	"esp.chams.localweapon.occluded"					,	0,
	"esp.chams.localweapon.visible"						,	0,
	"esp.chams.localweapon.overlay.glow"				,	0,
	"esp.chams.localweapon.overlay.wireframe"			,	0
}
chams_values[11] = {
	"esp.chams.localarms.occluded"						,	0,
	"esp.chams.localarms.visible"						,	0,
	"esp.chams.localarms.overlay.glow"					,	0,
	"esp.chams.localarms.overlay.wireframe"				,	0
}
chams_values[12] = {
	"esp.chams.localattachments.occluded"				,	0,
	"esp.chams.localattachments.visible"				,	0,
	"esp.chams.localattachments.overlay.glow"			,	0,
	"esp.chams.localattachments.overlay.wireframe"		,	0
}
chams_values[13] = {
	"esp.chams.ghost.occluded"							,	0,
	"esp.chams.ghost.visible"							,	0,
	"esp.chams.ghost.overlay.glow"						,	0,
	"esp.chams.ghost.overlay.wireframe"					,	0
}
chams_values[14] = {
	"esp.chams.weapon.occluded"							,	0,
	"esp.chams.weapon.visible"							,	0,
	"esp.chams.weapon.overlay.wireframe"				,	0,
	"esp.chams.weapon.overlay.glow"						,	0
}
chams_values[15] = {
	"esp.chams.nades.occluded"							,	0,
	"esp.chams.nades.visible"							,	0,
	"esp.chams.nades.overlay.glow"						,	0,
	"esp.chams.nades.overlay.wireframe"					,	0
}


local chams_cached = false
local chams_returned = false
local chams_disabled = false



--  ██      ███████  ██████  ██ ████████ 
--  ██      ██      ██       ██    ██    
--  ██      █████   ██   ██  ██    ██    
--  ██      ██      ██    ██ ██    ██    
--  ███████ ███████  ██████  ██    ██    

local menu_main = gui.Groupbox(legitTab, "Legit Toggle", 10, 10, 285, 50)
local legitTabToggle = gui.Checkbox(menu_main, "legitTabToggle", "Legit Toggle", false)
legitTabToggle:SetDescription("Toggle Legit tab settings.")

local menu_legit_backtrack = gui.Groupbox(legitTab, "Backtrack Settings", 10, 130, 285, 50)
local btGroupWpnSelection = gui.Combobox(menu_legit_backtrack, "btGroupWpnSelection", "Backtrack Weapon Group", unpack(btGroupWpns))
btGroupWpnSelection:SetDescription("Select weapon group to configure backtrack time for.")
local btWpnSlider = {
	gui.Slider(menu_legit_backtrack, "wpnPistol", "Pistols Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnHpistol", "Heavy Pistols Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnRifle", "Rifles Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnScout", "Scout Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnAWP", "AWP Backtrack Time", 0, 0, 400, 5),
    gui.Slider(menu_legit_backtrack, "wpnAuto", "Autosniper Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnSMG", "SMGs Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnSG", "Shotguns Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnLMG", "LMGs Backtrack Time", 0, 0, 400, 5),
	gui.Slider(menu_legit_backtrack, "wpnShared", "Shared Backtrack Time", 0, 0, 400, 5)
}

local btDecKey = gui.Keybox(menu_legit_backtrack, "btDecKey", "Decrease", 37)
btDecKey:SetDescription("Decrease BT time.")
btDecKey:SetWidth(120)
local btIncKey = gui.Keybox(menu_legit_backtrack, "btIncKey", "Increase", 39)
btIncKey:SetDescription("Increase BT time.")
btIncKey:SetWidth(120)
btIncKey:SetPosX(134)
btIncKey:SetPosY(132)

local backtrack_change_value = gui.Slider(menu_legit_backtrack, "backtrack.changevalue", "Change Value", 5, 5, 50, 5)
backtrack_change_value:SetDescription("Set by how much bactrack is increased/decreased.")
backtrack_change_value:SetPosX(0)
local backtrack_randomisation = gui.Checkbox(menu_legit_backtrack, "backtrack.randomisation.toggle", "Randomise Time", false)
backtrack_randomisation:SetDescription("Randomise backtrack value.")
local backtrack_randomisation_amount = gui.Slider(menu_legit_backtrack, "backtrack.randomisation.amount", "Randomisation Amount", 25, 0, 100, 5)
backtrack_randomisation_amount:SetDescription("Min and max bactrack time randomisation amount.")
local backtrack_ping = gui.Checkbox(menu_legit_backtrack, "backtrack.ping.toggle", "Add Ping", false)
backtrack_ping:SetDescription("Add your ping to the backtrack time.")
local backtrack_ping_multiplier = gui.Slider(menu_legit_backtrack, "backtrack.ping.multiplier", "Ping Multiplier", 0.67, 0.25, 1.75, 0.01)
backtrack_ping_multiplier:SetDescription("Set a custom multiplier for ping added to backtrack.")
for i=1, #btWpnSlider do
    btWpnSlider[i]:SetInvisible(true)
    btWpnSlider[i]:SetDescription("Change the "..btGroupWpns[i].." backtrack time.")
end
local btCurWpn = 10
local btWpnClassInt = 0

local function getCurWpn()
    if entities.GetLocalPlayer() ~= nil then
        local player = entities.GetLocalPlayer()
		if player:GetWeaponID() ~= nil then
        	btCurWpn = player:GetWeaponID()
		end
        if btCurWpn == 2 or btCurWpn == 3 or btCurWpn == 4 or btCurWpn == 30 or btCurWpn == 32 or btCurWpn == 36 or btCurWpn == 61 or btCurWpn == 63 then
            btWpnClassInt = 1
        elseif btCurWpn == 1 then
            btWpnClassInt = 2
        elseif btCurWpn == 7 or btCurWpn == 8 or btCurWpn == 10 or btCurWpn == 13 or btCurWpn == 16 or btCurWpn == 39 or btCurWpn == 61 then
            btWpnClassInt = 3
        elseif btCurWpn == 40 then
            btWpnClassInt = 4
        elseif btCurWpn == 9 then
            btWpnClassInt = 5
        elseif btCurWpn == 38 or btCurWpn == 11 then
            btWpnClassInt = 6
        elseif btCurWpn == 17 or btCurWpn == 19 or btCurWpn == 23 or btCurWpn == 24 or btCurWpn == 26 or btCurWpn == 33 or btCurWpn == 34 then
            btWpnClassInt = 7
        elseif btCurWpn == 25 or btCurWpn == 27 or btCurWpn == 29 or btCurWpn == 35 then
            btWpnClassInt = 8
        elseif btCurWpn == 28 or btCurWpn == 14 then
            btWpnClassInt = 9
        else
            btWpnClassInt = 10
        end
    end
end

callbacks.Register("Draw", function()
	btWpnSlider[btGroupWpnSelection:GetValue()+1]:SetInvisible(false)
		for i=1, #btWpnSlider do
			if i ~= btGroupWpnSelection:GetValue()+1 then
				btWpnSlider[i]:SetInvisible(true)
			end
		end
	if script_toggle:GetValue() and legitTabToggle:GetValue() then
		getCurWpn()
		local bt = 0

		if entities.GetLocalPlayer() ~= nil then
			bt = btWpnSlider[btWpnClassInt]:GetValue()
			if backtrack_ping:GetValue() then
				bt = bt + math.floor(entities.GetPlayerResources():GetPropInt("m_iPing", entities.GetLocalPlayer():GetIndex())*backtrack_ping_multiplier:GetValue())
			end
			if backtrack_randomisation:GetValue() then
				local tmp = backtrack_randomisation_amount:GetValue()
				bt = bt + math.random(-tmp, tmp)
			end
		end

		sv("lbot.extra.backtrack", bt)
		
		if btDecKey:GetValue() then
			if input.IsButtonPressed(btDecKey:GetValue()) then
				btWpnSlider[btGroupWpnSelection:GetValue()+1]:SetValue(btWpnSlider[btGroupWpnSelection:GetValue()+1]:GetValue()-backtrack_change_value:GetValue())
			end
		end
		if btIncKey:GetValue() then
			if input.IsButtonPressed(btIncKey:GetValue()) then
				btWpnSlider[btGroupWpnSelection:GetValue()+1]:SetValue(btWpnSlider[btGroupWpnSelection:GetValue()+1]:GetValue()+backtrack_change_value:GetValue())
			end
		end
	end
end)

callbacks.Register("FireGameEvent", function(e)
    getCurWpn()
	if script_toggle:GetValue() and legitTabToggle:GetValue() then
		if e then
			if e:GetName() == "item_equip" then
				btGroupWpnSelection:SetValue(btWpnClassInt-1)
			end
		end
	end
end)
client.AllowListener("item_equip")

local menu_legit_trigger = gui.Groupbox(legitTab, "Triggerbot Settings", 305, 10, 285, 50)
local triggerMagnetToggle = gui.Checkbox(menu_legit_trigger, "triggerbot.magnet", "Magnet", false)
triggerMagnetToggle:SetDescription("Enable magnet triggerbot.")

local legitTriggerbotWeapons = gui.Multibox(menu_legit_trigger, "Weapon Group Selection")
local legitTriggerbotWeaponItems = {
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.shared", "Shared", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.taser", "Taser", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.pistols", "Pistols", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.heavypistols", "Heavy Pistols", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.smgs", "SMGs", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.rifles", "Rifles", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.shotguns", "Shotguns", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.scout", "Scout", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.autosnipers", "Auto Snipers", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.awp", "AWP", false),
	gui.Checkbox(legitTriggerbotWeapons, "triggerbot.lmgs", "LMGs", false)
}

local legitTriggerbotDelay = gui.Slider(menu_legit_trigger, "triggerbot.delay", "Reaction Time", 100, 0, 500, 5)
legitTriggerbotDelay:SetDescription("Change reaction time for selected weapons.")
local legitTriggerbotBurst = gui.Slider(menu_legit_trigger, "triggerbot.burst", "Burst Time", 100, 0, 500, 5)
legitTriggerbotBurst:SetDescription("Change burst time for selected weapons.")
local legitTriggerbotHitchance = gui.Slider(menu_legit_trigger, "triggerbot.hitchance", "Hit Chance", 50, 0, 100)
legitTriggerbotHitchance:SetDescription("Change hit chance for selected weapons.")

callbacks.Register("Draw", "legitTriggerbot", function()
	if script_toggle:GetValue() and legitTabToggle:GetValue() then
		local val1 = legitTriggerbotDelay:GetValue()
		local val2 = legitTriggerbotBurst:GetValue()
		local val3 = legitTriggerbotHitchance:GetValue()
		for i=1, 11, 1 do
			if legitTriggerbotWeaponItems[i]:GetValue() then
				sv(legitTriggerbotItems[i] .. "delay", val1)
				sv(legitTriggerbotItems[i] .. "burst", val2)
				sv(legitTriggerbotItems[i] .. "hitchance", val3)
			end
		end
		if triggerMagnetToggle:GetValue() and gv("lbot.master") then
			sv("lbot.aim.enable", 1)
			if gv("lbot.trg.key") ~= 0 and input.IsButtonDown(gv("lbot.trg.key")) then
				sv("lbot.aim.autofire", 1)
				sv("lbot.aim.fireonpress", 0)
			else
				sv("lbot.aim.autofire", 0)
			end
		else
			sv("lbot.aim.autofire", 0)
		end
	end
end)



--   ███████  ██████ ██████  
--   ██      ██      ██   ██ 
--   █████    █████  ██████  
--   ██           ██ ██      
--   ███████ ██████  ██      

local menu_esp_main = gui.Groupbox(espTab, "ESP Settings", 10, 10, 285, 50)
local esp_toggle = gui.Checkbox(menu_esp_main, "toggle", "ESP Toggle", false)
local chams_toggle = gui.Checkbox(menu_esp_main, "chams.toggle", "Chams Toggle", true)
local chams_toggle_selection = gui.Multibox(menu_esp_main, "Chams Selection")
local esp_on_death = gui.Checkbox(menu_esp_main, "ondeath", "ESP When Dead", false)
local esp_main_vars = gui.Multibox(menu_esp_main, "ESP Display")
local esp_flag_vars = gui.Multibox(menu_esp_main, "ESP Flags")
local esp_precision = gui.Checkbox(menu_esp_main, "precision", "Enhance ESP Precision", false)
esp_toggle:SetDescription("Toggle ESP settings. Recommended to bind.")
chams_toggle:SetDescription("Toggle Chams. Recommended to bind.")
chams_toggle_selection:SetDescription("Enabled types will be toggled on/off.")
esp_on_death:SetDescription("Enables ESP when dead. Disables ESP on round start.")
esp_main_vars:SetDescription("Select what the ESP will draw.")
esp_flag_vars:SetDescription("Select which ESP flags will be drawn.")
esp_precision:SetDescription("Improve ESP drawing accuracy.")

local chams_toggle_selection_items = {}

for i=1, #chams_values_size do
	chams_toggle_selection_items[i] = gui.Checkbox(chams_toggle_selection, "chams"..chams_values_vars[i], chams_values_names[i], false)
end

local function chamsCache()
	for i=1, #chams_values_size do
		for j=0, chams_values_size[i]-1 do
			chams_values[i][j*2+2] = gv(chams_values[i][j*2+1])
		end
	end
	chams_cached = true
end

local function chamsDisable()
	for i=1, #chams_values_size do
		if chams_toggle_selection_items[i]:GetValue() then
			for j=0, chams_values_size[i]-1 do
				sv(chams_values[i][j*2+1], 0)
			end
		end
	end
	chams_returned = false
end

local function chamsReturn()
	for i=1, #chams_values_size do
		if chams_toggle_selection_items[i]:GetValue() then
			for j=0, chams_values_size[i]-1 do
				sv(chams_values[i][j*2+1], chams_values[i][j*2+2])
			end
		end
	end
	chams_returned = true
end

callbacks.Register("Draw", function()
	if script_toggle:GetValue() then
		if chams_toggle:GetValue() then
			if not chams_returned then
				chamsReturn()
			end
			chams_cached = false
		else
			if not chams_cached then
				chamsCache()
			end
			chamsDisable()
		end	
	end
end)



callbacks.Register("Draw", function()
    if script_toggle:GetValue() and esp_toggle:GetValue() then
        sv("esp.overlay.friendly.precision", esp_precision:GetValue() and 1 or 0)
        sv("esp.overlay.enemy.precision", esp_precision:GetValue() and 1 or 0)
    end
end)

local indicatorListSliderX = gui.Slider(mainScriptToggleBox, "indicatorSavePositionX", "indicatorListSliderX", moduleWidth*0.70, 0, screenWidth)
local indicatorListSliderY = gui.Slider(mainScriptToggleBox, "indicatorSavePositionY", "indicatorListSliderY", moduleHeight+14, 0, screenHeight)
indicatorListSliderX:SetInvisible(true)
indicatorListSliderY:SetInvisible(true)
local indicatorListMouseX, indicatorListMouseY, indicatorListDx, indicatorListDy, indicatorListWidth = 0, 0, 0, 0, 100
local indicatorListX, indicatorListY
callbacks.Register("Draw", function()
    indicatorListX, indicatorListY = indicatorListSliderX:GetValue(), indicatorListSliderY:GetValue()
end)
local shouldDragIndicatorList = false

callbacks.Register("Draw", function()
	if script_toggle:GetValue() and drawToggles:GetValue() then
		if entities.GetLocalPlayer() ~= nil or gui.Reference("Menu"):IsActive() then
			draw.SetFont(moonlightFont2)
			draw.Color(0, 0, 20, 100)
			draw.FilledRect(indicatorListX, indicatorListY-5, indicatorListX+150, indicatorListY+20 + #indicatorItems.toggleList*14+5)
			draw.ShadowRect(indicatorListX, indicatorListY-5, indicatorListX+150, indicatorListY+12, 8)
			draw.Color(57, 108, 255, 255)
			draw.Color(drawTogglesColours[2]:GetValue())
			draw.Line(indicatorListX, indicatorListY-5, indicatorListX+150, indicatorListY-6)
			draw.TextShadow(indicatorListX+48, indicatorListY-3, "Toggles")
			draw.SetFont(moonlightFont3)
			draw.Color(drawTogglesColours[1]:GetValue())
			for i=1, #indicatorItems.toggleList, 1 do
				draw.TextShadow(indicatorListX+8, indicatorListY+i*15+3, indicatorItems.toggleList[i])
				draw.TextShadow(indicatorListX+90, indicatorListY+i*15+3, "[")
				local state = "off"
				if i == 1 then
					if gv(miscOtherVariables[1]) and gv(miscOtherVariables[5]) then
						state = "on"
						draw.Color(unpack(indicatorItems.toggleColours[3]))
					end
				elseif i == 2 then
					if gv(miscOtherVariables[1]) and gv(miscOtherVariables[3]) then
						if gv(miscOtherVariables[7]) ~= nil and gv(miscOtherVariables[7]) ~= 0 then
							if input.IsButtonDown(gv(miscOtherVariables[7])) then
								if triggerMagnetToggle:GetValue() and legitTabToggle:GetValue() then
									state = "magnet"
									draw.Color(unpack(indicatorItems.toggleColours[3]))
								else
									state = "on"
									draw.Color(unpack(indicatorItems.toggleColours[3]))
								end
							end
						end
						if gv(miscOtherVariables[8]) then
							state = "af"
							draw.Color(unpack(indicatorItems.toggleColours[5]))
						end
					end
				elseif i == 3 then
					if gv(miscOtherVariables[6]) == 1 then
						state = "on"
						draw.Color(unpack(indicatorItems.toggleColours[3]))
					elseif gv(miscOtherVariables[6]) == 2 then
						state = "legit"
						draw.Color(unpack(indicatorItems.toggleColours[2]))
					end
				elseif i == 4 then
					local temp = 0
					if not esp_on_death:GetValue() then
						for i=1, #espMainVariables, 1 do
							if gv(espMainVariables[i]) then
								temp = temp +1
							end
						end
						if isHealthBarEspEnabled == 1 then
							temp = temp + 1
						end
						if temp-3 > 0 then
							state = "on"
							draw.Color(unpack(indicatorItems.toggleColours[3]))
						end
					else
						if entities.GetLocalPlayer() then
							if not entities.GetLocalPlayer():IsAlive() then
								draw.Color(unpack(indicatorItems.toggleColours[5]))
								state = "dead"
							end
						end
					end
				elseif i == 5 then
					if entities.GetLocalPlayer() ~= nil and btWpnSlider[btWpnClassInt] ~= nil then
						state = btWpnSlider[btWpnClassInt]:GetValue()
					else
						state = 0
					end
					if state == 0 then
						draw.Color(255, 255, 255, 255)
					elseif state < 55 then
						draw.Color(unpack(indicatorItems.toggleColours[2]))
					elseif state < 105 then
						draw.Color(unpack(indicatorItems.toggleColours[3]))
					elseif state < 205 then
						draw.Color(unpack(indicatorItems.toggleColours[4]))
					else
						draw.Color(unpack(indicatorItems.toggleColours[5]))
					end
					if backtrack_ping:GetValue() then
						state = state .. ",p"
					end
					if backtrack_randomisation:GetValue() then
						state = state .. ",r"
					end
				elseif i == 6 then
					if chams_toggle:GetValue() then
						draw.Color(unpack(indicatorItems.toggleColours[3]))
						state = "on"
					end
				end
				local gt = draw.GetTextSize
				draw.TextShadow(indicatorListX+90 + gt("[") , indicatorListY+i*15+3, state)
				draw.Color(drawTogglesColours[1]:GetValue())
				draw.TextShadow(indicatorListX+90 + gt("["..state), indicatorListY+i*15+3, "]")
				state = ""
			end

			if input.IsButtonDown(1) then
				indicatorListMouseX, indicatorListMouseY = input.GetMousePos()
				if shouldDragIndicatorList then
					indicatorListX = indicatorListMouseX - indicatorListDx
					indicatorListY = indicatorListMouseY - indicatorListDy
				end
				if indicatorListMouseX >= indicatorListX and indicatorListMouseX <= indicatorListX + indicatorListWidth and indicatorListMouseY >= indicatorListY and indicatorListMouseY <= indicatorListY+5*15+5 then
					shouldDragIndicatorList = true
					indicatorListDx = indicatorListMouseX - indicatorListX
					indicatorListDy = indicatorListMouseY - indicatorListY
				end
			else
				shouldDragIndicatorList = false
			end
			indicatorListSliderX:SetValue(indicatorListX)
			indicatorListSliderY:SetValue(indicatorListY)
		end
	end
end)

local menu_esp_other = gui.Groupbox(espTab, "Other Settings", 305, 10, 285, 30)
local espOtherToggle = gui.Checkbox(menu_esp_other, "otherEspToggle", "Other ESP Toggle", false)
local rankRevealToggle = gui.Checkbox(menu_esp_other, "rankEsp", "Rank Reveal", false)
local forceCrosshair = gui.Checkbox(menu_esp_other, "forceCrosshair", "Force Crosshair", false)
local antiObsScreenshot = gui.Checkbox(menu_esp_other, "antiObsScreenshot", "Anti-OBS and Anti-Screenshot", false)
local sharedEsp = gui.Checkbox(menu_esp_other, "sharedEsp", "Share ESP with team", false)
espOtherToggle:SetDescription("Enable other ESP settings.")
rankRevealToggle:SetDescription("Show team and enemy ranks in scoreboard.")
forceCrosshair:SetDescription("Force crosshair on snipers.")
antiObsScreenshot:SetDescription("Enable Anti-OBS and Anti-Screenshot.")
sharedEsp:SetDescription("Share your ESP information with your team.")
local sharedEspDesc = gui.Text(menu_esp_other, "You can only share your ESP information with \nother aimware users!")

callbacks.Register("Draw", function()
	if script_toggle:GetValue() and espOtherToggle:GetValue() then
		sv("misc.rankreveal", rankRevealToggle:GetValue())
		sv("esp.other.antiobs", antiObsScreenshot:GetValue())
		sv("esp.other.antiscreenshot", antiObsScreenshot:GetValue())
		if sharedEsp:GetValue() then
			sv("esp.other.sharedesp", 1)
		else
			sv("esp.other.sharedesp", 0)
		end
		if forceCrosshair:GetValue() then
			local lp =  entities.GetLocalPlayer()
			if lp then
				if lp:IsAlive() then
					if lp:GetPropBool("m_bIsScoped") then
						setConVar("weapon_debug_spread_show", 0, true)
					else
						setConVar("weapon_debug_spread_show", 3, true)
					end
				else
					setConVar("weapon_debug_spread_show", 0, true)
				end
			end
		else
			setConVar("weapon_debug_spread_show", 0, true)
		end
	end
end)

local espSettingsItems = {
	gui.Checkbox(esp_main_vars, "overlay.name", "Name", false),
	gui.Checkbox(esp_main_vars, "overlay.healthbar", "Healthbar", false),
	gui.Checkbox(esp_main_vars, "overlay.healthnum", "Healthnum", false),
	gui.Checkbox(esp_main_vars, "overlay.weapon", "Weapon", false),
	gui.Checkbox(esp_main_vars, "overlay.ammo", "Ammo", false),
	gui.Checkbox(esp_main_vars, "overlay.money", "Money", false),
	gui.Checkbox(esp_main_vars, "overlay.dormant", "Dormant", false),
	gui.Checkbox(esp_flag_vars, "overlay.defusing", "Defusing", false),
	gui.Checkbox(esp_flag_vars, "overlay.planting", "Planting", false),
	gui.Checkbox(esp_flag_vars, "overlay.scoped", "Scoped", false),
	gui.Checkbox(esp_flag_vars, "overlay.reloading", "Reloading", false),
	gui.Checkbox(esp_flag_vars, "overlay.flashed", "Flashed", false),
	gui.Checkbox(esp_flag_vars, "overlay.hasDefuser", "Has Defuser", false),
	gui.Checkbox(esp_flag_vars, "overlay.c4", "Has C4", false),
	gui.Checkbox(esp_flag_vars, "overlay.ping", "Ping", false),
	gui.Checkbox(menu_esp_main, "overlay.item", "Item ESP", false),
	gui.Checkbox(menu_esp_main, "overlay.defuser", "Defuser ESP", false),
	gui.Checkbox(menu_esp_main, "overlay.bomb", "Bomb ESP", false),
	gui.Checkbox(esp_main_vars, "overlay.box", "Box", false),
	gui.Checkbox(esp_main_vars, "overlay.skeleton", "Skeleton", false),
	gui.Checkbox(esp_main_vars, "overlay.armor", "Armour", false),
	gui.Checkbox(esp_main_vars, "overlay.barrel", "Barrel", false)
}

espSettingsItems[16]:SetDescription("Show weapon icons.")
espSettingsItems[17]:SetDescription("Show defusers when missing one.")
espSettingsItems[18]:SetDescription("Show bomb timer.")

callbacks.Register("Draw", function()
	if script_toggle:GetValue() then
		if esp_toggle:GetValue() then
			for i=1, #espMainVariables, 1 do
				if espSettingsItems[i]:GetValue() then
					sv(espMainVariables[i], 1)
				else
					sv(espMainVariables[i], 0)
				end
			end
		else
			for i=1, #espMainVariables, 1 do
				sv(espMainVariables[i], 0)
			end
		end
		if esp_on_death:GetValue() then
			if entities.GetLocalPlayer() then
				if not entities.GetLocalPlayer():IsAlive() then
					esp_toggle:SetValue(true)
				else
					esp_toggle:SetValue(false)
				end
			end
		end
	end
end)

local menu_esp_health = gui.Groupbox(espTab, "Healthbar Settings", 305, 375, 285, 30)
local healthAmount1 = 60
local healthAmount2 = 30

local toggleAdvancedHealthbar = gui.Checkbox(menu_esp_health, "healthbar.toggle", "Toggle Healthbar", false)
toggleAdvancedHealthbar:SetDescription("Automatically turns off built-in healthbar.")

local healthItems = {"Off", "Team only", "Enemy only", "On"}
local healthSelect = gui.Combobox(menu_esp_health, "healthSelect", "Mode", unpack(healthItems))

local healthBasedColours = gui.Checkbox(menu_esp_health, "healthBasedColours", "HP Colours", false)
healthBasedColours:SetDescription("Custom colour for 100/" .. healthAmount1 .. "/" .. healthAmount2 .. "HP.")

local enemyHP1 = gui.ColorPicker(menu_esp_health, "enemyHP1", "Enemy HP 1", 0, 255, 0, 255)
local enemyHP2 = gui.ColorPicker(menu_esp_health, "enemyHP2", "Enemy HP 2", 255, 255, 0, 255)
local enemyHP3 = gui.ColorPicker(menu_esp_health, "enemyHP3", "Enemy HP 3", 255, 0, 0, 255)
local teamHP1 = gui.ColorPicker(menu_esp_health, "teamHP1", "Team HP 1", 0, 255, 0, 255)
local teamHP2 = gui.ColorPicker(menu_esp_health, "teamHP2", "Team HP 2", 255, 255, 0, 255)
local teamHP3 = gui.ColorPicker(menu_esp_health, "teamHP3", "Team HP 3", 255, 0, 0, 255)
local enemyColourHealth = gui.ColorPicker(menu_esp_health, "enemyColourHealth", "not supposed to see this", 255, 255, 255, 255)
local enemyColourNumberHealth = gui.ColorPicker(menu_esp_health, "enemyColourNumberHealth", "not supposed to see this", 255, 255, 255, 255)
local teamColourHealth = gui.ColorPicker(menu_esp_health, "teamColourHealth", "not supposed to see this", 255, 255, 255, 255)
local teamColourNumberHealth = gui.ColorPicker(menu_esp_health, "teamColourNumberHealth", "not supposed to see this", 255, 255, 255, 255)
enemyColourHealth:SetInvisible(true)
enemyColourNumberHealth:SetInvisible(true)
teamColourHealth:SetInvisible(true)
teamColourNumberHealth:SetInvisible(true)
enemyHP1:SetInvisible(true)
enemyHP2:SetInvisible(true)
enemyHP3:SetInvisible(true)
teamHP1:SetInvisible(true)
teamHP2:SetInvisible(true)
teamHP3:SetInvisible(true)

local colourEnemy = gui.ColorPicker(menu_esp_health, "colourEnemy", "Enemy Colour", 0, 141, 255, 255)
local colourEnemyNumber = gui.ColorPicker(menu_esp_health, "colourEnemyNumber", "Enemy Number Colour", 0, 141, 255, 255)
local colourTeam = gui.ColorPicker(menu_esp_health, "colourTeam", "Team Colour", 0, 255, 0, 255)
local colourTeamNumber = gui.ColorPicker(menu_esp_health, "colourTeamNumber", "Team Number Colour", 0, 255, 0, 255)

local showHealthNumber = gui.Checkbox(menu_esp_health, "showHealthNumber", "Show number", false)
showHealthNumber:SetDescription("Show health number with healthbar.")
local healthPositionItems = {"Left", "Right"}
local healthposition = gui.Combobox(menu_esp_health, "healthposition", "Mode", unpack(healthPositionItems))
healthposition:SetDescription("Choose healthbar position.")

callbacks.Register("Draw", function()
	if toggleAdvancedHealthbar:GetValue() and script_toggle:GetValue() then
		if healthSelect:GetValue() ~= 0 then
			if esp_toggle:GetValue() then
				isHealthBarEspEnabled = 1
			else
				isHealthBarEspEnabled = 0
			end
		else
			isHealthBarEspEnabled = 0
		end
		sv(espMainVariables[2], 0)
		sv(espMainVariables[3], 0)
		espSettingsItems[2]:SetDisabled(true)
		espSettingsItems[3]:SetDisabled(true)
		espSettingsItems[2]:SetValue(false)
		espSettingsItems[3]:SetValue(false)
	else
		isHealthBarEspEnabled = 0
		espSettingsItems[2]:SetDisabled(false)
		espSettingsItems[3]:SetDisabled(false)
    end
	if healthBasedColours:GetValue() and script_toggle:GetValue() then
        colourEnemy:SetInvisible(true)
        colourEnemyNumber:SetInvisible(true)
        colourTeam:SetInvisible(true)
        colourTeamNumber:SetInvisible(true)
		enemyHP1:SetInvisible(false)
		enemyHP2:SetInvisible(false)
		enemyHP3:SetInvisible(false)
		teamHP1:SetInvisible(false)
		teamHP2:SetInvisible(false)
		teamHP3:SetInvisible(false)
    else
        colourEnemy:SetInvisible(false)
        colourEnemyNumber:SetInvisible(false)
        colourTeam:SetInvisible(false)
        colourTeamNumber:SetInvisible(false)
		enemyHP1:SetInvisible(true)
		enemyHP2:SetInvisible(true)
		enemyHP3:SetInvisible(true)
		teamHP1:SetInvisible(true)
		teamHP2:SetInvisible(true)
		teamHP3:SetInvisible(true)
    end
end)

local function customHealthbarEsp(builder)
	if toggleAdvancedHealthbar:GetValue() and script_toggle:GetValue() and esp_toggle:GetValue() and builder then
		local localPlayer = entities.GetLocalPlayer()
		local ent = builder:GetEntity()
		local health = ent:GetHealth()
		if ent:IsPlayer() then
			if health >= healthAmount1 then
				enemyColourHealth:SetValue(enemyHP1:GetValue())
				enemyColourNumberHealth:SetValue(enemyHP1:GetValue())
				teamColourHealth:SetValue(teamHP1:GetValue())
				teamColourNumberHealth:SetValue(teamHP1:GetValue())
			elseif health >= healthAmount2 and health < healthAmount1 then
				enemyColourHealth:SetValue(enemyHP2:GetValue())
				enemyColourNumberHealth:SetValue(enemyHP2:GetValue())
				teamColourHealth:SetValue(teamHP2:GetValue())
				teamColourNumberHealth:SetValue(teamHP2:GetValue())
			elseif health < healthAmount2 then
				enemyColourHealth:SetValue(enemyHP3:GetValue())
				enemyColourNumberHealth:SetValue(enemyHP3:GetValue())
				teamColourHealth:SetValue(teamHP3:GetValue())
				teamColourNumberHealth:SetValue(teamHP3:GetValue())
			end
		end
		if healthSelect:GetValue() == 1 then
			if ent:IsPlayer() and ent:GetTeamNumber() == localPlayer:GetTeamNumber() then
				if healthposition:GetValue() == 0 then
					if healthBasedColours:GetValue() then
						builder:Color(teamColourHealth:GetValue())
					else
						builder:Color(colourTeam:GetValue())
					end
					builder:AddBarLeft(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(teamColourNumberHealth:GetValue())
						else
							builder:Color(colourTeamNumber:GetValue())
						end
						builder:AddTextLeft(health)
					end
				else
					if healthBasedColours:GetValue() then
						builder:Color(teamColourHealth:GetValue())
					else
						builder:Color(colourTeam:GetValue())
					end
					builder:AddBarRight(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(teamColourNumberHealth:GetValue())
						else
							builder:Color(colourTeamNumber:GetValue())
						end
						builder:AddTextRight(health)
					end
				end
			end
		elseif healthSelect:GetValue() == 2 then
			if ent:IsPlayer() and ent:GetTeamNumber() ~= localPlayer:GetTeamNumber() then
				if healthposition:GetValue() == 0 then
					if healthBasedColours:GetValue() then
						builder:Color(enemyColourHealth:GetValue())
					else
						builder:Color(colourEnemy:GetValue())
					end
					builder:AddBarLeft(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(enemyColourNumberHealth:GetValue())
						else
							builder:Color(colourEnemyNumber:GetValue())
						end
						builder:AddTextLeft(health)
					end
				else
					if healthBasedColours:GetValue() then
						builder:Color(enemyColourHealth:GetValue())
					else
						builder:Color(colourEnemy:GetValue())
					end
					builder:AddBarRight(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(enemyColourNumberHealth:GetValue())
						else
							builder:Color(colourEnemyNumber:GetValue())
						end
						builder:AddTextRight(health)
					end
				end
			end
		elseif healthSelect:GetValue() == 3 then
			if ent:IsPlayer() and ent:GetTeamNumber() == localPlayer:GetTeamNumber() then
				if healthposition:GetValue() == 0 then
					if healthBasedColours:GetValue() then
						builder:Color(teamColourHealth:GetValue())
					else
						builder:Color(colourTeam:GetValue())
					end
					builder:AddBarLeft(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(teamColourNumberHealth:GetValue())
						else
							builder:Color(colourTeamNumber:GetValue())
						end
						builder:AddTextLeft(health)
					end
				else
					if healthBasedColours:GetValue() then
						builder:Color(teamColourHealth:GetValue())
					else
						builder:Color(colourTeam:GetValue())
					end
					builder:AddBarRight(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(teamColourNumberHealth:GetValue())
						else
							builder:Color(colourTeamNumber:GetValue())
						end
						builder:AddTextRight(health)
					end
				end
			end
			if ent:IsPlayer() and ent:GetTeamNumber() ~= localPlayer:GetTeamNumber() then
				if healthposition:GetValue() == 0 then
					if healthBasedColours:GetValue() then
						builder:Color(enemyColourHealth:GetValue())
					else
						builder:Color(colourEnemy:GetValue())
					end
					builder:AddBarLeft(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(enemyColourNumberHealth:GetValue())
						else
							builder:Color(colourEnemyNumber:GetValue())
						end
						builder:AddTextLeft(health)
					end
				else
					if healthBasedColours:GetValue() then
						builder:Color(enemyColourHealth:GetValue())
					else
						builder:Color(colourEnemy:GetValue())
					end
					builder:AddBarRight(health/100)
					if showHealthNumber:GetValue() then
						if healthBasedColours:GetValue() then
							builder:Color(enemyColourNumberHealth:GetValue())
						else
							builder:Color(colourEnemyNumber:GetValue())
						end
						builder:AddTextRight(health)
					end
				end
			end
		end
	end
end
callbacks.Register("DrawESP", "customHealthbarEsp", customHealthbarEsp)

local menu_esp_world = gui.Groupbox(espTab, "World Modulation", 10, 660, 285, 30)
local enableWorldModulation = gui.Checkbox(menu_esp_world, "enableWorldModulation", "World Modulation", false)
local enableShadowsModulation = gui.Checkbox(menu_esp_world, "enableShadowsModulation", "Shadows Modulation", false)
local shadowsPositionX = gui.Slider(menu_esp_world, "shadowsPositionX", "Shadows X", 50, 0, 360)
local shadowsPositionY = gui.Slider(menu_esp_world, "shadowsPositionY", "Shadows Y", 43, 0, 360)
local enableFogModulation = gui.Checkbox(menu_esp_world, "enableFogModulation", "Fog Modulation", false)
local skyboxFogColor = gui.ColorPicker(enableFogModulation, "skyboxFogColor", "Skybox Fog Colour", 255, 255, 255, 255)
local fogColor = gui.ColorPicker(enableFogModulation, "fogColor", "Fog Colour", 255, 255, 255, 255)
local fogStart = gui.Slider(menu_esp_world, "fogStart", "Fog Start", 0, 0, 2000)
local fogEnd = gui.Slider(menu_esp_world, "fogEnd", "Fog End", 1000, 0, 3000)
local fogDensity = gui.Slider(menu_esp_world, "fogDensity", "Fog Density", 0.2, 0, 1, 0.1)
local skyboxFogStart = gui.Slider(menu_esp_world, "skyboxFogStart", "Skybox Fog Start", 0, 0, 2000)
local skyboxFogEnd = gui.Slider(menu_esp_world, "skyboxFogEnd", "Skybox Fog End", 1000, 0, 3000)
local skyboxFogDensity = gui.Slider(menu_esp_world, "skyboxFogDensity", "Skybox Fog Density", 0.2, 0, 1, 0.1)

callbacks.Register("Draw", function()
	if script_toggle:GetValue() and enableWorldModulation:GetValue() then
		if enableShadowsModulation:GetValue() then
				setConVar("cl_csm_rot_override", 1, false)
				setConVar("cl_csm_rot_x", shadowsPositionX:GetValue(), false)
				setConVar("cl_csm_rot_y", shadowsPositionY:GetValue(), false)
		else
			setConVar("cl_csm_rot_override", 0, false)
		end
		if enableFogModulation:GetValue() then
			setConVar("fog_override", 1, true)
		else
			setConVar("fog_override", 0, true)
		end
		if enableFogModulation:GetValue() then
			local fca,fcb,fcc = fogColor:GetValue()
			local tempfc = fca .. " " .. fcb .. " " .. fcc
			local sfca,sfcb,sfcc = skyboxFogColor:GetValue()
			local tempsfc = sfca .. " " .. sfcb .. " " .. sfcc
				setConVar("fog_start", fogStart:GetValue(), true)
				setConVar("fog_end", fogEnd:GetValue(), true)
				setConVar("fog_maxdensity", fogDensity:GetValue(), true)
				setConVar("fog_color", tempfc, true)
				setConVar("fog_colorskybox", tempsfc, true)
				setConVar("fog_startskybox", skyboxFogStart:GetValue(), true)
				setConVar("fog_endskybox", skyboxFogEnd:GetValue(), true)
				setConVar("fog_maxdensityskybox", skyboxFogDensity:GetValue(), true)	
		end
	else
			setConVar("cl_csm_rot_override", 0, false)
			setConVar("fog_override", 0, true)
		setConVar("fog_color", "-1 -1 -1", true)
	end
end)



--   █████  ████████ ██   ██ ███████ ██████  
--  ██   ██    ██    ██   ██ ██      ██   ██ 
--  ██   ██    ██    ███████ █████   ██████  
--  ██   ██    ██    ██   ██ ██      ██   ██ 
--   █████     ██    ██   ██ ███████ ██   ██ 

local guiBoxOtherMain = gui.Groupbox(otherTab, "Other Settings", 10, 10, 285, 50)
local aspectRatioChangerToggle = gui.Checkbox(guiBoxOtherMain, "aspect_ratio_check", "Aspect Ratio Changer", false)
aspectRatioChangerToggle:SetDescription("Set custom aspect ratio. 1 - 1:1, 1.33 - 4:3, 1.78 - 16:9")
local aspectRatioChangerValue = gui.Slider(guiBoxOtherMain, "aspectRatioChangerValue", "Aspect Ratio", 1.778, 1, 2, 0.001)
callbacks.Register("Draw", function()
	local val
	if aspectRatioChangerToggle:GetValue() == true then
		val = aspectRatioChangerValue:GetValue()
	else
		val = screenWidth/screenHeight
	end
	setConVar("r_aspectratio", val, true)
end)

local guiBoxOtherMainImports = gui.Groupbox(guiBoxOtherMain, "Imports", 0, 100, 255, 50)
local importViewmodelPosition = gui.Button(guiBoxOtherMainImports, "viewmodel", function()
	client.Command("viewmodel_offset_x 2 viewmodel_offset_y 2 viewmodel_offset_z -2 viewmodel_fov 68 cl_righthand 1 cl_bobcycle 0 cl_bobamt_vert 0 cl_bobamt_vert 0 cl_bobamt_lat 0 cl_bob_lower_amt 0", true)
end)

local importAutoexecConfig = gui.Button(guiBoxOtherMainImports, "autoexec.cfg", function()
	client.Command("exec autoexec", true)
end)

local importMoonlightTheme = gui.Button(guiBoxOtherMainImports, "moonlight theme", function()
	gui.SetValue("theme.footer.bg", 0, 0, 0, 255)
	gui.SetValue("theme.header.bg", 0, 0, 0, 255)
	gui.SetValue("theme.nav.active", 0, 0, 0, 255)
	gui.SetValue("theme.nav.bg", 0, 0, 0, 255)
	gui.SetValue("theme.tablist.tabactivebg", 0, 0, 0, 255)
	gui.SetValue("theme.footer.text", 57, 108, 255, 255)
	gui.SetValue("theme.header.line", 57, 108, 255, 255)
	gui.SetValue("theme.header.text", 57, 108, 255, 255)
	gui.SetValue("theme.nav.shadow", 57, 108, 255, 255)
	gui.SetValue("theme.nav.text", 57, 108, 255, 255)
	gui.SetValue("theme.tablist.shadow", 57, 108, 255, 255)
	gui.SetValue("theme.tablist.tabdecorator", 57, 108, 255, 255)
	gui.SetValue("theme.tablist.text", 57, 108, 255, 255)
	gui.SetValue("theme.tablist.text2", 57, 108, 255, 255)
	gui.SetValue("theme.ui2.lowpoly1", 0, 6, 10, 255)
	gui.SetValue("theme.ui2.lowpoly2", 0, 32, 75, 255)
	gui.SetValue("theme.ui2.border", 57, 108, 255, 87)
end)
importViewmodelPosition:SetWidth(105)
importAutoexecConfig:SetWidth(105)
importAutoexecConfig:SetPosY(0)
importAutoexecConfig:SetPosX(120)
importMoonlightTheme:SetWidth(105)

local guiBoxOtherFun = gui.Groupbox(otherTab, "Fun", 10, 338, 285, 50)
local startQueueButton = gui.Button(guiBoxOtherFun, "Start MM Queue", function()
	panorama.RunScript('LobbyAPI.StartMatchmaking("", "", "", "")')
end)
startQueueButton:SetWidth(120)
local cancelQueueButton = gui.Button(guiBoxOtherFun, "Cancel MM Queue", function()
	panorama.RunScript("LobbyAPI.StopMatchmaking()")
end)
cancelQueueButton:SetWidth(120)
cancelQueueButton:SetPosX(135)
cancelQueueButton:SetPosY(0)

local guiBoxOtherInformation = gui.Groupbox(otherTab, "Information Settings", 305, 10, 285, 50)
local spectatorList = gui.Checkbox(guiBoxOtherInformation, "toggleSpectatorList", "Spectator List", false)
spectatorList:SetDescription("Enable moonlight's spectator list.")
local spectatorListColours = {
	gui.ColorPicker(spectatorList, "specListWindowNameColour", "Spectator List Window Name Colour", 255, 255, 255, 255),
	gui.ColorPicker(spectatorList, "specListNameColour", "Spectator List Name Colour", 57, 108, 255, 255)
}
local togglePlayerAvatars = gui.Checkbox(guiBoxOtherInformation, "togglePlayerAvatars", "Toggle Avatars", false)
togglePlayerAvatars:SetDescription("Toggle between show/hide player avatars in speclist.")
local togglePlayerAvatarsColour = gui.ColorPicker(togglePlayerAvatars, "togglePlayerAvatarsColour", "Player Avatar Filter Colour", 255, 255, 255, 255)

local playerAvatarUpdateMode = gui.Multibox(guiBoxOtherInformation, "Avatar Update Mode")
local playerAvatarUpdateModeItems = {
	gui.Checkbox(playerAvatarUpdateMode, "modeManual", "Manual", false),
	gui.Checkbox(playerAvatarUpdateMode, "modeRoundStart", "On Round Start", false),
	gui.Checkbox(playerAvatarUpdateMode, "modeRoundEnd", "On Round End", false),
	gui.Checkbox(playerAvatarUpdateMode, "modePlayerConnect", "On Player Connect", false),
	gui.Checkbox(playerAvatarUpdateMode, "modePlayerDisconnect", "On Player Disconnect", false)
}
local updatePlayerAvatars = gui.Checkbox(guiBoxOtherInformation, "updatePlayerAvatars", "Update Avatars", false)
updatePlayerAvatars:SetDescription("Download new avatars. Will freeze your game!")
callbacks.Register("Draw", function()
	if togglePlayerAvatars:GetValue() then
		playerAvatarUpdateMode:SetDisabled(false)
		if playerAvatarUpdateModeItems[1]:GetValue() then
			updatePlayerAvatars:SetDisabled(false)
		else
			updatePlayerAvatars:SetDisabled(true)
		end
	else
		playerAvatarUpdateMode:SetDisabled(true)
		updatePlayerAvatars:SetDisabled(true)
	end
end)

local specListSliderX = gui.Slider(guiBoxOtherInformation, "specListSavePositionX", "specListSliderX", 25, 0, screenWidth)
local specListSliderY = gui.Slider(guiBoxOtherInformation, "specListSavePositionY", "specListSliderY", 660, 0, screenHeight)
specListSliderX:SetInvisible(true)
specListSliderY:SetInvisible(true)
local specListMouseX, specListMouseY, specListDx, specListDy, specListWidth, specListHeight = 0, 0, 0, 0, 200, 60
local specListX, specListY
callbacks.Register("Draw", function()
    specListX, specListY = specListSliderX:GetValue(), specListSliderY:GetValue()
end)
local shouldDragSpectatorList = false

local function getSpectatorList()
    local spectators = {}
     if entities.GetLocalPlayer() ~= nil then
      local players = entities.FindByClass("CCSPlayer")
        for i=1, #players do
            local player = players[i]
            if player ~= entities.GetLocalPlayer() and not player:IsAlive() then
                local name = player:GetName()
                if player:GetPropEntity("m_hObserverTarget") ~= nil then
                    local playerindex = player:GetIndex()
                    if name ~= "GOTV" and playerindex ~= 1 then
                        local target = player:GetPropEntity("m_hObserverTarget")
                        if target:IsPlayer() then
                            local targetindex = target:GetIndex()
                            local myindex = client.GetLocalPlayerIndex()
                            if entities.GetLocalPlayer():IsAlive() then
                                if targetindex == myindex then
                                    table.insert(spectators, player)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return spectators
end


local botAvatar = draw.CreateTexture(common.DecodeJPEG(http.Get("https://raw.githubusercontent.com/BlueElixir/aimware-luas/main/moonlight/files/csgo_bot_avatar.jpg")))

local function getUserAvatar(userID)
	local userProfileLinkXMLContents = http.Get("https://steamcommunity.com/profiles/[U:1:" .. userID .. "]?xml=true")
	local function get(data, name)
		return data:match("<"..name..">(.-)</"..name..">")
	end
	local imageLink = get(userProfileLinkXMLContents, "avatarIcon"):gsub("<!.CDATA.", ""):gsub("..>", "")
	local imageOutput = draw.CreateTexture(common.DecodeJPEG(http.Get(imageLink)))
	return imageOutput
end

local playerAvatar = {
	ID = {},
	Picture = {}
}

local function getAllPictures()
	local players = entities.FindByClass("CCSPlayer")
	for i=1, #players do
		local index = players[i]:GetIndex()
		local steamID = client.GetPlayerInfo(index).SteamID
		local isBot = client.GetPlayerInfo(index).IsBot
		if not isBot then
			if playerAvatar.ID[steamID] ~= steamID then
				playerAvatar.ID[steamID] = steamID
				playerAvatar.Picture[steamID] = getUserAvatar(steamID)
			end
		else
			playerAvatar.ID[index] = index
			playerAvatar.Picture[index] = botAvatar
		end
	end
end

callbacks.Register("FireGameEvent", function(e)
	for i=2, 4 do
		if playerAvatarUpdateModeItems[i]:GetValue() and e then
			if e:GetName() == eventList[i-1] then
				getAllPictures()
			end
		end
	end
end)

local function getPlayerPicture(index)
	local avatar
	local steamID = client.GetPlayerInfo(index).SteamID
	if playerAvatar.ID[steamID] ~= nil or not client.GetPlayerInfo(index).IsBot then
		avatar = playerAvatar.Picture[steamID]
	else
		avatar = botAvatar
	end
	return avatar
end

callbacks.Register("Draw", function()
	if updatePlayerAvatars:GetValue() then
		getAllPictures()
		updatePlayerAvatars:SetValue(false)
	end
end)

callbacks.Register("Draw", function()
	if spectatorList:GetValue() and script_toggle:GetValue() then
		local spectators = getSpectatorList()
		draw.SetFont(moonlightFont2)
		if #spectators ~= 0 or gui.Reference("Menu"):IsActive() then
			draw.Color(0, 0, 20, 100)
			draw.FilledRect(specListX, specListY-5, specListX+200, specListY+#spectators*15+20)
			draw.ShadowRect(specListX, specListY-5, specListX+200, specListY+12, 8)
			draw.Color(spectatorListColours[2]:GetValue())
			draw.TextShadow(specListX+63, specListY-3, "Spectators")
			draw.Line(specListX, specListY-5, specListX+200, specListY-5)
			draw.SetFont(moonlightFont3)
			for i, player in pairs(spectators) do
				draw.Color(spectatorListColours[1]:GetValue())
				local name = ""
				if client.GetPlayerInfo(player:GetIndex()).IsBot then
					name = "BOT "
				end
				name = name .. player:GetName()
				draw.TextShadow(specListX+8, specListY+3+i*15, name)
				draw.Color(255, 255, 255, 255)
				if togglePlayerAvatars:GetValue() then
					draw.Color(togglePlayerAvatarsColour:GetValue())
					draw.SetTexture(getPlayerPicture(player:GetIndex()))
					draw.FilledRect(specListX+170, specListY+1+i*15, specListX+184, specListY+3+i*15+12)
					draw.SetTexture(nil)
				end
			end
			if input.IsButtonDown(1) then
				specListMouseX, specListMouseY = input.GetMousePos()
				if shouldDragSpectatorList then
					specListX = specListMouseX - specListDx
					specListY = specListMouseY - specListDy
				end
				if specListMouseX >= specListX and specListMouseX <= specListX + specListWidth and specListMouseY >= specListY and specListMouseY <= specListY+#spectators*15+5 then
					shouldDragSpectatorList = true
					specListDx = specListMouseX - specListX
					specListDy = specListMouseY - specListY
				end
			else
				shouldDragSpectatorList = false
			end
			specListSliderX:SetValue(specListX)
			specListSliderY:SetValue(specListY)
		end
	end
end)

local gui_buybind = gui.Groupbox(otherTab, "Buy Bind", 305, 295, 285, 50)

local primary = {"", "ak47", "ssg08", "sg556", "awp", "galilar", "mac10", "mp7", "u	mp45", "p90", "bizon", "nova", "xm1014", "mag7", "m249", "negev"}
local secondary = {"", "glock", "elite", "p250", "tec9", "deagle"}
local equipment = {"vest", "vesthelm", "taser"}
local equipmentnames = {"Kevlar Vest", "Kevlar + Helmet", "Zeus x27"}
local grenades = {"molotov", "decoy", "flashbang", "flashbang", "hegrenade", "smokegrenade"}
local grenadesnames = {"Molotov / Incendiary Grenade", "Decoy Grenade", "Flashbang", "Flashbang", "HE Grenade", "Smoke Grenade"}

local buy_primary = gui.Combobox(gui_buybind, "buybind.primary", "Primary Weapon", "None", "AK-47 / M4A4 / M4A1-S", "SSG 08", "SG 553 / AUG", "AWP", "G3SG1 / SCAR-20", "Galil AR / Famas", "MAC-10", "MP7 / MP5", "UMP-45", "P90", "PP-Bizon", "Nova", "XM1014", "Mag-7", "Sawed-Off", "M249", "Negev")
local buy_secondary = gui.Combobox(gui_buybind, "buybind.secondary", "Secondary Weapon", "None", "Glock-18 / USP-S / P2000", "Dual Berretas", "P250", "Tec-9 / Five-Seven / CZ75-Auto", "Desert Eagle / Revolver")
local buy_equipment = gui.Multibox(gui_buybind, "Equipment")
local buy_grenades = gui.Multibox(gui_buybind, "Grenades")

local equipmentSelectionItems = {}
for i=1, #equipment do
	equipmentSelectionItems[i] = gui.Checkbox(buy_equipment, "equipment." .. equipment[i], equipmentnames[i], false)
end

local grenadesSelectionItems = {}
for i=1, #grenades do
	grenadesSelectionItems[i] = gui.Checkbox(buy_grenades, "grenades." .. grenades[i], grenadesnames[i], false)
end

callbacks.Register("Draw", function()
	local temp = 0
	for i=1, #grenades do
		if grenadesSelectionItems[i]:GetValue() then
			temp = temp + 1
		end
	end
	for i=1, #grenades do
		if temp == 4 then
			if not grenadesSelectionItems[i]:GetValue() then
				grenadesSelectionItems[i]:SetDisabled(true)
			end
		else
			grenadesSelectionItems[i]:SetDisabled(false)
		end
	end
	if equipmentSelectionItems[1]:GetValue() then
		equipmentSelectionItems[2]:SetDisabled(true)
	else
		equipmentSelectionItems[2]:SetDisabled(false)
	end
	if equipmentSelectionItems[2]:GetValue() then
		equipmentSelectionItems[1]:SetDisabled(true)
	else
		equipmentSelectionItems[1]:SetDisabled(false)
	end
end)

local function buyWeapon()
	local buystring = ""
	for i=1, #grenadesSelectionItems do
		if grenadesSelectionItems[i]:GetValue() then
			buystring = buystring .. "buy " .. grenades[i] .. ";"
		end
	end
	for i=1, #equipmentSelectionItems do
		if equipmentSelectionItems[i]:GetValue() then
			buystring = buystring .. "buy " .. equipment[i] .. ";"
		end
	end
	if primary[buy_primary:GetValue()+1] ~= "" then
		buystring = buystring .. "buy " .. primary[buy_primary:GetValue()+1] .. ";"
	end
	if secondary[buy_secondary:GetValue()+1] ~= "" then
		buystring = buystring .. "buy " .. secondary[buy_secondary:GetValue()+1] .. ";"
	end

	if buystring == "" then
		print("Please select items to buy.")
		return
	end
	client.Command(buystring, false)
end

local purchase = gui.Checkbox(gui_buybind, "purchase", "Purchase Items", false)
purchase:SetDescription("Purchase selected items. Spamming it will kick you.")
callbacks.Register("Draw", function()
	if purchase:GetValue() then
		purchase:SetValue(false)
		buyWeapon()
	end
end)
local auto_purchase = gui.Checkbox(gui_buybind, "purchase.auto", "Autobuy on Round Start", false)
auto_purchase:SetDescription("Buy selected weapons on round start automatically.")
callbacks.Register("FireGameEvent", function(e)
	if e then
		if e:GetName() == "round_start" and auto_purchase:GetValue() then
			buyWeapon()
		end
	end
end)

for i=1, #eventList do
	client.AllowListener(eventList[i])
end

callbacks.Register("Draw", function()
	if script_toggle:GetValue() == false then
		menu_main:SetDisabled(true)
		menu_legit_backtrack:SetDisabled(true)
		menu_legit_trigger:SetDisabled(true)
		menu_esp_main:SetDisabled(true)
		menu_esp_other:SetDisabled(true)
		menu_esp_health:SetDisabled(true)
		menu_esp_world:SetDisabled(true)
		menu_main_hud:SetDisabled(true)
	else
		menu_main:SetDisabled(false)
		menu_legit_backtrack:SetDisabled(false)
		menu_legit_trigger:SetDisabled(false)
		menu_esp_main:SetDisabled(false)
		menu_esp_other:SetDisabled(false)
		menu_esp_health:SetDisabled(false)
		menu_esp_world:SetDisabled(false)
		menu_main_hud:SetDisabled(false)
	end
end)

callbacks.Register("Unload", function()
	chams_toggle:SetValue(true)
	chamsReturn()
end)


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")