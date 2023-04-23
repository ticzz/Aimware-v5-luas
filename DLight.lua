ffi.cdef [[
    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);
]]

function mem.CreateInterface(module_name, interface_name)
    return ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(module_name), "CreateInterface"))(interface_name, ffi.new("int*"))
end

ffi.cdef [[
    typedef struct
    {
        unsigned char r, g, b;
        signed char exponent;
    } ColorRGBExp32;

    typedef struct
    {
        float x;
        float y;
        float z;
    } vec3_t;

    typedef struct
    {
        int    flags;
        vec3_t  origin;
        float  radius;
        ColorRGBExp32  color;
        float  die;
        float  decay;
        float  minlight;
        int    key;
        int    style;
        vec3_t  m_Direction;
        float  m_InnerAngle;
        float  m_OuterAngle;
    } dlight_t, *dlight_ptr_t;

    typedef dlight_ptr_t(__thiscall* alloc_dlight_t)(void*, int);
    typedef dlight_ptr_t(__thiscall* alloc_elight_t)(void*, int);
    typedef dlight_ptr_t(__thiscall* get_elight_by_key_t)(void*, int);
]]

local engine_effects = mem.CreateInterface("engine.dll", "VEngineEffects001")
local engine_effects_class = ffi.cast(ffi.typeof("void***"), engine_effects)
local engine_effects_vtbl = engine_effects_class[0]

local ref = gui.Reference("Visuals", "Other", "Effects");

local cores = gui.ColorPicker(ref, "cores", "Neon Color", 0,0,0,0)

local alloc_dlight = ffi.cast("alloc_dlight_t", engine_effects_vtbl[4])
local alloc_elight = ffi.cast("alloc_elight_t", engine_effects_vtbl[5])
local get_elight_by_key = ffi.cast("get_elight_by_key_t", engine_effects_vtbl[8])

callbacks.Register(
    "Draw",
    function()
        local lp = entities.GetLocalPlayer()

    local AutoPeekKey=gui.GetValue("rbot.accuracy.movement.autopeekkey")

        if not lp then
            return
        end


        local r,g,b,a = cores:GetValue();
        local idx = lp:GetIndex()

        local origin = lp:GetAbsOrigin()
        local pos = {origin.x, origin.y, origin.z}

        local dlight = alloc_dlight(engine_effects_class, idx)

      if input.IsButtonDown( AutoPeekKey ) then

        dlight.flags = 0x2
        dlight.style = 0x0
        dlight.key = idx
        dlight.radius = 0x12c
        dlight.decay = 0x1
        dlight.origin = pos
        dlight.m_Direction = pos
        dlight.die = globals.CurTime() + 0.1 
        dlight.color.r = r
        dlight.color.g = g
        dlight.color.b = b
        dlight.color.exponent = 0x5
end
    end
)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

