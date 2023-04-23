local GUI = {}

GUI.Reference = gui.Tab(gui.Reference("Visuals"), "localtab", "Camera")
GUI.FreeCamToggle = gui.Checkbox(GUI.Reference, "freecam.toggle", "Free Cam Enable", false); GUI.FreeCamToggle:SetDescription("Enable free cam.")
GUI.ColorPicker = gui.ColorPicker(GUI.FreeCamToggle, "freecam.textcolor", "Free Text Color", 222, 222, 222, 222 )
GUI.FreeCamSpeed = gui.Slider(GUI.Reference, "freecam.speed", "Free Cam Speed", 10, 1, 30 ); GUI.FreeCamSpeed:SetDescription("Speed of the free cam.")


ffi.cdef[[
    void* GetProcAddress(void*, const char*);
    void* GetModuleHandleA(const char*);
    bool VirtualProtect(void*, intptr_t, unsigned long, unsigned long*);

    typedef void* (*GetInterfaceFn)();
    typedef struct {
        GetInterfaceFn Interface;
        char* InterfaceName;
        void* NextInterface;
    } CInterface;

    typedef struct { float x, y, z; } Vector3;

    typedef struct
    {
        int   x;                  //0x0000 
        int   x_old;              //0x0004 
        int   y;                  //0x0008 
        int   y_old;              //0x000C 
        int   width;              //0x0010 
        int   width_old;          //0x0014 
        int   height;             //0x0018 
        int   height_old;         //0x001C 
        char      pad_0x0020[0x90];   //0x0020
        float     fov;                //0x00B0 
        float     viewmodel_fov;      //0x00B4 
        Vector3    origin;             //0x00B8 
        Vector3    angles;             //0x00C4 
        char      pad_0x00D0[0x7C];   //0x00D0

    } CViewSetup;
]]


mem.CreateInterface = function(module, interfaceName)
    local pCreateInterface = ffi.cast("int", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(module), "CreateInterface"))
    local interface = ffi.cast("CInterface***", pCreateInterface + ffi.cast("int*", pCreateInterface + 5)[0] + 15)[0][0]

    while interface ~= ffi.NULL do
        if string.sub(ffi.string(interface.InterfaceName), 0, -4) == interfaceName then return interface.Interface() end
        interface = ffi.cast("CInterface*", interface.NextInterface)
    end

    return 0
end


local VMTHookManager = {}

function VMTHookManager:New(base)
    assert(base and base ~= ffi.NULL)
    return setmetatable({base = ffi.cast("void***", base), orig = {}}, {__index = self})
end

function VMTHookManager:HookMethod(index, func)
    self.orig[index] = self:_ReplaceMethodPtr(index, func)
end

function VMTHookManager:GetOriginal(index, typestring)
    return ffi.cast(ffi.typeof(typestring), self.orig[index])
end

function VMTHookManager:UnhookMethod(index)
    assert(self.orig[index])
    self:_ReplaceMethodPtr(index, self:GetOriginal(index, "void*"))
end

function VMTHookManager:_ReplaceMethodPtr(index, func)
    assert(self.base and self.base ~= ffi.NULL)
    assert(index > 0)
    assert(func and func ~= ffi.NULL)

    local prevFunc = self.base[0][index]

    local oldProtection = ffi.new("int[1]", 0)
    ffi.C.VirtualProtect(self.base[0] + index, 4, 0x40, oldProtection)
    self.base[0][index] = ffi.cast("void*", func)
    ffi.C.VirtualProtect(self.base[0] + index, 4, oldProtection[0], oldProtection)

    return prevFunc
end


local function vectorAdd(vector, other)
    vector.x = vector.x + other.x
    vector.y = vector.y + other.y
    vector.z = vector.z + other.z
end

local function vectorSub(vector, other)
    vector.x = vector.x - other.x
    vector.y = vector.y - other.y
    vector.z = vector.z - other.z
end


local IN_DUCK      = bit.lshift(1, 2)
local IN_FORWARD   = bit.lshift(1, 3)
local IN_BACK      = bit.lshift(1, 4)
local IN_MOVELEFT  = bit.lshift(1, 9)
local IN_MOVERIGHT = bit.lshift(1, 10)
local IN_SPEED     = bit.lshift(1, 17)
local KEY_SPACE    = 32

local prevStrafe = gui.GetValue("misc.strafe.enable")
local prevThirdperson = gui.GetValue("esp.local.thirdperson")


local FreeCam = {
    oOverrideView = nil,
    clientModeHook = nil,
    oldCmdViewAngles = nil,
    oldEngineViewAngles = nil,
    freeCamOrigin = ffi.new("Vector3"),
    enabled = false
}

FreeCam.hkOverrideView = function(this, edx, view)
    FreeCam.oOverrideView(this, view)

    if FreeCam.enabled then
        view.origin = FreeCam.freeCamOrigin
    else
        FreeCam.freeCamOrigin.x = view.origin.x
        FreeCam.freeCamOrigin.y = view.origin.y
        FreeCam.freeCamOrigin.z = view.origin.z
    end
end

function FreeCam:HookClientMode()
    local ClientMode = ffi.cast("void***", ffi.cast("int**", mem.CreateInterface("client.dll", "VClient"))[0][10] + 0x5)[0][0]
    self.clientModeHook = VMTHookManager:New(ClientMode)
end

function FreeCam:HookOverrideView()
    self.clientModeHook:HookMethod(18, ffi.cast("void(__fastcall*)(void*, void*, CViewSetup*)", self.hkOverrideView))
    self.oOverrideView = self.clientModeHook:GetOriginal(18, "void(__thiscall*)(void*, CViewSetup*)")
end

function FreeCam:OnCreateMove(cmd)
    if self.enabled then
        local angles = engine.GetViewAngles()
        local speed = GUI.FreeCamSpeed:GetValue()

        if bit.band(cmd.buttons, IN_SPEED) == IN_SPEED then speed = speed * 1.75 end

        if bit.band(cmd.buttons, IN_FORWARD) == IN_FORWARD then vectorAdd(self.freeCamOrigin, angles:Forward() * speed) end
        if bit.band(cmd.buttons, IN_BACK) == IN_BACK then vectorSub(self.freeCamOrigin, angles:Forward() * speed) end

        if bit.band(cmd.buttons, IN_MOVERIGHT) == IN_MOVERIGHT then vectorAdd(self.freeCamOrigin, angles:Right() * speed) end
        if bit.band(cmd.buttons, IN_MOVELEFT) == IN_MOVELEFT then vectorSub(self.freeCamOrigin, angles:Right() * speed) end

        if bit.band(cmd.buttons, IN_DUCK) == IN_DUCK then self.freeCamOrigin.z = self.freeCamOrigin.z - speed end
        if input.IsButtonDown(KEY_SPACE) then self.freeCamOrigin.z = self.freeCamOrigin.z + speed end

        cmd.buttons = 0
        cmd.forwardmove = 0
        cmd.sidemove = 0
        cmd.upmove = 0
        cmd.viewangles = self.oldCmdViewAngles
    else
        self.oldEngineViewAngles = engine.GetViewAngles()
        if cmd.sendpacket then
            self.oldCmdViewAngles = cmd.viewangles
        end
    end
end

function FreeCam:OnUnload()
    self.clientModeHook:UnhookMethod(18)
end


local function main()
    FreeCam:HookClientMode()
    FreeCam:HookOverrideView()
end

callbacks.Register("CreateMove", function(cmd)
    FreeCam:OnCreateMove(cmd)
end)

callbacks.Register("Draw", function()
    if GUI.FreeCamToggle:GetValue() then
        draw.Color( GUI.ColorPicker:GetValue() )
        draw.TextShadow( 10, 10, "FreeCam activated" )
        if not FreeCam.enabled then
            FreeCam.enabled = true

            prevStrafe = gui.GetValue("misc.strafe.enable")
            gui.SetValue("misc.strafe.enable", false)

            prevThirdperson = gui.GetValue("esp.local.thirdperson")
            gui.SetValue("esp.local.thirdperson", true)
        end
    else
        if FreeCam.enabled then
            FreeCam.enabled = false

            gui.SetValue("misc.strafe.enable", prevStrafe)
            gui.SetValue("esp.local.thirdperson", prevThirdperson)

            engine.SetViewAngles(FreeCam.oldEngineViewAngles)
        end
    end
end)

callbacks.Register("Unload", function() 
    FreeCam:OnUnload()
end)

main()



--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")