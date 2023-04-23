local Cache = {
    current_target = nil
}

local function UpdateTarget(entity)
    if entity:GetName() then
        Cache.current_target = entity
    else
        Cache.current_target = nil
    end
end

local function hDrawESP(builder)
    local builderentity = builder:GetEntity();
    if Cache.current_target and builderentity:GetIndex() == Cache.current_target:GetIndex() then
        builder:Color(255,0,0,255);
        builder:AddTextRight("T");
    end
end

callbacks.Register("AimbotTarget",UpdateTarget)
callbacks.Register("DrawESP", hDrawESP)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

