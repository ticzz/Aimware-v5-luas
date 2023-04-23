local ref = gui.Reference("Ragebot", "Accuracy", "Weapon")
local enable = gui.Checkbox(ref, "lua_damge_behind_wall_chkbox", "Activate AutoMinDamage on in-/visible", 0)
local ref2 = gui.Groupbox(ref, "AutoMinDamage due to Walls")
local weapon_list = { "asniper", "sniper", "scout", "hpistol", "pistol", "rifle" }

local rbot_autosniper_mindamage_2 = gui.Slider(ref2, weapon_list[1] .. ".mindmg.2", "Damage Visible(auto)", 0, 0, 100);
local rbot_autosniper_mindamage_1 = gui.Slider(ref2, weapon_list[1] .. ".mindmg.1", "Damage behind Wall(auto)", 0, 0, 100);

local rbot_sniper_mindamage_2 = gui.Slider(ref2, weapon_list[2] .. ".mindmg.2", "Damage Visible(awp)", 0, 0, 100);
local rbot_sniper_mindamage_1 = gui.Slider(ref2, weapon_list[2] .. ".mindmg.1", "Damage behind Wall(awp)", 0, 0, 100);

local rbot_scout_mindamage_2 = gui.Slider(ref2, weapon_list[3] .. ".mindmg.2", "Damage Visible(scout)", 0, 0, 100);
local rbot_scout_mindamage_1 = gui.Slider(ref2, weapon_list[3] .. ".mindmg.1", "Damage behind Wall(scout)", 0, 0, 100);

local rbot_revolver_mindamage_2 = gui.Slider(ref2, weapon_list[4] .. ".mindmg.2", "Damage Visible(R8)", 0, 0, 100);
local rbot_revolver_mindamage_1 = gui.Slider(ref2, weapon_list[4] .. ".mindmg.1", "Damage behind Wall(R8)", 0, 0, 100);

local rbot_pistol_mindamage_2 = gui.Slider(ref2, weapon_list[5] .. ".mindmg.2", "Damage Visible(pistol)", 0, 0, 100);
local rbot_pistol_mindamage_1 = gui.Slider(ref2, weapon_list[5] .. ".mindmg.1", "Damage behind Wall(pistol)", 0, 0, 100);

local rbot_rifle_mindamage_2 = gui.Slider(ref2, weapon_list[6] .. ".mindmg.2", "Damage Visible(rifle)", 0, 0, 100);
local rbot_rifle_mindamage_1 = gui.Slider(ref2, weapon_list[6] .. ".mindmg.1", "Damage behind Wall(rifle)", 0, 0, 100);

local function activationCheck()
    if not enable:GetValue() then
            ref2:SetInvisible(true);
			ref2:SetDisabled(true);
        else
            ref2:SetInvisible(false);
			ref2:SetDisabled(false)
    end
end

local adaptive_weapons = {
    -- see line 219
    ["asniper.mindmg"] = { 11, 38 },
    ["sniper.mindmg"] = { 9 },
    ["scout.mindmg"] = { 40 },
    ["hpistol.mindmg"] = { 64, 1 },
    ["pistol.mindmg"] = { 2, 3, 4, 30, 32, 36, 61, 63 },
    ["rifle.mindmg"] = { 7, 8, 10, 13, 16, 39, 60 },
    ["false"] = {},
}

local vars = {
    -- see line 219
    [rbot_autosniper_mindamage_2] = { 11, 38 },
    [rbot_sniper_mindamage_2] = { 9 },
    [rbot_scout_mindamage_2] = { 40 },
    [rbot_revolver_mindamage_2] = { 64, 1 },
    [rbot_pistol_mindamage_2] = { 2, 3, 4, 30, 32, 36, 61, 63 },
    [rbot_rifle_mindamage_2] = { 7, 8, 10, 13, 16, 39, 60 },
    [false] = {},
}

local vars_2 = {
    -- see line 219
    [rbot_autosniper_mindamage_1] = { 11, 38 },
    [rbot_sniper_mindamage_1] = { 9 },
    [rbot_scout_mindamage_1] = { 40 },
    [rbot_revolver_mindamage_1] = { 64, 1 },
    [rbot_pistol_mindamage_1] = { 2, 3, 4, 30, 32, 36, 61, 63 },
    [rbot_rifle_mindamage_1] = { 7, 8, 10, 13, 16, 39, 60 },
    [false] = {},
}

local function table_contains(table, item)
    for i = 1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end


local function find_key(value) 
    for k, v in pairs(adaptive_weapons) do
        if table_contains(v, value) then
            return k
        end
    end
end

local function set_vis(value)
    for k, v in pairs(vars) do
        if table_contains(v, value) then
            if k ~= false then
                k:SetInvisible(false)
            end
        else
            if k ~= false then
                k:SetInvisible(true)
            end
        end
    end
    for k, v in pairs(vars_2) do
        if table_contains(v, value) then
            if k ~= false then
              k:SetInvisible(false)
            end
        else
            if k ~= false then
                k:SetInvisible(true)
            end
        end
    end
end

local function entities_check()
    local LocalPlayer = entities.GetLocalPlayer();
    local Player
    if LocalPlayer ~= nil then
        Player = LocalPlayer:GetAbsOrigin()
        if (math.floor((entities.GetLocalPlayer():GetPropInt("m_fFlags") % 4) / 2) == 1) then
            z = 46
        else
            z = 64
        end
        Player.z = Player.z + LocalPlayer:GetPropVector("localdata", "m_vecViewOffset[0]").z
        return Player, LocalPlayer
    end
end

local function is_vis(LocalPlayerPos)
    local is_vis = false
    local players = entities.FindByClass("CCSPlayer")
    local fps = 4
    for i, player in pairs(players) do
        if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() and player:IsPlayer() and entities_check() ~= nil and player:IsAlive() then
            for i = 0, 4 do
                for x = 0, fps do
                    local v = player:GetHitboxPosition(i)

                    if x == 0 then
                        v.x = v.x
                        v.y = v.y
                    elseif x == 1 then
                        v.x = v.x
                        v.y = v.y + 4
                    elseif x == 2 then
                        v.x = v.x
                        v.y = v.y - 4
                    elseif x == 3 then
                        v.x = v.x + 4
                        v.y = v.y
                    elseif x == 4 then
                        v.x = v.x - 4
                        v.y = v.y
                    end

                    local c = (engine.TraceLine(LocalPlayerPos, v, 0x1)).contents
                    if c == 0 then
                        is_vis = true
                        break
                    end
                end
            end
        end
    end
    return is_vis
end

callbacks.Register("Draw", function()
    
if (enable:GetValue() == false) then
        return;
    end

local Player, LocalPlayer = entities_check()
    if LocalPlayer then
        local weapon = LocalPlayer:GetWeaponID()
        local slider = find_key(weapon) --finding mindamage var  ["asniper.mindmg"] = { 11, 38 },
        set_vis(weapon)
        if slider ~= nil then
            local slider_invis = ("rbot.accuracy.weapon." .. slider .. ".1") -- getting the var name of the check boxes/sliders
            local slider_vis = ("rbot.accuracy.weapon." .. slider .. ".2")
            if slider ~= false then -- makes sure only support weapon is selected
                if is_vis(Player) then
                    local damage = gui.GetValue(slider_vis) --setting damage
                    gui.SetValue("rbot.accuracy.weapon." .. slider, damage)
                else
                    local damage = gui.GetValue(slider_invis)
                    gui.SetValue("rbot.accuracy.weapon." .. slider, damage)
                end
            end
        end
    end
end)

callbacks.Register( "Draw", activationCheck );