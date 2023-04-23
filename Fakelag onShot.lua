----    Base    code    for    auto    updating.
--
--local    cS    =    GetScriptName()
--local    cV    =    '1.0.0'
--local    gS    =    'PUT    LINK    TO    RAW    LUA    SCRIPT'
--local    gV    =    'PUT    LINK    TO    RAW    VERSION'
--
--local    function    AutoUpdate()
--	if    gui.GetValue('lua_allow_http')    and    gui.GetValue('lua_allow_cfg')    then
--		local    nV    =    http.Get(gV)
--		if    cV    ~=    nV    then
--			local    nF    =    http.Get(gS)
--			local    cF    =    file.Open(cS,    'w')
--			cF:Write(nF)
--			cF:Close()
--			print(cS,    'updated    from',    cV,    'to',    nV)
--		else
--			print(cS,    'is    up-to-date.')
--		end
--	end
--end		
--
--callbacks.Register('Draw',    'Auto    Update')
--callbacks.Unregister('Draw',    'Auto    Update')


local cb = gui.Checkbox( gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "rbot.antiaim.flonshot", "Fakelag on Shot", 0 )
local flslid = gui.Slider(gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "rbot.antiaim.flticks", "Amount of Ticks", 0, 1, 64 )
local mb = gui.Multibox( gui.Reference( "Ragebot", "Anti-Aim", "Condition" ), "Exclude weapons from onshot" )
local onshotmelee = gui.Checkbox( mb, "rbot.antiaim.onshotmelee", "Melee", 0 )
local onshotgrenades = gui.Checkbox( mb, "rbot.antiaim.onshotnades", "Grenades", 0 )
local onshotrevolver = gui.Checkbox( mb, "rbot.antiaim.onshotr8", "Revolver", 0 )
local onshotauto = gui.Checkbox( mb, "rbot.antiaim.onshotauto", "Auto", 0 )
local onshotawp = gui.Checkbox( mb, "rbot.antiaim.onshotawp", "AWP", 0 )
local onshotscout = gui.Checkbox( mb, "rbot.antiaim.onshotscout", "Scout", 0 )
local onshotpistols = gui.Checkbox( mb, "rbot.antiaim.onshotpistols", "Pistols", 0 )
local lp = entities.GetLocalPlayer()
local aftershot = {}

callbacks.Register( 'CreateMove', function(cmd)
    if lp == nil or not cb:GetValue() then return
    else
    if lp:GetWeaponType() == 0 and onshotmelee:GetValue() or lp:GetWeaponType() == 9 and onshotgrenades:GetValue() or lp:GetWeaponID() == 64 and onshotrevolver:GetValue() or lp:GetWeaponID() == 38 and onshotauto:GetValue() or lp:GetWeaponID() == 11 and onshotauto:GetValue() or lp:GetWeaponID() == 9 and onshotawp:GetValue() or lp:GetWeaponID() == 40 and onshotscout:GetValue() or lp:GetWeaponType() == 1 and onshotpistols:GetValue() then return end

    local IN_ATTACK = bit.lshift(1, 0)
    local IN_ATTACK2 = bit.lshift(1, 11)
    if bit.band(cmd.buttons, IN_ATTACK) == IN_ATTACK then
        table.insert(aftershot, globals.CurTime())
        ticks = globals.TickCount()
        if aftershot <= globals.CurTime() then
        cmd:SetSendPacket(false)
        table.remove(aftershot, 1)
    end
end
end

    if ticks + flslid:GetValue() > globals.TickCount() - 5 then
        cmd:SetSendPacket(false)
    end
end)