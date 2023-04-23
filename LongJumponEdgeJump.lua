local main_font = draw.CreateFont("Verdana", 26);
local combo = gui.Combobox(gui.Reference( "MISC","Movement", "Jump"), 'msc_edgejump_vars','Long Jump Type','Normal', 'LJ Bind -forward', 'LJ Bind -back', 'LJ Bind -moveleft', 'LJ Bind -moveright')
local ljbind = gui.Checkbox(gui.Reference( "MISC","Movement", "Jump"), "lj_bind", "LJ Bind Edge Jump", true);
ljbind:SetDescription("Allows you to jump further with one unit extra height.")
local ui_checkbox = gui.Checkbox(gui.Reference( "Visuals", "Other", "Extra"), "lj_bind_status", "LJ Bind Status", false);

local edgejump = gui.GetValue("misc.edgejump");
callbacks.Register("CreateMove", function(cmd)
    
    if (ljbind:GetValue() ~= true) then
        return
    end
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
    
    local onground = bit.band(flags, 1) ~= 0

    
    if (not onground and input.IsButtonDown(edgejump)) then
        cmd:SetButtons( 86 )
        if (combo:GetValue() == 0) then
            return;
        end
            if (combo:GetValue() == 1) then
                client.Command("-forward", true)
                end
                
            if (combo:GetValue() == 2) then
                client.Command("-back", true)
                end
            if (combo:GetValue() == 3) then
                client.Command("-moveright", true)
                end
            if (combo:GetValue() == 4) then
                client.Command("-moveleft", true)
                end
        return
    end

end)

callbacks.Register("Draw", function()

    local x, y = draw.GetScreenSize( )
    local centerX = x / 2

    local lp = entities.GetLocalPlayer(); -- Get our local entity and check if its `nil`, If it's nil lets abort from here
        local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end

    local onground = bit.band(flags, 1) ~= 0

    draw.SetFont(main_font)
        if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
            draw.Color(255, 255, 255, 255)
            draw.Text( centerX , y - 150, "lj")
        end
    if (onground) then return end
    if  edgejump ~= 0 and input.IsButtonDown(edgejump)  then
    draw.Color(30, 255, 109)
    draw.Text( centerX , y - 150, "lj")
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

