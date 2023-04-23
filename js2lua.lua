local panorama_RunScript = panorama.RunScript
local string_gmatch = string.gmatch
local table_insert = table.insert
local table_concat = table.concat
local table_remove = table.remove
local client_SetConVar = client.SetConVar
local client_GetConVar = client.GetConVar
local callbacks_Register = callbacks.Register

local JSON_stringify
local JSON_parse

local function split(text, separator)
    if not separator then separator = "%s" end
    local t = {}
    for str in string_gmatch(text, "([^" .. separator .. "]+)") do table_insert(t, str) end
    return t
end

local function generateReturnValues()
    local str = "returnValues={"
    for k, v in pairs(_G) do
        if type(v) == "table" and k ~= "_G" then
            str = str .. k .. ":{"
            for k2, v2 in pairs(v) do
                str = str .. k2 .. ":\"\","
            end
            str = str .. "},"
        end
    end
    return str ..[[_G:{Vector3: "", EulerAngles: "", print: ""}]] .. "}\n"
end

local function generateFunctions()
    local str = ""
    for k, v in pairs(_G) do
        if type(v) == "table" and k ~= "_G" and k ~= "callbacks" then
            str = str .. k .. "={"
            for k2, v2 in pairs(v) do
                str = str .. k2 .. ":function(){return basicFunc(\"" .. k .. "\",\"" .. k2 .. "\",arguments)},"
            end
            str = str .. "}\n"
        end
    end
    return str
end

local function loadModule()
    panorama_RunScript([[
        if (typeof js2lua == "undefined") {
            //js2lua = true;

            checkDelay = 0.001;

            GameInterfaceAPI.SetSettingString("r_eyesize", "");
            GameInterfaceAPI.SetSettingString("r_eyemove", "");
            GameInterfaceAPI.SetSettingString("r_eyegloss", "");
        
            ]] .. generateReturnValues() .. generateFunctions() .. [[
        
            callbackValues = {
                Draw: 0,
                DrawESP: 0,
                DrawModel: 0,
                CreateMove: 0,
                FireGameEvent: 0,
                DispatchUserMessage: 0,
                SendStringCmd: 0,
                AimbotTarget: 0,
                Unload: 0
            }
        
            callbacksCount = {
                Draw: 0,
                DrawESP: 0,
                DrawModel: 0,
                CreateMove: 0,
                FireGameEvent: 0,
                DispatchUserMessage: 0,
                SendStringCmd: 0,
                AimbotTarget: 0,
                Unload: 0
            }
        
            registeredCallbacks = {
                Draw: {},
                DrawESP: {},
                DrawModel: {},
                CreateMove: {},
                FireGameEvent: {},
                DispatchUserMessage: {},
                SendStringCmd: {},
                AimbotTarget: {},
                Unload: {}
            }
        
            callbacks = {
                Register: function(id, callback) {
                    registeredCallbacks[id][callbacksCount[id] ] = callback;
                    callbacksCount[id]++;

                    GameInterfaceAPI.SetSettingString("r_eyesize", `${GameInterfaceAPI.GetSettingString("r_eyesize")}${id}|`)
                },
                RegisterUnique: function(id, unique, callback) {
                    registeredCallbacks[id][unique] = callback;
                },
                Unregister: function(id, unique) {
                    delete registeredCallbacks[id][unique];
                }
            }
        
            methodReturnValues = {};

            normalizeArgs = function(args) {
                let str = "";
                args.forEach(element => {
                    switch (typeof element) {
                        case "string":
                            str += `"${element}",`;
                            break;
                        case "Object":
                            str += "{";

                            break;
                        default:
                            str += `${element},`;
                            break;
                    }
                })
                return str.slice(0, -1);
            }

            BaseClass = class {
                constructor(id) {
                    this.id = id;
                    return new Proxy(this, BaseClassHandler);
                }
            }

            BaseClassHandler = {
                get: function(target, prop, receiver) {
                    if (prop == "id") {
                        return Reflect.get(target, "id");
                    }

                    if (prop == "then" || prop == "toJSON") {
                        return;
                    }

                    return function() {
                        return basicObjectInteraction(Reflect.get(target, "id"), prop, arguments);
                    }
                },

                set: function(target, prop, value) {
                    basicObjectInteraction(Reflect.get(target, "id"), prop, [value]);
                }
            }

            resolveValue = function(value) {
                if (typeof value.id != "undefined") {
                    if (value.id == -1) {
                        return null;
                    } else {
                        return new BaseClass(value.id);
                    }
                }

                return value;
            }
        
            basicObjectInteraction = function(id, method, _args) {
                let args = Array.from(_args);
                //TODO: wait until can add
                GameInterfaceAPI.SetSettingString("r_eyegloss", `${GameInterfaceAPI.GetSettingString("r_eyegloss")}${id}|${method}|${normalizeArgs(args)} |`);
        
                return new Promise(resolve => {
                    $.Schedule(checkDelay, function check() {
                        let returnedValue = methodReturnValues[id];
                        if (typeof returnedValue == "undefined") {
                            $.Schedule(checkDelay, check);
                        } else {
                            delete methodReturnValues[id];
                            resolve(resolveValue(returnedValue));
                        }
                    });
                });
            }
        
            basicFunc = function(libName, funcName, _args) {
                let args = Array.from(_args);
                //TODO: wait until can add
                GameInterfaceAPI.SetSettingString("r_eyemove", `${GameInterfaceAPI.GetSettingString("r_eyemove")}${libName}|${funcName}|${normalizeArgs(args)} |`);

                return new Promise(resolve => {
                    $.Schedule(checkDelay, function check() {
                        let returnedValue = returnValues[libName][funcName];
                        if (returnedValue === "") {
                            $.Schedule(checkDelay, check);
                        } else {
                            returnValues[libName][funcName] = "";
        
                            resolve(resolveValue(returnedValue));
                        }
                    });
                });
            }

            Vector3 = function(x, y, z) {
                return basicFunc("_G", "Vector3", {x, y, z});
            }

            EulerAngles = function(pitch, yaw, roll) {
                return basicFunc("_G", "EulerAngles", {pitch, yaw, roll});
            }

            print = function() {
                return basicFunc("_G", "print", arguments);
            }
        }
    ]])
end

local objects = {}

local function makeObject(object)
    if type(object) == "userdata" then
        local id = #objects + 1
        objects[id] = object
        object = {id = id}
    end

    if type(object) == "table" then
        for i = 1, #object do
            if type(object[i]) == "userdata" then
                local id = #objects + 1
                objects[id] = object[i]
                object[i] = {id = id}
            end
        end
    end

    if not object then object = {id = -1} end

    return object
end

local function handleFunctionCalls()
    local requestPieces = split(client_GetConVar("r_eyemove"), "|")
    client_SetConVar("r_eyemove", "", true)
    
    for i = 0, #requestPieces, 3 do
        local library = requestPieces[i + 1]
        local func = requestPieces[i + 2]
        local args = requestPieces[i + 3]
        if not args then break end

        local returnedValue, r2, r3, r4 = loadstring("return " .. library .. "." .. func .. "(" .. args .. ")")()
        local encodedValue

        if not r2 then
            encodedValue = JSON_stringify(makeObject(returnedValue))
        else
            encodedValue = JSON_stringify({returnedValue, r2, r3, r4})
        end

        panorama_RunScript("returnValues." .. library .. "." .. func .. "=".. encodedValue)
    end
end

local function handleObjectInteraction()
    local requestPieces = split(client_GetConVar("r_eyegloss"), "|")
    client_SetConVar("r_eyegloss", "", true)

    for i = 0, #requestPieces, 3 do
        local id = requestPieces[i + 1]
        local numberId = tonumber(id)
        local prop = requestPieces[i + 2]
        local args = requestPieces[i + 3]
        if not args then break end

        local returnedValue, r2, r3, r4

        if type(objects[numberId][prop]) ~= "function" then
            if args == " " then
                returnedValue = objects[numberId][prop]
            else
                load("objects[" .. id .. "]." .. prop .. "=" .. args, "", "bt", {objects = objects})()
            end  
        else
            returnedValue, r2, r3, r4 = load("return objects[" .. id .. "]:" .. prop .. "(" .. args .. ")", "", "bt", {objects = objects})()
        end

        local encodedValue

        if not r2 then
            encodedValue = JSON_stringify(makeObject(returnedValue))
        else
            encodedValue = JSON_stringify({returnedValue, r2, r3, r4})
        end
        panorama_RunScript("methodReturnValues[" .. id  .. "] =".. encodedValue)
    end
end

local callbackRegistered = false
local registeredCallbacks = {}

local function handleCallback(callbackType, val)
    panorama_RunScript([[
        for ([unique, callback] of Object.entries(registeredCallbacks.]] .. callbackType .. [[)) {
            callback(new BaseClass(]] .. makeObject(val).id .. [[));
        }
    ]])

    handleFunctionCalls()
    handleObjectInteraction()
end

local function handleCallbackRegister()
    local requestPieces = split(client_GetConVar("r_eyesize"), "|")
    client_SetConVar("r_eyesize", "")

    for i = 1, #requestPieces do
        callbacks_Register(requestPieces[i], function(x) handleCallback(requestPieces[i], x) end)
    end
end

local function main()
    loadModule()

    callbacks_Register("Draw", function() 
        handleCallback("Draw") 
        handleCallbackRegister()
    end)

    callbacks_Register("Unload", function()
        handleCallback("Unload") 

        panorama_RunScript([[
            for ([k, v] of Object.entries(registeredCallbacks)) {
                registeredCallbacks[k] = {};
            }
        ]])
    end)
end

http.Get("https://raw.githubusercontent.com/stqcky/js2lua/main/json.lua", function(body) 
    local JSON = loadstring(body)()
    JSON_stringify = JSON.encode
    JSON_parse = JSON.decode
    main()
    js2lua.main()
end)