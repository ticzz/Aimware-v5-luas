local last_a, last_d = 0
callbacks.Register("CreateMove", function(cmd)
    local flags = entities.GetLocalPlayer():GetPropInt("m_fFlags")
    if flags == nil then return end
      
    if (input.IsButtonDown(65) and input.IsButtonDown(68)) then
        if(last_a ~= nil and last_d ~= nil) then
            if(last_d < last_a) then
                cmd.sidemove = 450
            elseif(last_d > last_a) then
                cmd.sidemove = -450
            end
        end
        return
    end
   
    if (input.IsButtonDown(65)) then
        last_a = globals.CurTime()
    end

    if (input.IsButtonDown(68)) then
        last_d = globals.CurTime()
    end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

