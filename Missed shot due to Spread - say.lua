local bez_reference = gui.Reference("MISC", "AUTOMATION", "Other")
local bez_checkbox_enable = gui.Checkbox(bez_reference, "bez_checkbox_enable", "missed shot chat say", false)

local gun_fired = false

local ern_other_weapons =
{
    "knife",
    "knife_t",
    "hegrenade",
    "smokegrenade",
    "molotov",
    "incgrenade",
    "flashbang",
    "decoy",
    "taser"
}

local ern_shots =
{
    fired = 0,
    hit = 0,
    missed = 0,
    hit_chance = 0,
    miss_chance = 0
}

local function reset_shots()

    for index, shot in pairs(ern_shots) do

        ern_shots[index] = 0

    end

end

local function is_gun(weapon_name)

    for index, weapon in ipairs(ern_other_weapons) do
       
        if(weapon_name == "weapon_"..weapon) then

            return false

        end

    end

    return true

end

local function update_shots(event)

    if( entities.GetLocalPlayer() == nil or not bez_checkbox_enable:GetValue() ) then

        reset_shots()

        return -1

    end

    local event_name = event:GetName()
   
    local local_player_index = client.GetLocalPlayerIndex()
    local local_player_info = client.GetPlayerInfo(local_player_index)


    

    if(event_name == "player_hurt") then

        local attacker_id = event:GetInt("attacker")
        local attacker_weapon = event:GetString("weapon")

        if( local_player_info["UserID"] == attacker_id and is_gun(attacker_weapon) and gun_fired) then

            ern_shots.hit = ern_shots.hit + 1
            gun_fired = false

        end
		
	elseif(event_name == "weapon_fire") then

        local player_id = event:GetInt("userid")
        local player_weapon = event:GetString("weapon")

        if(local_player_info["UserID"] == player_id and is_gun(player_weapon)) then

            ern_shots.fired = ern_shots.fired + 1
            gun_fired = true

        end
    elseif( event_name == "round_prestart") then

        reset_shots()

    end
end

local function main()
w, h = draw.GetScreenSize()

    if( entities.GetLocalPlayer() == nil or not bez_checkbox_enable:GetValue() ) then

        return -1

    end


    if(ern_shots.hit > 0) then

draw.TextShadow(50, 50, "[x22cheats.com] Missed shot due to spread")
print("Aimware: Hits bitchniggas ass")

    if(ern_shots.hit == 1 or ern_shots.missed == 1) then

ern_shots.hit = ern_shots.hit - 1

ern_shots.missed = ern_shots.fired - ern_shots.hit

if (ern_shots.missed > 0 or ern_shots.missed == 1) then

draw.TextShadow(50, 50, "[x22cheats.com] Missed shot due to spread")
print("Aimware: Failed on teabagged bitch")
  
ern_shots.fired = ern_shots.fired - 1
ern_shots.missed = ern_shots.missed - 1


                    end
              end
         end
end




client.AllowListener("weapon_fire")
client.AllowListener("player_hurt")
client.AllowListener("round_prestart")

callbacks.Register("FireGameEvent", update_shots)
callbacks.Register("Draw",  main)