-- json https://raw.githubusercontent.com/rxi/json.lua/master/json.lua
--
-- json.lua
--
-- Copyright (c) 2020 rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local json = { _version = "0.1.2" }

-------------------------------------------------------------------------------
-- Encode
-------------------------------------------------------------------------------

local encode

local escape_char_map = {
  [ "\\" ] = "\\",
  [ "\"" ] = "\"",
  [ "\b" ] = "b",
  [ "\f" ] = "f",
  [ "\n" ] = "n",
  [ "\r" ] = "r",
  [ "\t" ] = "t",
}

local escape_char_map_inv = { [ "/" ] = "/" }
for k, v in pairs(escape_char_map) do
  escape_char_map_inv[v] = k
end


local function escape_char(c)
  return "\\" .. (escape_char_map[c] or string.format("u%04x", c:byte()))
end


local function encode_nil(val)
  return "null"
end


local function encode_table(val, stack)
  local res = {}
  stack = stack or {}

  -- Circular reference?
  if stack[val] then error("circular reference") end

  stack[val] = true

  if rawget(val, 1) ~= nil or next(val) == nil then
    -- Treat as array -- check keys are valid and it is not sparse
    local n = 0
    for k in pairs(val) do
      if type(k) ~= "number" then
        error("invalid table: mixed or invalid key types")
      end
      n = n + 1
    end
    if n ~= #val then
      error("invalid table: sparse array")
    end
    -- Encode
    for i, v in ipairs(val) do
      table.insert(res, encode(v, stack))
    end
    stack[val] = nil
    return "[" .. table.concat(res, ",") .. "]"

  else
    -- Treat as an object
    for k, v in pairs(val) do
      if type(k) ~= "string" then
        error("invalid table: mixed or invalid key types")
      end
      table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
    end
    stack[val] = nil
    return "{" .. table.concat(res, ",") .. "}"
  end
end


local function encode_string(val)
  return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
end


local function encode_number(val)
  -- Check for NaN, -inf and inf
  if val ~= val or val <= -math.huge or val >= math.huge then
    error("unexpected number value '" .. tostring(val) .. "'")
  end
  return string.format("%.14g", val)
end


local type_func_map = {
  [ "nil"     ] = encode_nil,
  [ "table"   ] = encode_table,
  [ "string"  ] = encode_string,
  [ "number"  ] = encode_number,
  [ "boolean" ] = tostring,
}


encode = function(val, stack)
  local t = type(val)
  local f = type_func_map[t]
  if f then
    return f(val, stack)
  end
  error("unexpected type '" .. t .. "'")
end


function json.encode(val)
  return ( encode(val) )
end


-------------------------------------------------------------------------------
-- Decode
-------------------------------------------------------------------------------

local parse

local function create_set(...)
  local res = {}
  for i = 1, select("#", ...) do
    res[ select(i, ...) ] = true
  end
  return res
end

local space_chars   = create_set(" ", "\t", "\r", "\n")
local delim_chars   = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars  = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
local literals      = create_set("true", "false", "null")

local literal_map = {
  [ "true"  ] = true,
  [ "false" ] = false,
  [ "null"  ] = nil,
}


local function next_char(str, idx, set, negate)
  for i = idx, #str do
    if set[str:sub(i, i)] ~= negate then
      return i
    end
  end
  return #str + 1
end


local function decode_error(str, idx, msg)
  local line_count = 1
  local col_count = 1
  for i = 1, idx - 1 do
    col_count = col_count + 1
    if str:sub(i, i) == "\n" then
      line_count = line_count + 1
      col_count = 1
    end
  end
  error( string.format("%s at line %d col %d", msg, line_count, col_count) )
end


local function codepoint_to_utf8(n)
  -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
  local f = math.floor
  if n <= 0x7f then
    return string.char(n)
  elseif n <= 0x7ff then
    return string.char(f(n / 64) + 192, n % 64 + 128)
  elseif n <= 0xffff then
    return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
  elseif n <= 0x10ffff then
    return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
                       f(n % 4096 / 64) + 128, n % 64 + 128)
  end
  error( string.format("invalid unicode codepoint '%x'", n) )
end


local function parse_unicode_escape(s)
  local n1 = tonumber( s:sub(1, 4),  16 )
  local n2 = tonumber( s:sub(7, 10), 16 )
   -- Surrogate pair?
  if n2 then
    return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
  else
    return codepoint_to_utf8(n1)
  end
end


local function parse_string(str, i)
  local res = ""
  local j = i + 1
  local k = j

  while j <= #str do
    local x = str:byte(j)

    if x < 32 then
      decode_error(str, j, "control character in string")

    elseif x == 92 then -- `\`: Escape
      res = res .. str:sub(k, j - 1)
      j = j + 1
      local c = str:sub(j, j)
      if c == "u" then
        local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
                 or str:match("^%x%x%x%x", j + 1)
                 or decode_error(str, j - 1, "invalid unicode escape in string")
        res = res .. parse_unicode_escape(hex)
        j = j + #hex
      else
        if not escape_chars[c] then
          decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
        end
        res = res .. escape_char_map_inv[c]
      end
      k = j + 1

    elseif x == 34 then -- `"`: End of string
      res = res .. str:sub(k, j - 1)
      return res, j + 1
    end

    j = j + 1
  end

  decode_error(str, i, "expected closing quote for string")
end


local function parse_number(str, i)
  local x = next_char(str, i, delim_chars)
  local s = str:sub(i, x - 1)
  local n = tonumber(s)
  if not n then
    decode_error(str, i, "invalid number '" .. s .. "'")
  end
  return n, x
end


local function parse_literal(str, i)
  local x = next_char(str, i, delim_chars)
  local word = str:sub(i, x - 1)
  if not literals[word] then
    decode_error(str, i, "invalid literal '" .. word .. "'")
  end
  return literal_map[word], x
end


local function parse_array(str, i)
  local res = {}
  local n = 1
  i = i + 1
  while 1 do
    local x
    i = next_char(str, i, space_chars, true)
    -- Empty / end of array?
    if str:sub(i, i) == "]" then
      i = i + 1
      break
    end
    -- Read token
    x, i = parse(str, i)
    res[n] = x
    n = n + 1
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "]" then break end
    if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
  end
  return res, i
end


local function parse_object(str, i)
  local res = {}
  i = i + 1
  while 1 do
    local key, val
    i = next_char(str, i, space_chars, true)
    -- Empty / end of object?
    if str:sub(i, i) == "}" then
      i = i + 1
      break
    end
    -- Read key
    if str:sub(i, i) ~= '"' then
      decode_error(str, i, "expected string for key")
    end
    key, i = parse(str, i)
    -- Read ':' delimiter
    i = next_char(str, i, space_chars, true)
    if str:sub(i, i) ~= ":" then
      decode_error(str, i, "expected ':' after key")
    end
    i = next_char(str, i + 1, space_chars, true)
    -- Read value
    val, i = parse(str, i)
    -- Set
    res[key] = val
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "}" then break end
    if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
  end
  return res, i
end


local char_func_map = {
  [ '"' ] = parse_string,
  [ "0" ] = parse_number,
  [ "1" ] = parse_number,
  [ "2" ] = parse_number,
  [ "3" ] = parse_number,
  [ "4" ] = parse_number,
  [ "5" ] = parse_number,
  [ "6" ] = parse_number,
  [ "7" ] = parse_number,
  [ "8" ] = parse_number,
  [ "9" ] = parse_number,
  [ "-" ] = parse_number,
  [ "t" ] = parse_literal,
  [ "f" ] = parse_literal,
  [ "n" ] = parse_literal,
  [ "[" ] = parse_array,
  [ "{" ] = parse_object,
}


parse = function(str, idx)
  local chr = str:sub(idx, idx)
  local f = char_func_map[chr]
  if f then
    return f(str, idx)
  end
  decode_error(str, idx, "unexpected character '" .. chr .. "'")
end


function json.decode(str)
  if type(str) ~= "string" then
    error("expected argument of type string, got " .. type(str))
  end
  local res, idx = parse(str, next_char(str, 1, space_chars, true))
  idx = next_char(str, idx, space_chars, true)
  if idx <= #str then
    decode_error(str, idx, "trailing garbage")
  end
  return res
end

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


-- gui
local oneway_indicator_tab = gui.Tab(gui.Reference("Ragebot"), "Chicken.oneway_indicator", "Oneway indicator")
local oneway_indicator_group = gui.Groupbox(oneway_indicator_tab, "Keybinds", 15, 15, 605, 0 )
local oneway_indicator_enabled = gui.Checkbox(oneway_indicator_group, "oneway_enable", "Enable oneway indicator", false)


local oneway_indicator_add_oneway_key = gui.Keybox(oneway_indicator_group, "add_oneway", "Add oneway", 6)
local oneway_indicator_remove_oneway_key = gui.Keybox(oneway_indicator_group, "remove_oneway", "Remove closest oneway", 5)
local oneway_indicator_autowalk_key = gui.Keybox(oneway_indicator_group, "autowalk_oneway", "Autowalk to closest oneway", 81)

local oneway_indicator_circle_size = gui.Slider( oneway_indicator_group, "circle_size", "Circle size", 3, 1, 500)


function move_to_pos(pos, cmd)
  local LocalPlayer = entities.GetLocalPlayer()
  local angle_to_target = (pos - entities.GetLocalPlayer():GetAbsOrigin()):Angles()
  cmd.forwardmove = math.cos(math.rad((engine:GetViewAngles() - angle_to_target).y)) * 255
  cmd.sidemove = math.sin(math.rad((engine:GetViewAngles() - angle_to_target).y)) * 255
end

function get_enemies()
    local players = entities.FindByClass("CCSPlayer")
    local enemies = {}
    local lp = entities.GetLocalPlayer()
    for k,v in pairs(players) do
        if v ~= lp and v:GetTeamNumber() ~= lp:GetTeamNumber() then
            table.insert(enemies, v)
        end
    end
    return enemies
end


function IsValid(entity)
  return pcall(function() tostring(entity:GetAbsOrigin()) end)
end



function update_file(content)
  local oneway_file = file.Open("oneway_coords.txt", "w")
  oneway_file:Write(json.encode(content))
  oneway_file:Close()

  oneways = json.decode(file.Contents("oneway_coords.txt"))
end



if not file.Exists("oneway_coords.txt") then
  local f = file.Open("oneway_coords.txt", "a")
  f:Write([[{
    "de_me": []
}]])
  f:Close()
end

local oneways = json.decode(file.Contents("oneway_coords.txt"))



function get_nearest_oneway()
  local localplayer = entities.GetLocalPlayer()
  if not IsValid(localplayer) then return end

  local lowest_dist = 9999999
  local closest_oneway = nil
  local index = 0

  for i, oneway in ipairs(oneways[engine.GetMapName()]) do
    local dist = vector.Distance({localplayer:GetAbsOrigin().x,localplayer:GetAbsOrigin().y,localplayer:GetAbsOrigin().z}, {oneway[1],oneway[2],oneway[3]})
    if dist < lowest_dist then
      lowest_dist = dist
      closest_oneway = oneway
      index = i
    end
  end
  return closest_oneway, index, lowest_dist
end

function add_oneway()
  local new_oneway = {entities.GetLocalPlayer():GetAbsOrigin().x, entities.GetLocalPlayer():GetAbsOrigin().y, entities.GetLocalPlayer():GetAbsOrigin().z}
  oneways = json.decode(file.Contents("oneway_coords.txt"))
  table.insert(oneways[engine.GetMapName()], new_oneway)
  update_file(oneways)
end


function remove_oneway()
  oneways = json.decode(file.Contents("oneway_coords.txt"))
  local _, index, dist = get_nearest_oneway()
  if dist < 100 then
    table.remove(oneways[engine.GetMapName()], index)
    update_file(oneways)
  end
end


function draw_oneways()
  if not oneway_indicator_enabled:GetValue() then return end
  local localplayer = entities.GetLocalPlayer()
  if oneways[engine.GetMapName()] == nil then return end
  for k, oneway in pairs(oneways[engine.GetMapName()]) do
      local players = entities.FindByClass("CCSPlayer")
      for i, player in ipairs(players) do
        local isEnemy = entities.GetLocalPlayer():GetTeamNumber() ~= player:GetTeamNumber()
        local dist = vector.Distance({player:GetAbsOrigin().x,player:GetAbsOrigin().y,player:GetAbsOrigin().z}, {oneway[1],oneway[2],oneway[3]} )
        local x, y = client.WorldToScreen(Vector3(oneway[1], oneway[2], oneway[3]))
        if x and y then
          if dist < 100 and isEnemy and player:IsAlive() then
            draw.Color(255, 0, 0)
          elseif dist < 1 and entities.GetLocalPlayer():GetIndex() == player:GetIndex() then
            draw.Color(255, 165, 0)
          elseif dist < 100 and not IsEnemy and player:IsAlive() and entities.GetLocalPlayer():GetIndex() ~= player:GetIndex() then
            draw.Color(0, 255, 0)

          end
          draw.FilledCircle(x, y, oneway_indicator_circle_size:GetValue())

        end
    end
    draw.Color(255, 255, 255)
  end
end



callbacks.Register("Draw", function()
  if not oneway_indicator_enabled:GetValue() then return end

  local localplayer = entities.GetLocalPlayer()
  if not IsValid(localplayer) then return end

  draw_oneways()

  if input.IsButtonReleased(oneway_indicator_add_oneway_key:GetValue()) then
    add_oneway()
  end

  if input.IsButtonReleased(oneway_indicator_remove_oneway_key:GetValue()) then
    remove_oneway()
  end
end)



callbacks.Register("CreateMove", function(cmd)
  if not oneway_indicator_enabled:GetValue() then return end
  
  local localplayer = entities.GetLocalPlayer()
  if not IsValid(localplayer) then return end

  if input.IsButtonDown(oneway_indicator_autowalk_key:GetValue()) then
    local oneway, _, dist = get_nearest_oneway()
    if dist > 0.1 then
      move_to_pos(Vector3(oneway[1], oneway[2], oneway[3]), cmd)
    end
  end
end)


function check_if_map_exists()
  oneways = json.decode(file.Contents("oneway_coords.txt"))

  if oneways[engine.GetMapName()] == nil then
    oneways[engine.GetMapName()] = {}
    update_file(oneways)
  end
end

callbacks.Register("Draw", check_if_map_exists)

function update_ui()
  if oneway_indicator_enabled:GetValue() then
    oneway_indicator_add_oneway_key:SetDisabled(false)
    oneway_indicator_remove_oneway_key:SetDisabled(false)
    oneway_indicator_autowalk_key:SetDisabled(false)
    oneway_indicator_circle_size:SetDisabled(false)
  else
    oneway_indicator_add_oneway_key:SetDisabled(true)
    oneway_indicator_remove_oneway_key:SetDisabled(true)
    oneway_indicator_autowalk_key:SetDisabled(true)
    oneway_indicator_circle_size:SetDisabled(true)
  end
end

callbacks.Register("Draw", update_ui)