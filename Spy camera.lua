--[[
    <meta name="author" content="giperfast">
    shit code prod.
]]--
Reference = gui.Tab(gui.Reference("Visuals"), "localtab", "Camera");
CAMBind = gui.Keybox(Reference, "cam.bind", "Camera Bind", 0);

function handler(cmd)
    GetViewAngles = cmd:GetViewAngles();
    if CAMBind:GetValue() and CAMBind:GetValue() > 0 and input.IsButtonDown(CAMBind:GetValue()) then
        client.Command("r_drawviewmodel 0");
        cmd.buttons = 0;
        cmd:SetForwardMove(0);
        cmd:SetSideMove(0);
        cmd:SetUpMove(0);
        cmd:SetViewAngles(backupAngles);
        engine.SetViewAngles(GetViewAngles);
        backupAnglesEngine = backupAngles;
        toggle = true;
    else
        if toggle then
            cmd:SetViewAngles(backupAngles);
            engine.SetViewAngles(backupAnglesEngine);
            toggle = false;
        end
        if backupAngles ~= GetViewAngles then
            backupAngles = GetViewAngles;
        end
        client.Command("r_drawviewmodel 1");
    end
end

callbacks.Register("CreateMove", "handler", handler);









--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

