
ffi.cdef[[
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
]]

local function GetInterface(dll_name, interface_name) -- https://aimware.net/forum/thread/152462/
    local CreateInterface = ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(dll_name), "CreateInterface"));
    local interface = CreateInterface(interface_name, ffi.new("int*"));
    return interface;
end;

local console = ffi.cast(ffi.typeof('bool(__thiscall*)()'), ffi.cast(ffi.typeof('void***'), GetInterface("engine.dll", "VEngineClient014"))[0][11]);
local consoleMaterials = { "vgui_white", "vgui/hud/800corner1", "vgui/hud/800corner2", "vgui/hud/800corner3", "vgui/hud/800corner4"};
local reference = gui.Tab(gui.Reference("Visuals"), "localtab", "Helper");
local color = gui.ColorPicker( reference, "consolecolor", "Console Color", 255, 255, 255, 255 );
tempColor = 0;

local function changeColor( r, g, b, a, material )
    for key,mat in ipairs( material ) do
        local findedMat = materials.Find( mat );
        findedMat:ColorModulate( r/255, g/255, b/255 );
        findedMat:AlphaModulate( a/255 );
    end;
end;

local function Main()
    local r, g, b, a = color:GetValue();
    if console() then
        if ( tempColor ~= r..' '..g..' '..b..' '..a ) then
            changeColor( r, g, b, a, consoleMaterials );
            tempColor = r..' '..g..' '..b..' '..a;
        end
    else
        changeColor( 255, 255, 255, 255, consoleMaterials );
        tempColor = "0 0 0 0";
    end
end

local function Event( Event )
    if ( Event:GetName() == "game_newmap" ) then
        local r, g, b, a = color:GetValue();
        changeColor( r, g, b, a, consoleMaterials );
    end
end

callbacks.Register( "Unload", function()
    changeColor( 255, 255, 255, 255, consoleMaterials );
end )

callbacks.Register( 'FireGameEvent', Event );
callbacks.Register( "Draw", Main );





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")