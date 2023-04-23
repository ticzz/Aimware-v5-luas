local keybind = gui.Keybox(gui.Reference("Ragebot", "Anti-Aim", "Advanced"), "keybind", "Autodirection", 0); -- our keybind
local is_autodirecting = false; -- boolean to check whether we have our keybind toggled
local should_autodir = false; -- boolean to check if it's an optimal case to make autodirection work

local function freestanding()
    if not entities.GetLocalPlayer() then return end; -- check whether we're in a game

    if gui.GetValue("rbot.antiaim.advanced.keybind") == 0 then return end; -- check if our keybind ain't nil so it won't spam console

    local local_player = entities.GetLocalPlayer(); -- getting local player

    local players = entities.FindByClass("CCSPlayer"); -- getting all other players

    if input.IsButtonPressed(gui.GetValue("rbot.antiaim.advanced.keybind")) then -- autodirection toggle
        is_autodirecting = not is_autodirecting;
    end;

    if is_autodirecting then -- check if our keybind is toggled 
        if (bit.band(local_player:GetPropInt("m_fFlags"), 1) == 0) or cheat.IsFakeDucking() then -- checks for whether we are fakeducking or in air
            gui.SetValue("rbot.antiaim.advanced.autodir.targets", true);
            gui.SetValue("rbot.antiaim.advanced.autodir.edges", false);
        else
            for i, player in pairs(players) do -- loop through every player
                if player:GetTeamNumber() ~= local_player:GetTeamNumber() and player:IsPlayer() and player:IsAlive() then -- check if player is an enemy and is valid
                    local trace = engine.TraceLine(local_player:GetHitboxPosition(0), player:GetHitboxPosition(0), 0x46004003); -- trace from our head to enemy's head with shot mask
                    if trace ~= nil then -- check if trace is valid
                        if trace.fraction > 0.1 then -- check if enemy can hit our head, you can change the value though if you feel like it will perform better - the higher value the higher damage enemy can do
                            should_autodir = false;
                        else
                            should_autodir = true;
                        end;
                    end;

                    gui.SetValue("rbot.antiaim.advanced.autodir.targets", not should_autodir); -- turning at targets off in case we need to have at edges autodirection mode and vice versa
                    gui.SetValue("rbot.antiaim.advanced.autodir.edges", should_autodir); -- turning on/off at edges mode itself
                end;
            end;
        end;
    end;
end;

callbacks.Register("Draw", freestanding); -- callback, shall it be CreateMove instead? idk