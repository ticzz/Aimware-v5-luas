 console_handlers = {}
function string:split(sep)
	 sep, fields = sep or ":", {}
	 pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c)
		fields[#fields + 1] = c
	end)
	return fields
end
 weapon_type_int = {
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
callbacks.Register("SendStringCmd", "lib_console_input", function(c)
	local raw_console_input = c:Get() 
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
		callbacks.Unregister("Draw", "AWStrangePanoramaFixer") 
		return true
	end
end)
local entities_GetPlayerResources, entities_FindByClass, entities_GetByIndex, entities_GetLocalPlayer, entities_GetByUserID =
    entities.GetPlayerResources,
    entities.FindByClass,
    entities.GetByIndex,
    entities.GetLocalPlayer,
    entities.GetByUserID
local client_GetLocalPlayerIndex,
    client_ChatSay,
    client_WorldToScreen,
    client_Command,
    client_GetPlayerIndexByUserID,
    client_SetConVar,
    client_GetPlayerInfo,
    client_GetConVar =
    client.GetLocalPlayerIndex,
    client.ChatSay,
    client.WorldToScreen,
    client.Command,
    client.GetPlayerIndexByUserID,
    client.SetConVar,
    client.GetPlayerInfo,
    client.GetConVar
local client_GetPlayerNameByIndex, client_GetPlayerNameByUserID, client_ChatTeamSay, client_AllowListener =
    client.GetPlayerNameByIndex,
    client.GetPlayerNameByUserID,
    client.ChatTeamSay,
    client.AllowListener
local globals_FrameTime,
    globals_AbsoluteFrameTime,
    globals_CurTime,
    globals_TickCount,
    globals_MaxClients,
    globals_RealTime,
    globals_FrameCount,
    globals_TickInterval =
    globals.FrameTime,
    globals.AbsoluteFrameTime,
    globals.CurTime,
    globals.TickCount,
    globals.MaxClients,
    globals.RealTime,
    globals.FrameCount,
    globals.TickInterval

local math_ceil,
    math_tan,
    math_huge,
    math_log10,
    math_randomseed,
    math_cos,
    math_sinh,
    math_random,
    math_mod,
    math_pi,
    math_max,
    math_atan2,
    math_ldexp,
    math_floor,
    math_sqrt,
    math_deg,
    math_atan =
    math.ceil,
    math.tan,
    math.huge,
    math.log10,
    math.randomseed,
    math.cos,
    math.sinh,
    math.random,
    math.mod,
    math.pi,
    math.max,
    math.atan2,
    math.ldexp,
    math.floor,
    math.sqrt,
    math.deg,
    math.atan
local math_fmod,
    math_acos,
    math_pow,
    math_abs,
    math_min,
    math_log,
    math_frexp,
    math_sin,
    math_tanh,
    math_exp,
    math_modf,
    math_cosh,
    math_asin,
    math_rad =
    math.fmod,
    math.acos,
    math.pow,
    math.abs,
    math.min,
    math.log,
    math.frexp,
    math.sin,
    math.tanh,
    math.exp,
    math.modf,
    math.cosh,
    math.asin,
    math.rad
local table_foreach, table_sort, table_remove, table_foreachi, table_maxn, table_getn, table_concat, table_insert =
    table.foreach,
    table.sort,
    table.remove,
    table.foreachi,
    table.maxn,
    table.getn,
    table.concat,
    table.insert
local string_find,
    string_lower,
    string_format,
    string_rep,
    string_gsub,
    string_len,
    string_gmatch,
    string_dump,
    string_match,
    string_reverse,
    string_byte,
    string_char,
    string_upper,
    string_gfind,
    string_sub =
    string.find,
    string.lower,
    string.format,
    string.rep,
    string.gsub,
    string.len,
    string.gmatch,
    string.dump,
    string.match,
    string.reverse,
    string.byte,
    string.char,
    string.upper,
    string.gfind,
    string.sub



 font = draw.CreateFont("Microsoft Tai Le", 32, 1000);
 font1 = draw.CreateFont("Verdana", 22, 400);
 Ind_font = draw.CreateFont("Verdana", 15, 400);
 ref = gui.Reference("Ragebot");
 tab = gui.Tab(ref, "SemiRage", "[Nigga-SemiRage]");
local screen_w, screen_h = draw.GetScreenSize();
local updaterfont1 = draw.CreateFont("Bahnschrift", 15);
local baserotation = "rbot.antiaim.base.rotation"
local UserName=cheat.GetUserName()

local Font2 = draw.CreateFont("Marlett", 35, 700)
local current_damage
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    local function decodeB64(data)
        data = string.gsub(data, '[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
        end))
    end;

 base64 = {
        fontIcon = [[
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
]]};
 local menu = gui.Reference('Menu')
 FIcon = draw.AddFontResource(decodeB64(base64.fontIcon));
 FontIcon = draw.CreateFont("icomoon", 42)
 FontDefault = draw.CreateFont("Verdana", 13)
 defusing = false;
 plantedat = 0;
 planting = false;
 bombsite = "???";
 plantingStarted = 0;
 display = false;
 shouldDrag = false;
 mouseX, mouseY, PosX, PosY, dx, dy, w, h = 0, 0, 25, 525, 0, 0, 190, 60;
local function lerp_pos(x1, y1, z1, x2, y2, z2, percentage) 
 x = (x2 - x1) * percentage + x1 
 y = (y2 - y1) * percentage + y1
 z = (z2 - z1) * percentage + z1 
return x, y, z 
end
local function sitename(site) 
 avec = entities.GetPlayerResources():GetProp("m_bombsiteCenterA")
 bvec = entities.GetPlayerResources():GetProp("m_bombsiteCenterB")
 sitevec1 = site:GetMins()
 sitevec2 = site:GetMaxs()
 site_x, site_y, site_z = lerp_pos(sitevec1.x, sitevec1.y, sitevec1.z , sitevec2.x, sitevec2.y, sitevec2.z, 0.5)
 distance_a, distance_b = vector.Distance({site_x, site_y, site_z}, {avec.x, avec.y, avec.z}), vector.Distance({site_x, site_y, site_z}, {bvec.x, bvec.y, bvec.z})
return distance_b > distance_a and "A" or "B" 
end

function EventHook(Event)
if Event:GetName() == "bomb_beginplant" then 
display = true
plantingStarted = globals.CurTime() 
bombsite = sitename(entities.GetByIndex(Event:GetInt("site")))
planting = true 
end
if Event:GetName() == "bomb_abortplant" then 
display = false
planting = false
end
if Event:GetName() == "bomb_begindefuse" then
defusing = true
elseif Event:GetName() == "bomb_abortdefuse" then
defusing = false
elseif Event:GetName() == "round_officially_ended" or Event:GetName() == "bomb_defused" or Event:GetName() == "bomb_exploded" then
display = false
defusing = false
planting = false
end
if Event:GetName() == "bomb_planted" then
plantedat = globals.CurTime()
planting = false
end	
end

local function dragFeature()
if input.IsButtonDown(1) then
mouseX, mouseY = input.GetMousePos();
if shouldDrag then
PosX = mouseX - dx;
PosY = mouseY - dy;
end
if mouseX >= PosX and mouseX <= PosX + w and mouseY >= PosY and mouseY <= PosY + 40 then
shouldDrag = true;
dx = mouseX - PosX;
dy = mouseY - PosY;
end
else
shouldDrag = false;
end
end

function Render()
    if bomb:GetValue() ~= true then return end
if display or menu:IsActive() then



 draw.Color(0,0,0,200);
draw.RoundedRectFill(PosX-5,PosY-5,PosX+165,PosY+35,1)
draw.Color(bomb_col:GetValue());
draw.SetFont(FontIcon)
draw.Text(PosX-3,PosY+14,"y")
draw.SetFont(FontDefault)
draw.Color(255,255,255,255);

draw.Text(PosX+40,PosY+3,"Site:")
draw.Text(PosX+90,PosY+3,"Time:")
draw.Text(PosX+40,PosY+17,"Damage:")
draw.Color(bomb_col2:GetValue());
draw.RoundedRectFill(PosX-5,PosY-4,PosX+165,PosY-5,1)
draw.Color(0,0,0,200);
draw.RoundedRectFill(PosX-5,PosY-30,PosX+165,PosY-5,1)
draw.SetFont(font1)
draw.Color(255,255,255,255);
draw.Text(PosX+15,PosY-25,"NiggaFish.lua")

draw.SetFont(FontDefault)
--Bait the nn
if planting == true then
 PlantTime = math.floor((((plantingStarted - globals.CurTime()) + 3.125) * 10)) / 10
PlantTime = tostring(PlantTime)
if not string.find(PlantTime, "%.") then
PlantTime = PlantTime .. ".0"
end
draw.Color(0,0,0,200);
draw.RoundedRectFill(PosX-5,PosY+35,PosX+165,PosY+55,1)
draw.SetFont(font1)
draw.Color(255,0,0,255)
draw.Text(PosX+30, PosY+35, " Planting".. bombsite)
draw.SetFont(FontDefault)
end
if entities.FindByClass("CPlantedC4")[1] ~= nil then
 Bomb = entities.FindByClass("CPlantedC4")[1];
if Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then
 bombtimer = math.floor((plantedat - globals.CurTime() + Bomb:GetProp("m_flTimerLength")) * 10) / 10	
if bombtimer < 0 then bombtimer = 0.0 end
if defusing == true then
draw.Color(2,123,253,255)
draw.Text(PosX+70, PosY+3, bombsite)
if bombtimer < 5 then
draw.Color(252,3,23,255);
elseif bombtimer < 10 then
draw.Color(252,117,23);
else
draw.Color(2,123,253,255);
end
bombtimer = tostring(bombtimer)
if not string.find(bombtimer, "%.") then
bombtimer = bombtimer .. ".0"
end
draw.Text(PosX+125, PosY+4, bombtimer .. "s")
draw.Color(23,114,69,255);
if Bomb:GetProp("m_flDefuseCountDown") > Bomb:GetProp("m_flC4Blow") then
draw.Color(255, 0, 0, 255);
end
local defusetime = math.floor( (Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10 ) / 10
defusetime = tostring(defusetime)

draw.Color(0,0,0,200);
draw.RoundedRectFill(PosX-5,PosY+35,PosX+165,PosY+55,1)
draw.Color(23,114,69,255);
if Bomb:GetProp("m_flDefuseCountDown") > Bomb:GetProp("m_flC4Blow") then
draw.Color(255, 0, 0, 255);
end
if not string.find(defusetime, "%.") then
defusetime = defusetime .. ".0"
end
draw.SetFont(font1)

draw.Text(PosX+115, PosY+35,defusetime .. "s")
draw.Color(255,255,255,255)
draw.Text(PosX+15, PosY+35, "Defusing : ")
draw.SetFont(FontDefault)
else
draw.Color(2,123,253,255)
draw.Text(PosX+70, PosY+3, bombsite)				
if bombtimer < 5 then
draw.Color(240, 20, 0, 255);
elseif bombtimer < 10 then
draw.Color(210, 150, 0, 255);
else
draw.Color(2,123,253,255);
end
bombtimer = tostring(bombtimer)
if not string.find(bombtimer, "%.") then
bombtimer = bombtimer .. ".0"
end
draw.Text(PosX+125, PosY+4, bombtimer .. "s")
end
 Player = entities.GetLocalPlayer();
if Player:IsAlive() and globals.CurTime() < Bomb:GetProp("m_flC4Blow") then		
local hpleft = math.floor(0.5 + BombDamage(Bomb, Player))
if hpleft >= Player:GetHealth() then
draw.Color(252,3,23,255)
draw.Text(PosX+93,PosY+17,"100")
elseif hpleft <= 0 then return
else
draw.Color(252,117,23,255)
draw.Text(PosX+93,PosY+17,hpleft)
end
end
elseif Bomb:GetProp("m_bBombTicking") and Bomb:GetProp("m_bBombDefused") == 0 and globals.CurTime() < (Bomb:GetProp("m_flC4Blow") + 2) then
 Player = entities.GetLocalPlayer(); 
if Player:IsAlive() and globals.CurTime() < (Bomb:GetProp("m_flC4Blow") + 1) then
 hpleft = math.floor(0.5 + BombDamage(Bomb, Player))
if hpleft >= Player:GetHealth() then
draw.Color(252,3,23,255)
draw.Text(PosX+93,PosY+17,"100")
elseif hpleft <= 0 then return
else
draw.Color(252,117,23,255)
draw.Text(PosX+93,PosY+17,hpleft)					
end
end
end
end
end

dragFeature();
end

function BombDamage(Bomb, Player)
 playerOrigin = Player:GetAbsOrigin()
 bombOrigin = Bomb:GetAbsOrigin()
 C4Distance = math.sqrt((bombOrigin.x - playerOrigin.x) ^ 2 + 
(bombOrigin.y - playerOrigin.y) ^ 2 + 
(bombOrigin.z - playerOrigin.z) ^ 2);
 Gauss = (C4Distance - 75.68) / 789.2 
 flDamage = 450.7 * math.exp(-Gauss * Gauss)
if Player:GetProp("m_ArmorValue") > 0 then
 flArmorRatio = 0.5;
 flArmorBonus = 0.5;
if Player:GetProp("m_ArmorValue") > 0 then	
 flNew = flDamage * flArmorRatio;
 flArmor = (flDamage - flNew) * flArmorBonus;
if flArmor > Player:GetProp("m_ArmorValue") then
flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus);
flNew = flDamage - flArmor;
end			 
flDamage = flNew;
end
end 
return math.max(flDamage, 0);
end





local ffi = ffi
local function a(b, c, d, e)
    local f = gui.Reference("menu")
    return (function()
        local g = {}
        local h, i, j, k, l, m, n, o, p, q, r, s, t, u
        local v = {__index = {Drag = function(self, ...)
                    local w, x = self:GetValue()
                    local y, z = g.drag(w, x, ...)
                    if w ~= y or x ~= z then
                        self:SetValue(y, z)
                    end
                    return y, z
                end, SetValue = function(self, w, x)
                    local p, q = draw.GetScreenSize()
                    self.x:SetValue(w / p * self.res)
                    self.y:SetValue(x / q * self.res)
                end, GetValue = function(self)
                    local p, q = draw.GetScreenSize()
                    return math.floor(self.x:GetValue() / self.res * p), math.floor(self.y:GetValue() / self.res * q)
                end}}
        function g.new(x, A, B, C, D)
            local D = D or 10000
            local p, q = draw.GetScreenSize()
            local A = A ~= "" and A .. "." or A
            local E = gui.Slider(x, A .. "x", "Position x", B / p * D, 0, D)
            local F = gui.Slider(x, A .. "y", "Position y", C / q * D, 0, D)
            E:SetInvisible(true)
            F:SetInvisible(true)
            return setmetatable({x = E, y = F, res = D}, v)
        end
        function g.drag(w, x, G, H, I)
            if globals.FrameCount() ~= h then
                i = f:IsActive()
                l, m = j, k
                j, k = input.GetMousePos()
                o = n
                n = input.IsButtonDown(1) == true
                s = r
                r = {}
                u = t
                t = false
                p, q = draw.GetScreenSize()
            end
            if i and o ~= nil then
                if (not o or u) and n and l > w and m > x and l < w + G and m < x + H then
                    t = true
                    w, x = w + j - l, x + k - m
                    if not I then
                        w = math.max(0, math.min(p - G, w))
                        x = math.max(0, math.min(q - H, x))
                    end
                end
            end
            table.insert(r, {w, x, G, H})
            return w, x, G, H
        end
        return g
    end)().new(b, c, d, e)
end
do
    ffi.cdef [[
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
    typedef struct {
        uint8_t r;
        uint8_t g;
        uint8_t b;
        uint8_t a;
    } color_struct_t;

    typedef void (*console_color_print)(const color_struct_t&, const char*, ...);

    typedef void* (__thiscall* get_client_entity_t)(void*, int);
    ]]
    function mem.CreateInterface(J, K)
        return ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(J), "CreateInterface"))(K, ffi.new("int*"))
    end
end
do
    local L =
        draw.CreateTexture(
        common.RasterizeSVG(
            [[<defs><linearGradient id="b" x1="100%" y1="0%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#b)" /></svg>]]
        )
    )
    local M =
        draw.CreateTexture(
        common.RasterizeSVG(
            [[<defs><linearGradient id="a" x1="0%" y1="100%" x2="0%" y2="0%"><stop offset="0%" style="stop-color:rgb(255,255,255); stop-opacity:0" /><stop offset="100%" style="stop-color:rgb(255,255,255); stop-opacity:1" /></linearGradient></defs><rect width="500" height="500" style="fill:url(#a)" /></svg>]]
        )
    )
    function draw.FilledRectFade(N, O, P, Q, R)
        local S = R and L or M
        draw.SetTexture(S)
        draw.FilledRect(math.floor(N), math.floor(O), math.floor(P), math.floor(Q))
        draw.SetTexture(nil)
    end
end
do
    function math.clamp(T, U, V)
        return T > V and V or T < U and U or T
    end
end

local hit_groups = {"Head", "Chest", "Stomach", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

local ffi_log = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ"))

local _SetTag = ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern('engine.dll', '53 56 57 8B DA 8B F9 FF 15'))

local SetTag = function(v)
    if v ~= last then
      _SetTag(v, v)
      last = v
    end
  end

function client.log(msg, ...)
    for k, v in pairs({...}) do
        msg = tostring(msg .. v)
    end
    ffi_log(ffi.new("color_struct_t"), msg .. "\n")
end

function client.color_log(r, g, b, msg, ...)
    for k, v in pairs({...}) do
        msg = tostring(msg .. v)
    end
    local clr = ffi.new("color_struct_t")
    clr.r, clr.g, clr.b, clr.a = r, g, b, 255
    ffi_log(clr, msg .. "\n")
end

local c_hud_chat =
    ffi.cast("unsigned long(__thiscall*)(void*, const char*)", mem.FindPattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))(
    ffi.cast("unsigned long**", ffi.cast("uintptr_t", mem.FindPattern("client.dll", "B9 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 5D 08")) + 1)[0],
    "CHudChat"
)

local ffi_print_chat = ffi.cast("void(__cdecl*)(int, int, int, const char*, ...)", ffi.cast("void***", c_hud_chat)[0][27])

function client.PrintChat(msg)
    ffi_print_chat(c_hud_chat, 0, 0, " " .. msg)
end

function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end


local function on_player_hurt(Event)
end

panorama.RunScript([[
        let muteSomeoneUHate = (ent) => {
        let xuid = GameStateAPI.GetPlayerXuidFromUserID(ent);
            if (GameStateAPI.IsXuidValid(xuid) && !GameStateAPI.IsFakePlayer(xuid) && !GameStateAPI.IsSelectedPlayerMuted(xuid)) {
                let isMuted = GameStateAPI.IsSelectedPlayerMuted(xuid);;
                if(isMuted) return;
                GameStateAPI.ToggleMute(xuid);
            }
        }
]])

panorama.RunScript([[
    let UnmuteSomeoneULike = (ent) => {
    let xuid = GameStateAPI.GetPlayerXuidFromUserID(ent);
        if (GameStateAPI.IsXuidValid(xuid) && !GameStateAPI.IsFakePlayer(xuid) && !GameStateAPI.IsSelectedPlayerMuted(xuid)) {
            let isMuted = GameStateAPI.IsSelectedPlayerMuted(xuid);
            if(isMuted) 
                GameStateAPI.ToggleMute(xuid);
        }
    }
]])

local function mute_someone_you_hate(UserID)

    panorama.RunScript([[muteSomeoneUHate( ]] .. UserID .. [[); 
                        var xuid = GameStateAPI.GetPlayerXuidFromUserID(]] .. UserID .. [[)
                        var name = GameStateAPI.GetPlayerName(xuid);
                        $.Msg("Muted: " + name)]])

end

local function unmute_someone_you_love_like_yukine(UserID)

    panorama.RunScript([[
        $.Msg("Running UnmuteFunc")
        UnmuteSomeoneULike(]] .. UserID .. [[);
    ]])

end

local function unmute_all()

    panorama.RunScript([[
        (function a() {
            let xuid = GameStateAPI.GetPlayerXuidStringFromEntIndex(]].. index ..[[)
            let isMuted = GameStateAPI.IsSelectedPlayerMuted(xuid)
            if (isMuted) GameStateAPI.ToggleMute(xuid)
        })()
    ]])

end
callbacks.Register("FireGameEvent", function(e)
    if e:GetName() ~= "player_team" then return end
    if e:GetInt("disconnect") == 1 then return end
    local index = entities.GetByUserID(e:GetInt("userid")):GetIndex()
    if index == client.GetLocalPlayerIndex() then 
        local ent = entities.FindByClass("CCSPlayer")
        for k,v in pairs(ent) do
            unmute_all(v:GetIndex())
        end
        return
    end
    unmute_all(index)
end)
client.AllowListener("player_team")
local function mute_all()

    panorama.RunScript([[
        for(var i = 0; i < 1000; i++){
            $.Msg(i)
            muteSomeoneUHate(i)
        }
    ]])

end

local clantag_speed = 3

local function print_user_id()

    local players = entities.FindByClass("CCSPlayer");

    for i = 1, #players do

        local player = players[i];

        local info = client.GetPlayerInfo(player:GetIndex())

        client.PrintChat(string.format( "Username: %s -> UserID: %s", player:GetName(), info["UserID"]))
        
    end


end

local function round(num, numDecimalPlaces)

	local mult = 10 ^ (numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult

end

local last_update_time = 0

local iter = 1

local clantag_set = ""

local clantag_type = ""

local clantag_str = ""

local function do_clantag(clantag, style)

    if clantag == nil or clantag == "" then return end

    
    local clantag_len = string.len(clantag)

    local cur_time = round(globals.CurTime() * clantag_speed, 0)



    if cur_time == last_update_time then return end



    if style == "Static" then

        clantag_set = clantag

    elseif style == "Build" then

       

        if cur_time % clantag_len == 0 then

            iter = 1

        end



     

        clantag_set = ""



        for i = 1, iter do

            clantag_set = clantag_set .. clantag:sub(i, i)

            print(clantag_set)

        end



   
        iter = iter + 1

    elseif style == "Scroll" then

 

        if cur_time % clantag_len == 0 then

            clantag_set = clantag .. " "

        end



    

        if clantag_set:len() > 0 then

            clantag_set = clantag_set .. clantag_set:sub(1, 1)

            clantag_set = clantag_set:sub(2, clantag_set:len())

        end

    elseif style == "Build-Scroll" then

   

        if cur_time % (clantag_len * 3 + 1) == 0 then 

            iter = 1

        end

    

 

        if iter <= clantag_len * 3 + 1 then

            if iter <= clantag_len then

                clantag_set = string.sub(clantag, 1, iter)

            elseif iter >= (clantag_len * 2) then

                clantag_set = string.sub(clantag, iter - clantag_len * 2 + 1, clantag_len)

            end

    

            iter = iter + 1

        end

    end



    SetTag(clantag_set, clantag_set)



    last_update_time = round(globals.CurTime() * clantag_speed, 0)

end



local function on_create_move(cmd)
 
    if(clantag_type == "") then clantag_type = "Static" end

    do_clantag(clantag_str, clantag_type)
    
end

local function set_animation(anim_type)

    if(string.find(string.lower(anim_type), "static") == 1) then

        clantag_type = "Static"

        return true

    elseif(string.find(string.lower(anim_type), "scroll") == 1) then

        clantag_type = "Scroll"

        return true

    elseif(string.find(string.lower(anim_type), "build") == 1) then

        clantag_type = "Build"

        return true

    elseif(string.find(string.lower(anim_type), "build-scroll") == 1) then

        clantag_type = "Build-Scroll"

        return true

    end

end

local function on_cmd(cmd) 

    if(string.find(cmd:Get(), 'say "!') == 1) then 

        if(cmd:Get() == 'say "!help"') then

            client.PrintChat("\02[NiggaFish.lua]\08 !clantag Clantag You want to set i.e. !clantag NiggaFish.lau")

            client.PrintChat("\02[NiggaFish.lua]\08 !animation static/scroll/build/build-scroll")

            client.PrintChat("\02[NiggaFish.lua]\08 !clantag_speed 3")

            client.PrintChat("\02[NiggaFish.lua]\08 !name Name You want to set i.e. !name NiggaFish")

            client.PrintChat("\02[NiggaFish.lua]\08 !consolecommand i.e. !disconnect")

            client.PrintChat("\02[NiggaFish.lua]\08 !mute UID i.e. !mute 3 use !list to find UID")

            client.PrintChat("\02[NiggaFish.lua]\08 !muteall UID i.e. !muteall Mutes everyone")

            client.PrintChat("\02[NiggaFish.lua]\08 !unmute UID i.e. !unmute 3 use !list to find UID (Not working?)")

            client.PrintChat("\02[NiggaFish.lua]\08 !list prints player names and their UID")

        elseif(cmd:Get() == 'say "!todo"') then

            client.PrintChat("\02[To-do]\08 !unmuteall")

            client.PrintChat("\02[To-do]\08 !muteall")

            client.PrintChat("\02[To-do]\08 !clantag prints subdirectories")

        elseif(string.find(cmd:Get(), 'say "!clantag') == 1) then 

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!clantag ', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Setting clantag: " .. t)

            clantag_str = t

        elseif(string.find(cmd:Get(), 'say "!unmuteall') == 1) then 

            client.PrintChat("\02[NiggaFish.lua]\08 Unmuting everyone")

            unmute_all()

        elseif(string.find(cmd:Get(), 'say "!muteall') == 1) then 

            client.PrintChat("\02[NiggaFish.lua]\08 Muting everyone")

            mute_all()

        elseif(string.find(cmd:Get(), 'say "!clantag_speed') == 1) then 

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!clantag_speed ', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Setting clantag speed: " .. t)

            clantag_speed = tonumber(t)

        elseif(string.find(cmd:Get(), 'say "!animation') == 1) then 

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!animation ', "")

            t = string.gsub(t, '"', "")

            local sucess = set_animation(t)

            if(sucess) then client.PrintChat("\02[NiggaFish.lua]\08 Setting animation: " .. t) end

        elseif(string.find(cmd:Get(), 'say "!name') == 1) then

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!name ', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Setting name: " .. t)

            client.SetConVar("name", t, 1)

        elseif(string.find(cmd:Get(), 'say "!mute') == 1) then

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!mute', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Muting player with UID: " .. t)

            mute_someone_you_hate(t)

        elseif(string.find(cmd:Get(), 'say "!unmute') == 1) then

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!unmute', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Unmuting player with UID: " .. t)

            unmute_someone_you_love_like_yukine(t)

        elseif(string.find(cmd:Get(), 'say "!list') == 1) then

            print_user_id()

        else 

            local commmand = cmd:Get()

            local t = string.gsub(cmd:Get(), 'say "!', "")

            t = string.gsub(t, '"', "")

            client.PrintChat("\02[NiggaFish.lua]\08 Running command: " .. t)

            client.Command(t, 1)

        end

    end

end










 guiSet = gui.SetValue
 guiGet = gui.GetValue
 auto = guiGet("rbot.hitscan.accuracy.asniper.mindamage")
 sniper = guiGet("rbot.hitscan.accuracy.sniper.mindamage")
 pistol = guiGet("rbot.hitscan.accuracy.pistol.mindamage")
 revolver = guiGet("rbot.hitscan.accuracy.hpistol.mindamage")
 smg = guiGet("rbot.hitscan.accuracy.smg.mindamage")
 rifle = guiGet("rbot.hitscan.accuracy.rifle.mindamage")
 shotgun = guiGet("rbot.hitscan.accuracy.shotgun.mindamage")
 scout = guiGet("rbot.hitscan.accuracy.scout.mindamage")
 lmg = guiGet("rbot.hitscan.accuracy.lmg.mindamage")

 guiSet = gui.SetValue
 guiGet = gui.GetValue
 togglekey = input.IsButtonDown
 Toggle =-1
 pressed = false
 awp1 = 0
 scout1 = 0
 auto1 = 0
 hpistol1 = 0

--main shit
 main_box = gui.Groupbox(tab, "Main", 16, 16, 200, 0);
 Ind = gui.Checkbox(main_box,"indicator", "Main indicator", false);
 Ind_col = gui.ColorPicker(Ind, "main.color", "Accent Color", 105,0,255, 255);
 Ind_col_2 = gui.ColorPicker(Ind, "main.color", "Accent Color", 20, 20, 20, 200);
 Ind2 = gui.Checkbox(main_box,"CrossHair", "Under CrossHair", true);
 Ind_col2 = gui.ColorPicker(Ind2, "main.color", "Accent Color", 105,0,255, 255);
 Ind_col2name = gui.ColorPicker(Ind2, "main.color", "Accent Color", 105,0,255, 255);
 anti_aim_arrow_cb = gui.Checkbox(main_box,"anti_aim_arrows", "Anti-Aim arrows", true);
 main_clr = gui.ColorPicker(anti_aim_arrow_cb, "main.color", "Accent Color", 105,0,255, 255);
 Y = gui.Checkbox(main_box, "so.watermark", "Watermark", 1)
 Z = gui.ColorPicker(Y, "clr", "Color", 105,0,255, 255)
 X = gui.Checkbox(main_box, "so.rainbow", "Rainbow", 0)
 Team = gui.Checkbox(main_box,"TeamDamage", "TeamDamage", true);


 --FOV
 Fov = gui.Groupbox(tab, "Fov", 232, 16, 200, 0);
 dynamic_enable = gui.Checkbox(Fov, "dynamic.enable", "Dynamic Fov Enable", true);
 dynamic_min_slider = gui.Slider(Fov, "dynamic.min", "Fov Min", 5, 1, 30);
 dynamic_max_slider = gui.Slider(Fov, "dynamic.max", "Fov Max", 10, 1, 30);



--swithers
 switch_box = gui.Groupbox(tab, "Switch", 448, 16, 174, 0);
 switch_enable = gui.Checkbox(switch_box, "switch.enable", "Enable", true);
 switch_fbaim_key = gui.Keybox(switch_box, "switch.force", "Force Baim", 0);
 switch_awall_key = gui.Keybox(switch_box, "switch.autowall", "Auto Wall", 0);
 key = gui.Keybox(switch_box, "lua_keybox", "Rage/Legit",0);
 


--misc
 misc_box = gui.Groupbox(tab, "Misc", 232, 266, 200, 0);
 EngineRadar = gui.Checkbox(misc_box, "engineradar", "Engine Radar", true)
 bomb = gui.Checkbox(misc_box, "bomb", "Bomb ", 1)
 bomb_col = gui.ColorPicker(bomb, "main.color", "Accent Color", 255,255,255, 255);
 bomb_col2 = gui.ColorPicker(bomb, "main.color", "Accent Color", 105,0,255, 255);
 main_unlockinv = gui.Checkbox(misc_box, "main.unlockinv", "Unlock Inventory", true);
on = gui.Checkbox(misc_box, "showvote", "Vote Revealer ", 1)
 Enable_Killsays = gui.Checkbox(misc_box, "enable.killsays", "Enable Killsay", false)
 Killsay_Mode = gui.Combobox(misc_box, "killsay.mode", "Select Killsay Mode", "NiggaFish.lua","AimWare.net")
  hudweapon_enable = gui.Checkbox(misc_box, "hudweapon.enabled", "Scoreboard", true)
  menu = {filter = gui.Multibox(misc_box, "Weapon filter")}
  itemList = {"Primary", "Secondary", "Knife/Taser", "Grenades", "C4", "Defuser", "Armor", "Other"}
 for index, value in ipairs(itemList) do
     menu["item_" .. index] = gui.Checkbox(menu.filter, "hudweapon.item_" .. index, value, false)
 end
  hudweapon_color = gui.ColorPicker(misc_box, "hudweapon.color", "Blur color", 105, 0, 255, 255)
  player_weapons = {}
 for i = 0, 64 do
     player_weapons[i] = {}
 end
 gui.Button(misc_box, "Clear equipments data", function()
     for i = 0, 64 do
         player_weapons[i] = {}
     end
 end)




--clantag
 misc_box1 = gui.Groupbox(tab, "Clantag", 440, 266, 200, 0);
 EnableClantag=gui.Checkbox(misc_box1,"EnableClantag","Clantag",false)
 enable = gui.Checkbox(misc_box1,"customtagenable", "Custom clantag", 0)
 tagbox = gui.Editbox(misc_box1, "customtag", "Clantag name ")
 speedslider = gui.Slider(misc_box1, "customtagspeed", "Clantag speed", 3, 0, 10, 0.1)
 stealclan = gui.Combobox(misc_box1, "stealclan", "Steal Clan", "Off")


 --minoverride
  Min_box = gui.Groupbox(tab, "Min Override", 16, 266, 200, 0);

   togglekey = gui.Keybox(Min_box, "ChangeDmgKey", "Key", 0)
  setDmg = gui.Combobox(Min_box, "mindmgmode", "Key Mode", "Off", "Toggle", "Hold")
  awpori = gui.Slider(Min_box, "awpori", "Awp Original Min Damage", 101, 0, 130)
  awpDamage = gui.Slider(Min_box, "awpDamage", "Awp Min Damage", 5, 0, 130)
  
  qawpDamage = gui.Slider(Min_box, "", "", 0, 0, 0)
  scoutori = gui.Slider(Min_box, "scoutori", "Scout Original Min Damage", 60, 0, 130)
  scoutDamage = gui.Slider(Min_box, "scoutDamage", "Scout Min Damage", 5, 0, 130)

  qawpDamage = gui.Slider(Min_box, "", "", 0, 0, 0)
  autoori = gui.Slider(Min_box, "autoori", "Auto Original Min Damage", 30, 0, 130)
  autoDamage = gui.Slider(Min_box, "autoDamage", "Auto Min Damage", 5, 0, 130)
 
  qawpDamage = gui.Slider(Min_box, "", "", 0, 0, 0)
  hpistolori = gui.Slider(Min_box, "hpistolori", "HeavyPistol Original Min Damage", 30, 0, 130)

  hpistolDamage = gui.Slider(Min_box, "hpistolDamage", "HeavyPistol Min Damage", 5, 0, 130)


 

 pressed = false;
--------NiggaFish Killsay--------
 NiggaFish_killsays = {
    [1] = "NiggaFish.lua is the best Lua for AimWare.net",
    [2] = "OMFG got shit on By NiggaFish.lua",
    [3] = "NiggaFish is free Semi-Rage lua on AimWare.net forums",
  }
  
  
  
  local function NiggaFish_KillSay( Event )
    
   if ( Event:GetName() == 'player_death' ) and Enable_Killsays:GetValue() == true and Killsay_Mode:GetValue() == 0 then
        
        ME = client.GetLocalPlayerIndex();
       
        INT_UID = Event:GetInt( 'userid' );
        INT_ATTACKER = Event:GetInt( 'attacker' );
       
        NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
        INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
       
        NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
        INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
        
       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
    
        random = math.random (1, 3)
        client.ChatSay( ' ' .. tostring( NiggaFish_killsays[random]));
  

    end
  
  end
  
  end
  --------NiggaFish Killsay--------
 AimWare_KillSay = {
    [1] = "Get Good Get Aimware.net",
    [2] = "Need the best cheat? got to Aimware.net",
    [3] = "Free Semi-Rage lua on AimWare forums",
  }
  
  
  
  local function AimWare_KillSay( Event )
    
   if ( Event:GetName() == 'player_death' ) and Enable_Killsays:GetValue() == true and Killsay_Mode:GetValue() == 1 then
        
        ME = client.GetLocalPlayerIndex();
       
        INT_UID = Event:GetInt( 'userid' );
        INT_ATTACKER = Event:GetInt( 'attacker' );
       
        NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
        INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );
       
        NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
        INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );
        
       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME ) then
    
        random = math.random (1, 3)
        client.ChatSay( ' ' .. tostring( AimWare_KillSay[random]));
  

    end
  
  end
  end


  local kills  = {}
  local deaths = {}
   
  local function KillDeathCount(event)
   
      local local_player = client.GetLocalPlayerIndex( );
      local INDEX_Attacker = client.GetPlayerIndexByUserID( event:GetInt( 'attacker' ) );
      local INDEX_Victim = client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) );
   
      if (event:GetName( ) == "client_disconnect") or (event:GetName( ) == "begin_new_match") then
          kills = {}
          deaths = {}
      end
   
      if event:GetName( ) == "player_death" then
          if INDEX_Attacker == local_player then
              kills[#kills + 1] = {};
          end
   
          if (INDEX_Victim == local_player) then
              deaths[#deaths + 1] = {};
          end
   
      end
  end
  
  a1 = draw.CreateFont("verdana", 15)
 a2 = {watermark = 0, spectators = 0}
 a3 = {

    watermark = function()
         a4 = mem.FindPattern("engine.dll", "FF E1")
         a5 = ffi.cast("uint32_t(__fastcall*)(unsigned int, unsigned int, const char*)", a4)
         a6 = ffi.cast("uint32_t(__fastcall*)(unsigned int, unsigned int, uint32_t, const char*)", a4)
         a7 = ffi.cast("uint32_t**", ffi.cast("uint32_t", mem.FindPattern("engine.dll", "FF 15 ?? ?? ?? ?? A3 ?? ?? ?? ?? EB 05")) + 2)[0][0]
         a8 = ffi.cast("uint32_t**", ffi.cast("uint32_t", mem.FindPattern("engine.dll", "FF 15 ?? ?? ?? ?? 85 C0 74 0B")) + 2)[0][0]
         a9 = function(aa, ab, ac)
             ad = ffi.typeof(ac)
            return function(...)
                return ffi.cast(ad, a4)(a6(a7, 0, a5(a8, 0, aa), ab), 0, ...)
            end
        end
         ae = a9("user32.dll", "EnumDisplaySettingsA", "int(__fastcall*)(unsigned int, unsigned int, unsigned int, unsigned long, void*)")
         af = ffi.new("struct { char pad_0[120]; unsigned long dmDisplayFrequency; char pad_2[32]; }[1]")
        ae(0, 4294967295, af[0])
        
    end,
   d
 
}
a3.watermark()

 aspect_table = {0, 2.0, 1.9, 1.8, 1.7, 1.6, 1.5, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3};
 weapons_table = {"asniper", "hpistol", "lmg", "pistol", "rifle", "scout", "smg", "shotgun", "sniper", "zeus",
                       "shared"};
 aa_side = false;
 switch_fbaim = false;
 switch_awall = false;
 fakeducking = false;
 time = 0.0;

 c_hud_chat =
    ffi.cast("unsigned long(__thiscall*)(void*, const char*)", mem.FindPattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))(
    ffi.cast("unsigned long**", ffi.cast("uintptr_t", mem.FindPattern("client.dll", "B9 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B 5D 08")) + 1)[0],
    "CHudChat"
)

 ffi_print_chat = ffi.cast("void(__cdecl*)(int, int, int, const char*, ...)", ffi.cast("void***", c_hud_chat)[0][27])

function client.PrintChat(msg)
    ffi_print_chat(c_hud_chat, 0, 0, " " .. msg)
end

 vote_print_chat =
    (function()


   

end)()

local function get_name(localplayer)
    if localplayer then
        local lp_index = client_GetLocalPlayerIndex()
        local n = client_GetPlayerNameByIndex(lp_index)
        return n
    else
        local n = client_GetConVar("name")
        return n
    end
end
local name = get_name(pattern)
local function rect(x, y, w, h, col)
    draw.Color(col[1], col[2], col[3], col[4]);
    draw.FilledRect(x, y, x + w, y + h);
end




local set_clan_tag = ffi.cast("int(__fastcall*)(const char*)", mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local SetClantag= ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern('engine.dll', '53 56 57 8B DA 8B F9 FF 15'))
function client.SetClanTag(...)
    local clan = ""

    for k, v in pairs({...}) do
        clan = tostring(clan .. v)
    end

    set_clan_tag(clan)
end
local animation={
    " ",
    "NiggaFish.lua ",
    "NiggaFish.lu ",
    "NiggaFish.l ",
    "NiggaFish. ",
    "NiggaFish ",
    "NiggaFis ",
    "NiggaFi ",
    "NiggaF ",
    "Nigga ",
    "Nigg ",
    "Nig ",
    "Ni ",
    "N ",

    "N ",
    "Ni ",
    "Nig ",
    "Nigg ",
    "Nigga ",
    "NiggaF ",
    "NiggaFi ",
    "NiggaFis ",
    "NiggaFish ",
    "NiggaFish. ",
    "NiggaFish.l ",
    "NiggaFish.lu ",
    "NiggaFish.lua ",
    " ",
    
}
function Clantag()
	if EnableClantag:GetValue()  then
		local CurTime = math.floor(globals.CurTime() * 2.3);
    	if OldTime ~= CurTime then
    	    SetClantag(animation[CurTime % #animation+1], animation[CurTime % #animation+1]);
    	end
    	OldTime = CurTime;
		clantagset = 1;
	else
		if clantagset == 1 then
            clantagset = 0;
            SetClantag("", "");
        end
	end
end
local last = nil
local tag = " "
local lasttag = nil
local tagsteps = {}
local SetTag = function(v)
    if v ~= last then
        SetClantag(v, "")
      last = v
    end
  end
  
  local function makesteps()
    tagsteps = {" "}
  
    for i = 1, #tag do
      table.insert(tagsteps, tag:sub(1, i))
    end
  
    for i = #tagsteps - 1, 1, -1 do
      table.insert(tagsteps, tagsteps[i])
    end
  end
  
  local function monkey()
    if enable:GetValue() then
      gui.SetValue("misc.clantag", false)
      tag = tagbox:GetValue()
      if tag:match("gamesense") then tag = "retard" end
      if lasttag ~= tag then
        makesteps()
        lasttag = tag
      end
      if speedslider:GetValue() == 0 then
        SetTag(tag)
      else
        SetTag(tagsteps[math.floor(globals.TickCount()/((11-speedslider:GetValue())*3.5))%(#tagsteps-1)+1])
      end
    else
      SetTag("")
    end
  end
  




--minover
function changeMinDamage()
 
      
    if (setDmg:GetValue()==1) then
            if input.IsButtonPressed(togglekey:GetValue()) then
                pressed=true;
    Toggle = Toggle *-1
    
            elseif (pressed and input.IsButtonReleased(togglekey:GetValue())) then
                pressed=false;
    
                if Toggle == 1 then
                guiSet("rbot.hitscan.accuracy.sniper.mindamage", awp1)
                guiSet("rbot.hitscan.accuracy.scout.mindamage", scout1)
                guiSet("rbot.hitscan.accuracy.asniper.mindamage", auto1)
                guiSet("rbot.hitscan.accuracy.hpistol.mindamage", hpistol1)
                else
            guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
            guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
            guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
            guiSet("rbot.hitscan.accuracy.hpistol.mindamage", hpistolori:GetValue())
    
                end
            end
        elseif (setDmg:GetValue()==2) then
            if input.IsButtonDown(togglekey:GetValue()) then
                guiSet("rbot.hitscan.accuracy.sniper.mindamage", awp1)
                guiSet("rbot.hitscan.accuracy.scout.mindamage", scout1)
                guiSet("rbot.hitscan.accuracy.asniper.mindamage", auto1)
                guiSet("rbot.hitscan.accuracy.hpistol.mindamage", hpistol1)
            else
            guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
            guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
            guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
            guiSet("rbot.hitscan.accuracy.hpistol.mindamage", hpistolori:GetValue())
            end
        elseif (setDmg:GetValue()==0) then
            Toggle = -1
            guiSet("rbot.hitscan.accuracy.asniper.mindamage", autoori:GetValue())
            guiSet("rbot.hitscan.accuracy.sniper.mindamage", awpori:GetValue())
            guiSet("rbot.hitscan.accuracy.scout.mindamage", scoutori:GetValue())
            guiSet("rbot.hitscan.accuracy.hpistol.mindamage", hpistolori:GetValue())
        end
    end
    
--minend

local function gradient_h(x1, y1, x2, y2, col1, left)
    local w = x2 - x1;
    local h = y2 - y1;

    for i = 0, w do
        local a = (i / w) * 200;
        local r, g, b = col1[1], col1[2], col1[3];
        draw.Color(r, g, b, a);
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h);
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h);
        end
    end
end

local function gradient_v(x, y, w, h, col1, col2, down)
    rect(x, y, w, h, col1);

    local r, g, b = col2[1], col2[2], col2[3];

    for i = 1, h do
        local a = i / h * 255;
        if down then
            rect(x, y + i, w, 1, {r, g, b, a});
        else
            rect(x, y - i, w, 1, {r, g, b, a});
        end
    end
end

local function check(option)
    if not option:GetValue() then
        return false;
    end
    if not gui.GetValue("rbot.master") then
        return false;
    end
    local lc = entities.GetLocalPlayer();
    if not lc or not lc:IsAlive() then
        return false;
    end
    return true;
end

local function get_weapon_class(lp)
    local weapon_id = lp:GetWeaponID();

    if weapon_id == 11 or weapon_id == 38 then
        return "asniper";
    elseif weapon_id == 1 or weapon_id == 64 then
        return "hpistol";
    elseif weapon_id == 14 or weapon_id == 28 then
        return "lmg";
    elseif weapon_id == 2 or weapon_id == 3 or weapon_id == 4 or weapon_id == 30 or weapon_id == 32 or weapon_id == 36 or weapon_id == 61 or weapon_id == 63 then
        return "pistol";
    elseif weapon_id == 7 or weapon_id == 8 or weapon_id == 10 or weapon_id == 13 or weapon_id == 16 or weapon_id == 39 or weapon_id == 60 then
        return "rifle";
    elseif weapon_id == 40 then
        return "scout";
    elseif weapon_id == 17 or weapon_id == 19 or weapon_id == 23 or weapon_id == 24 or weapon_id == 26 or weapon_id == 33 or weapon_id == 34 then
        return "smg";
    elseif weapon_id == 25 or weapon_id == 27 or weapon_id == 29 or weapon_id == 35 then
        return "shotgun";
    elseif weapon_id == 9 then
        return "sniper";
    elseif weapon_id == 31 then
        return "zeus";
    end

    return "shared";
end


function gradient(x1, y1, x2, y2, left)
    local w = x2 - x1
    local h = y2 - y1
 
    for i = 0, w do
        local a = (i / w) * 200
 
        draw.Color(0, 0, 0, a)
        if left then
            draw.FilledRect(x1 + i, y1, x1 + i + 1, y1 + h)
        else
            draw.FilledRect(x1 + w - i, y1, x1 + w - i + 1, y1 + h)
        end
    end
end
local function dynamic()
    if not check(dynamic_enable) then
        return;
    end

    if dynamic_min_slider:GetValue() > dynamic_max_slider:GetValue() then
        return;
    end

    if math.abs(globals.CurTime() - time) > 1 then
        gui.SetValue("rbot.aim.target.fov", math.random(dynamic_min_slider:GetValue(), dynamic_max_slider:GetValue()));
        time = globals.CurTime();
    end
end

local function switch()
	if Ind:GetValue() ~= true then return end
    local lc = entities.GetLocalPlayer();
      if lc and lc:IsAlive() then
     local x, y = draw.GetScreenSize()
     local centerX = x / 2
  
 --  if Ind2:GetValue() ~= true then return end
     
    --left
     gradient(centerX - 450, y - 20, centerX - 301, y, 0, true)
     gradient(centerX - 450, y - 20, centerX - 301, y - 19, true)
 
     gradient(centerX - 450, y - 20, centerX - 301, y, 0, true)
     
 
 
    draw.Color(0, 0, 0, 255)
     draw.FilledRect(centerX -300, y - 20, centerX + 300, y)
  
      draw.Color(0, 0, 0, 255)
     draw.FilledRect(centerX - 50, y - 20, centerX + 50, y - 19)
 
  draw.Color(0, 0, 0, 200)
  draw.FilledRect(centerX - 50, y - 40, centerX + 50, y)
 

 
  --right
     gradient(centerX + 300, y - 20, centerX + 431, y, false)
     gradient(centerX + 400, y - 20, centerX + 331, y - 19,false)
    gradient(centerX + 300, y - 20, centerX + 431, y,false)

  --top
     gradient(centerX + 50, y - 40, centerX + 100, y - 19, false)
     gradient(centerX - 100, y - 40, centerX - 51, y - 19, true)
     draw.Color(0, 0, 0, 255)
     draw.FilledRect(centerX - 50, y - 40, centerX + 50, y - 19)
    
       draw.SetFont(Ind_font);
       draw.Color(255, 255, 255, 255)
       draw.Text(centerX - 40,  y - 35, "Nigga      .lua")
       draw.Color(Ind_col:GetValue());
       draw.Text(centerX - 5,  y - 35, "Fish")
        draw.Color(255, 255, 255, 255);
        draw.Text(screen_w / 2 -351, screen_h / 2+525, "Fov:");
        draw.Text(screen_w / 2 - 295, screen_h / 2 + 525, "DMG:");
        draw.Text(screen_w / 2 - 235, screen_h / 2 + 525, "Accuracy:");
        draw.Text(screen_w / 2 - 135, screen_h / 2 + 525, "Awall:");
        draw.Text(screen_w / 2 - 70, screen_h / 2 + 525, "Baim:");
        draw.Text(screen_w / 2 - 0, screen_h / 2 + 525, "Resolver:");

        draw.Color(0, 255, 0, 255);
        draw.Text(screen_w / 2 - 323, screen_h / 2+525, gui.GetValue("rbot.aim.target.fov"," °"));
        draw.Color(0, 255, 0, 255);
        draw.Text(screen_w / 2 - 263, screen_h / 2 + 525, gui.GetValue("rbot.hitscan.accuracy." .. get_weapon_class(lc) .. ".mindamage"));
        if (gui.GetValue("rbot.master") == true ) and (gui.GetValue("rbot.aim.enable") == true) then
            onoroff = "Rage"
            draw.Color(0, 255, 0, 255)
            draw.Text(screen_w / 2 - 393, screen_h / 2 + 525, onoroff)     
            else
            onoroff = "Rage"
            draw.Color(255, 0, 0, 255)
            draw.Text(screen_w / 2 - 393, screen_h / 2 + 525, onoroff)     
            
        end

       if switch_awall then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 95, screen_h / 2 + 525, "ON");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 95, screen_h / 2 + 525, "OFF");
        end

        if switch_fbaim then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 30, screen_h / 2 + 525, "ON");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 30, screen_h / 2 + 525, "OFF");
        end

        if gui.GetValue("rbot.accuracy.posadj.resolver") then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 + 60, screen_h / 2 + 525, "ON");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 + 60, screen_h / 2 + 525, "OFF");
        end

        local accuracy = 100 - math.floor(entities.GetLocalPlayer():GetWeaponInaccuracy() * 10 ^ 3 + 0.5) / 10 ^ 3 * 100;

        if accuracy > 90 then
            draw.Color(0, 255, 0, 255);
            draw.Text(screen_w / 2 - 170, screen_h / 2 + 525, "High");
        else
            draw.Color(255, 0, 0, 255);
            draw.Text(screen_w / 2 - 170, screen_h / 2 + 525, "Low");
        end

        
   end
 
    if not check(switch_enable) then
        return;
    end

    if switch_fbaim_key:GetValue() ~= 0 then
        if input.IsButtonPressed(switch_fbaim_key:GetValue()) then
            if not switch_fbaim then
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 1);
                end
                switch_fbaim = true;
            else
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 0);
                end
                switch_fbaim = false;
            end
        end
    end

    if switch_awall_key:GetValue() ~= 0 then
        if input.IsButtonPressed(switch_awall_key:GetValue()) then
            if not switch_awall then
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 1);
                end
                switch_awall = true;
            else
                for i, v in next, weapons_table do
                    gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 0);
                end
                switch_awall = false;
            end
        end
    end 

    local x, y = draw.GetScreenSize()
    local centerX = x / 2

    draw.Color(255, 255, 255, 255)
    draw.Text(centerX + 150, y - 15, #kills)
 
    draw.Color(0, 255, 0, 255)
    draw.Text(centerX + 105, y - 15, "Kills:")
 

    draw.Color(255, 255, 255, 255)
    draw.Text(centerX + 255, y - 15, #deaths)
 
    draw.Color(255, 50, 50, 255)
    draw.Text(centerX + 205, y - 15, "Deaths:")
 
end

local teamDamageArray = {}

local function gameEvents(event)

	if event:GetName() == "weapon_fire" then
		lPlayer = entities.GetLocalPlayer()
		lPlayerTeam = lPlayer:GetTeamNumber()
	end

	if event:GetName() == "player_hurt" or event:GetName() == "player_death" then
		 attacker = event:GetInt("attacker")
		 victim = event:GetInt("userid")
		 dmgdone = event:GetInt("dmg_health")
		 attackerIndex = client.GetPlayerIndexByUserID(attacker)
		 victimIndex = client.GetPlayerIndexByUserID(victim)
		 attackerName = client.GetPlayerNameByUserID(attacker)
		 attackerUID = entities.GetByUserID(attacker)
		 victimUID = entities.GetByUserID(victim)
		 attackerTeam = attackerUID:GetTeamNumber()
		 victimTeam = victimUID:GetTeamNumber()
		 attackerPlayerInfo = client.GetPlayerInfo(attackerIndex)
		 victimPlayerInfo = client.GetPlayerInfo(victimIndex)
		 attackerSteamID = attackerPlayerInfo["SteamID"]
		 victimSteamID = victimPlayerInfo["SteamID"]

		if event:GetName() == "player_hurt" then
			local lPlayerTeam = lPlayer:GetTeamNumber()
			if victimTeam == lPlayerTeam and attackerTeam == lPlayerTeam and victimIndex ~= attackerIndex then
				if teamDamageArray[attackerSteamID] == nil then
					teamDamageArray[attackerSteamID] = {0, 0, attackerName}
				end
				teamDamageArray[attackerSteamID][1] = teamDamageArray[attackerSteamID][1] + dmgdone
			end
		elseif event:GetName() == "player_death" then
			local lPlayerTeam = lPlayer:GetTeamNumber()
			if victimTeam == lPlayerTeam and attackerTeam == lPlayerTeam and victimIndex ~= attackerIndex then
				teamDamageArray[attackerSteamID][2] = teamDamageArray[attackerSteamID][2] + 1
			end
		end
	end
	if event:GetName() == "cs_win_panel_match" then
		teamDamageArray = {}
	end
end
--3rd 


local thirdperson = "esp.local.thirdperson"

local function third_person_esp()
	if gui.GetValue(thirdperson) ~= true then return end
	if third_person_indicators:GetValue() ~= true then return end
	local localplayer = entities.GetLocalPlayer();
	if localplayer == nil then return end
	local head = localplayer:GetHitboxPosition(0)
	local head_pos_x, head_pos_y = client.WorldToScreen(head)
	local velocity = math.sqrt(localplayer:GetPropFloat( "localdata", "m_vecVelocity[0]" ) ^ 2 + localplayer:GetPropFloat( "localdata", "m_vecVelocity[1]" ) ^ 2)
	local fake_duck_on = cheat.IsFakeDucking();
	
	if head_pos_x == nil then return end
	if head_pos_y == nil then return end
	
	if current_damage == nil then 
		return
	end
	
	local damage_information = "damage: " .. current_damage
	
	local speed = "velocity: " .. string.format('%.f', velocity)
	local fake_duck = "fake duck: " .. tostring(fake_duck_on)
	
	draw.SetFont(third_person_font)
    local map_name = engine.GetMapName()
	
    local watermarktext = "damage: " .. current_damage .. " velocity: " .. string.format('%.f', velocity) .. " fake duck: " .. tostring(fake_duck_on)
    local watermark_text_size_x, watermark_text_size_y = draw.GetTextSize(watermarktext)
	
	draw.Color(0, 0, 0, 150)
	draw.FilledRect(head_pos_x + 47, head_pos_y, head_pos_x + watermark_text_size_x + 56, head_pos_y - 30); -- gray background
	
	draw.Color(bomb_col:GetValue());
    draw.FilledRect(head_pos_x + 47, head_pos_y - 32, head_pos_x + watermark_text_size_x + 56, head_pos_y - 30); -- top line
	
	draw.Color(255, 255, 255)
	draw.Text(head_pos_x + 50, head_pos_y - 20, watermarktext)
end
--3rdend
screenSize = {0, 0}
local function draw_Func()
    if Team:GetValue() ~= true then return end
	screenSize = {draw.GetScreenSize()}
	local playerCount = 0
	for i, v in pairs(teamDamageArray) do

        local lc = entities.GetLocalPlayer();
        if lc and lc:IsAlive() then
			if playerCount % 2 == 0 then
				draw.Color(20, 20, 20, 255)
			else
				draw.Color(20, 20, 20, 255)
			end

			if v[3]:len() > 15 then
				v[3] = v[3]:sub(1, 15).."..."
			end

           
			draw.FilledRect(screenSize[1] - select(1, draw.GetTextSize("Damage: 300")) - 53, screenSize[2] * 0.187 + (screenSize[2] * 0.027 * playerCount), screenSize[1], screenSize[2] * 0.214 + (screenSize[2] * 0.027 * playerCount))
		
			if v[2] == 0 then
				draw.Color(245, 245, 245, 255)
			elseif v[2] == 1 then
				draw.Color(245, 245, 0, 255)
			elseif v[2] == 2 then
				draw.Color(245, 150, 0, 255)
			elseif v[2] >= 3 then
				draw.Color(245, 0, 0, 255)				
			end
			draw.TextShadow(screenSize[1] - select(1, draw.GetTextSize("Kills: 0")) - 5, screenSize[2] * 0.2 + (screenSize[2] * 0.027 * playerCount), "Kills: "..v[2])	

		
			if v[1] < 100 then
				draw.Color(245, 245, 0, 255)
			elseif v[1] > 99 and v[1] < 199 then
				draw.Color(245, 150, 0, 255)
			elseif v[1] > 200 then
				draw.Color(245, 0, 0, 255)
			end
			draw.TextShadow(screenSize[1] - select(1, draw.GetTextSize("Damage: 300")) - 50, screenSize[2] * 0.2 + (screenSize[2] * 0.027 * playerCount), "Damage: "..v[1])

	
			draw.Color(255, 255, 255, 255)
			draw.TextShadow(screenSize[1] - select(1, draw.GetTextSize("Damage: 300")) - 50, screenSize[2] * 0.189 + (screenSize[2] * 0.027 * playerCount), v[3])
			

			playerCount = playerCount + 1
		end
	end
end


---
--©thekorol

--local enhancement = gui.Reference("Misc", "Enhancement", "Appearance")

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
		elseif wepType == "taser" then
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
	if hudweapon_enable:GetValue() and entities.GetLocalPlayer() then
		local player_resource = entities.GetPlayerResources()
		local currentUpdatePlayer = globals.FrameCount() % 16
		if currentUpdatePlayer ~= lastUpdate then
			local function updateIdx(currentUpdatePlayer)
				local r, g, b, a = hudweapon_color:GetValue()
				local forced_index = math.floor(currentUpdatePlayer)
				local playerInfo = client.GetPlayerInfo(forced_index)
				if playerInfo and not playerInfo.IsGOTV then
					local player_ent = entities.GetByIndex(forced_index)
					if player_ent and not player_ent:IsDormant() then
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

--end






local function main()
   


 

end


function paint_traverse()
    local lc = entities.GetLocalPlayer();
  if lc and lc:IsAlive() then
    local x, y = draw.GetScreenSize()
    local centerX = x / 2
 
if Ind2:GetValue() ~= true then return end
	

 draw.Color(Ind_col2:GetValue())
 draw.FilledRectFade(centerX - 50, y - 511, centerX + 50, y - 509)
 draw.SetFont(Ind_font);
 draw.Color(255, 255, 255, 255)
 draw.Text(centerX - 40,  y - 525, "Nigga      .lua")
 draw.Color(Ind_col2name:GetValue());
 draw.Text(centerX - 5,  y - 525, "Fish")
 draw.Color(255, 255, 255, 255);
 draw.Text(centerX - 45, y-505, "Rage:");
 draw.Text(centerX - 45, y-490, "Fov:");
 draw.Text(centerX - 45, y-475, "DMG:");
 draw.Text(centerX - 45, y-460, "Accuracy:");
 draw.Text(centerX - 45, y-445, "Awall:");
 draw.Text(centerX - 45, y-430, "Baim:");


  draw.Color(0, 255, 0, 255);
  draw.Text(centerX + 20, y-490, gui.GetValue("rbot.aim.target.fov"," °"));
  draw.Color(0, 255, 0, 255);
  draw.Text(centerX + 20, y-475, gui.GetValue("rbot.hitscan.accuracy." .. get_weapon_class(lc) .. ".mindamage"));
  if (gui.GetValue("rbot.master") == true ) and (gui.GetValue("rbot.aim.enable") == true) then
      onoroff = "ON"
      draw.Color(0, 255, 0, 255)
      draw.Text(centerX + 20, y-505, onoroff)     
      else
      onoroff = "OFF"
      draw.Color(255, 0, 0, 255)
      draw.Text(centerX + 20, y-505, onoroff)     
      
  end

 if switch_awall then
      draw.Color(0, 255, 0, 255);
      draw.Text(centerX + 20, y-445, "ON");
  else
      draw.Color(255, 0, 0, 255);
      draw.Text(centerX + 20, y-445, "OFF");
  end

  if switch_fbaim then
      draw.Color(0, 255, 0, 255);
      draw.Text(centerX +20, y-430, "ON");
  else
      draw.Color(255, 0, 0, 255);
      draw.Text(centerX +20, y-430, "OFF");
  end


  local accuracy = 100 - math.floor(entities.GetLocalPlayer():GetWeaponInaccuracy() * 10 ^ 3 + 0.5) / 10 ^ 3 * 100;

  if accuracy > 90 then
      draw.Color(0, 255, 0, 255);
      draw.Text(centerX +20, y-460, "High");
  else
      draw.Color(255, 0, 0, 255);
      draw.Text(centerX +20, y-460, "Low");
  end

  
end

if not check(switch_enable) then
  return;
end

if switch_fbaim_key:GetValue() ~= 0 then
  if input.IsButtonPressed(switch_fbaim_key:GetValue()) then
      if not switch_fbaim then
          for i, v in next, weapons_table do
              gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 1);
          end
          switch_fbaim = true;
      else
          for i, v in next, weapons_table do
              gui.SetValue("rbot.hitscan.mode." .. v .. ".bodyaim.force", 0);
          end
          switch_fbaim = false;
      end
  end
end

if switch_awall_key:GetValue() ~= 0 then
  if input.IsButtonPressed(switch_awall_key:GetValue()) then
      if not switch_awall then
          for i, v in next, weapons_table do
              gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 1);
          end
          switch_awall = true;
      else
          for i, v in next, weapons_table do
              gui.SetValue("rbot.hitscan.mode." .. v .. ".autowall", 0);
          end
          switch_awall = false;
      end
  end
end 
   
end

--val



local function anti_aim_arrows() 
    local lc = entities.GetLocalPlayer();
    if lc and lc:IsAlive() then
    if anti_aim_arrow_cb:GetValue() ~= true then return end
    local screen_size_x, screen_size_y = draw.GetScreenSize();
	local direction
	
	draw.Color(255, 255, 255, 255)
	
	if gui.GetValue(baserotation) >= 0 then
		direction = "left"
	else
		direction = "right"
	end
	
	if direction == "right" then
        draw.SetFont( Font2 )
        draw.Color(255,255,255);
        draw.TextShadow(screen_w / 2 - 65, screen_h / 2 - 15, "⮜");
    
         draw.Color(main_clr:GetValue());       
         draw.TextShadow(screen_w / 2 - 65, screen_h / 2 - 15, "⮜");
         
    end
	
	if direction == "left" then
        draw.SetFont( Font2 )
		 draw.Color(255,255,255);
        draw.TextShadow(screen_w / 2 + 45, screen_h / 2 - 15, "⮞");
        draw.Color(main_clr:GetValue());
        draw.TextShadow(screen_w / 2 + 45, screen_h / 2 - 15, "⮞");
	end
end
end
	


function Draw()

	anti_aim_arrows()
  --  third_person_esp()
end




--player list 
local w,h = draw.GetScreenSize()

local IN_SCOREBOARD = false

local ranks = {
"Silver 1",
"Silver 2",
"Silver 3",
"Silver 4",
"Silver Elite",
"Silver Elite Master",

"GOLD NOVA 1",
"GOLD NOVA 2",
"GOLD NOVA 3",
"GOLD NOVA Master",

"MG1",
"MG2",
"MGE",
"DMG",

"LE",
"LEM",
"SMFC",
"GE"
}

local font = draw.CreateFont("Tahoma", 20, 450)

callbacks.Register("CreateMove", function(cmd)
local IN_SCORE = bit.lshift(1, 16)
IN_SCOREBOARD = bit.band(cmd.buttons, IN_SCORE) == IN_SCORE
end)

callbacks.Register("Draw", function()
if not engine.GetServerIP() then return end

if not engine.GetServerIP():gmatch("=[A:") then return end

if not gui.Reference("menu"):IsActive() and not IN_SCOREBOARD then return end

local y = h/2

for i, v in next, entities.FindByClass("CCSPlayer") do
if v:GetName() ~= "GOTV" and entities.GetPlayerResources():GetPropInt("m_iPing", v:GetIndex()) ~= 0 then
local index = v:GetIndex()
local rank_index = entities.GetPlayerResources():GetPropInt("m_iCompetitiveRanking", index)
local wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
local rank = ranks[rank_index] or "Unranked"
draw.SetFont(font)
draw.Color(255,255,255,255)
draw.Text(5, y, v:GetName().." - Rank: "..rank.." Wins: "..wins)
y = y + 30
end
end
end)
--player list end 





--callbacks
client.AllowListener("player_hurt")
callbacks.Register("SendStringCmd", on_cmd)
callbacks.Register("FireGameEvent", on_player_hurt)
callbacks.Register("CreateMove", on_create_move)
callbacks.Register( "FireGameEvent", "KillDeathCount", KillDeathCount);
callbacks.Register(
    "DispatchUserMessage",
    function(um)
        local lp = entities.GetLocalPlayer()
        if not (gui.GetValue("misc.master") and on:GetValue() and lp) then
            return
        end

        local team = lp:GetTeamNumber()
        local clr = team == 2 and "\09" or team == 3 and "\10" or "\01"
        if um:GetID() == 46 then
            local type = um:GetInt(3)
            local type_name =
                type == 0 and "\07kick player " or type == 1 and " Change map " or type == 6 and "\04Surrender" or
                type == 13 and "\07Call a timeout"

            client.PrintChat(
                "[" .. clr .. "\02NiggaFish.lua\01] " .. client.GetPlayerNameByIndex(um:GetInt(2)) .. " wants to " .. type_name .. um:GetString(5)
            )
        end

        local results = um:GetID() == 47 and "\06Passed" or um:GetID() == 48 and "\02Failed"
        local _ = results and client.PrintChat("[" .. clr .. "\02NiggaFish.lua\01] " .. results)
    end
)

client.AllowListener("vote_cast")

callbacks.Register(
    "FireGameEvent",
    function(e)
        local lp = entities.GetLocalPlayer()
        if not (gui.GetValue("misc.master") and on:GetValue() and lp) then
            return
        end

        if e:GetName() and e:GetName() == "vote_cast" then
            local team = lp:GetTeamNumber()
            local option = e:GetInt("vote_option")
            local results = option == 0 and "\06YES" or option == 1 and "\07NO" or "?"

            client.PrintChat(
                "[" ..
                    (team == 2 and "\09" or team == 3 and "\10" or "\02") ..
                        "\02NiggaFish.lua\01] " .. client.GetPlayerNameByIndex(e:GetInt("entityid")) .. " " .. results
            )
        end
    end
)

callbacks.Register(
            "Draw",
            function()
                 ag = globals.FrameTime() * 8
                 s, h, c, b = Z:GetValue()
                 ah = entities.GetLocalPlayer()
                 ai = os.date("%X")
                 aj = "NiggaFish.lua"
                 --local ak = ah and ah:GetName() or client.GetConVar("name")

                 ak = ah and cheat.GetUserName() or cheat.GetUserName()
                 al = (" %s | %s | %s"):format(aj, ak, ai)
                if ah then
                     am = entities.GetPlayerResources():GetPropInt("m_iPing", ah:GetIndex())
                     an = (" | delay: %dms"):format(am)
                    al = (" %s | %s%s | %s"):format(aj, ak, an, ai)
                end
                draw.SetFont(a1)
                 ao, ap = draw.GetScreenSize()
                 i, x = 18, draw.GetTextSize(al) + 8
                 y, z = ao, 10 + 25 * 0
                y = y - x - 10
                a2.watermark = math.clamp(a2.watermark + (Y:GetValue() and ag or -ag), 0, 1)
                draw.SetScissorRect(y + x - x * a2.watermark, z, x, i * 3)
                if X:GetValue() then
                    draw.Color(s, h, c)
                    draw.FilledRectFade(y + x / 2 + 1, z + 2, y, z, true)
                    draw.FilledRectFade(y + x / 2, z, y + x, z + 2, true)
                    draw.Color(h, c, s)
                    draw.FilledRectFade(y, z, y + x / 2 + 1, z + 2, true)
                    draw.Color(c, s, h)
                    draw.FilledRectFade(y + x, z + 2, y + x / 2, z, true)
                else
                    draw.Color(s, h, c)
                    draw.FilledRect(y, z, y + x, z + 2)
                end
             
                draw.Color(17, 17, 17, 255)
                draw.FilledRect(y, z + 2, y + x, z + i)
                draw.Color(255, 255, 255)
                draw.Text(y + 4, z + 4, al)
                 al = ("%dhz"):format(tonumber(af[0].dmDisplayFrequency))
                 i, x = 18, draw.GetTextSize(al) + 8
                 y, z = ao, 10 + 25 * 1
                y = y - x - 10
               
                draw.Color(17, 17, 17, b)
                draw.FilledRect(y-90, z, y + x, z + i)
                draw.Color(255, 255, 255)
                draw.Text(y - 55, z + 4, #kills)
                draw.Text(y - 85, z + 4, "Kills:")

                draw.Text(y + 15, z + 4, #deaths)
                draw.Text(y - 35, z + 4, "Deaths:")
                draw.Color(Z:GetValue())
                draw.FilledRect(y-90, z+20, y + x, z + i)
                draw.Color(255, 255, 255)
                draw.SetScissorRect(0, 0, ao, ap)
               
   

                
               
             
            end
        )

callbacks.Register("Draw", monkey)
  
callbacks.Register("Unload", function()
  SetTag("")
end)

client.AllowListener("bomb_beginplant");
client.AllowListener("bomb_abortplant");
client.AllowListener("bomb_begindefuse");
client.AllowListener("bomb_abortdefuse"); 
client.AllowListener("bomb_defused");
client.AllowListener("bomb_exploded");
client.AllowListener("round_officially_ended");
client.AllowListener("bomb_planted");

callbacks.Register("Draw",Render);
callbacks.Register("FireGameEvent",EventHook);


callbacks.Register("Draw", "changeMinDamage", changeMinDamage);
callbacks.Register("Draw", Draw)
callbacks.Register( 'FireGameEvent', 'AWKS', NiggaFish_KillSay )
callbacks.Register( 'FireGameEvent', 'AWKS', AimWare_KillSay )


callbacks.Register('Draw', function()
	if EngineRadar:GetValue() == true then
		isEngineRadarOn = 1
	else
		isEngineRadarOn = 0
	end

	for index, Player in pairs(entities.FindByClass('CCSPlayer')) do
        Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)
callbacks.Register("Draw",Clantag)
client.AllowListener( "player_death" );
client.AllowListener( "client_disconnect" );
client.AllowListener( "begin_new_match" );

callbacks.Register("Draw", "paint_traverse", paint_traverse);
callbacks.Register("Draw", function()
    if key:GetValue() ~= 0 then
        if input.IsButtonPressed(key:GetValue()) then
 pressed=true;
 elseif (pressed and input.IsButtonReleased(key:GetValue())) then
 pressed=false;
 if gui.GetValue("rbot.master") then
 gui.SetValue("rbot.master", false)
 gui.SetValue("lbot.master", true)
 else
 gui.SetValue("rbot.master", true)
 gui.SetValue("lbot.master", false)
 end
 end
    end
 
end)

client.AllowListener("player_death")
client.AllowListener("player_hurt")
client.AllowListener("weapon_fire")
client.AllowListener("cs_win_panel_match")
callbacks.Register("FireGameEvent", "gameEvents", gameEvents)
callbacks.Register("Draw", "draw_Func", draw_Func)


callbacks.Register(
    "Draw",
    function()
        local lp = entities.GetLocalPlayer()

        if not entities.GetLocalPlayer() then
            return
        end

        local name = {"Off"}
        local clan = {}

        for k, v in pairs(entities.FindByClass("CCSPlayer")) do
            local idx = v:GetIndex()
            local m_szClan = idx ~= lp:GetIndex() and entities.GetPlayerResources():GetPropString("m_szClan", idx)
            if m_szClan then
                table.insert(name, v:GetName())
                table.insert(clan, m_szClan)
            end
        end

        stealclan:SetOptions(unpack(name))

        if clan[stealclan:GetValue()] and entities.GetPlayerResources():GetPropString("m_szClan", lp:GetIndex()) ~= clan[stealclan:GetValue()] then
            client.SetClanTag(clan[stealclan:GetValue()])
        end
    end
)


callbacks.Register("Draw", "dynamic_fov", dynamic);
callbacks.Register("Draw", "switch", switch);
callbacks.Register("Draw", "defaults", main);

print("Welocme to NiggaFish.lua "..UserName.."!")
