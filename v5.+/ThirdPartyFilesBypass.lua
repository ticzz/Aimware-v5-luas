local bypass_ref = gui.Reference("Misc", "General", "Bypass")
local bypass_check = gui.Checkbox(bypass_ref, "bypass_check", "Bypass Third Party Files", false)
bypass_check:SetDescription("Bypass third party files check")

-- stacky's code
ffi.cdef [[
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]

local function GetInterface(dll_name, interface_name)
    local CreateInterface = ffi.cast("tCreateInterface",
        ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(dll_name), "CreateInterface"))
    local interface = CreateInterface(interface_name, ffi.new("int*"))
    return interface
end

local function bypass()
    local fileSystem = ffi.cast("int*", GetInterface("filesystem_stdio.dll", "VFileSystem017"))
    fileSystem[56] = 1
end

callbacks.Register('Draw', function()
    if bypass_check:GetValue() then
        bypass()
		bypass_check:SetValue(0)
    end
end)

-- ***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")
