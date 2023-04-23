local ThirdPersonRef = gui.Reference('Visuals','Local','Helper')

local FirstPersonOnGrenade = gui.Checkbox(ThirdPersonRef, 'ongrenade','First Person On Grenade',0)

local LocalChams = gui.GetValue('esp.chams.local.visible')

local ThirdPersonDist = gui.GetValue('esp.local.thirdpersondist')

client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', function(Event)
	if not gui.GetValue('esp.master') or not FirstPersonOnGrenade:GetValue() or Event:GetName() ~= 'item_equip' then
		return
    end
	
local LocalPlayerIndex = client.GetLocalPlayerIndex()
local PlayerIndex = client.GetPlayerIndexByUserID( Event:GetInt('userid') )
local WeaponType = Event:GetInt('weptype')


	if LocalPlayerIndex == PlayerIndex then
		if WeaponType == 9 then
			gui.SetValue('esp.local.thirdpersondist',0)
			gui.SetValue('esp.chams.local.visible' , 8)
		else
			gui.SetValue('esp.local.thirdpersondist',ThirdPersonDist)
			gui.SetValue('esp.chams.local.visible' ,LocalChams) 
		end	
	end
	
	if gui.GetValue('esp.chams.local.visible') ~= 8 and gui.GetValue('esp.chams.local.visible') ~=LocalChams then
		LocalChams = gui.GetValue('esp.chams.local.visible')
	end	
	
	if gui.GetValue('esp.local.thirdpersondist') ~= 0 and gui.GetValue('esp.local.thirdpersondist') ~= ThirdPersonDist then
		ThirdPersonDist = gui.GetValue('esp.local.thirdpersondist')
	end
	
end)






--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

