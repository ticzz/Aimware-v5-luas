local hitHeader, missHeader
--[[
    YOU CAN CUSTOMIZE MESSAGES MORE HERE
]]
local function formatHitMessage(name, damage, hitbox, remaining) 
    local msg = string.format("%s %s damage to %s %s (%s hp left) ", hitHeader:GetValue(), damage, name, hitbox, remaining)
    return msg
end

local function formatMissMessage(name, remaining) 
    local msg = string.format("%s missed %s (%s hp left) ", missHeader:GetValue(), name, remaining)
    return msg
end
--[[
    DONT TOUCH ANYTHING PAST HERE
]]

-- making sure you have notify stuff and loading it
local installed = false
file.Enumerate(function(filename)
    if filename == "Libraries/Scape_Notify.txt" then
        installed = true;
    end;
end)

if not installed then
    file.Write("Libraries/Scape_Notify.txt", http.Get("https://raw.githubusercontent.com/lennonc1atwit/Luas/master/Notify/Core.lua"));
end

local res = file.Open("Libraries/Scape_Notify.txt", "r") 
local buf = res:Read()
res:Close()
load(buf, "Libraries/Scape_Notify")()
  
--[[
    Gui Fun
]]
local sv_maxusrcmdprocessticks = gui.Reference("Misc", "General", "Server", "sv_maxusrcmdprocessticks")
local ref = gui.Tab(gui.Reference("Visuals"), "shotlogs", "Shot Logs")

local logSettingsGroup = gui.Groupbox( ref, "Settings", 16, 16, 296)
    local logOptions = gui.Multibox( logSettingsGroup, "Logs")
        local logHits = gui.Checkbox( logOptions, "hit.enable", "Hits", true)
            local hitColor = gui.ColorPicker( logHits, "logs.color.hit", "Hit", 0, 255, 0, 255)
        local logMiss = gui.Checkbox( logOptions, "miss.enable", "Misses", true )
            local missColor = gui.ColorPicker( logMiss, "logs.color.miss", "Miss", 255, 0, 0, 255)
        local logOther = gui.Checkbox( logOptions, "other.enable", "Other", true )
            local otherColor = gui.ColorPicker( logOther, "logs.color.other", "Other", 255, 255, 0, 255)

    
    local logFlags = gui.Multibox( logSettingsGroup, "Flags")
    local flagOptions  = {
        spread = gui.Checkbox( logFlags, "flags.spread", "Spread", true),
        weapon = gui.Checkbox( logFlags, "flags.weapon", "Weapon", true),
        target = gui.Checkbox( logFlags, "flags.target", "Target", true)
    }
    
    hitHeader = gui.Editbox( logSettingsGroup, "hit.header", "hit header" )
    missHeader = gui.Editbox( logSettingsGroup, "miss.header", "miss header" )

    local notifiyDuration = gui.Slider( logSettingsGroup, "logs.duration", "Log Duration", 8, 0, 16, 0.5)
    local notifyConsole = gui.Checkbox( logSettingsGroup, "logs.console", "Console", true)

local logFontGroup = gui.Groupbox( ref, "Font Settings", 32 + 296, 16, 296)
    local fontSize = gui.Slider( logFontGroup, "logs.font.size", "Font size", 14, 10, 24)
    local fontName = gui.Editbox( logFontGroup, "logs.font.name", "Font Name" )
    local w, h = draw.GetScreenSize()
    local xPos = gui.Slider( logFontGroup, "logs.y", "X position", 8, 0, w )
    local yPos = gui.Slider( logFontGroup, "logs.x", "Y position", 5, 0, h )

fontName:SetValue("tomah")
hitHeader:SetValue("[HURT] ")
missHeader:SetValue("[MISS] ")

local applySettings = gui.Button(logFontGroup, "Apply Settings", function()
    PushNotifySettings(notifiyDuration:GetValue(), fontName:GetValue(), fontSize:GetValue(), 501, xPos:GetValue(), yPos:GetValue())
    AddToNotify({r = 255, g = 255, b = 255, a = 255}, "Font Settings Updated", false)
end )
--[[
    Important script vars 
]]
local local_player = entities.GetLocalPlayer()

local Hit_Groups = {"GENERIC", "HEAD", "CHEST", "STOMACH", "LEFT ARM", "RIGHT ARM", "LEFT LEG", "RIGHT LEG", "NECK"}

local Cache = {
    current_target = nil,
    mouse_pressed = false,
    weapon_name = "",
    bullet_impact = {},
    player_hurt = {},
    view_angles = {
        [1] = nil,
        [2] = nil
    }
}

local Event_Table = {}
--[[ 
    Helpers
]]
local function ClearCache()
    Cache.weapon_name = ""
    Cache.bullet_impact = {}
    Cache.player_hurt = {}
    Cache.mouse_pressed = false
end

local function IsGrenade(weapon_name)
    for i, str in ipairs({"grenade", "flash", "decoy", "molotov", "mine", "charge"}) do
        if string.find(weapon_name, str) then return true end
    end

    return false
end

local function CalculateSpread(view_angles, src, dst)
    local dst_wish = src + view_angles:Forward() * 1000
    
    local AB = src - dst
    local AC = src - dst_wish
    
    local deg = math.deg(math.acos(AB:Dot(AC) / (AB:Length() * AC:Length())))
    
    return deg
end

local function DisplayShot(shot)
    local msg = "nil"
    local r, g, b, a
    local hit_target = false

    -- Handle flag options
    local flag_table = {}
    for k ,obj in pairs(flagOptions) do 
        if obj:GetValue() then
            table.insert(flag_table, string.format( "%s: %s",k, tostring(shot[k])))
        end
    end

    -- log each hit in path and mark unintended ones as yellow
    if logOther:GetValue() or logHits:GetValue() then
        for i, hurt in ipairs(shot.hurts) do 
            local hurt_name = entities.GetByIndex( hurt.index ):GetName()
            local hurt_where = Hit_Groups[hurt.hitgroup]

            -- select color based on who we aimed at and who we hit
            if shot.target:GetIndex() == hurt.index and logHits:GetValue() then
                r, g, b, a = hitColor:GetValue()
            elseif logOther:GetValue() then
                r, g, b, a = otherColor:GetValue()
            end

            -- keep track if we hit target so we can log a miss is we hit someone else but not target
            hit_target = shot.target:GetIndex() == hurt.index or hit_target

            msg = formatHitMessage(hurt_name, hurt.damage, hurt_where, hurt.health) 
            
            if r then
                AddToNotify({r=r,g=g,b=b,a=a}, msg.."Flags: ["..table.concat(flag_table, " | ").."]", notifyConsole:GetValue())
            end
            
        end
    end

    -- if we didnt hit target
    -- or it was a manual shot
    if logMiss:GetValue() and (shot.type == "aimbot" and shot.target and not hit_target) then 
        msg = formatMissMessage(shot.target:GetName(), shot.target:GetHealth()) 
        
        r, g, b, a = missColor:GetValue()
        AddToNotify({r=r,g=g,b=b,a=a}, msg.."Flags: ["..table.concat(flag_table, " | ").."]", notifyConsole:GetValue())
    end
end
--[[
    Events
]]
Event_Table['weapon_fire'] = function(weapon_fire)
    local player_index = entities.GetByUserID(weapon_fire:GetInt("userid")):GetIndex()

    if player_index ~= local_player:GetIndex() then return end

    local weapon = string.gsub(weapon_fire:GetString("weapon"), "weapon_", "")
    local eye_pos = local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]")

    table.insert(Cache.bullet_impact, eye_pos)

    Cache.weapon_name = weapon
end

Event_Table["bullet_impact"] = function(bullet_impact)
    local player_index = entities.GetByUserID(bullet_impact:GetInt("userid")):GetIndex()

    if player_index ~= local_player:GetIndex() then return end

    local x = bullet_impact:GetFloat("x")
    local y = bullet_impact:GetFloat("y")
    local z = bullet_impact:GetFloat("z")

    local position = Vector3(x,y,z)

    table.insert(Cache.bullet_impact, position)
end

Event_Table["player_hurt"] = function(player_hurt)
    local attacker_index = entities.GetByUserID(player_hurt:GetInt("attacker")):GetIndex()

    -- we are not attacker
    if attacker_index ~= local_player:GetIndex() then return end

    local victim = entities.GetByUserID(player_hurt:GetInt("userid"))
	local victim_index = victim:GetIndex()

    local _damage = player_hurt:GetInt("dmg_health")
    local _health = player_hurt:GetInt("health")
    local _hitgroup = player_hurt:GetInt("hitgroup") + 1

    -- anything but grenade and knife
    if _hitgroup ~= 1  or Cache.weapon_name == "taser" then
        table.insert(Cache.player_hurt, {damage = _damage, health = _health, hitgroup = _hitgroup, index = victim_index})
        return
    end

    -- nades and knife fix
    local msg = formatHitMessage(victim:GetName(), _damage, Hit_Groups[1], _health) 

    local r, g, b, a = hitColor:GetValue()
    AddToNotify({r=r,g=g,b=b,a=a}, msg, notifyConsole:GetValue())
end

Event_Table["round_prestart"] = function(player_death)
    ClearCache()
end

local function handleEvents(event)
    local_player = entities.GetLocalPlayer()
    if event then
        local event_name = event:GetName()
        if Event_Table[event_name] then
            Event_Table[event_name](event);
        end
    end
end

--[[
    CreateMove
]]
local function CompileShot(predicted_shot)
    if string.find(Cache.weapon_name, "knife") then return end
    if IsGrenade(Cache.weapon_name) then return end

    local shot_type = Cache.mouse_pressed and "manual" or "aimbot"
    local spread_amt = CalculateSpread(predicted_shot.ang, predicted_shot.pos, Cache.bullet_impact[#Cache.bullet_impact])

    if not predicted_shot.target and #Cache.player_hurt > 0 then
        predicted_shot.target = entities.GetByIndex( Cache.player_hurt[1].index )
    end

    local shot = {
        type = shot_type,
        target = predicted_shot.target,
        weapon = Cache.weapon_name,
        ang = predicted_shot.ang,
        pos = predicted_shot.pos,
        impacts = Cache.bullet_impact,
        hurts = Cache.player_hurt,
        tick = globals.TickCount(),
        spread = string.format("%.3f", spread_amt)
    }
    
    return shot
end

local function HandleViewAngles(cmd)
    Cache.mouse_pressed = input.IsButtonDown( 1 )

    local ping_in_seconds = entities.GetPlayerResources():GetPropInt("m_iPing", local_player:GetIndex()) / 1000
    local ping_in_ticks = math.ceil(ping_in_seconds / globals.TickInterval())
    local longest_lifetime = sv_maxusrcmdprocessticks:GetValue() + (ping_in_ticks * 2)

    -- remove old angles
    local i = 1 
    while i <= 2 do
        if Cache.view_angles[i] and globals.TickCount() - Cache.view_angles[i].tick >= longest_lifetime then
            Cache.view_angles[i] = nil
        end

        i = i + 1
    end

    -- In attack check for getting shot angles
    if bit.band(cmd.buttons, bit.lshift(1,0)) == bit.lshift(1,0) then
        local shot_pos = local_player:GetAbsOrigin() + local_player:GetPropVector("localdata", "m_vecViewOffset[0]")
        local recoil = local_player:GetPropVector("localdata", "m_Local", "m_aimPunchAngle") * 2
        local shot_angle =  cmd.viewangles

        -- account for recoil
        shot_angle.x = shot_angle.x + recoil.x
        shot_angle.y = shot_angle.y + recoil.y

        -- my best attempt at filtering the correct shot angles and positions
        -- actually works very well
        -- gets first and very last IN_ATTACK tick
        if Cache.view_angles[1] == nil then
            Cache.view_angles[1] = {ang = shot_angle, pos = shot_pos, tick = globals.TickCount(), target = Cache.current_target}
        else
            Cache.view_angles[2] = {ang = shot_angle, pos = shot_pos, tick = globals.TickCount(), target = Cache.current_target}
        end
    end
end
--[[
    Shot stuff
]]
callbacks.Register("Draw", function()
    -- match angles to shots
    if Cache.weapon_name ~= "" then
        -- basic logic for deciding which angle to choose
        local shot_data = Cache.view_angles[1]
        Cache.view_angles[1] = nil

        if shot_data == nil then
            shot_data = Cache.view_angles[2]
            Cache.view_angles[2] = nil
        end

        -- the actual function of the script
        if shot_data then
            local shot = CompileShot(shot_data)
            
            if shot then
                DisplayShot(shot)
            end
            -- clear cache shit
            ClearCache()
        end
    end
end)

--[[
    Target Stuff (BUGGY AS FUCK)
]]
local function UpdateTarget(entity)
    if entity:GetName() then
        Cache.current_target = entity
    else
        Cache.current_target = nil
    end
end
--[[
    Boring Shit
]]
callbacks.Register( "CreateMove", HandleViewAngles)

callbacks.Register( "AimbotTarget", UpdateTarget)

callbacks.Register( "Draw", UpdateNotify)
callbacks.Register( "Draw", DrawNotify)

callbacks.Register( "FireGameEvent", handleEvents)

for k, v in pairs(Event_Table) do
    client.AllowListener(k)
end








--***********************************************--

print("♥♥♥ " .. GetScriptName() .. " loaded without Errors ♥♥♥")

