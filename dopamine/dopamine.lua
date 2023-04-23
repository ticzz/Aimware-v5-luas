-- dopamine - external aimware framework extender. made using lua, c++ and love :)
-- This product is using GNU GPL version 3 license.

if dopamine then
    return -- avoid calling again
end

-- json library (minified)
-- original: https://github.com/rxi/json.lua
local json={_version="0.1.1"}local a;local b={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local c={["\\/"]="/"}for d,e in pairs(b)do c[e]=d end;local function f(g)return b[g]or string.format("\\u%04x",g:byte())end;local function h(i)return"null"end;local function j(i,k)local l={}k=k or{}if k[i]then error("circular reference")end;k[i]=true;if i[1]~=nil or next(i)==nil then local m=0;for d in pairs(i)do if type(d)~="number"then error("invalid table: mixed or invalid key types")end;m=m+1 end;if m~=#i then error("invalid table: sparse array")end;for n,e in ipairs(i)do table.insert(l,a(e,k))end;k[i]=nil;return"["..table.concat(l,",").."]"else for d,e in pairs(i)do if type(d)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(l,a(d,k)..":"..a(e,k))end;k[i]=nil;return"{"..table.concat(l,",").."}"end end;local function o(i)return'"'..i:gsub('[%z\1-\31\\"]',f)..'"'end;local function p(i)if i~=i or i<=-math.huge or i>=math.huge then error("unexpected number value '"..tostring(i).."'")end;return string.format("%.14g",i)end;local q={["nil"]=h,["table"]=j,["string"]=o,["number"]=p,["boolean"]=tostring}a=function(i,k)local r=type(i)local s=q[r]if s then return s(i,k)end;error("unexpected type '"..r.."'")end;function json.encode(i)return a(i)end;local t;local function u(...)local l={}for n=1,select("#",...)do l[select(n,...)]=true end;return l end;local v=u(" ","\t","\r","\n")local w=u(" ","\t","\r","\n","]","}",",")local x=u("\\","/",'"',"b","f","n","r","t","u")local y=u("true","false","null")local z={["true"]=true,["false"]=false,["null"]=nil}local function A(B,C,D,E)for n=C,#B do if D[B:sub(n,n)]~=E then return n end end;return#B+1 end;local function F(B,C,G)local H=1;local I=1;for n=1,C-1 do I=I+1;if B:sub(n,n)=="\n"then H=H+1;I=1 end end;error(string.format("%s at line %d col %d",G,H,I))end;local function J(m)local s=math.floor;if m<=0x7f then return string.char(m)elseif m<=0x7ff then return string.char(s(m/64)+192,m%64+128)elseif m<=0xffff then return string.char(s(m/4096)+224,s(m%4096/64)+128,m%64+128)elseif m<=0x10ffff then return string.char(s(m/262144)+240,s(m%262144/4096)+128,s(m%4096/64)+128,m%64+128)end;error(string.format("invalid unicode codepoint '%x'",m))end;local function K(L)local M=tonumber(L:sub(3,6),16)local N=tonumber(L:sub(9,12),16)if N then return J((M-0xd800)*0x400+N-0xdc00+0x10000)else return J(M)end end;local function O(B,n)local P=false;local Q=false;local R=false;local S;for T=n+1,#B do local U=B:byte(T)if U<32 then F(B,T,"control character in string")end;if S==92 then if U==117 then local V=B:sub(T+1,T+5)if not V:find("%x%x%x%x")then F(B,T,"invalid unicode escape in string")end;if V:find("^[dD][89aAbB]")then Q=true else P=true end else local g=string.char(U)if not x[g]then F(B,T,"invalid escape char '"..g.."' in string")end;R=true end;S=nil elseif U==34 then local L=B:sub(n+1,T-1)if Q then L=L:gsub("\\u[dD][89aAbB]..\\u....",K)end;if P then L=L:gsub("\\u....",K)end;if R then L=L:gsub("\\.",c)end;return L,T+1 else S=U end end;F(B,n,"expected closing quote for string")end;local function W(B,n)local U=A(B,n,w)local L=B:sub(n,U-1)local m=tonumber(L)if not m then F(B,n,"invalid number '"..L.."'")end;return m,U end;local function X(B,n)local U=A(B,n,w)local Y=B:sub(n,U-1)if not y[Y]then F(B,n,"invalid literal '"..Y.."'")end;return z[Y],U end;local function Z(B,n)local l={}local m=1;n=n+1;while 1 do local U;n=A(B,n,v,true)if B:sub(n,n)=="]"then n=n+1;break end;U,n=t(B,n)l[m]=U;m=m+1;n=A(B,n,v,true)local _=B:sub(n,n)n=n+1;if _=="]"then break end;if _~=","then F(B,n,"expected ']' or ','")end end;return l,n end;local function a0(B,n)local l={}n=n+1;while 1 do local a1,i;n=A(B,n,v,true)if B:sub(n,n)=="}"then n=n+1;break end;if B:sub(n,n)~='"'then F(B,n,"expected string for key")end;a1,n=t(B,n)n=A(B,n,v,true)if B:sub(n,n)~=":"then F(B,n,"expected ':' after key")end;n=A(B,n+1,v,true)i,n=t(B,n)l[a1]=i;n=A(B,n,v,true)local _=B:sub(n,n)n=n+1;if _=="}"then break end;if _~=","then F(B,n,"expected '}' or ','")end end;return l,n end;local a2={['"']=O,["0"]=W,["1"]=W,["2"]=W,["3"]=W,["4"]=W,["5"]=W,["6"]=W,["7"]=W,["8"]=W,["9"]=W,["-"]=W,["t"]=X,["f"]=X,["n"]=X,["["]=Z,["{"]=a0}t=function(B,C)local _=B:sub(C,C)local s=a2[_]if s then return s(B,C)end;F(B,C,"unexpected character '".._.."'")end;function json.decode(B)if type(B)~="string"then error("expected argument of type string, got "..type(B))end;local l,C=t(B,A(B,1,v,true))C=A(B,C,v,true)if C<=#B then F(B,C,"trailing garbage")end;return l end;

local charset = {} do
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

local function random_string(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return random_string(length - 1) .. charset[math.random(1, #charset)]
end

local function d_log(prefix, text)
    print("[DOPAMINE] [" .. prefix:upper() .. "] " .. text) -- todo: file log
end

local preinit_complete = false
local init_complete = false
local queue = {}

local api_fwrite = nil
local api_fread = nil

local old_content = nil

local function api_init()
    api_fwrite = file.Open("comm.txt", "w")
    api_fwrite:Write("ping")
    api_fwrite:Close()

    api_fread = file.Open("out.txt", "wr")
    api_fread:Write("")
    api_fread:Close()
    
    preinit_complete = true
end

local function api_uninit()
    api_fread:Close()
    api_fwrite:Close()
end

local function api_read()
    if not preinit_complete then
        return
    end

    api_fread = file.Open("out.txt", "r")

    local content = api_fread:Read()
    api_fread:Close()

    if content == "" or content == old_content then return end

    if init_complete then
        local return_data = {}

        for part in content:gmatch("%w+") do
            table.insert(return_data, part)
        end

        if not queue[return_data[1]] then
            return -- it probably has been already done
        end

        queue[return_data[1]](return_data[2])
        queue[return_data[1]] = nil
    end

    if content:find("pong") and not init_complete then
        init_complete = true

        api_fread = file.Open("out.txt", "w")
        api_fread:Write("")
        api_fread:Close()

        api_fwrite = file.Open("comm.txt", "w")
        api_fwrite:Write("")
        api_fwrite:Close()

        client.Command("play ui\\mm_success_lets_roll", true) -- :)
        d_log("info", "Communication established.")
    end

    old_content = content
end

local function api_call(func, callback, ...)
    if not init_complete then
        d_log("error", "Communication is not established yet.")
        return "ERROR_NOCOMM"
    end
    
    local queue_id = random_string(8)
    local api_info = queue_id .. " " .. func .. " " .. json.encode({ ... })
    
    queue[queue_id] = callback
    
    api_fwrite = file.Open("comm.txt", "w")
    api_fwrite:Write(api_info)
    api_fwrite:Close()

    return "ERROR_NONE"
end

callbacks.Register("Draw", "dopamine_read", api_read)

dopamine = {
    available = function()
        return init_complete
    end,

    set_clan_tag = function(tag, callback)
        return api_call("set_clan_tag", (callback or function() end), tag)
    end
}

api_init()
d_log("info", "Connecting, please inject dll now.")
