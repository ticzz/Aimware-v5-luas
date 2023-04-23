local ref = gui.Tab(gui.Reference("Misc"), "Gaben mode", "Gaben mode");
local guiGmBlock = gui.Groupbox(ref, "Gaben mode", 16, 16, 250, 250);
local guiGodmode = gui.Checkbox(guiGmBlock, "Gaben power", "Gaben power", 0);
local last_send_command = 0;
local function on_create_move(cmd)
local localPlayer = entities.GetLocalPlayer();
    if not localPlayer or not guiGodmode:GetValue() then 
       return; 
    end
    local realtime = globals.RealTime();
    if realtime > last_send_command + 0.5 then
       client.Command("open_buymenu");
       last_send_command = realtime;
    end
    localPlayer:SetPropBool(true, "m_bGunGameImmunity");
end
callbacks.Register("CreateMove", on_create_move);

--Fixed by me, credits to @thesaykom






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

