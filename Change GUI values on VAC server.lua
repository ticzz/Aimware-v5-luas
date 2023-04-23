local GetServerIP, SetValue = engine.GetServerIP, gui.SetValue
local set_0 = false

local vars = {
    'rab_autobuy_masterswitch',
    'lua_fakelag_moving',
    'lua_fakelag_inair',
}

local function applyServerID()
local server_ip = GetServerIP()

  if (engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then

    if not server_ip:find('A:') then
		return
else
        if not set_0 then
            for i=1, #vars do SetValue(vars[i], 0) end
            set_0 = true
        
    elseif set_0 then
            for i=1, #vars do SetValue(vars[i], 1) end
            set_0 = false
        end end end
    end
end

callbacks.Register('Draw', applyServerID)