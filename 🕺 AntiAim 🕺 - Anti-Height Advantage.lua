-- Original script by JohnK. (https://aimware.net/forum/thread/129673)
local ref = gui.Reference( "Ragebot","Anti-Aim","Advanced")
local checkbox = gui.Checkbox( ref, "hidehead", "Anti-Height Advantage", false )
checkbox:SetDescription( "Hides head from players with height advantage")

	local base_old = gui.GetValue("rbot.antiaim.base")
	local base_left = gui.GetValue("rbot.antiaim.left")
	local base_right = gui.GetValue("rbot.antiaim.right")


local function get_closed_enemy(players)
 
    if not checkbox:GetValue() then 
        return
    end

    local pos
    local min = math.huge
    local nearest
    for i, player in pairs(players) do
        if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then 
         
         local pos = player:GetAbsOrigin()
         if pos == nil then 
             return 
         end

            local lenght = (pos-entities.GetLocalPlayer():GetAbsOrigin()):Length()
            if lenght < min then 
                min = lenght
                nearest = player
            end
        end
     end
     return nearest
end

local function get_distance(entity1,entity2)
    local abs2 = entity2:GetAbsOrigin()
    local abs1 = entity1:GetAbsOrigin()
  return ((abs2-abs1):Length()),abs1.z,abs2.z
end


callbacks.Register("CreateMove", function (cmd)    
    
    if not checkbox:GetValue() then 
        return
    end
	
    local players = entities.FindByClass("CCSPlayer")
    local closet_enemy = get_closed_enemy(players) 
    local distance,pPosZ,posZ = get_distance(entities.GetLocalPlayer(),get_closed_enemy(players))

	if posZ +10 > pPosZ and (math.abs(posZ-pPosZ))^1.05 > distance then 
        gui.SetValue("rbot.antiaim.base",0,"Desync")
        gui.SetValue("rbot.antiaim.left", 40.0, "Desync")
        gui.SetValue("rbot.antiaim.right", -40.0, "Desync")
    else
        gui.SetValue("rbot.antiaim.base", base_old,"Desync") 
        gui.SetValue("rbot.antiaim.left", base_left, "Desync")
        gui.SetValue("rbot.antiaim.right", base_right, "Desync")
    end
end)








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

