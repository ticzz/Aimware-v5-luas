local helpers = {
    version = "2";
    link = "https://raw.githubusercontent.com/superyor/helpers/master/helpers.lua";
    versionLink = "https://raw.githubusercontent.com/superyor/helpers/master/version.txt";
    b64charset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
};

function helpers.b64encode(data)
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return helpers.b64charset:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function helpers.b64decode(data)
    data = string.gsub(data, '[^'..helpers.b64charset..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(helpers.b64charset:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function helpers.DecimalToHex(decimalNum)
    local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
    while decimalNum>0 do
        I=I+1
        decimalNum,D=math.floor(decimalNum/B),math.mod(decimalNum,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end

function helpers.StringToHex(string)
    local output = "";

    for letter in string.gmatch(string, "%a") do
        output = output .. string.format('%02X',string.byte(letter))
    end

    return output;
end

function helpers.xor(a,b)

    a = tonumber(a)
    b = tonumber(b)

    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
    return c
end

function helpers.toBits(num)
    local t={}
    while num>0 do
        rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end

	local bits = {}
	local lpad = 8 - #t
	if lpad > 0 then
		for c = 1,lpad do table.insert(bits,0) end
	end

	for i = #t,1,-1 do table.insert(bits,t[i]) end

    return table.concat(bits)
end

function helpers.toDec(bits)
	local bmap = {128,64,32,16,8,4,2,1}

	local bitt = {}
	for c in bits:gmatch(".") do table.insert(bitt,c) end

	local result = 0

	for i = 1,#bitt do
		if bitt[i] == "1" then result = result + bmap[i] end
	end

	return result
end

function helpers:crypt(str, key, inDecimalStringInput, inDecimalStringOutput)

    if inDecimalStringInput then
        local stringTable = {};

        for n in str:gmatch("%S+") do
            n = tonumber(n)
            stringTable[#stringTable+1] = string.char(n);
        end
        str = table.concat(stringTable)
    end

    local keys = {}
    for ch in key:gmatch(".") do

        local keyBits = {};
        local c = self.toBits(string.byte(ch))

        for b in c:gmatch(".") do
            keyBits[#keyBits+1] = b;
        end

        keys[#keys+1] = keyBits;
    end

	local block = {}
	for ch in str:gmatch(".") do
		local c = self.toBits(string.byte(ch))
		table.insert(block,c)
    end

    local cK = 1;

    if keys[1] == nil then
        return "Empty Key"
    end

	for i = 1,#block do
		local bitt = {}
        local bit = block[i]

        for c in bit:gmatch(".") do table.insert(bitt,c) end

        local result = {}

        for b in ipairs(bitt) do
            table.insert(result, self.xor(keys[cK][b], bitt[b]))
        end

        if not inDecimalStringOutput then
            block[i] = string.char(self.toDec(table.concat(result)))
        else
            block[i] = self.toDec(table.concat(result)) .. " "
        end

        if keys[cK+1] ~= nil then
            cK = cK + 1;
        else
            cK = 1;
        end
	end

	return table.concat(block)
end

local function updateCheck()
    if helpers.version ~= http.Get(helpers.versionLink) then
        local scriptName = GetScriptName()
        local script = file.Open("Modules\\Superyu\\helpers.lua", "w");
        newScript = http.Get(helpers.link)
        script:Write(newScript);
        script:Close()
        return false;
    else
        return true;
    end
end

if updateCheck() then
    return helpers;
else
    return "Updated";
end