-- Desync Plus by stacky
--Some Vars
local screenCenterX, screenCenterY = draw.GetScreenSize();
screenCenterX = screenCenterX * 0.5;
screenCenterY = screenCenterY * 0.5;

DESYNCPLUS_CURRENT_VERSION = "2.0.3"
DESYNCPLUS_LATEST_VERSION = "Not Checked"

local SCREEN_W, SCREEN_H = draw.GetScreenSize()

local function guiModify(guiObject, x, y, width)
    if not guiObject then return end
    if x then guiObject:SetPosX(x) end
    if y then guiObject:SetPosY(y) end
    if width then guiObject:SetWidth(width) end
end

local activeMenu = 0
local activeState = 0
local bTabClicked = true

local FONT = draw.CreateFont("Verdana", 30, 2000)

local AW_WINDOW = gui.Reference( "Menu" )
local WINDOW = gui.Window( "desyncplus", "Desync Plus", 200, 200, 850, 550 )

local TABS_GBOX = gui.Groupbox( WINDOW, "", 10, 10, 830, 0 )
local ANTIAIM_BTN = gui.Button( TABS_GBOX, "Anti-Aim", function()
    activeMenu = 0
    bTabClicked = true
    WINDOW:SetHeight(550)
end )
guiModify(ANTIAIM_BTN, 0, -30, 180)
local BUILDER_BTN = gui.Button( TABS_GBOX, "Builder", function()
    activeMenu = 1
    bTabClicked = true
    WINDOW:SetHeight(290)
end )
guiModify(BUILDER_BTN, 205, -30, 180)
local MISC_BTN = gui.Button( TABS_GBOX, "Misc", function()
    activeMenu = 2
    bTabClicked = true
    WINDOW:SetHeight(495)
end )
guiModify(MISC_BTN, 415, -30, 180)
local SETTINGS_BTN = gui.Button( TABS_GBOX, "Settings", function()
    activeMenu = 3
    bTabClicked = true
    WINDOW:SetHeight(475)
end )
guiModify(SETTINGS_BTN, 620, -30, 180)

local menus = {
    antiaim = 0,
    builder = 1,
    misc = 2,
    settings = 3
}

local ANTIAIM_STATE_GBOX = gui.Groupbox( WINDOW, "", 10, 85, 830, 0 )
local ANTIAIM_STATE_STANDING_BTN = gui.Button( ANTIAIM_STATE_GBOX, "Standing", function()
    activeState = 0
end )
guiModify(ANTIAIM_STATE_STANDING_BTN, 0, -30, 180)
local ANTIAIM_STATE_MOVING_BTN = gui.Button( ANTIAIM_STATE_GBOX, "Moving", function()
    activeState = 1
end )
guiModify(ANTIAIM_STATE_MOVING_BTN, 300, -30, 180)
local ANTIAIM_STATE_AIR_BTN = gui.Button( ANTIAIM_STATE_GBOX, "Air", function()
    activeState = 2
end )
guiModify(ANTIAIM_STATE_AIR_BTN, 615, -30, 180)

local states = {
    standing = 0,
    moving = 1,
    air = 2
}

function pickle(t)
    return Pickle:clone():pickle_(t)
end

Pickle = {
    clone = function(t)
        local nt = {}
        for i, v in pairs(t) do
            nt[i] = v
        end
        return nt
    end
}

function Pickle:pickle_(root)
    if type(root) ~= "table" then
        error("can only pickle tables, not " .. type(root) .. "s")
    end
    self._tableToRef = {}
    self._refToTable = {}
    local savecount = 0
    self:ref_(root)
    local s = ""

    while table.getn(self._refToTable) > savecount do
        savecount = savecount + 1
        local t = self._refToTable[savecount]
        s = s .. "{\n"
        for i, v in pairs(t) do
            s = string.format("%s[%s]=%s,\n", s, self:value_(i), self:value_(v))
        end
        s = s .. "},\n"
    end

    return string.format("{%s}", s)
end

function Pickle:value_(v)
    local vtype = type(v)
    if vtype == "string" then
        return string.format("%q", v)
    elseif vtype == "number" then
        return v
    elseif vtype == "boolean" then
        return tostring(v)
    elseif vtype == "table" then
        return "{" .. self:ref_(v) .. "}"
    else --error("pickle a "..type(v).." is not supported")
    end
end

function Pickle:ref_(t)
    local ref = self._tableToRef[t]
    if not ref then
        if t == self then
            error("can't pickle the pickle class")
        end
        table.insert(self._refToTable, t)
        ref = table.getn(self._refToTable)
        self._tableToRef[t] = ref
    end
    return ref
end

function unpickle(s)
    if type(s) ~= "string" then
        error("can't unpickle a " .. type(s) .. ", only strings")
    end
    local gentables = loadstring("return " .. s)
    local tables = gentables()

    for tnum = 1, table.getn(tables) do
        local t = tables[tnum]
        local tcopy = {}
        for i, v in pairs(t) do
            tcopy[i] = v
        end
        for i, v in pairs(tcopy) do
            local ni, nv
            if type(i) == "table" then
                ni = tables[i[1]]
            else
                ni = i
            end
            if type(v) == "table" then
                nv = tables[v[1]]
            else
                nv = v
            end
            t[i] = nil
            t[ni] = nv
        end
    end
    return tables[1]
end

local base64 = {}

local extract = _G.bit32 and _G.bit32.extract
if not extract then
	if _G.bit then
		local shl, shr, band = _G.bit.lshift, _G.bit.rshift, _G.bit.band
		extract = function( v, from, width )
			return band( shr( v, from ), shl( 1, width ) - 1 )
		end
	elseif _G._VERSION >= "Lua 5.3" then
		extract = load[[return function( v, from, width )
			return ( v >> from ) & ((1 << width) - 1)
		end]]()
	else
		extract = function( v, from, width )
			local w = 0
			local flag = 2^from
			for i = 0, width-1 do
				local flag2 = flag + flag
				if v % flag2 >= flag then
					w = w + 2^i
				end
				flag = flag2
			end
			return w
		end
	end
end


function base64.makeencoder( s62, s63, spad )
	local encoder = {}
	for b64code, char in pairs{[0]='A','B','C','D','E','F','G','H','I','J',
		'K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y',
		'Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
		'o','p','q','r','s','t','u','v','w','x','y','z','0','1','2',
		'3','4','5','6','7','8','9',s62 or '+',s63 or'/',spad or'='} do
		encoder[b64code] = char:byte()
	end
	return encoder
end

function base64.makedecoder( s62, s63, spad )
	local decoder = {}
	for b64code, charcode in pairs( base64.makeencoder( s62, s63, spad )) do
		decoder[charcode] = b64code
	end
	return decoder
end

local DEFAULT_ENCODER = base64.makeencoder()
local DEFAULT_DECODER = base64.makedecoder()

local char, concat = string.char, table.concat

function base64.encode( str, encoder, usecaching )
	encoder = encoder or DEFAULT_ENCODER
	local t, k, n = {}, 1, #str
	local lastn = n % 3
	local cache = {}
	for i = 1, n-lastn, 3 do
		local a, b, c = str:byte( i, i+2 )
		local v = a*0x10000 + b*0x100 + c
		local s
		if usecaching then
			s = cache[v]
			if not s then
				s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
				cache[v] = s
			end
		else
			s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
		end
		t[k] = s
		k = k + 1
	end
	if lastn == 2 then
		local a, b = str:byte( n-1, n )
		local v = a*0x10000 + b*0x100
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[64])
	elseif lastn == 1 then
		local v = str:byte( n )*0x10000
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[64], encoder[64])
	end
	return concat( t )
end

function base64.decode( b64, decoder, usecaching )
	decoder = decoder or DEFAULT_DECODER
	local pattern = '[^%w%+%/%=]'
	if decoder then
		local s62, s63
		for charcode, b64code in pairs( decoder ) do
			if b64code == 62 then s62 = charcode
			elseif b64code == 63 then s63 = charcode
			end
		end
		pattern = ('[^%%w%%%s%%%s%%=]'):format( char(s62), char(s63) )
	end
	b64 = b64:gsub( pattern, '' )
	local cache = usecaching and {}
	local t, k = {}, 1
	local n = #b64
	local padding = b64:sub(-2) == '==' and 2 or b64:sub(-1) == '=' and 1 or 0
	for i = 1, padding > 0 and n-4 or n, 4 do
		local a, b, c, d = b64:byte( i, i+3 )
		local s
		if usecaching then
			local v0 = a*0x1000000 + b*0x10000 + c*0x100 + d
			s = cache[v0]
			if not s then
				local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
				s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
				cache[v0] = s
			end
		else
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
		end
		t[k] = s
		k = k + 1
	end
	if padding == 1 then
		local a, b, c = b64:byte( n-3, n-1 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
		t[k] = char( extract(v,16,8), extract(v,8,8))
	elseif padding == 2 then
		local a, b = b64:byte( n-3, n-2 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000
		t[k] = char( extract(v,16,8))
	end
	return concat( t )
end

function split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do table.insert(t, str) end
    return t
end

-- Base Direction
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX = gui.Groupbox( WINDOW, "Base Direction", 10, 165, 200, 500 )
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, "antiaim.basedir.standing.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_BASEVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, "antiaim.basedir.standing.basevalue", "Base Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, "antiaim.basedir.standing.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, "antiaim.basedir.standing.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, "antiaim.basedir.standing.speed", "Speed", 0, 0, 100 )

DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX = gui.Groupbox( WINDOW, "Base Direction", 10, 165, 200, 500 )
DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, "antiaim.basedir.moving.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_BASEVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, "antiaim.basedir.moving.basevalue", "Base Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, "antiaim.basedir.moving.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, "antiaim.basedir.moving.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, "antiaim.basedir.moving.speed", "Speed", 0, 0, 100 )

DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX = gui.Groupbox( WINDOW, "Base Direction", 10, 165, 200, 500 )
DESYNCPLUS_ANTIAIM_BASEDIR_AIR_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, "antiaim.basedir.air.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_BASEDIR_AIR_BASEVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, "antiaim.basedir.air.basevalue", "Base Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, "antiaim.basedir.air.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, "antiaim.basedir.air.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_BASEDIR_AIR_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, "antiaim.basedir.air.speed", "Speed", 0, 0, 100 )

-- Rotation
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX = gui.Groupbox( WINDOW, "Rotation", 220, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.minvalue", "Minimal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.maxvalue", "Maximal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MIN = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.deadzone.min", "Min Dead Zone", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MAX = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, "antiaim.rotation.standing.deadzone.max", "Max Dead Zone", 0, -58, 58 )

DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX = gui.Groupbox( WINDOW, "Rotation", 220, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.minvalue", "Minimal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.maxvalue", "Maximal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MIN = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.deadzone.min", "Min Dead Zone", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MAX = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, "antiaim.rotation.moving.deadzone.max", "Max Dead Zone", 0, -58, 58 )

DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX = gui.Groupbox( WINDOW, "Rotation", 220, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.minvalue", "Minimal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.maxvalue", "Maximal Value", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.deadzone.min", "Min Dead Zone", 0, -58, 58 )
DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MAX = gui.Slider( DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, "antiaim.rotation.air.deadzone.max", "Max Dead Zone", 0, -58, 58 )

-- LBY
DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX = gui.Groupbox( WINDOW, "LBY", 430, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_LBY_STANDING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, "antiaim.lby.standing.type", "Type", "Off", "Static", "Match", "Opposite", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_LBY_STANDING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, "antiaim.lby.standing.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_STANDING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, "antiaim.lby.standing.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_STANDING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, "antiaim.lby.standing.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_LBY_STANDING_VALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, "antiaim.lby.standing.value", "Value", 0, 0, 180 )

DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX = gui.Groupbox( WINDOW, "LBY", 430, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_LBY_MOVING_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, "antiaim.lby.moving.type", "Type", "Off", "Static", "Match", "Opposite", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_LBY_MOVING_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, "antiaim.lby.moving.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_MOVING_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, "antiaim.lby.moving.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_MOVING_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, "antiaim.lby.moving.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_LBY_MOVING_VALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, "antiaim.lby.moving.value", "Value", 0, 0, 180 )

DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX = gui.Groupbox( WINDOW, "LBY", 430, 165, 200, 200 )
DESYNCPLUS_ANTIAIM_LBY_AIR_TYPE = gui.Combobox( DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, "antiaim.lby.air.type", "Type", "Off", "Static", "Match", "Opposite", "Switch", "Cycle", "Jitter" )
DESYNCPLUS_ANTIAIM_LBY_AIR_MINVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, "antiaim.lby.air.minvalue", "Minimal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_AIR_MAXVALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, "antiaim.lby.air.maxvalue", "Maximal Value", 0, -180, 180 )
DESYNCPLUS_ANTIAIM_LBY_AIR_SPEED = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, "antiaim.lby.air.speed", "Speed", 0, 0, 100 )
DESYNCPLUS_ANTIAIM_LBY_AIR_VALUE = gui.Slider( DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, "antiaim.lby.air.value", "Value", 0, 0, 180 )

-- Pitch
local ANTIAIM_PITCH_STANDING_GBOX = gui.Groupbox( WINDOW, "Pitch", 640, 165, 200, 200 )
local ANTIAIM_PITCH_STANDING_TYPE = gui.Combobox( ANTIAIM_PITCH_STANDING_GBOX, "antiaim.pitch.standing.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
local ANTIAIM_PITCH_STANDING_MINVALUE = gui.Slider( ANTIAIM_PITCH_STANDING_GBOX, "antiaim.pitch.standing.minvalue", "Minimal Value", 0, -180, 180 )
local ANTIAIM_PITCH_STANDING_MAXVALUE = gui.Slider( ANTIAIM_PITCH_STANDING_GBOX, "antiaim.pitch.standing.maxvalue", "Maximal Value", 0, -180, 180 )
local ANTIAIM_PITCH_STANDING_SPEED = gui.Slider( ANTIAIM_PITCH_STANDING_GBOX, "antiaim.pitch.standing.speed", "Speed", 0, 0, 100 )

local ANTIAIM_PITCH_MOVING_GBOX = gui.Groupbox( WINDOW, "Pitch", 640, 165, 200, 200 )
local ANTIAIM_PITCH_MOVING_TYPE = gui.Combobox( ANTIAIM_PITCH_MOVING_GBOX, "antiaim.pitch.moving.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
local ANTIAIM_PITCH_MOVING_MINVALUE = gui.Slider( ANTIAIM_PITCH_MOVING_GBOX, "antiaim.pitch.moving.minvalue", "Minimal Value", 0, -180, 180 )
local ANTIAIM_PITCH_MOVING_MAXVALUE = gui.Slider( ANTIAIM_PITCH_MOVING_GBOX, "antiaim.pitch.moving.maxvalue", "Maximal Value", 0, -180, 180 )
local ANTIAIM_PITCH_MOVING_SPEED = gui.Slider( ANTIAIM_PITCH_MOVING_GBOX, "antiaim.pitch.moving.speed", "Speed", 0, 0, 100 )

local ANTIAIM_PITCH_AIR_GBOX = gui.Groupbox( WINDOW, "Pitch", 640, 165, 200, 200 )
local ANTIAIM_PITCH_AIR_TYPE = gui.Combobox( ANTIAIM_PITCH_AIR_GBOX, "antiaim.pitch.air.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
local ANTIAIM_PITCH_AIR_MINVALUE = gui.Slider( ANTIAIM_PITCH_AIR_GBOX, "antiaim.pitch.air.minvalue", "Minimal Value", 0, -180, 180 )
local ANTIAIM_PITCH_AIR_MAXVALUE = gui.Slider( ANTIAIM_PITCH_AIR_GBOX, "antiaim.pitch.air.maxvalue", "Maximal Value", 0, -180, 180 )
local ANTIAIM_PITCH_AIR_SPEED = gui.Slider( ANTIAIM_PITCH_AIR_GBOX, "antiaim.pitch.air.speed", "Speed", 0, 0, 100 )

local tblANTIAIM = {
    DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_GBOX, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_GBOX, DESYNCPLUS_ANTIAIM_LBY_STANDING_GBOX, ANTIAIM_PITCH_STANDING_GBOX,
    DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_GBOX, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_GBOX, DESYNCPLUS_ANTIAIM_LBY_MOVING_GBOX, ANTIAIM_PITCH_MOVING_GBOX,
    DESYNCPLUS_ANTIAIM_BASEDIR_AIR_GBOX, DESYNCPLUS_ANTIAIM_ROTATION_AIR_GBOX, DESYNCPLUS_ANTIAIM_LBY_AIR_GBOX, ANTIAIM_PITCH_AIR_GBOX, ANTIAIM_STATE_GBOX
}

local tblBASEDIR = {
    { DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_TYPE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_TYPE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_TYPE },
    {
        { DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_SPEED },
        { DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_SPEED },
        { DESYNCPLUS_ANTIAIM_BASEDIR_AIR_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_SPEED }
    }
}

local tblROTATION = {
    { DESYNCPLUS_ANTIAIM_ROTATION_STANDING_TYPE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_TYPE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_TYPE },
    {
        { DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_SPEED, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MAX },
        { DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_SPEED, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MAX },
        { DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_SPEED, DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MAX }
    }
}

local tblLBY = {
    { DESYNCPLUS_ANTIAIM_LBY_STANDING_TYPE, DESYNCPLUS_ANTIAIM_LBY_MOVING_TYPE, DESYNCPLUS_ANTIAIM_LBY_AIR_TYPE },
    {
        { DESYNCPLUS_ANTIAIM_LBY_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_STANDING_SPEED, DESYNCPLUS_ANTIAIM_LBY_STANDING_VALUE },
        { DESYNCPLUS_ANTIAIM_LBY_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_MOVING_SPEED, DESYNCPLUS_ANTIAIM_LBY_MOVING_VALUE },
        { DESYNCPLUS_ANTIAIM_LBY_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_AIR_SPEED, DESYNCPLUS_ANTIAIM_LBY_AIR_VALUE }
    }
}

local tblPITCH = {
    { ANTIAIM_PITCH_STANDING_TYPE, ANTIAIM_PITCH_MOVING_TYPE, ANTIAIM_PITCH_AIR_TYPE },
    {
        { ANTIAIM_PITCH_STANDING_MINVALUE, ANTIAIM_PITCH_STANDING_MAXVALUE, ANTIAIM_PITCH_STANDING_SPEED },
        { ANTIAIM_PITCH_MOVING_MINVALUE, ANTIAIM_PITCH_MOVING_MAXVALUE, ANTIAIM_PITCH_MOVING_SPEED },
        { ANTIAIM_PITCH_AIR_MINVALUE, ANTIAIM_PITCH_AIR_MAXVALUE, ANTIAIM_PITCH_AIR_SPEED }
    }
}

local tblPITCHVALUES = {
    ANTIAIM_PITCH_STANDING_MINVALUE, ANTIAIM_PITCH_STANDING_MAXVALUE, ANTIAIM_PITCH_MOVING_MINVALUE, ANTIAIM_PITCH_MOVING_MAXVALUE, ANTIAIM_PITCH_AIR_MINVALUE, ANTIAIM_PITCH_AIR_MAXVALUE
}

local tblDeadZone = {
    { DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MAX, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE },
    { DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MAX, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE },
    { DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE }
}

local tblShared = { tblBASEDIR, tblROTATION, tblLBY, tblPITCH }

local bShared = false

local function handleAntiaimGUI()
    local startingIndex = nil
    if activeState == states.standing then
        startingIndex = 1
    elseif activeState == states.moving then
        startingIndex = 5
    else
        startingIndex = 9
    end

    for i = startingIndex, startingIndex + 3 do
        tblANTIAIM[i]:SetInvisible(false)
    end
    ANTIAIM_STATE_GBOX:SetInvisible(false)

    local tblDisable = {false, false, false, false}
    if tblBASEDIR[1][activeState + 1]:GetValue() == 0 then
        tblDisable = {true, true, true, true}
    elseif tblBASEDIR[1][activeState + 1]:GetValue() == 1 then
        tblDisable = {false, true, true, true}
    elseif tblBASEDIR[1][activeState + 1]:GetValue() == 2 then
        tblDisable = {true, false, false, false}
    elseif tblBASEDIR[1][activeState + 1]:GetValue() == 3 then
        tblDisable = {false, false, false, false}
    elseif tblBASEDIR[1][activeState + 1]:GetValue() == 4 then
        tblDisable = {false, false, false, false}
    end

    for j = 1, #tblBASEDIR[2][activeState + 1] do
        tblBASEDIR[2][activeState + 1][j]:SetDisabled(tblDisable[j])
    end

    for i = 1, #tblROTATION[2] do
        if tblROTATION[1][i]:GetValue() == 0 then
            tblDisable = {true, true, true, true, true}
        elseif tblROTATION[1][i]:GetValue() == 1 then
            tblDisable = {false, true, true, true, true}
        elseif tblROTATION[1][i]:GetValue() == 2 then
            tblDisable = {false, false, false, true, true}
        elseif tblROTATION[1][i]:GetValue() == 4 or tblROTATION[1][i]:GetValue() == 3 then
            tblDisable = {false, false, false, false, false}
        end

        for j = 1, #tblROTATION[2][i] do
            tblROTATION[2][i][j]:SetDisabled(tblDisable[j])
        end
    end

    for i = 1, #tblLBY[2] do
        if tblLBY[1][i]:GetValue() == 0 then
            tblDisable = {true, true, true, true}
        elseif tblLBY[1][i]:GetValue() == 1 then
            tblDisable = {false, true, true, true}
        elseif tblLBY[1][i]:GetValue() == 2 or tblLBY[1][i]:GetValue() == 3 then
            tblDisable = {true, true, true, false}
        elseif tblLBY[1][i]:GetValue() == 4 then
            tblDisable = {false, false, false, true}
        elseif tblLBY[1][i]:GetValue() == 5 then
            tblDisable = {false, false, false, true}
        elseif tblLBY[1][i]:GetValue() == 6 then
            tblDisable = {false, false, false, true}
        end

        for j = 1, #tblLBY[2][i] do
            tblLBY[2][i][j]:SetDisabled(tblDisable[j])
        end
    end

    for i = 1, #tblPITCH[2] do
        if tblPITCH[1][i]:GetValue() == 0 then
            tblDisable = {true, true, true}
        elseif tblPITCH[1][i]:GetValue() == 1 then
            tblDisable = {false, true, true}
        elseif tblPITCH[1][i]:GetValue() == 2 or tblPITCH[1][i]:GetValue() == 3 then
            tblDisable = {false, false, false}
        elseif tblPITCH[1][i]:GetValue() == 4 then
            tblDisable = {false, false, false}
        end

        for j = 1, #tblPITCH[2][i] do
            tblPITCH[2][i][j]:SetDisabled(tblDisable[j])
        end
    end

    if gui.GetValue( "misc.antiuntrusted" ) then
        for i = 1, #tblPITCHVALUES do
            if tblPITCHVALUES[i]:GetValue() < -89 then
                tblPITCHVALUES[i]:SetValue(-89)
            elseif tblPITCHVALUES[i]:GetValue() > 89 then
                tblPITCHVALUES[i]:SetValue(89)
            end
        end
    end

    if bShared then
        for tbl = 1, #tblShared do
            tblShared[tbl][1][2]:SetValue(tblShared[tbl][1][1]:GetValue())
            tblShared[tbl][1][3]:SetValue(tblShared[tbl][1][1]:GetValue())
    
            for i = 2, #tblShared[tbl][2] do
                for j = 1, #tblShared[tbl][2][i] do
                    tblShared[tbl][2][i][j]:SetValue(tblShared[tbl][2][1][j]:GetValue())
                end
            end
        end
    end

    local tblDeadZone = {
        { DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MAX, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE },
        { DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MAX, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE },
        { DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE }
    }

    for state = 1, #tblDeadZone do
        if tblDeadZone[state][1]:GetValue() < tblDeadZone[state][2]:GetValue() then tblDeadZone[state][1]:SetValue(tblDeadZone[state][2]:GetValue()) end
        if tblDeadZone[state][3]:GetValue() > tblDeadZone[state][4]:GetValue() then tblDeadZone[state][3]:SetValue(tblDeadZone[state][4]:GetValue()) end
    end

end

local playerState = {
    standing = 0,
    moving = 1,
    air = 2
}

local iBaseDirTick = 0
local iBaseDirSwitch = 0
local iBaseDirDirection = 1
local iBaseDirAngle = 0
local iLastBaseValue = 0

local iRotationTick = 0
local iRotationSwitch = 0
local iRotationDirection = 0
local iRotationAngle = 0

local iLBYTick = 0
local iLBYSwitch = 0
local iLBYDirection = 0
local iLBYAngle = 0

local iPitchTick = 0
local iPitchSwitch = 0
local iPitchDirection = 0
local iPitchAngle = 0
local iLastPitch = 0

local bShotRevolver = false
local iTickRateMultiplier = 1
local iInvert = 1

local bInvertBaseDir = false
local bInvertRotation = false
local bInvertLBY = false

local function calcCycle(angle, step)
    if step == -1 then
        if angle == -179 then
            return 180
        end
    else
        if angle == 180 then
            return -179
        end
    end

    return angle + step
end

local function handleAntiaim(cmd)
    local hLocalPlayer = entities.GetLocalPlayer()

    local tblValues = {
        BaseDir = { Type = nil, BaseValue = nil, MinValue = nil, MaxValue = nil, Speed = nil },
        Rotation = { Type = nil, MinValue = nil, MaxValue = nil, Speed = nil, MinDeadZone = nil, MaxDeadZone = nil },
        LBY = { Type = nil, MinValue = nil, MaxValue = nil, Speed = nil, Value = nil },
        Pitch = { Type = nil, MinValue = nil, MaxValue = nil, Speed = nil },
    }
    
    if bit.band(hLocalPlayer:GetPropInt("m_fFlags"), 1) == 0 then
        tblValues.BaseDir.Type = DESYNCPLUS_ANTIAIM_BASEDIR_AIR_TYPE:GetValue()
        tblValues.BaseDir.BaseValue = DESYNCPLUS_ANTIAIM_BASEDIR_AIR_BASEVALUE:GetValue()
        tblValues.BaseDir.MinValue = DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MINVALUE:GetValue()
        tblValues.BaseDir.MaxValue = DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MAXVALUE:GetValue()
        tblValues.BaseDir.Speed = DESYNCPLUS_ANTIAIM_BASEDIR_AIR_SPEED:GetValue()

        tblValues.Rotation.Type = DESYNCPLUS_ANTIAIM_ROTATION_AIR_TYPE:GetValue()
        tblValues.Rotation.MinValue = DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE:GetValue()
        tblValues.Rotation.MaxValue = DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE:GetValue()
        tblValues.Rotation.Speed = DESYNCPLUS_ANTIAIM_ROTATION_AIR_SPEED:GetValue()
        tblValues.Rotation.MinDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MIN:GetValue()
        tblValues.Rotation.MaxDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_AIR_DEADZONE_MAX:GetValue()

        tblValues.LBY.Type = DESYNCPLUS_ANTIAIM_LBY_AIR_TYPE:GetValue()
        tblValues.LBY.MinValue = DESYNCPLUS_ANTIAIM_LBY_AIR_MINVALUE:GetValue()
        tblValues.LBY.MaxValue = DESYNCPLUS_ANTIAIM_LBY_AIR_MAXVALUE:GetValue()
        tblValues.LBY.Speed = DESYNCPLUS_ANTIAIM_LBY_AIR_SPEED:GetValue()
        tblValues.LBY.Value = DESYNCPLUS_ANTIAIM_LBY_AIR_VALUE:GetValue()

        tblValues.Pitch.Type = ANTIAIM_PITCH_AIR_TYPE:GetValue()
        tblValues.Pitch.MinValue = ANTIAIM_PITCH_AIR_MINVALUE:GetValue()
        tblValues.Pitch.MaxValue = ANTIAIM_PITCH_AIR_MAXVALUE:GetValue()
        tblValues.Pitch.Speed = ANTIAIM_PITCH_AIR_SPEED:GetValue()
    else
        if math.sqrt(hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[0]" ) ^ 2 + hLocalPlayer:GetPropFloat( "localdata", "m_vecVelocity[1]" ) ^ 2) > 5 then
            tblValues.BaseDir.Type = DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_TYPE:GetValue()
            tblValues.BaseDir.BaseValue = DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_BASEVALUE:GetValue()
            tblValues.BaseDir.MinValue = DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MINVALUE:GetValue()
            tblValues.BaseDir.MaxValue = DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MAXVALUE:GetValue()
            tblValues.BaseDir.Speed = DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_SPEED:GetValue()
    
            tblValues.Rotation.Type = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_TYPE:GetValue()
            tblValues.Rotation.MinValue = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE:GetValue()
            tblValues.Rotation.MaxValue = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE:GetValue()
            tblValues.Rotation.Speed = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_SPEED:GetValue()
            tblValues.Rotation.MinDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MIN:GetValue()
            tblValues.Rotation.MaxDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_MOVING_DEADZONE_MAX:GetValue()
    
            tblValues.LBY.Type = DESYNCPLUS_ANTIAIM_LBY_MOVING_TYPE:GetValue()
            tblValues.LBY.MinValue = DESYNCPLUS_ANTIAIM_LBY_MOVING_MINVALUE:GetValue()
            tblValues.LBY.MaxValue = DESYNCPLUS_ANTIAIM_LBY_MOVING_MAXVALUE:GetValue()
            tblValues.LBY.Speed = DESYNCPLUS_ANTIAIM_LBY_MOVING_SPEED:GetValue()
            tblValues.LBY.Value = DESYNCPLUS_ANTIAIM_LBY_MOVING_VALUE:GetValue()
    
            tblValues.Pitch.Type = ANTIAIM_PITCH_MOVING_TYPE:GetValue()
            tblValues.Pitch.MinValue = ANTIAIM_PITCH_MOVING_MINVALUE:GetValue()
            tblValues.Pitch.MaxValue = ANTIAIM_PITCH_MOVING_MAXVALUE:GetValue()
            tblValues.Pitch.Speed = ANTIAIM_PITCH_MOVING_SPEED:GetValue()
        else
            tblValues.BaseDir.Type = DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_TYPE:GetValue()
            tblValues.BaseDir.BaseValue = DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_BASEVALUE:GetValue()
            tblValues.BaseDir.MinValue = DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MINVALUE:GetValue()
            tblValues.BaseDir.MaxValue = DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MAXVALUE:GetValue()
            tblValues.BaseDir.Speed = DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_SPEED:GetValue()
    
            tblValues.Rotation.Type = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_TYPE:GetValue()
            tblValues.Rotation.MinValue = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE:GetValue()
            tblValues.Rotation.MaxValue = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE:GetValue()
            tblValues.Rotation.Speed = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_SPEED:GetValue()
            tblValues.Rotation.MinDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MIN:GetValue()
            tblValues.Rotation.MaxDeadZone = DESYNCPLUS_ANTIAIM_ROTATION_STANDING_DEADZONE_MAX:GetValue()
    
            tblValues.LBY.Type = DESYNCPLUS_ANTIAIM_LBY_STANDING_TYPE:GetValue()
            tblValues.LBY.MinValue = DESYNCPLUS_ANTIAIM_LBY_STANDING_MINVALUE:GetValue()
            tblValues.LBY.MaxValue = DESYNCPLUS_ANTIAIM_LBY_STANDING_MAXVALUE:GetValue()
            tblValues.LBY.Speed = DESYNCPLUS_ANTIAIM_LBY_STANDING_SPEED:GetValue()
            tblValues.LBY.Value = DESYNCPLUS_ANTIAIM_LBY_STANDING_VALUE:GetValue()
    
            tblValues.Pitch.Type = ANTIAIM_PITCH_STANDING_TYPE:GetValue()
            tblValues.Pitch.MinValue = ANTIAIM_PITCH_STANDING_MINVALUE:GetValue()
            tblValues.Pitch.MaxValue = ANTIAIM_PITCH_STANDING_MAXVALUE:GetValue()
            tblValues.Pitch.Speed = ANTIAIM_PITCH_STANDING_SPEED:GetValue()
        end
    end

    local iInvertBaseDir = 1
    if bInvertBaseDir then iInvertBaseDir = iInvert end

    local iInvertRotation = 1
    if bInvertRotation then iInvertRotation = iInvert end

    local iInvertLBY = 1
    if bInvertLBY then iInvertLBY = iInvert end
    
    -- Base Direction

    if tblValues.BaseDir.Type == 1 then -- Static
        gui.SetValue("rbot.antiaim.base", tblValues.BaseDir.BaseValue * iInvertBaseDir)
    elseif tblValues.BaseDir.Type == 3 then -- Cycle
        local iSteps = math.floor(tblValues.BaseDir.Speed / 4)

        if iLastBaseValue ~= tblValues.BaseDir.BaseValue then
            iBaseDirAngle = tblValues.BaseDir.BaseValue
            iBaseDirDirection = 1
        end

        for i = 0, iSteps do
            iBaseDirAngle = calcCycle(iBaseDirAngle, iBaseDirDirection)

            if iBaseDirAngle == tblValues.BaseDir.MaxValue or iBaseDirAngle == tblValues.BaseDir.MinValue then
                iBaseDirDirection = iBaseDirDirection * -1
            end
        end

        gui.SetValue("rbot.antiaim.base", iBaseDirAngle * iInvertBaseDir)
        iLastBaseValue = tblValues.BaseDir.BaseValue
    elseif globals.TickCount() >= iBaseDirTick + (100 - tblValues.BaseDir.Speed) * iTickRateMultiplier then 
        if tblValues.BaseDir.Type == 2 then -- Switch
            if iBaseDirSwitch == tblValues.BaseDir.MinValue then
                gui.SetValue( "rbot.antiaim.base", tblValues.BaseDir.MaxValue * iInvertBaseDir )
                iBaseDirSwitch = tblValues.BaseDir.MaxValue
            else
                gui.SetValue( "rbot.antiaim.base", tblValues.BaseDir.MinValue * iInvertBaseDir )
                iBaseDirSwitch = tblValues.BaseDir.MinValue
            end
        elseif tblValues.BaseDir.Type == 4 then -- Jitter
            local iRandom = math.random(tblValues.BaseDir.MinValue, tblValues.BaseDir.MaxValue)       
            if tblValues.BaseDir.BaseValue + iRandom > 180 or tblValues.BaseDir.BaseValue + iRandom < -180 then tblValues.BaseDir.BaseValue = tblValues.BaseDir.BaseValue * -1 end
            gui.SetValue("rbot.antiaim.base", (tblValues.BaseDir.BaseValue + iRandom) * iInvertBaseDir)
        end

        iBaseDirTick = globals.TickCount()
    end

    -- Rotation

    if tblValues.Rotation.Type == 1 then -- Static
        gui.SetValue("rbot.antiaim.base.rotation", tblValues.Rotation.MinValue * iInvertRotation)
    elseif tblValues.Rotation.Type == 3 then -- Cycle
        local speed = tblValues.Rotation.Speed / 4

        if iRotationAngle >= tblValues.Rotation.MaxValue then iRotationDirection = 1 
        elseif iRotationAngle <= tblValues.Rotation.MinValue + speed then iRotationDirection = 0 end

        if iRotationDirection == 0 and iRotationAngle <= tblValues.Rotation.MinDeadZone and iRotationAngle + speed >= tblValues.Rotation.MinDeadZone then
            iRotationAngle = tblValues.Rotation.MaxDeadZone
        end

        if iRotationDirection == 1 and iRotationAngle >= tblValues.Rotation.MaxDeadZone and iRotationAngle - speed <= tblValues.Rotation.MaxDeadZone then
            iRotationAngle = tblValues.Rotation.MinDeadZone
        end

        if iRotationDirection == 0 then iRotationAngle = iRotationAngle + speed
        elseif iRotationDirection == 1 then iRotationAngle = iRotationAngle - speed end      
        gui.SetValue("rbot.antiaim.base.rotation", iRotationAngle * iInvertRotation)
    elseif globals.TickCount() >= iRotationTick + (100 - tblValues.Rotation.Speed) * iTickRateMultiplier then 
        if tblValues.Rotation.Type == 2 then -- Switch
            if iRotationSwitch == tblValues.Rotation.MinValue then
                gui.SetValue( "rbot.antiaim.base.rotation", tblValues.Rotation.MaxValue * iInvertRotation )
                iRotationSwitch = tblValues.Rotation.MaxValue
            else
                gui.SetValue( "rbot.antiaim.base.rotation", tblValues.Rotation.MinValue * iInvertRotation )
                iRotationSwitch = tblValues.Rotation.MinValue
            end
        elseif tblValues.Rotation.Type == 4 then -- Jitter
            local rndChoice = math.random(0, 1)
            local rndValue = 0
            local rndValueMin = math.random(tblValues.Rotation.MinValue, tblValues.Rotation.MinDeadZone)
            local rndValueMax = math.random(tblValues.Rotation.MaxDeadZone, tblValues.Rotation.MaxValue)
            

            if rndChoice == 0 then
                rndValue = rndValueMin
            else
                rndValue = rndValueMax
            end

            gui.SetValue("rbot.antiaim.base.rotation", rndValue * iInvertRotation)
        end

        iRotationTick = globals.TickCount()
    end

    -- LBY

    if tblValues.LBY.Type == 1 then -- Static
        gui.SetValue("rbot.antiaim.base.lby", tblValues.LBY.MinValue * iInvertLBY)
    elseif tblValues.LBY.Type == 2 then -- Match
        if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
            gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.Value * iInvertLBY )
        else
            gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.Value * -1 * iInvertLBY )
        end
    elseif tblValues.LBY.Type == 3 then -- Opposite
        if gui.GetValue("rbot.antiaim.base.rotation") <= 0 then
            gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.Value * iInvertLBY )
        else
            gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.Value * -1 * iInvertLBY )
        end
    elseif tblValues.LBY.Type == 5 then -- Cycle
        if iLBYAngle >= tblValues.LBY.MaxValue then iLBYDirection = 1 
        elseif iLBYAngle <= tblValues.LBY.MinValue + tblValues.LBY.Speed / 4 then  iLBYDirection = 0 end

        if iLBYDirection == 0 then iLBYAngle = iLBYAngle + tblValues.LBY.Speed / 4
        elseif iLBYDirection == 1 then iLBYAngle = iLBYAngle - tblValues.LBY.Speed / 4 end      
        gui.SetValue("rbot.antiaim.base.lby", iLBYAngle * iInvertLBY)
    elseif globals.TickCount() >= iLBYTick + (100 - tblValues.LBY.Speed) * iTickRateMultiplier then 
        if tblValues.LBY.Type == 4 then -- Switch
            if iLBYSwitch == tblValues.LBY.MinValue then
                gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.MaxValue * iInvertLBY )
                iLBYSwitch = tblValues.LBY.MaxValue
            else
                gui.SetValue( "rbot.antiaim.base.lby", tblValues.LBY.MinValue * iInvertLBY )
                iLBYSwitch = tblValues.LBY.MinValue
            end
        elseif tblValues.LBY.Type == 6 then -- Jitter
            gui.SetValue("rbot.antiaim.base.lby", math.random(tblValues.LBY.MinValue, tblValues.LBY.MaxValue) * iInvertLBY)
        end

        iLBYTick = globals.TickCount()
    end

    -- Pitch

    if hLocalPlayer:GetWeaponID() == 64 then
        local flReadyTime = globals.CurTime() - hLocalPlayer:GetPropEntity("m_hActiveWeapon"):GetPropFloat("m_flPostponeFireReadyTime")
        if flReadyTime < 0 and bShotRevolver then bShotRevolver = false end
        if flReadyTime >= 0 and bit.band(cmd.buttons, 1) ~= 0 and not bShotRevolver then
            bShotRevolver = true 
            return
        end
    end

    if bit.band(cmd.buttons, 1) ~= 0 or bit.band(cmd.buttons, 2048) ~= 0 or bit.band(cmd.buttons, 32) ~= 0 then return end
    if hLocalPlayer:GetWeaponType() == 9 then
        if hLocalPlayer:GetPropEntity("m_hActiveWeapon"):GetProp("m_fThrowTime") ~= 0 then return end
    end

    if tblValues.Pitch.Type == 1 then -- Static
        cmd.viewangles = EulerAngles(tblValues.Pitch.MinValue, cmd.viewangles["yaw"], 0)
    elseif tblValues.Pitch.Type == 3 then -- Cycle
        if iPitchAngle >= tblValues.Pitch.MaxValue then iPitchDirection = 1 
        elseif iPitchAngle <= tblValues.Pitch.MinValue + tblValues.Pitch.Speed / 4 then  iPitchDirection = 0 end

        if iPitchDirection == 0 then iPitchAngle = iPitchAngle + tblValues.Pitch.Speed / 4
        elseif iPitchDirection == 1 then iPitchAngle = iPitchAngle - tblValues.Pitch.Speed / 4 end    
        cmd.viewangles = EulerAngles(iPitchAngle, cmd.viewangles["yaw"], 0)  
    elseif globals.TickCount() >= iPitchTick + (100 - tblValues.Pitch.Speed) * iTickRateMultiplier then 
        if tblValues.Pitch.Type == 2 then -- Switch
            if iPitchSwitch == tblValues.Pitch.MinValue then
                cmd.viewangles = EulerAngles(tblValues.Pitch.MaxValue, cmd.viewangles["yaw"], 0)
                iLastPitch = tblValues.Pitch.MaxValue
                iPitchSwitch = tblValues.Pitch.MaxValue
            else
                cmd.viewangles = EulerAngles(tblValues.Pitch.MinValue, cmd.viewangles["yaw"], 0)
                iLastPitch = tblValues.Pitch.MinValue
                iPitchSwitch = tblValues.Pitch.MinValue
            end
        elseif tblValues.Pitch.Type == 4 then -- Jitter
            local iRandom = math.random(tblValues.Pitch.MinValue, tblValues.Pitch.MaxValue)
            cmd.viewangles = EulerAngles(iRandom, cmd.viewangles["yaw"], 0)
            iLastPitch = iRandom
        end

        iPitchTick = globals.TickCount()
    elseif tblValues.Pitch.Type ~= 0 then
        cmd.viewangles = EulerAngles(iLastPitch, cmd.viewangles["yaw"], 0)
    end
end

local iRunningStep = 0
local iSelectedStep = 1
local iLastTick = 0
local flLastTime = 0
local bSetValues = false
local tblSteps = {}

local builderTable = {
    DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_SPEED,
    DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_SPEED,
    DESYNCPLUS_ANTIAIM_BASEDIR_AIR_BASEVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_BASEDIR_AIR_SPEED,
    DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_STANDING_SPEED,
    DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_MOVING_SPEED,
    DESYNCPLUS_ANTIAIM_ROTATION_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_ROTATION_AIR_SPEED,
    DESYNCPLUS_ANTIAIM_LBY_STANDING_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_STANDING_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_STANDING_SPEED, DESYNCPLUS_ANTIAIM_LBY_STANDING_VALUE,
    DESYNCPLUS_ANTIAIM_LBY_MOVING_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_MOVING_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_MOVING_SPEED, DESYNCPLUS_ANTIAIM_LBY_MOVING_VALUE,
    DESYNCPLUS_ANTIAIM_LBY_AIR_MINVALUE, DESYNCPLUS_ANTIAIM_LBY_AIR_MAXVALUE, DESYNCPLUS_ANTIAIM_LBY_AIR_SPEED, DESYNCPLUS_ANTIAIM_LBY_AIR_VALUE,
    ANTIAIM_PITCH_STANDING_MINVALUE, ANTIAIM_PITCH_STANDING_MAXVALUE, ANTIAIM_PITCH_STANDING_SPEED,
    ANTIAIM_PITCH_MOVING_MINVALUE, ANTIAIM_PITCH_MOVING_MAXVALUE, ANTIAIM_PITCH_MOVING_SPEED,
    ANTIAIM_PITCH_AIR_MINVALUE, ANTIAIM_PITCH_AIR_MAXVALUE, ANTIAIM_PITCH_AIR_SPEED
}

local BUILDER_INFO_GBOX = gui.Groupbox( WINDOW, "Info", 10, 85, 200, 0 )
local BUILDER_INFO_TOTAL = gui.Text( BUILDER_INFO_GBOX, "Total Steps: 0" )
local BUILDER_INFO_RUNNING = gui.Text( BUILDER_INFO_GBOX, "Running Step: None" )
local BUILDER_ENABLE = gui.Checkbox( WINDOW, "builder.enable", "Enable", false )
guiModify(BUILDER_ENABLE, 70, 215)

local BUILDER_CONTROLS_GBOX = gui.Groupbox( WINDOW, "Controls", 220, 85, 620, 0 )
local BUILDER_CONTROLS_DURATION_VALUE = gui.Editbox( BUILDER_CONTROLS_GBOX, "builder.controls.duration.value", "Duration" )
guiModify(BUILDER_CONTROLS_DURATION_VALUE, nil, nil, 150)
local BUILDER_CONTROLS_DURATION_TYPE = gui.Combobox( BUILDER_CONTROLS_GBOX, "builder.controls.duration.type", "Duration Type", "Ticks", "Seconds" )
guiModify(BUILDER_CONTROLS_DURATION_TYPE, nil, nil, 150)

local BUILDER_CONTROLS_COPY_BTN = gui.Button( BUILDER_CONTROLS_GBOX, "Copy Previous", function()
    if BUILDER_ENABLE:GetValue() then return end
    if iSelectedStep - 1 < 1 then return end
    if #tblSteps == 0 then return end
    for i = 1, #builderTable do
        builderTable[i]:SetValue(tblSteps[iSelectedStep - 1].table[i])
    end
end )
guiModify(BUILDER_CONTROLS_COPY_BTN, 200, 10, 110)

local BUILDER_CONTROLS_PAGES = gui.Text( BUILDER_CONTROLS_GBOX, "Step 1/1" )
guiModify(BUILDER_CONTROLS_PAGES, 290, 80, nil)

local BUILDER_CONTROLS_SAVE_BTN = gui.Button( BUILDER_CONTROLS_GBOX, "Save Step", function()
    if BUILDER_ENABLE:GetValue() then return end
    if tonumber(BUILDER_CONTROLS_DURATION_VALUE:GetValue()) == nil then return end
    local tmpTable = {}
    for i = 1, #builderTable do
        table.insert(tmpTable, builderTable[i]:GetValue())
    end
    tblSteps[iSelectedStep] = {duration = BUILDER_CONTROLS_DURATION_VALUE:GetValue(), type = BUILDER_CONTROLS_DURATION_TYPE:GetValue(), table = tmpTable}
    BUILDER_CONTROLS_PAGES:SetText("Step " .. tostring(iSelectedStep) .. "/" .. tostring(#tblSteps))
    BUILDER_INFO_TOTAL:SetText("Total Steps: " .. tostring(#tblSteps))
end )
guiModify(BUILDER_CONTROLS_SAVE_BTN, 325, 10, 110)

local BUILDER_CONTROLS_REMOVE_BTN = gui.Button( BUILDER_CONTROLS_GBOX, "Remove Step", function()
    if BUILDER_ENABLE:GetValue() then return end
    if #tblSteps == 1 then return end

    table.remove(tblSteps, iSelectedStep)
    
    if iSelectedStep > 1 then iSelectedStep = iSelectedStep - 1 end

    BUILDER_CONTROLS_PAGES:SetText("Step " .. tostring(iSelectedStep) .. "/" .. tostring(#tblSteps))
    BUILDER_INFO_TOTAL:SetText("Total Steps: " .. tostring(#tblSteps))

    BUILDER_CONTROLS_DURATION_VALUE:SetValue(tblSteps[iSelectedStep].duration)
    BUILDER_CONTROLS_DURATION_TYPE:SetValue(tblSteps[iSelectedStep].type)
end )
guiModify(BUILDER_CONTROLS_REMOVE_BTN, 470, 10, 110)

local BUILDER_CONTROLS_PREV_BTN = gui.Button( BUILDER_CONTROLS_GBOX, "◄", function()
    if BUILDER_ENABLE:GetValue() then return end
    if iSelectedStep > 1 then
        iSelectedStep = iSelectedStep - 1

        BUILDER_CONTROLS_PAGES:SetText("Step " .. tostring(iSelectedStep) .. "/" .. tostring(#tblSteps))

        for i = 1, #builderTable do
            builderTable[i]:SetValue(tblSteps[iSelectedStep].table[i])
        end

        BUILDER_CONTROLS_DURATION_VALUE:SetValue(tblSteps[iSelectedStep].duration)
        BUILDER_CONTROLS_DURATION_TYPE:SetValue(tblSteps[iSelectedStep].type)
    end
end )
guiModify(BUILDER_CONTROLS_PREV_BTN, 470, 65, 50)

local BUILDER_CONTROLS_NEXT_BTN = gui.Button( BUILDER_CONTROLS_GBOX, "►", function()
    if BUILDER_ENABLE:GetValue() then return end
    if iSelectedStep == #tblSteps + 1 then return end
    iSelectedStep = iSelectedStep + 1
    BUILDER_CONTROLS_PAGES:SetText("Step " .. tostring(iSelectedStep) .. "/" .. tostring(#tblSteps))

    if iSelectedStep == #tblSteps + 1 then
        for i = 1, #builderTable do
            builderTable[i]:SetValue(0)
        end
        BUILDER_CONTROLS_DURATION_VALUE:SetValue(0)
        BUILDER_CONTROLS_DURATION_TYPE:SetValue(0)
    else
        for i = 1, #builderTable do
            builderTable[i]:SetValue(tblSteps[iSelectedStep].table[i])
        end
        BUILDER_CONTROLS_DURATION_VALUE:SetValue(tblSteps[iSelectedStep].duration)
        BUILDER_CONTROLS_DURATION_TYPE:SetValue(tblSteps[iSelectedStep].type)
    end
end )
guiModify(BUILDER_CONTROLS_NEXT_BTN, 530, 65, 50)

local function handleBuilder()
    if not BUILDER_ENABLE:GetValue() then
        iRunningStep = 0
        bSetValues = false
        return
    end

    if iRunningStep == 0 then 
        iRunningStep = 1 
        flLastTime = globals.CurTime()
        iLastTick = globals.TickCount()
    end

    if tblSteps[iRunningStep].type == 0 then -- Ticks
        if globals.TickCount() >= iLastTick + tblSteps[iRunningStep].duration then
            iRunningStep = iRunningStep + 1
            if iRunningStep > #tblSteps then iRunningStep = 1 end
            bSetValues = false
            flLastTime = globals.CurTime()
            iLastTick = globals.TickCount()
        end
    else
        if globals.CurTime() >= flLastTime + tblSteps[iRunningStep].duration then
            iRunningStep = iRunningStep + 1
            if iRunningStep > #tblSteps then iRunningStep = 1 end
            bSetValues = false
            flLastTime = globals.CurTime()
            iLastTick = globals.TickCount()
        end
    end

    if not bSetValues then
        bSetValues = true
        for i = 1, #builderTable do
            builderTable[i]:SetValue(tblSteps[iRunningStep].table[i])
        end
    end
end

local function handleBuilderGUI()
    if iRunningStep == 0 then
        BUILDER_INFO_RUNNING:SetText("Running Step: None")
    else
        BUILDER_INFO_RUNNING:SetText("Running Step: " .. tostring(iRunningStep))
    end
end

local tblBUILDER = {
    BUILDER_INFO_GBOX, BUILDER_CONTROLS_GBOX, BUILDER_ENABLE
}

local MISC_SLOWWALK_GBOX = gui.Groupbox( WINDOW, "Slow Walk", 10, 85, 200, 0 )
local MISC_SLOWWALK_TYPE = gui.Combobox( MISC_SLOWWALK_GBOX, "misc.slowwalk.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
local MISC_SLOWWALK_MINVALUE = gui.Slider( MISC_SLOWWALK_GBOX, "misc.slowwalk.minvalue", "Minimal Value", 1, 1, 100 )
local MISC_SLOWWALK_MAXVALUE = gui.Slider( MISC_SLOWWALK_GBOX, "misc.slowwalk.maxvalue", "Maximal Value", 1, 1, 100 )
local MISC_SLOWWALK_SPEED = gui.Slider( MISC_SLOWWALK_GBOX, "misc.slowwalk.speed", "Speed", 0, 0, 100 )
local MISC_FAKEWALK_ENABLE = gui.Checkbox( MISC_SLOWWALK_GBOX, "misc.slowwalk.fakewalk.enable", "Fake Walk", false )
local MISC_FAKEWALK_ANGLE = gui.Slider( MISC_SLOWWALK_GBOX, "misc.slowwalk.fakewalk.angle", "Fake Walk Angle", 0, -180, 180 )

local MISC_FAKELAG_GBOX = gui.Groupbox( WINDOW, "Fakelag", 220, 85, 200, 0 )
local MISC_FAKELAG_TYPE = gui.Combobox( MISC_FAKELAG_GBOX, "misc.fakelag.type", "Type", "Off", "Static", "Switch", "Cycle", "Jitter" )
local MISC_FAKELAG_MINVALUE = gui.Slider( MISC_FAKELAG_GBOX, "misc.fakelag.minvalue", "Minimal Value", 3, 3, 17 )
local MISC_FAKELAG_MAXVALUE = gui.Slider( MISC_FAKELAG_GBOX, "misc.fakelag.maxvalue", "Maximal Value", 3, 3, 17 )
local MISC_FAKELAG_SPEED = gui.Slider( MISC_FAKELAG_GBOX, "misc.fakelag.speed", "Speed", 0, 0, 100 )
local MISC_FAKELAG_DISABLEDONREV = gui.Checkbox( MISC_FAKELAG_GBOX, "misc.fakelag.disableonrev", "Disable on Revolver", false )

local MISC_INVERTER_GBOX = gui.Groupbox( WINDOW, "Inverter", 430, 85, 200, 0 )
local MISC_INVERTER_KEY = gui.Keybox( MISC_INVERTER_GBOX, "misc.inverter.key", "Invert Key", 0 )
local MISC_INVERTER_INDICATOR = gui.Checkbox( MISC_INVERTER_GBOX, "misc.inverter.indicator", "Indicator", false )
local MISC_INVERTER_ARROWSCOLOR = gui.ColorPicker(MISC_INVERTER_GBOX, "misc.inverter.arrowscolor", "Arrows Color", 255, 0, 0, 255);
local MISC_INVERTER_SETTINGS = gui.Multibox( MISC_INVERTER_GBOX, "Inverter Settings" )
local MISC_INVERTER_SETTINGS_BASEDIR = gui.Checkbox(MISC_INVERTER_SETTINGS, "misc.inverter.settings.basedir", "Invert Base Direction", false)
local MISC_INVERTER_SETTINGS_ROTATION = gui.Checkbox(MISC_INVERTER_SETTINGS, "misc.inverter.settings.rotation", "Invert Rotation", false)
local MISC_INVERTER_SETTINGS_LBY = gui.Checkbox(MISC_INVERTER_SETTINGS, "misc.inverter.settings.lby", "Invert LBY", false)
local MISC_INVERTER_SETTINGS_INVERTONENEMYSHOT = gui.Checkbox(MISC_INVERTER_SETTINGS, "misc.inverter.settings.onenemyshot", "Invert on Enemy Shot", false)
local MISC_OVERRIDE_GBOX = gui.Groupbox( MISC_INVERTER_GBOX, "Override Anti-Resolver") --, 430, 305, 200, 0 )
local MISC_OVERRIDE_VALUE = gui.Slider( MISC_OVERRIDE_GBOX, "misc.override.value", "Override Value", 58, 0, 58 )
local MISC_MANUAL_GBOX = gui.Groupbox( WINDOW, "Manual Anti-Aim", 640, 85, 200, 0 )
local MISC_MANUAL_LEFT_KEY = gui.Keybox( MISC_MANUAL_GBOX, "misc.manual.left.key", "Left Key", 0 )
local MISC_MANUAL_BACK_KEY = gui.Keybox( MISC_MANUAL_GBOX, "misc.manual.back.key", "Back Key", 0 )
local MISC_MANUAL_RIGHT_KEY = gui.Keybox( MISC_MANUAL_GBOX, "misc.manual.right.key", "Right Key", 0 )
local MISC_MANUAL_LEFT_OFFSET = gui.Slider( MISC_MANUAL_GBOX, "misc.manual.left.offset", "Left Offset", 0, 0, 180 )


local MISC_MANUAL_RIGHT_OFFSET = gui.Slider( MISC_MANUAL_GBOX, "misc.manual.right.offset", "Right Offset", 0, 0, 180 )

local tblMISC = {
    MISC_SLOWWALK_GBOX, MISC_FAKELAG_GBOX, MISC_INVERTER_GBOX, MISC_OVERRIDE_GBOX, MISC_MANUAL_GBOX
}

local tblSLOWWALK = {
    MISC_SLOWWALK_MINVALUE, MISC_SLOWWALK_MAXVALUE, MISC_SLOWWALK_SPEED
}

local tblFAKELAG = {
    MISC_FAKELAG_MINVALUE, MISC_FAKELAG_MAXVALUE, MISC_FAKELAG_SPEED
}

local function handleMiscGUI()
    local tblDisable = {false, false, false}
    if MISC_SLOWWALK_TYPE:GetValue() == 0 then
        tblDisable = {true, true, true}
    elseif MISC_SLOWWALK_TYPE:GetValue() == 1 then
        tblDisable = {false, true, true}
    else
        tblDisable = {false, false, false}
    end

    if MISC_FAKEWALK_ENABLE:GetValue() then
        tblDisable = {true, true, true}
        MISC_FAKEWALK_ANGLE:SetDisabled(false)
    else
        MISC_FAKEWALK_ANGLE:SetDisabled(true)
    end

    for i = 1, #tblSLOWWALK do
        tblSLOWWALK[i]:SetDisabled(tblDisable[i])
    end

    if MISC_FAKELAG_TYPE:GetValue() == 0 then
        tblDisable = {true, true, true}
    elseif MISC_FAKELAG_TYPE:GetValue() == 1 then
        tblDisable = {false, true, true}
    else
        tblDisable = {false, false, false}
    end

    for i = 1, #tblFAKELAG do
        tblFAKELAG[i]:SetDisabled(tblDisable[i])
    end

    if MISC_MANUAL_LEFT_KEY:GetValue() == 0 then
        MISC_MANUAL_LEFT_OFFSET:SetDisabled(true)
    else
        MISC_MANUAL_LEFT_OFFSET:SetDisabled(false)
    end

    if MISC_MANUAL_RIGHT_KEY:GetValue() == 0 then
        MISC_MANUAL_RIGHT_OFFSET:SetDisabled(true)
    else
        MISC_MANUAL_RIGHT_OFFSET:SetDisabled(false)
    end

    if MISC_INVERTER_KEY:GetValue() == 0 then
        MISC_INVERTER_INDICATOR:SetDisabled(true)
        MISC_INVERTER_SETTINGS:SetDisabled(true)
    else
        MISC_INVERTER_INDICATOR:SetDisabled(false)
        MISC_INVERTER_SETTINGS:SetDisabled(false)
    end
end

local iFakeWalkTick = 0

local function handleFakeWalk(cmd)
    local iSlowWalkBtn = gui.GetValue( "rbot.accuracy.movement.slowkey" )
    if iSlowWalkBtn == 0 then return end
    if not input.IsButtonDown( iSlowWalkBtn ) then 
        iFakeWalkTick = 0
        return 
    end

    local flSideSpeed = 0
    local flForwardSpeed = 0

    local bW = input.IsButtonDown( 87 )
    local bA = input.IsButtonDown( 65 )
    local bS = input.IsButtonDown( 83 )
    local bD = input.IsButtonDown( 68 )

    local bForward = bW or bS
    local bSideways = bA or bD

    if bA then
        if not bForward then
            flSideSpeed = flSideSpeed + -27.58
        else
            flSideSpeed = flSideSpeed + -19.5
        end
    end

    if bD then
        if not bForward then
            flSideSpeed = flSideSpeed + 27.58
        else
            flSideSpeed = flSideSpeed + 19.5
        end
    end

    if bW then
        if not bSideways then
            flForwardSpeed = flForwardSpeed + 27.58
        else
            flForwardSpeed = flForwardSpeed + 19.5
        end
    end

    if bS then
        if not bSideways then
            flForwardSpeed = flForwardSpeed + -27.58
        else
            flForwardSpeed = flForwardSpeed + -19.5
        end
    end

    local iLbyYaw = cmd.viewangles["yaw"] + MISC_FAKEWALK_ANGLE:GetValue()
    if iLbyYaw < - 180 then iLbyYaw = 360 + iLbyYaw end
    if iLbyYaw > 180 then iLbyYaw = -360 + iLbyYaw end

    if iFakeWalkTick <= 3 then
        cmd.sidemove = flSideSpeed / 2
        cmd.forwardmove = flForwardSpeed / 2
        cmd.sendpacket = false
    elseif iFakeWalkTick == 4 then
        cmd.sidemove = flSideSpeed / 4
        cmd.forwardmove = flForwardSpeed / 4
        cmd.sendpacket = false
        if bit.band(cmd.buttons, 1) == 0 then cmd.viewangles = EulerAngles(89, iLbyYaw, 0) end
    elseif iFakeWalkTick == 5 then
        cmd.sidemove = 0
        cmd.forwardmove = 0
        cmd.sendpacket = false
    elseif iFakeWalkTick == 6 then
        cmd.sidemove = 0
        cmd.forwardmove = 0
        cmd.sendpacket = true
    elseif iFakeWalkTick > 6 then
        cmd.sidemove = flSideSpeed
        cmd.forwardmove = flForwardSpeed
        cmd.sendpacket = false
        if iFakeWalkTick == 15 then iFakeWalkTick = -1 end
    end

    iFakeWalkTick = iFakeWalkTick + 1
end

local iSlowWalkTick = 0
local iSlowWalkSwitch = 0
local iSlowWalkDirection = 0
local iSlowWalkAngle = 0

local iFakeLagTick = 0
local iFakeLagSwitch = 0
local iFakeLagDirection = 0
local iFakeLagAngle = 0

local function handleMisc()
    if MISC_INVERTER_SETTINGS_BASEDIR:GetValue() then bInvertBaseDir = true else bInvertBaseDir = false end
    if MISC_INVERTER_SETTINGS_ROTATION:GetValue() then bInvertRotation = true else bInvertRotation = false end
    if MISC_INVERTER_SETTINGS_LBY:GetValue() then bInvertLBY = true else bInvertLBY = false end

    -- Slow Walk

    if MISC_SLOWWALK_TYPE:GetValue() == 1 then -- Static
        gui.SetValue("rbot.accuracy.movement.slowspeed", MISC_SLOWWALK_MINVALUE:GetValue())
    elseif MISC_SLOWWALK_TYPE:GetValue() == 3 then -- Cycle
        if iSlowWalkAngle >= MISC_SLOWWALK_MAXVALUE:GetValue() then iSlowWalkDirection = 1 
        elseif iSlowWalkAngle <= MISC_SLOWWALK_MINVALUE:GetValue() + MISC_SLOWWALK_SPEED:GetValue() / 4 then  iSlowWalkDirection = 0 end

        if iSlowWalkDirection == 0 then iSlowWalkAngle = iSlowWalkAngle + MISC_SLOWWALK_SPEED:GetValue() / 4
        elseif iSlowWalkDirection == 1 then iSlowWalkAngle = iSlowWalkAngle - MISC_SLOWWALK_SPEED:GetValue() / 4 end      
        gui.SetValue("rbot.accuracy.movement.slowspeed", iSlowWalkAngle)
    elseif globals.TickCount() >= iSlowWalkTick + (100 - MISC_SLOWWALK_SPEED:GetValue()) * iTickRateMultiplier then 
        if MISC_SLOWWALK_TYPE:GetValue() == 2 then -- Switch
            if iSlowWalkSwitch == MISC_SLOWWALK_MINVALUE:GetValue() then
                gui.SetValue( "rbot.accuracy.movement.slowspeed", MISC_SLOWWALK_MAXVALUE:GetValue() )
                iSlowWalkSwitch = MISC_SLOWWALK_MAXVALUE:GetValue()
            else
                gui.SetValue( "rbot.accuracy.movement.slowspeed", MISC_SLOWWALK_MINVALUE:GetValue() )
                iSlowWalkSwitch = MISC_SLOWWALK_MINVALUE:GetValue()
            end
        elseif MISC_SLOWWALK_TYPE:GetValue() == 4 then -- Jitter
            gui.SetValue("rbot.accuracy.movement.slowspeed", math.random(MISC_SLOWWALK_MINVALUE:GetValue(), MISC_SLOWWALK_MAXVALUE:GetValue()))
        end

        iSlowWalkTick = globals.TickCount()
    end

    -- FakeLag

    if MISC_FAKELAG_TYPE:GetValue() == 1 then -- Static
        gui.SetValue("misc.fakelag.factor", MISC_FAKELAG_MINVALUE:GetValue())
    elseif MISC_FAKELAG_TYPE:GetValue() == 3 then -- Cycle
        if iFakeLagAngle >= MISC_FAKELAG_MAXVALUE:GetValue() then iFakeLagDirection = 1 
        elseif iFakeLagAngle <= MISC_FAKELAG_MINVALUE:GetValue() + MISC_FAKELAG_SPEED:GetValue() / 16 then  iFakeLagDirection = 0 end

        if iFakeLagDirection == 0 then iFakeLagAngle = iFakeLagAngle + MISC_FAKELAG_SPEED:GetValue() / 16
        elseif iFakeLagDirection == 1 then iFakeLagAngle = iFakeLagAngle - MISC_FAKELAG_SPEED:GetValue() / 16 end      
        gui.SetValue("misc.fakelag.factor", iFakeLagAngle)
    elseif globals.TickCount() >= iFakeLagTick + (100 - MISC_FAKELAG_SPEED:GetValue()) * iTickRateMultiplier then 
        if MISC_FAKELAG_TYPE:GetValue() == 2 then -- Switch
            if iFakeLagSwitch == MISC_FAKELAG_MINVALUE:GetValue() then
                gui.SetValue( "misc.fakelag.factor", MISC_FAKELAG_MAXVALUE:GetValue() )
                iFakeLagSwitch = MISC_FAKELAG_MAXVALUE:GetValue()
            else
                gui.SetValue( "misc.fakelag.factor", MISC_FAKELAG_MINVALUE:GetValue() )
                iFakeLagSwitch = MISC_FAKELAG_MINVALUE:GetValue()
            end
        elseif MISC_FAKELAG_TYPE:GetValue() == 4 then -- Jitter
            gui.SetValue("misc.fakelag.factor", math.random(MISC_FAKELAG_MINVALUE:GetValue(), MISC_FAKELAG_MAXVALUE:GetValue()))
        end

        iFakeLagTick = globals.TickCount()
    end

    if MISC_FAKELAG_DISABLEDONREV:GetValue() then
        if entities.GetLocalPlayer():GetWeaponID() == 64 then
            gui.SetValue( "misc.fakelag.enable", false )
        else
            gui.SetValue( "misc.fakelag.enable", true )
        end
    end

    -- Override Anti-Resolver

    if gui.GetValue("rbot.antiaim.advanced.antiresolver") then
        if gui.GetValue("rbot.antiaim.base.rotation") >= 0 then
            gui.SetValue("rbot.antiaim.base.rotation", MISC_OVERRIDE_VALUE:GetValue())
        else
            gui.SetValue("rbot.antiaim.base.rotation", MISC_OVERRIDE_VALUE:GetValue() * -1)
        end
    end

end


local SETTINGS_EXTRA_GBOX = gui.Groupbox( WINDOW, "Extra", 10, 300, 200, 0 )
local SETTINGS_EXTRA_SHARED = gui.Checkbox( SETTINGS_EXTRA_GBOX, "settings.extra.shared", "Shared Anti-Aim State", false )

local SETTINGS_INDICATOR_GBOX = gui.Groupbox( WINDOW, "Inverter Indicator", 220, 85, 200, 0 )
local SETTINGS_INDICATOR_COLOR_ENABLED = gui.ColorPicker( SETTINGS_INDICATOR_GBOX, "settings.indicator.font.color.enabled", "Enabled Color", 124, 176, 34, 255)
local SETTINGS_INDICATOR_COLOR_DISABLED = gui.ColorPicker( SETTINGS_INDICATOR_GBOX, "settings.indicator.font.color.disabled", "Disabled Color", 255, 25, 25, 255)
local SETTINGS_INDICATOR_FONT_NAME = gui.Editbox( SETTINGS_INDICATOR_GBOX, "settings.indicator.font.name", "Font Name" )
SETTINGS_INDICATOR_FONT_NAME:SetValue("Verdana")
local SETTINGS_INDICATOR_FONT_SIZE = gui.Slider( SETTINGS_INDICATOR_GBOX, "settings.indicator.font.size", "Font Size", 30, 1, 50 )
local SETTINGS_INDICATOR_FONT_APPLY = gui.Button( SETTINGS_INDICATOR_GBOX, "Apply Font", function()
    FONT = draw.CreateFont( SETTINGS_INDICATOR_FONT_NAME:GetValue(), SETTINGS_INDICATOR_FONT_SIZE:GetValue(), 2000 )
end )
local SETTINGS_INDICATOR_X = gui.Slider( SETTINGS_INDICATOR_GBOX, "settings.indicator.x", "X Offset", 20, 0, SCREEN_W )
local SETTINGS_INDICATOR_Y = gui.Slider( SETTINGS_INDICATOR_GBOX, "settings.indicator.y", "Y Offset", 950, 0, SCREEN_H )

local SETTINGS_CONFIG_GBOX = gui.Groupbox( WINDOW, "Configurations", 430, 85, 410, 0 )
local SETTINGS_CONFIG_SAVE_NAME = gui.Editbox( SETTINGS_CONFIG_GBOX, "settings.config.save.name", "Name" )
guiModify(SETTINGS_CONFIG_SAVE_NAME, nil, nil, 130)

local saveTable = {
    {
        ["desyncplus.antiaim.basedir.standing.type"] = 0, ["desyncplus.antiaim.basedir.standing.basevalue"] = 0, ["desyncplus.antiaim.basedir.standing.minvalue"] = 0, ["desyncplus.antiaim.basedir.standing.maxvalue"] = 0, ["desyncplus.antiaim.basedir.standing.speed"] = 0,
        ["desyncplus.antiaim.basedir.moving.type"] = 0, ["desyncplus.antiaim.basedir.moving.basevalue"] = 0, ["desyncplus.antiaim.basedir.moving.minvalue"] = 0, ["desyncplus.antiaim.basedir.moving.maxvalue"] = 0, ["desyncplus.antiaim.basedir.moving.speed"] = 0,
        ["desyncplus.antiaim.basedir.air.type"] = 0, ["desyncplus.antiaim.basedir.air.basevalue"] = 0, ["desyncplus.antiaim.basedir.air.minvalue"] = 0, ["desyncplus.antiaim.basedir.air.maxvalue"] = 0, ["desyncplus.antiaim.basedir.air.speed"] = 0,
        ["desyncplus.antiaim.rotation.standing.type"] = 0, ["desyncplus.antiaim.rotation.standing.minvalue"] = 0, ["desyncplus.antiaim.rotation.standing.maxvalue"] = 0, ["desyncplus.antiaim.rotation.standing.speed"] = 0,
        ["desyncplus.antiaim.rotation.moving.type"] = 0, ["desyncplus.antiaim.rotation.moving.minvalue"] = 0, ["desyncplus.antiaim.rotation.moving.maxvalue"] = 0, ["desyncplus.antiaim.rotation.moving.speed"] = 0,
        ["desyncplus.antiaim.rotation.air.type"] = 0, ["desyncplus.antiaim.rotation.air.minvalue"] = 0, ["desyncplus.antiaim.rotation.air.maxvalue"] = 0, ["desyncplus.antiaim.rotation.air.speed"] = 0, 
        ["desyncplus.antiaim.lby.standing.type"] = 0, ["desyncplus.antiaim.lby.standing.minvalue"] = 0, ["desyncplus.antiaim.lby.standing.maxvalue"] = 0, ["desyncplus.antiaim.lby.standing.speed"] = 0, ["desyncplus.antiaim.lby.standing.value"] = 0,
        ["desyncplus.antiaim.lby.moving.type"] = 0, ["desyncplus.antiaim.lby.moving.minvalue"] = 0, ["desyncplus.antiaim.lby.moving.maxvalue"] = 0, ["desyncplus.antiaim.lby.moving.speed"] = 0, ["desyncplus.antiaim.lby.moving.value"] = 0,
        ["desyncplus.antiaim.lby.air.type"] = 0, ["desyncplus.antiaim.lby.air.minvalue"] = 0, ["desyncplus.antiaim.lby.air.maxvalue"] = 0, ["desyncplus.antiaim.lby.air.speed"] = 0, ["desyncplus.antiaim.lby.air.value"] = 0,
        ["desyncplus.antiaim.pitch.standing.type"] = 0, ["desyncplus.antiaim.pitch.standing.minvalue"] = 0, ["desyncplus.antiaim.pitch.standing.maxvalue"] = 0, ["desyncplus.antiaim.pitch.standing.speed"] = 0,
        ["desyncplus.antiaim.pitch.moving.type"] = 0, ["desyncplus.antiaim.pitch.moving.minvalue"] = 0, ["desyncplus.antiaim.pitch.moving.maxvalue"] = 0, ["desyncplus.antiaim.pitch.moving.speed"] = 0,
        ["desyncplus.antiaim.pitch.air.type"] = 0, ["desyncplus.antiaim.pitch.air.minvalue"] = 0, ["desyncplus.antiaim.pitch.air.maxvalue"] = 0, ["desyncplus.antiaim.pitch.air.speed"] = 0, 
        ["desyncplus.misc.slowwalk.type"] = 0, ["desyncplus.misc.slowwalk.minvalue"] = 0, ["desyncplus.misc.slowwalk.maxvalue"] = 0, ["desyncplus.misc.slowwalk.speed"] = 0,
        ["desyncplus.misc.fakelag.type"] = 0, ["desyncplus.misc.fakelag.minvalue"] = 0, ["desyncplus.misc.fakelag.maxvalue"] = 0, ["desyncplus.misc.fakelag.speed"] = 0,
        ["desyncplus.misc.inverter.key"] = 0, ["desyncplus.misc.inverter.indicator"] = false, 
        ["desyncplus.misc.inverter.settings.basedir"] = false, ["desyncplus.misc.inverter.settings.rotation"] = false, ["desyncplus.misc.inverter.settings.lby"] = false, ["desyncplus.misc.inverter.settings.onenemyshot"] = false, 
        ["desyncplus.misc.override.value"] = 0, ["desyncplus.misc.manual.left.key"] = 0, ["desyncplus.misc.manual.back.key"] = 0, ["desyncplus.misc.manual.right.key"] = 0, ["desyncplus.misc.manual.left.offset"] = 0, ["desyncplus.misc.manual.right.offset"] = 0,
        ["desyncplus.settings.indicator.font.name"] = "", ["desyncplus.settings.indicator.font.size"] = 0, ["desyncplus.settings.indicator.x"] = 0, ["desyncplus.settings.indicator.y"] = 0,
        ["desyncplus.misc.fakelag.disableonrev"] = false, ["desyncplus.settings.extra.shared"] = false, ["desyncplus.misc.slowwalk.fakewalk.enable"] = false, ["desyncplus.misc.slowwalk.fakewalk.angle"] = 0,
        ["desyncplus.antiaim.rotation.standing.deadzone.min"] = 0, ["desyncplus.antiaim.rotation.standing.deadzone.max"] = 0,
        ["desyncplus.antiaim.rotation.moving.deadzone.min"] = 0, ["desyncplus.antiaim.rotation.moving.deadzone.max"] = 0,
        ["desyncplus.antiaim.rotation.air.deadzone.min"] = 0, ["desyncplus.antiaim.rotation.air.deadzone.max"] = 0
    },
    {
        ["desyncplus.settings.indicator.font.color.enabled"] = {}, ["desyncplus.settings.indicator.font.color.disabled"] = {}
    },
    {

    }
}

local savedConfigs = {}

local SETTINGS_CONFIG_LIST = gui.Listbox( SETTINGS_CONFIG_GBOX, "settings.config.list", 300, "cock", "and", "ball" )
guiModify(SETTINGS_CONFIG_LIST, 160, 0, 220)

local function fetchConfigs(filename)
    if string.match(filename, "%.dat") then
        local line = split(file.Read(filename), string.char(10))[1]
        if not line:match("Desync Plus") then return end
        table.insert(savedConfigs, filename:sub(1, -5))
    end
end

local function refreshConfigs()
    savedConfigs = {}
    file.Enumerate(fetchConfigs)
    SETTINGS_CONFIG_LIST:SetOptions(unpack(savedConfigs))
end

refreshConfigs()

local function createConfigString()
    local tmpTable = saveTable

    for k, v in pairs(tmpTable[1]) do
        tmpTable[1][k] = gui.GetValue( k )
    end

    for k, v in pairs(tmpTable[2]) do
        local r, g, b, a = gui.GetValue( k )
        tmpTable[2][k] = {r, g, b, a}
    end

    tmpTable[3] = tblSteps

    return "Desync Plus" .. string.char(10) .. base64.encode(pickle(tmpTable))
end

local function normalizeFileName(filename)
    local chars = {"\\", "/", ":", "*", "?", "<", ">", "|"}
    local name = filename
    for i = 1, #chars do
        name = string.gsub(name, chars[i], "")
    end
    return name
end

local function guiExists(var)
    if pcall(function() gui.GetValue(var) end ) then return true else return false end
end

local SETTINGS_CONFIG_CREATE_BTN = gui.Button( SETTINGS_CONFIG_GBOX, "Create", function()
    if SETTINGS_CONFIG_SAVE_NAME:GetValue() == "" then return end
    file.Write(normalizeFileName(SETTINGS_CONFIG_SAVE_NAME:GetValue()) .. ".dat", createConfigString())
    refreshConfigs()
    SETTINGS_CONFIG_SAVE_NAME:SetValue("")
end )
guiModify(SETTINGS_CONFIG_CREATE_BTN, 0, 55, nil)

local SETTINGS_CONFIG_SAVE_BTN = gui.Button( SETTINGS_CONFIG_GBOX, "Save", function()
    file.Write(savedConfigs[SETTINGS_CONFIG_LIST:GetValue() + 1] .. ".dat", createConfigString())
end )
guiModify(SETTINGS_CONFIG_SAVE_BTN, nil, 110, nil)

local SETTINGS_CONFIG_LOAD_BTN = gui.Button( SETTINGS_CONFIG_GBOX, "Load", function()
    local settings = base64.decode(split(file.Read(savedConfigs[SETTINGS_CONFIG_LIST:GetValue() + 1] .. ".dat"), string.char(10))[2])
    local settingsTable = unpickle(settings)

    for k, v in pairs(settingsTable[1]) do
        if guiExists(k) then
            gui.SetValue( k, v )
        end
    end

    for k, v in pairs(settingsTable[2]) do
        if guiExists(k) then
            gui.SetValue( k, v[1], v[2], v[3], v[4] )
        end
    end

    tblSteps = settingsTable[3]

    BUILDER_ENABLE:SetValue(false)
    iSelectedStep = 1
    iRunningStep = 0
    iLastTick = 0
    flLastTime = 0
    bSetValues = false
    
    BUILDER_CONTROLS_PAGES:SetText("Step " .. tostring(iSelectedStep) .. "/" .. tostring(#tblSteps))
    BUILDER_INFO_TOTAL:SetText("Total Steps: " .. tostring(#tblSteps))
    if #tblSteps > 0 then
        BUILDER_CONTROLS_DURATION_VALUE:SetValue(tblSteps[iSelectedStep].duration)
        BUILDER_CONTROLS_DURATION_TYPE:SetValue(tblSteps[iSelectedStep].type)
    end
end )
guiModify(SETTINGS_CONFIG_LOAD_BTN, nil, 150, nil)

local deleteTime = 0

local SETTINGS_CONFIG_DELETE_BTN = gui.Button( SETTINGS_CONFIG_GBOX, "Delete", function()
    if deleteTime == 0 then
        deleteTime = globals.CurTime()
        return
    else
        file.Delete( savedConfigs[SETTINGS_CONFIG_LIST:GetValue() + 1] .. ".dat" )
        refreshConfigs()
        deleteTime = 0
    end
end )

local function handleDelete()
    if deleteTime == 0 then return end
    if globals.CurTime() >= deleteTime + 1 then
        deleteTime = 0
    end
end

guiModify(SETTINGS_CONFIG_DELETE_BTN, nil, 220, nil)
local SETTINGS_CONFIG_REFRESH_BTN = gui.Button( SETTINGS_CONFIG_GBOX, "Refresh", refreshConfigs)
guiModify(SETTINGS_CONFIG_REFRESH_BTN, nil, 265, nil)

local tblSETTINGS = {
    SETTINGS_INDICATOR_GBOX, SETTINGS_CONFIG_GBOX, SETTINGS_EXTRA_GBOX
}

local tblEVERYTHING = {
    tblANTIAIM, tblBUILDER, tblMISC, tblSETTINGS
}

local function handleIndicator()
local hLocalPlayer = entities.GetLocalPlayer()
	if not hLocalPlayer then return end
	
	
	draw.SetFont( FONT )

	local YAdd = 50;
	
	----Draw AA Arows
	draw.Color(46, 46, 46, 200);
	draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
	draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);

    if iInvert ~= 1 then 
	draw.Color(MISC_INVERTER_ARROWSCOLOR:GetValue()) --(r, g, b, a);
	draw.Line(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8);
	draw.Line(screenCenterX - 50, screenCenterY - 7 + 15, screenCenterX - 65, screenCenterY - 7 + 8);
	draw.Color( SETTINGS_INDICATOR_COLOR_DISABLED:GetValue() ) 
	draw.TextShadow( SETTINGS_INDICATOR_X:GetValue(), SETTINGS_INDICATOR_Y:GetValue(), "INVERT" )
	else 
	draw.Color(MISC_INVERTER_ARROWSCOLOR:GetValue()) --(r, g, b, a);
	draw.Line(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8);
	draw.Line(screenCenterX + 50, screenCenterY - 7 + 15, screenCenterX + 65, screenCenterY - 7 + 8);
	draw.Color( SETTINGS_INDICATOR_COLOR_ENABLED:GetValue() )
    draw.TextShadow( SETTINGS_INDICATOR_X:GetValue(), SETTINGS_INDICATOR_Y:GetValue(), "INVERT" )

	end
end

local function handleTabBtn()
    ANTIAIM_BTN:SetDisabled(false)
    BUILDER_BTN:SetDisabled(false)
    MISC_BTN:SetDisabled(false)
    SETTINGS_BTN:SetDisabled(false)
    if activeMenu == menus.antiaim then
        ANTIAIM_BTN:SetDisabled(true)
    elseif activeMenu == menus.builder then
        BUILDER_BTN:SetDisabled(true)
    elseif activeMenu == menus.misc then
        MISC_BTN:SetDisabled(true)
    else 
        SETTINGS_BTN:SetDisabled(true)
    end
end

local function handleStateBtn()
    if SETTINGS_EXTRA_SHARED:GetValue() then
        ANTIAIM_STATE_STANDING_BTN:SetDisabled(true)
        ANTIAIM_STATE_MOVING_BTN:SetDisabled(true)
        ANTIAIM_STATE_AIR_BTN:SetDisabled(true)
        activeState = 0
        return
    end

    ANTIAIM_STATE_STANDING_BTN:SetDisabled(false)
    ANTIAIM_STATE_MOVING_BTN:SetDisabled(false)
    ANTIAIM_STATE_AIR_BTN:SetDisabled(false)
    if activeState == states.standing then
        ANTIAIM_STATE_STANDING_BTN:SetDisabled(true)
    elseif activeState == states.moving then
        ANTIAIM_STATE_MOVING_BTN:SetDisabled(true)
    else 
        ANTIAIM_STATE_AIR_BTN:SetDisabled(true)
    end
end

local function handleMenu()
    for i = 1, #tblEVERYTHING do
        for j = 1, #tblEVERYTHING[i] do
            if i - 1 == activeMenu and i ~= 1 then 
                tblEVERYTHING[i][j]:SetInvisible(false) 
            else
                tblEVERYTHING[i][j]:SetInvisible(true)
            end
        end
    end
end

local iLastTick = 0
callbacks.Register( "Draw", function()
    if AW_WINDOW:IsActive() then
        WINDOW:SetActive(true)
        handleMenu()
        handleDelete()

        if SETTINGS_EXTRA_SHARED:GetValue() then 
            bShared = true 
        else 
            bShared = false 
        end

        if bTabClicked then
            handleTabBtn()
            bTabClicked = false
        end
     
        if activeMenu == menus.antiaim then
            handleStateBtn()
            handleAntiaimGUI()
        elseif activeMenu == menus.builder then
            handleBuilderGUI()
        elseif activeMenu == menus.misc then
            handleMiscGUI()
        end
    else
        WINDOW:SetActive(false)
    end

    -- Inverter
    if MISC_INVERTER_KEY:GetValue() ~= 0 then
        if input.IsButtonPressed( MISC_INVERTER_KEY:GetValue() ) then iInvert = iInvert * -1 end
    end

    if MISC_INVERTER_INDICATOR:GetValue() then
        handleIndicator()
    end

    -- Manual AA
    local iManualValue = nil
    if MISC_MANUAL_LEFT_KEY:GetValue() ~= 0 then
        if input.IsButtonPressed( MISC_MANUAL_LEFT_KEY:GetValue() ) then 
            iManualValue = MISC_MANUAL_LEFT_OFFSET:GetValue()
        end
    end

    if MISC_MANUAL_BACK_KEY:GetValue() ~= 0 then
        if input.IsButtonPressed( MISC_MANUAL_BACK_KEY:GetValue() ) then
            iManualValue = 180
        end
    end

    if MISC_MANUAL_RIGHT_KEY:GetValue() ~= 0 then
        if input.IsButtonPressed( MISC_MANUAL_RIGHT_KEY:GetValue() ) then
            iManualValue = MISC_MANUAL_RIGHT_OFFSET:GetValue() * -1
        end
    end

    if iManualValue then
        DESYNCPLUS_ANTIAIM_BASEDIR_STANDING_BASEVALUE:SetValue( iManualValue )
        DESYNCPLUS_ANTIAIM_BASEDIR_MOVING_BASEVALUE:SetValue( iManualValue )
        DESYNCPLUS_ANTIAIM_BASEDIR_AIR_BASEVALUE:SetValue( iManualValue )
    end

    if not entities.GetLocalPlayer() or not entities.GetLocalPlayer():IsAlive() then
        iBaseDirTick = 0
        iRotationTick = 0
        iLBYTick = 0
        iPitchTick = 0
        iSlowWalkTick = 0
        iFakeLagTick = 0
    end
end )

callbacks.Register( "CreateMove", function(cmd)
    if 1 / globals.TickInterval() == 128 then iTickRateMultiplier = 2 else iTickRateMultiplier = 1 end
    handleAntiaim(cmd)
    handleMisc()
    handleBuilder()

    if MISC_FAKEWALK_ENABLE:GetValue() then
        handleFakeWalk(cmd)
    end
end )

callbacks.Register( "FireGameEvent", function(event)
    if not MISC_INVERTER_SETTINGS_INVERTONENEMYSHOT:GetValue() then return end
    if event:GetName() ~= "weapon_fire" then return end

    local hLocalPlayer = entities.GetLocalPlayer()
    local tblPlayers = entities.FindByClass("CCSPlayer")

    local flClosestDist = math.huge
    local hClosestEntity = nil

    for i = 1, #tblPlayers do
        if tblPlayers[i]:GetTeamNumber() ~= hLocalPlayer:GetTeamNumber() and tblPlayers[i]:IsAlive() then
            local vecLocalPlayer = {hLocalPlayer:GetAbsOrigin()["x"], hLocalPlayer:GetAbsOrigin()["y"], hLocalPlayer:GetAbsOrigin()["z"]}
            local vecEnemy = {tblPlayers[i]:GetAbsOrigin()["x"], tblPlayers[i]:GetAbsOrigin()["y"], tblPlayers[i]:GetAbsOrigin()["z"]}
            local flDistance = vector.Distance( {vecLocalPlayer[1], vecLocalPlayer[2], vecLocalPlayer[3]}, {vecEnemy[1], vecEnemy[2], vecEnemy[3]}) 
            if flDistance < flClosestDist then
                flClosestDist = flDistance
                hClosestEntity = tblPlayers[i]
            end
        end
    end

    if not hClosestEntity then return end

    if entities.GetByUserID(event:GetInt("userid")):GetIndex() == hClosestEntity:GetIndex() then
        iInvert = iInvert * -1
    end
end )

client.AllowListener( "weapon_fire")







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
