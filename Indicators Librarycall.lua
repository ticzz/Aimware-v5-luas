if not pcall(function() gui.GetValue("esp.tab_ind_opt") end) then
	local ind = http.Get("https://raw.githubusercontent.com/bean07/indicators-library/master/ind_lib.lua")
	local file = file.Open("ind_lib\\ind_lib.lua", "a")
	if file:Size() == 0 then
		file:Write(ind)
	end
	LoadScript("ind_lib\\ind_lib.lua")
end