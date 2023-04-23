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


local refff = gui.Reference("RAGEBOT", "ACCURACY", "Movement")
local enable = gui.Checkbox(refff, "lua.rbot.accuracy.movement.slowspeed.chkbox", "Activate SlowWalkSpeed per Weapon", 0)
local ref = gui.Groupbox(refff, "AutoSlowWalkSpeed per Weapon")

local pistol = gui.Slider(ref, "slowspeed.pistol", "Pistol Auto Stop Speed", 30, 0, 30)
local heavypistol = gui.Slider(ref, "slowspeed.heavypistol", "Heavy Pistol Auto Stop Speed", 30, 0, 30)
local submachine = gui.Slider(ref, "slowspeed.submachineGun", "Submachine Gun Auto Stop Speed", 30, 0, 30)
local rifle = gui.Slider(ref, "slowspeed.rifle", "Rifle Auto Stop Speed", 30, 0, 30)
local shotgun = gui.Slider(ref, "slowspeed.shotgun", "Shotgun Auto Stop Speed", 30, 0, 30)
local scout = gui.Slider(ref, "slowspeed.scout", "Scout Auto Stop Speed", 30, 0, 30)
local autosniper = gui.Slider(ref, "slowspeed.autosniper", "Autosniper Auto Stop Speed", 30, 0, 30)
local awp = gui.Slider(ref, "slowspeed.awp", "AWP Auto Stop Speed", 30, 0, 30)
local light = gui.Slider(ref, "slowspeed.light", "Light Machine Gun Auto Stop Speed", 30, 0, 30)
local zeus = gui.Slider(ref, "slowspeed.zeus", "Zeus Auto Stop Speed", 30, 0, 30)

local function activationCheck()
    if not enable:GetValue() then
            ref:SetInvisible(true);
			ref:SetDisabled(true);
        else
            ref:SetInvisible(false);
			ref:SetDisabled(false)
    end
end

local value
local set = 0
local setweapon

local function slowspeed()
if(entities.GetLocalPlayer() ~= nil and engine.GetServerIP() ~= nil and engine.GetMapName() ~= nil) then
    local activeweapon = entities.GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
    local weapon = activeweapon:GetWeaponType()

    if setweapon ~= tostring(activeweapon) then
        set = 0
    end

    if set == 0 then
        set = 1
        setweapon = tostring(activeweapon)
        if tostring(activeweapon) == "weapon_taser" then
            value = zeus:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 1 then
        if tostring(activeweapon) == "weapon_revolver" or tostring(activeweapon) == "weapon_deagle" then
            value = heavypistol:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        else
            value = pistol:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        end
        elseif weapon == 2 then
            value = submachine:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 3 then
            value = rifle:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 4 then
            value = shotgun:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        elseif weapon == 5 then
            if tostring(activeweapon) == "weapon_ssg08" then
                value = scout:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            elseif tostring(activeweapon) == "weapon_awp" then
                value = awp:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            elseif tostring(activeweapon) == "weapon_g3sg1" or tostring(activeweapon) == "weapon_scar20" then  
                value = autosniper:GetValue()
                gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
            end
        elseif weapon == 6 then
            value = light:GetValue()
            gui.SetValue( "rbot.accuracy.movement.slowspeed", value )
        end
    end
end
end

callbacks.Register("Draw", slowspeed)
callbacks.Register("Draw", activationCheck );

