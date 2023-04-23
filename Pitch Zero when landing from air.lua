delay = 0
jump_delay = 0
toggle = false
togglePitch = false
function PitchOnGround(cmd)
    local localPlayer = entities.GetLocalPlayer() -- Getting a Local Player
    local OnGround = bit.band(localPlayer:GetPropInt("m_fFlags"), 1) ~= 0 -- getting the status flag
    if OnGround then -- checking where the local player is located (in the air or on the ground)
        if toggle then -- if we were in the air
            if (globals.TickCount() - jump_delay > 5) then -- we are waiting for 5 ticks
                togglePitch = true -- we allow you to turn off pitch
                jump_delay = globals.TickCount();  -- so let's say clean delays
            end
            if togglePitch then -- if we were in the air and waited for 5 ticks after landing
                gui.SetValue('rbot.antiaim.advanced.pitch', 0) -- turning off the pitch
            end
            if (globals.TickCount() - delay > 70) then -- we lower the pitch after 70 ticks
                toggle = false
                togglePitch = false
                delay = globals.TickCount(); -- so let's say clean delays
            end
        else
            gui.SetValue('rbot.antiaim.advanced.pitch', 1) -- if we were not in the air, we set the pitch to 89 degrees
        end
    else -- if we are in the air
        gui.SetValue('rbot.antiaim.advanced.pitch', 1) -- we put the pitch at 89 degrees
        jump_delay = globals.TickCount(); -- so let's say clean delays
        delay = globals.TickCount(); -- so let's say clean delays
        toggle = true -- we keep the information that we were in the air
    end
end

callbacks.Register("CreateMove", PitchOnGround)









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

