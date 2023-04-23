local ui_key, cache_baim, reset = gui.Keybox(gui.Reference("Ragebot", "Hitscan", "Mode"), "bodyaimkey", "Force Bodyaim On Key", 0), {}, true;
local wep_list = {"pistol", "hpistol", "smg", "rifle", "shotgun", "scout", "asniper", "sniper", "lmg",};

callbacks.Register("Draw", function()
    local key = ui_key:GetValue();
    if key == 0 or key == nil then return; end;
    if reset == true then
        for i = 1, 9 do
            cache_baim[i] = gui.GetValue(string.format("rbot.hitscan.mode.%s.bodyaim", wep_list[i]));
        end;
    end;
    if input.IsButtonDown(key) then
        for i = 1, 9 do
            gui.SetValue(string.format("rbot.hitscan.mode.%s.bodyaim", wep_list[i]), 1);
        end;
        reset = false;
    elseif reset == false then
        for i = 1, 9 do
            gui.SetValue(string.format("rbot.hitscan.mode.%s.bodyaim", wep_list[i]), cache_baim[i]);
        end;
        reset = true;
    end;
end);