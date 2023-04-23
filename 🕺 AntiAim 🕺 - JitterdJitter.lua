local ref = gui.Reference("Ragebot", "Anti-Aim", "Advanced")
local check = gui.Checkbox( ref, "checkkk", "Jitter Master", 0)
local yawcheck = gui.Checkbox( ref, "yaw.jit", "Yaw Jitter", 0)
local edgey = gui.Checkbox( ref, "yaw.jit", "Edge Yaw Jitter", 0)
local slider = gui.Slider( ref, "jitter.slid","Jitter", 11, 0, 58, 1 )
local edgeslid = gui.Slider( ref, "edge.jitter.slid","Edge Jitter", 11, 0, 58, 1 )
local remslid = gui.Slider( ref, "remove","Remove/Add", 0, -58, 58, 1 )
local eremslid = gui.Slider( ref, "eremove","Edge Remove", 0, 0, 58, 1 )
local inv = 0
local GetLocalPlayer = entities.GetLocalPlayer

local lp = GetLocalPlayer()
--local weapon = lp:GetPropEntity('m_hActiveWeapon')
--local weaponID = weapon:GetWeaponID()

local weapon = weapon ~= nil and weapon:GetClass() ~= nil 

local function autozeus()
	

   local lp = entities.GetLocalPlayer();
    if (lp == nil or lp:IsAlive() ~= true) then return end
	
	weapon = lp:GetPropEntity('m_hActiveWeapon')
    weaponID = weapon:GetWeaponID()
    if weaponID == 31 or weaponID == 508 then
       gui.SetValue( "misc.fakelag.type", 1)
       gui.SetValue( "misc.fakelag.factor", 15)
    else
        gui.SetValue( "misc.fakelag.type", 0)
        gui.SetValue( "misc.fakelag.factor", 11)
    end
end

local function jitterdjitter()
    edgeslidval = gui.GetValue("rbot.antiaim.advanced.edge.jitter.slid")
    slidval = gui.GetValue("rbot.antiaim.advanced.jitter.slid")
    remove = gui.GetValue("rbot.antiaim.advanced.remove")
    eremove = gui.GetValue("rbot.antiaim.advanced.eremove")
    if check:GetValue() and inv == 0 then
        gui.SetValue( "rbot.antiaim.base.lby", -slidval)
        if yawcheck:GetValue() then gui.SetValue( "rbot.antiaim.base", 180 - slidval + remove) end
        gui.SetValue( "rbot.antiaim.left.rotation", edgeslidval)
        gui.SetValue( "rbot.antiaim.left.lby", -edgeslidval)
        if edgey:GetValue() then gui.SetValue( "rbot.antiaim.left", 165 - edgeslidval + eremove) end
        gui.SetValue( "rbot.antiaim.right.rotation", edgeslidval)
        gui.SetValue( "rbot.antiaim.right.lby", -edgeslidval)
        if edgey:GetValue() then gui.SetValue( "rbot.antiaim.right", -165 + edgeslidval - eremove) end
        inv = 1
    elseif check:GetValue() and inv == 1 then
        if yawcheck:GetValue() then gui.SetValue( "rbot.antiaim.base", -180 + slidval - remove) end
        gui.SetValue( "rbot.antiaim.base.lby", slidval)
        gui.SetValue( "rbot.antiaim.left.rotation", -edgeslidval)
        gui.SetValue( "rbot.antiaim.right.lby", edgeslidval)
        gui.SetValue( "rbot.antiaim.right.lby", edgeslidval)
        gui.SetValue( "rbot.antiaim.left.lby", edgeslidval)
        if edgey:GetValue() then gui.SetValue( "rbot.antiaim.left",  165 - edgeslidval*2 + eremove) end
        gui.SetValue( "rbot.antiaim.right.rotation", -edgeslidval)
        if edgey:GetValue() then gui.SetValue( "rbot.antiaim.right", edgeslidval*2 + -165 - eremove ) end
        inv = 0
    end
    if check:GetValue() and gui.GetValue("rbot.antiaim.base.rotation") > 0 then gui.SetValue( "rbot.antiaim.base.rotation", -slidval) else gui.SetValue( "rbot.antiaim.base.rotation", slidval) end
    if not yawcheck:GetValue() then gui.SetValue( "rbot.antiaim.base", 180) end
    if not edgey:GetValue() then gui.SetValue( "rbot.antiaim.left", 165) end
    if not edgey:GetValue() then gui.SetValue( "rbot.antiaim.right", -165) end
end


callbacks.Register( "Draw", jitterdjitter)
callbacks.Register("Draw", autozeus)











--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

