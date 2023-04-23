--©thekorol
local console_handlers = {}
function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c)
		fields[#fields + 1] = c
	end)
	return fields
end
local weapon_type_int = {
	1,
	1,
	1,
	1,
	[7] = 3,
	[8] = 3,
	[9] = 5,
	[10] = 3,
	[11] = 5,
	[13] = 3,
	[14] = 6,
	[16] = 3,
	[17] = 2,
	[19] = 2,
	[20] = 19,
	[23] = 2,
	[24] = 2,
	[25] = 4,
	[26] = 2,
	[27] = 4,
	[28] = 6,
	[29] = 4,
	[30] = 1,
	[31] = 0,
	[32] = 1,
	[33] = 2,
	[34] = 2,
	[35] = 4,
	[36] = 1,
	[37] = 19,
	[38] = 5,
	[39] = 3,
	[40] = 5,
	[41] = 0,
	[42] = 0,
	[43] = 9,
	[44] = 9,
	[45] = 9,
	[46] = 9,
	[47] = 9,
	[48] = 9,
	[49] = 7,
	[50] = 19,
	[51] = 19,
	[52] = 19,
	[55] = 19,
	[56] = 19,
	[57] = 11,
	[59] = 0,
	[60] = 3,
	[61] = 1,
	[63] = 1,
	[64] = 1,
	[68] = 9,
	[69] = 12,
	[70] = 13,
	[72] = 15,
	[74] = 16,
	[75] = 16,
	[76] = 16,
	[78] = 16,
	[80] = 0,
	[81] = 9,
	[82] = 9,
	[83] = 9,
	[84] = 9,
	[85] = 14,
	[500] = 0,
	[503] = 0,
	[505] = 0,
	[506] = 0,
	[507] = 0,
	[508] = 0,
	[509] = 0,
	[512] = 0,
	[514] = 0,
	[515] = 0,
	[516] = 0,
	[517] = 0,
	[518] = 0,
	[519] = 0,
	[520] = 0,
	[521] = 0,
	[522] = 0,
	[523] = 0,
	[525] = 0
}
local wep_type = {taser = 0, knife = 0, pistol = 1, smg = 2, rifle = 3, shotgun = 4, sniperrifle = 5, machinegun = 6, c4 = 7, grenade = 9, stackableitem = 11, fists = 12, breachcharge = 13, bumpmine = 14, tablet = 15, melee = 16, equipment = 19}
local function getWeaponType(wepIdx)
	local typeInt = weapon_type_int[tonumber(wepIdx)]
	for index, value in pairs(wep_type) do
		if value == typeInt then
			return index ~= 0 and index or (tonumber(wepIdx) == 31 and "taser" or "knife")
		end
	end
end

local function register_console_handler(command, handler, force)
	if console_handlers[command] and not force then
		return false
	end
	console_handlers[command] = handler
	return true
end
-- Console input
callbacks.Register("SendStringCmd", "lib_console_input", function(c)
	local raw_console_input = c:Get() -- Maximum 255 chars
	local parsed_console_input = raw_console_input:split(" ")
	local command = table.remove(parsed_console_input, 1)
	local str = ""
	for index, value in ipairs(parsed_console_input) do
		str = str .. value .. " "
	end
	if console_handlers[command] and console_handlers[command](str:sub(1, -2)) then
		c:Set("\0")
	end
end)
local main = [====[
	if (typeof(SClient) == 'undefined' && $.GetContextPanel().id == "CSGOHud") {
        SClient = (function () {
            $.Msg("Scoreboard Weapon injected successfully! Welcome : " + MyPersonaAPI.GetName())
            var handlers = {}
            let registerHandler = function (type, callback) {
                handlers[type] = callback
            }
            let receivedHandler = function (message) {
                if (handlers[message.type]) {
                    handlers[message.type](message)
                }
            }
            return {
                register_handler: registerHandler,
                receive: receivedHandler
            }
        })()
    }
    if ($.GetContextPanel().id == "CSGOHud") { $.Schedule(1, ()=>{GameInterfaceAPI.ConsoleCommand("!panoCall e_PanelWeaponLoaded")}) }
    if (typeof(SImageManager) == 'undefined' && $.GetContextPanel().id == "CSGOHud") {
        SImageManager = (function () {
            var HashMap = function HashMap() {
                var length = 0;
                var obj = new Object();
                this.isEmpty = function () {
                    return length == 0;
                };
                this.containsKey = function (key) {
                    return (key in obj);
                };
                this.containsValue = function (value) {
                    for (var key in obj) {
                        if (obj[key] == value) {
                            return true;
                        }
                    }
                    return false;
                };
                this.put = function (key, value) {
                    if (!this.containsKey(key)) {
                        length++;
                    }
                    obj[key] = value;
                };
                this.get = function (key) {
                    return this.containsKey(key) ? obj[key] : null;
                };
                this.remove = function (key) {
                    if (this.containsKey(key) && (delete obj[key])) {
                        length--;
                    }
                };
                this.values = function () {
                    var _values = new Array();
                    for (var key in obj) {
                        _values.push(obj[key]);
                    }
                    return _values;
                };
                this.keySet = function () {
                    var _keys = new Array();
                    for (var key in obj) {
                        _keys.push(key);
                    }
                    return _keys;
                };
                this.size = function () {
                    return length;
                };
                this.clear = function () {
                    length = 0;
                    obj = new Object();
                };
            }
            var ImagePool = new HashMap()
            class ImageCell {
                constructor(xuid) {
                    var updating = false
                    var lastUpdateWep = ""
                    var lastUpdateHL = ""
                    var lastColor = ""
                    let primaryLut = ['smg', 'rifle', 'heavy']
                    let partInit = "<root><styles><include src='file://{resources}/styles/csgostyles.css'/><include src='file://{resources}/styles/scoreboard.css'/><include src='file://{resources}/styles/hud/hudweaponselection.css' /></styles><Panel style='margin-right:0px;flow-children:right;horizontal-align:right;'></Panel></root>"
                    this.getTargetXUID = () => {
                        return xuid
                    }
                    this.getTargetPanel = () => {
                        var panel
                        var par = $.GetContextPanel().FindChildTraverse("player-" + xuid)
                        if (!par)
                            return
                        var parent = par.FindChildTraverse("name")
                        if (!parent)
                            return
                        panel = parent.FindChildTraverse("CustomImagePanel")
                        if (!panel) {
                            panel = $.CreatePanel("Panel", parent, "CustomImagePanel")
                        }
                        return panel
                    }
                    this.getState = () => {
                        return updating
                    }
                    this.update = (color, equipments, alpha, hl) => {
                        let colorRGBtoHex = (color) => {
                            var rgb = color.split(',')
                            var r = parseInt(rgb[0])
                            var g = parseInt(rgb[1])
                            var b = parseInt(rgb[2])
                            var hex = "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)
                            return hex
                        }
                        let targetColor = colorRGBtoHex(color)
                        let panel = this.getTargetPanel()
                        if (!panel) {return}
                        if (GameStateAPI.GetPlayerStatus(xuid) == 1) {
                            panel.RemoveAndDeleteChildren()
                            return
                        }
                        if (lastUpdateHL != hl || lastUpdateWep != equipments.toString() || lastColor != color) {
                            updating = true
                            panel.RemoveAndDeleteChildren()
                            panel.BLoadLayoutFromString(partInit, false, false)
                            let sortedEQ = []
                            let nades = []
                            let others = []
                            equipments.forEach((item)=>{
                                let curType = InventoryAPI.GetSlot(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(parseInt(item), 0))
                                if(curType == 'grenade'){
                                    nades.push(item)
                                } else if (curType == 'secondary') {
                                    nades.unshift(item)
                                } else if(primaryLut.includes(curType)) {
                                    sortedEQ.push(item)
                                } else {
                                    others.push(item)
                                }
                            })
                            sortedEQ.concat(nades).concat(others).forEach((item) => {
                                let cellPanel = $.CreatePanel("Panel", panel, "CustomPanelCell", {
                                    style: 'margin-right:3px; height:18px;'
                                })
                                let nameUnClipped = InventoryAPI.GetItemDefinitionName(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(parseInt(item), 0))
                                if (!nameUnClipped)
                                    return
                                $.CreatePanel("Image", cellPanel, "CustomImageCell", {
                                    scaling: 'stretch-to-fit-y-preserve-aspect',
                                    src: 'file://{images}/icons/equipment/' + nameUnClipped.replace( 'weapon_', '' ).replace('item_defuser', 'defuser') + '.svg',
                                    style: hl == item ? ('wash-color-fast: white;opacity:' + alpha + ';-s2-mix-blend-mode: normal;img-shadow: ' + targetColor + ' 1px 1px 1.5px 0.5;') : ('wash-color-fast: hsv-transform(#e8e8e8, 0, 0.96, 0.18);opacity:' + (alpha-0.02) + ';-s2-mix-blend-mode: normal;')
                                })
                            })
                        }
                        lastUpdateHL = hl
                        lastUpdateWep = equipments.toString()
                        lastColor = color
                        updating = false
                    }
                }
            }
            return {
                get_cache: (xuid) => {
                    if (ImagePool.containsKey(xuid)) {
                        return ImagePool.get(xuid)
                    } else {
                        return false
                    }
                },
                dispatch: (entid, color, alpha, weapons, hl) => {
                    let xuid = GameStateAPI.GetPlayerXuidStringFromEntIndex(entid)
                    if (ImagePool.containsKey(xuid)) {
                        var targetCell = ImagePool.get(xuid)
                        var waitForUpdate = () => {
                            if (targetCell.getState()){
                                $.Schedule(0.05, waitForUpdate)
                            } else {
                                targetCell.update(color, weapons, alpha, hl)
                            }
                        }
                        waitForUpdate()
                        return true
                    } else {
                        ImagePool.put(xuid, new ImageCell(xuid))
                        return false
                    }
                },
                destroy: () => {
                    ImagePool.clear()
                }
            }
        })()
        $.RegisterForUnhandledEvent("Scoreboard_OnEndOfMatch", SImageManager.destroy)
        $.RegisterForUnhandledEvent('CSGOShowMainMenu', SImageManager.destroy)
        $.RegisterForUnhandledEvent('OpenPlayMenu', SImageManager.destroy)
        $.RegisterForUnhandledEvent('PanoramaComponent_Lobby_ReadyUpForMatch', SImageManager.destroy)
        SClient.register_handler("updateWeapons", (message) => {
            if (!SImageManager.dispatch(message.content.xuid, message.content.colorSet, message.content.alpha, message.content.weapons, message.content.highLightWep)) {
                $.Schedule(0.5, () => {
                    SImageManager.dispatch(message.content.xuid, message.content.colorSet, message.content.alpha, message.content.weapons, message.content.highLightWep)
                })
            }
        }) 
    }
]====]
-- Client
local handlers = {}
local pending = {}
local Client = {
	updateWeapons = loadstring([=[
        return function(entid, color, alpha, weapons, highLight)
            if not weapons or #weapons == 0 then
                return
            end
            alpha = string.format("%1.3f", alpha / 255)
            local colorStr = "" .. tostring(color[1]) .. "," .. tostring(color[2]) .. "," .. tostring(color[3])
            local weaponsStr = ""
            for index, value in ipairs(weapons) do
                weaponsStr = weaponsStr .. "\"" .. value .. "\"" .. ","
            end
            weaponsStr = weaponsStr:sub(1, -2)
            local panoStr = string.format("if(typeof (SClient) != 'undefined') { SClient.receive(%s) }", string.format([[{type: "%s", content: %s}]], "updateWeapons", string.format([[{xuid: %s, colorSet: "%s", alpha: %s , weapons: [%s], highLightWep:"%s" }]], entid, colorStr, alpha, weaponsStr, highLight)))
            panorama.RunScript(panoStr)
        end
    ]=])(),
	receive = function(message)
		for index, value in ipairs(handlers) do
			if value(message) then
				return
			end
		end
	end,
	register_handler = function(callback)
		table.insert(handlers, callback)
	end
}
register_console_handler("!panoCall", function(args)
	Client.receive(args)
	return true
end, true)
local last_check_sec = 0
local loaded = false
callbacks.Register("Draw", "AWStrangePanoramaFixer", function()
	if loaded then
		return
	end
	local cur = string.format("%1.0f", tostring(globals.RealTime()))
	if last_check_sec ~= cur then
		panorama.RunScript(main)
		last_check_sec = cur
	end
end)
Client.register_handler(function(msg)
	if msg == "e_PanelWeaponLoaded" then
		loaded = true
		callbacks.Unregister("Draw", "AWStrangePanoramaFixer") -- Credit: squid for api correction
		return true
	end
end)
local enhancement = gui.Reference("Misc", "Enhancement", "Appearance")
local hudweapon_enable = gui.Checkbox(enhancement, "hudweapon.enabled", "Display equipment on scoreboard", false)
local menu = {filter = gui.Multibox(enhancement, "Weapon filter")}
local itemList = {"Primary", "Secondary", "Knife/Taser", "Grenades", "C4", "Defuser", "Armor", "Other"}
for index, value in ipairs(itemList) do
	menu["item_" .. index] = gui.Checkbox(menu.filter, "hudweapon.item_" .. index, value, false)
end
local hudweapon_color = gui.ColorPicker(enhancement, "hudweapon.color", "Blur color", 136, 71, 255, 255)
local player_weapons = {}
for i = 0, 64 do
	player_weapons[i] = {}
end
gui.Button(enhancement, "Clear equipments data", function()
	for i = 0, 64 do
		player_weapons[i] = {}
	end
end)
local function filter_weapon(wepList)
	for index, value in ipairs(wepList) do
		local wepType = getWeaponType(value)
		if wepType == "smg" or wepType == "rifle" or wepType == "shotgun" or wepType == "sniperrifle" or wepType == "machinegun" then
			if not menu.item_1:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "pistol" then
			if not menu.item_2:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "taser" or "knife" then
			if not menu.item_3:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "grenade" then
			if not menu.item_4:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "c4" then
			if not menu.item_5:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "defuser" then
			if not menu.item_6:GetValue() then
				table.remove(wepList, index)
			end
		elseif wepType == "armor" then
			if not menu.item_7:GetValue() then
				table.remove(wepList, index)
			end
		else
			if not menu.item_8:GetValue() then
				table.remove(wepList, index)
			end
		end
	end
	return wepList
end

local hl = {}
local function add_weapon(idx, weapon)
	if player_weapons and player_weapons[idx] and #player_weapons[idx] > 0 then
		for i = 1, #player_weapons[idx] do
			if player_weapons[idx][i] == weapon then
				return
			end
		end
	end
	table.insert(player_weapons[idx], weapon)
end

local function remove_weapon(idx, weapon)
	if #player_weapons[idx] > 0 then
		for i = 1, #player_weapons[idx] do
			if player_weapons[idx][i] == weapon then
				table.remove(player_weapons[idx], i)
			end
		end
	end
end

local function deep_compare(tbl1, tbl2)
	for key1, value1 in pairs(tbl1) do
		local value2 = tbl2[key1]
		if value2 == nil then
			return false
		elseif value1 ~= value2 then
			if type(value1) == "table" and type(value2) == "table" then
				if not deep_compare(value1, value2) then
					return false
				end
			else
				return false
			end
		end
	end
	for key2, _ in pairs(tbl2) do
		if tbl1[key2] == nil then
			return false
		end
	end
	return true
end

local lastUpdate = 0
callbacks.Register("Draw", "hud_weapon_render", function()
	if entities.GetLocalPlayer() and hudweapon_enable:GetValue() then
		local player_resource = entities.GetPlayerResources()
		local currentUpdatePlayer = globals.FrameCount() % 16
		if currentUpdatePlayer ~= lastUpdate then
			local function updateIdx(currentUpdatePlayer)
				local r, g, b, a = hudweapon_color:GetValue()
				local forced_index = math.floor(currentUpdatePlayer)
				local playerInfo = client.GetPlayerInfo(forced_index)
				if playerInfo and not playerInfo.IsGOTV then
					local player_ent = entities.GetByIndex(forced_index)
					if not player_ent then return
					elseif player_ent and not player_ent:IsDormant() then
						local current_player_data = {}
						local active_weapon = player_ent:GetWeaponID()
						if active_weapon ~= nil then
							if player_ent:GetPropInt("m_bHasDefuser") == 1 then
								table.insert(current_player_data, "55")
							end
							for slot = 0, 63 do
								local weapon_ent = player_ent:GetPropEntity("m_hMyWeapons", string.format("%0.3d", slot))
								if weapon_ent ~= nil then
									local wep_id = weapon_ent:GetWeaponID()
									if wep_id then
										table.insert(current_player_data, tostring(wep_id))
									end
								end
							end
						end
						if player_resource:GetPropInt("m_iArmor", player_ent:GetIndex()) > 0 then
							if player_resource:GetPropInt("m_bHasHelmet", player_ent:GetIndex()) == 1 then
								table.insert(current_player_data, "51")
							else
								table.insert(current_player_data, "50")
							end
						end
						Client.updateWeapons(forced_index, {r, g, b}, a, filter_weapon(current_player_data), tostring(active_weapon))
						return
					elseif player_weapons[forced_index] and #player_weapons[forced_index] > 0 then
						Client.updateWeapons(forced_index, {r, g, b}, a, filter_weapon(player_weapons[forced_index]), hl[forced_index])
						return
					elseif player_weapons[forced_index] and #player_weapons[forced_index] == 0 then
						Client.updateWeapons(player_ent:GetIndex(), {r, g, b}, a, {"dead"}, "dead")
					end
					if not player_ent:IsAlive() then
						Client.updateWeapons(player_ent:GetIndex(), {r, g, b}, a, {"dead"}, "dead")
					end
				end
			end
			updateIdx(currentUpdatePlayer)
			updateIdx(currentUpdatePlayer * 2)
			updateIdx(currentUpdatePlayer * 4)
		end
		lastUpdate = currentUpdatePlayer
	end
end)
client.AllowListener("item_equip")
client.AllowListener("item_pickup")
client.AllowListener("item_remove")
client.AllowListener("grenade_thrown")
client.AllowListener("player_death")
client.AllowListener("cs_game_disconnected")
client.AllowListener("cs_match_end_restart")
client.AllowListener("start_halftime")
client.AllowListener("game_newmap")
client.AllowListener("round_end")
client.AllowListener("bomb_dropped")
callbacks.Register("FireGameEvent", "hud_weapon_events", function(event)
	local eventName = event:GetName()
	if eventName then
		if eventName == "item_equip" then
			local entid = entities.GetByUserID(event:GetInt("userid")):GetIndex()
			local wepName = event:GetString("defindex")
			hl[entid] = wepName
		elseif eventName == "item_pickup" then
			add_weapon(entities.GetByUserID(event:GetInt("userid")):GetIndex(), event:GetString("defindex"))
		elseif eventName == "item_remove" then
			remove_weapon(entities.GetByUserID(event:GetInt("userid")):GetIndex(), event:GetString("defindex"))
		elseif eventName == "player_death" then
			if player_weapons then
				player_weapons[entities.GetByUserID(event:GetInt("userid")):GetIndex()] = {}
				Client.updateWeapons(entities.GetByUserID(event:GetInt("userid")):GetIndex(), {0, 0, 0}, 0, {"dead"}, "dead")
			end
		elseif eventName == "round_end" or eventName == "bomb_dropped" then
			for k, v in pairs(player_weapons) do
				remove_weapon(k, "49")
			end
		end
	end
end)
--©thekorol


--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

