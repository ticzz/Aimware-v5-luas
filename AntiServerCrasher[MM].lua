---modified by Csmit195 for NiggaFish47
--Og credits to meeoww or his profile (https://aimware.net/forum/user/394521)
--OG thread https://aimware.net/forum/thread/153961

ffi.cdef[[
 typedef void*(__thiscall* getnetchannel_t)(void*); // engineclient 78
    typedef void(__thiscall* set_timeout_t)(void*, float, bool); // netchan 31

 typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
 void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]

local function GetInterface(dll_name, interface_name)
    local CreateInterface = ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(dll_name), "CreateInterface"));
    local interface = CreateInterface(interface_name, ffi.new("int*"));
    return interface;
end

local engineclient = ffi.cast(ffi.typeof("void***"), GetInterface("engine.dll", "VEngineClient014"));
local getnetchannel = ffi.cast("getnetchannel_t", engineclient[0][78]);

local netchannel = {}
do
    function vfunc_wrapper(type, index)
        return function(...)
            -- only did this for netchannel, you can probably extend it to make it a proper wrapper
            local netchannel = ffi.cast(ffi.typeof("void***"), getnetchannel(engineclient));
            local fn = ffi.cast(type, netchannel[0][index]);

            return fn(netchannel, ...);
        end
    end

    netchannel.set_timeout = vfunc_wrapper("void(__thiscall*)(void*, float, bool)", 31);
end

gui.Button(gui.Reference("Misc", "General", "Bypass"), "Anticrash", function()
    if not engine.GetServerIP() then return end;
    netchannel.set_timeout(3600, true);
end);

local function player_connect_full( Event )
    if ( Event:GetName() == 'player_connect_full' ) then
        netchannel.set_timeout(3600, true)
    end
end
 
client.AllowListener( 'player_connect_full' )

callbacks.Register( 'FireGameEvent', 'AWKS', player_connect_full )






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")