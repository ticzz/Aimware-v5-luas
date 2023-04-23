-------------------------------------------------
--------   Carter's Bomb Timer   ----------------
--------      Created By:         ---------------
--------       CarterPoe          ---------------
--------     Date: 7/24/2022       --------------
-------------------------------------------------
--------  Tested By:             ----------------
--------  Agentsix1              ----------------
-------------------------------------------------
--
-- This is a product of the G&A Development Team
--
------------------------------
---  Credit To: Cheeseot   ---
---       Bomb Stuff       ---
------------------------------
--G&A Scripts--
--https://aimware.net/forum/thread/168242 Shared Music Kit Changer
--https://aimware.net/forum/thread/168291 Health Bars Plus v0.2


-- Pasted from https://github.com/tg021/tt/blob/master/dkjson.lua

-- Download and run the library. Place the download code below in your script.

-- json.encode(table) -- returns string
-- json.decode(string) -- returns table

--[=====[

local json_lib_installed = false

file.Enumerate(function(filename)
	if filename == "libraries/json.lua" then
		json_lib_installed = true
	end
end)

if not json_lib_installed then
	local body = http.Get("https://raw.githubusercontent.com/Aimware0/aimware_scripts/main/libraries/json.lua")
	file.Write("libraries/json.lua", body)
end

RunScript("libraries/json.lua")

--]=====]



-- Module options:
local always_try_using_lpeg = true
local register_global_module_table = false
local global_module_name = 'json'

--[==[

David Kolf's JSON module for Lua 5.1/5.2

Version 2.5


For the documentation see the corresponding readme.txt or visit
<http://dkolf.de/src/dkjson-lua.fsl/>.

You can contact the author by sending an e-mail to 'david' at the
domain 'dkolf.de'.


Copyright (C) 2010-2014 David Heiko Kolf

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

--]==]

-- global dependencies:
local pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset =
      pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset
local error, require, pcall, select = error, require, pcall, select
local floor, huge = math.floor, math.huge
local strrep, gsub, strsub, strbyte, strchar, strfind, strlen, strformat =
      string.rep, string.gsub, string.sub, string.byte, string.char,
      string.find, string.len, string.format
local strmatch = string.match
local concat = table.concat

json = { version = "dkjson 2.5" }

if register_global_module_table then
  _G[global_module_name] = json
end

local _ENV = nil -- blocking globals in Lua 5.2

pcall (function()
  -- Enable access to blocked metatables.
  -- Don't worry, this module doesn't change anything in them.
  local debmeta = require "debug".getmetatable
  if debmeta then getmetatable = debmeta end
end)

json.null = setmetatable ({}, {
  __tojson = function () return "null" end
})

local function isarray (tbl)
  local max, n, arraylen = 0, 0, 0
  for k,v in pairs (tbl) do
    if k == 'n' and type(v) == 'number' then
      arraylen = v
      if v > max then
        max = v
      end
    else
      if type(k) ~= 'number' or k < 1 or floor(k) ~= k then
        return false
      end
      if k > max then
        max = k
      end
      n = n + 1
    end
  end
  if max > 10 and max > arraylen and max > n * 2 then
    return false -- don't create an array with too many holes
  end
  return true, max
end

local escapecodes = {
  ["\""] = "\\\"", ["\\"] = "\\\\", ["\b"] = "\\b", ["\f"] = "\\f",
  ["\n"] = "\\n",  ["\r"] = "\\r",  ["\t"] = "\\t"
}

local function escapeutf8 (uchar)
  local value = escapecodes[uchar]
  if value then
    return value
  end
  local a, b, c, d = strbyte (uchar, 1, 4)
  a, b, c, d = a or 0, b or 0, c or 0, d or 0
  if a <= 0x7f then
    value = a
  elseif 0xc0 <= a and a <= 0xdf and b >= 0x80 then
    value = (a - 0xc0) * 0x40 + b - 0x80
  elseif 0xe0 <= a and a <= 0xef and b >= 0x80 and c >= 0x80 then
    value = ((a - 0xe0) * 0x40 + b - 0x80) * 0x40 + c - 0x80
  elseif 0xf0 <= a and a <= 0xf7 and b >= 0x80 and c >= 0x80 and d >= 0x80 then
    value = (((a - 0xf0) * 0x40 + b - 0x80) * 0x40 + c - 0x80) * 0x40 + d - 0x80
  else
    return ""
  end
  if value <= 0xffff then
    return strformat ("\\u%.4x", value)
  elseif value <= 0x10ffff then
    -- encode as UTF-16 surrogate pair
    value = value - 0x10000
    local highsur, lowsur = 0xD800 + floor (value/0x400), 0xDC00 + (value % 0x400)
    return strformat ("\\u%.4x\\u%.4x", highsur, lowsur)
  else
    return ""
  end
end

local function fsub (str, pattern, repl)
  -- gsub always builds a new string in a buffer, even when no match
  -- exists. First using find should be more efficient when most strings
  -- don't contain the pattern.
  if strfind (str, pattern) then
    return gsub (str, pattern, repl)
  else
    return str
  end
end

local function quotestring (value)
  -- based on the regexp "escapable" in https://github.com/douglascrockford/JSON-js
  value = fsub (value, "[%z\1-\31\"\\\127]", escapeutf8)
  if strfind (value, "[\194\216\220\225\226\239]") then
    value = fsub (value, "\194[\128-\159\173]", escapeutf8)
    value = fsub (value, "\216[\128-\132]", escapeutf8)
    value = fsub (value, "\220\143", escapeutf8)
    value = fsub (value, "\225\158[\180\181]", escapeutf8)
    value = fsub (value, "\226\128[\140-\143\168-\175]", escapeutf8)
    value = fsub (value, "\226\129[\160-\175]", escapeutf8)
    value = fsub (value, "\239\187\191", escapeutf8)
    value = fsub (value, "\239\191[\176-\191]", escapeutf8)
  end
  return "\"" .. value .. "\""
end
json.quotestring = quotestring

local function replace(str, o, n)
  local i, j = strfind (str, o, 1, true)
  if i then
    return strsub(str, 1, i-1) .. n .. strsub(str, j+1, -1)
  else
    return str
  end
end

-- locale independent num2str and str2num functions
local decpoint, numfilter

local function updatedecpoint ()
  decpoint = strmatch(tostring(0.5), "([^05+])")
  -- build a filter that can be used to remove group separators
  numfilter = "[^0-9%-%+eE" .. gsub(decpoint, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") .. "]+"
end

updatedecpoint()

local function num2str (num)
  return replace(fsub(tostring(num), numfilter, ""), decpoint, ".")
end

local function str2num (str)
  local num = tonumber(replace(str, ".", decpoint))
  if not num then
    updatedecpoint()
    num = tonumber(replace(str, ".", decpoint))
  end
  return num
end

local function addnewline2 (level, buffer, buflen)
  buffer[buflen+1] = "\n"
  buffer[buflen+2] = strrep ("  ", level)
  buflen = buflen + 2
  return buflen
end

function json.addnewline (state)
  if state.indent then
    state.bufferlen = addnewline2 (state.level or 0,
                           state.buffer, state.bufferlen or #(state.buffer))
  end
end

local encode2 -- forward declaration

local function addpair (key, value, prev, indent, level, buffer, buflen, tables, globalorder, state)
  local kt = type (key)
  if kt ~= 'string' and kt ~= 'number' then
    return nil, "type '" .. kt .. "' is not supported as a key by JSON."
  end
  if prev then
    buflen = buflen + 1
    buffer[buflen] = ","
  end
  if indent then
    buflen = addnewline2 (level, buffer, buflen)
  end
  buffer[buflen+1] = quotestring (key)
  buffer[buflen+2] = ":"
  return encode2 (value, indent, level, buffer, buflen + 2, tables, globalorder, state)
end

local function appendcustom(res, buffer, state)
  local buflen = state.bufferlen
  if type (res) == 'string' then
    buflen = buflen + 1
    buffer[buflen] = res
  end
  return buflen
end

local function exception(reason, value, state, buffer, buflen, defaultmessage)
  defaultmessage = defaultmessage or reason
  local handler = state.exception
  if not handler then
    return nil, defaultmessage
  else
    state.bufferlen = buflen
    local ret, msg = handler (reason, value, state, defaultmessage)
    if not ret then return nil, msg or defaultmessage end
    return appendcustom(ret, buffer, state)
  end
end

function json.encodeexception(reason, value, state, defaultmessage)
  return quotestring("<" .. defaultmessage .. ">")
end

encode2 = function (value, indent, level, buffer, buflen, tables, globalorder, state)
  local valtype = type (value)
  local valmeta = getmetatable (value)
  valmeta = type (valmeta) == 'table' and valmeta -- only tables
  local valtojson = valmeta and valmeta.__tojson
  if valtojson then
    if tables[value] then
      return exception('reference cycle', value, state, buffer, buflen)
    end
    tables[value] = true
    state.bufferlen = buflen
    local ret, msg = valtojson (value, state)
    if not ret then return exception('custom encoder failed', value, state, buffer, buflen, msg) end
    tables[value] = nil
    buflen = appendcustom(ret, buffer, state)
  elseif value == nil then
    buflen = buflen + 1
    buffer[buflen] = "null"
  elseif valtype == 'number' then
    local s
    if value ~= value or value >= huge or -value >= huge then
      -- This is the behaviour of the original JSON implementation.
      s = "null"
    else
      s = num2str (value)
    end
    buflen = buflen + 1
    buffer[buflen] = s
  elseif valtype == 'boolean' then
    buflen = buflen + 1
    buffer[buflen] = value and "true" or "false"
  elseif valtype == 'string' then
    buflen = buflen + 1
    buffer[buflen] = quotestring (value)
  elseif valtype == 'table' then
    if tables[value] then
      return exception('reference cycle', value, state, buffer, buflen)
    end
    tables[value] = true
    level = level + 1
    local isa, n = isarray (value)
    if n == 0 and valmeta and valmeta.__jsontype == 'object' then
      isa = false
    end
    local msg
    if isa then -- JSON array
      buflen = buflen + 1
      buffer[buflen] = "["
      for i = 1, n do
        buflen, msg = encode2 (value[i], indent, level, buffer, buflen, tables, globalorder, state)
        if not buflen then return nil, msg end
        if i < n then
          buflen = buflen + 1
          buffer[buflen] = ","
        end
      end
      buflen = buflen + 1
      buffer[buflen] = "]"
    else -- JSON object
      local prev = false
      buflen = buflen + 1
      buffer[buflen] = "{"
      local order = valmeta and valmeta.__jsonorder or globalorder
      if order then
        local used = {}
        n = #order
        for i = 1, n do
          local k = order[i]
          local v = value[k]
          if v then
            used[k] = true
            buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
            prev = true -- add a seperator before the next element
          end
        end
        for k,v in pairs (value) do
          if not used[k] then
            buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
            if not buflen then return nil, msg end
            prev = true -- add a seperator before the next element
          end
        end
      else -- unordered
        for k,v in pairs (value) do
          buflen, msg = addpair (k, v, prev, indent, level, buffer, buflen, tables, globalorder, state)
          if not buflen then return nil, msg end
          prev = true -- add a seperator before the next element
        end
      end
      if indent then
        buflen = addnewline2 (level - 1, buffer, buflen)
      end
      buflen = buflen + 1
      buffer[buflen] = "}"
    end
    tables[value] = nil
  else
    return exception ('unsupported type', value, state, buffer, buflen,
      "type '" .. valtype .. "' is not supported by JSON.")
  end
  return buflen
end

function json.encode (value, state)
  state = state or {}
  local oldbuffer = state.buffer
  local buffer = oldbuffer or {}
  state.buffer = buffer
  updatedecpoint()
  local ret, msg = encode2 (value, state.indent, state.level or 0,
                   buffer, state.bufferlen or 0, state.tables or {}, state.keyorder, state)
  if not ret then
    error (msg, 2)
  elseif oldbuffer == buffer then
    state.bufferlen = ret
    return true
  else
    state.bufferlen = nil
    state.buffer = nil
    return concat (buffer)
  end
end

local function loc (str, where)
  local line, pos, linepos = 1, 1, 0
  while true do
    pos = strfind (str, "\n", pos, true)
    if pos and pos < where then
      line = line + 1
      linepos = pos
      pos = pos + 1
    else
      break
    end
  end
  return "line " .. line .. ", column " .. (where - linepos)
end

local function unterminated (str, what, where)
  return nil, strlen (str) + 1, "unterminated " .. what .. " at " .. loc (str, where)
end

local function scanwhite (str, pos)
  while true do
    pos = strfind (str, "%S", pos)
    if not pos then return nil end
    local sub2 = strsub (str, pos, pos + 1)
    if sub2 == "\239\187" and strsub (str, pos + 2, pos + 2) == "\191" then
      -- UTF-8 Byte Order Mark
      pos = pos + 3
    elseif sub2 == "//" then
      pos = strfind (str, "[\n\r]", pos + 2)
      if not pos then return nil end
    elseif sub2 == "/*" then
      pos = strfind (str, "*/", pos + 2)
      if not pos then return nil end
      pos = pos + 2
    else
      return pos
    end
  end
end

local escapechars = {
  ["\""] = "\"", ["\\"] = "\\", ["/"] = "/", ["b"] = "\b", ["f"] = "\f",
  ["n"] = "\n", ["r"] = "\r", ["t"] = "\t"
}

local function unichar (value)
  if value < 0 then
    return nil
  elseif value <= 0x007f then
    return strchar (value)
  elseif value <= 0x07ff then
    return strchar (0xc0 + floor(value/0x40),
                    0x80 + (floor(value) % 0x40))
  elseif value <= 0xffff then
    return strchar (0xe0 + floor(value/0x1000),
                    0x80 + (floor(value/0x40) % 0x40),
                    0x80 + (floor(value) % 0x40))
  elseif value <= 0x10ffff then
    return strchar (0xf0 + floor(value/0x40000),
                    0x80 + (floor(value/0x1000) % 0x40),
                    0x80 + (floor(value/0x40) % 0x40),
                    0x80 + (floor(value) % 0x40))
  else
    return nil
  end
end

local function scanstring (str, pos)
  local lastpos = pos + 1
  local buffer, n = {}, 0
  while true do
    local nextpos = strfind (str, "[\"\\]", lastpos)
    if not nextpos then
      return unterminated (str, "string", pos)
    end
    if nextpos > lastpos then
      n = n + 1
      buffer[n] = strsub (str, lastpos, nextpos - 1)
    end
    if strsub (str, nextpos, nextpos) == "\"" then
      lastpos = nextpos + 1
      break
    else
      local escchar = strsub (str, nextpos + 1, nextpos + 1)
      local value
      if escchar == "u" then
        value = tonumber (strsub (str, nextpos + 2, nextpos + 5), 16)
        if value then
          local value2
          if 0xD800 <= value and value <= 0xDBff then
            -- we have the high surrogate of UTF-16. Check if there is a
            -- low surrogate escaped nearby to combine them.
            if strsub (str, nextpos + 6, nextpos + 7) == "\\u" then
              value2 = tonumber (strsub (str, nextpos + 8, nextpos + 11), 16)
              if value2 and 0xDC00 <= value2 and value2 <= 0xDFFF then
                value = (value - 0xD800)  * 0x400 + (value2 - 0xDC00) + 0x10000
              else
                value2 = nil -- in case it was out of range for a low surrogate
              end
            end
          end
          value = value and unichar (value)
          if value then
            if value2 then
              lastpos = nextpos + 12
            else
              lastpos = nextpos + 6
            end
          end
        end
      end
      if not value then
        value = escapechars[escchar] or escchar
        lastpos = nextpos + 2
      end
      n = n + 1
      buffer[n] = value
    end
  end
  if n == 1 then
    return buffer[1], lastpos
  elseif n > 1 then
    return concat (buffer), lastpos
  else
    return "", lastpos
  end
end

local scanvalue -- forward declaration

local function scantable (what, closechar, str, startpos, nullval, objectmeta, arraymeta)
  local len = strlen (str)
  local tbl, n = {}, 0
  local pos = startpos + 1
  if what == 'object' then
    setmetatable (tbl, objectmeta)
  else
    setmetatable (tbl, arraymeta)
  end
  while true do
    pos = scanwhite (str, pos)
    if not pos then return unterminated (str, what, startpos) end
    local char = strsub (str, pos, pos)
    if char == closechar then
      return tbl, pos + 1
    end
    local val1, err
    val1, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
    if err then return nil, pos, err end
    pos = scanwhite (str, pos)
    if not pos then return unterminated (str, what, startpos) end
    char = strsub (str, pos, pos)
    if char == ":" then
      if val1 == nil then
        return nil, pos, "cannot use nil as table index (at " .. loc (str, pos) .. ")"
      end
      pos = scanwhite (str, pos + 1)
      if not pos then return unterminated (str, what, startpos) end
      local val2
      val2, pos, err = scanvalue (str, pos, nullval, objectmeta, arraymeta)
      if err then return nil, pos, err end
      tbl[val1] = val2
      pos = scanwhite (str, pos)
      if not pos then return unterminated (str, what, startpos) end
      char = strsub (str, pos, pos)
    else
      n = n + 1
      tbl[n] = val1
    end
    if char == "," then
      pos = pos + 1
    end
  end
end

scanvalue = function (str, pos, nullval, objectmeta, arraymeta)
  pos = pos or 1
  pos = scanwhite (str, pos)
  if not pos then
    return nil, strlen (str) + 1, "no valid JSON value (reached the end)"
  end
  local char = strsub (str, pos, pos)
  if char == "{" then
    return scantable ('object', "}", str, pos, nullval, objectmeta, arraymeta)
  elseif char == "[" then
    return scantable ('array', "]", str, pos, nullval, objectmeta, arraymeta)
  elseif char == "\"" then
    return scanstring (str, pos)
  else
    local pstart, pend = strfind (str, "^%-?[%d%.]+[eE]?[%+%-]?%d*", pos)
    if pstart then
      local number = str2num (strsub (str, pstart, pend))
      if number then
        return number, pend + 1
      end
    end
    pstart, pend = strfind (str, "^%a%w*", pos)
    if pstart then
      local name = strsub (str, pstart, pend)
      if name == "true" then
        return true, pend + 1
      elseif name == "false" then
        return false, pend + 1
      elseif name == "null" then
        return nullval, pend + 1
      end
    end
    return nil, pos, "no valid JSON value at " .. loc (str, pos)
  end
end

local function optionalmetatables(...)
  if select("#", ...) > 0 then
    return ...
  else
    return {__jsontype = 'object'}, {__jsontype = 'array'}
  end
end

function json.decode (str, pos, nullval, ...)
  local objectmeta, arraymeta = optionalmetatables(...)
  return scanvalue (str, pos, nullval, objectmeta, arraymeta)
end

function json.use_lpeg ()
  local g = require ("lpeg")

  if g.version() == "0.11" then
    error "due to a bug in LPeg 0.11, it cannot be used for JSON matching"
  end

  local pegmatch = g.match
  local P, S, R = g.P, g.S, g.R

  local function ErrorCall (str, pos, msg, state)
    if not state.msg then
      state.msg = msg .. " at " .. loc (str, pos)
      state.pos = pos
    end
    return false
  end

  local function Err (msg)
    return g.Cmt (g.Cc (msg) * g.Carg (2), ErrorCall)
  end

  local SingleLineComment = P"//" * (1 - S"\n\r")^0
  local MultiLineComment = P"/*" * (1 - P"*/")^0 * P"*/"
  local Space = (S" \n\r\t" + P"\239\187\191" + SingleLineComment + MultiLineComment)^0

  local PlainChar = 1 - S"\"\\\n\r"
  local EscapeSequence = (P"\\" * g.C (S"\"\\/bfnrt" + Err "unsupported escape sequence")) / escapechars
  local HexDigit = R("09", "af", "AF")
  local function UTF16Surrogate (match, pos, high, low)
    high, low = tonumber (high, 16), tonumber (low, 16)
    if 0xD800 <= high and high <= 0xDBff and 0xDC00 <= low and low <= 0xDFFF then
      return true, unichar ((high - 0xD800)  * 0x400 + (low - 0xDC00) + 0x10000)
    else
      return false
    end
  end
  local function UTF16BMP (hex)
    return unichar (tonumber (hex, 16))
  end
  local U16Sequence = (P"\\u" * g.C (HexDigit * HexDigit * HexDigit * HexDigit))
  local UnicodeEscape = g.Cmt (U16Sequence * U16Sequence, UTF16Surrogate) + U16Sequence/UTF16BMP
  local Char = UnicodeEscape + EscapeSequence + PlainChar
  local String = P"\"" * g.Cs (Char ^ 0) * (P"\"" + Err "unterminated string")
  local Integer = P"-"^(-1) * (P"0" + (R"19" * R"09"^0))
  local Fractal = P"." * R"09"^0
  local Exponent = (S"eE") * (S"+-")^(-1) * R"09"^1
  local Number = (Integer * Fractal^(-1) * Exponent^(-1))/str2num
  local Constant = P"true" * g.Cc (true) + P"false" * g.Cc (false) + P"null" * g.Carg (1)
  local SimpleValue = Number + String + Constant
  local ArrayContent, ObjectContent

  -- The functions parsearray and parseobject parse only a single value/pair
  -- at a time and store them directly to avoid hitting the LPeg limits.
  local function parsearray (str, pos, nullval, state)
    local obj, cont
    local npos
    local t, nt = {}, 0
    repeat
      obj, cont, npos = pegmatch (ArrayContent, str, pos, nullval, state)
      if not npos then break end
      pos = npos
      nt = nt + 1
      t[nt] = obj
    until cont == 'last'
    return pos, setmetatable (t, state.arraymeta)
  end

  local function parseobject (str, pos, nullval, state)
    local obj, key, cont
    local npos
    local t = {}
    repeat
      key, obj, cont, npos = pegmatch (ObjectContent, str, pos, nullval, state)
      if not npos then break end
      pos = npos
      t[key] = obj
    until cont == 'last'
    return pos, setmetatable (t, state.objectmeta)
  end

  local Array = P"[" * g.Cmt (g.Carg(1) * g.Carg(2), parsearray) * Space * (P"]" + Err "']' expected")
  local Object = P"{" * g.Cmt (g.Carg(1) * g.Carg(2), parseobject) * Space * (P"}" + Err "'}' expected")
  local Value = Space * (Array + Object + SimpleValue)
  local ExpectedValue = Value + Space * Err "value expected"
  ArrayContent = Value * Space * (P"," * g.Cc'cont' + g.Cc'last') * g.Cp()
  local Pair = g.Cg (Space * String * Space * (P":" + Err "colon expected") * ExpectedValue)
  ObjectContent = Pair * Space * (P"," * g.Cc'cont' + g.Cc'last') * g.Cp()
  local DecodeValue = ExpectedValue * g.Cp ()

  function json.decode (str, pos, nullval, ...)
    local state = {}
    state.objectmeta, state.arraymeta = optionalmetatables(...)
    local obj, retpos = pegmatch (DecodeValue, str, pos, nullval, state)
    if state.msg then
      return nil, state.pos, state.msg
    else
      return obj, retpos
    end
  end

  -- use this function only once:
  json.use_lpeg = function () return json end

  json.using_lpeg = true

  return json -- so you can get the module using json = require "dkjson".use_lpeg()
end
windows = {}

local function Move(window)
	if window.Move then
		if input.IsButtonDown(1) then
			mouseX, mouseY = input.GetMousePos();
			if shouldDrag then
				window.X = mouseX - dx;
				window.Y = mouseY - dy;
			end
			if mouseX >= window.X and mouseX <= window.X + window.W and mouseY >= window.Y and mouseY <= window.Y + window.H then
				if window.BoundsHeight ~= nil then
					if mouseX >= window.X and mouseX <= window.X + window.W and mouseY >= window.Y and mouseY <= window.Y + window.BoundsHeight then
						window.Resize = false
						shouldDrag = true;
						dx = mouseX - window.X;
						dy = mouseY - window.Y;
						if window.Form.Dragging ~= nil then
							window.Form.Dragging = true
						end
					end
					
				else
					if window.BoundsWidth ~= nil then
						if mouseX >= window.X and mouseX <= window.X + window.BoundsWidth and mouseY >= window.Y and mouseY <= window.Y + window.H then
							window.Resize = false
							shouldDrag = true;
							dx = mouseX - window.X;
							dy = mouseY - window.Y;
							if window.Form.Dragging ~= nil then
								window.Form.Dragging = true
							end
						end
					else
						window.Resize = false
						shouldDrag = true;
						dx = mouseX - window.X;
						dy = mouseY - window.Y;
						if window.Form.Dragging ~= nil then
							window.Form.Dragging = true
						end
					end
				end
			else
				if window.Form.Dragging ~= nil then
					window.Form.Dragging = true
				end
			end
		else
			shouldDrag = false;
			if window.Form.Dragging ~= nil then
				window.Form.Dragging = false
			end
			
		end
	end
end

local function Resize(window)
	if window.Resize then
		draw.Color(255,0,0,255)
		draw.FilledRect(window.X+window.W, window.Y+window.H, window.X+window.W+10, window.Y+window.H+10)
		local resizex = window.X+window.W
		local resizey = window.Y+window.H
		local resizew = window.X+window.W+10
		local resizeh = window.Y+window.H+10
		if input.IsButtonDown(1) then
			mouseX, mouseY = input.GetMousePos();
			if shouldDrag then
				window.W = mouseX - dx;
				window.H = mouseY - dy;
				if window.W < window.MinW then window.W = window.MinW end
				if window.W > window.MaxW then window.W = window.MaxW end
				if window.H < window.MinW then window.H = window.MinW end
				if window.H > window.MaxW then window.H = window.MaxW end
			end
			if mouseX >= resizex and mouseX <= resizex + resizew and mouseY >= resizey and mouseY <= resizey + resizeh then
				window.Move = false
				shouldDrag = true;
				dx = mouseX - window.W;
				dy = mouseY - window.H;
			end
		else
			shouldDrag = false;
		end
	end
end

callbacks.Register("Draw", function()
    for i = 1, #windows do
        local window = windows[i]
		
		if window.Form.Visible ~= nil then
			if window.Form.Visible ~= true then
				return
			end
		end

        if window.OverrideLocation then
            window.X, window.Y = window.Location(window.X, window.Y, window.W, window.H)
        end

		if window.Form ~= nil then
			window.X =  window.Form.Location.X
			window.Y = window.Form.Location.Y
			window.W = window.Form.Size.Width
			window.H = window.Form.Size.Height
			window.MinW = window.Form.MinimumSize.Width
			window.MinH = window.Form.MinimumSize.Height
			window.MaxW = window.Form.MaximumSize.Width
			window.MaxH = window.Form.MaximumSize.Height
		end

		window.Draw(window.X, window.Y, window.W, window.H)

		if window.Form ~= nil then
			if window.Form.BorderStyle == "Sizable" then
				Resize(window)
			end
		else
			if window.Resize then
				Resize(window)
			end
		end

        if input.IsButtonReleased(1) then
            window.Move = true
            window.Resize = true
        end

        if window.Move then
            Move(window)
        end
        if input.IsButtonReleased(1) then
            window.Move = true
            window.Resize = true
        end
		if window.Form ~= nil then
			window.Form.Location.X = window.X
			window.Form.Location.Y = window.Y
			window.Form.Size.Width = window.W
			window.Form.Size.Height = window.H
			window.Form.MinimumSize.Width = window.MinW
			window.Form.MinimumSize.Height = window.MinH
			window.Form.MaximumSize.Width = window.MaxW
			window.Form.MaximumSize.Height = window.MaxH
		end

    end
end)

function size(w, h)
	return {
		Width = w,
		Height = h,
	}
end

function point(x, y)
	return {
		X = x,
		Y = y,
	}
end

function color(r, g, b, a)
	return {r, g, b, a}
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. '\n'
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

--ffi.cdef([[
--    int ShowCursor(bool bShow);
--]])
--
--function ShowCursor(bool)
--	ffi.C.ShowCursor(bool)
--	print(bool)
--end

function MouseInLocation(X, Y, W, H)
	local mouseX, mouseY = input.GetMousePos()
	if mouseX >= X and mouseX <= X + W and mouseY >= Y and mouseY <= Y + H then
		return true
	else
		return false
	end
end

function center(itemW, itemH, W, H)
	return (W/2)-(itemW/2), (H/2)-(itemH/2)
end

SystemColors = {
	Black = color(0, 0, 0 , 255),
	DarkGrey = color(128, 128, 128, 180),
	Control = color(240, 240, 240, 255),
	Button = color(225, 225, 225, 255),
	ButtonHighlight = color(0, 120, 215, 20),
	ButtonClick = color(0, 120, 215, 35),
	TitleBarControlHighlight = color(229, 229, 229, 255),
	TitleBarControlCloseHighlight = color(232, 17, 35, 255),
	ButtonHighlightBorder = color(0, 120, 215, 150),
	White = color(255, 255, 255, 255),
	Green = color(6, 176, 37, 255),
	Transparent = color(1, 1, 1, 1),
	Grey = color(141, 141, 141, 255),
	Red = color(240, 20, 0, 255),
	Blue = color(0, 135, 255, 255),
	Yellow = color(210, 150, 0, 255),
}

Toolbox = {
	Label = function()
		local Props = {
			Name = "Label",
			Text = "A Label",
			Location = point(0, 0),
			Size = size(75, 23),
			
			Font = {
				Name = "Microsoft Sans Serif",
				Size = 15,
				LoadedFont = nil,
			},
			ForeColor = SystemColors.Black,
		}
		local RegEvens = {

		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				--Label
				draw.SetFont(props.Font.LoadedFont)
				draw.Color(unpack(props.ForeColor))
				local Tw, Th = draw.GetTextSize(props.Text)
				props.Size = size(Tw + props.Font.Size, Th + props.Font.Size)
				draw.TextShadow(X + 8, Y + 15, props.Text)
			end,
			Register = function(event, callback)

			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			RegisteredEvents = RegEvens,
			Events = Evens,
			OverridedEvents = {},
			
			Update = function(props)
				props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size, props.Font.Size)
				
				return props
			end,
		}
	end,
	PictureBox = function()
		local Props = {
			Name = "Picturebox",
			Location = point(0, 0),
			Size = size(75, 23),
			Icon = "",
			LoadedIcon = nil,
			Visible = true,
		}
		local RegEvens = {
			MouseHover = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X =  X + props.Location.X
				Y =  Y + props.Location.Y
				
				--Icon
				if props.Visible then
					draw.Color(255, 255, 255, 255)
					draw.SetTexture(props.LoadedIcon)
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					draw.SetTexture(nil)
				end
			end,
			Register = function(event, callback)
				if event == "MouseHover" then
					RegEvens.MouseHover = callback
				end
			end,
			MouseHover = function(mouseX, mouseY, X, Y, W, H, props)
				if props.Visible then
					props.BackColor = SystemColors.Black
				end
			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			RegisteredEvents = RegEvens,
			Events = Evens,
			OverridedEvents = {},
			
			Update = function(props)
				
				local iconRGBA, iconWidth, iconHeight = common.DecodePNG(http.Get(props.Icon))
				local iconTexture = draw.CreateTexture(iconRGBA, iconWidth, iconHeight)
				props.LoadedIcon = iconTexture
				
				return props
			end,
		}
	end,
	Button = function()
		local Props = {
			Name = "Button",
			Text = "A Button",
			Size = size(75, 23),
			Location = point(0, 0),
			Visible = true,
			
			Font = {
				Name = "Microsoft Sans Serif",
				Size = 15,
				LoadedFont = nil,
			},
			ForeColor = SystemColors.Black,
			BackColor = SystemColors.Button,
			BorderColor = SystemColors.DarkGrey,
		}
		local RegEvens = {
			MouseHover = nil,
			MouseClick = nil,
		}
		local OverEvens = {
			Draw = nil,
			MouseHover = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				--Background
				draw.Color(unpack(props.BackColor))
				draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				
				--Border
				draw.Color(unpack(props.BorderColor))
				draw.OutlinedRect(X, Y, X + props.Size.Width, Y + props.Size.Height)

				--Label
				draw.SetFont(props.Font.LoadedFont)
				local Tw, Th = draw.GetTextSize(props.Text)
				local centerX, centerY = center(Tw, Th, props.Size.Width, props.Size.Height)
				
				draw.Color(unpack(props.ForeColor))
				draw.Text(X + centerX, Y + centerY, props.Text)
				
			end,
			MouseHover = function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				--Background
				draw.Color(unpack(SystemColors.ButtonHighlight))
				draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				
				--Border
				draw.Color(unpack(SystemColors.ButtonHighlightBorder))
				draw.OutlinedRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
			end,
			Register = function(event, callback)
				if event == "MouseHover" then
					RegEvens.MouseHover = callback
				end
				if event == "MouseClick" then
					RegEvens.MouseClick = callback
				end
			end,
			Override = function(event, callback)
				if event == "Draw" then
					OverEvens.Draw = callback
				end
				if event == "MouseHover" then
					OverEvens.MouseHover = callback
				end
			end,
			Click = function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				--Background
				if props.Visible then
					draw.Color(unpack(SystemColors.ButtonClick))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				end
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			Events = Evens,
			RegisteredEvents = RegEvens,
			OverridedEvents = OverEvens,
			
			Update = function(props)
				props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size, props.Font.Size)
				
				return props
			end,
		}
	end,
	ProgressBar = function()
		local Props = {
			Name = "ProgressBar",
			Size = size(100, 23),
			Location = point(0, 0),
			Visible = true,
			Value = 0,
			Minimum = 0,
			Maximum = 100,
			RightToLeft = false,
			Rounded = false,
			Roundness = 100,
			
			
			Font = {
				Name = "Microsoft Sans Serif",
				Size = 15,
				LoadedFont = nil,
			},
			ForeColor = SystemColors.Black,
			ValueColor = SystemColors.Green,
			BackColor = SystemColors.Button,
			BorderColor = SystemColors.DarkGrey,
		}
		local RegEvens = {

		}
		local OverEvens = {
			Draw = nil,
		}
		local Evens = {
			Draw = function(X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				if props.Rounded then
					--placeholder
					draw.Color(unpack(props.BackColor))
					draw.RoundedRectFill(X, Y, X + props.Size.Width, Y + props.Size.Height, props.Roundness)
					
					--value
					draw.Color(unpack(props.ValueColor))
					--draw.FilledRect(X, Y, X + props.Value, Y + props.Size.Height)
					
					if props.Value >= props.Maximum then 
						draw.RoundedRectFill(X, Y, X + ((props.Size.Width/props.Maximum)*props.Maximum), Y + props.Size.Height, props.Roundness)
						return 
					end
					if props.Value <= props.Minimum then
						draw.RoundedRectFill(X, Y, X + ((props.Size.Width/props.Maximum)*props.Minimum), Y + props.Size.Height, props.Roundness)
						return
					end
					draw.RoundedRectFill(X, Y, X + ((props.Size.Width/props.Maximum)*props.Value), Y + props.Size.Height,props.Roundness)

					
				else
					--placeholder
					draw.Color(unpack(props.BackColor))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					
					--value
					draw.Color(unpack(props.ValueColor))
					--draw.FilledRect(X, Y, X + props.Value, Y + props.Size.Height)
					
					if props.Value >= props.Maximum then 
						draw.FilledRect(X, Y, X + ((props.Size.Width/props.Maximum)*props.Maximum), Y + props.Size.Height)
						return 
					end
					if props.Value <= props.Minimum then
						draw.FilledRect(X, Y, X + ((props.Size.Width/props.Maximum)*props.Minimum), Y + props.Size.Height)
						return
					end
					draw.FilledRect(X, Y, X + ((props.Size.Width/props.Maximum)*props.Value), Y + props.Size.Height)

					draw.Color(unpack(props.BorderColor))
					draw.OutlinedRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				end
				
				
				
			end,
			Register = function(event, callback)
			
			end,
			Override = function(event, callback)
				if event == "Draw" then
					OverEvens.Draw = callback
				end
			end,
		}
		return {
			Interface = "Control",
			Properties = Props,
			Events = Evens,
			RegisteredEvents = RegEvens,
			OverridedEvents = OverEvens,
			
			Update = function(props)
				props.Font.LoadedFont = draw.CreateFont(props.Font.Name, props.Font.Size, props.Font.Size)
				
				return props
			end,
		}
	end,
}

local Forms = {}

callbacks.Register("Draw", function()

end)

callbacks.Register("Unload", function()
	for i = 1, #windows do
		local window = windows[i]
		for i = 1, #Forms do
			local form = Forms[i]
			if window.Name == form.Name then
				windows[i] = nil
			end
		end
	end
end)

WinWindow = {
	Draw = {
		Background = function(Form, X, Y, W, H)
			if Form.BorderShadow then
				draw.Color(unpack(Form.BorderShadowColor));
				draw.ShadowRect(X, Y, X + W, Y + H, Form.BorderShadowRadius)
			end
			if Form.WinStyle == 11 then
				draw.Color(unpack(Form.BackColor))
				draw.RoundedRectFill(X, Y, X + W, Y + H, 6, 6, 6, 6, 6)
			end
			if Form.WinStyle == 10 then
				draw.Color(unpack(Form.BackColor))
				draw.FilledRect(X, Y, X + W, Y + H)
			end

		end,
		TitleBar = function(Form, X, Y, W, H)
			if Form.BorderStyle == "Sizable" then
				if Form.WinStyle == 11 then
					--Titlebar
					draw.Color(unpack(Form.TitleBarColor))
					draw.RoundedRectFill(X, Y, X + W, Y + 30, 6, 5, 5, 0, 0)
				end
				if Form.WinStyle == 10 then
					--Titlebar
					draw.Color(unpack(Form.TitleBarColor))
					draw.FilledRect(X, Y, X + W, Y + 30)
				end
				--Title
				draw.SetFont(Form.Font.LoadedFont)
				draw.Color(unpack(Form.ForeColor))
				draw.Text(X + 34, Y + 10, Form.Name)
				
				--Title Icon
				draw.Color(255, 255, 255, 255)
				draw.SetTexture(Form.LoadedIcon)
				draw.FilledRect(X + 10, Y + 8, X + 25, Y + 23)
				draw.SetTexture(nil)
			
				
			end
		end,
	},
}

Application = {
	Run = function(Form)
		if Form.Interface == "Form" then
			if Form.Update ~= nil then
				Form = Form.Update(Form)
			end
			local Controls = Form.Initialize()
			
			Controls["Add"] = function(control)
				control.Properties = control.Update(control.Properties)
				table.insert(Controls, control)
			end
			
			Controls["Find"] = function(name)
				for i = 1, #Controls do
					local control = Controls[i]
					if control.Properties.Name == name then
						return i
					end
				end
			end
			
			local button_close = Toolbox.Button()
			button_close.Properties.Size = size(45, 30)
			button_close.Properties.Name = "CloseBtn"
			
			local button_maximize = Toolbox.Button()
			button_maximize.Properties.Size = size(45, 30)
			button_maximize.Properties.Name = "MaxBtn"
			
			local picturebox_close = Toolbox.PictureBox()
			
			picturebox_close.Properties.Name = "pb_close"
			picturebox_close.Properties.Size = size(11,11)
			picturebox_close.Properties.Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/close.png"
			
			local picturebox_max = Toolbox.PictureBox()
			
			picturebox_max.Properties.Name = "pb_max"
			picturebox_max.Properties.Size = size(11,11)
			picturebox_max.Properties.Icon = "https://raw.githubusercontent.com/G-A-Development-Team/WinFormAPI/main/maximize.png"
			
			--picturebox_close.Properties = picturebox_close.Events.Update(picturebox_close.Properties)
			
			button_close.Events.Override("Draw", function(X, Y, W, H, props, Form)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				if Form.BorderStyle == "Sizable" then
					--draw.Color(unpack(SystemColors.Black))
					--draw.FilledRect(X + props.Location.X, Y + props.Location.Y, X + props.Size.Width, Y + props.Size.Height)
					
					if Form.WinStyle == 11 then
						draw.Color(unpack(Form.TitleBarColor))
						draw.RoundedRectFill(X, Y, X + props.Size.Width, Y + props.Size.Height, 7, 0, 7, 0, 0)
					end
					if Form.WinStyle == 10 then
						draw.Color(unpack(Form.TitleBarColor))
						draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					end
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Location = point(props.Location.X + 17,props.Location.Y + 9)
				else
					Form.Controls[Form.Controls.Find("pb_close")].Properties.Visible = false
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = false
				end
			end)
			
			button_close.Events.Override("MouseHover", function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				if Form.BorderStyle == "Sizable" then
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = true
					if Form.WinStyle == 11 then
						draw.Color(unpack(SystemColors.TitleBarControlCloseHighlight))
						draw.RoundedRectFill(X, Y, X + props.Size.Width, Y + props.Size.Height, 6, 0, 6, 0, 0)
					end
					if Form.WinStyle == 10 then
						draw.Color(unpack(SystemColors.TitleBarControlCloseHighlight))
						draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					end
				else
					Form.Controls[Form.Controls.Find("CloseBtn")].Properties.Visible = false
				end
			end)
			button_close.Events.Register("MouseClick", function(mouseX, mouseY)
				if Form.BorderStyle == "Sizable" then
					Form.Visible = not Form.Visible
				end
			end)
			
			button_maximize.Events.Override("Draw", function(X, Y, W, H, props, Form)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				
				if Form.BorderStyle == "Sizable" then
					--draw.Color(unpack(SystemColors.Black))
					--draw.FilledRect(X + props.Location.X, Y + props.Location.Y, X + props.Size.Width, Y + props.Size.Height)
					
					draw.Color(unpack(Form.TitleBarColor))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
					
					Form.Controls[Form.Controls.Find("MaxBtn")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Visible = true
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Location = point( props.Location.X + 17,props.Location.Y+9)
				else
					Form.Controls[Form.Controls.Find("pb_max")].Properties.Visible = false
					Form.Controls[Form.Controls.Find("MaxBtn")].Properties.Visible = false
				end
			end)
			
			button_maximize.Events.Register("MouseClick", function(mouseX, mouseY)
				if Form.BorderStyle == "Sizable" then
					Form.Size = Form.MaximumSize -100
				end
			end)
			
			button_maximize.Events.Override("MouseHover", function(mouseX, mouseY, X, Y, W, H, props)
				X = X + props.Location.X
				Y = Y + props.Location.Y
				if Form.BorderStyle == "Sizable" then
					draw.Color(unpack(SystemColors.TitleBarControlHighlight))
					draw.FilledRect(X, Y, X + props.Size.Width, Y + props.Size.Height)
				end
			end)
			
			Controls.Add(button_close)
			Controls.Add(button_maximize)
			Controls.Add(picturebox_close)
			Controls.Add(picturebox_max)
			
			for i = 1, #Controls do
				local control = Controls[i]
				if Controls[i].Interface == "Control" then
					Controls[i].Properties = control.Update(control.Properties)
				end
			end
			
			if Form.Load ~= nil then
				Form.Load()
			end
			
			local Resizable = false
			
			if Form.BorderStyle == "Sizable" then
				Resizable = true
			end
			
			if Form.BorderStyle == "None" then
				Resizable = false
			end
			Form.Dragging = false
			local tbl = {
				Name = Form.Name,
				Form = Form,
				X = Form.Location.X,
				Y = Form.Location.Y,
				W = Form.Size.Width,
				H = Form.Size.Height,
				MinW = Form.MinimumSize.Width,
				MinH = Form.MinimumSize.Height,
				MaxW = Form.MaximumSize.Width,
				MaxH = Form.MaximumSize.Height,
				Resize = Resizable,
				Move = Resizable,
				
				BoundsHeight = Form.DragBounds,
				
				Draw = function(X, Y, W, H)

					if Form.Visible ~= true then
						return
					end
					WinWindow.Draw.Background(Form, X, Y, W, H)
					WinWindow.Draw.TitleBar(Form, X, Y, W, H)
					
					if MouseInLocation(X, Y, W, H) then
						if Form.CursorEnabled == false then
						
							Form.CursorEnabled = true
						end
						--draw.Color(255, 255, 255, 255)
						--draw.SetTexture(Form.LoadedCursorIcon)
						--draw.FilledRect(mouseX, mouseY, mouseX + 33, mouseY + 33)
						--draw.SetTexture(nil)
					else
						if Form.CursorEnabled == true then
							Form.CursorEnabled = false
						end
					end
					
					Controls[Controls.Find("CloseBtn")].Properties.Location = point(W - Controls[Controls.Find("CloseBtn")].Properties.Size.Width, 0)
					Controls[Controls.Find("MaxBtn")].Properties.Location = point(W - (Controls[Controls.Find("MaxBtn")].Properties.Size.Width * 2), 0)
					
					for i = 1, #Controls do
						local control = Controls[i]
						if Controls[i].Interface == "Control" then
							if control.OverridedEvents.Draw ~= nil then
								control.OverridedEvents.Draw(X, Y, W, H, control.Properties, Form)
							else
								control.Events.Draw(X, Y, W, H, control.Properties)
							end
							
							if MouseInLocation(control.Properties.Location.X + X, control.Properties.Location.Y + Y, control.Properties.Size.Width, control.Properties.Size.Height) then
								local mouseX, mouseY = input.GetMousePos()
								
								--Registered Events
								if control.OverridedEvents.MouseHover ~= nil then
									control.OverridedEvents.MouseHover(mouseX, mouseY, X, Y, W, H, control.Properties)
								else
									if control.Events.MouseHover ~= nil then
										control.Events.MouseHover(mouseX, mouseY, X, Y, W, H, control.Properties)
									end
								end
								
								if control.RegisteredEvents.MouseHover ~= nil then
									control.RegisteredEvents.MouseHover(mouseX, mouseY)
								end
								
								if input.IsButtonDown(1) then
									if control.Events.Click ~= nil then
										control.Events.Click(mouseX, mouseY, X, Y, W, H, control.Properties)
									end
								end
								
								if input.IsButtonReleased(1) then
									if control.RegisteredEvents.MouseClick ~= nil then
										control.RegisteredEvents.MouseClick(mouseX, mouseY)
									end
								end
							end

						end
					end
				end,
			}
			
			table.insert(windows, tbl)
			table.insert(Forms, tbl)
			
			Form.Controls = Controls
			return Form
		end
	end,
}

function BombDamage(Bomb, Player)

    local playerOrigin = Player:GetAbsOrigin()
    local bombOrigin = Bomb:GetAbsOrigin()

	local C4Distance = math.sqrt((bombOrigin.x - playerOrigin.x) ^ 2 + 
	(bombOrigin.y - playerOrigin.y) ^ 2 + 
	(bombOrigin.z - playerOrigin.z) ^ 2);

	local Gauss = (C4Distance - 75.68) / 789.2 
	local flDamage = 450.7 * math.exp(-Gauss * Gauss);

		if Player:GetProp("m_ArmorValue") > 0 then

			local flArmorRatio = 0.5;
			local flArmorBonus = 0.5;

			if Player:GetProp("m_ArmorValue") > 0 then
			
				local flNew = flDamage * flArmorRatio;
				local flArmor = (flDamage - flNew) * flArmorBonus;
			 
				if flArmor > Player:GetProp("m_ArmorValue") then
				
					flArmor = Player:GetProp("m_ArmorValue") * (1 / flArmorBonus);
					flNew = flDamage - flArmor;
					
				end
			 
			flDamage = flNew;

			end

		end 
		
	return math.max(flDamage, 0);
	
end

client.AllowListener("bomb_planted")
client.AllowListener("bomb_begindefuse")
client.AllowListener("bomb_abortdefuse") 
client.AllowListener("bomb_exploded")
client.AllowListener("round_officially_ended")
client.AllowListener("bomb_defused") 


local Tab = gui.Tab(gui.Reference("Visuals"), "aa_t", "Carter's Bomb Timer");
local bt_x = gui.Editbox(Tab, "bt_x", "X")
local bt_y = gui.Editbox(Tab, "bt_y", "Y")

if tonumber(bt_x:GetValue()) == nil then bt_x:SetValue("30") end
if tonumber(bt_y:GetValue()) == nil then bt_y:SetValue("350") end
local function getX() if tonumber(bt_x:GetValue()) == nil then return 30 else return tonumber(bt_x:GetValue()) end end
local function getY() if tonumber(bt_y:GetValue()) == nil then return 350 else return tonumber(bt_y:GetValue()) end end

local FrmTimer = {
	Name = "FrmTimer",
	Interface = "Form",
	Size = size(125, 67),
	Location = point(getX(), getY()),
	MinimumSize = size(100, 80),
	MaximumSize = size(150, 80),
	DragBounds = 80,
	BorderStyle = "None", --None
	WinStyle = 10,
	Visible = true,
	BackColor = color(20,20,20,210),
	TitleBarColor = SystemColors.White,
	ForeColor = SystemColors.Black,
	BorderShadow = true,
	BorderShadowColor = color(40, 40, 40, 255),
	BorderShadowRadius = 10,
}

FrmTimer.Initialize = function()
	local pb_bomb = Toolbox.PictureBox()
	pb_bomb.Properties.Name = "pb_bomb"
	pb_bomb.Properties.Size = size(60,50)
	pb_bomb.Properties.Icon = "https://raw.githubusercontent.com/G-A-Development-Team/AA-Bomb-Timer/main/bomb3.png"
	pb_bomb.Properties.Location = point(-8, 0)
	
	local prog_bar = Toolbox.ProgressBar()
	prog_bar.Properties.Name = "prog_bomb"
	prog_bar.Properties.BorderColor = SystemColors.Transparent
	prog_bar.Properties.BackColor = SystemColors.Transparent
	prog_bar.Properties.Size = size(121 ,10)
	prog_bar.Properties.Value = 0
	prog_bar.Properties.Maximum = 40
	prog_bar.Properties.Location = point(2, 55)
	
	local prog_bar_defuse = Toolbox.ProgressBar()
	prog_bar_defuse.Properties.Name = "prog_bomb_defuse"
	prog_bar_defuse.Properties.BackColor = SystemColors.Transparent
	prog_bar_defuse.Properties.BorderColor = SystemColors.Transparent
	prog_bar_defuse.Properties.ValueColor = SystemColors.Blue
	prog_bar_defuse.Properties.Size = size(121 ,4)
	prog_bar_defuse.Properties.Value = 0
	prog_bar_defuse.Properties.Maximum = 1
	prog_bar_defuse.Properties.Location = point(2, 61)
	
	local lb_secs = Toolbox.Label()
	lb_secs.Properties.Name = "lb_bomb"
	lb_secs.Properties.Text = "0.0s"
	lb_secs.Properties.ForeColor = SystemColors.White
	lb_secs.Properties.Font.Name = "Bahnschrift"
	lb_secs.Properties.Font.Size = 17
	lb_secs.Properties.Location = point(38, -2)
	
	local lb_dmg = Toolbox.Label()
	lb_dmg.Properties.Name = "lb_dmg"
	lb_dmg.Properties.Text = "0 damage"
	lb_dmg.Properties.ForeColor = SystemColors.Grey
	lb_dmg.Properties.Font.Name = "Bahnschrift"
	lb_dmg.Properties.Font.Size = 15
	lb_dmg.Properties.Location = point(38, 15)
	
	return { pb_bomb, prog_bar, prog_bar_defuse, lb_secs, lb_dmg, }
end
FrmTimer = Application.Run(FrmTimer)

local timePlanted = 0 local defusing = false local ended = false

callbacks.Register("FireGameEvent", function(event)
	if event:GetName() == "bomb_planted" then timePlanted = globals.CurTime() ended = false end
	if event:GetName() == "bomb_begindefuse" then defusing = true ended = false end
	if event:GetName() == "bomb_abortdefuse" then defusing = false ended = false end
	if event:GetName() == "bomb_defused" then ended = true end
	if event:GetName() == "bomb_exploded" then ended = true end
	if event:GetName() == "round_officially_ended" then ended = true end
end)

callbacks.Register("Draw", function()
	if FrmTimer.Dragging then
		bt_x:SetValue(FrmTimer.Location.X)
		bt_y:SetValue(FrmTimer.Location.Y)
	else FrmTimer.Location = point(tonumber(bt_x:GetValue()), tonumber(bt_y:GetValue())) end

	FrmTimer.Visible = not ended
	
	if entities.FindByClass("CPlantedC4")[1] ~= nil then
		local Bomb = entities.FindByClass("CPlantedC4")[1];	
		local BombMath = ((globals.CurTime() - Bomb:GetProp("m_flC4Blow")) * (0 - 1)) / ((Bomb:GetProp("m_flC4Blow") - Bomb:GetProp("m_flTimerLength")) - Bomb:GetProp("m_flC4Blow")) + 1;
		local bombtimer = math.floor((timePlanted - globals.CurTime() + Bomb:GetProp("m_flTimerLength")) * 10) / 10
		
		FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb")].Properties.Value = bombtimer
		
		if bombtimer <= 0 then FrmTimer.Visible = false end
		
		if bombtimer <= 5 then FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb")].Properties.ValueColor = SystemColors.Red
		elseif bombtimer <= 10 then FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb")].Properties.ValueColor = SystemColors.Yellow
		else FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb")].Properties.ValueColor = SystemColors.Green end
		
		bombtimer = tostring(bombtimer)
		if not string.find(bombtimer, "%.") then bombtimer = bombtimer .. ".0" end
		
		FrmTimer.Controls[FrmTimer.Controls.Find("lb_bomb")].Properties.Text = bombtimer .. "s"
		
		local hpleft = math.floor(0.5 + BombDamage(Bomb, entities.GetLocalPlayer()))
		if hpleft >= entities.GetLocalPlayer():GetHealth() then
			FrmTimer.Controls[FrmTimer.Controls.Find("lb_dmg")].Properties.ForeColor = SystemColors.Red
			FrmTimer.Controls[FrmTimer.Controls.Find("lb_dmg")].Properties.Text = "Fatal"
		else
			FrmTimer.Controls[FrmTimer.Controls.Find("lb_dmg")].Properties.ForeColor = SystemColors.Grey
			FrmTimer.Controls[FrmTimer.Controls.Find("lb_dmg")].Properties.Text = tostring(hpleft) .. " damage"
		end
		if defusing then
			BombMath = ((globals.CurTime() - Bomb:GetProp("m_flDefuseCountDown")) * (0 - 1)) / ((Bomb:GetProp("m_flDefuseCountDown") - Bomb:GetProp("m_flDefuseLength")) - Bomb:GetProp("m_flDefuseCountDown")) + 1;
			FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb_defuse")].Properties.Value = BombMath
			
			bombtimer = math.floor((timePlanted - globals.CurTime() + Bomb:GetProp("m_flTimerLength")) * 10) / 10
			local defusetime = math.floor((Bomb:GetProp("m_flDefuseCountDown") - globals.CurTime()) * 10) / 10
			
			if bombtimer >= defusetime then
				FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb_defuse")].Properties.ValueColor = SystemColors.Blue
			else FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb_defuse")].Properties.ValueColor = SystemColors.Yellow end
			
		else FrmTimer.Controls[FrmTimer.Controls.Find("prog_bomb_defuse")].Properties.Value = 0 end
	else ended = true defusing = false timePlanted = 0 FrmTimer.Visible = false end end)



-- ***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")