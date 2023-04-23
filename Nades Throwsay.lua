local all_says = {
    hegrenade = {
        'Catch retard!',
		'Here, a hot Portato!'
    },

    flashbang = {
        'Look a bird!',
		'3, 2, 1, Cheeeese'
    },

    molotov = {
        'BURN BABY BURN!!!',
		'Barbecue Time'
    },

    smokegrenade = {
        'I am a ninja',
		'Hide and seek, just wait, i´m comin'
    },

    incgrenade = {
        'BURN BABY BURN!!!',
		'Barbecue Time'
    },
	
	decoy = {
		'Time to pFake'
	}
}

local function throw_say(e)
    if e:GetName() ~= 'grenade_thrown' then
        return
    end

    if client.GetPlayerIndexByUserID(e:GetInt('userid')) ~= client.GetLocalPlayerIndex() then
        return
    end

    local says = all_says[e:GetString('weapon')]
    client.ChatSay( says[math.random(#says)] )
end

client.AllowListener('grenade_thrown')
callbacks.Register('FireGameEvent', throw_say)







--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

