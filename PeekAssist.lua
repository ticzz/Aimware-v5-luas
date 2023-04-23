local inverse = false;

local reference = gui.Reference("Ragebot", "Accuracy", "Movement");
local keybox = gui.Keybox(reference, "nex_peekassist", "PeekAssist", 0);

callbacks.Register("FireGameEvent", function(Event)
    if(Event:GetName() == "weapon_fire") then
        if(keybox:GetValue() ~= 0 and input.IsButtonDown(keybox:GetValue())) then
            local LocalPlayer = entities.GetLocalPlayer();
            
            if(LocalPlayer:GetIndex() == entities.GetByUserID(Event:GetInt("userid")):GetIndex()) then
                inverse = true;
            end
        end
    end
end)

callbacks.Register("CreateMove", function(CMD)
    if(keybox:GetValue() ~= 0 and input.IsButtonDown(keybox:GetValue())) then
        if(inverse) then

            local LocalPlayer = entities.GetLocalPlayer();
            local velocityX = LocalPlayer:GetPropFloat("localdata", "m_vecVelocity[0]");
            local velocityY = LocalPlayer:GetPropFloat("localdata", "m_vecVelocity[1]");
    
            local velocity = math.sqrt(velocityX^2 + velocityY^2);
            local FinalVelocity = tonumber(math.floor(math.min(9999, velocity) + 0.2));

            if(FinalVelocity >= 10) then
                if(cmd.sidemove() > 1) then
                   cmd.sidemove(-450);
                elseif(cmd.sidemove() < -1) then
                    cmd.sidemove(450);
                end
            else
                inverse = false;
            end
        end
    else
        inverse = false;
    end
end)













--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

