ffi.cdef[[
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]

local function GetInterface(dll_name, interface_name)
    local CreateInterface = ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(dll_name), "CreateInterface"))
    local interface = CreateInterface(interface_name, ffi.new("int*"))
    return interface
end

local function main()
    local fileSystem = ffi.cast("int*", GetInterface("filesystem_stdio.dll", "VFileSystem017"))

    callbacks.Register("Draw", function() 
        fileSystem[56] = 1
    end)
end

main()



--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")