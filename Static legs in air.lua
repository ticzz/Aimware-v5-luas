
-- ported from another software by https://aimware.net/forum/user/250878

ffi.cdef[[
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);

    typedef struct
    {
        float x;
        float y;
        float z;
    } Vector;

    typedef struct
    {
        char        pad0[0x60]; // 0x00
        void*       pEntity; // 0x60
        void*       pActiveWeapon; // 0x64
        void*       pLastActiveWeapon; // 0x68
        float        flLastUpdateTime; // 0x6C
        int            iLastUpdateFrame; // 0x70
        float        flLastUpdateIncrement; // 0x74
        float        flEyeYaw; // 0x78
        float        flEyePitch; // 0x7C
        float        flGoalFeetYaw; // 0x80
        float        flLastFeetYaw; // 0x84
        float        flMoveYaw; // 0x88
        float        flLastMoveYaw; // 0x8C // changes when moving/jumping/hitting ground
        float        flLeanAmount; // 0x90
        char        pad1[0x4]; // 0x94
        float        flFeetCycle; // 0x98 0 to 1
        float        flMoveWeight; // 0x9C 0 to 1
        float        flMoveWeightSmoothed; // 0xA0
        float        flDuckAmount; // 0xA4
        float        flHitGroundCycle; // 0xA8
        float        flRecrouchWeight; // 0xAC
        Vector    vecOrigin; // 0xB0
        Vector    vecLastOrigin;// 0xBC
        Vector    vecVelocity; // 0xC8
        Vector    vecVelocityNormalized; // 0xD4
        Vector    vecVelocityNormalizedNonZero; // 0xE0
        float        flVelocityLenght2D; // 0xEC
        float        flJumpFallVelocity; // 0xF0
        float        flSpeedNormalized; // 0xF4 // clamped velocity from 0 to 1
        float        flRunningSpeed; // 0xF8
        float        flDuckingSpeed; // 0xFC
        float        flDurationMoving; // 0x100
        float        flDurationStill; // 0x104
        bool        bOnGround; // 0x108
        bool        bHitGroundAnimation; // 0x109
        char        pad2[0x2]; // 0x10A
        float        flNextLowerBodyYawUpdateTime; // 0x10C
        float        flDurationInAir; // 0x110
        float        flLeftGroundHeight; // 0x114
        float        flHitGroundWeight; // 0x118 // from 0 to 1, is 1 when standing
        float        flWalkToRunTransition; // 0x11C // from 0 to 1, doesnt change when walking or crouching, only running
        char        pad3[0x4]; // 0x120
        float        flAffectedFraction; // 0x124 // affected while jumping and running, or when just jumping, 0 to 1
        char        pad4[0x208]; // 0x128
        float        flMinBodyYaw; // 0x330
        float        flMaxBodyYaw; // 0x334
        float        flMinPitch; //0x338
        float        flMaxPitch; // 0x33C
        int            iAnimsetVersion; // 0x340
    } CCSGOPlayerAnimationState_534535_t;


    typedef void* (__cdecl* tCreateInterface)(const char* name, int* returnCode);
    void* GetProcAddress(void* hModule, const char* lpProcName);
    void* GetModuleHandleA(const char* lpModuleName);



]]
 

function mem.CreateInterface(module_name, interface_name)
    return ffi.cast("tCreateInterface", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(module_name), "CreateInterface"))(interface_name, ffi.new("int*"))
end



local entity_list_ptr = ffi.cast("void***", mem.CreateInterface("client.dll", "VClientEntityList003"))
local get_client_entity_fn = ffi.cast("GetClientEntity_4242425_t", entity_list_ptr[0][3])

local ffi_helpers = {
 
    get_entity_address = function(ent_index)
        local addr = get_client_entity_fn(entity_list_ptr, ent_index)
        return addr
    end
}


local shared_onground

 



 local offset_value = 0x9960
callbacks.Register( 'CreateMove', function() 

 local m_fFlags = entities.GetLocalPlayer():GetPropFloat('m_fFlags')
 local local_player = entities.GetLocalPlayer()
   
    if m_fFlags == nil then return end
    if not local_player then return end

    local bOnGround = bit.band(math.floor(m_fFlags), bit.lshift(1,0)) ~= 0

    if not bOnGround then
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(entities.GetLocalPlayer():GetIndex()) + offset_value)[0].flDurationInAir = 99
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(entities.GetLocalPlayer():GetIndex()) + offset_value)[0].flHitGroundCycle = 0
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(entities.GetLocalPlayer():GetIndex()) + offset_value)[0].bHitGroundAnimation = false
    end

    shared_onground = bOnGround

end )

callbacks.Register( 'CreateMove', function()
    if not local_player then return end
    if m_fFlags == nil then return end

    local bOnGround = bit.band(math.floor(m_fFlags), bit.lshift(1,0)) ~= 0
    if bOnGround and not shared_onground then 
        ffi.cast("CCSGOPlayerAnimationState_534535_t**", ffi_helpers.get_entity_address(entities.GetLocalPlayer():GetIndex()) + offset_value)[0].flDurationInAir = 0.5 
    end -- ACT_CSGO_LAND_LIGHT

end)

 





--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")