__author__ = "LeoDeveloper"
__version__ = "1.1.0"
-- requires my playerlist: https://github.com/Le0Developer/playerlist / https://aimware.net/forum/thread/136526
RunScript('PList.lua');

callbacks.Register("CreateMove", function(cmd)
	local lp = entities.GetLocalPlayer()
	for _, player in ipairs( entities.FindByClass("CCSPlayer") ) do
		if player:GetTeamNumber() ~= lp:GetTeamNumber() and player:IsAlive()  then
			plist.GetByIndex( player:GetIndex() ).set( "resolver.type", 2 ) -- 2 = manual
			plist.GetByIndex( player:GetIndex() ).set( "resolver.lby_override", math.random(-58, 58) )
		end
	end
end)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

