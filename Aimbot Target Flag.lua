local cache =
{
    current_target = nil;
}

local function UpdateTarget(entity)
    if entity:GetName() then
        cache.current_target = entity;
    else
        cache.current_target = nil;
    end
end

local function DrawESP(builder)
    local builderentity = builder:GetEntity();
    if cache.current_target and builderentity:GetIndex() == cache.current_target:GetIndex() then
        builder:Color(255, 0, 0, 255);
        builder:AddTextRight("T");
    else
        builder:Color(0, 0, 0, 0);
        builder:AddTextRight("");
    end
end

callbacks.Register("AimbotTarget", UpdateTarget)
callbacks.Register("DrawESP", DrawESP)


--############################################################--


print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")