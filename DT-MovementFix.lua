local weapon_dt = {"pistol", "smg", "rifle", "shotgun", "asniper", "lmg",};
local curr_dt, history = false, false;

callbacks.Register("CreateMove", "dt check", function()
    if weapon_dt[entities.GetLocalPlayer():GetWeaponType()] == nil then return; end;
    curr_dt = gui.GetValue("rbot.accuracy.weapon." .. weapon_dt[entities.GetLocalPlayer():GetWeaponType()] .. ".doublefire") ~= 0;
    if curr_dt == true then
        history = true;
        gui.SetValue("misc.fakelag.enable", 0);
    elseif curr_dt == false and history == true then
        if math.sqrt(entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[0]" )^2 + entities.GetLocalPlayer():GetPropFloat( "localdata", "m_vecVelocity[1]" )^2) == 0 then
            gui.SetValue("misc.fakelag.enable", 1);
            history = false;
        end;
    end;
end);